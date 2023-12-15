public with sharing class CoAcreditadoTriggerHandler extends TriggerHandler{
    private Map<Id, Co_Acreditado__c> newMap;
    private Map<Id, Co_Acreditado__c> oldMap;
    private List<Co_Acreditado__c> newList;
    private List<Co_Acreditado__c> oldList;
    
    public CoAcreditadoTriggerHandler() {
        this.newMap = (Map<Id, Co_Acreditado__c>) trigger.newMap;
        this.oldMap = (Map<Id, Co_Acreditado__c>) trigger.oldMap;
        this.newList = (List<Co_Acreditado__c>) trigger.new;
        this.oldList = (List<Co_Acreditado__c>) trigger.old;
    }

    public override void beforeInsert(){
        updateCurp(this.newList);
    }

    public override void beforeUpdate(){
        updateCurp(this.newList);
    }

    private void updateCurp(List<Co_Acreditado__c> coAcreditadoList){
        CurpGenerator curpGenerator;
        Person person;
        for(Co_Acreditado__c ca : coAcreditadoList){
            if(validateData(ca)){
                person = new Person()
                    .setName(ca.Nombre__c)
                    .setLastName(ca.Apellido_Paterno_CO_Acreditado__c)
                    .setMotherMaidenName(ca.Apellido_Materno_CO_Acreditado__c)
                    .setGender(ca.Sexo__c)
                    .setBirthDate(ca.Fecha_de_Nacimiento_CO_Acreditado__c)
                    .setBirthPlace(ca.Lugar_de_nacimiento__c);
    
                curpGenerator = new CurpGenerator(person);
    
                ca.RFC_CO_Acreditado__c = curpGenerator.generateBaseRFC() + curpGenerator.generateHomoclave();
                ca.CURP__c = curpGenerator.generateCurp();
            }
        }
    }

    private Boolean validateData(Co_Acreditado__c ca){
        return ca.Nombre__c != null && 
        ca.Apellido_Paterno_CO_Acreditado__c != null && 
        ca.Apellido_Materno_CO_Acreditado__c != null &&
        ca.Sexo__c != null && ca.Fecha_de_Nacimiento_CO_Acreditado__c != null &&
        ca.Lugar_de_nacimiento__c != null;
    }

}