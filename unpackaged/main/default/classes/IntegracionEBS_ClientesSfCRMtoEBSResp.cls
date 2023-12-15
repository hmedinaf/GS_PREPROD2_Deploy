/**
 * @description       : Clase Apex que expone un servicio REST para recibir unformación de Clientes que fueron procesados en EBS
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-07-31
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
@RestResource(urlMapping='/EBS/Clientes/*')
global with sharing class IntegracionEBS_ClientesSfCRMtoEBSResp
{
    @HttpPost
    global static ResponseWrapper doPost()
    {
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();

        RequestWrapper reqW = (RequestWrapper)JSON.deserialize(requestString,RequestWrapper.class);

        Integracion_EBS_Clientes__c iebc;

        ResponseWrapper respW = new ResponseWrapper();
        
        try
        {
            iebc = [SELECT Id, Name FROM Integracion_EBS_Clientes__c WHERE Id =: reqW.IdInterfaseCrm];

            iebc.Id_Cliente_AR__c = reqW.IdClienteAr;
            iebc.Id_Proceso_AR__c = String.valueOf(reqW.IdProcesoAr);
            iebc.Mensaje_API__c = reqW.MensajeApi;
            iebc.Respuesta_API__c = reqW.RespuestaApi;
            iebc.Request_EBS_hacia_CRM__c = requestString;
            iebc.Estatus_Integracion__c = reqW.RespuestaApi!='4' ? 'Integrado' : 'Error';
            // if (reqW.RespuestaApi == '4') {
            //     iebc.Estatus_Integracion__c = 'Error';
            // } else {
            //     iebc.Estatus_Integracion__c = 'Integrado';
            // }
            
            // if (reqW.RespuestaApi=='5') { // Exito
            //     iebc.Estatus_Integracion__c = 'Integrado';
            // } else {
            //     if (reqW.RespuestaApi=='4') { //Error
            //         iebc.Estatus_Integracion__c = 'Error';
            //     }
            // }
            respW.MensajeApi = 'Actualizado en CRM';
            respW.RespuestaApi = '1';
            iebc.Response_EBS_hacia_CRM__c = JSON.serialize(respW);

            update iebc;

            return respW;
        }
        catch (Exception e)
        {
            String msjApi = 'Error: ' + e.getMessage();
            respW.MensajeApi = msjApi.length() > 2000 ? msjApi.substring(0, 1999) : msjApi;
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
        public String IdClienteAr;
        public String IdProcesoCrm;
        public Integer IdProcesoAr;
        public String MensajeApi;
        public String RespuestaApi;
        public String IdInterfaseCrm;
    }

    global class ResponseWrapper
    {
        public String MensajeApi;
        public String RespuestaApi;
    }
}