/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Handler de AccountTrigger
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      24/02/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class AccountTriggerHandler extends TriggerHandler {
    
    public static Boolean isFirstTime = true;
    public static Boolean firstTimeFilter = true;
    
    private Map<Id, Account> newMap;
    private Map<Id, Account> oldMap;
    private List<Account> newList;
    private List<Account> oldList;
    
    public AccountTriggerHandler() {
        this.newMap = (Map<Id, Account>) trigger.newMap;
        this.oldMap = (Map<Id, Account>) trigger.oldMap;
        this.newList = (List<Account>) trigger.new;
        this.oldList = (List<Account>) trigger.old;
    }
    
    public override void beforeInsert() {
        validatePhonesInsert();
    }
    
    public override void beforeUpdate() {
        if((UserInfo.getFirstName() == 'ADMIN' && firstTimeFilter ) || Test.isRunningTest()){
            firstTimeFilter = false;
            validatePhones();
        }
    }
    public override void afterInsert() {
        CreateAccountshare();
    }
    
    public override void afterUpdate() {
        CreateAccountshare();
        // HMF 2023-07-11 Desactivado para procesar desasignaciones automaticas
        //updateEntregaSiebel();
    }
    public void CreateAccountshare(){
        List<AccountShare> asList = new List<AccountShare>();
        for (Account newAccount : newList){
            if(newAccount.Asesor__c != newAccount.OwnerId && ((oldMap != null && newAccount.Asesor__c != oldMap.get(newAccount.Id).Asesor__c &&
                                                               newAccount.Asesor__c != null) || (newAccount.Asesor__c != null && oldMap == null))){
                                                                   AccountShare ashare = new AccountShare();
                                                                   ashare.AccountId = newAccount.Id;
                                                                   ashare.AccountAccessLevel = 'Edit'; 
                                                                   ashare.UserOrGroupId = newAccount.Asesor__c;  
                                                                   ashare.OpportunityAccessLevel = 'read';
                                                                   asList.add(ashare);
                                                               }
            else if(newAccount.Prospectador__c != newAccount.OwnerId && ((oldMap != null && newAccount.Prospectador__c != oldMap.get(newAccount.Id).Prospectador__c &&
                                                                          newAccount.Prospectador__c != null) || (newAccount.Prospectador__c != null && oldMap == null))){
                                                                              AccountShare ashare = new AccountShare();
                                                                              ashare.AccountId = newAccount.Id;
                                                                              ashare.AccountAccessLevel = 'Edit';
                                                                              ashare.UserOrGroupId = newAccount.Prospectador__c; 
                                                                              ashare.OpportunityAccessLevel = 'read';
                                                                              asList.add(ashare);
                                                                          }
            /*else if(newAccount.Colaborador_Javer__c != newAccount.OwnerId && ((oldMap != null && newAccount.Colaborador_Javer__c != oldMap.get(newAccount.Id).Colaborador_Javer__c && newAccount.Colaborador_Javer__c != null) || (newAccount.Colaborador_Javer__c != null && oldMap == null))){
AccountShare ashare = new AccountShare();
ashare.AccountId = newAccount.Id;
ashare.AccountAccessLevel = 'Edit';
ashare.UserOrGroupId = newAccount.Colaborador_Javer__c; 
ashare.OpportunityAccessLevel = 'read';
asList.add(ashare);
}*/
        }
        insert asList; 
    }
    public void validatePhonesInsert(){
        for(Account newAccount : newList){
            /* COMENTADO POR CAPPTUS PORQUE CHOCABA CON REGLA DE VALIDACION SOLICITADA POR NEGOCIO
newAccount.Phone = newAccount.Phone != null && newAccount.Phone != '+52' && newAccount.Phone != '+' ? getFilteredPhoneWPrefix(newAccount.Phone) : '+52';
newAccount.TelefonoCelular__c = newAccount.TelefonoCelular__c != null && newAccount.TelefonoCelular__c != '+52' && newAccount.TelefonoCelular__c != '+' ? getFilteredPhoneWPrefix(newAccount.TelefonoCelular__c) : '+52';
newAccount.TelefonoOtro__c = newAccount.TelefonoOtro__c != null && newAccount.TelefonoOtro__c != '+52' && newAccount.TelefonoOtro__c != '+' ? getFilteredPhoneWPrefix(newAccount.TelefonoOtro__c) : '+52';
newAccount.Otro_Telefono__c = newAccount.Otro_Telefono__c != null && newAccount.Otro_Telefono__c != '+52' && newAccount.Otro_Telefono__c != '+' ? getFilteredPhoneWPrefix(newAccount.Otro_Telefono__c) : '+52';
*/
        }
    }
    
    public void validatePhones(){
        Map<Id, Account> mapCuentasATC = new Map<Id, Account>();
        for(Account newAccount : newList){
            if(newAccount.Phone != oldMap.get(newAccount.Id).Phone || newAccount.TelefonoCelular__c != oldMap.get(newAccount.Id).TelefonoCelular__c || 
               newAccount.TelefonoOtro__c != oldMap.get(newAccount.Id).TelefonoOtro__c || newAccount.Otro_Telefono__c != oldMap.get(newAccount.Id).Otro_Telefono__c){
                   mapCuentasATC.put(newAccount.Id, newAccount);
               }
        }
        
        if(!mapCuentasATC.isEmpty()){
            for(Account newAccount : mapCuentasATC.values()){
                //Entrega mas reciente
                newAccount.Phone = newAccount.Phone != null && newAccount.Phone != '+52' && newAccount.Phone != '+' ? getFilteredPhoneWPrefix(newAccount.Phone) : '+52';
                newAccount.TelefonoCelular__c = newAccount.TelefonoCelular__c != null && newAccount.TelefonoCelular__c != '+52' && newAccount.TelefonoCelular__c != '+' ? getFilteredPhoneWPrefix(newAccount.TelefonoCelular__c) : '+52';
                newAccount.TelefonoOtro__c = newAccount.TelefonoOtro__c != null && newAccount.TelefonoOtro__c != '+52' && newAccount.TelefonoOtro__c != '+' ? getFilteredPhoneWPrefix(newAccount.TelefonoOtro__c) : '+52';
                newAccount.Otro_Telefono__c = newAccount.Otro_Telefono__c != null && newAccount.Otro_Telefono__c != '+52' && newAccount.Otro_Telefono__c != '+' ? getFilteredPhoneWPrefix(newAccount.Otro_Telefono__c) : '+52';
            }
        }
    }
    
    /*  public void updateEntregaSiebel(){
if(!recursionCheck.entregasWS && isFirstTime && !System.isFuture() ){ //Previene updates desde MasComercial
Map<Id, Account> mapCuentasATC = new Map<Id, Account>();
List<RecordType> recordTypeList = [SELECT Id, Name FROM RecordType WHERE Name = 'Clientes ATC'];
Map<Id, RecordType> recordTypeMap = new Map<Id, RecordType>(recordTypeList);
isFirstTime = false;
for(Account newAccount : newList){
if(recordTypeMap.containsKey(newAccount.RecordTypeId) && newAccount.IdMasComercial__c != null && 
(newAccount.Phone != oldMap.get(newAccount.Id).Phone || newAccount.TelefonoCelular__c != oldMap.get(newAccount.Id).TelefonoCelular__c || 
newAccount.TelefonoOtro__c != oldMap.get(newAccount.Id).TelefonoOtro__c || newAccount.CorreoElectronico__c != oldMap.get(newAccount.Id).CorreoElectronico__c)){
mapCuentasATC.put(newAccount.Id, newAccount);
}
}

if(!mapCuentasATC.isEmpty()){
Map<Id, Entrega__c> mapCuentasEntregas = new Map<Id, Entrega__c>();
List<Entrega__c> entregas = [SELECT Id, Numero_Proceso__c, Cuenta__c FROM Entrega__c WHERE Cuenta__c IN: mapCuentasATC.keySet() ORDER BY CreatedDate DESC];   
for(Entrega__c entrega: entregas){ mapCuentasEntregas.put(entrega.Cuenta__c, entrega); }

for(Account newAccount : mapCuentasATC.values()){
if(mapCuentasEntregas.containsKey(newAccount.Id)){
//Entrega mas reciente
String numeroProceso = mapCuentasEntregas.get(newAccount.Id).Numero_Proceso__c != null ? mapCuentasEntregas.get(newAccount.Id).Numero_Proceso__c : null;
String fechaHabitibilidad = null; 
String estatus = null;
String fechaEntrega = null;
Long telefonoCasa = newAccount.Phone != null && newAccount.Phone != '+52' && newAccount.Phone != '+' ? getFilteredPhone(newAccount.Phone) : 0;
Long telefonoCelular = newAccount.TelefonoCelular__c != null && newAccount.TelefonoCelular__c != '+52' && newAccount.TelefonoCelular__c != '+' ? getFilteredPhone(newAccount.TelefonoCelular__c) : 0;
Long telefonoOtro = newAccount.TelefonoOtro__c != null && newAccount.TelefonoOtro__c != '+52' && newAccount.TelefonoOtro__c != '+' ? getFilteredPhone(newAccount.TelefonoOtro__c) : 0;
Decimal telefonoRecados = newAccount.TelefonoRecados__c != null ? newAccount.TelefonoRecados__c : null;
String correoElectronico = newAccount.CorreoElectronico__c != null ? newAccount.CorreoElectronico__c : null;
Long numeroCliente = null;

UpdateEntregaSiebel.sendData(numeroProceso, fechaHabitibilidad, estatus,
fechaEntrega, telefonoCasa, telefonoCelular,
telefonoOtro, telefonoRecados, correoElectronico, numeroCliente);
}
}
}
}
} */
    
    /* public Long getFilteredPhone(String phone){
Long filteredPhone = phone != null && String.valueOf(phone.Substring(3,phone.length()).replaceAll('[^0-9]', '')).length() == 10 ? Long.valueOf(phone.Substring(3,phone.length()).replaceAll('[^0-9]', '')) : null;
return filteredPhone; 
} */
    
    public String getFilteredPhoneWPrefix(String phone){
        System.debug(phone);
        if(!String.isBlank(phone) && phone.length() == 10 && phone.Substring(0,1) != '+' && phone.Substring(0,4) != '+521' && phone.Substring(0,2) != '52'){
            phone = '+52' + phone;
        }else if(!String.isBlank(phone) && phone.length() > 9){
            if(phone.Substring(0,2) == '52' || (phone.Substring(0,2) == '+1' && phone.length() == 12)){
                phone = '+52' + phone.Substring(2,phone.length());
            }else if(phone.Substring(0,1) == '1' && phone.length() ==  11){
                phone = '+52' + phone.Substring(1,phone.length());
            }else if(phone.Substring(0,3) == '521' && phone.length() ==  13){
                phone = '+52' + phone.Substring(3,phone.length());
            }else if(phone.Substring(0,3) == '+52' && phone.length() == 13){
            }else if(phone.Substring(0,4) == '+521' && phone.length() == 14){
                phone = '+52' + phone.Substring(4,phone.length());
            }else if(phone.length() == 11 && phone.Substring(0,1) == '+'){
                phone = '+52' + phone.Substring(1,phone.length());
            }else if(phone.length() == 10 && phone.Substring(0,1) != '+' && phone.Substring(0,4) != '+521' && phone.Substring(0,2) != '52' ){
                phone = '+52' + phone;
            }else{
                phone = '+52';
            }
        }else{
            phone = '+52';
        }
        System.debug(phone);
        return phone;
    }
}