/**
 * @description       : Servicio PAGOS Rest Entrada - De EBS a Salesforce, RESPONSE llamado de SF->EBS
 * @author            : Héctor Medina
 * @group             : 
 * @last modified on  : 2023-09-29
 * @last modified by  : Héctor Medina
**/

@RestResource(urlMapping='/EBS/Pagos/*')
global with sharing class IntegracionEBS_PagoSfCRMtoEBSResp
{
    @HttpPost
    global static ResponseWrapper doPost()
    {
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();

        RequestWrapper reqW = (RequestWrapper)JSON.deserialize(requestString,RequestWrapper.class);

        Integracion_EBS_Pagos__c iebc;

        ResponseWrapper respW = new ResponseWrapper();
        
        try
        {
            iebc = [SELECT Id, Name FROM Integracion_EBS_Pagos__c WHERE Id =: reqW.IdInterfaseCrm];

            iebc.IdClienteAr__c = reqW.IdClienteAr;
            iebc.Mensaje_API__c = reqW.MensajeApi;
            iebc.Respuesta_API__c = reqW.RespuestaApi;
            iebc.Request_EBS_hacia_CRM__c = requestString;
            if (reqW.RespuestaApi=='5') { // Exito
                iebc.Estatus_Integracion__c = 'Integrado';
            } else {
                if (reqW.RespuestaApi=='4') { //Error
                    iebc.Estatus_Integracion__c = 'Error';
                }
            }
            // iebc.Estatus_Integracion__c = 'Integrado';
            respW.MensajeApi = 'Actualizado en CRM';
            respW.RespuestaApi = '0';
            iebc.Response_EBS_hacia_CRM__c = JSON.serialize(respW);

            iebc.Created__c = reqw.Created;
            //iebc.CreatedBy__c = reqw.CreatedBy;
            /* *** Esto no va en este servicio, hay otro servicio para ello: ***
            iebc.ModifecationNum__c = reqw.ModifecationNum;
            iebc.ConflictId__c = reqw.ConflictId;
            iebc.FechaContable__c = reqw.FechaContable;
            iebc.FechaDeposito__c = reqw.FechaDeposito;
            iebc.FechaRecibo__c = reqw.FechaRecibo;
            iebc.IdCobranzaMultiple__c = integer.valueof(reqw.IdCobranzaMultiple);
            iebc.IdEstadoVenta__c = decimal.valueof(reqw.IdEstadoVenta);
            iebc.IdInterface__c = reqw.IdInterface;
            iebc.IdReestructura__c = reqw.IdReestructura;
            iebc.IdSector__c = reqw.IdSector;
            iebc.IdTipoDocto__c = reqw.IdTipoDocto;
            iebc.ImporteRecibo__c = decimal.valueof(reqw.ImporteRecibo);
            iebc.IndAnticipo__c = reqw.IndAnticipo;
            iebc.IndReversa__c = reqw.IndReversa;
            iebc.RetryCount__c = reqw.RetryCount;
            iebc.DescTipoDocto__c = reqw.DescTipoDocto;
            iebc.IdMoneda__c = reqw.IdMoneda;
            iebc.IdProcesoAr__c = reqw.IdProcesoAr;
            iebc.IdReciboCrm__c = reqw.IdReciboCrm;
            iebc.Metodo__c = reqw.Metodo;
            iebc.NumRecibo__c = reqw.NumRecibo;
            iebc.Referencia__c = reqw.Referencia;
            iebc.Requisicion__c = reqw.Requisicion;
            iebc.SesionCajaId__c = reqw.SesionCajaId;
            iebc.TipoPago__c = reqw.TipoPago;
            */
            // iebc.LastUdp__c = reqw.LastUdp;
            // iebc.LastUdpBy__c = reqw.LastUdpBy;

            update iebc;

            return respW;
        }
        catch (Exception e)
        {
            String msjApi = 'Error: ' + e.getMessage();
            respW.MensajeApi = msjApi;//.substring(0, 1999);
            respW.RespuestaApi = '-1';

            return respW;
        }

    }
    
    /*
    @HttpGet
    global static void doGet()
    {
        //ToDo
    }

    @HttpDelete
    global static void doDelete()
    {
        //ToDo
    }*/

    global class RequestWrapper
    {
        public String RespuestaApi;
        public String MensajeApi;
        public String IdReciboAr;
        public String IdClienteAr;
        public String IdInterfaseCrm;
        public String RowId;

        public Date Created;
        public String CreatedBy;
        public Integer ModifecationNum;
        public String ConflictId;
        public Date FechaContable;
        public Date FechaDeposito;
        public Date FechaRecibo;
        public String IdCobranzaMultiple;
        public String IdEstadoVenta;
        public Integer IdInterface;
        public Integer IdReestructura;
        public Integer IdSector;
        public Integer IdTipoDocto;
        public String ImporteRecibo;
        public Integer IndAnticipo;
        public Integer IndReversa;
        public Integer RetryCount;
        public String DescTipoDocto;
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

    global class ResponseWrapper
    {
        public String MensajeApi;
        public String RespuestaApi;
    }
}