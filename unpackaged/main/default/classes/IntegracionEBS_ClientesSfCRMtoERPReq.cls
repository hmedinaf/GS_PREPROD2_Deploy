/**
 * @description       : 
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-07-27
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
public with sharing class IntegracionEBS_ClientesSfCRMtoERPReq
{
    
    private static Boolean isSandbox;
    private static Parametros_Integracion_EBS__mdt mdt;

    public class IntegracionEBSCallable
    {
      @InvocableVariable(label='ID registro Integracion EBS Clientes' required=true)
      public String iEbsId;
    }

    @InvocableMethod(label='Integraciones EBS: Enviar Proceso de Venta' description='Enviar Proceso de Venta a EBS' category='Callout') 
    public static void EBSEnviarProcesoDeVenta(List<IntegracionEBSCallable> integracionEBS)
    {
        isSandbox = [SELECT IsSandbox, Id FROM Organization].IsSandbox;

        if(isSandbox)
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Sandbox');
        else
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Produccion');

        for (IntegracionEBSCallable p : integracionEBS)
        {
            Integracion_EBS_Clientes__c iEbs =
            [
                SELECT
                    Id
                    ,Name
                    ,Apellido_Materno__c
                    ,Apellido_Paterno__c
                    ,Calle__c
                    ,Ciudad__c
                    ,Colonia__c
                    ,CreatedDate
                    ,CreatedById
                    ,CreatedBy.Name
                    ,CURP__c
                    ,Codigo_Postal__c
                    ,Domicilio_Oficial__c
                    ,Edad__c
                    ,Estado__c
                    ,Estatus_Integracion__c
                    ,Fecha_Escrituracion__c
                    ,Fecha_Formalizacion__c
                    ,Fecha_Nacimiento__c
                    ,Fideicomiso__c
                    ,Fraccionamiento__c
                    ,Id_Cliente_AR__c
                    ,Id_Cliente_CRM__c
                    ,Id_Interfase__c
                    ,Id_Interface_AutoNo__c
                    ,Id_Interfase_CRM__c
                    ,Id_Pago__c
                    ,Id_Proceso_AR__c
                    ,Ind_Exigible__c
                    ,Interior__c
                    ,Lote__c
                    ,Lugar_Nacimiento__c
                    ,Manzana__c
                    ,Mensaje_API__c
                    ,Metros_Terreno_Excedente__c
                    ,Nacionalidad__c
                    ,Nombre__c
                    ,Nombre_Cliente__c
                    ,Nombre_Referencia_1__c
                    ,Nombre_Referencia_2__c
                    ,Nombre_Referencia_3__c
                    ,NSS__c
                    ,Num_Proceso_AR__c
                    ,Numero_Domicilio__c
                    ,Numero_Interno__c
                    ,Pais__c
                    ,Proceso_de_Venta__c
                    ,Proceso_de_Venta__r.Name
                    ,Prototipo__c
                    ,Referencia_Bancaria__c
                    ,Requisicion_CRM__c
                    ,Respuesta_API__c
                    ,RFC__c
                    ,Row_Id__c
                    ,Sexo__c
                    ,Telefono_Celular__c
                    ,Telefono_Particular__c
                    ,Telefono_Ref_Otro_1__c
                    ,Telefono_Ref_Otro_2__c
                    ,Telefono_Ref_Otro_3__c
                    ,Telefono_Referencia_1__c
                    ,Telefono_Referencia_2__c
                    ,Telefono_Referencia_3__c
                    ,Tipo_Credito__c
                    ,Tipo_Lote__c
                    ,UEN__c
                    ,LastModifiedDate
                    ,LastModifiedById
                    ,LastModifiedBy.Name
                FROM Integracion_EBS_Clientes__c WHERE ID = :p.iEbsId
            ];

            InsClientesSfCRMtoERP ebsData = new InsClientesSfCRMtoERP();
            EBSRequest ebsReq = new EBSRequest();

            String ebsID = iEbs.Id;
            ebsID = ebsID.substring(1,15);

            ebsData.ApellidoMaterno = iEbs.Apellido_Materno__c;
            ebsData.ApellidoPaterno = iEbs.Apellido_Paterno__c;
            ebsData.Calle = iEbs.Calle__c;
            ebsData.Ciudad = iEbs.Ciudad__c;
            ebsData.CodigoPosta = iEbs.Codigo_Postal__c!=null ? Integer.valueOf(iEbs.Codigo_Postal__c) : null;
            ebsData.Colonia = iEbs.Colonia__c;
            ebsData.Created = formatFecha(iEbs.CreatedDate); //Date.valueOf(iEbs.CreatedDate);
            ebsData.CreatedBy = iEbs.CreatedBy.Name;
            ebsData.Curp = iEbs.CURP__c;
            ebsData.DbLastUpd = null;
            ebsData.DbLastUpdSrc = null;
            ebsData.DomicilioOficial = iEbs.Domicilio_Oficial__c;
            ebsData.EDAD = iEbs.Edad__c;
            ebsData.Estado = iEbs.Estado__c;
            ebsData.FechaEscrituracion = formatFecha(iEbs.Fecha_Escrituracion__c); //String.valueOf(iEbs.Fecha_Escrituracion__c);
            ebsData.FechaFormalizacion = formatFecha(iEbs.Fecha_Formalizacion__c); //String.valueOf(iEbs.Fecha_Formalizacion__c);
            ebsData.FechaNacimiento = formatFecha(iEbs.Fecha_Nacimiento__c); //String.valueOf(iEbs.Fecha_Nacimiento__c);
            ebsData.Fideicomiso = iEbs.Fideicomiso__c;
            ebsData.Fraccionamiento = iEbs.Fraccionamiento__c;
            ebsData.IdPago = iEbs.Id_Pago__c;
            ebsData.IndExigible = iEbs.Ind_Exigible__c!=null ? Integer.valueOf(iEbs.Ind_Exigible__c) : null;
            ebsData.Interior = iEbs.Interior__c;
            ebsData.LastUpd = formatFecha(iEbs.LastModifiedDate); //Date.valueOf(iEbs.LastModifiedDate);
            ebsData.LastUpdBy = iEbs.LastModifiedBy.Name;
            ebsData.Lote = iEbs.Lote__c;
            ebsData.LugarNacimiento = iEbs.Lugar_Nacimiento__c;
            ebsData.Manzana = iEbs.Manzana__c;
            ebsData.MetrosTerrenoExcedente = iEbs.Metros_Terreno_Excedente__c;
            ebsData.Nacionalidad = iEbs.Nacionalidad__c;
            ebsData.Nombre = iEbs.Nombre__c;
            ebsData.NombreReferencia1 = iEbs.Nombre_Referencia_1__c;
            ebsData.NombreReferencia2 = iEbs.Nombre_Referencia_2__c;
            ebsData.NombreReferencia3 = iEbs.Nombre_Referencia_3__c;
            ebsData.Nombre_Cliente = iEbs.Nombre_Cliente__c;
            ebsData.Nss = iEbs.NSS__c;
            ebsData.NumeroDomicilio = iEbs.Numero_Domicilio__c;
            ebsData.NumeroInterno = iEbs.Numero_Interno__c;
            ebsData.Pais = iEbs.Pais__c;
            ebsData.Prototipo = iEbs.Prototipo__c;
            ebsData.ReferenciaBancaria = iEbs.Referencia_Bancaria__c;
            ebsData.Rfc = iEbs.RFC__c;
            ebsData.Sexo = iEbs.Sexo__c;
            ebsData.TelefonoCelular = iEbs.Telefono_Celular__c;
            ebsData.TelefonoParticular = iEbs.Telefono_Particular__c;
            ebsData.TelefonoRefOtro1 = iEbs.Telefono_Ref_Otro_1__c;
            ebsData.TelefonoRefOtro2 = iEbs.Telefono_Ref_Otro_2__c;
            ebsData.TelefonoRefOtro3 = iEbs.Telefono_Ref_Otro_3__c;
            ebsData.TelefonoReferencia1 = iEbs.Telefono_Referencia_1__c;
            ebsData.TelefonoReferencia2 = iEbs.Telefono_Referencia_2__c;
            ebsData.TelefonoReferencia3 = iEbs.Telefono_Referencia_3__c;
            ebsData.TipoCredito = iEbs.Tipo_Credito__c;
            ebsData.TipoLote = iEbs.Tipo_Lote__c;
            ebsData.Uen = iEbs.UEN__c;

            ebsData.IdInterfase = Integer.valueOf(iEbs.Id_Interface_AutoNo__c);
            ebsData.IdClienteCrm = iEbs.Id_Cliente_CRM__c;
            ebsData.IdInterfaseCrm = iEbs.Id;//iEbs.Id_Interfase_CRM__c;

            ebsData.RequisicionCrm = iEbs.Requisicion_CRM__c;
            system.debug('*** *** Requisicion_CRM__c: '+iEbs.Requisicion_CRM__c);
            ebsData.IdClienteAr = iEbs.Id_Cliente_AR__c;
            ebsData.NumProcesoAr = iEbs.Num_Proceso_AR__c;
            ebsData.IdProcesoAr = iEbs.Id_Proceso_AR__c;
            ebsData.RespuestaApi = '0'; //iEbs.Respuesta_API__c;
            //ebsData.MensajeApi = iEbs.Mensaje_API__c;
            ebsData.RowId = ebsID;

            ebsReq.InsClientesSfCRMtoERP = ebsData;

            String body = JSON.serialize(ebsReq);

            System.debug('EBSRequest: ' + body);

            String esbURL = mdt.URL_base__c + '' + mdt.Servicio_Clientes__c;

            System.enqueueJob(new QueueableIntegracionEBSCall(esbURL, 'POST', body, iEbs.Id));
        }
    }


    public class EBSRequest {
        //public String @Version;
        //public String @RequestDate;
        //public String @SourceSystem;
        //public String @TransactionID;
        public InsClientesSfCRMtoERP InsClientesSfCRMtoERP;
    }

    public class InsClientesSfCRMtoERP {
        public String ApellidoMaterno;
        public String ApellidoPaterno;
        public String Calle;
        public String Ciudad;
        public Decimal CodigoPosta;
        public String Colonia;
        public String Created;
        public String CreatedBy;
        public String Curp;
        public Date DbLastUpd;
        public String DbLastUpdSrc;
        public String DomicilioOficial;
        public String EDAD;
        public String Estado;
        public String FechaEscrituracion;
        public String FechaFormalizacion;
        public String FechaNacimiento;
        public String Fideicomiso;
        public String Fraccionamiento;
        public String IdClienteAr;
        public String IdClienteCrm;
        public Integer IdInterfase;
        public String IdInterfaseCrm;
        public String IdPago;
        public String IdProcesoAr;
        public Integer IndExigible;
        public String Interior;
        public String LastUpd;
        public String LastUpdBy;
        public String Lote;
        public String LugarNacimiento;
        public String Manzana;
        public String MensajeApi;
        public Double MetrosTerrenoExcedente;
        public String Nacionalidad;
        public String Nombre;
        public String NombreReferencia1;
        public String NombreReferencia2;
        public String NombreReferencia3;
        public String Nombre_Cliente;
        public String Nss;
        public String NumProcesoAr;
        public String NumeroDomicilio;
        public String NumeroInterno;
        public String Pais;
        public String Prototipo;
        public String ReferenciaBancaria;
        public String RequisicionCrm;
        public String RespuestaApi;
        public String Rfc;
        public String RowId;
        public String Sexo;
        public String TelefonoCelular;
        public String TelefonoParticular;
        public String TelefonoRefOtro1;
        public String TelefonoRefOtro2;
        public String TelefonoRefOtro3;
        public String TelefonoReferencia1;
        public String TelefonoReferencia2;
        public String TelefonoReferencia3;
        public String TipoCredito;
        public String TipoLote;
        public String Uen;
    }


    public class EBSResponse {

        public String ResponseDate;
        public Boolean Success;
        public String ESB_Id;
        public String NombreCompleto;
        public String Departamento;
        public String Oficina;
        public String Estado;
        public ClientesSfCRMtoERP ClientesSfCRMtoERP;        
    }

    public class ClientesSfCRMtoERP {
        public ClientesSfCRMtoERPResponse ClientesSfCRMtoERPResponse;
    }

    public class ClientesSfCRMtoERPResponse {
        public String MensajeApi;
        public String RespuestaApi;
        public String RequisicionCRM;
        public String IdClienteAr;
        public String IdProcesoAr;
    }


    public class QueueableIntegracionEBSCall implements System.Queueable, Database.AllowsCallouts {

        private final String url;
        private final String method;
        private final String body;
        private final String recordId;
  
        public QueueableIntegracionEBSCall(String url, String method, String body, String recordId) {
            this.url = url;
            this.method = method;
            this.body = body;
            this.recordId = recordId;
        }
  
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method);
            req.setBody(body);
            req.setHeader('Accept', 'application/json');
			req.setHeader('Content-Type', 'application/json');
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

            System.debug('errorNoControlado:: ' + errorNoControlado);

            Integracion_EBS_Clientes__c integracionEBS = [SELECT Id FROM Integracion_EBS_Clientes__c WHERE ID = :recordId];

            if(String.isBlank(errorNoControlado))
            {
                System.debug('EBSResponse: ' + res.getBody());
                String respBody = res.getBody();
                respBody = respBody.replaceAll('@', '');
                System.debug('Body sin arrobas: ' + respBody);

                EBSResponse ebsRes = new EBSResponse();
                ebsRes = (EBSResponse) JSON.deserialize(respBody, EBSResponse.CLASS);
                System.debug('EBSResponse deserializado: ' + ebsRes);

                if(res.getStatusCode() == 200)
                {
                    if(ebsRes.Success)
                    {
                        integracionEBS.Estatus_Integracion__c = 'Enviado';
                        integracionEBS.Request_CRM_hacia_EBS__c = body;
                        integracionEBS.Response_CRM_hacia_EBS__c = respBody;
                        integracionEBS.Respuesta_API__c = ebsRes.ClientesSfCRMtoERP.ClientesSfCRMtoERPResponse.RespuestaApi;
                        //integracionEBS.Id_Cliente_AR__c = ebsRes.ESB_Id;
                        //integracionEBS.Id_Cliente_AR__c = ebsRes.ESB_Id;
                        update integracionEBS;
                    }
                    else
                    {
                        integracionEBS.Estatus_Integracion__c = 'Error';
                        integracionEBS.Respuesta_API__c = ebsRes.ClientesSfCRMtoERP.ClientesSfCRMtoERPResponse.MensajeApi;
                        integracionEBS.Request_CRM_hacia_EBS__c = body;
                        integracionEBS.Response_CRM_hacia_EBS__c = respBody;
                        update integracionEBS;
                    }
                }
                else
                {
                    integracionEBS.Estatus_Integracion__c = 'Error';
                    integracionEBS.Respuesta_API__c = res.getBody();
                    integracionEBS.Request_CRM_hacia_EBS__c = body;
                    integracionEBS.Response_CRM_hacia_EBS__c = respBody;
                    update integracionEBS;
                }
            }
            else
            {
                integracionEBS.Estatus_Integracion__c = 'Error';
                integracionEBS.Respuesta_API__c = errorNoControlado;
                integracionEBS.Request_CRM_hacia_EBS__c = body;
                update integracionEBS;
            }
        }
    }

    public static String formatFecha (Date fecha) {
        if (fecha != null) {
            Datetime tmpDateTime = Datetime.newInstance(fecha.year(), fecha.month(), fecha.day());
            return (tmpDateTime.format('yyyy-MM-dd'));
        } else {
            return null;
        }
    }

    public static String formatFecha (Datetime fecha) {
        if (fecha != null) {
            // return (fecha.format('dd/MM/yyyy'));
            return (fecha.format('yyyy-MM-dd'));
        } else {
            return null;
        }
    }
}