public with sharing class DireccionesTriggerHandler extends TriggerHandler{
    private Map<Id, Direcciones__c> newMap;
    private Map<Id, Direcciones__c> oldMap;
    private List<Direcciones__c> newList;
    private List<Direcciones__c> oldList;

    private final String template = 'ya existe una dirección del tipo "{0}".';
    private final String addressTemplate = 'CALLE {0} #{1}, COLONIA {2} CP: {3}, {4} {5}, {6}';
    private final String OFFICE_ADDRESS = 'Dirección Laboral';
    
    public DireccionesTriggerHandler() {
        this.newMap = (Map<Id, Direcciones__c>) trigger.newMap;
        this.oldMap = (Map<Id, Direcciones__c>) trigger.oldMap;
        this.newList = (List<Direcciones__c>) trigger.new;
        this.oldList = (List<Direcciones__c>) trigger.old;

    }

    public override void beforeInsert(){
        PreventDuplicateAddress(this.newList);
        // checkAddressCategory(this.newList);
    }

    public override void afterInsert(){
        Set<Id> officeAddressSet = new Set<Id>();
        for(Direcciones__c address : this.newList){

            if(address.Tipo__c == OFFICE_ADDRESS){
                officeAddressSet.add(
                    address.Id
                );
            }
        }

        if(!officeAddressSet.isEmpty()){
            updateContractOfficeAddress(officeAddressSet);
        }
    }

    public override void beforeUpdate(){
        List<Direcciones__c> addressList = new List<Direcciones__c>();

        for(Direcciones__c address : this.newList){
            if(oldMap.get(address.Id).Tipo__c != address.Tipo__c){
                addressList.add(address);
            }
        }

        // if(!addressList.IsEmpty()){
        //     checkAddressCategory(addressList);
        // }
    }

    public override void afterUpdate (){
        Set<Id> officeAddressSet = new Set<Id>();

        for(Direcciones__c address : this.newList){
            if(address.Tipo__c == OFFICE_ADDRESS){
                officeAddressSet.add(address.Id);
            }
        }

        if(!officeAddressSet.isEmpty()){
            updateContractOfficeAddress(officeAddressSet);
        }
    }

 /*   public void checkAddressCategory(List<Direcciones__c> addressList){
        Set<Id> contractIds = new Set<Id>();

        for(Direcciones__c address : addressList){
            if (address.Dictaminacion__c != null) {
                contractIds.add(address.Dictaminacion__c);
            }
        }

        if (contractIds.size() > 0) {
            List<Direcciones__c> registeredAddressList = [
                SELECT Id, Tipo__c, Dictaminacion__c, contrato__c
                FROM Direcciones__c 
                WHERE Dictaminacion__c IN: contractIds];

            Map<Id, Set<String>> addressCategoryByContractIds = new Map<Id,Set<String>>();
            Set<String> addressCategory;

            for(Direcciones__c address : registeredAddressList){
                addressCategory = addressCategoryByContractIds.get(address.Dictaminacion__c);

                if(addressCategory == null){
                    addressCategory = new Set<String>();
                    addressCategoryByContractIds.put(address.Dictaminacion__c, addressCategory);
                }

                addressCategory.add(address.Tipo__c);
            }

            Id contractId;
            for(Direcciones__c address : addressList){
                contractId = address.Dictaminacion__c;
                addressCategory = addressCategoryByContractIds.get(contractId);

                if(addressCategory != null && addressCategory.contains(address.Tipo__c)){

                    address.addError(
                        String.format(
                            this.template, 
                            new List<Object>{address.Tipo__c}
                            )
                        );
                }
            }
        }
    } */

    public void updateContractOfficeAddress(set<Id> officeAddressSet){
        List<Direcciones__c> addressList = [
            SELECT Id, Colonia__r.Name, 
                Calle__c, Numero_Exterior__c, Contrato__c, Dictaminacion__c,
                Codigo_Postal__r.Name, Estado__r.Name, Municipio__r.Name,
                pais__r.Name
            FROM Direcciones__c 
            WHERE Id IN : officeAddressSet];

        List<Dictaminacion__c> contractList = new List<Dictaminacion__c>();

        for(Direcciones__c address : addressList){
            if(address.Dictaminacion__c != null){
                contractList.add( new Dictaminacion__c( Id = address.Dictaminacion__c, ValidationBypassDateTime__c = DateTime.Now(), Direccion_Empresa__c = String.format( this.addressTemplate, 
                        new List<Object>{address.Calle__c,address.Numero_Exterior__c, address.Colonia__r.Name,address.Codigo_Postal__r.Name,address.Municipio__r.Name, address.Estado__r.Name,address.pais__r.Name
                                }
                            )
                    )
                );
            }
        }
 if(!contractList.isEmpty()){
            update contractList;
        }
    }
   
    public void PreventDuplicateAddress (List<Direcciones__c> addressList) {
        // Gather all account IDs from the new addresses
        Set<Id> accountIds = new Set<Id>();
        for (Direcciones__c address : addressList) {
            if (address.Account__c!=null) {
                accountIds.add(address.Account__c);
            }
        }
        if (accountIds.size()>0) {

            // Query existing addresses for the same account IDs
            Map<String, Direcciones__c> existingAddressesMap = new Map<String, Direcciones__c>();
            for (Direcciones__c existingAddress : [SELECT Id, Tipo__c, Account__c FROM Direcciones__c WHERE Account__c IN :accountIds]) {
                if (!existingAddressesMap.containsKey(existingAddress.Account__c +'|'+ existingAddress.Tipo__c )) {
                    existingAddressesMap.put(existingAddress.Account__c+'|'+ existingAddress.Tipo__c, existingAddress);
                }
            }
            system.debug('existingAddressesMap: '+existingAddressesMap);
            if (existingAddressesMap.size()>0) {       
                // Iterate over the new addresses and check for duplicates
                for (Direcciones__c newAddress : addressList) {
                    if (existingAddressesMap.containsKey(newAddress.Account__c +'|'+ newAddress.Tipo__c)) {
                        newAddress.addError('Ya existe una dirección del mismo tipo para esta Cuenta.');
                    }
                }
            }
        }
    }   
}