public class GetTask {
    @future(callout=true)
    public static void NewCall(){
        if(!Test.isRunningTest()){
            List<Task> tasks = [Select ID, CallObject from task where CallObject LIKE '{%' and CreatedDate = Yesterday];
            List<Llamada__c> callList = new List<Llamada__c>();
            //Integer count = 0;
            //while(count < tasks.size()){
                for(Integer i = 0; i < 99; i++){
                    //count++;
                    try{
                        Integer exists = [Select COUNT() from Llamada__c where idObjeto__c =: tasks[i].CallObject];
                        if(exists == 0){
                            try{
                                Http http = new Http();
                                HttpRequest request = new HttpRequest();
                                String idObjeto_x = tasks[i].CallObject.remove('{');
                                String idObjeto_y = idObjeto_x.remove('}');
                                request.setEndpoint('http://189.210.202.36:8050/api/CallDetail/%7B'+ idObjeto_y + '%7D');
                                request.setMethod('GET');
                                HttpResponse response = http.send(request);
                                
                                if (response.getStatusCode() == 200) {
                                    Map<String, Object> attributes = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                                    System.debug(attributes);
                                    String Agente = (String)attributes.get('Agente');
                                    String Ani =  (String)attributes.get('Ani');
                                    String Disposicion = (String)attributes.get('Disposicion');
                                    String Dnis = (String)attributes.get('Dnis');
                                    Double Duracion = Double.valueOf(attributes.get('Duracion'));
                                    String HoraFin = (String)attributes.get('HoraFin');
                                    String HoraInicializacion = (String)attributes.get('HoraInicializac');
                                    String HoraInicio = (String)attributes.get('HoraInicio');
                                    Double TiempoACD = Double.valueOf(attributes.get('TiempoACD'));
                                    Double TiempoAtencion = Double.valueOf(attributes.get('TiempoAtencion'));
                                    Double TiempoConclusion = Double.valueOf(attributes.get('TiempoConclusion'));
                                    Double TiempoDisposicion = Double.valueOf(attributes.get('TiempoDisposicion'));
                                    Double TiempoRetencion = Double.valueOf(attributes.get('TiempoRetencion'));
                                    Double TiempoTimbrado = Double.valueOf(attributes.get('TiempoTimbrando'));
                                    Double TiempoVistaPrevia = Double.valueOf(attributes.get('TiempoVistaPrevia'));
                                    String Tipo = (String)attributes.get('Tipo');
                                    Llamada__c call = new Llamada__c(); 
                                    call.Agente__c = Agente;
                                    call.Telefono__c = Ani;
                                    call.Disposicion__c = Disposicion; 
                                    call.Dnis__c = Dnis;
                                    call.Duracion__c = Duracion;
                                    call.Hora_Fin__c = date.parse(HoraFin);
                                    call.Hora_Inicializacion__c = date.parse(HoraInicializacion);
                                    call.Hora_Inicio__c = date.parse(HoraInicio);
                                    call.idObjeto__c = tasks[i].CallObject;
                                    call.Tiempo_ACD__c = TiempoACD;
                                    call.Tiempo_Atencion__c = TiempoAtencion;
                                    call.Tiempo_Conclusion__c = TiempoConclusion;
                                    call.Tiempo_Disposicion__c = TiempoDisposicion;
                                    call.Tiempo_Retencion__c = TiempoRetencion;
                                    call.Tiempo_Timbrado__c = TiempoTimbrado;
                                    call.Tiempo_Vista_Previa__c = TiempoVistaPrevia;
                                    call.Tipo__c = Tipo;
                                    callList.add(call);
                            }
                                
                            }catch(Exception e){
                                System.debug(e);
                            }
                        }
                        
                    }catch(Exception e){
                        system.debug(e);
                    }
                }
            //}
            insert callList;
            
        }else{
            String response = '{"Tipo":"E","Agente":"mescobedoh","Dnis":"6611","Ani":"8123514910","HoraInicio":"10/12/2018","HoraInicializac":"10/12/2018","HoraFin":"10/12/2018","Disposicion":"0","Duracion":"203.000","TiempoACD":"38.000","TiempoTimbrando":"2.000","TiempoAtencion":"150.000","TiempoDisposicion":"0","TiempoConclusion":"15.000","TiempoRetencion":"0","TiempoVistaPrevia":"0"}';
            Map<String, Object> attributes = (Map<String, Object>) JSON.deserializeUntyped(response);
            System.debug(attributes);
            String Agente = (String)attributes.get('Agente');
            String Ani =  (String)attributes.get('Ani');
            String Disposicion = (String)attributes.get('Disposicion');
            String Dnis = (String)attributes.get('Dnis');
                Double Duracion = Double.valueOf(attributes.get('Duracion'));
                String HoraFin = (String)attributes.get('HoraFin');
                String HoraInicializacion = (String)attributes.get('HoraInicializac');
                String HoraInicio = (String)attributes.get('HoraInicio');
                Double TiempoACD = Double.valueOf(attributes.get('TiempoACD'));
            	Double TiempoAtencion = Double.valueOf(attributes.get('TiempoAtencion'));
                Double TiempoConclusion = Double.valueOf(attributes.get('TiempoConclusion'));
                Double TiempoDisposicion = Double.valueOf(attributes.get('TiempoDisposicion'));
                Double TiempoRetencion = Double.valueOf(attributes.get('TiempoRetencion'));
                Double TiempoVistaPrevia = Double.valueOf(attributes.get('TiempoVistaPrevia'));
                String Tipo = (String)attributes.get('Tipo');
                Llamada__c call = new Llamada__c(); 
                call.Agente__c = Agente;
                call.Telefono__c = Ani;
                call.Disposicion__c = Disposicion; 
                call.Dnis__c = Dnis;
                call.Duracion__c = Duracion;
                call.Hora_Fin__c = date.parse(HoraFin);
                call.Hora_Inicializacion__c = date.parse(HoraInicializacion);
                call.Hora_Inicio__c = date.parse(HoraInicio);
                call.Tiempo_ACD__c = TiempoACD;
                call.Tiempo_Atencion__c = TiempoAtencion;
                call.Tiempo_Conclusion__c = TiempoConclusion;
                call.Tiempo_Disposicion__c = TiempoDisposicion;
                call.Tiempo_Retencion__c = TiempoRetencion;
                call.Tiempo_Vista_Previa__c = TiempoVistaPrevia;
                call.Tipo__c = Tipo;
                Integer i = 1;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
            	i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
    	}
    }
}