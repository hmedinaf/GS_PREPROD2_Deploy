public with sharing class IntegracionEBS_PagoSfCRMtoERPReq 
{
    private static Boolean isSandbox;
    private static Parametros_Integracion_EBS__mdt mdt;

    public class IntegracionEBSCallable
    {
        @InvocableVariable(label='ID registro Integracion EBS Pago' required=true)
        public String iEbsId;
    }

    @InvocableMethod(label='Integraciones EBS: Enviar Pago' description='Enviar Pago a EBS' category='Callout') 
    public static void EBSEnviarPago(List<IntegracionEBSCallable> integracionEBS)
    {
        isSandbox = [SELECT IsSandbox, Id FROM Organization].IsSandbox;

        if(isSandbox)
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Sandbox');
        else
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Produccion');

        for (IntegracionEBSCallable p : integracionEBS)
        {
            Integracion_EBS_Pagos__c iEbs =
            [
                SELECT
                    Id,
                    Name,
                    ConflictId__c,
                    CreatedById,
                    CreatedDate,
                    Created__c,
                    CreatedBy.Name,
                    DbLastUpd__c,
                    DescTipoDocto__c,
                    FechaContable__c,
                    FechaDeposito__c,
                    FechaRecibo__c,
                    IdClienteAr__c,
                    IdCobranzaMultiple__c,
                    Id_Interface_AutoNo__c,
                    IdEstadoVenta__c,
                    IdInterfaceCrm__c,
                    IdInterface__c,
                    IdMoneda__c,
                    IdProcesoAr__c,
                    IdReciboAr__c,
                    IdReciboCrm__c,
                    IdReestructura__c,
                    IdSector__c,
                    IdTipoDocto__c,
                    ImporteRecibo__c,
                    IndAnticipo__c,
                    IndReversa__c,
                    LastModifiedById,
                    LastModifiedDate,
                    LastModifiedBy.Name,
                    Metodo__c,
                    ModifecationNum__c,
                    NumRecibo__c,
                    OwnerId,
                    Referencia__c,
                    Requisicion__c,
                    RetryCount__c,
                    RowId__c,
                    SesionCajaId__c,
                    TipoPago__c
                FROM Integracion_EBS_Pagos__c WHERE ID = :p.iEbsId
            ];

            InsPagoSfCRMtoERP ebsData = new InsPagoSfCRMtoERP();
            EBSRequest ebsReq = new EBSRequest();

            ebsData.ConflictId  = iEbs.ConflictId__c;
            ebsData.Created  = date.valueOf(iEbs.CreatedDate);
            ebsData.CreatedBy  = 'ADMIN JAVER'; //iEbs.CreatedBy.Name;
            ebsData.DbLastUpd  = null;
            ebsData.DbLastUpdSrc  = null;
            ebsData.DescTipoDocto  = iEbs.DescTipoDocto__c;
            ebsData.FechaContable  = iEbs.FechaContable__c;
            ebsData.FechaDeposito  = iEbs.FechaDeposito__c;
            ebsData.FechaRecibo  = iEbs.FechaRecibo__c;
            ebsData.IdClienteAr  = iEbs.IdClienteAr__c;
            ebsData.IdCobranzaMultiple  = String.ValueOf(iEbs.IdCobranzaMultiple__c);
            ebsData.IdEstadoVenta  = String.ValueOf(iEbs.IdEstadoVenta__c);
            ebsData.IdInterface  = Integer.valueOf(iEbs.IdInterface__c);
            ebsData.IdInterfaceCrm  = iEbs.IdInterfaceCrm__c;
            ebsData.IdMoneda  = iEbs.IdMoneda__c;
            ebsData.IdProcesoAr  = iEbs.IdProcesoAr__c;
            ebsData.IdReciboAr  = integer.valueOf(iEbs.IdReciboAr__c);
            ebsData.IdReciboCrm  = iEbs.IdReciboCrm__c;
            ebsData.IdReestructura  = integer.valueOf(iEbs.IdReestructura__c);
            ebsData.IdSector  = integer.valueOf(iEbs.IdSector__c);
            ebsData.IdTipoDocto  = integer.valueOf(iEbs.IdTipoDocto__c);
            ebsData.ImporteRecibo  = String.valueOf(iEbs.ImporteRecibo__c);
            ebsData.IndAnticipo  = integer.valueOf(iEbs.IndAnticipo__c);
            ebsData.IndReversa  = integer.valueOf(iEbs.IndReversa__c);
            ebsData.LastUdp  = Date.valueOf(iEbs.LastModifiedDate);
            ebsData.LastUdpBy  = iEbs.LastModifiedBy.Name;
            ebsData.Metodo  = iEbs.Metodo__c;
            ebsData.ModifecationNum  = integer.valueOf(iEbs.ModifecationNum__c);
            ebsData.NumRecibo  = iEbs.NumRecibo__c;
            ebsData.Referencia  = iEbs.Referencia__c;
            ebsData.Requisicion  = iEbs.Requisicion__c;
            ebsData.RetryCount  = integer.valueOf(iEbs.RetryCount__c);
            ebsData.RowId = string.valueOf(iEbs.Id_Interface_AutoNo__c);
            ebsData.SesionCajaId  = iEbs.SesionCajaId__c;
            ebsData.TipoPago  = iEbs.TipoPago__c;
            ebsData.RespuestaApi = '0';
            ebsData.IdInterface = Integer.valueOf(iEbs.Id_Interface_AutoNo__c);
            ebsData.IdInterfaceCrm = iEbs.Id;

            ebsReq.InsPagoSfCRMtoERP = ebsData;

            String body = JSON.serialize(ebsReq);

            System.debug('EBSRequest: ' + body);

            String esbURL = mdt.URL_base__c + '' + mdt.Servicio_Pagos__c;

            System.enqueueJob(new QueueableIntegracionEBSCall(esbURL, 'POST', body, iEbs.Id));
        }
    }


    public class EBSRequest {
        //public String @Version;
        //public String @RequestDate;
        //public String @SourceSystem;
        //public String @TransactionID;
        public InsPagoSfCRMtoERP InsPagoSfCRMtoERP;
    }

    public class InsPagoSfCRMtoERP {
        public String RowId;
        public Date Created;
        public String CreatedBy;
        public Integer ModifecationNum;
        public String ConflictId;
        public String RespuestaApi;
        public Date DbLastUpd;
        public String DbLastUpdSrc;
        public Date FechaContable;
        public Date FechaDeposito;
        public Date FechaRecibo;
        public String IdClienteAr;
        public String IdCobranzaMultiple;
        public String IdEstadoVenta;
        public Integer IdInterface;
        public Integer IdReciboAr;
        public Integer IdReestructura;
        public Integer IdSector;
        public Integer IdTipoDocto;
        public String ImporteRecibo;
        public Integer IndAnticipo;
        public Integer IndReversa;
        public Integer RetryCount;
        public String DescTipoDocto;
        public String IdInterfaceCrm;
        public String IdMoneda;
        public String IdProcesoAr;
        public String IdReciboCrm;
        public String Metodo;
        public String NumRecibo;
        public String Referencia;
        public String Requisicion;
        public String SesionCajaId;
        public String TipoPago;
        public Date LastUdp;
        public String LastUdpBy;
    }


    public class EBSResponse {

        public String ResponseDate;
        public Boolean Success;
        public String ESB_Id;
        public String NombreCompleto;
        public String Departamento;
        public String Oficina;
        public String Estado;
        public PagoSfCRMtoERP PagoSfCRMtoERP;        
    }

    public class PagoSfCRMtoERP {
        public PagoSfCRMtoERPResponse PagoSfCRMtoERPResponse;
    }

    public class PagoSfCRMtoERPResponse {
        public String MensajeApi;
        public String RespuestaApi;
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

            Integracion_EBS_Pagos__c integracionEBS = [SELECT Id FROM Integracion_EBS_Pagos__c WHERE ID = :recordId];

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
                        integracionEBS.Respuesta_API__c = ebsRes.PagoSfCRMtoERP.PagoSfCRMtoERPResponse.RespuestaApi;
                        //integracionEBS.Id_Cliente_AR__c = ebsRes.ESB_Id;
                        //integracionEBS.Id_Cliente_AR__c = ebsRes.ESB_Id;
                        update integracionEBS;
                    }
                    else
                    {
                        integracionEBS.Estatus_Integracion__c = 'Error';
                        integracionEBS.Respuesta_API__c = ebsRes.PagoSfCRMtoERP.PagoSfCRMtoERPResponse.MensajeApi;
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
}