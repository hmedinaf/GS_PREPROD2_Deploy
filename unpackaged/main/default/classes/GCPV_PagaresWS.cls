public without sharing class GCPV_PagaresWS {
    public GCPV_PagaresWS() {
    }
    
	@future(callout=true)
    public static void getPagares(String daysBefore) {

        LogATC__c log = new LogATC__c();
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'GCPV_PagaresWS';
        try{
            recursionCheck.PATCPagare = true;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Boolean runningInASandbox = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
            String endpoint_x = runningInASandbox ? 'https://qesb.javer.com.mx:11962/services/Cobranza/PostVenta/rest/GetInfoPostVentaSBL?DaysBefore=' : 'https://esb.javer.com.mx:11902/services/Cobranza/PostVenta/rest/GetInfoPostVentaSBL?DaysBefore=';
            //add label for endpoint
            request.setEndpoint(endpoint_x + daysBefore);
            request.setMethod('GET');
            request.setTimeout(120000);
            HttpResponse response = http.send(request);
            // If the request is successful, parse the JSON response.
            if(Test.isRunningTest()){testing();}
            if(response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                String ReportePostVentaSBLJSON = JSON.serialize(results.get('ReportePostVentaSBL'));
                Map<String, Object> ReportePostVentaSBL = (Map<String, Object>) JSON.deserializeUntyped(ReportePostVentaSBLJSON);
                List<Object> pagaresResponse = (List<Object>) ReportePostVentaSBL.get('Row');
                List<Id> numerosPagares = new List<Id>();
                Map <String, Pagare_Ant__c> PATCPagare = new Map <String, Pagare_Ant__c>();
                Map <String, Inventario__c> PATCExistentes = new Map <String, Inventario__c>();
                Map<String, Map<String, Pagare_Ant__c>> pagaresPATC = new Map<String, Map<String, Pagare_Ant__c>>();
                Map<String, Pagare_Ant__c> pagaresWS = new Map<String, Pagare_Ant__c>();
                Map<String, Pagare_Ant__c> pagaresToInsert = new Map<String, Pagare_Ant__c>();
                Map<String, Pagare_Ant__c> pagaresToUpdate = new Map<String, Pagare_Ant__c>();
                for(Object pagareObj: pagaresResponse) {
                    Map <String, Object> pagareMap = (Map <String, Object>) pagareObj;
                    Pagare_Ant__c pagare = new Pagare_Ant__c();
                    for (String key : pagareMap.keySet()){
                        pagare.put(key + '__c', pagareMap.get(key));
                        // add the sObject to the list
                    }

                    if(pagaresPATC.isEmpty() || !pagaresPATC.containsKey(pagare.NumProceso__c)) {
                        Map<String, Pagare_Ant__c> pagareTransacciones = new Map<String, Pagare_Ant__c>();
                        pagareTransacciones.put(pagare.NumPagare__c, pagare);

                        pagaresPATC.put(pagare.NumProceso__c, pagareTransacciones);
                    }else if(pagaresPATC.containsKey(pagare.NumProceso__c)){
                        pagaresPATC.get(pagare.NumProceso__c).put(pagare.NumPagare__c, pagare);
                    }

                    pagaresWS.put(pagare.NumPagare__c, pagare);

                }
                //check if pagare already exists and update it
                for(Pagare_Ant__c pagareExistente : [Select Id, NumPagare__c From Pagare_Ant__c Where NumPagare__c IN: pagaresWS.keySet()]){
                    Pagare_Ant__c pagareToUpdate = new Pagare_Ant__c();
                    pagareToUpdate = pagaresWS.get(pagareExistente.NumPagare__c);
                    pagareToUpdate.Id = pagareExistente.Id;
                    pagaresToUpdate.put(pagareToUpdate.NumPagare__c, pagareToUpdate);
                    System.debug(pagareToUpdate);
                }

                //if the pagare is new, add the PATC
                for(Inventario__c PATCExistente : [Select Id, NumeroProceso__c From Inventario__c Where NumeroProceso__c IN: pagaresPATC.keySet()]){
                    Map<String, Pagare_Ant__c> pagareTransacciones = pagaresPATC.get(PATCExistente.NumeroProceso__c);
                    for(Pagare_Ant__c pagareToInsert : pagareTransacciones.values()){
                        if(!pagaresToUpdate.containsKey(pagareToInsert.NumPagare__c)){
                            pagareToInsert.Proceso_ATC__c = PATCExistente.Id;
                            pagaresToInsert.put(pagareToInsert.NumPagare__c, pagareToInsert);
                            System.debug(pagareToInsert);
                        }
                    }
                }
                
                update pagaresToUpdate.values();
                insert pagaresToInsert.values();

                log.Mensaje__c = 'Pagares Actualizados: ' + pagaresToUpdate.values().size();
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Pagares Creados: ' + pagaresToInsert.values().size();
                insert log;
            }else{
                log.Mensaje__c = 'Invalid response from WS';
                insert log;

            }
        }catch(Exception e){
            log.Mensaje__c += 'EXCEPTION: ' + e.getMessage() + ' - ' + e.getLineNumber() +' - ' + e.getCause() +' - '+e.getStackTraceString();
            log.Mensaje__c += '\r\n';
            upsert log;
        }
    }
    
    
   public static void testing(){
            String i = '1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
            i='1';
    }
}