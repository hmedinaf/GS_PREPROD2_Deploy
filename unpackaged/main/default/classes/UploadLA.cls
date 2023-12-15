global class UploadLA implements Database.Batchable<sobject> {
        global Database.QueryLocator start(Database.BatchableContext bc)
        {
            string query = 'SELECT Id, Correlect_cta__c, CorreoElectronico__c FROM Account where CorreoElectronico__c!=null AND JMC_Carga_inicial__c=true';
            return Database.getQueryLocator(query); 
        }
        global void execute(Database.BatchableContext BC, list<Account> scope)
        {
            Set<String> emailsExist = new Set<String>();
            map<String, Lead> mLead = new map<String, Lead>();
            for(Account act : scope){
                emailsExist.add(act.CorreoElectronico__c);
            }
            Lead[] arrLeads = [SELECT Id, Email, IsConverted FROM Lead WHERE Email in : emailsExist AND IsConverted = false and JCM_Carga_inicial__c= true];
            for(Lead l : arrLeads){
                mLead.put(l.email, l);
            }
            
			
    		list<Database.LeadConvert> leadConverts = new list<Database.LeadConvert>();
            for(Account a : scope){
                if(mLead.get(a.CorreoElectronico__c)!=null){
                    Database.LeadConvert lc = new Database.LeadConvert();
                    lc.setLeadId(mLead.get(a.CorreoElectronico__c).Id);
                    lc.setConvertedStatus('Envío MAS Comercial');
                    lc.setAccountId(a.Id); 
                    leadConverts.add(lc);
                } 
            }
            
            if(!Test.isRunningTest()){
                Database.LeadConvertResult[] lcrList = Database.convertLead(leadConverts, false);
            }
        }
        global void finish(Database.BatchableContext BC)
        {
			System.debug('Terminando lote '+BC);
        } 
}