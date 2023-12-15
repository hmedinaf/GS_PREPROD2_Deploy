/**
 * @description       : 
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-07-31
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
@RestResource(urlMapping='/EBS/Facturas/*')
global with sharing class IntegracionEBS_FacturasSfCRMtoEBSResp
{
    @HttpPost
    global static ResponseWrapper doPost()
    {
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();

        RequestWrapper reqW = (RequestWrapper)JSON.deserialize(requestString,RequestWrapper.class);

        Integracion_EBS_Facturas__c iebc;

        ResponseWrapper respW = new ResponseWrapper();
        
        try
        {
            iebc = [SELECT Id, Name, IdFacturaCrm__c FROM Integracion_EBS_Facturas__c WHERE Id =: reqW.IdInterfaseCrm];

            iebc.IdClienteAr__c = reqW.IdClienteAr;
            iebc.Mensaje_API__c = reqW.MensajeApi;
            iebc.Respuesta_API__c = reqW.RespuestaApi;
            iebc.IdFacturaAr__c = reqW.IdFacturaAr;
            iebc.IdInterfaceCrm__c = reqW.IdInterfaseCrm;
            iebc.Request_EBS_hacia_CRM__c = requestString;
            iebc.Estatus_Integracion__c = 'Integrado';
            // if (reqW.RespuestaApi=='5') { // Exito
            //     iebc.Estatus_Integracion__c = 'Integrado';
            // } else {
            //     if (reqW.RespuestaApi=='4') { //Error
            //         iebc.Estatus_Integracion__c = 'Error';
            //     }
            // }
            // iebc.Estatus_Integracion__c = 'Integrado';
            respW.MensajeApi = 'Actualizado en CRM';
            respW.RespuestaApi = '1';
            iebc.Response_EBS_hacia_CRM__c = JSON.serialize(respW);

            update iebc;

            // Actualizar datos de Factura (Quizá mandarlo a asyncronous flow)
            List <Documento__c> lDoc = [SELECT Id, IdFacturaAr__c 
                FROM Documento__c WHERE Name = :iebc.IdFacturaCrm__c];

            if (lDoc.size() > 0) {
                lDoc[0].IdFacturaAr__c = reqW.IdFacturaAr;

                update lDoc;
            }

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
        public String IdFacturaAr;
        public String IdClienteAr;
        public String IdInterfaseCrm;
        public String RowId;
    }

    global class ResponseWrapper
    {
        public String MensajeApi;
        public String RespuestaApi;
    }
}