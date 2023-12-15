@isTest
public class JaverClass_Test {
    
    @testSetup
    Public static void Setup(){
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.parse('11/09/1991');
        acc.Phone = '+528119928819';
        acc.TelefonoOtro__c = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c= f.Id;
        insert acc;
        
    }
    
    @isTest
    public static void test_logOut(){
        JaverClass.logout();
    }
    
    @isTest 
    public static void test_updateFraccAsessor(){
        Account acc = [Select Id From Account Limit 1];
        Fraccionamiento__c frac = [Select id, Name From Fraccionamiento__c Limit 1];
        Historial_Asignacion__c h = new  Historial_Asignacion__c();
        h.Fraccionamiento__c = frac.id;
        h.Asesor__c = UserInfo.getUserId();
        h.Cuenta__c= acc.id;
        insert h; 
        
        try{
            JaverClass.updateFraccAsessor(acc.Id, frac.Name); 
        }
        catch(Exception e){
            System.debug('Exception'+ e);
        }
        
    }
    
    @isTest 
    public static void test_updateFraccAsessorException(){
        Account acc = [Select Id From Account Limit 1];
        Fraccionamiento__c frac = [Select id, Name From Fraccionamiento__c Limit 1];
        try{
            JaverClass.updateFraccAsessor(acc.Id, frac.Name); 
        }
        catch(Exception e){
            System.debug('Exception'+ e);
        }
        
    }
}