trigger EncuestaTrigger on Encuesta__c (before insert, before update) {
    EncuestaConfig__c en = EncuestaConfig__c.getOrgDefaults();
    system.debug('en '+en);
    List<String> blacklist = new List<String>{
        'CreatedById','Name','OwnerId','LastModifiedById', 'Resultado__c'
            };
                List<String> okList = new List<String>();
    Map<String, Schema.SObjectField> fieldsMap = Schema.SObjectType.Encuesta__c.fields.getMap();
    for(Encuesta__c e :trigger.new){
        Double porcentaje = 0;
        for (Schema.SObjectField field : fieldsMap.values()){
            if(field.getDescribe().getType() == Schema.DisplayType.BOOLEAN){
                if(!blacklist.contains(field.getDescribe().getName())){
                    if(e.get(field.getDescribe().getName()) == true){
                        porcentaje += (Double)en.get(field.getDescribe().getName());
                    }
                }
            }else if(field.getDescribe().getType() == Schema.DisplayType.PICKLIST){
                if(!blacklist.contains(field.getDescribe().getName())){
                    if(e.get(field.getDescribe().getName()) != null && e.get(field.getDescribe().getName()) != ''){
                        porcentaje += (Double)en.get(field.getDescribe().getName());
                    }
                }
            }
        }
        e.Resultado__c = porcentaje;
    }
}