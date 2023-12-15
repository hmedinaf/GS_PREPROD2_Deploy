public without sharing class RegistrationPage {
    @AuraEnabled 
    Public static string createAccRecord(Account prospect,String FName, String Division,String LastName,String MName,date Bdate,String NSS,String telTrabajo,string credit,string Email,string telephCasa,string telephCel,string telephOtro,Boolean checkAp){ 
        Id redtId = [Select Id,developername, Name from recordtype where developername = 'Prospecto_Persona_Fisica' LIMIT 1].Id;
        list<Fraccionamiento__c> f = [Select Id,Name From Fraccionamiento__c where Name =:Division];
        string fId;
        if(f != null && f.size()> 0){
            fId = f[0].id;
        }
        Account acc = new Account();
        Id userId =  UserInfo.getUserId();
        User u =[Select ID, name, Profile.Name from user Where Id =: userId];
        string msg = '';
        try{
            acc.firstName = FName.toUppercase();
            acc.Apellidopaterno_cta__c = LastName.toUppercase();
            acc.Fraccionamiento_cta__c = fId;
            acc.LastName = LastName.toUppercase();
            acc.Apellidomaterno_cta__c = MName.toUppercase();
            acc.FechaNacimiento__c = Bdate;
            acc.NSS__c = NSS;
            acc.Check_Apellido__c = checkAp;
            if(prospect.Zona__c != null && prospect.Zona__c != ''){
                acc.Zona__c =  prospect.Zona__c.toUppercase();
            }
            acc.Tipo__c =  'Prospecto';
            acc.Sexo__c =  prospect.Sexo__c;
            acc.Canal_de_Venta__c =  prospect.Canal_de_Venta__c;
            acc.Sub_canal_de_venta__c =  prospect.Sub_canal_de_venta__c;
            if(prospect.BillingColony__c != null && prospect.BillingColony__c != ''){
                acc.BillingColony__c =  prospect.BillingColony__c.toUppercase();
            }
            if(prospect.BillingCity != null && prospect.BillingCity != ''){
                acc.BillingCity =  prospect.BillingCity.toUppercase();
            }
            if(prospect.BillingState != null && prospect.BillingState != ''){
                acc.BillingState =  prospect.BillingState.toUppercase();
            }
            if(prospect.BillingCountry != null && prospect.BillingCountry != ''){
                acc.BillingCountry =  prospect.BillingCountry.toUppercase();
            }
            if(prospect.BillingStreet != null && prospect.BillingStreet != ''){
                acc.BillingStreet =  prospect.BillingStreet.toUppercase();
            }
            acc.Otro_Telefono__c = telephOtro;
            acc.Phone = telephCasa;
            acc.TelefonoCelular__c = telephCel;
            acc.NumeroExterior__c =  prospect.NumeroExterior__c;
            acc.NumeroInterior__c =  prospect.NumeroInterior__c;
            acc.CorreoElectronico__c =  Email;
            if(prospect.Empresa__c != null && prospect.Empresa__c != ''){
                acc.Empresa__c = prospect.Empresa__c.toUppercase();
            }
            if(prospect.Puesto__c != null && prospect.Puesto__c != ''){
                acc.Puesto__c = prospect.Puesto__c.toUppercase();
            }
            acc.Colonia_cta__c =  prospect.Colonia_cta__c;
            acc.TelefonoTrabajo__c = telTrabajo;
            acc.anios__c = prospect.anios__c;
            acc.Meses__c = prospect.Meses__c;
            acc.Estado_Civil__c = prospect.Estado_Civil__c;
            acc.Ingresos_Mensuales__c = prospect.Ingresos_Mensuales__c;
            acc.DependientesEconomicos__c = prospect.DependientesEconomicos__c;
            acc.Hijos__c = prospect.Hijos__c;
            acc.MANAGEAPPROVALS__Active__c =  'yes';
            acc.Tipo_Credito__c = credit;
            acc.RecordTypeId =  redtId;
            if(prospect.BillingPostalCode != null && prospect.BillingPostalCode != ''){
                acc.BillingPostalCode =  prospect.BillingPostalCode.toUppercase();
            }
            acc.Estatus_Cliente__c = 'ASIGNADO';
            acc.PersonBirthdate = prospect.FechaNacimiento__c;
            acc.Origen__c = 'ENLACE';
            string prosLabel = System.Label.Prospectator;
            string assesLabel = System.Label.Assessor;
            string collabLabel = System.Label.Collaborator;
            string profile = u.Profile.Name;
            if(profile == prosLabel){   
                acc.Estatus_Prospectador__c = 'ASIGNADO';
                acc.Estatus_Asesor__c = 'POR ASIGNAR';
                acc.Prospectador__c = UserInfo.getUserId();
                acc.Fecha_Prospeccion__c = System.today();
            }
            if(profile == assesLabel){ 
                acc.Estatus_Prospectador__c = 'ASIGNADO';
                acc.Estatus_Asesor__c = 'ASIGNADO';
                acc.Asesor__c = UserInfo.getUserId();
                //     acc.Fecha_Prospeccion__c = System.today();
                acc.FechaAsignacion__c  = System.today();
            }
            if(profile == collabLabel){
                acc.Estatus_Colaborador_Javer__c = 'ASIGNADO';
                acc.Estatus_Asesor__c = 'POR ASIGNAR';
                acc.Colaborador_Javer__c = UserInfo.getUserId();
                acc.Fecha_Colaborador_Javer__c = system.today();
                //   acc.Fecha_Prospeccion__c = System.today();
                //   acc.FechaAsignacion__c  = System.today();
            }
            acc.Colonia_cta__c =  prospect.Colonia_cta__c;
            acc.MANAGEAPPROVALS__Active__c =  'yes';
            acc.RecordTypeId =  redtId;
            insert acc;
            system.debug('acc'+acc);
            msg = acc.id;
        }
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            system.debug('msg='+msg);
            throw new AuraHandledException(msg);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        
        return msg;
    } 
    @AuraEnabled 
    Public static String updateAccRecord(Account prospect, String prosId){
        String msg = '';
        try{
            prospect.Id = prosId;          
            prospect.Tipo_de_Direccion__c = 'Dirección Principal';
            if(prospect.Zona__c != null && prospect.Zona__c != ''){
                prospect.Zona__c =  prospect.Zona__c.toUppercase();
            }
            if(prospect.BillingColony__c != null && prospect.BillingColony__c != ''){
                prospect.BillingColony__c =  prospect.BillingColony__c.toUppercase();
            }
            if(prospect.BillingCity != null && prospect.BillingCity != ''){
                prospect.BillingCity =  prospect.BillingCity.toUppercase();
            }
            if(prospect.BillingState != null && prospect.BillingState != ''){
                prospect.BillingState =  prospect.BillingState.toUppercase();
            }
            if(prospect.BillingCountry != null && prospect.BillingCountry != ''){
                prospect.BillingCountry =  prospect.BillingCountry.toUppercase();
            }
            if(prospect.BillingStreet != null && prospect.BillingStreet != ''){
                prospect.BillingStreet =  prospect.BillingStreet.toUppercase();
            }
            if(prospect.Empresa__c != null && prospect.Empresa__c != ''){
                prospect.Empresa__c = prospect.Empresa__c.toUppercase();
            }
            if(prospect.Puesto__c != null && prospect.Puesto__c != ''){
                prospect.Puesto__c = prospect.Puesto__c.toUppercase();
            }
            if(prospect.BillingPostalCode != null && prospect.BillingPostalCode != ''){
                prospect.BillingPostalCode =  prospect.BillingPostalCode.toUppercase();
            }
            upsert prospect;
        }
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            throw new AuraHandledException(msg);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        return null;
    } 
    @AuraEnabled 
    Public static void createPrivacyRecord(Boolean loginPrivacy, String msg){
        Privacy__c p = new Privacy__c();
        if(loginPrivacy == true ){
            p.Privacy_Message__c = 'Aviso de Empresa';
            p.Privacy_Notice__c = msg;
        }
        else if(loginPrivacy == false ){
            p.Privacy_Message__c = 'Aviso de Inicio';
            p.Privacy_Notice__c = msg;
        }
        p.User__c =UserInfo.getUserId();
        p.Timestamp_of_User_Acceptance__c = system.now();
        insert p;
    }
    
    @AuraEnabled 
    Public static  wrap PrivacyRecord(Boolean msgType, String fraccId){
        wrap wr = new wrap();
        wr.UserId = UserInfo.getUserId();
        String Loginmsg = '';  String Prospectmsg = '';
        Date todayDate = Date.today(); 
        Integer d = Date.today().day(); Integer y = todayDate.year(); Integer m = todayDate.month(); DateTime dt = DateTime.newInstance(y,m,d); string tMonth = dt.format('MMMM');
        String tDate = tMonth+' ' +d;
        Id userId =  UserInfo.getUserId();
        String pId = '';
        List <Privacy_Notice__c> pnList = new List <Privacy_Notice__c>();
        if(msgType == false){
            for(Privacy_Notice__c pn : [Select Id, Name, Account__c,Active__c,Notice_Text__c,Type__c from Privacy_Notice__c Where Active__c = true AND Type__c = 'Aviso de Inicio' LIMIT 1]){
                if(pn.Notice_Text__c != null && pn.Notice_Text__c.contains('||TODAY||')){
                    Loginmsg = pn.Notice_Text__c.replace('||TODAY||',tDate);
                }
                else if(pn.Notice_Text__c != null && !pn.Notice_Text__c.contains('||TODAY||')){
                    Loginmsg = pn.Notice_Text__c;
                }
                else if(pn.Notice_Text__c == null){
                    Loginmsg = 'Privacy Notice Not Found';
                }
            }
            wr.loginPMsg = Loginmsg;
        }
        else{
            if(fraccId != null){
                List<Fraccionamiento__c> fracList = [Select Id, Name, Compania_Asociada__c, Compania_Asociada__r.Aviso_de_Privadidad_Relacionado2__c from Fraccionamiento__c Where Id =: fraccId OR Name =: fraccId];
                if(fracList != null && fracList.size() > 0){
                    Fraccionamiento__c fracc = fracList[0];
                    if(fracc != null && fracc.Compania_Asociada__c != null && fracc.Compania_Asociada__r.Aviso_de_Privadidad_Relacionado2__c != null){
                        pId = fracc.Compania_Asociada__r.Aviso_de_Privadidad_Relacionado2__c;
                        for(Privacy_Notice__c pn : [Select Id, Name, Account__c,Active__c,Notice_Text__c,Type__c from Privacy_Notice__c Where Id =: pId]){
                            if(pn.Notice_Text__c != null && pn.Notice_Text__c.contains('||TODAY||')){
                                Prospectmsg = pn.Notice_Text__c.replace('||TODAY||',tDate);
                            }
                            else if(pn.Notice_Text__c != null && !pn.Notice_Text__c.contains('||TODAY||')){
                                Prospectmsg = pn.Notice_Text__c;
                            }
                        }
                        wr.Prospectmsg = Prospectmsg;
                    }
                }
            }
            else{
                wr.Prospectmsg = 'Privacy Notice Not Found';
            }
        }
        return  wr;
    }
    @AuraEnabled
    public static List<Account> SeachProsRecords(String FName,String LName, String Division,String LastName,String MName,String Bdate,String NSS){
        list<Account> acclist = new list <Account>();
        User u = [select id,Name,Profile.Name,Fraccionamientos__c from User where id =: userInfo.getUserId()];
        string query = 'Select Id,Name,Nombre__c,Prospectador__c,RecordTypeName__c,PersonMobilePhone,Fraccionamiento_cta__c,FechaNacimiento__c,Estatus_Colaborador_Javer__c,Tipo_de_Direccion__c,BillingColony__c,Asesor__c,Estatus_Asesor__c,Apellidopaterno_cta__c,Apellidomaterno_cta__c,Estatus_Prospectador__c,Fraccionamiento_cta__r.Name ,RecordType.Name from Account where CreatedDate != null';
        
        if(FName != null && FName != ''){
            FName = FName.trim();
            query += ' AND FirstName = \''+ FName.trim()+'\'';  
        }
        if(LastName != null && LastName != '' && LastName != 'undefined'){
            LastName = LastName.trim();
            query += ' AND( Apellidopaterno_cta__c = \''+ LastName.trim()+'\' OR LastName = \''+ LastName.trim()+'\')'; 
        }
        if(MName != null && MName != ''){
            MName = MName.trim();
            query += ' AND Apellidomaterno_cta__c = \''+MName.trim()+'\''; 
        }
      /*  if(Division != null && Division != '' && Division != 'None'){
            List<Fraccionamiento__c> f = [Select Id,Name From Fraccionamiento__c where Name =:Division];
            query += ' AND Fraccionamiento_cta__c = \''+ f[0].Id+'\''; 
        } */
        if(Bdate != null && Bdate != ''){
            query += ' AND ( FechaNacimiento__c = '+ Bdate;
            query += ' OR PersonBirthdate = '+ Bdate+')';
        }
        if(NSS != null && NSS != '' && NSS != 'undefined'){
            query += ' AND NSS__c = \''+ NSS+'\'';  
        }
        acclist = Database.query(query);
        return acclist;
    }
     @AuraEnabled 
    public static void logoutFromSite(){
       JaverClass.logout();
    }
    public class wrap{
        @AuraEnabled public String loginPMsg ;	
        @AuraEnabled public String prospectMsg;
        @AuraEnabled public String UserId;
    }
}