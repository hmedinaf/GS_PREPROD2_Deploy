/**
 * @description       : Clase que consume el servicio "Lista Negra, Quién es Quién"
 * @author            : Oscar Bustos Mtz
 * @group             : Capptus
 * @last modified on  : 09-30-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
global class ListaNegra_QEQ {

    static Map<String, Object>  mapaRespuestaQEQ    =   new Map<String, Object>();
    static Boolean              successWsCall       =   false;
    static String               MessageWsCall       =   '';


    @future (callout=true)
    public static void ListaNegra_QEQ(String cuentaId) {

        date fNac = date.newInstance(1957, 4, 4);
        Account cuenta = new Account();
        Account acc1 = [SELECT IsPersonAccount FROM Account WHERE Id =: cuentaId];

        if(acc1.IsPersonAccount){
            cuenta = [SELECT Id, FirstName, LastName, Apellidomaterno_cta__c, RFC_Completo__c, CURP__c, IsPersonAccount, FechaNacimiento__c FROM Account WHERE Id =: cuentaId];
        }else{
            cuenta = [SELECT Id, Name, RFC_Completo__c, CURP__c, IsPersonAccount FROM Account WHERE Id =: cuentaId];
        }
        system.debug('cuenta: '+cuenta);
        String respuestaQEQ;

        try {

            DateTime dt = DateTime.now();
            String dateTimeStr = dt.format('yyyy/MM/dd\'T\'hh:mm:ss');

            accObj acc = new accObj();

            if(cuenta.IsPersonAccount){
                acc.nombre              =   cuenta.FirstName;
                acc.apellido_paterno    =   cuenta.LastName;
                acc.apellido_materno    =   cuenta.Apellidomaterno_cta__c;
                if (cuenta.FechaNacimiento__c != null) {
                    acc.fecha_nacimiento = cuenta.FechaNacimiento__c;
                }
            }else{
                acc.nombre              =   cuenta.Name;
            }
            
            // acc.rfc                 =   cuenta.RFC_Completo__c;
            // acc.curp                =   cuenta.CURP__c;

            JSONGenerator requestJSON = JSON.createGenerator(true);
            requestJSON.writeStartObject();
            requestJSON.writeStringField('@Version'                 ,   '1');
            requestJSON.writeStringField('@RequestDate'             ,   dateTimeStr);
            requestJSON.writeStringField('@SourceSystem'            ,   'Salesforce');
            requestJSON.writeStringField('@TransactionID'           ,   'String');
            requestJSON.writeObjectField('ListaNegraQEQSalesforce'  ,   acc);
            requestJSON.writeEndObject();

            HttpRequest     requestQEQ  = new HttpRequest();
            Http            httpQEQ     = new Http();
                
            requestQEQ.setMethod('POST');
            requestQEQ.setEndpoint(System.Label.QEQ_Endpoint);
            requestQEQ.setHeader('Content-Type','application/json');     
            requestQEQ.setBody(requestJSON.getAsString());
            requestQEQ.setTimeout(60000);
            System.debug('*****requestJSON:' + requestJSON);
            System.debug('*****requestJSON.getAsString()):' + requestJSON.getAsString());
            System.debug('*****requestQEQ:' + requestQEQ);
            
            HTTPResponse responseQEQ    = httpQEQ.send(requestQEQ);
            respuestaQEQ                = responseQEQ.getBody();
            mapaRespuestaQEQ            = (Map<String, Object>)JSON.deserializeUntyped(respuestaQEQ);

            System.debug('*****mapaRespuestaQEQ:' + mapaRespuestaQEQ);

            if(Boolean.valueOf(mapaRespuestaQEQ.get('@Success'))){

                Map<String, Object>     ListaNegraQEQSalesforceRs   = (Map<String, Object>)mapaRespuestaQEQ.get('ListaNegraQEQSalesforceRs');
                Map<String, Object>     PagoSfCRMtoERPResponse      = (Map<String, Object>)ListaNegraQEQSalesforceRs.get('PagoSfCRMtoERPResponse');
                List<Object>            persona                     = (List<Object>)PagoSfCRMtoERPResponse.get('persona');
                System.debug('*****persona: ' + persona);
                
                Object datosPersona = persona.get(0);
                System.debug('*****datosPersona: ' + datosPersona);
                
                Map<String, Object> datoPersona = (Map<String, Object>)datosPersona;
                System.debug( '*****datoPersona.get(apellido_paterno):' + datoPersona.get('apellido_paterno'));
                System.debug( '*****datoPersona.get(apellido_materno):' + datoPersona.get('apellido_materno'));
                System.debug( '*****datoPersona.get(fecha_nacimiento):' + datoPersona.get('fecha_nacimiento'));
                System.debug( '*****datoPersona.get(sexo):' + datoPersona.get('sexo'));
                System.debug( '*****datoPersona.get(nombre):' + datoPersona.get('nombre'));
                System.debug( '*****datoPersona.get(curp):' + datoPersona.get('curp'));
                System.debug( '*****datoPersona.get(rfc):' + datoPersona.get('rfc'));
                System.debug( '*****datoPersona.get(lista):' + datoPersona.get('lista'));

                cuenta.QEQ_Apellido_Paterno__c = (String)datoPersona.get('apellido_paterno');
                cuenta.QEQ_Apellido_Materno__c = (String)datoPersona.get('apellido_materno');                
                cuenta.QEQ_Fecha_Nacimiento__c = (String)datoPersona.get('fecha_nacimiento');
                cuenta.QEQ_Sexo__c = (String)datoPersona.get('sexo');
                cuenta.QEQ_Nombre__c = (String)datoPersona.get('nombre');
                cuenta.QEQ_CURP__c = (String)datoPersona.get('curp');
                cuenta.QEQ_RFC__c = (String)datoPersona.get('rfc');
                cuenta.QEQ_Lista__c = (String)datoPersona.get('lista');

                System.debug( '*****Integer.valueOf(PagoSfCRMtoERPResponse.get(registros_encontrados)):' + Integer.valueOf(PagoSfCRMtoERPResponse.get('registros_encontrados')));
                if(Integer.valueOf(PagoSfCRMtoERPResponse.get('registros_encontrados')) > 0 ){
                    if (cuenta.QEQ_Lista__c == 'PPE') {
                        cuenta.Estatus_Lista_Negra_QEQ__c = 'PPE';
                    } else {
                        cuenta.Estatus_Lista_Negra_QEQ__c = 'LISTA NEGRA';
                    }
                }else{
                    cuenta.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
                }
            }else{
                cuenta.Estatus_Lista_Negra_QEQ__c = 'SIN VALIDAR';
            }
            
            System.debug( '*****cuenta.Estatus_Lista_Negra_QEQ__c:' + cuenta.Estatus_Lista_Negra_QEQ__c);
            update cuenta;

            MessageWsCall = 'Completado';
            successWsCall = true;
            
        } catch (Exception e) {
            System.debug('*****Error: ' + e.getMessage());
            MessageWsCall = 'Error: ' + e.getMessage();
            successWsCall = false;
        }

    }

    @AuraEnabled  
    public static void sentToQeq(String recId) {
        
        ListaNegra_QEQ(recId);
        if(!successWsCall){
            System.debug('*****MessageWsCall:' + MessageWsCall);
            //throw new AuraHandledException(MessageWsCall);
        }
    }

    public class accObj{
        String nombre               {get;set;}
        String apellido_paterno     {get;set;}
        String apellido_materno     {get;set;}
        String rfc                  {get;set;}
        String curp                 {get;set;}
        Date   fecha_nacimiento     {get;set;}
    }

    public class accObjRespuesta{
        String id_persona {get;set;}
        String estatus {get;set;}
        String apellido_paterno {get;set;}
        String apellido_materno {get;set;}
        String fecha_nacimiento {get;set;}
        String sexo {get;set;}
        String nombre {get;set;}
        String curp {get;set;}
        String rfc {get;set;}
    }
}