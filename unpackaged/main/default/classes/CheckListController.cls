public class CheckListController{
    public CheckListController(Check_List__c lista){
        Integer pct = 0;
        List<String> okList = new List<String>();
        Map<String, Schema.SObjectField> fieldsMap = Schema.SObjectType.Check_List__c.fields.getMap();
        for (Schema.SObjectField field : fieldsMap.values()){
            if(field.getDescribe().getType() == Schema.DisplayType.BOOLEAN){
                if(field.getDescribe().getName() != 'IsDeleted' && field.getDescribe().getName() != 'Seleccionartodo__c'
                  && field.getDescribe().getName() != 'SoloLectura__c'){
                    if(lista.get(field.getDescribe().getName()) == true){
                        okList.add(field.getDescribe().getName());
                    }
                }
            }
        }
        System.debug('ok->'+okList);
        RecordType p1 = [SELECT Id FROM RecordType WHERE Name = 'Planta 1'];
        RecordType p2 = [SELECT Id FROM RecordType WHERE Name = 'Planta 2'];
        RecordType p3 = [SELECT Id FROM RecordType WHERE Name = 'Planta 3'];
        if(lista.RecordTypeId == p1.Id){
            pct = validarPlanta1(okList);
        }
        if(lista.RecordTypeId == p2.Id){
            pct = validarPlanta2(okList);
        }
        if(lista.RecordTypeId == p3.Id){
            pct = validarPlanta3(okList);
        }
        System.debug('tipo->'+lista.RecordTypeId);
        lista.Completado__c = pct;
        if(pct > 91){
            lista.Estatus__c = 'Cerrado';
        }
        try{
            Inventario__c inv = [SELECT PorcentajeCheckList__c,Id FROM Inventario__c WHERE Id =: lista.Vivienda__c];
            inv.PorcentajeCheckList__c = pct;
            update inv;
        }catch(Exception e){
            System.debug('SE ESTÁ GUARDANDO DESDE EL WS --- ' + e.getMessage() +' ' + e.getLineNumber());
        }
    }
    private Integer validarPlanta1(List<String> okList){
        Integer pct = 0;
        Checklist1__c chs = Checklist1__c.getOrgDefaults();
        for(String d : okList){
            pct += Integer.valueOf(chs.get(d));
        }
        return pct;
    }
    private Integer validarPlanta2(List<String> okList){
        Integer pct = 0;
        Checklist2__c chs = Checklist2__c.getOrgDefaults();
        for(String d : okList){
            pct += Integer.valueOf(chs.get(d));
        }
        return pct;
    }
    private Integer validarPlanta3(List<String> okList){
        Integer pct = 0;
        Checklist3__c chs = Checklist3__c.getOrgDefaults();
        for(String d : okList){
            pct += Integer.valueOf(chs.get(d));
        }
        return pct;
    }
}