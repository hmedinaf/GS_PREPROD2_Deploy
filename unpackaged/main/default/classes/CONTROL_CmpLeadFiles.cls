public class CONTROL_CmpLeadFiles {
    
    @AuraEnabled  
    public static List<ContentDocument> getFiles(String recordId){ 
        
        Set<Id> recordIds = new Set<Id>{recordId};
        List<ContentDocumentLink> cdlList = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN :recordIds];                         
        
        Set<Id> documentIds = new Set<Id>(); 
        for(ContentDocumentLink cdl : cdlList){  
            documentIds.add(cdl.ContentDocumentId);  
        }    
        return [SELECT Id, Title, FileType, ContentSize, CreatedDate, FileExtension FROM ContentDocument WHERE Id IN :documentIds];        
    } 
    
    @AuraEnabled  
    public static void deleteFile(String contentDocumentId, String title, String recordId){ 

        try{
            
            delete [SELECT Id FROM ContentDocument WHERE Id = :contentDocumentId];
            
            Id auxRecordId = Id.valueOf(recordId);
            System.debug('*****recordId.getSObjectType():' + auxRecordId.getSObjectType());
            
            /*if(auxRecordId.getSObjectType() == Schema.Lead.SObjectType){
            
                Lead prospecto = [SELECT Id, File_Credit_Report__c, File_Ine_Passport__c, File_Curp__c, File_Proof_Address__c, File_Settlement_Offer__c, File_Payment_Authorization__c, File_Kyc__c FROM Lead WHERE Id =: recordId];
                if(title.toUpperCase().contains('CREDIT')){
                    prospecto.File_Credit_Report__c = false;
                }
                else if(title.toUpperCase().contains('INE')){
                    prospecto.File_Ine_Passport__c = false;
                }
                else if(title.toUpperCase().contains('CURP')){
                    prospecto.File_Curp__c = false;
                }
                else if(title.toUpperCase().contains('PROOF')){
                    prospecto.File_Proof_Address__c = false;
                }
                else if(title.toUpperCase().contains('SETTLEMENT')){
                    prospecto.File_Settlement_Offer__c = false;
                }
                else if(title.toUpperCase().contains('PAYMENT')){
                    prospecto.File_Payment_Authorization__c = false;
                }
                else if(title.toUpperCase().contains('KYC')){
                    prospecto.File_Kyc__c = false;
                }

                try{
                    update prospecto;
                }
                catch(Exception e){
                    System.debug('Exception has occurred updating lead '+ recordId + ': ' + e.getMessage());
                }
            }
            else if(auxRecordId.getSObjectType() == Schema.Account.SObjectType){
            
                Account cliente = [SELECT Id, File_Credit_Report__c, File_Ine_Passport__c, File_Curp__c, File_Proof_Address__c, File_Settlement_Offer__c, File_Payment_Authorization__c, File_Kyc__c FROM Account WHERE Id =: recordId];
                if(title.toUpperCase().contains('CREDIT')){
                    cliente.File_Credit_Report__c = false;
                }
                else if(title.toUpperCase().contains('INE')){
                    cliente.File_Ine_Passport__c = false;
                }
                else if(title.toUpperCase().contains('CURP')){
                    cliente.File_Curp__c = false;
                }
                else if(title.toUpperCase().contains('PROOF')){
                    cliente.File_Proof_Address__c = false;
                }
                else if(title.toUpperCase().contains('SETTLEMENT')){
                    cliente.File_Settlement_Offer__c = false;
                }
                else if(title.toUpperCase().contains('PAYMENT')){
                    cliente.File_Payment_Authorization__c = false;
                }
                else if(title.toUpperCase().contains('KYC')){
                    cliente.File_Kyc__c = false;
                }

                try{
                    update cliente;
                }
                catch(Exception e){
                    System.debug('Exception has occurred updating account '+ recordId + ': ' + e.getMessage());
                }
            }*/
        }  
        catch(Exception e){
            System.debug('Exception has occurred deleting file '+ contentDocumentId + ', title:' + title + ', recordId:' + recordId + ': ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static ContentDocument UpdateFiles(String documentId, String title, String recordId){
        
        System.debug('title: ' + title);
        ContentDocument cd = [SELECT Id, Title, FileType, ContentSize, CreatedDate, FileExtension FROM ContentDocument WHERE Id =: documentId];
        
        cd.Title = title;
        try{
            update cd;

            Id auxRecordId = Id.valueOf(recordId);
            System.debug('*****recordId.getSObjectType():' + auxRecordId.getSObjectType());
            /*if(auxRecordId.getSObjectType() == Schema.Lead.SObjectType){
            
                Lead prospecto = [SELECT Id, File_Credit_Report__c, File_Ine_Passport__c, File_Curp__c, File_Proof_Address__c, File_Settlement_Offer__c, File_Payment_Authorization__c, File_Kyc__c FROM Lead WHERE Id =: recordId];
                
                if(title.toUpperCase().contains('CREDIT')){
                    prospecto.File_Credit_Report__c = true;
                }
                else if(title.toUpperCase().contains('INE')){
                    prospecto.File_Ine_Passport__c = true;
                }
                else if(title.toUpperCase().contains('CURP')){
                    prospecto.File_Curp__c = true;
                }
                else if(title.toUpperCase().contains('PROOF')){
                    prospecto.File_Proof_Address__c = true;
                }
                else if(title.toUpperCase().contains('SETTLEMENT')){
                    prospecto.File_Settlement_Offer__c = true;
                }
                else if(title.toUpperCase().contains('PAYMENT')){
                    prospecto.File_Payment_Authorization__c = true;
                }
                else if(title.toUpperCase().contains('KYC')){
                    prospecto.File_Kyc__c = true;
                }

                try{
                    update prospecto;
                }
                catch(DMLException e){
                    System.debug('Exception has occurred updating lead '+ recordId + ': ' + e.getMessage());
                }
            }
            else if(auxRecordId.getSObjectType() == Schema.Account.SObjectType){
            
                Account cliente = [SELECT Id, File_Credit_Report__c, File_Ine_Passport__c, File_Curp__c, File_Proof_Address__c, File_Settlement_Offer__c, File_Payment_Authorization__c, File_Kyc__c FROM Account WHERE Id =: recordId];
                
                if(title.toUpperCase().contains('CREDIT')){
                    cliente.File_Credit_Report__c = true;
                }
                else if(title.toUpperCase().contains('INE')){
                    cliente.File_Ine_Passport__c = true;
                }
                else if(title.toUpperCase().contains('CURP')){
                    cliente.File_Curp__c = true;
                }
                else if(title.toUpperCase().contains('PROOF')){
                    cliente.File_Proof_Address__c = true;
                }
                else if(title.toUpperCase().contains('SETTLEMENT')){
                    cliente.File_Settlement_Offer__c = true;
                }
                else if(title.toUpperCase().contains('PAYMENT')){
                    cliente.File_Payment_Authorization__c = true;
                }
                else if(title.toUpperCase().contains('KYC')){
                    cliente.File_Kyc__c = true;
                }

                try{
                    update cliente;
                }
                catch(DMLException e){
                    System.debug('Exception has occurred updating account '+ recordId + ': ' + e.getMessage());
                }
            }*/
        }
        catch(DMLException e){
            System.debug('Exception has occurred deleting file '+ documentId + ', title:' + title + ', recordId:' + recordId + ': ' + e.getMessage());
        }        

        return cd;
    }
}