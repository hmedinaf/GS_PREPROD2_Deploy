public class CLASS_lookupOppValorPrevio {
    
    /* Logica */ 
    public static void executeBefore(List<Opportunity> listaOppNew, Map<Id,Opportunity> mapaOppOld){
        for(Opportunity oppNew : listaOppNew){
            // Asesor
            if(oppNew.Asesor__c != mapaOppOld.get(oppNew.Id).Asesor__c){
                
                oppNew.Valores_previos__c = mapaOppOld.get(oppNew.Id).Asesor__c;
            }
            // Prospectador
            if(oppNew.Prospectador__c != mapaOppOld.get(oppNew.Id).Prospectador__c){
                
                oppNew.Valores_previos__c = mapaOppOld.get(oppNew.Id).Prospectador__c;
            }
            // Lead Profiler
            else if(oppNew.Lead_Profiler__c != mapaOppOld.get(oppNew.Id).Lead_Profiler__c){
                
                oppNew.Valores_previos__c = mapaOppOld.get(oppNew.Id).Lead_Profiler__c;
            }
            // Colaborador Javer
            else if(oppNew.Colaborador_Javer__c != mapaOppOld.get(oppNew.Id).Colaborador_Javer__c){
                
                oppNew.Valores_previos__c = mapaOppOld.get(oppNew.Id).Colaborador_Javer__c;
            }
            
        }
    }
    public static void executeAfter(){
        Map<Id,Opportunity> mapaOpp = new Map<Id,Opportunity>();
        //Map<Id,Opportunity> mapaOppRelacionados = new Map<Id,Opportunity>();
        
        for(SObject so : Trigger.new){
            SObject before = Trigger.oldMap.get(so.Id);
            
            Opportunity oppNew = (Opportunity) so;
            Opportunity oppOld = (Opportunity) before;
            // Regresar campos a sus valores originales
            if(oppNew.Estado_de_aprobacion__c == 'Rechazado' && oppOld.Estado_de_aprobacion__c != 'Rechazado'){
                mapaOpp.put(oppNew.Id,oppOld);
                
            }
        }
        
        // Actualizar oportunidad 
        if(mapaOpp.size() > 0){
            crearOpp(mapaOpp);
        }
    }
    
    /* Crear oportunidad a actualizar (Rechazo de aprobación) */
    public static void crearOpp(Map<Id,Opportunity> mapaOpp){
        List<Opportunity> actualizarOpp = new List<Opportunity>();
        for(Opportunity opp : mapaOpp.values()){
            Opportunity opp2 = new Opportunity();
            opp2.Id = opp.Id;
            // Asesor = Proceso de aprobación "Cambia el Asesor en la oportunidad" (1)
            if(opp.Proceso_de_aprobaci_n__c == '1'){
                opp2.Asesor__c = opp.Valores_previos__c; 
            }
            // Prospectador = Proceso de aprobación "Aprobación prospectador" (2)
            else if(opp.Proceso_de_aprobaci_n__c == '2'){
                opp2.Prospectador__c = opp.Valores_previos__c;
            }
            // Lead Profiler = Proceso de aprobación "Aprobación lead profiler" (3)
            else if(opp.Proceso_de_aprobaci_n__c == '3'){
                opp2.Lead_Profiler__c = opp.Valores_previos__c;
            }
            // Colaborador Javer = Proceso de aprobación "Aprobación colaborador Javer" (4)
            else if(opp.Proceso_de_aprobaci_n__c == '4'){
                opp2.Colaborador_Javer__c = opp.Valores_previos__c;
            }
            actualizarOpp.add(opp2);
            
        }
        // Actualizar oportunidad
        System.debug('JG actualizarOpp.size(): '+actualizarOpp.size());
        if(actualizarOpp.size() > 0){
            Database.SaveResult [] updateResult = Database.update(actualizarOpp, false);
        }
    }
}