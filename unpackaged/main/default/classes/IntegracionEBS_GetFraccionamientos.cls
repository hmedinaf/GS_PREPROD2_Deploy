/**
 * @description       : 
 * @author            : Jose fracc. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-07-03
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
public class IntegracionEBS_GetFraccionamientos implements Schedulable
{
    private static Boolean isSandbox;
    private static Parametros_Integracion_EBS__mdt mdt;

    public void execute(SchedulableContext sc)
    {
        EBSGetFraccionamientos();
    }

    @future (callout=true)
    public static void EBSGetFraccionamientos()
    {
        isSandbox = [SELECT IsSandbox, Id FROM Organization].IsSandbox;

        if(isSandbox) 
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Sandbox');
        else
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Produccion');

        GetFraccionamientosRequest ebsReq = new GetFraccionamientosRequest();

        ebsReq.Dias = Integer.valueOf(mdt.Fraccionamientos_Dias__c);

        ebsReq.IdFraccionamiento = Integer.valueOf(mdt.Fraccionamientos_Id_Fraccionamiento__c);

        String body = JSON.serialize(ebsReq);

        System.debug('EBSRequest Fraccionamientos:: ' + body);

        String esbURL = mdt.URL_base__c + '' + mdt.Servicio_Obtener_Fraccionamientos__c;

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
                system.debug('*** ErrorNoControlado: '+errorNoControlado);
            }
        } else {
            System.debug('***body: ' + body);
        }

        List<Fraccionamiento__c> fraccionamientos = new List<Fraccionamiento__c>();
        Database.UpsertResult[] resultadosFraccionamientos;
        Schema.SObjectField idExternoFraccionamiento = Fraccionamiento__c.Fields.Id_Fraccionamiento__c;
        //Schema.SObjectField idExternoFraccionamiento = Fraccionamiento__c.Fields.Codigo_Fraccionamiento__c;

        List<Error_Integracion_EBS__c> erroresIntegracion = new List<Error_Integracion_EBS__c>();
        erroresIntegracion = [SELECT Id FROM Error_Integracion_EBS__c WHERE Servicio__c = 'Fraccionamientos' LIMIT 20000];

        if(erroresIntegracion.size() > 0)
            delete erroresIntegracion;

        erroresIntegracion = new List<Error_Integracion_EBS__c>();

        if(String.isBlank(errorNoControlado))
        {
            System.debug('EBSResponse fraccionamientos:: ' + res.getBody());
            String respBody = res.getBody();
            respBody = respBody.replace('@ResponseDate', 'ResponseDate');
            respBody = respBody.replace('@Success', 'Success');
            respBody = respBody.replace('@ESB_Id', 'ESB_Id');
            respBody = respBody.replace('@ItemQuantity', 'ItemQuantity');
            System.debug('Body sin arrobas fraccionamientos: ' + respBody);

            GetFraccionamientosResponse ebsRes = new GetFraccionamientosResponse();
            ebsRes = (GetFraccionamientosResponse) JSON.deserialize(respBody, GetFraccionamientosResponse.CLASS);
            System.debug('EBSResponse fraccionamientos deserializado:: ' + ebsRes);

            if(res.getStatusCode() == 200)
            {
                if(ebsRes.Success)
                {
                    System.debug('Respuesta success TRUE: ' + ebsRes);

                    for(Fraccionamientos fracc : ebsRes.Fraccionamientos)
                    {
                        Fraccionamiento__c nuevoFraccionamiento = new Fraccionamiento__c();

                        nuevoFraccionamiento.Id_Fraccionamiento__c = String.valueOf(fracc.IdFraccionamiento);
                        //nuevoFraccionamiento.Id_Fraccionamiento__c = String.valueOf(fracc.NombreComercial);
                        nuevoFraccionamiento.Codigo_Fraccionamiento__c = String.valueOf(fracc.CodigoFracc);
                        nuevoFraccionamiento.Name = fracc.NombreComercial;
                        nuevoFraccionamiento.Muni_fracc__c = fracc.Municipio;
                        nuevoFraccionamiento.Estado_fracc__c = fracc.Estado;
                        nuevoFraccionamiento.Compania_Nombre__c = fracc.Companias.Compania;
                        nuevoFraccionamiento.Ubic_fracc__c = fracc.Ubicacion;
                        nuevoFraccionamiento.UEN__c = fracc.Uens.Uen;
                        nuevoFraccionamiento.Codigo_Fraccionamiento__c = fracc.CodigoFracc;
                        nuevoFraccionamiento.Activo_frac__c = fracc.Activo == True ? True : False;

                        String estadoTmp = '';
                        if(fracc.Estado == 'Nuevo Leon')
                            estadoTmp = 'Nuevo León';
                        else if(fracc.Estado == 'Queretaro')
                            estadoTmp = 'Querétaro';
                        else if(fracc.Estado == 'Estado de Mexico')
                            estadoTmp = 'Estado de México';
                        else
                            estadoTmp = fracc.Estado;

                        //nuevoFraccionamiento.Estado_fracc__c = fracc.Estado;
                        nuevoFraccionamiento.Estado_fracc__c = estadoTmp;
                        
                        fraccionamientos.add(nuevoFraccionamiento);
                    }

                    resultadosFraccionamientos = Database.upsert(fraccionamientos, idExternoFraccionamiento, false);

                    System.debug('RESULTADOS CON ERROR: ' + resultadosFraccionamientos.size());

                    for (Database.UpsertResult ur : resultadosFraccionamientos)
                    {
                        if (ur.isSuccess())
                        {
                            System.debug('Fraccionamiento insertado/actualizado correctamente. ID Fraccionamiento: ' + ur.getId());
                        }
                        else
                        {
                            for(Database.Error err : ur.getErrors())
                            {
                                Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
                                e.Servicio__c = 'Fraccionamientos';
                                e.Error__c = err.getMessage() + (err.getFields().size() > 0 ? '. Campos con error: ' + err.getFields() : '');
                                erroresIntegracion.add(e);

                                System.debug('Error al insertar/actualizar Fraccionamiento');                    
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('Error en el campo: ' + err.getFields());
                            }
                        }
                    }
                }
                else
                {
                    Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
                    e.Servicio__c = 'Fraccionamientos';
                    e.Error__c = 'Error controlado: ' + ebsRes.SysMessage.Error;
                    erroresIntegracion.add(e);

                    System.debug('Invocacion al servicio GetFraccionamientos fallida. Error controlado:: ' + ebsRes.SysMessage.Error);
                }
            }
            else
            {
                Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
                e.Servicio__c = 'Fraccionamientos';
                e.Error__c = 'Codigo de error != 200: ' + res;
                erroresIntegracion.add(e);

                System.debug('Invocacion al servicio GetFraccionamientos fallida. Status code != 200:: ' + res);
            }
        }
        else
        {
            Error_Integracion_EBS__c e = new Error_Integracion_EBS__c();
            e.Servicio__c = 'Fraccionamientos';
            e.Error__c = 'Error no controlado: ' + res;
            erroresIntegracion.add(e);

            System.debug('Invocacion al servicio GetFraccionamientos fallida. Error NO controlado:: ' + res);
        }

        if (erroresIntegracion.size() > 0)
            insert erroresIntegracion;
    }

    public class GetFraccionamientosRequest
    {
        public Integer Dias;
        public Integer IdFraccionamiento;
    }

    public class GetFraccionamientosResponse
    {
        public String ResponseDate;
        public Boolean Success;
        public String ESB_Id;
        public Integer ItemQuantity;
        public SysMessage SysMessage;
        public List<Fraccionamientos> Fraccionamientos;
    }

    public class SysMessage
    {
        public Integer IdSolicitud;
        public Boolean Exitoso;
        public Integer CodigoError;
        public String Error;
    }

    public class Companias
    {
        public String IdCompania;
        public String Compania;
    }

    public class Uens
    {
        public Integer IdUen;
        public String Uen;
    }

    public class DireccionesRegionales
    {
        public String DireccionRegional;
    }

    public class Fraccionamientos
    {
        public Integer IdFraccionamiento;
        public String NombreInicial;
        public String NombreComercial;
        public String AbreviaturaNomEtapas;
        public String AbreviaturaNumInternos;
        public String SegmentoProyecto;
        public Integer IdTipoVivienda;
        public Integer IdSubtipoVivienda;
        public Integer CantidadLotesTipo;
        public Integer CantidadLotes;
        public Integer CantidadViviendas;
        public String FechaEspConstruccion;
        public String FechaInicioProyecto;
        public Integer IdMunicipio;
        public String Municipio;
        public Integer IdEstado;
        public String Estado;
        public Companias Companias;
        public String Ubicacion;
        public Decimal SuperficieTotal;
        public Decimal SuperficieUtilizable;
        public Decimal SuperficieEdificable;
        public Decimal SuperficieAreasVerdes;
        public Decimal SuperficieVendible;
        public Integer IdSucursalCobranza;
        public Integer IdSucursalFormalizacion;
        public Integer IdSucursalTitula;
        public Integer IdSucursalInfraestructura;
        public Integer IdSucursalUrbaniza;
        public Integer IdSucursalEquipamiento;
        public Integer IdSucursalEdifica;
        public Integer IdSucursalEntrega;
        public String Proyecto;
        public Integer IdEtapaContructFracc;
        public Integer IdEstatusFraccionamiento;
        public Integer DiasProspectoSepare;
        public Integer DiasProspectoFormalice;
        public Integer Estatus;
        public String UsuarioModificacion;
        public String UsuarioCreacion;
        public String FechaModificacion;
        public String FechaCreacion;
        public Integer IdDireccionPago;
        public Integer IdDireccionRegional;
        public DireccionesRegionales DireccionesRegionales;
        public Uens Uens;
        public String SegmentoUen;
        public Integer EstatusBit;
        public Integer DiasRegAfluencia;
        public String CodigoFracc;
        public Integer IdTerreno;
        public Integer IdTipoFraccionamiento;
        public Integer ActivoVenta;
        public Integer CodigoPostal;
        public Boolean Activo;
        public Boolean BanFideicomiso;
        public Integer IdFideicomiso;
        public Boolean BanCreditoPuente;
    }
}