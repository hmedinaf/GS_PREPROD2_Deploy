public class CheckListReportController {
    public Check_List__c cl {get;set;}
    public User prop {get;set;}
    public Inventario__c viv {get;set;}
    public Boolean isPlanta2 {get;set;}
    public Boolean isPlanta3 {get;set;}
    public CheckListReportController(){
        String idData = Apexpages.currentPage().getparameters().get('id');
        String query = 'SELECT '+ fieldNames() + ' FROM Check_List__c WHERE Id = \''+ idData +'\'';
        List<Check_List__c> checklist;
        try {
            checklist = database.query(query);
        } catch (QueryException e){
            //perform exception handling
        }
        if(!checklist.isEmpty()){
            cl = checklist.get(0);
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'La CheckList no se encuentra'));
        }
        prop = [SELECT Name FROM User WHERE Id =: cl.OwnerId];
        viv = [SELECT NumeroInterior__c FROM Inventario__c WHERE Id =: cl.Vivienda__c];
        RecordType p2 = [SELECT Id FROM RecordType WHERE Name = 'Planta 2'];
        RecordType p3 = [SELECT Id FROM RecordType WHERE Name = 'Planta 3'];
        isPlanta2 = false;
        isPlanta3 = false;
        if(cl.RecordTypeId == p2.Id){
            isPlanta2 = true;
        }
        if(cl.RecordTypeId == p3.Id){
            isPlanta2 = true;
            isPlanta3 = true;
        }
        System.debug('data cargada');
    }
    private String fieldNames(){
        String names = '';
        Map<String, Schema.SObjectField> fieldsMap = Schema.SObjectType.Check_List__c.fields.getMap();
        for (Schema.SObjectField field : fieldsMap.values()){
            names += field.getDescribe().getName() + ',';
        }
        if (names.subString(names.Length()-1,names.Length()) == ','){
            names = names.subString(0,names.Length()-1);
        }
        return names;
    }
}