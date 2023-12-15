global with sharing class Javer_Util_Future {
        
    
  
  
  @Future(callout=true) 
  public static void limpia_aprob_siebel(Integer int_DiasAntiguedad) {
    Integer dias = 0- (int_DiasAntiguedad);
    //System.Debug('***limpia_aprob_siebel*** ');
    Date dtFechaLimite = system.today().addDays(dias);
    String nombreAdmin ='%Admin%';
    List<approvalObject__c> list_AprobObj = new List<approvalObject__c>([SELECT Id, Name, Estatus__c, CreatedDate  
                                                                        FROM approvalObject__c 
                                                                        WHERE 
                                                                        ( 
                                                                            CreatedDate < :dtFechaLimite
                                                                        )
                                                                         AND
                                                                         (
                                                                            FHR__c = null
                                                                         
                                                                          )
                                                                        ]
                                                                        );
    System.Debug('***list_AprobObj ***'+list_AprobObj);
    if ( !list_AprobObj.IsEmpty() ) {  try{ delete list_AprobObj; } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } } //catch
          
    }
    
  }
    
  @Future(callout=true) 
  public static void limpia_aprob_shpn(Integer int_DiasAntiguedad) {
    Integer dias = 0- (int_DiasAntiguedad);
    //System.Debug('***limpia_aprob_siebel*** ');
    Date dtFechaLimite = system.today().addDays(dias);
    String nombreAdmin ='%Admin%';
    List<SharePointObj__c> list_ShPnObj = new List<SharePointObj__c>([SELECT Id, Name, Estatus__c, CreatedDate  
                                                                        FROM SharePointObj__c 
                                                                        WHERE 
                                                                        ( 
                                                                            CreatedDate < :dtFechaLimite
                                                                        )
                                                                         AND
                                                                         (
                                                                            FHR__c = null
                                                                         
                                                                          )
                                                                        ]
                                                                        );
    System.Debug('***list_ShPnObj ***'+list_ShPnObj);
    if ( !list_ShPnObj.IsEmpty() ) {  try{ delete list_ShPnObj; } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } } //catch
          
    }
    
  }
  
    @future(callout=true)
    static webservice void DetenerJob(String JobId)
    {
        System.Debug('*** JobId*** '+JobId);
        if (JobId!=null){ try { CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :JobId]; System.abortJob(ct.id); } catch(System.CalloutException e) { System.debug('ERROR: '+ e);}
        }
        
    
    }
    
   
        
  
  

  private class ErrorProcesoException extends Exception { }

  
    

}