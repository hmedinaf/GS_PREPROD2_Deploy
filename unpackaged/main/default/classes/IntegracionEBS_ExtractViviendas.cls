/**
 * @description       : 
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-07-03
 * @last modified by  : Jose V. Aguilar Tlaseca
**/

public class IntegracionEBS_ExtractViviendas implements Schedulable
{
    private static Boolean isSandbox;
    private static Parametros_Integracion_EBS__mdt mdt;

    public void execute(SchedulableContext sc)
    {
        EBSExtraerViviendas();
    }

    @future (callout=true)
    public static void EBSExtraerViviendas()
    {
        Map<String, Prototipo__c> mapaPrototipos = new Map<String, Prototipo__c>();

        for (Prototipo__c p : [SELECT Id, prototipo_pro__c FROM Prototipo__c WHERE Activo_Pro__c = TRUE])
        {
            mapaPrototipos.put(p.Prototipo_pro__c, p);
        }

        isSandbox = [SELECT IsSandbox, Id FROM Organization].IsSandbox;

        if(isSandbox)
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Sandbox');
        else
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Produccion');

        ExtractViviendasRequest ebsReq = new ExtractViviendasRequest();

        ebsReq.Dias = Integer.valueOf(mdt.Viviendas_Dias__c);

        String strStatus = mdt.Viviendas_Estatus__c;
        strStatus = strStatus.deleteWhitespace();
        List<Integer> lstEstatuses = new List<Integer>();
        
        for(String s : strStatus.split(','))
        {
            Integer i = Integer.valueOf(s);
            lstEstatuses.add(i);
        }

        ebsReq.Estatus = lstEstatuses;
        ebsReq.IdVivienda = Integer.valueOf(mdt.Viviendas_Id_Vivienda__c);

        String body = JSON.serialize(ebsReq);

        System.debug('EBSRequest viviendas:: ' + body);

        String esbURL = mdt.URL_base__c + '' + mdt.Servicio_Extraer_Viviendas__c;

        HttpRequest req = new HttpRequest();
        req.setEndpoint(esbURL);
        req.setMethod('POST');
        req.setBody(body);
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(120000);
        Http http = new Http();
        HttpResponse res = new HTTPResponse();

        String errorNoControlado = '';

        if (!Test.isRunningTest()) {
            try {
                res = http.send(req);    
            } catch (Exception e) {
                errorNoControlado = e.getMessage();
            }
        } else {
            System.debug(body);
        }

        List<Vivienda__c> viviendas = new List<Vivienda__c>();

        Database.UpsertResult[] resultadosViviendas;
        Schema.SObjectField idExternoVivienda = Vivienda__c.Fields.Id_Vivienda__c;

        List<Error_Integracion_EBS__c> erroresIntegracion = new List<Error_Integracion_EBS__c>();
        erroresIntegracion = [SELECT Id FROM Error_Integracion_EBS__c WHERE Servicio__c = 'Viviendas' LIMIT 20000];

        if(erroresIntegracion.size() > 0)
            delete erroresIntegracion;
            
        erroresIntegracion = new List<Error_Integracion_EBS__c>();

        if(String.isBlank(errorNoControlado))
        {
            System.debug('EBSResponse viviendas:: ' + res.getBody());
            String respBody = res.getBody();
            respBody = respBody.replaceAll('@', '');
            System.debug('Body sin arrobas viviendas: ' + respBody);

            ExtractViviendasResponse ebsRes = new ExtractViviendasResponse();
            ebsRes = (ExtractViviendasResponse) JSON.deserialize(respBody, ExtractViviendasResponse.CLASS);
            System.debug('EBSResponse viviendas deserializado:: ' + ebsRes);

            if(res.getStatusCode() == 200)
            {
                if(ebsRes.Success)
                {
                    System.debug('Respuesta success TRUE: ' + ebsRes);

                    //Se recorren las viviendas para buscar prototipos que no existan
                    for(Viviendas v : ebsRes.Viviendas)
                    {
                        Fraccionamiento__c f = new Fraccionamiento__c
                        (
                            Id_Fraccionamiento__c = String.valueOf(v.IdFraccionamiento)
                        );
                        
                        String llavePrototipo = v.Prototipos.Prototipo + ' - ' + v.Fraccionamientos.Fraccionamiento;
                        Prototipo__c p;

                        if(mapaPrototipos.containsKey(llavePrototipo))
                        {
                            p = mapaPrototipos.get(llavePrototipo);
                        }
                        else
                        {
                            p = new Prototipo__c
                            (
                                Name = v.Prototipos.Prototipo,
                                Id_Prototipo__c = String.valueOf(v.IdPrototipo),
                                Prototipo_pro__c = llavePrototipo,
                                Nombre_Prototipo__c = v.Prototipos.Prototipo,
                                Fraccionamiento__r = f
                            );

                            mapaPrototipos.put(llavePrototipo, p);

                            System.debug('Se creará un nuevo prototipo: ' + p);
                        }
                    }

                    upsert mapaPrototipos.values();


                    //Se recorren las viviendas para guardarlas en Salesforce
                    for(Viviendas v : ebsRes.Viviendas)
                    {
                        Fraccionamiento__c f = new Fraccionamiento__c
                        (
                            Id_Fraccionamiento__c = String.valueOf(v.IdFraccionamiento)
                        );
                        
                        String llavePrototipo = v.Prototipos.Prototipo + ' - ' + v.Fraccionamientos.Fraccionamiento;
                        
                        Vivienda__c nuevaVivienda = new Vivienda__c();

                        nuevaVivienda.Id_Vivienda__c = String.valueOf(v.IdVivienda);
                        nuevaVivienda.Fraccionamiento__r = f;
                        nuevaVivienda.Sector__c = String.valueOf(v.IdSector);
                        nuevaVivienda.Prototipo__c = mapaPrototipos.get(llavePrototipo).Id;
                        nuevaVivienda.Manzana__c = String.valueOf(v.Id_Manzana);
                        nuevaVivienda.Lote__c = String.valueOf(v.IdLote);
                        nuevaVivienda.Num_Interior__c = v.NumInterior;
                        nuevaVivienda.Num_Interno__c = v.NumInterno;
                        nuevaVivienda.Direccion__c = v.Direccion;
                        nuevaVivienda.Fecha_Ultimo_Avaluo__c = v.FechaUltimoAvaluo;
                        nuevaVivienda.Fecha_Vencimiento_Avaluo__c = v.VigenciaUltimoAvaluo;
                        nuevaVivienda.M2_Superficie__c = v.MetrosSuperficie;
                        nuevaVivienda.Tiene_DTU__c = v.BanDtu != null ? v.BanDtu : false;
                        nuevaVivienda.Casa_Muestra__c = v.BanMuestra != null ? v.BanMuestra : false;
                        nuevaVivienda.Estatus__c = String.valueOf(v.IdEstatusVivienda);
                        nuevaVivienda.Esquina__c = v.BanEsquina != null ? v.BanEsquina : false;
                        nuevaVivienda.Frente_Parque__c = v.BanFrenteParque != null ? v.BanFrenteParque : false;
                        nuevaVivienda.Sobre_Avenida__c = v.BanSobreAvenida != null ? v.BanSobreAvenida : false;
                        nuevaVivienda.Lado_Sol__c = v.BanLadoSol != null ? v.BanLadoSol : false;
                        nuevaVivienda.Lado_Sombra__c = v.BanLadoSombra != null ? v.BanLadoSombra : false;
                        nuevaVivienda.Excendente_M2__c = v.MetrosSuperficieExcedente;
                        nuevaVivienda.Piso__c = v.Piso;
                        nuevaVivienda.Check_Fideicomiso__c = v.Fideicomiso != null ? v.Fideicomiso : false;
                        nuevaVivienda.Estatus_Vivienda__c = v.EstatusConstruccion;
                        nuevaVivienda.Unidad_Privativa__c = String.valueOf(v.UnidadPrivativa);
                        nuevaVivienda.Fideicomiso__c = String.valueOf(v.IdFideicomiso);
                        nuevaVivienda.Tiene_DTI__c = v.BanDti != null ? v.BanDti : false;

                        nuevaVivienda.Precio_Unitario__c = 0.1;//agregado solo para prpbar si el error dejaba de ocurrir

                        viviendas.add(nuevaVivienda);
                    }

                    resultadosViviendas = Database.upsert(viviendas, idExternoVivienda, false);

                    System.debug('RESULTADOS CON ERROR: ' + resultadosViviendas.size());

                    Set <Id> setViv = new Set<Id>();
                    for (Database.UpsertResult ur : resultadosViviendas)
                    {
                        if (ur.isSuccess())
                        {
                            System.debug('Vivienda insertada/actualizada correctamente. ID Vivienda: ' + ur.getId());
                            setViv.add(ur.getId());
                        }
                        else
                        {
                            for(Database.Error err : ur.getErrors())
                            {
                                Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
                                e.Servicio__c = 'Viviendas';
                                e.Error__c = err.getMessage() + (err.getFields().size() > 0 ? '. Campos con error: ' + err.getFields() : '');
                                erroresIntegracion.add(e);

                                System.debug('Error al insertar/actualizar vivienda');                    
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('Error en el campo: ' + err.getFields());
                            }
                        }
                    }
                    // Crear productos de Viviendas creadas
                    if (setViv.size()>0) {
                        List <Product2> newProds = new List <Product2>();
                        for (Vivienda__c v : [SELECT Id, Id_Vivienda__c, Precio_Unitario__c FROM Vivienda__c WHERE Id in :setViv]) {
                            Product2 newProd = new Product2();
                            newProd.Name = v.Id_Vivienda__c;
                            newProd.Precio_Venta__c	= v.Precio_Unitario__c;
                            newProd.Description	= v.Id_Vivienda__c;
                            newProd.Vivienda__c	= v.Id;
                            newProd.Family = 'Vivienda';
                            newProd.Sin_Vigencia__c = true;
                            newProd.RecordTypeId = '0120r000000FRwrAAG';
                            newProd.Id_Externo__c = v.Id_Vivienda__c;
                            newProds.add(newProd);
                        }
                        if (newProds.size()>0) {
                            Schema.SObjectField idExternoProduct2 = Product2.Fields.Id_Externo__c;
                            Database.UpsertResult[] sr = Database.Upsert (newProds, idExternoProduct2, false);
                        }
                    }
                }
                else
                {
                    Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
                    e.Servicio__c = 'Viviendas';
                    e.Error__c = 'Error controlado: ' + ebsRes.SysMessage.Error;
                    erroresIntegracion.add(e);

                    System.debug('Invocacion al servicio ExtractViviendas fallida. Error controlado:: ' + ebsRes.SysMessage.Error);
                }
            }
            else
            {
                Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
                e.Servicio__c = 'Viviendas';
                e.Error__c = 'Codigo de error != 200: ' + res;
                erroresIntegracion.add(e);

                System.debug('Invocacion al servicio ExtractViviendas fallida. Status code != 200:: ' + res);
            }
        }
        else
        {
            Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
            e.Servicio__c = 'Viviendas';
            e.Error__c = 'Error no controlado: ' + res;
            erroresIntegracion.add(e);

            System.debug('Invocacion al servicio ExtractViviendas fallida. Error NO controlado:: ' + res);
        }

        if (erroresIntegracion.size() > 0)
            insert erroresIntegracion;
    }

    public class ExtractViviendasRequest
    {
        public Integer Dias;
        public List<Integer> Estatus;
        public Integer IdVivienda;
    }

    public class ExtractViviendasResponse
    {
        public String ESB_Id;
        public Integer ItemQuantity;
        public String ResponseDate;
        public Boolean Success;
        public SysMessage SysMessage;
        public List<Viviendas> Viviendas;
    }

    public class Fraccionamientos
    {
        public String Fraccionamiento;
    }
    
    public class EtapasFraccionamientos
    {
        public String EtapaFraccionamiento;
    }
    
    public class Prototipos
    {
        public String Prototipo;
    }
    
    public class EstatusViviendas
    {
        public String EstatusVivienda;
    }
    
    public class SysMessage
    {
        public Integer CodigoError;
        public String Error;
        public Boolean Exitoso;
        public Integer IdSolicitud;
    }
    
    public class Sectores
    {
        public String Sector;
    }
    
    public class Lotes
    {
        public String Lote;
    }
    
    public class Manzanas
    {
        public String Manzana;
    }
    
    public class Viviendas
    {
        public Integer AnioPrograma;
        public Integer AvanceObraFinan;
        public Integer AvanceObraFisico;
        public Boolean BanAreaMuni;
        public Boolean BanDti;
        public Boolean BanDtu;
        public Boolean BanEsquina;
        public Boolean BanFormalizaContado;
        public Boolean BanFrenteParque;
        public Boolean BanGravamen;
        public Boolean BanLadoSol;
        public Boolean BanLadoSombra;
        public Boolean BanMuestra;
        public Boolean BanPermisoConstruccion;
        public Boolean BanProvisional;
        public Boolean BanRoc;
        public Boolean BanSeguro;
        public Boolean BanSobreAvenida;
        public Boolean BanUnidadPrivativa;
        public Boolean BanVerde;
        public Boolean BanVistoBuenoJuridico;
        public Boolean Cablevision;
        public String Calle;
        public String ClaveUnicaVivienda;
        public String CodigoElemento;
        public String CodigoSeccion;
        public String Comentarios;
        public Integer ConstruccionLoteTipo;
        public Decimal CostoFinal;
        public String Direccion;
        public String Domicilio;
        public Boolean EnCrea;
        public Boolean Estatus;
        public String EstatusConstruccion;
        public EstatusViviendas EstatusViviendas;
        public EtapasFraccionamientos EtapasFraccionamientos;
        public Date FechaArranque;
        public Date FechaAvance;
        public Date FechaCancelada;
        public Datetime FechaCreacion;
        public Date FechaDti;
        public Date FechaDtu;
        public Date FechaEntregada;
        public Date FechaEscriturada;
        public Date FechaFormalizada;
        public Date FechaLiberacionGravamen;
        public Date FechaLista;
        public Datetime FechaModificacion;
        public Date FechaModificacionVerde;
        public Date FechaProyeccionDtu;
        public Date FechaSeparada;
        public Date FechaUltimoAvaluo;
        public Date FechaUltimoEstatus;
        public Date FechaUltimoEstatusVivienda;
        public Date FechaValidada;
        public Date FechaVigenciaDtu;
        public Date FechaVigenciaPredial;
        public Boolean Fideicomiso;
        public Boolean FlagCrm;
        public Fraccionamientos Fraccionamientos;
        public Integer IdAseguradora;
        public Integer IdEstatusVivienda;
        public Integer IdEtapaFraccionamiento;
        public Integer IdFideicomiso;
        public Integer IdFraccionamiento;
        public Integer IdLote;
        public Integer IdPaqueteInfonavit;
        public Integer IdPrototipo;
        public Integer IdSector;
        public Integer IdVivienda;
        public Integer Id_Manzana;
        public Boolean ImpuestoPredial;
        public Lotes Lotes;
        public Manzanas Manzanas;
        public Integer MaxIdVivFracc;
        public Decimal MetrosConstruccion;
        public Decimal MetrosSuperficie;
        public Decimal MetrosSuperficieExcedente;
        public Decimal MontoBonificacion;
        public Decimal MontoConvenio;
        public Decimal MontoIncobrable;
        public Decimal MontoUltimoAvaluo;
        public String MotivoBaja;
        public String NumInterior;
        public String NumInterno;
        public String NumeroCatastro;
        public String NumeroOficial;
        public Integer Piso;
        public String PolizaSeguro;
        public Decimal PorcPartConjunto;
        public Prototipos Prototipos;
        public String Reclamos;
        public String Regimen;
        public String ResidenteEdificacion;
        public Integer Ruv;
        public Sectores Sectores;
        public Double SuperficieLoteTipo;
        public Integer Supervision;
        public Integer UnidadPrivativa;
        public String UsuarioCreacion;
        public String UsuarioModificacion;
        public String UsuarioUltimoEstatus;
        public Date VigenciaUltimoAvaluo;
    }
}