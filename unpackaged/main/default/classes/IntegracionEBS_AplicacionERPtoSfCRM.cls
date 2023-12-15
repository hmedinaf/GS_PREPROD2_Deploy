/**
 * @description       : 
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-09-25
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
@RestResource(urlMapping='/EBS/Aplicaciones/*')
global with sharing class IntegracionEBS_AplicacionERPtoSfCRM
{
    @HttpPost
    global static ResponseWrapper doPost()
    {
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();

        RequestWrapper reqW = (RequestWrapper)JSON.deserialize(requestString,RequestWrapper.class);

        List<Integracion_EBS_Aplicaciones__c> aplicaciones = new List<Integracion_EBS_Aplicaciones__c>();
        Integracion_EBS_Aplicaciones__c ieba;

        ResponseWrapper respW = new ResponseWrapper();
        
        try
        {
            //ieba = [SELECT Id, Name FROM Integracion_EBS_Aplicaciones__c WHERE Id =: reqW.IdInterfaceCrm];

            respW.MensajeApi = 'Creado en CRM';
            respW.RespuestaApi = '1';

            for(Aplicacion app : reqW.Aplicaciones)
            {
                ieba = new Integracion_EBS_Aplicaciones__c();

                ieba.IdAplicacionAr__c = app.IdAplicacionAr;
                ieba.IdClienteAr__c = app.IdClienteAr;
                ieba.IdFacturaAr__c = app.IdFacturaAr;
                ieba.IdNotaCredAr__c = app.IdNotaCredAr;
                ieba.IdProcesoAr__c = app.IdProcesoAr;
                ieba.IdReciboAr__c = app.IdReciboAr;
                ieba.IdInterfaceCrm__c = app.IdInterfaceCrm;

                ieba.FechaAplicacion__c = app.FechaAplicacion;
                ieba.FechaContable__c = app.FechaContable;
                ieba.ImporteACuenta__c = app.ImporteACuenta;
                ieba.ImporteAnticipo__c = app.ImporteAnticipo;
                ieba.ImporteAplicado__c = app.ImporteAplicado;
                ieba.ImporteFuncional__c = app.ImporteFuncional;
                ieba.ImporteNoAplicado__c = app.ImporteNoAplicado;
                ieba.ImporteNoIdentificado__c = app.ImporteNoIdentificado;
                ieba.ImporteOriginal__c = app.ImporteOriginal;
                ieba.ImporteReclamo__c = app.ImporteReclamo;
                ieba.ImporteResto__c = app.ImporteResto;

                ieba.Mensaje_API__c = app.MensajeApi;
                ieba.Respuesta_API__c = app.RespuestaApi;
                ieba.Request_EBS_hacia_CRM__c = requestString;
                ieba.Estatus_Integracion__c = app.RespuestaApi!='4' ? 'Integrado' : 'Error';

                ieba.Response_EBS_hacia_CRM__c = JSON.serialize(respW);

                aplicaciones.add(ieba);
            }

            insert aplicaciones;

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
        public List<Aplicacion> Aplicaciones;
        

    }

    global class ResponseWrapper
    {
        public String MensajeApi;
        public String RespuestaApi;
    }

    private class Aplicacion
    {
        public String IdAplicacionAr;
        public String IdClienteAr;
        public String IdFacturaAr;
        public String IdNotaCredAr;
        public String IdProcesoAr;
        public String IdReciboAr;
        
        public String IdInterfaceCrm;
        public Date FechaAplicacion;
        public Date FechaContable;

        public Decimal ImporteACuenta;
        public Decimal ImporteAnticipo;
        public Decimal ImporteAplicado;
        public Decimal ImporteFuncional;
        public Decimal ImporteNoAplicado;
        public Decimal ImporteNoIdentificado;
        public Decimal ImporteOriginal;
        public Decimal ImporteReclamo;
        public Decimal ImporteResto;

        public String MensajeApi;
        public String RespuestaApi;
    }
}