public with sharing class AprobacionTerrenosWS {
    
    public class customException extends Exception {}
    
    List<Bitacora__c> logs = new List<Bitacora__c>();
    public static Map<String,String> ValoresXML;    
    
    @future(callout=true)
    public static void ActualizaTerrenos(String ApprovalType, String ApprovalId, String SourceSystem, String Status, String FlowCheckpoint, String SolicitudTerrenoId)
    {
        String mensaje;
        Integer numeroIntentos = 1;
        String requestDate;
        String javerNS;
        String wsEndpoint;
        
        while(numeroIntentos <= 3)
        {
            try
            {
                FlujosDeAprobacion__c settingsFlujos = FlujosDeAprobacion__c.getOrgDefaults();
                javerNs = settingsFlujos.Javer_XMLNS__c;
                wsEndpoint = settingsFlujos.Manage_Approval_WS_Endpoint__c;
                requestDate = String.valueOf(System.DateTime.now());
                requestDate = requestDate.substring(0,10) + 'T' + requestDate.substring(11);
                String resp = '<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:typ=\"' + javerNS + '\">'
                +  '\n <soap:Header/>'
                +  '\n <soap:Body>'
                +  '\n <typ:UpdateApprovalStatusRq RequestDate=\"' +  requestDate + '\" SourceSystem=\"SALESFORCE_SOLCOM\" ApprovalType=\"' + ApprovalType + '\" Version="1.1">'
                +  '\n <typ:ApprovalId>' + ApprovalId + '</typ:ApprovalId>'
                +  '\n <typ:SourceSystem>' + SourceSystem + '</typ:SourceSystem>'
                +  '\n <typ:Status>' + Status + '</typ:Status>'
                +  '\n <typ:TerrenoAttributes FlowCheckpoint=\"' + FlowCheckpoint + '\"/>'
                +  '\n </typ:UpdateApprovalStatusRq>'
                +  '\n </soap:Body>'
                +  '\n </soap:Envelope>';
    
    
                HttpRequest req = new HttpRequest();
                req.setEndpoint(wsEndpoint);
                req.setMethod('POST');
                req.setBody(resp);
                req.setHeader('Content-Type', 'application/soap+xml;charset=UTF-8;');
               
                
                req.setHeader('SOAPAction', 'UpdateApprovalStatusRequest');
                req.setHeader('Accept-Encoding', 'gzip,deflate');
                            
                req.setTimeout(120000);
                System.Debug('Resp: ' + resp);
                
                Http http = new Http();                                   
                HTTPResponse res = http.send(req);
    
                String respuesta = '<?xml version="1.0"?>'+res.getBody();
                System.Debug('Respuesta: ' + respuesta);

                if(respuesta.contains('404 Not Found'))
                {
                    throw new customException('404 Not Found');
                }
                else
                {
                    getXMLDocument(respuesta);
                }
                
                Bitacora__c log;
                if(valoresXML.get('Success') == 'true')
                {
                 log = new Bitacora__c(Fecha__c = Date.today(),
                                            Origen__c = 'Salesforce', 
                                            ServicioWeb__c = 'Servicio de Solicitudes de Terrenos en Salesforce',
                                            Operacion__c =  'Aprobación',
                                            Estado__c = '200 (OK)');
                }
                else
                {
                    mensaje = valoresXML.get('ShortText') +  ' EBS_Id: ' + valoresXML.get('ESB_Id');
                 log = new Bitacora__c(Fecha__c = Date.today(),
                                            Origen__c = 'Salesforce', 
                                            ServicioWeb__c = 'Servicio de Solicitudes de Terrenos en Salesforce',
                                            Operacion__c =  'Aprobación',
                                            Estado__c = '400 (ERROR)',
                                            Mensaje__c = mensaje);                  
                }
                                
                SolicitudTerreno__c SolicitudTerreno= [SELECT Id
                                        , StatusInternoAprobacion__c
                                        , Aprobacion_Externa__c
                                        FROM SolicitudTerreno__c 
                                         WHERE Id = : SolicitudTerrenoId
                                         LIMIT 1 ];
                if(SolicitudTerreno != null)
                {
                    SolicitudTerreno.StatusInternoAprobacion__c = null;
                    SolicitudTerreno.Aprobacion_Externa__c = false;
                    try{
                      update SolicitudTerreno; 
                    } catch(Exception e)
                    {
                        System.debug(System.LoggingLevel.ERROR, 'Error update SolicitudTerreno__c: ' + e.getDmlMessage(0));
                    }
                }
                try {
                    insert log;
                } catch (Exception e) {
                    System.debug(System.LoggingLevel.ERROR, 'Error inserting webservice logs: ' + e.getDmlMessage(0));
                }
                numeroIntentos = 4;
            }
            catch(Exception ex)
            {
                System.debug(numeroIntentos);
                if(numeroIntentos < 3)
                {
                    numeroIntentos++;
                }
                else
                {
                    numeroIntentos = 4;
                    SolicitudTerreno__c SolicitudTerreno= [SELECT Id
                                        , StatusInternoAprobacion__c
                                        , Aprobacion_Externa__c
                                        FROM SolicitudTerreno__c 
                                         WHERE Id = : SolicitudTerrenoId
                                         LIMIT 1 ];
                    if(SolicitudTerreno != null)
                    {
                        SolicitudTerreno.StatusInternoAprobacion__c = null;
                        SolicitudTerreno.Aprobacion_Externa__c = false;
                        
                        try
                        {
                            update SolicitudTerreno;
                        } catch(Exception e)
                        {
                            System.debug(System.LoggingLevel.ERROR, 'Error update SolicitudTerreno__c: ' + e.getDmlMessage(0));
                        }
                    }                   
                    Bitacora__c log = new Bitacora__c(Fecha__c = Date.today(),
                                            Origen__c = 'Salesforce', 
                                            ServicioWeb__c = 'Servicio de Solicitudes de Terrenos en Salesforce',
                                            Operacion__c =  'Aprobación',
                                            TipoDeError__c = 'COMUNICACION',
                                            Estado__c = '400 (ERROR)');
                                            
                                             
                    try {
                        insert log;
                    } catch (Exception e) {
                        System.debug(System.LoggingLevel.ERROR, 'Error inserting webservice logs: ' + e.getDmlMessage(0));
                    }
                }
                    
            }
        }
    }
    
    public static void getXMLDocument(String respuesta)
    {
        XmlStreamReader reader = new XmlStreamReader(respuesta);
        valoresXML = new Map<String,String>();
        while(reader.hasNext()) {
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if ('UpdateApprovalStatusRs' == reader.getLocalName()) {
                    valoresXML.put('ResponseDate', reader.getAttributeValue(null, 'ResponseDate'));
                    valoresXML.put('Success', reader.getAttributeValue(null, 'Success'));
                    valoresXML.put('ESB_Id', reader.getAttributeValue(null, 'ESB_Id'));
                }else if('Error' == reader.getLocalName())
                {
                    valoresXML.put('Language', reader.getAttributeValue(null, 'Language'));
                    valoresXML.put('Type', reader.getAttributeValue(null, 'Type'));
                    valoresXML.put('ShortText', reader.getAttributeValue(null, 'ShortText'));
                    valoresXML.put('Code', reader.getAttributeValue(null, 'Code'));
                }
            }
            reader.next();
        } 
    }
    
    @future(callout=true)
    public static void ActualizaRegistro(String SolicitudTerrenoId)
    {
        SolicitudTerreno__c SolicitudTerreno= [SELECT Id
                            , StatusInternoAprobacion__c
                            , Aprobacion_Externa__c
                            FROM SolicitudTerreno__c
                            WHERE Id = : SolicitudTerrenoId
                            LIMIT 1 ];
        if(SolicitudTerreno != null)
        {
            SolicitudTerreno.StatusInternoAprobacion__c = null;
            SolicitudTerreno.Aprobacion_Externa__c = false;
            
            try
            {
                update SolicitudTerreno;
            } catch(Exception e)
            {
                System.debug(System.LoggingLevel.ERROR, 'Error update SolicitudTerreno__c: ' + e.getDmlMessage(0));
            }
        }                   
    }
    
    
}