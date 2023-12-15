trigger NewCall on Task (before Insert, before Update) {
    try{
        List<Task> listTaskU = new List<Task>();
        Set<Id> setTasks = new set<Id>();
        for(Task t : trigger.new){
            setTasks.add(t.whatId);
        }
        List<Inventario__c> listViviendas = [SELECT Id,Cuenta__c FROM Inventario__c WHERE Cuenta__c IN :setTasks];
        system.debug(listViviendas.size());
        for(Task t : trigger.new){
            integer count=0;
            Id inventario = null;
            for(Inventario__c inv : listViviendas){
                if(inv.Cuenta__c == t.whatId){
                    inventario = inv.Id;
                    count++;
                    if(count>1)
                        break;
                }
            }
            if(count==1){
                t.Vivienda__c = inventario;
                listTaskU.add(t);
            }
        }
    }catch(Exception e){
        system.debug('Cliente con multiples viviendas');
    }   
}