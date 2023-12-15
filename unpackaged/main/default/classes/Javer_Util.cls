global with sharing class Javer_Util {
    /****************************************************************************** 
        Constantes
    */

    /****************************************************************************** 
        Variables
    */
    public static Id archivoXMLIdParent {get; set;}
    
    public static integer contador_ApprovalData  {get; set;}
    public static integer contador_record  {get; set;}
    public static integer contador_field  {get; set;}
    
    public static Map<Id,list<ApprovalData__c>>  map_id_listApprovalData;
    public static Map<Integer,list<record__c>> map_intNumLista_listrecord {get; set;}
    public static Map<Integer,list<field__c>> map_intNumLista_listfield {get; set;}
    
    
  
    
    /******************************************************************************
        Subclases:
    */
    public class Datos {
        public String idFlujo {get; set;}
        public String platform {get; set;}
        public String requesterLogin {get; set;}
        public String requesterEmpId {get; set;}
        public String requesterName {get; set;}
        public String approverLogin {get; set;}
        public String approverEmpId {get; set;}
        public String approverName {get; set;}
        public String approvalObject {get; set;}
        public String approvalRequestedDate {get; set;}
        public String approvalName {get; set;}
        public String approvalId {get; set;}
        public String approvalType {get; set;}
        public String approvalLevel {get; set;}
        public String approvalLevelValue {get; set;}
        public String listOfApprovalData {get; set;}
        
        
        public CadenaXML cadenaXML {get; set;}
        public String token {get; set;}
        public String action {get; set;}
        public String src {get; set;}
      
      // Constructor
      public Datos() {
      idFlujo = '';
      
      requesterLogin = '';
      requesterEmpId = '';
      requesterName = '';
      approverLogin = '';
      approverEmpId = '';
      approverName = '';
      approvalObject = '';
      approvalRequestedDate = '';
      approvalName = '';
      approvalId = '';
      approvalType = '';
      approvalLevel = '';
      approvalLevelValue = '';
      listOfApprovalData = '';
      
      token = '';
      action  = '';
      src  = '';
      cadenaXML = new CadenaXML();
      }  
    }
    
    public class CadenaXML {
      public DatosSiebel datosSiebel {get; set;}
      
      // Contructor
      public CadenaXML() {
        datosSiebel = new DatosSiebel();
      }
    }
    
    public class DatosSiebel {
      //public List<Proceso__c> listaSiebelProcesos {get; set;}
      public List<approvalObject__c> listaSiebelProcesos {get; set;}
      public ApprovalDataClass approvalDataClass {get; set;}
      
      // Constructor
      public DatosSiebel() {
        listaSiebelProcesos = new List<approvalObject__c>();
        approvalDataClass = new ApprovalDataClass();
      }
    }
    
    public class ApprovalDataClass {
      public List<ApprovalData__c> listaApprovalData {get; set;}
      public RecordClass recordClass {get; set;}
      
      // Constructor
      public ApprovalDataClass() {
        listaApprovalData = new List<ApprovalData__c>();
        recordClass = new RecordClass();
      }
    }
    
    public class RecordClass {
      public List<record__c> listarecord {get; set;}
      public FieldClass fieldClass {get; set;}
      
      // Constructor
      public RecordClass() {
        listarecord = new List<record__c>();
        fieldClass = new FieldClass();
      }
    }
    
    public class FieldClass {
      public List<field__c> listafield {get; set;}
      // Constructor
      public FieldClass() {
        listafield = new List<field__c>();
      }
    }
  
  
  public Javer_Util(){
      //datos = new Datos();
      
  }  
    
  public static void envia_respuesta(XmlStreamReader reader) {
  
  
  }
  
  /******************************************************************************
        Método descargaParseXML
    */
    public static void descargaParseXML(XmlStreamReader reader) {
        Id idDatoSiebel;
        contador_ApprovalData=0;
        contador_record=0;
        contador_field=0;
        Datos datos = new Datos();
        map_id_listApprovalData = new Map<Id,list<ApprovalData__c>>();
        map_intNumLista_listrecord = new Map<Integer,list<record__c>>();
        map_intNumLista_listfield = new Map<Integer,list<field__c>>();
        XmlStreamReader reader_AppData = reader;
        Map<Integer, Id> map_intNmListaAppData_idAppData = new Map<Integer, Id>();
        Map<Integer, Id> map_intNmListaRecord_idRecord = new Map<Integer, Id>();
        approvalObject__c approvalObject_Encabezado = new approvalObject__c();
        while(reader.hasNext()) {
                // Buscamos el Start Element de variables encabezado
            if(reader.getEventType() == XmlTag.START_ELEMENT) {
                  
                  if(reader.getLocalName() == 'platform') {
                        approvalObject_Encabezado.platform__c = datos.platform = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'token') {
                        approvalObject_Encabezado.token__c = datos.token = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'requesterLogin') {
                        approvalObject_Encabezado.requesterLogin__c = datos.requesterLogin = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'requesterEmpId') {
                        approvalObject_Encabezado.requesterEmpId__c = datos.requesterEmpId = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'requesterName') {
                        approvalObject_Encabezado.requesterName__c = datos.requesterName = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approverLogin') {
                        approvalObject_Encabezado.approverLogin__c = datos.approverLogin = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approverEmpId') {
                        approvalObject_Encabezado.approverEmpId__c = datos.approverEmpId = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approverName') {
                        approvalObject_Encabezado.approverName__c = datos.approverName = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approvalObject') {
                        approvalObject_Encabezado.approvalObject__c = datos.approvalObject = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approvalRequestedDate') {
                        approvalObject_Encabezado.approvalRequestedDate__c = datos.approvalRequestedDate = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approvalName') {
                        approvalObject_Encabezado.approvalName__c = approvalObject_Encabezado.Name = datos.approvalName = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approvalId') {
                        approvalObject_Encabezado.approvalId__c = datos.approvalId = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approvalType') {
                        approvalObject_Encabezado.approvalType__c = datos.approvalType = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approvalLevel') {
                        approvalObject_Encabezado.approvalLevel__c = datos.approvalLevel = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'approvalLevelValue') {
                        approvalObject_Encabezado.approvalLevelValue__c = datos.approvalLevelValue = obtenerValor(reader);
                    }
                  
                  if (approvalObject_Encabezado.approvalLevelValue__c!=''){
                      //System.Debug('***approvalObject_Encabezado 0*** '+ approvalObject_Encabezado);
                      if (datos.cadenaXML.datosSiebel.listaSiebelProcesos.size() == 0 ){
                          datos.cadenaXML.datosSiebel.listaSiebelProcesos.add(approvalObject_Encabezado);
                          try{
                                //System.Debug('***datos.cadenaXML.datosSiebel.listaSiebelProcesos 0*** '+ datos.cadenaXML.datosSiebel.listaSiebelProcesos);
                                insert datos.cadenaXML.datosSiebel.listaSiebelProcesos;
                                idDatoSiebel = datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id;
                          } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                          } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                          } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } //catch
                      } else {
                        //System.Debug('***approvalObject_Encabezado else*** '+ approvalObject_Encabezado);
                        try{
                                update approvalObject_Encabezado;
                          } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                          } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                          } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } //catch
                      }
                      
                  }
                  if(reader.getLocalName() == 'ApprovalData' && datos.cadenaXML.datosSiebel.listaSiebelProcesos.size()==1) {
                      //System.Debug('***reader*** '+ reader);
                      datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData.add(obtenerValorlistOfApprovalData(reader, 'ApprovalData', datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id));
                  }
                  
            }
            reader.next();
        }
                    
        
        if (datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id!=null && datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData!=null){
            try{
                insert datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData;
             } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                          } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                          } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } //catch
            
            List<record__c> list_Record = new List<record__c>();
            Set<String> set_llaveCompuestaRecord = new Set<String>();
            for (ApprovalData__c objApprovalData : datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData){   
                            if(map_id_listApprovalData.get(datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id)!=null){
                                map_id_listApprovalData.get(datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id).add(objApprovalData);
                            } else
                            {
                                map_id_listApprovalData.put(datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id, new List<ApprovalData__c>{objApprovalData});      
                            }
                            map_intNmListaAppData_idAppData.put( Integer.ValueOf( objApprovalData.Numero_de_Lista__c), objApprovalData.Id);
                            List<record__c> list_Record_temp = new List<record__c>( map_intNumLista_listrecord.get(Integer.ValueOf( objApprovalData.Numero_de_Lista__c) ) );
                            for(record__c objRecord : list_Record_temp){
                                if (!set_llaveCompuestaRecord.contains(objRecord.name) ){
                                    set_llaveCompuestaRecord.add(objRecord.name);
                                    list_Record.add(objRecord);
                                }
                                
                            }                  
            }
            
            if ( !list_Record.isEmpty() ){
                List<record__c> list_record_ins = new List<record__c>(); 
                List<field__c> list_field = new List<field__c>();
                Set<String> set_llaveCompuestaField = new Set<String>();
                for(record__c objrecord : list_Record ){
                    objrecord.ApprovalData_Buscar__c = map_intNmListaAppData_idAppData.get( Integer.ValueOf( objrecord.Numero_de_Lista_Buscar__c) );
                    list_record_ins.add(objrecord);
                    //list_field.add(map_intNumLista_listfield.get( Integer.ValueOf(objrecord.Numero_de_Lista__c)  )  );
                    
                    List<field__c> list_field_temp = new List<field__c>( map_intNumLista_listfield.get(Integer.ValueOf( objrecord.Numero_de_Lista__c) ) );
                    for(field__c objField : list_field_temp){
                        if (!set_llaveCompuestaField.contains(objField.Llave_Compuesta__c) ){
                            set_llaveCompuestaField.add(objField.Llave_Compuesta__c);
                            list_field.add(objField);
                        }
                        
                    } 
                }
                try{
                    //System.Debug('***list_record_ins*** '+ list_record_ins);
                    insert list_record_ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
                for (record__c objrecord :list_record_ins){
                    map_intNmListaRecord_idRecord.put( Integer.ValueOf(objrecord.Numero_de_Lista__c) , objrecord.Id);
                }
                if ( !list_field.isEmpty() ){
                    List<field__c> list_field_ins = new List<field__c>(); 
                    for(field__c objfield : list_field ){
                        objfield.record_Buscar__c = map_intNmListaRecord_idRecord.get( Integer.ValueOf( objfield.Numero_de_Lista_Buscar__c) );
                        list_field_ins.add(objfield);
                    }
                    try{
                        insert list_field_ins;
                    } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
                }
            }
        }
                      
        
        Boolean boolFlujoAprobValido = false;
        //approvalObject__c ApprvObj = [SELECT Id, Copiar_Datos_a_Objeto_SF__c FROM approvalObject__c WHERE Id = : idDatoSiebel];
        approvalObject__c ApprvObj= [SELECT Id
                                        , Name
                                        , approvalId__c
                                        , approvalLevel__c
                                        , approvalLevelValue__c
                                        , approvalName__c
                                        , approvalObject__c
                                        , approvalRequestedDate__c
                                        , approvalType__c
                                        , approverEmpId__c
                                        , approverLogin__c
                                        , approverName__c
                                        , Nombre__c
                                        , platform__c
                                        , requesterEmpId__c
                                        , requesterLogin__c
                                        , requesterName__c
                                        , token__c
                                        FROM approvalObject__c WHERE Id = : idDatoSiebel ];
        if(ApprvObj.approvalObject__c=='Cedula Asesor' 
            || 
            ApprvObj.approvalObject__c=='Cedula Prospectador'
            || 
            ApprvObj.approvalObject__c=='Plan Comision Asesor'
            || 
            ApprvObj.approvalObject__c=='Plan Comision Prospectador'
            || 
            ApprvObj.approvalObject__c=='Plan Bono Asesor'
            || 
            ApprvObj.approvalObject__c=='Plan Bono Col. Javer'
            || 
            ApprvObj.approvalObject__c=='Plan Bono Prospectador'
            || 
            ApprvObj.approvalObject__c=='Plan Bono_Col. Javer'
            
            ){
            //System.Debug('***ApprvObj Comision*** '+ ApprvObj);
            Comision__c objComision= new Comision__c();
            if(ApprvObj.approvalObject__c=='Cedula Asesor'){
                 objComision = Crea_Cedula_Asesor(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Cedula Prospectador'){
                objComision = Crea_Cedula_Prospectador(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Plan Comision Asesor'){
                objComision = Crea_PlanComAsesor(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Plan Comision Prospectador'){
                objComision = Crea_PlanComProsp(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Plan Bono Asesor'){
                objComision = Crea_PlanBonoAsesor(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Plan Bono Col. Javer'){
                objComision = Crea_PlanBonoColJaver(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Plan Bono Prospectador'){
                objComision = Crea_PlanBonoProspectador(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Plan Bono_Col. Javer'){
                objComision = Crea_PlanBono_ColJaver(ApprvObj);
            }
            
            System.Debug('***objComision*** '+ objComision);
            
            if (objComision == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, approvalObject_Buscar__c FROM Catch__c WHERE approvalObject_Buscar__c=:ApprvObj.Id  LIMIT 1]);
                      if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ ApprvObj.approvalObject__c+' con clave '+ApprvObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+ApprvObj.approvalObject__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.approvalObject_Buscar__c = ApprvObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                            
                      
                }    
            } else {
                    try{
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(objComision.id);
                        
                        // Submit on behalf of a specific submitter
                        req1.setSubmitterId(objComision.OwnerId); 
                        
                        // Submit the record to specific process and skip the criteria evaluation
                        String rtComision_ComAsesores = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Comisiones Asesores').getRecordTypeId();
                        String rtComision_ComProsp = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Comisiones Prospectadores').getRecordTypeId();
                        String rtComision_BaseComAsesores = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Base Comisiones Asesores').getRecordTypeId();
                        String rtComision_BaseComProsp = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Base Comisiones Prospectadores').getRecordTypeId();
                        String rtComision_BasePlanBonos = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Base Plan de Bonos').getRecordTypeId();
                        String rtComision_PlanBonoAsesor = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono Asesor').getRecordTypeId();
                        String rtComision_PlanBonoColJaver = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono Col. Javer').getRecordTypeId();
                        String rtComision_PlanBonoProspectador = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono Prospectador').getRecordTypeId();
                        String rtComision_PlanBono_ColJaver = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono_Col. Javer').getRecordTypeId();
                        // Submit the record to specific process and skip the criteria evaluation
                        if (objComision.RecordTypeId == rtComision_ComAsesores ){
                            System.Debug('***rtComision_ComAsesores*** '+ rtComision_ComAsesores);
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_ComAsesores');
                        } else if (objComision.RecordTypeId == rtComision_ComProsp ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_ComProsp');
                        } else if (objComision.RecordTypeId == rtComision_BaseComAsesores ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_BaseComAsesores');
                        } else if (objComision.RecordTypeId == rtComision_BaseComProsp ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_BaseComProsp');
                        } else if (objComision.RecordTypeId == rtComision_BasePlanBonos ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_BasePlanBonos');
                        }  else if (objComision.RecordTypeId == rtComision_PlanBonoAsesor ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_PlanBonoAsesor');
                        }  else if (objComision.RecordTypeId == rtComision_PlanBonoColJaver ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_PlanBonoColJaver');
                        }  else if (objComision.RecordTypeId == rtComision_PlanBonoProspectador ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_PlanBonoProspectador');
                        }  else if (objComision.RecordTypeId == rtComision_PlanBono_ColJaver ){
                            req1.setProcessDefinitionNameOrId('Proc_Aprob_Comision_PlanBono_ColJaver');
                        }
                        
                        //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Comision');
                        req1.setSkipEntryCriteria(false);
                        // Submit the approval request for the account
                        Approval.ProcessResult result = Approval.process(req1);
                        //System.debug('***result*** '+result);
                        ApprvObj.Id_Objeto_A_Aprobar_Buscar__c = objComision.Id;
                        ApprvObj.Estatus__c = 'En Proceso de Aprobación';
                        ApprvObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objComision.Id;
                        ApprvObj.OwnerId = objComision.OwnerId;
                        
                        ApprvObj.Tipo__c = 'Comisión';
                        ApprvObj.SubTipo__c = ApprvObj.approvalObject__c;
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        ApprvObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                        
                        try{
                            update ApprvObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                        
                    } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
            }
            boolFlujoAprobValido = true;
            
        } else if(ApprvObj.approvalObject__c=='Extension de Periodos' 
            || 
            ApprvObj.approvalObject__c=='Bonificaciones Batch'
            || 
            ApprvObj.approvalObject__c=='Lista de Bonificaciones Batch'
            || 
            ApprvObj.approvalObject__c=='Lista de Financiamientos Batch'
            || 
            ApprvObj.approvalObject__c=='Lista de Precios Batch Prods'
            || 
            ApprvObj.approvalObject__c=='Lista de Precios Batch'
            || 
            ApprvObj.approvalObject__c=='Lista de Precios'
            
            ){
            //System.Debug('***ApprvObj Planning*** '+ ApprvObj);
            //Crea_BonBatch
            Planning__c objPlanning= new Planning__c();
            if(ApprvObj.approvalObject__c=='Extension de Periodos'){
                 objPlanning = Crea_PlannPeriodoVenta(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Bonificaciones Batch'){
                objPlanning = Crea_BonBatch(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Lista de Bonificaciones Batch'){
                objPlanning = Crea_ListBonBatch(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Lista de Financiamientos Batch'){
                objPlanning = Crea_ListFinBatch(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Lista de Precios Batch Prods'){
                objPlanning = Crea_ListPrcBatchPrdctos(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Lista de Precios Batch'){
                objPlanning = Crea_ListPrcBatch(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Lista de Precios'){
                objPlanning = Crea_ListPrc(ApprvObj);
            }
            
            if (objPlanning == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) {
                      List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, approvalObject_Buscar__c FROM Catch__c WHERE approvalObject_Buscar__c=:ApprvObj.Id  LIMIT 1]);
                        if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ ApprvObj.approvalObject__c+' con clave '+ApprvObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+ApprvObj.approvalObject__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.approvalObject_Buscar__c = ApprvObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                        
                }    
            } else {
                try{
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('Submitting request for approval.');
                    req1.setObjectId(objPlanning.id);
                    
                    // Submit on behalf of a specific submitter
                    req1.setSubmitterId(objPlanning.OwnerId); 
                    
                    String rtPlanning_ExtPeriodos = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Periodo de Venta').getRecordTypeId();
                    String rtPlanning_ApListDeBon = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Bonificaciones').getRecordTypeId();
                    String rtPlanning_ApListDeFin = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Financiamiento').getRecordTypeId();
                    String rtPlanning_ApListDePrecios = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Precios').getRecordTypeId();
                    String rtPlanning_ApListDePreciosBatch = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Precios Batch').getRecordTypeId();
                    String rtPlanning_ListDePreciosBatcPr = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Precios Batch Prods').getRecordTypeId();
                    String rtPlanning_BonBatch = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Bonificaciones Batch').getRecordTypeId();
                    // Submit the record to specific process and skip the criteria evaluation
                    if (objPlanning.RecordTypeId == rtPlanning_ExtPeriodos ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Planning_ExtPeriodos');
                    } else if (objPlanning.RecordTypeId == rtPlanning_ApListDeBon ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Planning_ApListDeBon');
                    } else if (objPlanning.RecordTypeId == rtPlanning_ApListDeFin ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Planning_ApListDeFin');
                    } else if (objPlanning.RecordTypeId == rtPlanning_ApListDePrecios ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Planning_ApListDePrecios');
                    } else if (objPlanning.RecordTypeId == rtPlanning_ApListDePreciosBatch ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Planning_ApListDePreciosBatc');
                    } else if (objPlanning.RecordTypeId == rtPlanning_ListDePreciosBatcPr ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Planning_ListDePreciosBatcPr');
                    } else if (objPlanning.RecordTypeId == rtPlanning_BonBatch ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Planning_BonBatch');
                    }
                    //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Planning');
                    req1.setSkipEntryCriteria(false);
                    // Submit the approval request for the account
                    Approval.ProcessResult result = Approval.process(req1);
                    
                    ApprvObj.Id_Objeto_A_Aprobar_Buscar__c = objPlanning.Id;
                        ApprvObj.Estatus__c = 'En Proceso de Aprobación';
                        ApprvObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objPlanning.Id;
                        ApprvObj.OwnerId = objPlanning.OwnerId;
                      
                      ApprvObj.Tipo__c = 'Planning';
                        ApprvObj.SubTipo__c = ApprvObj.approvalObject__c;
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        ApprvObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                    
                        try{
                            update ApprvObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                    
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
            
            }
            boolFlujoAprobValido = true;
            
        } else if(ApprvObj.approvalObject__c=='Bonif. Emp. de Plan de Venta' 
            || 
            ApprvObj.approvalObject__c=='Excepcion Bonif. Emp. ColJaver'
            || 
            ApprvObj.approvalObject__c=='Bonificacion de Plan de Venta'
            || 
            ApprvObj.approvalObject__c=='Financiamiento Plan de Venta'
            || 
            ApprvObj.approvalObject__c=='Paquetes de Plan de Venta'
            
            ){
            //System.Debug('***ApprvObj Planning*** '+ ApprvObj);u
            
            Venta__c objVenta= new Venta__c();
            if(ApprvObj.approvalObject__c=='Bonif. Emp. de Plan de Venta'){
                 objVenta = Crea_BonEmpPlanVta(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Excepcion Bonif. Emp. ColJaver'){
                objVenta = Crea_ExcBonEmpColJaver(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Bonificacion de Plan de Venta'){
                objVenta = Crea_BonPlanVta(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Financiamiento Plan de Venta'){
                objVenta = Crea_FinPlanVta(ApprvObj);
            } else if( ApprvObj.approvalObject__c=='Paquetes de Plan de Venta'){
                objVenta = Crea_PaqPlanVta(ApprvObj);
            } 
            
            if (objVenta == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, approvalObject_Buscar__c FROM Catch__c WHERE approvalObject_Buscar__c=:ApprvObj.Id  LIMIT 1]);
                        if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ ApprvObj.approvalObject__c+' con clave '+ApprvObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+ApprvObj.approvalObject__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.approvalObject_Buscar__c = ApprvObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                }    
            } else {
            
                try{
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('Submitting request for approval.');
                    req1.setObjectId(objVenta.id);
                    
                    // Submit on behalf of a specific submitter
                    req1.setSubmitterId(objVenta.OwnerId); 
                    String rtVenta_AutBonEmp = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Autorizacion Bonificaciones Empleados').getRecordTypeId();
                    String rtVenta_AutFinPreVta = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Autorizacion Financiamiento Pre Venta').getRecordTypeId();
                    String rtVenta_ExcBonEmpColJaver = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Excepcion Bonif. Emp. ColJaver').getRecordTypeId();
                    String rtVenta_BonFueraLista = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Bonificacion Fuera de Lista').getRecordTypeId();
                    String rtVenta_ExcPaqProdViv = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Excepcion de Paquetes / Productos Vivienda').getRecordTypeId();
                   
                    // Submit the record to specific process and skip the criteria evaluation
                    if (objVenta.RecordTypeId == rtVenta_AutBonEmp ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Vta_AutBonEmp');
                    } else if (objVenta.RecordTypeId == rtVenta_AutFinPreVta ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Vta_AutFinPreVta');
                    } else if (objVenta.RecordTypeId == rtVenta_ExcBonEmpColJaver ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Vta_ExcBonEmpColJaver');
                    } else if (objVenta.RecordTypeId == rtVenta_BonFueraLista ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Vta_BonFueraLista');
                    } else if (objVenta.RecordTypeId == rtVenta_ExcPaqProdViv ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Vta_ExcPaqProdViv');
                    }
                    // Submit the record to specific process and skip the criteria evaluation
                    //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Venta');
                    req1.setSkipEntryCriteria(false);
                    // Submit the approval request for the account
                    Approval.ProcessResult result = Approval.process(req1);
                    
                    ApprvObj.Id_Objeto_A_Aprobar_Buscar__c = objVenta.Id;
                        ApprvObj.Estatus__c = 'En Proceso de Aprobación';
                        ApprvObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objVenta.Id;
                        ApprvObj.OwnerId = objVenta.OwnerId;
                      
                      ApprvObj.Tipo__c = 'Venta';
                        ApprvObj.SubTipo__c = ApprvObj.approvalObject__c;
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        ApprvObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                    
                        try{
                            update ApprvObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                    
                    
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
            
            
            }
            
            boolFlujoAprobValido = true;
        } else if(ApprvObj.approvalObject__c=='VO. Menor a Presupuesto' 
            || 
            ApprvObj.approvalObject__c=='VO. Menor a Presupuesto'
            
            ){
            //System.Debug('***ApprvObj Planning*** '+ ApprvObj);
            
            Pre_Venta__c objPreVenta= new Pre_Venta__c();
            if(ApprvObj.approvalObject__c=='VO. Menor a Presupuesto'){
                 objPreVenta = Crea_VOMenPres(ApprvObj);
            } 
                
            if (objPreVenta == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, approvalObject_Buscar__c FROM Catch__c WHERE approvalObject_Buscar__c=:ApprvObj.Id  LIMIT 1]);
                        if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ ApprvObj.approvalObject__c+' con clave '+ApprvObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+ApprvObj.approvalObject__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.approvalObject_Buscar__c = ApprvObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                }    
            } else {
                
                try{
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('Submitting request for approval.');
                    req1.setObjectId(objPreVenta.id);
                    
                    // Submit on behalf of a specific submitter
                    req1.setSubmitterId(objPreVenta.OwnerId); 
                    String rtPreVenta_VOMenPres = Schema.SObjectType.Pre_Venta__c.getRecordTypeInfosByName().get('VO. Menor a Presupuesto').getRecordTypeId();
                    
                    // Submit the record to specific process and skip the criteria evaluation
                    if (objPreVenta.RecordTypeId == rtPreVenta_VOMenPres ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_PreVenta_VOMenorAPresupuesto');
                    }
                    // Submit the record to specific process and skip the criteria evaluation
                    //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Post_Venta');
                    req1.setSkipEntryCriteria(false);
                    // Submit the approval request for the account
                    Approval.ProcessResult result = Approval.process(req1);
                    
                    ApprvObj.Id_Objeto_A_Aprobar_Buscar__c = objPreVenta.Id;
                        ApprvObj.Estatus__c = 'En Proceso de Aprobación';
                        ApprvObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objPreVenta.Id;
                        ApprvObj.OwnerId = objPreVenta.OwnerId;
                      
                      ApprvObj.Tipo__c = 'PreVenta';
                        ApprvObj.SubTipo__c = ApprvObj.approvalObject__c;
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        ApprvObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                    
                        try{
                            update ApprvObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                    
                    
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
            
            
            }
            
            boolFlujoAprobValido = true;
            
        }  else if(ApprvObj.approvalObject__c=='Financiamiento Post Venta' 
            || 
            ApprvObj.approvalObject__c=='Finan PostVenta Col Javer'   
            || 
            ApprvObj.approvalObject__c=='Subsidio'
            || 
            ApprvObj.approvalObject__c=='Financiamiento Reestructura PV'
            || 
            ApprvObj.approvalObject__c=='Garantia'
            
            
            ){
            
            
            
            Post_Venta__c objPostVenta= new Post_Venta__c();
            if(ApprvObj.approvalObject__c=='Financiamiento Post Venta'){
                 objPostVenta = Crea_FinPostVta(ApprvObj);
            } else if(ApprvObj.approvalObject__c=='Finan PostVenta Col Javer'){
                 objPostVenta = Crea_FinPVColJaver(ApprvObj);
            } else if(ApprvObj.approvalObject__c=='Subsidio'){
                 objPostVenta = Crea_Subsidio(ApprvObj);
            } else if(ApprvObj.approvalObject__c=='Financiamiento Reestructura PV'){
                 objPostVenta = Crea_ReestructPV(ApprvObj);
            } else if(ApprvObj.approvalObject__c=='Garantia'){
                 objPostVenta = Crea_Garantia(ApprvObj);
            }  
            
            if (objPostVenta == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, approvalObject_Buscar__c FROM Catch__c WHERE approvalObject_Buscar__c=:ApprvObj.Id  LIMIT 1]);
                        if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ ApprvObj.approvalObject__c+' con clave '+ApprvObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+ApprvObj.approvalObject__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.approvalObject_Buscar__c = ApprvObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                }    
            } else {
                
                try{
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('Submitting request for approval.');
                    req1.setObjectId(objPostVenta.id);
                    
                    // Submit on behalf of a specific submitter
                    req1.setSubmitterId(objPostVenta.OwnerId); 
                    String rtPostVenta_AutFinPostVta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Autorizacion Financiamiento PosVenta').getRecordTypeId();
                    String rtPostVenta_FinPVColJaver = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Finan PostVenta Col Javer').getRecordTypeId();
                    String rtPostVenta_BonSaldoPostVta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Bonificacion Saldo Post Venta').getRecordTypeId();
                    String rtPostVenta_ReesctrucPostVta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Reestructuracion Post Venta').getRecordTypeId();
                    String rtPostVenta_Subsidio = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Subsidio').getRecordTypeId();
                    String rtPostVenta_Garantia = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Garantia').getRecordTypeId();
                    // Submit the record to specific process and skip the criteria evaluation
                    if (objPostVenta.RecordTypeId == rtPostVenta_AutFinPostVta ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_PostVenta_AutFinPostVta');
                    } else if (objPostVenta.RecordTypeId == rtPostVenta_FinPVColJaver ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_PostVenta_FinPVColJaver');
                    } else if (objPostVenta.RecordTypeId == rtPostVenta_BonSaldoPostVta ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_PostVenta_BonSaldoPostVta');
                    } else if (objPostVenta.RecordTypeId == rtPostVenta_ReesctrucPostVta ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_PostVenta_ReesctrucPostVta');
                    } else if (objPostVenta.RecordTypeId == rtPostVenta_Subsidio ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_PostVenta_Subsidio');
                    } else if (objPostVenta.RecordTypeId == rtPostVenta_Garantia ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_PostVenta_Garantia');
                    }
                    // Submit the record to specific process and skip the criteria evaluation
                    //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Post_Venta');
                    req1.setSkipEntryCriteria(false);
                    // Submit the approval request for the account
                    Approval.ProcessResult result = Approval.process(req1);
                    
                    ApprvObj.Id_Objeto_A_Aprobar_Buscar__c = objPostVenta.Id;
                        ApprvObj.Estatus__c = 'En Proceso de Aprobación';
                        ApprvObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objPostVenta.Id;
                        ApprvObj.OwnerId = objPostVenta.OwnerId;
                    
                      ApprvObj.Tipo__c = 'PostVenta';
                        ApprvObj.SubTipo__c = ApprvObj.approvalObject__c;
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        ApprvObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                      
                        try{
                            update ApprvObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                    
                    
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
                
            
            }
            boolFlujoAprobValido = true;
            
        } else if(ApprvObj.approvalObject__c=='Cancelacion de Escritura' 
            || 
            ApprvObj.approvalObject__c=='Cancelacion Formalizacion'
            || 
            ApprvObj.approvalObject__c=='Gastos Admin'
            
            
            ){
                        
            Cancelacion__c objCancelacion= new Cancelacion__c();
            if(ApprvObj.approvalObject__c=='Cancelacion de Escritura'){
                 objCancelacion = Crea_CancEscrt(ApprvObj);
            } else if(ApprvObj.approvalObject__c=='Cancelacion Formalizacion'){
                 objCancelacion = Crea_CancFormal(ApprvObj);
            } else if(ApprvObj.approvalObject__c=='Gastos Admin'){
                 objCancelacion = Crea_CancGastosAdmin(ApprvObj);
            } 
            
            if (objCancelacion == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, approvalObject_Buscar__c FROM Catch__c WHERE approvalObject_Buscar__c=:ApprvObj.Id  LIMIT 1]);
                        if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ ApprvObj.approvalObject__c+' con clave '+ApprvObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+ApprvObj.approvalObject__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.approvalObject_Buscar__c = ApprvObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                }    
            } else {
                
                try{
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('Submitting request for approval.');
                    req1.setObjectId(objCancelacion.id);
                    
                    // Submit on behalf of a specific submitter
                    req1.setSubmitterId(objCancelacion.OwnerId); 
                    String rtCancelacion_CancFormal = Schema.SObjectType.Cancelacion__c.getRecordTypeInfosByName().get('Cancelacion Formalizacion').getRecordTypeId();
                    String rtCancelacion_CancEsc = Schema.SObjectType.Cancelacion__c.getRecordTypeInfosByName().get('Cancelacion de Escritura').getRecordTypeId();
                    String rtCancelacion_GastosAdmin = Schema.SObjectType.Cancelacion__c.getRecordTypeInfosByName().get('Gastos Admin').getRecordTypeId();
                    // Submit the record to specific process and skip the criteria evaluation
                    if (objCancelacion.RecordTypeId == rtCancelacion_CancFormal ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Canc_CancFormal');
                    } else if (objCancelacion.RecordTypeId == rtCancelacion_CancEsc ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Canc_CancEsc');
                    } else if (objCancelacion.RecordTypeId == rtCancelacion_GastosAdmin ){
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Canc_GastosAdmin');
                    } 
                    // Submit the record to specific process and skip the criteria evaluation
                    //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Cancelacion');
                    req1.setSkipEntryCriteria(false);
                    // Submit the approval request for the account
                    Approval.ProcessResult result = Approval.process(req1);
                    
                    ApprvObj.Id_Objeto_A_Aprobar_Buscar__c = objCancelacion.Id;
                        ApprvObj.Estatus__c = 'En Proceso de Aprobación';
                        ApprvObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objCancelacion.Id;
                        ApprvObj.OwnerId = objCancelacion.OwnerId;
                      
                      ApprvObj.Tipo__c = 'Cancelación';
                        ApprvObj.SubTipo__c = ApprvObj.approvalObject__c;
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        ApprvObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                      
                        try{
                            update ApprvObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                    
                    
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
                
            }
            boolFlujoAprobValido = true;
        }
        //Comprobamos si alguna vez entro en algun IF
        //Si nunca entro generamos una exception indicandolo
        if (!boolFlujoAprobValido){
            // En esta caso validamos si acaso el objeto se construyo
            // Si tenia nombre entonces el nombre del flujo no se encontro
            if (ApprvObj.approvalObject__c!=null){ try { throw new ErrorProcesoException(); } catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El campo de <approvalObject> con el valor: '+ ApprvObj.approvalObject__c+' no fue encontrado entre los Flujos de Aprobación.'; newCatch.Causa__c = 'Nombre de flujo no válido.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
            } 
            // Si no tenia nombre significa que no tiene datos de encabezado
            else { try { throw new ErrorProcesoException(); } catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no tiene información básica de encabezado.'; newCatch.Causa__c = 'El XML no tiene encabezado.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
            }
            
        }
    
    
    }
    
    
  /******************************************************************************
        Métodos obtener valores de secciones
    */        
    
    public static ApprovalData__c obtenerValorlistOfApprovalData(XmlStreamReader reader, String localName, Id idParent) {
        
        ApprovalData__c objApprovalData = new ApprovalData__c();
        //contador_ApprovalData = 0;
        Datos datos= new Datos();
        contador_ApprovalData+=1;
        while(reader.hasNext()) {
              //System.Debug('***reader w*** '+ reader);
              if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == localName) {
                   //System.Debug('***reader if 1*** '+ reader);
                   break;
              } else if(reader.getEventType() == XmlTag.START_ELEMENT) {
                      //System.Debug('***reader if 3*** '+ reader);
                      //ApprovalData__c objApprovalData = new ApprovalData__c();
                      //System.Debug('***objApprovalData 0*** '+objApprovalData );
                      
                      objApprovalData.Numero_de_Lista__c = contador_ApprovalData;
                      objApprovalData.Name = String.ValueOf(contador_ApprovalData);
                      
                      
                      //System.Debug('***objApprovalData*** '+objApprovalData );
                      //System.Debug('*** objApprovalData 1*** '+  objApprovalData);
                      datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord.add(obtenerValorlistOfRecords(reader, 'record', Integer.ValueOf(objApprovalData.Numero_de_Lista__c)));
                      //System.Debug('*** datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord*** '+  datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord);
                      if (datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord.size()>0){
                          for (record__c objRecord : datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord){
                              if(map_intNumLista_listrecord.get(Integer.ValueOf(objApprovalData.Numero_de_Lista__c))!=null){
                                  map_intNumLista_listrecord.get(Integer.ValueOf(objApprovalData.Numero_de_Lista__c)).add(objRecord);
                              } else {
                                  map_intNumLista_listrecord.put(Integer.ValueOf(objApprovalData.Numero_de_Lista__c), new List<record__c>{objRecord});      
                              } 
                          } 
                      }
                      
              } 
          
          reader.next();
        }
        objApprovalData.approvalObject_Buscar__c= idParent;
        //System.Debug('*** map_intNumLista_listrecord*** '+  map_intNumLista_listrecord);
        //System.Debug('*** datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord 2*** '+  datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord);
        return objApprovalData;
    }
    
    
 
   
    
    public static record__c obtenerValorlistOfRecords(XmlStreamReader reader, String localName, Integer intNumListaBuscar) {
        
        record__c record = new record__c();
        //contador_record = 0;
        Datos datos= new Datos();
        contador_record+=1;
        while(reader.hasNext()) {
              //System.Debug('***reader w*** '+ reader);
              if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == localName) {
                   //System.Debug('***reader if 1*** '+ reader);
                   break;
              } else if(reader.getEventType() == XmlTag.START_ELEMENT) {
                      //System.Debug('***record 0*** '+ record);
                      
                      record.Numero_de_Lista__c = contador_record;     
                      record.Name  = 'R-'+String.ValueOf(contador_record)+'-'+String.ValueOf(intNumListaBuscar);
                      //System.Debug('***record 1*** '+ record);
                      datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.FieldClass.listafield.add(obtenerValorlistOfFields(reader, 'field', Integer.ValueOf( record.Numero_de_Lista__c)  ));
                      if (datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.FieldClass.listafield.size()>0){
                          
                          for (field__c objField : datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.FieldClass.listafield){
                              if(map_intNumLista_listfield.get(Integer.ValueOf(record.Numero_de_Lista__c))!=null){
                                  map_intNumLista_listfield.get(Integer.ValueOf(record.Numero_de_Lista__c)).add(objField);
                              } else {
                                  map_intNumLista_listfield.put(Integer.ValueOf(record.Numero_de_Lista__c), new List<field__c>{objField});      
                              } 
                          } 
                      }
                      
              } 
          reader.next();
        }
        record.Numero_de_Lista_Buscar__c= intNumListaBuscar;
        //System.Debug('***map_intNumLista_listfield*** '+ map_intNumLista_listfield);
        return record;
    }
    

    
    private static field__c obtenerValorlistOfFields(XmlStreamReader reader, String localName , Integer intNumListaBuscar ) {
       
        field__c field = new field__c();
        //contador_field = 0;
        //Datos datos= new Datos();
        while(reader.hasNext()) {
              
              if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == localName) {
                   break;
              } else if(reader.getEventType() == XmlTag.START_ELEMENT) {
                      
                      if(reader.getLocalName() == 'name') {
                            field.Name = obtenerValor(reader);
                        } else if(reader.getLocalName() == 'value') {
                            field.Value__c = obtenerValor(reader);
                        } 
                      
                      //System.Debug('***field 1*** '+ field);
              }
          reader.next();
        }
        field.Llave_Compuesta__c = String.ValueOf(intNumListaBuscar)+'-'+ field.Name;
        field.Numero_de_Lista_Buscar__c= intNumListaBuscar;
        //System.Debug('***field*** '+ field);
        return field;
    }
    
   
    

  /******************************************************************************
        Métodos Web Services y de entrada de ejecución
    */     
    webservice static void buscarYProcesarArchivo(Id idArchivoXML) {
      XML_Siebel__c archivoXML = [SELECT Id
                       FROM XML_Siebel__c
                      WHERE Id = : idArchivoXML
                      LIMIT 1];
      
    Attachment doc = [SELECT Id, ParentId, Name, Body
                FROM Attachment
               WHERE ParentId = : idArchivoXML
            ORDER BY CreatedDate desc
               LIMIT 1];
    procesarArchivo(idArchivoXML, doc.Id);
    }
    
  @future
  public static void procesarArchivo(Id registro, Id idArchivo) {
    Javer_Util.archivoXMLIdParent = registro;
    Attachment doc = [SELECT Id, Name, Body
                FROM Attachment
               WHERE Id = : idArchivo
               LIMIT 1];
    // Define the email
    Sistema__c Sistema = new Sistema__c();
    if (!Test.isRunningTest()) { 
        Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c FROM Sistema__c WHERE Name='Configuracion en Javer Util' LIMIT 1 ];
    }else {
        Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c FROM Sistema__c WHERE Name='Configuracion en Javer Util-Test' LIMIT 1 ];
    }
    
    System.Debug('*** Sistema *** '+Sistema);
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        // Take the PDF content
        Blob b = doc.body;
        // Create the email attachment
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        Datetime dtAhora = System.Now();
        System.Debug('***dtAhora*** '+dtAhora);
        String strFechaHora = String.ValueOf(dtAhora);
        System.Debug('***strFechaHora *** '+strFechaHora );
        
        String regExp = ' ';
        String replacement = '_';
        String strFechaHoraReplace = strFechaHora.replaceAll(regExp, replacement);
        System.Debug('***strFechaHoraReplace 1 *** '+strFechaHoraReplace );
        regExp = ':';
       
        strFechaHoraReplace = strFechaHoraReplace.replaceAll(regExp, replacement);
        System.Debug('***strFechaHoraReplace 2 *** '+strFechaHoraReplace );
        efa.setFileName( strFechaHoraReplace+'.xml');
        efa.setBody(b);

      if (Sistema!=null && Sistema.Name!='' && Sistema.Name!=null && Sistema.Correo_Recep_XML_Direcciones__c!=null && Sistema.Correo_Recep_XML_Direcciones__c!='' ){
      	try{
          	String addresses=Sistema.Correo_Recep_XML_Direcciones__c; String[] toAddresses = addresses.split(':', 0); String subject = Sistema.Correo_Recep_XML_Asunto__c; String body = Sistema.Correo_Recep_XML_Mensaje__c; email.setSubject( subject ); email.setToAddresses( toAddresses ); email.setPlainTextBody( body ); email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.XML_Siebel_Buscar__c = registro; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
          
        //String addresses='pruebasblein@gmail.com:odeanda@javer.com.mx:hugo.ruiz@obelit.com:rmaldonado@javer.com.mx'
        //String subject ='Recepcion de XML en Ambiente de SandBox';
        //String body =' Se ha recibido en Salesforce Produccion el ar
        // Sets the paramaters of the email
        // Sends the email
        // 
        try{
          Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.XML_Siebel_Buscar__c = registro; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
         
    }
    
  //
  //
    //EncodingUtil.base64Decode()
      XmlStreamReader reader;
      try{
          reader = new XmlStreamReader(doc.Body.toString());
      } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.XML_Siebel_Buscar__c = registro; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
    //XmlStreamReader reader = new XmlStreamReader(doc.Body.toString());
    Javer_Util.descargaParseXML(reader);
  }
    
    
  public static String protocolAndHost() {
        String protocolAndHost_var;
                String orgId = UserInfo.getOrganizationId();
                String userId = UserInfo.getUserId();
                String sessionId = UserInfo.getSessionId();
    
                //we can trust getSalesforceBaseUrl within batches and schedules (but not in VF)
                if (sessionId == null) return Url.getSalesforceBaseUrl().toExternalForm().replace('http:', 'https:');
    
                PageReference pr = new PageReference('/id/' + orgId + '/' + userId);
                pr.getParameters().put('oauth_token', sessionId);
                pr.getParameters().put('format', 'json');
    
                //within test context use url class, else derive from identity api
                String data = Test.isRunningTest() ? '{"urls": {"rest": "' + Url.getSalesforceBaseUrl().toExternalForm() + '"}}' : pr.getContent().toString();
                Map<String,Object> result = (Map<String,Object>)Json.deserializeUntyped(data);
                Map<String,Object> urls = (Map<String,Object>)result.get('urls');
                Url rest = new Url((String)urls.get('rest'));
                protocolAndHost_var = rest.getProtocol() + '://' + rest.getHost();
           
    
            return protocolAndHost_var;
        
    }
  
  
  
  
  private static Comision__c Crea_Cedula_Asesor(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Comisiones Asesores').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;

    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_NomEquipo;
    String strField_NumEquipo;
    String strField_RolVentas;
    String strField_FormaPago;
    String strField_Nombre;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Nombre = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        } else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        } else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        }

    }
    
   
    
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Prospectador_Asesor_de_Comision__c> list_objProspAsCom = new List<Prospectador_Asesor_de_Comision__c>();
    String strRecordBuscar='';
    Prospectador_Asesor_de_Comision__c PrpsAsNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field PrspAsesor*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objProspAsCom.add(PrpsAsNew);
            } 
            PrpsAsNew = new Prospectador_Asesor_de_Comision__c();   
            if (Field.Name=='Empleado'){
                PrpsAsNew.Name = Field.Value__c;
            } else if (Field.Name=='Cant Formalizadas'){
                PrpsAsNew.Cantidad_Formalizadas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Escrituradas'){
                PrpsAsNew.Cantidad_Escrituradas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Canceladas'){
                PrpsAsNew.Cantidad_Canceladas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Total a Pagar'){
                PrpsAsNew.Total_a_Pagar__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Empleado'){
                PrpsAsNew.Name = Field.Value__c;
            } else if (Field.Name=='Cant Formalizadas'){
                PrpsAsNew.Cantidad_Formalizadas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Escrituradas'){
                PrpsAsNew.Cantidad_Escrituradas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Canceladas'){
                PrpsAsNew.Cantidad_Canceladas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Total a Pagar'){
                PrpsAsNew.Total_a_Pagar__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
        } 
    }
    
    list_objProspAsCom.add(PrpsAsNew);
    
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Forma_Pago__c = strField_FormaPago
                                                , Codigo__c = strField_Codigo
                                                , Nombre__c = strField_Nombre
                                                );
    
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
        
        
        
        if (!list_objProspAsCom.IsEmpty() && objComision!=null){
            List<Prospectador_Asesor_de_Comision__c> list_ProspAs_Ins = new List<Prospectador_Asesor_de_Comision__c>();
            for(Prospectador_Asesor_de_Comision__c ProspAs2Ins : list_objProspAsCom){
                ProspAs2Ins.Comision_Buscar__c= objComision.Id;
                list_ProspAs_Ins.add(ProspAs2Ins);
            }
            if (!list_ProspAs_Ins.IsEmpty()){
                try{
                    insert list_ProspAs_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    return objComision;
  }
  
  //Comision 'Cédula Prospectador'
  private static Comision__c Crea_Cedula_Prospectador(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Comisiones Prospectadores').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_RolVentas;
    String strField_FormaPago;
    String strField_NomEquipo;
    String strField_NumEquipo;
    
    
    String strField_Nombre;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Nombre = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        }  else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        }  else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        }else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } 
        
        

         
    }
    
        
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Prospectador_Asesor_de_Comision__c> list_objProspAsCom = new List<Prospectador_Asesor_de_Comision__c>();
    String strRecordBuscar='';
    Prospectador_Asesor_de_Comision__c PrpsAsNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objProspAsCom.add(PrpsAsNew);
            } 
            PrpsAsNew = new Prospectador_Asesor_de_Comision__c();   
            if (Field.Name=='Empleado'){
                PrpsAsNew.Name = Field.Value__c;
            } else if (Field.Name=='Cant Reservas'){
                PrpsAsNew.Cantidad_Reservadas__c = asignaOLimpiaValorDouble(Field.Value__c);
            }else if (Field.Name=='Cant Formalizadas'){
                PrpsAsNew.Cantidad_Formalizadas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Escrituradas'){
                PrpsAsNew.Cantidad_Escrituradas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Exigibles'){
                PrpsAsNew.Cantidad_Exigibles__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Canceladas'){
                PrpsAsNew.Cantidad_Canceladas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Total a Pagar'){
                PrpsAsNew.Total_a_Pagar__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Empleado'){
                PrpsAsNew.Name = Field.Value__c;
            } else if (Field.Name=='Cant Reservas'){
                PrpsAsNew.Cantidad_Reservadas__c = asignaOLimpiaValorDouble(Field.Value__c);
            }else if (Field.Name=='Cant Formalizadas'){
                PrpsAsNew.Cantidad_Formalizadas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Escrituradas'){
                PrpsAsNew.Cantidad_Escrituradas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Exigibles'){
                PrpsAsNew.Cantidad_Exigibles__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Cant Canceladas'){
                PrpsAsNew.Cantidad_Canceladas__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Total a Pagar'){
                PrpsAsNew.Total_a_Pagar__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
        }
    }
    list_objProspAsCom.add(PrpsAsNew);
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Nombre__c = strField_Nombre
                                                , Codigo__c = strField_Codigo
                                                , Forma_Pago__c = strField_FormaPago
                                                );
        
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        if (!list_objProspAsCom.IsEmpty() && objComision!=null){
            List<Prospectador_Asesor_de_Comision__c> list_ProspAs_Ins = new List<Prospectador_Asesor_de_Comision__c>();
            for(Prospectador_Asesor_de_Comision__c ProspAs2Ins : list_objProspAsCom){
                ProspAs2Ins.Comision_Buscar__c= objComision.Id;
                list_ProspAs_Ins.add(ProspAs2Ins);
            }
            if (!list_ProspAs_Ins.IsEmpty()){
                try{
                    insert list_ProspAs_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    
    return objComision;
    
  }
  
  
  private static Comision__c Crea_PlanComAsesor(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Base Comisiones Asesores').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_RolVentas;
    String strField_Tipo;
    String strField_FormaPago;
    String strField_NomEquipo;
    String strField_NumEquipo;
    
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Name = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Tipo'){
            strField_Tipo = Field.Value__c;
        } else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        } else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        } else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        } 

         
    }
    
        
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Pago_por_Categoria__c> list_objPagoPorCat = new List<Pago_por_Categoria__c>();
    String strRecordBuscar='';
    Pago_por_Categoria__c PagoPorCatNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objPagoPorCat.add(PagoPorCatNew);
            } 
            PagoPorCatNew = new Pago_por_Categoria__c();    
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Base'){
                PagoPorCatNew.Base_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Cumplimiento'){
                PagoPorCatNew.Cumplimiento_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Excedente'){
                PagoPorCatNew.Excedente_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Base'){
                PagoPorCatNew.Base_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Cumplimiento'){
                PagoPorCatNew.Cumplimiento_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Excedente'){
                PagoPorCatNew.Excedente_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
        }
    }
    list_objPagoPorCat.add(PagoPorCatNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 3
    Set<Id> set_idRecord_Etapas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_3 ORDER BY Name Asc] ){
        set_idRecord_Etapas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Etapa__c> list_objEtapa = new List<Etapa__c>();
    strRecordBuscar='';
    Etapa__c EtapaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Etapas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objEtapa.add(EtapaNew);
            } 
            EtapaNew = new Etapa__c();  
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        } 
    }
    list_objEtapa.add(EtapaNew);
    
   
    // Obtiene datos de varios records de la lista relacionada 4
    Set<Id> set_idRecord_Metas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_4 ORDER BY Name Asc] ){
        set_idRecord_Metas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Meta_del_Plan__c> list_objMeta = new List<Meta_del_Plan__c>();
    strRecordBuscar='';
    Meta_del_Plan__c MetaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Metas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objMeta.add(MetaNew);
            } 
            MetaNew = new Meta_del_Plan__c();  
            if (Field.Name=='Meta Grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
             if (Field.Name=='Meta Grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
        } 
    }
    list_objMeta.add(MetaNew);
    
    
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Codigo__c = strField_Codigo
                                                
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Tipo__c = strField_Tipo
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Forma_Pago__c = strField_FormaPago
                                                );
    
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        
        
        if ((!list_objPagoPorCat.IsEmpty() && list_objPagoPorCat!=NULL)  && objComision!=null){
            List<Pago_por_Categoria__c> list_PagoPorCat_Ins = new List<Pago_por_Categoria__c>();
            for(Pago_por_Categoria__c PagoPorCat2Ins : list_objPagoPorCat){
                System.Debug('***PagoPorCat2Ins*** '+PagoPorCat2Ins);
                PagoPorCat2Ins.Comision_Buscar__c= objComision.Id;
                list_PagoPorCat_Ins.add(PagoPorCat2Ins);
            }
            if (!list_PagoPorCat_Ins.IsEmpty()){
                try{
                    insert list_PagoPorCat_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ((!list_objEtapa.IsEmpty()  && list_objEtapa!=NULL)  && objComision!=null){
            List<Etapa__c> list_Etapa_Ins = new List<Etapa__c>();
            for(Etapa__c Etapa2Ins : list_objEtapa){
                 System.Debug('***Etapa2Ins*** '+Etapa2Ins);
                Etapa2Ins.Comision_Buscar__c= objComision.Id;
                list_Etapa_Ins.add(Etapa2Ins);
            }
            if (!list_Etapa_Ins.IsEmpty()){
                try{
                    insert list_Etapa_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
          
        if ((!list_objMeta.IsEmpty()  && list_objMeta!=NULL)  && objComision!=null){
            List<Meta_del_Plan__c> list_Meta_Ins = new List<Meta_del_Plan__c>();
            for(Meta_del_Plan__c Meta2Ins : list_objMeta){
                 System.Debug('***Meta2Ins*** '+Meta2Ins);
                Meta2Ins.Comision_Buscar__c= objComision.Id;
                list_Meta_Ins.add(Meta2Ins);
            }
            if (!list_Meta_Ins.IsEmpty()){
                try{
                    insert list_Meta_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }  
    
    
    
    
    return objComision;
  }
  
  //Comision
  private static Comision__c Crea_PlanComProsp(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Base Comisiones Prospectadores').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_NomEquipo;
    String strField_NumEquipo;
    String strField_RolVentas;
    String strField_Tipo;
    String strField_FormaPago;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Name = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Tipo'){
            strField_Tipo = Field.Value__c;
        } else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        } else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        } else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        } 

         
    }
    
        
    
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Pago_por_Categoria__c> list_objPagoPorCat = new List<Pago_por_Categoria__c>();
    String strRecordBuscar='';
    Pago_por_Categoria__c PagoPorCatNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objPagoPorCat.add(PagoPorCatNew);
            } 
            PagoPorCatNew = new Pago_por_Categoria__c();    
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Base'){
                PagoPorCatNew.Base_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Cumplimiento'){
                PagoPorCatNew.Cumplimiento_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Excedente'){
                PagoPorCatNew.Excedente_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Base'){
                PagoPorCatNew.Base_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Cumplimiento'){
                PagoPorCatNew.Cumplimiento_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Excedente'){
                PagoPorCatNew.Excedente_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
        }
    }
    list_objPagoPorCat.add(PagoPorCatNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 3
    Set<Id> set_idRecord_Etapas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_3 ORDER BY Name Asc] ){
        set_idRecord_Etapas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Etapa__c> list_objEtapa = new List<Etapa__c>();
    strRecordBuscar='';
    Etapa__c EtapaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Etapas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objEtapa.add(EtapaNew);
            } 
            EtapaNew = new Etapa__c();  
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        } 
    }
    list_objEtapa.add(EtapaNew);
    
    // Obtiene datos de varios records de la lista relacionada 4
    Set<Id> set_idRecord_Metas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_4 ORDER BY Name Asc] ){
        set_idRecord_Metas.add(Record.Id);
    }
    //System.Debug('***set_idRecord_Metas*** '+set_idRecord_Metas);
    List<Meta_del_Plan__c> list_objMetaPlan = new List<Meta_del_Plan__c>();
    strRecordBuscar='';
    Meta_del_Plan__c MetaPlanNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Metas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objMetaPlan.add(MetaPlanNew);
            } 
            MetaPlanNew = new Meta_del_Plan__c();   
            if (Field.Name=='Meta Grupal'){
                MetaPlanNew.Name = 'Meta Grupal ' + Field.Value__c;
            } else if (Field.Name=='Meta Individual'){
                MetaPlanNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='No Miembros'){
                MetaPlanNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Meta Grupal'){
                MetaPlanNew.Name =  'Meta Grupal ' + Field.Value__c;
            } else if (Field.Name=='Meta Individual'){
                MetaPlanNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='No Miembros'){
                MetaPlanNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
        }
        //System.Debug('***list_objMetaPlan 0*** '+list_objMetaPlan); 
    }
    list_objMetaPlan.add(MetaPlanNew);
    //System.Debug('***list_objMetaPlan 1*** '+list_objMetaPlan); 
    
    //System.Debug('***map_strEmpClave_UsrId*** '+map_strEmpClave_UsrId);
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Tipo__c = strField_Tipo
                                                , Forma_Pago__c = strField_FormaPago
                                                );
        
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        
        
        if ((!list_objPagoPorCat.IsEmpty()  && list_objPagoPorCat!=NULL) && objComision!=null){
            List<Pago_por_Categoria__c> list_PagoPorCat_Ins = new List<Pago_por_Categoria__c>();
            for(Pago_por_Categoria__c PagoPorCat2Ins : list_objPagoPorCat){
                PagoPorCat2Ins.Comision_Buscar__c= objComision.Id;
                list_PagoPorCat_Ins.add(PagoPorCat2Ins);
            }
            if (!list_PagoPorCat_Ins.IsEmpty()){
                try{
                    insert list_PagoPorCat_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ( (!list_objEtapa.IsEmpty()  && list_objEtapa!=NULL)  && objComision!=null){
            List<Etapa__c> list_Etapa_Ins = new List<Etapa__c>();
            for(Etapa__c Etapa2Ins : list_objEtapa){
                Etapa2Ins.Comision_Buscar__c= objComision.Id;
                list_Etapa_Ins.add(Etapa2Ins);
            }
            if (!list_Etapa_Ins.IsEmpty()){
                try{
                    insert list_Etapa_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        System.Debug('***objComision*** '+objComision);
        
        if ( (!list_objMetaPlan.IsEmpty()  && list_objMetaPlan!=NULL)   && objComision!=null){
            List<Meta_del_Plan__c> list_MetaPlan_Ins = new List<Meta_del_Plan__c>();
            for(Meta_del_Plan__c MetaPlan2Ins : list_objMetaPlan){
                //System.Debug('***MetaPlan2Ins*** '+MetaPlan2Ins);
                MetaPlan2Ins.Comision_Buscar__c= objComision.Id;
                list_MetaPlan_Ins.add(MetaPlan2Ins);
            }
            if (!list_MetaPlan_Ins.IsEmpty()){
                try{
                    insert list_MetaPlan_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    
    return objComision;
  }
  
  //Comision 'Plan Bono Asesor'
  private static Comision__c Crea_PlanBonoAsesor(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono Asesor').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_RolVentas;
    String strField_Tipo;
    String strField_FormaPago;
    String strField_NomEquipo;
    String strField_NumEquipo;
    
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Name = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Tipo'){
            strField_Tipo = Field.Value__c;
        } else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        } else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        } else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        } 

         
    }
    
        
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Pago_por_Categoria__c> list_objPagoPorCat = new List<Pago_por_Categoria__c>();
    String strRecordBuscar='';
    Pago_por_Categoria__c PagoPorCatNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objPagoPorCat.add(PagoPorCatNew);
            } 
            PagoPorCatNew = new Pago_por_Categoria__c();    
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
        }
    }
    list_objPagoPorCat.add(PagoPorCatNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 3
    Set<Id> set_idRecord_Etapas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_3 ORDER BY Name Asc] ){
        set_idRecord_Etapas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Etapa__c> list_objEtapa = new List<Etapa__c>();
    strRecordBuscar='';
    Etapa__c EtapaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Etapas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objEtapa.add(EtapaNew);
            } 
            EtapaNew = new Etapa__c();  
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        } 
    }
    list_objEtapa.add(EtapaNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 4
    Set<Id> set_idRecord_Metas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_4 ORDER BY Name Asc] ){
        set_idRecord_Metas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Meta_del_Plan__c> list_objMeta = new List<Meta_del_Plan__c>();
    strRecordBuscar='';
    Meta_del_Plan__c MetaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Metas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objMeta.add(MetaNew);
            } 
            MetaNew = new Meta_del_Plan__c();  
            if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
             if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
        } 
    }
    list_objMeta.add(MetaNew);
    
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Codigo__c = strField_Codigo
                                                
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Tipo__c = strField_Tipo
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Forma_Pago__c = strField_FormaPago
                                                );
    
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        System.Debug('***objComision*** '+objComision);
        System.Debug('***list_objPagoPorCat*** '+list_objPagoPorCat);
        System.Debug('***list_objPagoPorCat.Size()*** '+list_objPagoPorCat.Size());
        if ( list_objPagoPorCat.Size()>0 && list_objPagoPorCat!=null  && objComision!=null){
            List<Pago_por_Categoria__c> list_PagoPorCat_Ins = new List<Pago_por_Categoria__c>();
            for(Pago_por_Categoria__c PagoPorCat2Ins : list_objPagoPorCat){
                System.Debug('***PagoPorCat2Ins*** '+PagoPorCat2Ins);
                if (PagoPorCat2Ins!=null){
                    PagoPorCat2Ins.Comision_Buscar__c= objComision.Id;
                  list_PagoPorCat_Ins.add(PagoPorCat2Ins);
                } 
                // No presenta lista relacionada
                else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
                }
                
            }
            if (!list_PagoPorCat_Ins.IsEmpty()){
                try{
                    insert list_PagoPorCat_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ((!list_objEtapa.IsEmpty()  && list_objEtapa!=NULL)  && objComision!=null){
            List<Etapa__c> list_Etapa_Ins = new List<Etapa__c>();
            for(Etapa__c Etapa2Ins : list_objEtapa){
                 System.Debug('***Etapa2Ins*** '+Etapa2Ins);
                
                if (Etapa2Ins!=null){
                    Etapa2Ins.Comision_Buscar__c= objComision.Id;
                  list_Etapa_Ins.add(Etapa2Ins);
                } 
                // No presenta lista relacionada
                else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
                }
                
            }
            if (!list_Etapa_Ins.IsEmpty()){
                try{
                    insert list_Etapa_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
          
        if ((!list_objMeta.IsEmpty()  && list_objMeta!=NULL)  && objComision!=null){
            List<Meta_del_Plan__c> list_Meta_Ins = new List<Meta_del_Plan__c>();
            for(Meta_del_Plan__c Meta2Ins : list_objMeta){
                 System.Debug('***Meta2Ins*** '+Meta2Ins);
                
                if (Meta2Ins!=null){
                    Meta2Ins.Comision_Buscar__c= objComision.Id;
                  list_Meta_Ins.add(Meta2Ins);
                } 
                // No presenta lista relacionada
                else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
                }
            }
            if (!list_Meta_Ins.IsEmpty()){
                try{
                    insert list_Meta_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }  

    return objComision;
    
  }
    
  //Comision 'Plan Bono Col. Javer'
  private static Comision__c Crea_PlanBonoColJaver(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono Col. Javer').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_RolVentas;
    String strField_Tipo;
    String strField_FormaPago;
    String strField_NomEquipo;
    String strField_NumEquipo;
    
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Name = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Tipo'){
            strField_Tipo = Field.Value__c;
        } else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        } else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        } else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        } 

         
    }
    
        
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Pago_por_Categoria__c> list_objPagoPorCat = new List<Pago_por_Categoria__c>();
    String strRecordBuscar='';
    Pago_por_Categoria__c PagoPorCatNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objPagoPorCat.add(PagoPorCatNew);
            } 
            PagoPorCatNew = new Pago_por_Categoria__c();    
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
        }
    }
    list_objPagoPorCat.add(PagoPorCatNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 3
    Set<Id> set_idRecord_Etapas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_3 ORDER BY Name Asc] ){
        set_idRecord_Etapas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Etapa__c> list_objEtapa = new List<Etapa__c>();
    strRecordBuscar='';
    Etapa__c EtapaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Etapas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objEtapa.add(EtapaNew);
            } 
            EtapaNew = new Etapa__c();  
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        } 
    }
    list_objEtapa.add(EtapaNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 4
    Set<Id> set_idRecord_Metas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_4 ORDER BY Name Asc] ){
        set_idRecord_Metas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Meta_del_Plan__c> list_objMeta = new List<Meta_del_Plan__c>();
    strRecordBuscar='';
    Meta_del_Plan__c MetaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Metas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objMeta.add(MetaNew);
            } 
            MetaNew = new Meta_del_Plan__c();  
            if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
             if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
        } 
    }
    list_objMeta.add(MetaNew);
    
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Codigo__c = strField_Codigo
                                                
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Tipo__c = strField_Tipo
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Forma_Pago__c = strField_FormaPago
                                                );
    
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        System.Debug('***objComision*** '+objComision);
        
        if ((!list_objPagoPorCat.IsEmpty() && list_objPagoPorCat!=NULL)  && objComision!=null){
            List<Pago_por_Categoria__c> list_PagoPorCat_Ins = new List<Pago_por_Categoria__c>();
            for(Pago_por_Categoria__c PagoPorCat2Ins : list_objPagoPorCat){
                System.Debug('***PagoPorCat2Ins*** '+PagoPorCat2Ins);
                PagoPorCat2Ins.Comision_Buscar__c= objComision.Id;
                list_PagoPorCat_Ins.add(PagoPorCat2Ins);
            }
            if (!list_PagoPorCat_Ins.IsEmpty()){
                try{
                    insert list_PagoPorCat_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ((!list_objEtapa.IsEmpty()  && list_objEtapa!=NULL)  && objComision!=null){
            List<Etapa__c> list_Etapa_Ins = new List<Etapa__c>();
            for(Etapa__c Etapa2Ins : list_objEtapa){
                 System.Debug('***Etapa2Ins*** '+Etapa2Ins);
                Etapa2Ins.Comision_Buscar__c= objComision.Id;
                list_Etapa_Ins.add(Etapa2Ins);
            }
            if (!list_Etapa_Ins.IsEmpty()){
                try{
                    insert list_Etapa_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
          
        if ((!list_objMeta.IsEmpty()  && list_objMeta!=NULL)  && objComision!=null){
            List<Meta_del_Plan__c> list_Meta_Ins = new List<Meta_del_Plan__c>();
            for(Meta_del_Plan__c Meta2Ins : list_objMeta){
                 System.Debug('***Meta2Ins*** '+Meta2Ins);
                Meta2Ins.Comision_Buscar__c= objComision.Id;
                list_Meta_Ins.add(Meta2Ins);
            }
            if (!list_Meta_Ins.IsEmpty()){
                try{
                    insert list_Meta_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }  
    
    return objComision;
    
  }
      
  //Comision 'Plan Bono Prospectador'
  private static Comision__c Crea_PlanBonoProspectador(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono Prospectador').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_RolVentas;
    String strField_Tipo;
    String strField_FormaPago;
    String strField_NomEquipo;
    String strField_NumEquipo;
    
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Name = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Tipo'){
            strField_Tipo = Field.Value__c;
        } else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        } else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        } else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        } 

         
    }
    
        
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Pago_por_Categoria__c> list_objPagoPorCat = new List<Pago_por_Categoria__c>();
    String strRecordBuscar='';
    Pago_por_Categoria__c PagoPorCatNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objPagoPorCat.add(PagoPorCatNew);
            } 
            PagoPorCatNew = new Pago_por_Categoria__c();    
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
        }
    }
    list_objPagoPorCat.add(PagoPorCatNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 3
    Set<Id> set_idRecord_Etapas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_3 ORDER BY Name Asc] ){
        set_idRecord_Etapas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Etapa__c> list_objEtapa = new List<Etapa__c>();
    strRecordBuscar='';
    Etapa__c EtapaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Etapas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objEtapa.add(EtapaNew);
            } 
            EtapaNew = new Etapa__c();  
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        } 
    }
    list_objEtapa.add(EtapaNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 4
    Set<Id> set_idRecord_Metas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_4 ORDER BY Name Asc] ){
        set_idRecord_Metas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Meta_del_Plan__c> list_objMeta = new List<Meta_del_Plan__c>();
    strRecordBuscar='';
    Meta_del_Plan__c MetaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Metas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objMeta.add(MetaNew);
            } 
            MetaNew = new Meta_del_Plan__c();  
            if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
             if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
        } 
    }
    list_objMeta.add(MetaNew);
    
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Codigo__c = strField_Codigo
                                                
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Tipo__c = strField_Tipo
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Forma_Pago__c = strField_FormaPago
                                                );
    
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        System.Debug('***objComision*** '+objComision);
        
        if ((!list_objPagoPorCat.IsEmpty() && list_objPagoPorCat!=NULL)  && objComision!=null){
            List<Pago_por_Categoria__c> list_PagoPorCat_Ins = new List<Pago_por_Categoria__c>();
            for(Pago_por_Categoria__c PagoPorCat2Ins : list_objPagoPorCat){
                System.Debug('***PagoPorCat2Ins*** '+PagoPorCat2Ins);
                PagoPorCat2Ins.Comision_Buscar__c= objComision.Id;
                list_PagoPorCat_Ins.add(PagoPorCat2Ins);
            }
            if (!list_PagoPorCat_Ins.IsEmpty()){
                try{
                    insert list_PagoPorCat_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ((!list_objEtapa.IsEmpty()  && list_objEtapa!=NULL)  && objComision!=null){
            List<Etapa__c> list_Etapa_Ins = new List<Etapa__c>();
            for(Etapa__c Etapa2Ins : list_objEtapa){
                 System.Debug('***Etapa2Ins*** '+Etapa2Ins);
                Etapa2Ins.Comision_Buscar__c= objComision.Id;
                list_Etapa_Ins.add(Etapa2Ins);
            }
            if (!list_Etapa_Ins.IsEmpty()){
                try{
                    insert list_Etapa_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
          
        if ((!list_objMeta.IsEmpty() && list_objMeta!=NULL)  && objComision!=null){
            List<Meta_del_Plan__c> list_Meta_Ins = new List<Meta_del_Plan__c>();
            for(Meta_del_Plan__c Meta2Ins : list_objMeta){
                 System.Debug('***Meta2Ins*** '+Meta2Ins);
                Meta2Ins.Comision_Buscar__c= objComision.Id;
                list_Meta_Ins.add(Meta2Ins);
            }
            if (!list_Meta_Ins.IsEmpty()){
                try{
                    insert list_Meta_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }  

    return objComision;
    
  }
    
    
  
  //Comision 'Plan Bono_Col. Javer'
  private static Comision__c Crea_PlanBono_ColJaver(approvalObject__c ApprvObj){
    String rtComisiones = Schema.SObjectType.Comision__c.getRecordTypeInfosByName().get('Plan Bono_Col. Javer').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_RolVentas;
    String strField_Tipo;
    String strField_FormaPago;
    String strField_NomEquipo;
    String strField_NumEquipo;
    
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
        
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Nombre'){
            strField_Name = Field.Value__c;
        } else if (Field.Name=='Codigo'){
            strField_Codigo = Field.Value__c;
        } else if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Tipo'){
            strField_Tipo = Field.Value__c;
        } else if (Field.Name=='Rol Ventas'){
            strField_RolVentas = Field.Value__c;
        } else if (Field.Name=='Forma Pago'){
            strField_FormaPago = Field.Value__c;
        } else if (Field.Name=='Numero Equipo'){
            strField_NumEquipo = Field.Value__c;
        } else if (Field.Name=='Nombre Equipo'){
            strField_NomEquipo = Field.Value__c;
        } 

         
    }
    
        
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Pago_por_Categoria__c> list_objPagoPorCat = new List<Pago_por_Categoria__c>();
    String strRecordBuscar='';
    Pago_por_Categoria__c PagoPorCatNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objPagoPorCat.add(PagoPorCatNew);
            } 
            PagoPorCatNew = new Pago_por_Categoria__c();    
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Categoria'){
                PagoPorCatNew.Name = Field.Value__c;
            } else if (Field.Name=='Valor del Bono'){
                PagoPorCatNew.Valor_del_Bono__c = Field.Value__c;
            }
        }
    }
    list_objPagoPorCat.add(PagoPorCatNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 3
    Set<Id> set_idRecord_Etapas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_3 ORDER BY Name Asc] ){
        set_idRecord_Etapas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Etapa__c> list_objEtapa = new List<Etapa__c>();
    strRecordBuscar='';
    Etapa__c EtapaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Etapas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objEtapa.add(EtapaNew);
            } 
            EtapaNew = new Etapa__c();  
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Etapa Venta'){
                EtapaNew.Name = Field.Value__c;
            } else if (Field.Name=='Pct Pago'){
                EtapaNew.Pago_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        } 
    }
    list_objEtapa.add(EtapaNew);
    
    
    // Obtiene datos de varios records de la lista relacionada 4
    Set<Id> set_idRecord_Metas = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_4 ORDER BY Name Asc] ){
        set_idRecord_Metas.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Meta_del_Plan__c> list_objMeta = new List<Meta_del_Plan__c>();
    strRecordBuscar='';
    Meta_del_Plan__c MetaNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord_Metas ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objMeta.add(MetaNew);
            } 
            MetaNew = new Meta_del_Plan__c();  
            if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
             if (Field.Name=='Meta grupal'){
                MetaNew.Name = 'Meta Grupal '+Field.Value__c;
            } else if (Field.Name=='No Miembros'){
                MetaNew.Num_Miembros__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Meta Individual'){
                MetaNew.Meta_Individual__c = asignaOLimpiaValor(Field.Value__c);
            }
        } 
    }
    list_objMeta.add(MetaNew);
    
    Comision__c objComision;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objComision = new Comision__c(RecordTypeId= rtComisiones
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Codigo__c = strField_Codigo
                                                
                                                , Objeto_a_Aprobar__c = ApprvObj.Name
                                                , Rol_Ventas__c = strField_RolVentas
                                                , Tipo__c = strField_Tipo
                                                , Nombre_Equipo__c = strField_NomEquipo
                                                , No_Equipo__c = strField_NumEquipo
                                                , Forma_Pago__c = strField_FormaPago
                                                );
    
        try{
            insert objComision;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        System.Debug('***objComision*** '+objComision);
        
        if ((!list_objPagoPorCat.IsEmpty() && list_objPagoPorCat!=NULL)  && objComision!=null){
            List<Pago_por_Categoria__c> list_PagoPorCat_Ins = new List<Pago_por_Categoria__c>();
            for(Pago_por_Categoria__c PagoPorCat2Ins : list_objPagoPorCat){
                System.Debug('***PagoPorCat2Ins*** '+PagoPorCat2Ins);
                PagoPorCat2Ins.Comision_Buscar__c= objComision.Id;
                list_PagoPorCat_Ins.add(PagoPorCat2Ins);
            }
            if (!list_PagoPorCat_Ins.IsEmpty()){
                try{
                    insert list_PagoPorCat_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ((!list_objEtapa.IsEmpty() && list_objEtapa!=NULL)  && objComision!=null){
            List<Etapa__c> list_Etapa_Ins = new List<Etapa__c>();
            for(Etapa__c Etapa2Ins : list_objEtapa){
                 System.Debug('***Etapa2Ins*** '+Etapa2Ins);
                Etapa2Ins.Comision_Buscar__c= objComision.Id;
                list_Etapa_Ins.add(Etapa2Ins);
            }
            if (!list_Etapa_Ins.IsEmpty()){
                try{
                    insert list_Etapa_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
          
        if ((!list_objMeta.IsEmpty()  && list_objMeta!=NULL)  && objComision!=null){
            List<Meta_del_Plan__c> list_Meta_Ins = new List<Meta_del_Plan__c>();
            for(Meta_del_Plan__c Meta2Ins : list_objMeta){
                 System.Debug('***Meta2Ins*** '+Meta2Ins);
                Meta2Ins.Comision_Buscar__c= objComision.Id;
                list_Meta_Ins.add(Meta2Ins);
            }
            if (!list_Meta_Ins.IsEmpty()){
                try{
                    insert list_Meta_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }  
    
    return objComision;
    
  }
  
  //Planning 'Extension de Periodos'
  private static Planning__c Crea_PlannPeriodoVenta(approvalObject__c ApprvObj){
    String rtPlanning = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Periodo de Venta').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_IniPeriodo;
    String strField_Extension;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Inicio Periodo'){
            strField_IniPeriodo = Field.Value__c;
        }  else if (Field.Name=='Fin Periodo'){
            strField_FinPeriodo = Field.Value__c;
        } else if (Field.Name=='Extension'){
            strField_Extension = Field.Value__c;
        }
    }
    
    Planning__c objPlanninng;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPlanninng = new Planning__c(RecordTypeId= rtPlanning
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Fraccionamiento__c= strAppvObjFrccName
                                                
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Periodo_Actual__c = strField_Periodo
                                                , Fecha_Fin__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_FinPeriodo)
                                                , Fecha_Inicio__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_IniPeriodo)
                                                , Fecha_Fin_Extension__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_Extension)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
        try{
            insert objPlanninng;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }    
    
    
    return objPlanninng;
  }
  
  //Planning 'Bonificaciones Batch'
  private static Planning__c Crea_BonBatch(approvalObject__c ApprvObj){
    String rtPlanning = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Bonificaciones Batch').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Periodo'){
            strField_Periodo = Field.Value__c;
        } else if (Field.Name=='Fin Periodo'){
            strField_FinPeriodo = Field.Value__c;
        } else if (Field.Name=='Extension'){
            strField_Extension = Field.Value__c;
        }
    }
    
        
    Planning__c objPlanninng;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPlanninng = new Planning__c(RecordTypeId= rtPlanning
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Periodo_Actual__c = strField_Periodo
                                                , Fecha_Fin__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_FinPeriodo)
                                                , Fecha_Fin_Extension__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_Extension)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        try{
            insert objPlanninng;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    return objPlanninng;
  }
  
  //Planning 'Lista de Bonificaciones Batch'
  private static Planning__c Crea_ListBonBatch(approvalObject__c ApprvObj){
    String rtPlanning = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Bonificaciones').getRecordTypeId();
    String rtListaDePlanning = Schema.SObjectType.Lista_de_Planning__c.getRecordTypeInfosByName().get('Listas de Bonificaciones').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_ListPlanningFracc;
    String strField_ListPlanningPeriodo;
    String strField_ListPlanningPrototipo;
    String strField_ListPlanningNomBon;
    String strField_ListPlanningTipo;
    String strField_ListPlanningClase;
    String strField_ListPlanningMonto;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    
    // Obtiene datos del varios records de la lista relacionada 1
    // No existe lista relacionada para copiar al registro master
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Lista_de_Planning__c> list_objListaDePlanning = new List<Lista_de_Planning__c>();
    String strRecordBuscar='';
    Lista_de_Planning__c ListaDePlanningNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objListaDePlanning.add(ListaDePlanningNew);
            } 
            ListaDePlanningNew = new Lista_de_Planning__c();    
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c  = strField_ListPlanningFracc =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c  =  strField_Periodo =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Nombre Bonificacion'){
                ListaDePlanningNew.Nombre_Lista_de_Bonificacion__c  = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Tipo'){
                ListaDePlanningNew.Tipo_de_Bonificacion__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Clase'){
                ListaDePlanningNew.Clase_Bonificacion__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Monto/Porcentaje'){
                ListaDePlanningNew.Monto_o_Porcentaje__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c  = strField_ListPlanningFracc =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c  =  strField_Periodo =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Nombre Bonificacion'){
                ListaDePlanningNew.Nombre_Lista_de_Bonificacion__c = ListaDePlanningNew.Name = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Tipo'){
                ListaDePlanningNew.Tipo_de_Bonificacion__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Clase'){
                ListaDePlanningNew.Clase_Bonificacion__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Monto/Porcentaje'){
                ListaDePlanningNew.Monto_o_Porcentaje__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        }
        //System.Debug('***list_objMetaPlan 0*** '+list_objMetaPlan); 
    }
    list_objListaDePlanning.add(ListaDePlanningNew);
    
        
    Planning__c objPlanninng;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPlanninng = new Planning__c(RecordTypeId= rtPlanning
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Fraccionamiento__c = strField_ListPlanningFracc
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
        try{
            insert objPlanninng;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        if (!list_objListaDePlanning.IsEmpty() && objPlanninng!=null){
            List<Lista_de_Planning__c> list_ListaDePlanning_Ins = new List<Lista_de_Planning__c>();
            for(Lista_de_Planning__c ListaDePlanning2Ins : list_objListaDePlanning){
                ListaDePlanning2Ins.Planning_Buscar__c= objPlanninng.Id;
                ListaDePlanning2Ins.RecordTypeId = rtListaDePlanning;
                list_ListaDePlanning_Ins.add(ListaDePlanning2Ins);
            }
            if (!list_ListaDePlanning_Ins.IsEmpty()){
                try{
                    insert list_ListaDePlanning_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    return objPlanninng;
  }
  
  //Planning 'Lista de Financiamientos Batch'
  private static Planning__c Crea_ListFinBatch(approvalObject__c ApprvObj){
    String rtPlanning = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Financiamiento').getRecordTypeId(); 
    String rtListaDePlanning = Schema.SObjectType.Lista_de_Planning__c.getRecordTypeInfosByName().get('Listas de Financiamiento').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_ListPlanningFracc;
    String strField_ListPlanningPeriodo;
    String strField_ListPlanningPrototipo;
    String strField_ListPlanningNomBon;
    String strField_ListPlanningTipo;
    String strField_ListPlanningClase;
    String strField_ListPlanningMonto;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    
    // Obtiene datos del varios records de la lista relacionada 1
    // No existe lista relacionada para copiar al registro master
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Lista_de_Planning__c> list_objListaDePlanning = new List<Lista_de_Planning__c>();
    String strRecordBuscar='';
    Lista_de_Planning__c ListaDePlanningNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objListaDePlanning.add(ListaDePlanningNew);
            } 
            ListaDePlanningNew = new Lista_de_Planning__c();    
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c =  strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Nombre Financiamiento'){
                ListaDePlanningNew.Nombre_Lista_de_Financiamiento__c   = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Categoria'){
                ListaDePlanningNew.Categoria_Financiamiento__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Tipo'){
                ListaDePlanningNew.Tipo_de_Financiamiento__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Plazo'){
                ListaDePlanningNew.Plazo__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Monto/Porcentaje'){
                ListaDePlanningNew.Monto_o_Porcentaje__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c =  strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Nombre Financiamiento'){
                ListaDePlanningNew.Nombre_Lista_de_Financiamiento__c   = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Categoria'){
                ListaDePlanningNew.Categoria_Financiamiento__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Tipo'){
                ListaDePlanningNew.Tipo_de_Financiamiento__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Plazo'){
                ListaDePlanningNew.Plazo__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Monto/Porcentaje'){
                ListaDePlanningNew.Monto_o_Porcentaje__c = asignaOLimpiaValorDouble(Field.Value__c);
            }  
        }
        //System.Debug('***list_objMetaPlan 0*** '+list_objMetaPlan); 
    }
    list_objListaDePlanning.add(ListaDePlanningNew);
    
        
    Planning__c objPlanninng;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPlanninng = new Planning__c(RecordTypeId= rtPlanning
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Fraccionamiento__c = strField_ListPlanningFracc
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        try{
            insert objPlanninng;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        if (!list_objListaDePlanning.IsEmpty() && objPlanninng!=null){
            List<Lista_de_Planning__c> list_ListaDePlanning_Ins = new List<Lista_de_Planning__c>();
            for(Lista_de_Planning__c ListaDePlanning2Ins : list_objListaDePlanning){
                ListaDePlanning2Ins.Planning_Buscar__c= objPlanninng.Id;
                ListaDePlanning2Ins.RecordTypeId = rtListaDePlanning;
                list_ListaDePlanning_Ins.add(ListaDePlanning2Ins);
            }
            if (!list_ListaDePlanning_Ins.IsEmpty()){
                try{
                    insert list_ListaDePlanning_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    return objPlanninng;
  }
  
  //Planning 'Lista de Precios Batch Prods'
  private static Planning__c Crea_ListPrcBatchPrdctos(approvalObject__c ApprvObj){
    String rtPlanning = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Precios Batch Prods').getRecordTypeId(); 
    String rtListaDePlanning = Schema.SObjectType.Lista_de_Planning__c.getRecordTypeInfosByName().get('Lista de Precios Batch Prods').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_ListPlanningFracc;
    String strField_ListPlanningPeriodo;
    String strField_ListPlanningPrototipo;
    String strField_ListPlanningNomBon;
    String strField_ListPlanningTipo;
    String strField_ListPlanningClase;
    String strField_ListPlanningMonto;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
      
    String strPrecio_Lista;
    String strPrecio_Mt_Excedente ;
    String strPrecio_Sobre_Avenida;
    String strPrecio_Cablevision ;
    String strPrecio_Esquina ;
    String strPrecio_Lado_Sol ;
    String strPrecio_Lado_Sombra ;
    String strPrecio_Frente_Parque ;
    String strPrecio_Presupuesto;
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    
    // Obtiene datos del varios records de la lista relacionada 1
    // No existe lista relacionada para copiar al registro master
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Lista_de_Planning__c> list_objListaDePlanning = new List<Lista_de_Planning__c>();
    String strRecordBuscar='';
    Lista_de_Planning__c ListaDePlanningNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objListaDePlanning.add(ListaDePlanningNew);
            } 
            ListaDePlanningNew = new Lista_de_Planning__c();    
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c = strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c  = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Producto'){
                
                ListaDePlanningNew.Producto__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Precio Compra'){
                 
                ListaDePlanningNew.Precio_Compra__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Sugerido'){
                
                ListaDePlanningNew.Precio_Sugerido__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Venta'){
                
                ListaDePlanningNew.Precio_Venta__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c = strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c  = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Producto'){
                
                ListaDePlanningNew.Producto__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Precio Compra'){
                 
                ListaDePlanningNew.Precio_Compra__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Sugerido'){
                
                ListaDePlanningNew.Precio_Sugerido__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Venta'){
                
                ListaDePlanningNew.Precio_Venta__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
        }
        //System.Debug('***list_objMetaPlan 0*** '+list_objMetaPlan); 
    }
    list_objListaDePlanning.add(ListaDePlanningNew);
    
        
    Planning__c objPlanninng;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPlanninng = new Planning__c(RecordTypeId= rtPlanning
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Fraccionamiento__c = strField_ListPlanningFracc
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
        try{
            insert objPlanninng;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        
           
        if (!list_objListaDePlanning.IsEmpty() && objPlanninng!=null){
            List<Lista_de_Planning__c> list_ListaDePlanning_Ins = new List<Lista_de_Planning__c>();
            Integer NumeroListaPlanning =1;
            for(Lista_de_Planning__c ListaDePlanning2Ins : list_objListaDePlanning){
                ListaDePlanning2Ins.Name = String.ValueOf(NumeroListaPlanning++);
                ListaDePlanning2Ins.Planning_Buscar__c= objPlanninng.Id;
                ListaDePlanning2Ins.RecordTypeId = rtListaDePlanning;
                list_ListaDePlanning_Ins.add(ListaDePlanning2Ins);
            }
            if (!list_ListaDePlanning_Ins.IsEmpty()){
                try{
                    insert list_ListaDePlanning_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
     
    
    
    return objPlanninng;
  }
  
  //Planning 'Lista de Precios Batch'
  private static Planning__c Crea_ListPrcBatch(approvalObject__c ApprvObj){
    String rtPlanning = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Precios').getRecordTypeId(); 
    String rtListaDePlanning = Schema.SObjectType.Lista_de_Planning__c.getRecordTypeInfosByName().get('Listas de Precios').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_ListPlanningFracc;
    String strField_ListPlanningPeriodo;
    String strField_ListPlanningPrototipo;
    String strField_ListPlanningNomBon;
    String strField_ListPlanningTipo;
    String strField_ListPlanningClase;
    String strField_ListPlanningMonto;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    String strPrecio_Lista;
    String strPrecio_Mt_Excedente ;
    String strPrecio_Sobre_Avenida;
    String strPrecio_Cablevision ;
    String strPrecio_Esquina ;
    String strPrecio_Lado_Sol ;
    String strPrecio_Lado_Sombra ;
    String strPrecio_Frente_Parque ;
    String strPrecio_Presupuesto;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    
    // Obtiene datos del varios records de la lista relacionada 1
    // No existe lista relacionada para copiar al registro master
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Lista_de_Planning__c> list_objListaDePlanning = new List<Lista_de_Planning__c>();
    String strRecordBuscar='';
    Lista_de_Planning__c ListaDePlanningNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                System.Debug('***ListaDePlanningNew 0*** '+ ListaDePlanningNew);
                list_objListaDePlanning.add(ListaDePlanningNew);
            } 
            ListaDePlanningNew = new Lista_de_Planning__c();    
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c = strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c  = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Precio Lista'){
                strPrecio_Lista = Field.Value__c;
                System.Debug('***strPrecio_Lista*** '+ strPrecio_Lista);
                ListaDePlanningNew.Precio_Lista__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Metro Excedente'){
                 strPrecio_Mt_Excedente  = Field.Value__c;
                 System.Debug('***strPrecio_Mt_Excedente*** '+ strPrecio_Mt_Excedente);
                ListaDePlanningNew.Precio_Mt_Excedente__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Avenida'){
                strPrecio_Sobre_Avenida = Field.Value__c;
                System.Debug('***strPrecio_Sobre_Avenida*** '+ strPrecio_Sobre_Avenida);
                ListaDePlanningNew.Precio_Sobre_Avenida__c = asignaOLimpiaValorDouble(Field.Value__c);
            }  else if (Field.Name=='Precio Area'){
                
                ListaDePlanningNew.Precio_Frente_Area_Municipal__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Cablevision'){
                strPrecio_Cablevision  = Field.Value__c;
                System.Debug('***strPrecio_Cablevision*** '+ strPrecio_Cablevision);
                ListaDePlanningNew.Precio_Cablevision__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Esquina'){
                strPrecio_Esquina  = Field.Value__c;
                System.Debug('***strPrecio_Esquina*** '+ strPrecio_Esquina);
                ListaDePlanningNew.Precio_Esquina__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sol'){
                strPrecio_Lado_Sol  = Field.Value__c;
                System.Debug('***strPrecio_Lado_Sol*** '+ strPrecio_Lado_Sol);
                ListaDePlanningNew.Precio_Lado_Sol__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sombra'){
                strPrecio_Lado_Sombra  = Field.Value__c;
                System.Debug('***strPrecio_Lado_Sombra*** '+ strPrecio_Lado_Sombra);
                ListaDePlanningNew.Precio_Lado_Sombra__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Parque'){
                strPrecio_Frente_Parque  = Field.Value__c;
                System.Debug('***strPrecio_Frente_Parque*** '+ strPrecio_Frente_Parque);
                ListaDePlanningNew.Precio_Frente_Parque__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Presupuesto'){
                
                ListaDePlanningNew.Precio_Presupuesto__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
             
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c = strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c  = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Precio Lista'){
                strPrecio_Lista = Field.Value__c;
                System.Debug('***strPrecio_Lista*** '+ strPrecio_Lista);
                ListaDePlanningNew.Precio_Lista__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Metro Excedente'){
                 strPrecio_Mt_Excedente  = Field.Value__c;
                 System.Debug('***strPrecio_Mt_Excedente*** '+ strPrecio_Mt_Excedente);
                ListaDePlanningNew.Precio_Mt_Excedente__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Avenida'){
                strPrecio_Sobre_Avenida = Field.Value__c;
                System.Debug('***strPrecio_Sobre_Avenida*** '+ strPrecio_Sobre_Avenida);
                ListaDePlanningNew.Precio_Sobre_Avenida__c = asignaOLimpiaValorDouble(Field.Value__c);
            }  else if (Field.Name=='Precio Area'){
                
                ListaDePlanningNew.Precio_Frente_Area_Municipal__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Cablevision'){
                strPrecio_Cablevision  = Field.Value__c;
                System.Debug('***strPrecio_Cablevision*** '+ strPrecio_Cablevision);
                ListaDePlanningNew.Precio_Cablevision__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Esquina'){
                strPrecio_Esquina  = Field.Value__c;
                System.Debug('***strPrecio_Esquina*** '+ strPrecio_Esquina);
                ListaDePlanningNew.Precio_Esquina__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sol'){
                strPrecio_Lado_Sol  = Field.Value__c;
                System.Debug('***strPrecio_Lado_Sol*** '+ strPrecio_Lado_Sol);
                ListaDePlanningNew.Precio_Lado_Sol__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sombra'){
                strPrecio_Lado_Sombra  = Field.Value__c;
                System.Debug('***strPrecio_Lado_Sombra*** '+ strPrecio_Lado_Sombra);
                ListaDePlanningNew.Precio_Lado_Sombra__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Parque'){
                strPrecio_Frente_Parque  = Field.Value__c;
                System.Debug('***strPrecio_Frente_Parque*** '+ strPrecio_Frente_Parque);
                ListaDePlanningNew.Precio_Frente_Parque__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Presupuesto'){
                
                ListaDePlanningNew.Precio_Presupuesto__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
        }
        //System.Debug('***list_objMetaPlan 0*** '+list_objMetaPlan); 
    }
    
    list_objListaDePlanning.add(ListaDePlanningNew);
    
    Planning__c objPlanninng;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPlanninng = new Planning__c(RecordTypeId= rtPlanning
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                , Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                ,Fraccionamiento__c = strField_ListPlanningFracc
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
        try{
            insert objPlanninng;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        if (!list_objListaDePlanning.IsEmpty() && objPlanninng!=null){
            List<Lista_de_Planning__c> list_ListaDePlanning_Ins = new List<Lista_de_Planning__c>();
            Integer NumeroListaPlanning =1;
            for(Lista_de_Planning__c ListaDePlanning2Ins : list_objListaDePlanning){
                ListaDePlanning2Ins.Name = String.ValueOf(NumeroListaPlanning++);
                ListaDePlanning2Ins.Planning_Buscar__c = objPlanninng.Id;
                ListaDePlanning2Ins.RecordTypeId = rtListaDePlanning;
                list_ListaDePlanning_Ins.add(ListaDePlanning2Ins);
            }
            if (!list_ListaDePlanning_Ins.IsEmpty()){
                try{
                    insert list_ListaDePlanning_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
     
    
    
    return objPlanninng;
  }
  
  //Planning 'Lista de Precios'
  private static Planning__c Crea_ListPrc(approvalObject__c ApprvObj){
    String rtPlanning = Schema.SObjectType.Planning__c.getRecordTypeInfosByName().get('Aprobacion Listas de Precios').getRecordTypeId(); 
    String rtListaDePlanning = Schema.SObjectType.Lista_de_Planning__c.getRecordTypeInfosByName().get('Listas de Precios').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_ListPlanningFracc;
    String strField_ListPlanningPeriodo;
    String strField_ListPlanningPrototipo;
    String strField_ListPlanningNomBon;
    String strField_ListPlanningTipo;
    String strField_ListPlanningClase;
    String strField_ListPlanningMonto;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    
    // Obtiene datos del varios records de la lista relacionada 1
    // No existe lista relacionada para copiar al registro master
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Lista_de_Planning__c> list_objListaDePlanning = new List<Lista_de_Planning__c>();
    String strRecordBuscar='';
    Lista_de_Planning__c ListaDePlanningNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objListaDePlanning.add(ListaDePlanningNew);
            } 
            ListaDePlanningNew = new Lista_de_Planning__c();    
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c = strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c  = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Precio Lista'){
                ListaDePlanningNew.Precio_Lista__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Metro Excedente'){
                ListaDePlanningNew.Precio_Mt_Excedente__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Avenida'){
                ListaDePlanningNew.Precio_Sobre_Avenida__c = asignaOLimpiaValorDouble(Field.Value__c);
            }  else if (Field.Name=='Precio Area'){
                
                ListaDePlanningNew.Precio_Frente_Area_Municipal__c = asignaOLimpiaValorDouble(Field.Value__c);
            }  else if (Field.Name=='Precio Cablevision'){
                ListaDePlanningNew.Precio_Cablevision__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Esquina'){
                ListaDePlanningNew.Precio_Esquina__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sol'){
                ListaDePlanningNew.Precio_Lado_Sol__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sombra'){
                ListaDePlanningNew.Precio_Lado_Sombra__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Parque'){
                ListaDePlanningNew.Precio_Frente_Parque__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Presupuesto'){
                
                ListaDePlanningNew.Precio_Presupuesto__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
             
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Fraccionamiento'){
                ListaDePlanningNew.Fraccionamiento__c = strField_ListPlanningFracc = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Periodo'){
                ListaDePlanningNew.Periodo__c = strField_Periodo = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Prototipo'){
                ListaDePlanningNew.Prototipo__c  = ListaDePlanningNew.Name =  asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Precio Lista'){
                ListaDePlanningNew.Precio_Lista__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Metro Excedente'){
                ListaDePlanningNew.Precio_Mt_Excedente__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Avenida'){
                ListaDePlanningNew.Precio_Sobre_Avenida__c = asignaOLimpiaValorDouble(Field.Value__c);
            }  else if (Field.Name=='Precio Area'){
                
                ListaDePlanningNew.Precio_Frente_Area_Municipal__c = asignaOLimpiaValorDouble(Field.Value__c);
            }  else if (Field.Name=='Precio Cablevision'){
                ListaDePlanningNew.Precio_Cablevision__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Esquina'){
                ListaDePlanningNew.Precio_Esquina__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sol'){
                ListaDePlanningNew.Precio_Lado_Sol__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Lado Sombra'){
                ListaDePlanningNew.Precio_Lado_Sombra__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Parque'){
                ListaDePlanningNew.Precio_Frente_Parque__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio Presupuesto'){
                
                ListaDePlanningNew.Precio_Presupuesto__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
             
        }
        //System.Debug('***list_objMetaPlan 0*** '+list_objMetaPlan); 
    }
    list_objListaDePlanning.add(ListaDePlanningNew);
    
    Planning__c objPlanninng;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPlanninng = new Planning__c(RecordTypeId= rtPlanning
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Periodo__c = strField_Periodo
                                                , Fraccionamiento__c = strField_ListPlanningFracc
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        try{
            insert objPlanninng;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        if (!list_objListaDePlanning.IsEmpty() && objPlanninng!=null){
            List<Lista_de_Planning__c> list_ListaDePlanning_Ins = new List<Lista_de_Planning__c>();
            Integer NumeroListaPlanning =1;
            for(Lista_de_Planning__c ListaDePlanning2Ins : list_objListaDePlanning){
                ListaDePlanning2Ins.Name = String.ValueOf(NumeroListaPlanning++);
                ListaDePlanning2Ins.Planning_Buscar__c= objPlanninng.Id;
                ListaDePlanning2Ins.RecordTypeId = rtListaDePlanning;
                list_ListaDePlanning_Ins.add(ListaDePlanning2Ins);
            }
            if (!list_ListaDePlanning_Ins.IsEmpty()){
                try{
                    insert list_ListaDePlanning_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
     
    
    return objPlanninng;
  }
  
  
  //Venta 'Bonif. Emp. de Plan de Venta'
  private static Venta__c Crea_BonEmpPlanVta(approvalObject__c ApprvObj){
    String rtVenta = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Autorizacion Bonificaciones Empleados').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_PlanDeVenta;
    String strField_ValorDeOperacion;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Plan de Venta'){
            strField_PlanDeVenta = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        }
        
    }
    
        
    Venta__c objVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objVenta = new Venta__c(RecordTypeId= rtVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , No_Proceso__c =  strField_Proceso
                                                , Plan_de_Venta__c =  strField_PlanDeVenta
                                                , Valor_de_Operacion__c =  asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        try{
            insert objVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
   
    
    return objVenta;
  }
  
  
  //Venta 'Excepcion Bonif. Emp. ColJaver'
  private static Venta__c Crea_ExcBonEmpColJaver(approvalObject__c ApprvObj){
    String rtVenta = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Excepcion Bonif. Emp. ColJaver').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_PlanDeVenta;
    String strField_ValorDeOperacion;
    String strField_BonAutorizada;
    String strField_BonSolicitada;
    String strField_Diferencia;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Plan de Venta'){
            strField_PlanDeVenta = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        } else if (Field.Name=='Bonificacion Autorizada'){
            strField_BonAutorizada = Field.Value__c;
        } else if (Field.Name=='Bonificacion Solicitada'){
            strField_BonSolicitada = Field.Value__c;
        } else if (Field.Name=='Diferencia'){
            strField_Diferencia = Field.Value__c;
        }
        
    }
    
    
    Venta__c objVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objVenta = new Venta__c(RecordTypeId= rtVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , No_Proceso__c =  strField_Proceso
                                                , Plan_de_Venta__c =  strField_PlanDeVenta
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Bonificacion_Autorizada__c = asignaOLimpiaValorRecDec(strField_BonAutorizada)
                                                , Bonificacion_Solicitada__c = asignaOLimpiaValorRecDec(strField_BonSolicitada)
                                                , Diferencia_Texto__c = asignaOLimpiaValorRecDec(strField_Diferencia)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
        try{
            insert objVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    return objVenta;
  }
  
  //Venta 'Bonificacion de Plan de Venta'
  private static Venta__c Crea_BonPlanVta(approvalObject__c ApprvObj){
    String rtVenta = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Bonificacion Fuera de Lista').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_PlanDeVenta;
    String strField_ValorDeOperacion;
    String strField_BonAutorizada;
    String strField_BonSolicitada;
    String strField_Diferencia;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Plan de Venta'){
            strField_PlanDeVenta = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        } else if (Field.Name=='Bonificacion Autorizada'){
            strField_BonAutorizada = Field.Value__c;
        } else if (Field.Name=='Bonificacion Solicitada'){
            strField_BonSolicitada = Field.Value__c;
        } else if (Field.Name=='Diferencia'){
            strField_Diferencia = Field.Value__c;
        }
        
    }
    
        
   
    Venta__c objVenta;
    
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objVenta = new Venta__c(RecordTypeId= rtVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , No_Proceso__c =  strField_Proceso
                                                , Plan_de_Venta__c =  strField_PlanDeVenta
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Bonificacion_Autorizada__c = asignaOLimpiaValorRecDec(strField_BonAutorizada)
                                                , Bonificacion_Solicitada__c = asignaOLimpiaValorRecDec(strField_BonSolicitada)
                                                , Diferencia_Texto__c = asignaOLimpiaValorRecDec(strField_Diferencia)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
        try{
            insert objVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
   
    return objVenta;
  }
  
  //Venta 'Financiamiento Plan de Venta'
  private static Venta__c Crea_FinPlanVta(approvalObject__c ApprvObj){
    String rtVenta = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Autorizacion Financiamiento Pre Venta').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_PlanDeVenta;
    String strField_ValorDeOperacion;
    String strField_FinAutorizado;
    String strField_FinSolicitado;
    String strField_Diferencia;
    String strField_PlazoAut;
    String strField_PlazoSol;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Plan de Venta'){
            strField_PlanDeVenta = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        } else if (Field.Name=='Financiamiento Autorizado'){
            strField_FinAutorizado = Field.Value__c;
        } else if (Field.Name=='Financiamiento Solicitado'){
            strField_FinSolicitado = Field.Value__c;
        } else if (Field.Name=='Diferencia'){
            strField_Diferencia = Field.Value__c;
        } else if (Field.Name=='Plazo Autorizado'){
            strField_PlazoAut = Field.Value__c;
        } else if (Field.Name=='Plazo Solicitado'){
            strField_PlazoSol = Field.Value__c;
        }
        
    }
    
    Venta__c objVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objVenta = new Venta__c(RecordTypeId= rtVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , No_Proceso__c =  strField_Proceso
                                                , Plan_de_Venta__c =  strField_PlanDeVenta
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Financiamiento_Autorizado__c = asignaOLimpiaValorRecDec(strField_FinAutorizado)
                                                , Financiamiento_Solicitado__c = asignaOLimpiaValorRecDec(strField_FinSolicitado)
                                                , Diferencia_Texto__c = asignaOLimpiaValorRecDec(strField_Diferencia)
                                                , Plazo_Autorizado__c = strField_PlazoAut
                                                , Plazo_Solicitado__c = strField_PlazoSol
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        try{
            insert objVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }    
    
    
    return objVenta;
  }
  
  
  //Venta 'Paquetes de Plan de Venta'
  private static Venta__c Crea_PaqPlanVta(approvalObject__c ApprvObj){
    String rtVenta = Schema.SObjectType.Venta__c.getRecordTypeInfosByName().get('Excepcion de Paquetes / Productos Vivienda').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_PlanDeVenta;
    String strField_ValorDeOperacion;
    String strField_FinAutorizado;
    String strField_FinSolicitado;
    String strField_Diferencia;
    String strField_PlazoAut;
    String strField_PlazoSol;
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Plan de Venta'){
            strField_PlanDeVenta = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        } 
        
    }
    
    // Obtiene datos del varios records de la lista relacionada 2
    // No existe lista relacionada para copiar al registro master
    Set<Id> set_idRecord = new Set<Id>();
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_2 ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Paquete__c> list_objPaquete = new List<Paquete__c>();
    String strRecordBuscar='';
    Paquete__c PaqueteNew;
    for (field__c Field :[SELECT Id, Name, Value__c, Record_Buscar__c FROM field__c WHERE Record_Buscar__c IN :set_idRecord ORDER BY Record_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.Record_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objPaquete.add(PaqueteNew);
            } 
            PaqueteNew = new Paquete__c();  
            if (Field.Name=='Producto'){
                PaqueteNew.Name = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Tipo'){
                PaqueteNew.Tipo__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Cantidad'){
                PaqueteNew.Cantidad__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio'){
                PaqueteNew.Precio__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
             
            
            strRecordBuscar = Field.Record_Buscar__c;
            
        } else {
            if (Field.Name=='Producto'){
                PaqueteNew.Name = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Tipo'){
                PaqueteNew.Tipo__c = asignaOLimpiaValor(Field.Value__c);
            } else if (Field.Name=='Cantidad'){
                PaqueteNew.Cantidad__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Precio'){
                PaqueteNew.Precio__c = asignaOLimpiaValorDouble(Field.Value__c);
            } 
        }
        //System.Debug('***list_objMetaPlan 0*** '+list_objMetaPlan); 
    }
    list_objPaquete.add(PaqueteNew);    
    
    Venta__c objVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objVenta = new Venta__c(RecordTypeId= rtVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , No_Proceso__c =  strField_Proceso
                                                , Plan_de_Venta__c =  strField_PlanDeVenta
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        try{
            insert objVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        
        if (!list_objPaquete.IsEmpty() && objVenta!=null){
            List<Paquete__c> list_Paquete_Ins = new List<Paquete__c>();
            for(Paquete__c Paquete2Ins : list_objPaquete){
                Paquete2Ins.Venta_Buscar__c= objVenta.Id;
                
                list_Paquete_Ins.add(Paquete2Ins);
            }
            if (!list_Paquete_Ins.IsEmpty()){
                try{
                    insert list_Paquete_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    
    return objVenta;
  }
  
  //Pre Venta 'VO. Menor a Presupuesto'
  private static Pre_Venta__c Crea_VOMenPres(approvalObject__c ApprvObj){
    String rtPreVenta = Schema.SObjectType.Pre_Venta__c.getRecordTypeInfosByName().get('VO. Menor a Presupuesto').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_PlanDeVenta;
    String strField_ValorDeOperacion;
    String strField_QuoteId;
    String strField_sPriListId;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Plan de Venta'){
            strField_PlanDeVenta = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        } else if (Field.Name=='Quote Id'){
            strField_QuoteId = Field.Value__c;
        } else if (Field.Name=='sPriListId'){
            strField_sPriListId = Field.Value__c;
        }
        
       
    }
    
        
    Pre_Venta__c objPreVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPreVenta = new Pre_Venta__c(RecordTypeId= rtPreVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , Proceso__c = strField_Proceso
                                                , Plan_de_Venta__c = strField_PlanDeVenta
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Quote_Id__c = strField_QuoteId
                                                , sPriListId__c = strField_sPriListId
                                                , Approval_Obj_Type__c = str_approvalType
                                               
                                                );
    
        try{
            insert objPreVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    return objPreVenta;
  }
  
  //FinPVColJaver
  //Post Venta 'Financiamiento Post Venta'
  private static Post_Venta__c Crea_FinPostVta(approvalObject__c ApprvObj){
    String rtPostVenta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Autorizacion Financiamiento PosVenta').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_Escritura;
    String strField_ValorDeOperacion;
    String strField_Subsidio;
    String strField_FinSolicitado;
    String strField_FinAutorizado;
    String strField_Diferencia;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Escritura'){
            strField_Escritura = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        }  else if (Field.Name=='Monto Subsidio'){
            strField_Subsidio = Field.Value__c;
        } else if (Field.Name=='Financiamiento Solicitado'){
            strField_FinSolicitado = Field.Value__c;
        } else if (Field.Name=='Financiamiento Autorizado'){
            strField_FinAutorizado = Field.Value__c;
        } else if (Field.Name=='Diferencia'){
            strField_Diferencia = Field.Value__c;
        }
        
       
    }
    
        
    Post_Venta__c objPostVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPostVenta = new Post_Venta__c(RecordTypeId= rtPostVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , Escritura__c =  strField_Escritura
                                                
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Subsidio__c =  asignaOLimpiaValorDouble(strField_Subsidio)
                                                , Financiamiento_Solicitado__c = asignaOLimpiaValor(strField_FinSolicitado)
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Financiamiento_Autorizado__c = strField_FinAutorizado
                                                , Diferencia__c = strField_Diferencia
                                                );
        try{
            insert objPostVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    return objPostVenta;
  }
    
  
  //Post Venta 'Finan PostVenta Col Javer'
  private static Post_Venta__c Crea_FinPVColJaver(approvalObject__c ApprvObj){
    String rtPostVenta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Finan PostVenta Col Javer').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_Escritura;
    String strField_ValorDeOperacion;
    String strField_Subsidio;
    String strField_FinSolicitado;
    String strField_FinAutorizado;
    String strField_Diferencia;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Escritura'){
            strField_Escritura = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        }  else if (Field.Name=='Monto Subsidio'){
            strField_Subsidio = Field.Value__c;
        } else if (Field.Name=='Financiamiento Solicitado'){
            strField_FinSolicitado = Field.Value__c;
        } else if (Field.Name=='Financiamiento Autorizado'){
            strField_FinAutorizado = Field.Value__c;
        } else if (Field.Name=='Diferencia'){
            strField_Diferencia = Field.Value__c;
        }
        
       
    }
    
        
    Post_Venta__c objPostVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPostVenta = new Post_Venta__c(RecordTypeId= rtPostVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , Escritura__c =  strField_Escritura
                                                
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Subsidio__c =  asignaOLimpiaValorDouble(strField_Subsidio)
                                                , Financiamiento_Solicitado__c = asignaOLimpiaValor(strField_FinSolicitado)
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Financiamiento_Autorizado__c = strField_FinAutorizado
                                                , Diferencia__c = strField_Diferencia
                                                );
        try{
            insert objPostVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    return objPostVenta;
  }
  
    
  
  
  
  //Post Venta 'Financiamiento Reestructura PV'
  private static Post_Venta__c Crea_ReestructPV(approvalObject__c ApprvObj){
    String rtPostVenta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Reestructuracion Post Venta').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_Escritura;
    String strField_ValorDeOperacion;
    String strField_Subsidio;
    String strField_FinSolicitado;
    String strField_MtoAReestruct;
    String strField_PctAReestruct;
    String strField_Plazo;
    String strField_Frecuencia;
    String strField_FechaIniCob;
    String strField_MensualidadAprox;
    
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Monto a Reestructurar'){
            strField_MtoAReestruct = Field.Value__c;
        }  else if (Field.Name=='Porc a Reestructurar'){
            strField_PctAReestruct = Field.Value__c;
        } else if (Field.Name=='Plazo'){
            strField_Plazo = Field.Value__c;
        } else if (Field.Name=='Frecuencia'){
            strField_Frecuencia = Field.Value__c;
        } else if (Field.Name=='Fecha Inicio Cob'){
            strField_FechaIniCob = Field.Value__c;
        } else if (Field.Name=='Mensualidad Aproximada'){
            strField_MensualidadAprox = Field.Value__c;
        }
        
    }
    
        
    Post_Venta__c objPostVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPostVenta = new Post_Venta__c(RecordTypeId= rtPostVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strField_Fraccionamiento
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c =  strField_Fraccionamiento
                                                , Approval_Obj_Type__c = str_approvalType
                                                , No_Proceso__c = strField_Proceso
                                                , Monto_Reestructura__c = asignaOLimpiaValorDouble(strField_MtoAReestruct)
                                                , Pct_a_Reestructura__c = asignaOLimpiaValorDouble(strField_PctAReestruct)
                                                , Plazo__c = asignaOLimpiaValorDouble(strField_Plazo)
                                                , Frecuencia__c = strField_Frecuencia
                                                , Fecha_Inicio_Cobranza__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_FechaIniCob)
                                                , Mensualidad_Aproximada__c = asignaOLimpiaValorDouble(strField_MensualidadAprox)
                                                );
    
        try{
            insert objPostVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
     
    
    return objPostVenta;
  }
  
  //Post Venta 'Subsidio'
  private static Post_Venta__c Crea_Subsidio(approvalObject__c ApprvObj){
    String rtPostVenta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Subsidio').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_Escritura;
    String strField_ValorDeOperacion;
    String strField_Subsidio;
    String strField_FinSolicitado;
    
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Escritura'){
            strField_Escritura = Field.Value__c;
        } else if (Field.Name=='Valor de Operacion'){
            strField_ValorDeOperacion = Field.Value__c;
        }  else if (Field.Name=='Subsidio'){
            strField_Subsidio = Field.Value__c;
        } else if (Field.Name=='Financiamiento Solicitado'){
            strField_FinSolicitado = Field.Value__c;
        }
        
    }
    
        
    Post_Venta__c objPostVenta;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objPostVenta = new Post_Venta__c(RecordTypeId= rtPostVenta
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , Escritura__c =  strField_Escritura
                                                
                                                , Valor_de_Operacion__c = asignaOLimpiaValorDouble(strField_ValorDeOperacion)
                                                , Subsidio__c =  asignaOLimpiaValorDouble(strField_Subsidio)
                                                //, Financiamiento_PostVentaSolicitada_Monto__c = asignaOLimpiaValorDouble(strField_FinSolicitado)
                                                , Approval_Obj_Type__c = str_approvalType
                                                , Financiamiento_Solicitado__c = strField_FinSolicitado
                                                );
        try{
            insert objPostVenta;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    return objPostVenta;
  }
    
    //Post Venta 'Garantia'
     private static Post_Venta__c Crea_Garantia(approvalObject__c ApprvObj){
        String rtPostVenta = Schema.SObjectType.Post_Venta__c.getRecordTypeInfosByName().get('Garantia').getRecordTypeId(); 
        Id idApprovalData_1;
        Id idApprovalData_2;
        Id idApprovalData_3;
        Id idApprovalData_4;
        
        String str_approvalId = ApprvObj.approvalId__c;
        String str_approvalLevel = ApprvObj.approvalLevel__c;
        String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
        String str_approvalName = ApprvObj.approvalName__c;
        String str_approvalObject = ApprvObj.approvalObject__c;
        String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
        String str_approvalType = ApprvObj.approvalType__c;
        String str_approverEmpId = ApprvObj.approverEmpId__c;
        String str_approverLogin = ApprvObj.approverLogin__c;
        String str_approverName = ApprvObj.approverName__c;
        String str_Nombre = ApprvObj.Nombre__c;
        String str_platform = ApprvObj.platform__c;
        String str_requesterEmpId = ApprvObj.requesterEmpId__c;
        String str_requesterLogin = ApprvObj.requesterLogin__c;
        String str_requesterName = ApprvObj.requesterName__c;
        String str_token = ApprvObj.token__c;
        
        String strEmpRequesterID;
        String strEmpApproverID;
        String strApprovalID;
        String strToken;
        String strRecord_1_Id;
        String strRecord_2_Id;
        String strField_Name;
        String strField_Codigo;
        String strField_Periodo;
        String strField_FinPeriodo;
        String strField_Extension;
        String strField_Cliente;
        String strField_Fraccionamiento;
        String strField_Proceso;
        String strField_Escritura;
        String strField_NumGarantia;
        String strField_TipoGarantia;
        String strField_Supervisor;
        String strField_Detalle;
        String strField_FechaAsignacion;
        String strField_FechaVencimiento;
        String strField_DiasGarantia;
        
        
        Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
        for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
            if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
                map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
            }
        }
        
        strEmpRequesterID = ApprvObj.requesterEmpId__c;
        strEmpApproverID = ApprvObj.approverEmpId__c;
        strApprovalID = ApprvObj.approvalId__c;
        strToken = ApprvObj.token__c;
        String strAppvObjLevel = ApprvObj.approvalLevel__c;
        String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
        
        
        for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
            if (ApprvData.Numero_de_Lista__c == 1){
                idApprovalData_1 = ApprvData.Id;
            } else if (ApprvData.Numero_de_Lista__c == 2){
                idApprovalData_2 = ApprvData.Id;
            } else if (ApprvData.Numero_de_Lista__c == 3){
                idApprovalData_3 = ApprvData.Id;
            } else if (ApprvData.Numero_de_Lista__c == 4){
                idApprovalData_4 = ApprvData.Id;
            }
            
        }
        // Obtiene datos del unico record de la lista relacionada 1
        
        for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
            strRecord_1_Id = Record.Id;
        }
        for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
            if (Field.Name=='Cliente'){
                strField_Cliente = Field.Value__c;
            } else if (Field.Name=='Fraccionamiento'){
                strField_Fraccionamiento = Field.Value__c;
            } else if (Field.Name=='Escritura'){
                strField_Escritura = Field.Value__c;
            } else if (Field.Name=='Numero Garantia'){
                strField_NumGarantia = Field.Value__c;
            }  else if (Field.Name=='Tipo Garantia'){
                strField_TipoGarantia = Field.Value__c;
            } else if (Field.Name=='Supervisor'){
                strField_Supervisor = Field.Value__c;
            } else if (Field.Name=='Detalle'){
                strField_Detalle = Field.Value__c;
            } else if (Field.Name=='Fecha Asignacion'){
                strField_FechaAsignacion = Field.Value__c;
            } else if (Field.Name=='Fecha Vencimiento'){
                strField_FechaVencimiento = Field.Value__c;
            } else if (Field.Name=='Dias Garantia'){
                strField_DiasGarantia = Field.Value__c;
            }
            
        }
        
            
        Post_Venta__c objPostVenta;
        if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
            objPostVenta = new Post_Venta__c(RecordTypeId= rtPostVenta
                                                    , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                    , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                    //, Solicitante_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.requesterEmpId__c)
                                                    , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                    //, Periodo__c = strField_Periodo
                                                    , Token__c = strToken
                                                    , Approval_Object_Level__c = strAppvObjLevel
                                                    , Approval_Object_LevelValue__c = str_approvalLevelValue
                                                    , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                    , Nombre_Solicitante__c = str_requesterName
                                                    , Cliente_Nombre__c = strField_Cliente
                                                    , Fraccionamiento__c = strField_Fraccionamiento
                                                    , Escritura__c =  strField_Escritura
                                                    , Numero_de_Garantia__c = strField_NumGarantia
                                                 , Tipo_de_Garantia__c = strField_TipoGarantia
                                                 , Supervisor__c = strField_Supervisor
                                                 , Detalle__c = strField_Detalle
                                                 , Fecha_de_Asignacion__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_FechaAsignacion)
                                                 , Fecha_de_Vencimiento__c = asignaOLimpiaValorDateFormatoMxValueOf(strField_FechaVencimiento)
                                                 , Dias_de_Garantia__c = strField_DiasGarantia
                                                    , Approval_Obj_Type__c = str_approvalType
                                                    
                                                    );
            try{
                insert objPostVenta;
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } //catch
        
        } else {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                            String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                            Catch__c newCatch = new Catch__c();
                            newCatch.RecordTypeId = rtCatch;
                            newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                            newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                            newCatch.StackTrace__c = e.getStackTraceString();
                        newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                            Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                }    
        }
        
        
        
        return objPostVenta;
      }
  
  //Cancelacion 'Cancelacion de Escritura'
  private static Cancelacion__c Crea_CancEscrt(approvalObject__c ApprvObj){
    String rtCancelacion = Schema.SObjectType.Cancelacion__c.getRecordTypeInfosByName().get('Cancelacion de Escritura').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_Estatus;
    String strField_RazonRechazo;
    String strField_GastosAdmin;
    String strField_GastosAdminPropuesto; 
    String strField_ReembGenerado;
    String strField_ReembPropuesto;
    String strField_Saldo;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Estatus'){
            strField_Estatus = Field.Value__c;
        }  else if (Field.Name=='Razon Rechazo'){
            strField_RazonRechazo = Field.Value__c;
        } else if (Field.Name=='Gastos Admin'){
            strField_GastosAdmin = Field.Value__c;
        } else if (Field.Name=='Gastos Admin Propuesto'){
            strField_GastosAdminPropuesto = Field.Value__c;
        } else if (Field.Name=='Reembolso Generado'){
            strField_ReembGenerado = Field.Value__c;
        } else if (Field.Name=='Reembolso Propuesto'){
            strField_ReembPropuesto = Field.Value__c;
        } else if (Field.Name=='Saldo'){
            strField_Saldo = Field.Value__c;
        }
        
        
    }
    
        
    Cancelacion__c objCancelacion;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objCancelacion = new Cancelacion__c(RecordTypeId= rtCancelacion
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                , Objeto_a_Aprobar__c =ApprvObj.Name
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , Estatus_Texto__c =  strField_Estatus
                                                , Razon_rechazo__c =  strField_RazonRechazo
                                                
                                                
                                                , Gastos_Admin__c = asignaOLimpiaValorDouble(strField_GastosAdmin)
                                                , Gastos_Admin_Propuesto__c = asignaOLimpiaValorDouble(strField_GastosAdminPropuesto)
                                                , Reembolso_Generado__c = asignaOLimpiaValorDouble(strField_ReembGenerado)
                                                , Reembolso_Propuesto__c = asignaOLimpiaValorDouble(strField_ReembPropuesto)
                                                , Saldo__c = asignaOLimpiaValorDouble(strField_Saldo)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        
        try{
            insert objCancelacion;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    return objCancelacion;
  }
  
  //Cancelacion 'Cancelacion Formalizacion'
  private static Cancelacion__c Crea_CancFormal(approvalObject__c ApprvObj){
    String rtCancelacion = Schema.SObjectType.Cancelacion__c.getRecordTypeInfosByName().get('Cancelacion Formalizacion').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_Estatus;
    String strField_RazonRechazo;
    String strField_GastosAdmin;
    String strField_GastosAdminPropuesto; 
    String strField_ReembGenerado;
    String strField_ReembPropuesto;
    String strField_Saldo;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Estatus'){
            strField_Estatus = Field.Value__c;
        }  else if (Field.Name=='Razon Rechazo'){
            strField_RazonRechazo = Field.Value__c;
        } else if (Field.Name=='Gastos Admin'){
            strField_GastosAdmin = Field.Value__c;
        } else if (Field.Name=='Gastos Admin Propuesto'){
            strField_GastosAdminPropuesto = Field.Value__c;
        } else if (Field.Name=='Reembolso Generado'){
            strField_ReembGenerado = Field.Value__c;
        } else if (Field.Name=='Reembolso Propuesto'){
            strField_ReembPropuesto = Field.Value__c;
        } else if (Field.Name=='Saldo'){
            strField_Saldo = Field.Value__c;
        }
        
        
    }
    
        
    Cancelacion__c objCancelacion;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objCancelacion = new Cancelacion__c(RecordTypeId= rtCancelacion
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                , Objeto_a_Aprobar__c =ApprvObj.Name
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , Estatus_Texto__c =  strField_Estatus
                                                , Razon_rechazo__c =  strField_RazonRechazo
                                                , Gastos_Admin__c = asignaOLimpiaValorDouble(strField_GastosAdmin)
                                                , Gastos_Admin_Propuesto__c = asignaOLimpiaValorDouble(strField_GastosAdminPropuesto)
                                                , Reembolso_Generado__c = asignaOLimpiaValorDouble(strField_ReembGenerado)
                                                , Reembolso_Propuesto__c = asignaOLimpiaValorDouble(strField_ReembPropuesto)
                                                , Saldo__c = asignaOLimpiaValorDouble(strField_Saldo)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
    
        try{
            insert objCancelacion;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    
    
    
    return objCancelacion;
  }
  
  //Cancelacion 'Gastos Admin'
  private static Cancelacion__c Crea_CancGastosAdmin(approvalObject__c ApprvObj){
    String rtCancelacion = Schema.SObjectType.Cancelacion__c.getRecordTypeInfosByName().get('Gastos Admin').getRecordTypeId(); 
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    
    String str_approvalId = ApprvObj.approvalId__c;
    String str_approvalLevel = ApprvObj.approvalLevel__c;
    String str_approvalLevelValue = ApprvObj.approvalLevelValue__c;
    String str_approvalName = ApprvObj.approvalName__c;
    String str_approvalObject = ApprvObj.approvalObject__c;
    String str_approvalRequestedDate = ApprvObj.approvalRequestedDate__c;
    String str_approvalType = ApprvObj.approvalType__c;
    String str_approverEmpId = ApprvObj.approverEmpId__c;
    String str_approverLogin = ApprvObj.approverLogin__c;
    String str_approverName = ApprvObj.approverName__c;
    String str_Nombre = ApprvObj.Nombre__c;
    String str_platform = ApprvObj.platform__c;
    String str_requesterEmpId = ApprvObj.requesterEmpId__c;
    String str_requesterLogin = ApprvObj.requesterLogin__c;
    String str_requesterName = ApprvObj.requesterName__c;
    String str_token = ApprvObj.token__c;
    
    String strEmpRequesterID;
    String strEmpApproverID;
    String strApprovalID;
    String strToken;
    String strRecord_1_Id;
    String strRecord_2_Id;
    String strField_Name;
    String strField_Codigo;
    String strField_Periodo;
    String strField_FinPeriodo;
    String strField_Extension;
    String strField_Cliente;
    String strField_Fraccionamiento;
    String strField_Proceso;
    String strField_Estatus;
    String strField_RazonRechazo;
    String strField_GastosAdmin;
    String strField_GastosAdminPropuesto; 
    String strField_ReembGenerado;
    String strField_ReembPropuesto;
    String strField_Saldo;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, EmpId1__c FROM User LIMIT 10000] ){
        if (objUsr.EmpId1__c!=null || objUsr.EmpId1__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.EmpId1__c, objUsr.Id);
        }
    }
    
    strEmpRequesterID = ApprvObj.requesterEmpId__c;
    strEmpApproverID = ApprvObj.approverEmpId__c;
    strApprovalID = ApprvObj.approvalId__c;
    strToken = ApprvObj.token__c;
    String strAppvObjLevel = ApprvObj.approvalLevel__c;
    String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalData__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalData__c WHERE approvalObject_Buscar__c = :ApprvObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    
    for (record__c Record :[SELECT Id, Name FROM record__c WHERE ApprovalData_Buscar__c = :idApprovalData_1] ){
        strRecord_1_Id = Record.Id;
    }
    
    for (field__c Field :[SELECT Id, Name, Value__c FROM field__c WHERE Record_Buscar__c = :strRecord_1_Id] ){
        if (Field.Name=='Cliente'){
            strField_Cliente = Field.Value__c;
        } else if (Field.Name=='Fraccionamiento'){
            strField_Fraccionamiento = Field.Value__c;
        } else if (Field.Name=='Proceso'){
            strField_Proceso = Field.Value__c;
        } else if (Field.Name=='Estatus'){
            strField_Estatus = Field.Value__c;
        }  else if (Field.Name=='Razon Rechazo'){
            strField_RazonRechazo = Field.Value__c;
        } else if (Field.Name=='Gastos Admin Solicitados'){
            strField_GastosAdmin = Field.Value__c;
        } else if (Field.Name=='Gastos Admin Propuestos'){
            strField_GastosAdminPropuesto = Field.Value__c;
        } else if (Field.Name=='Saldo'){
            strField_Saldo = Field.Value__c;
        }
        
        
    }
    
        
    Cancelacion__c objCancelacion;
    if(map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)!=null ){
        objCancelacion = new Cancelacion__c(RecordTypeId= rtCancelacion
                                                , Name = str_approvalObject + ' / '+ ApprvObj.Name
                                                , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)  
                                                , Objeto_a_Aprobar__c =ApprvObj.Name
                                                , OwnerId = map_strEmpClave_UsrId.get(ApprvObj.approverEmpId__c)
                                                //, Periodo__c = strField_Periodo
                                                , Token__c = strToken
                                                , Approval_Object_Level__c = strAppvObjLevel
                                                , Approval_Object_Fracc_Name__c = strAppvObjFrccName
                                                , Nombre_Solicitante__c = str_requesterName
                                                
                                                , Cliente_Nombre__c = strField_Cliente
                                                , Fraccionamiento__c = strField_Fraccionamiento
                                                , Estatus_Texto__c =  strField_Estatus
                                                , Razon_rechazo__c =  strField_RazonRechazo
                                                , Gastos_Admin__c = asignaOLimpiaValorDouble(strField_GastosAdmin)
                                                , Gastos_Admin_Propuesto__c = asignaOLimpiaValorDouble(strField_GastosAdminPropuesto)
                                                , Proceso__c = strField_Proceso
                                                , Saldo__c = asignaOLimpiaValorDouble(strField_Saldo)
                                                , Approval_Obj_Type__c = str_approvalType
                                                );
        try{
            insert objCancelacion;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    
    } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <approverEmpId> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <approverEmpId> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                    newCatch.approvalObject_Buscar__c = ApprvObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
     
    
    return objCancelacion;
  }
  
  
        
  /******************************************************************************
        Métodos obtener valores de elementos
    */ 
  private static String obtenerValor(XmlStreamReader reader) {
      String valor = '';
    while(reader.hasNext()) {
          //System.Debug('***reader.getEventType()*** '+ reader.getEventType());
          
          
          if (reader.getEventType() == XmlTag.END_ELEMENT) {
               break;
          } else if (reader.getEventType() == XmlTag.CHARACTERS) {
               //System.Debug('***reader.getText()*** '+ reader.getText() );
               valor = asignaOLimpiaValor(reader.getText());
          }
      reader.next();
       }
       return valor;
  }
    
  private static Integer obtenerValorInteger(XmlStreamReader reader) {
      Integer valor = 0;
    while(reader.hasNext()) {
          if (reader.getEventType() == XmlTag.END_ELEMENT) { break;
          } else if (reader.getEventType() == XmlTag.CHARACTERS) { valor = asignaOLimpiaValorInteger(reader.getText());
          }
      reader.next();
       }
       return valor;
    }
    
  private static Double obtenerValorDouble(XmlStreamReader reader) { Double valor = 0.00;
    while(reader.hasNext()) {
          if (reader.getEventType() == XmlTag.END_ELEMENT) { break;
          } else if (reader.getEventType() == XmlTag.CHARACTERS) {  valor = asignaOLimpiaValorDouble(reader.getText());
          }
      reader.next();
       }
       return valor;
    }

  private static Date obtenerValorDate(XmlStreamReader reader) { Date valor = null;
    while(reader.hasNext()) {
          if (reader.getEventType() == XmlTag.END_ELEMENT) { break;
          } else if (reader.getEventType() == XmlTag.CHARACTERS) { valor = asignaOLimpiaValorDate(reader.getText());
          }
      reader.next();
       }
       return valor;
    }
    

 
    

    
  /******************************************************************************
        Métodos Generales
    */
  private static String asignaOLimpiaValor(String valor) {
        String nuevoValor = valor != null ? valor : '';
        return nuevoValor;
    }
  
  private static String asignaOLimpiaValorRecDec(String valor) {
        String nuevoValor ='';
        if (valor!=null){
            String strPuntoDecimal = '.';
            Integer intInicioDecimales = valor.indexOf(strPuntoDecimal, 0);
            System.Debug('***intInicioDecimales*** '+intInicioDecimales);
            Integer intLongitud = valor.length();
            System.Debug('***intLongitud*** '+intLongitud);
            System.Debug('***valor*** '+valor);
            if (intInicioDecimales+3<intLongitud){
                System.Debug('***valor.substring(0,intInicioDecimales+3)*** '+valor.substring(0,intInicioDecimales+3) );
                nuevoValor = valor.substring(0,intInicioDecimales+3);
            }
            else {
                    System.Debug('*** else valor*** '+valor);
                    nuevoValor = valor;
            }
            //String nuevoValor = valor != null ? valor : '';
        }
        
        return nuevoValor;
  }
  
    
  private static Integer asignaOLimpiaValorInteger(String valor) {
        Integer nuevoValor = valor != null ? Integer.valueOf(valor) : 0;
        return nuevoValor;
    }

  private static Double asignaOLimpiaValorDouble(String valor) {
        Double nuevoValor = valor != null ? Double.valueOf(valor) : 0.00;
        return nuevoValor;
    }
    
  private static Date asignaOLimpiaValorDate(String valor) {
    // Reemplazamos el año 9999 con 4000
    valor = valor.replace('9999', '4000');
        Date nuevoValor = valor != null ? Date.valueOf(valor) : null;
        return nuevoValor;
    }
    
    
  private static Date asignaOLimpiaValorDateParse(String valor) {
    // Reemplazamos el año 9999 con 4000
    valor = valor.replace('9999', '4000');
        Date nuevoValor = valor != null ? Date.Parse(valor) : null;
        return nuevoValor;
  }
    
  private static Date asignaOLimpiaValorDateFormatoMx(String valor) {
    // Reemplazamos el año 9999 con 4000
    //<apex:variable value="{!LEFT(stageKey,(FIND(':', stageKey) - 1))}" var="Folio"/>
    //                        <apex:variable value="{!RIGHT(stageKey, (LEN(stageKey) - FIND(':', stageKey) - 1  ))}" var="strSinFolio"/>
    //                        <apex:variable value="{!LEFT(strSinFolio,(FIND(':', strSinFolio) - 1))}" var="Inicio"/>
    //                        <apex:variable value="{!RIGHT(strSinFolio, (LEN(strSinFolio) - FIND(':', strSinFolio) - 1  ))}" var="strSinInicio"/>
    //                        <apex:variable value="{!LEFT(strSinInicio,(FIND(':', strSinInicio) - 1))}" var="Fin"/>
    //                        <apex:variable value="{!RIGHT(strSinInicio, (LEN(strSinInicio) - FIND(':', strSinInicio) - 1  ))}" var="strSinFin"/>
    //                        <apex:variable value="{!LEFT(strSinFin,(FIND(':', strSinFin) - 1))}" var="Tipo"/>
    //                        <apex:variable value="{!RIGHT(strSinFin, (LEN(strSinFin) - FIND(':', strSinFin) - 1  ))}" var="strSinTipo"/>
    //                        <apex:variable value="{!LEFT(strSinTipo,(FIND(':', strSinTipo) - 1))}" var="Desc"/>
     if(valor!=null){
    //if (LEN(valor)>0){
        
                //date fecha = date.valueOf(fechaTexto.substring(0,4)+'-'+fechaTexto.substring(4,6)+'-'+fechaTexto.substring(6,8) + ' ' + '00' + ':' + '00' + ':' + '00');
                
        // 10/31/2014
        String strMes = valor.substring(0,2);
        System.Debug('*** valor Despues de Mes*** '+valor);
        System.Debug('*** strMes *** '+strMes);
        //String strFechaSinMes = RIGHT(valor, (LEN(valor) - valor.indexOf('/') - 1  ));
        String strDia = valor.substring(3,5);
        System.Debug('*** strDia *** '+strDia);
        System.Debug('*** valor Despues de Dia*** '+valor);
        //String strFechaSinDia = RIGHT(strFechaSinMes, (LEN(strFechaSinMes) - strFechaSinMes.indexOf('/') - 1  ));
        String strAnio = valor.substring(6);
        System.Debug('*** strAnio *** '+strAnio);
        System.Debug('*** valor Despues de Anio*** '+valor);
        valor =  strMes+'-'+strDia+'-'+strAnio;
        //valor =  strMes+'/'+strDia+'/'+strAnio;
        System.Debug('*** valor Nuevo*** '+valor);
        
        //valor = valor.substring(3,4)+'/'+valor.substring(0,1)+'/'+valor.substring(8) ;
    }
    valor = valor.replace('9999', '4000');
        Date nuevoValor = valor != null ? Date.valueOf(valor) : null;
        return nuevoValor;
    }
    
    private static Date asignaOLimpiaValorDateFormatoMxValueOf(String valor) {
    // Reemplazamos el año 9999 con 4000
    //<apex:variable value="{!LEFT(stageKey,(FIND(':', stageKey) - 1))}" var="Folio"/>
    //                        <apex:variable value="{!RIGHT(stageKey, (LEN(stageKey) - FIND(':', stageKey) - 1  ))}" var="strSinFolio"/>
    //                        <apex:variable value="{!LEFT(strSinFolio,(FIND(':', strSinFolio) - 1))}" var="Inicio"/>
    //                        <apex:variable value="{!RIGHT(strSinFolio, (LEN(strSinFolio) - FIND(':', strSinFolio) - 1  ))}" var="strSinInicio"/>
    //                        <apex:variable value="{!LEFT(strSinInicio,(FIND(':', strSinInicio) - 1))}" var="Fin"/>
    //                        <apex:variable value="{!RIGHT(strSinInicio, (LEN(strSinInicio) - FIND(':', strSinInicio) - 1  ))}" var="strSinFin"/>
    //                        <apex:variable value="{!LEFT(strSinFin,(FIND(':', strSinFin) - 1))}" var="Tipo"/>
    //                        <apex:variable value="{!RIGHT(strSinFin, (LEN(strSinFin) - FIND(':', strSinFin) - 1  ))}" var="strSinTipo"/>
    //                        <apex:variable value="{!LEFT(strSinTipo,(FIND(':', strSinTipo) - 1))}" var="Desc"/>
     if(valor!=null){
    //if (LEN(valor)>0){
        
                //date fecha = date.valueOf(fechaTexto.substring(0,4)+'-'+fechaTexto.substring(4,6)+'-'+fechaTexto.substring(6,8) + ' ' + '00' + ':' + '00' + ':' + '00');
                
        // 10/31/2014
        String strMes = valor.substring(0,2);
        System.Debug('*** valor Despues de Mes*** '+valor);
        System.Debug('*** strMes *** '+strMes);
        //String strFechaSinMes = RIGHT(valor, (LEN(valor) - valor.indexOf('/') - 1  ));
        String strDia = valor.substring(3,5);
        System.Debug('*** strDia *** '+strDia);
        System.Debug('*** valor Despues de Dia*** '+valor);
        //String strFechaSinDia = RIGHT(strFechaSinMes, (LEN(strFechaSinMes) - strFechaSinMes.indexOf('/') - 1  ));
        String strAnio = valor.substring(6);
        System.Debug('*** strAnio *** '+strAnio);
        System.Debug('*** valor Despues de Anio*** '+valor);
        valor =  strAnio +'-'+ strMes +'-'+strDia;
        //valor =  strMes+'/'+strDia+'/'+strAnio;
        System.Debug('*** valor Nuevo*** '+valor);
        
        //valor = valor.substring(3,4)+'/'+valor.substring(0,1)+'/'+valor.substring(8) ;
        valor = valor.replace('9999', '4000');
    }
    
        Date nuevoValor = valor != null ? Date.valueOf(valor) : null;
        return nuevoValor;
    }

  /******************************************************************************
        Métodos de Error
    */
  private void mensajeDeError(String mensaje) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, mensaje));
        throw new ErrorProcesoException(mensaje);
    }

    private class ErrorProcesoException extends Exception { }

    /******************************************************************************
        Métodos de Respuesta
    */
    @future(callout=true)
    public static void Envia_Respuesta(String strToken, String strAccion, String strIDObjetoRespuesta){
                
        try {
            Sistema__c Sistema = new Sistema__c();
            String cert;
            if (!Test.isRunningTest()) { 
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c, Cert_Password__c, Certificado_Autofirmado__c FROM Sistema__c WHERE Name='Configuracion en Javer Util' LIMIT 1 ];
                if (Sistema.Certificado_Rec_Estatico__c!=null && Sistema.Cert_Password__c!=null ){
                    for (StaticResource sr : [Select Id, Body from StaticResource where Name =: Sistema.Certificado_Rec_Estatico__c]){
                        cert = EncodingUtil.base64Encode(sr.Body);
                    }
                }
                
            }else {
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c, Cert_Password__c FROM Sistema__c WHERE Name='Configuracion en Javer Util-Test' LIMIT 1 ];
            }
            
            String s='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">'+
                           '<soapenv:Header/>'+
                           '<soapenv:Body>'+
                              '<tem:RegAprov>'+
                                 '<tem:token>' + strToken + '</tem:token>'+
                                 '<tem:action>' + strAccion + '</tem:action>'+
                                 '<tem:src>3</tem:src>'+
                              '</tem:RegAprov>'+
                           '</soapenv:Body>'+
                    '</soapenv:Envelope>';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Sistema.End_Point__c);
            //req.setEndpoint('https://ws.javer.com.mx:4390/WS/Wrapper1.svc');
            //req.setEndpoint('https://qws.javer.com.mx:5532/WS/Wrapper1.svc');
            req.setMethod('POST');
            req.setBody(s);
            req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
           
            
            req.setHeader('SOAPAction', '"http://tempuri.org/IWrapper1/RegAprov"');
            req.setHeader('Accept-Encoding', 'gzip,deflate');
                        
            req.setTimeout(120000);
            
            //if (!Test.isRunningTest() && cert!=null && Sistema.Cert_Password__c!=null) { 
            //	req.setClientCertificate(cert, Sistema.Cert_Password__c);
            //}
            if (Sistema.Certificado_Autofirmado__c !=null){
            	req.setClientCertificateName(Sistema.Certificado_Autofirmado__c);    
            }
            //req.setClientCertificateName('javer1');
            Http http = new Http();                                   
            HTTPResponse res = http.send(req);
            
            // Guardamos la respuesta como string
            String respuesta = '<?xml version="1.0"?>'+res.getBody();
            System.debug('aki:'+respuesta);
            try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                            String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('CallOut').getRecordTypeId(); 
                            Catch__c newCatch = new Catch__c();
                            newCatch.RecordTypeId = rtCatch;
                            if (respuesta.length()>2450){
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta.SubString(0,2449)+' (...). *** Respuesta parcial por motivos de formato. Consulte al Administrador de Salesforce para conocer los detalles.';
                            } else{
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta;
                            }
                    		if(respuesta.contains('n Exitosa') || respuesta.contains('Succes') ){
                                newCatch.Causa__c = 'Respuesta-Siebel : Aprobación Exitosa';
                            } else if(respuesta.contains('No Aprobado')) {
                                newCatch.Causa__c = 'Respuesta-Siebel : No Aprobado';
                            } else {
                                newCatch.Causa__c = 'Respuesta-Siebel : Sin respuesta catalogada';
                            }
                        
                            
                            newCatch.StackTrace__c = e.getStackTraceString();
                            Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }
             
            approvalObject__c ApprvObj= [SELECT Id
                                        , Name , Id_Objeto_A_Aprobar_Buscar__c
                                        , Estatus__c
                                        FROM approvalObject__c 
                                         WHERE  Id_Objeto_A_Aprobar_Buscar_15__c = : strIDObjetoRespuesta 
                                         OR
                                         Id_Objeto_A_Aprobar_Buscar__c = : strIDObjetoRespuesta
                                         LIMIT 1 ];
            ApprvObj.Estatus__c  = strAccion == '0' ? 'Rechazada' : 'Aprobada'; 
      ApprvObj.Respuesta_Larga_Siebel__c = respuesta;
            try{
              update ApprvObj; 
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.approvalObject_Buscar__c = ApprvObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } //catch
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.Registro_Salesforce_URL__c = protocolAndHost()+'/'+strIDObjetoRespuesta; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    }
    
    
   @future(callout=true)
   WebService static void WS_Envia_Respuesta(String strToken, String strAccion, String strIDObjetoRespuesta) {
   //public static void Envia_Respuesta(String strToken, String strAccion, String strIDObjetoRespuesta){
                
        try {
            Sistema__c Sistema = new Sistema__c();
            String cert;
            if (!Test.isRunningTest()) { 
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c, Cert_Password__c, Certificado_Autofirmado__c FROM Sistema__c WHERE Name='Configuracion en Javer Util' LIMIT 1 ];
                if (Sistema.Certificado_Rec_Estatico__c!=null && Sistema.Cert_Password__c!=null ){
                    for (StaticResource sr : [Select Id, Body from StaticResource where Name =: Sistema.Certificado_Rec_Estatico__c]){
                        cert = EncodingUtil.base64Encode(sr.Body);
                    }
                }
                
            }else {
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c FROM Sistema__c WHERE Name='Configuracion en Javer Util-Test' LIMIT 1 ];
            }
            
            String s='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">'+
                           '<soapenv:Header/>'+
                           '<soapenv:Body>'+
                              '<tem:RegAprov>'+
                                 '<tem:token>' + strToken + '</tem:token>'+
                                 '<tem:action>' + strAccion + '</tem:action>'+
                                 '<tem:src>3</tem:src>'+
                              '</tem:RegAprov>'+
                           '</soapenv:Body>'+
                    '</soapenv:Envelope>';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Sistema.End_Point__c);
            //req.setEndpoint('https://ws.javer.com.mx:4390/WS/Wrapper1.svc');
            //req.setEndpoint('https://qws.javer.com.mx:5532/WS/Wrapper1.svc');
            req.setMethod('POST');
            req.setBody(s);
            req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
           
            
            req.setHeader('SOAPAction', '"http://tempuri.org/IWrapper1/RegAprov"');
            req.setHeader('Accept-Encoding', 'gzip,deflate');
                        
            req.setTimeout(120000);
            //if (!Test.isRunningTest() && cert!=null && Sistema.Cert_Password__c!=null) { 
            //	req.setClientCertificate(cert, Sistema.Cert_Password__c);
            //}
            req.setClientCertificateName(Sistema.Certificado_Autofirmado__c);
            Http http = new Http();                                   
            HTTPResponse res = http.send(req);
            
            // Guardamos la respuesta como string
            String respuesta = '<?xml version="1.0"?>'+res.getBody();
            System.debug('aki:'+respuesta);
            try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                            String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('CallOut').getRecordTypeId(); 
                            Catch__c newCatch = new Catch__c();
                            newCatch.RecordTypeId = rtCatch;
                            if (respuesta.length()>2450){
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta.SubString(0,2449)+' (...). *** Respuesta parcial por motivos de formato. Consulte al Administrador de Salesforce para conocer los detalles.';
                            } else{
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta;
                            }
                        if(respuesta.contains('n Exitosa') || respuesta.contains('Succes') ){
                                newCatch.Causa__c = 'Respuesta-Siebel : Aprobación Exitosa';
                            } else if(respuesta.contains('No Aprobado')) {
                                newCatch.Causa__c = 'Respuesta-Siebel : No Aprobado';
                            } else {
                                newCatch.Causa__c = 'Respuesta-Siebel : Sin respuesta catalogada';
                            }
                        
                            
                            newCatch.StackTrace__c = e.getStackTraceString();
                            Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }
            //System.Debug('***strIDObjetoRespuesta*** '+strIDObjetoRespuesta);
            //strIDObjetoRespuesta = strIDObjetoRespuesta.substring(0, 15);
            approvalObject__c ApprvObj= [SELECT Id
                                        , Name , Id_Objeto_A_Aprobar_Buscar__c
                                        , Estatus__c
                                        FROM approvalObject__c 
                                         WHERE Id_Objeto_A_Aprobar_Buscar_15__c = : strIDObjetoRespuesta 
                                         OR
                                         Id_Objeto_A_Aprobar_Buscar__c = : strIDObjetoRespuesta
                                         LIMIT 1 ];
            if (ApprvObj!=null){
                ApprvObj.Estatus__c  = strAccion == '0' ? 'Rechazada' : 'Aprobada'; 
          		ApprvObj.Respuesta_Larga_Siebel__c = respuesta;
                try{
                  update ApprvObj; 
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                
                } //catch
            }
            
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.Registro_Salesforce_URL__c = protocolAndHost()+'/'+strIDObjetoRespuesta; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    }


  /******************************************************************************
        Métodos de Prueba
    */

    //Comision 'Cédula Asesor'
    public static void CedulaAsesor_test() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+  
    '<approverLogin>CRG</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>CARLOS REYES</approverName>'+        
    '<approvalObject>Cedula Asesor</approvalObject>'+
    '<approvalRequestedDate>11/28/2014 14:39:03</approvalRequestedDate>'+
    '<approvalName>1-31091595</approvalName>'+
    '<approvalId>1-IIEFQ</approvalId>'+         
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '<listOfApprovalData>'+
    '   <ApprovalData>'+
'           <listOfRecords>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Nombre</name>'+
'                           <value>ANDRES MONTAÑEZ</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Codigo</name>'+
'                           <value>1-31091595</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Periodo</name>'+
'                           <value>NOVIEMBRE 2014</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Tipo</name>'+
'                           <value>Comisión</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Rol Ventas</name>'+
'                           <value>Asesor</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Forma Pago</name>'+
'                           <value>NOVIEMBRE SEM4</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Numero Equipo</name>'+
'                           <value>1-3490395</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'           </listOfRecords>'+
'       </ApprovalData>'+
'       <ApprovalData>'+
'           <listOfRecords>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>ELVIRA MORENO</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+            
'           </listOfRecords>'+
'       </ApprovalData>'+
'   </listOfApprovalData>'+
'</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Comision 'Cédula Asesor' Excepcion
    public static void CedulaAsesor_Xtest() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+  
    '<approverLogin>CRG</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>CARLOS REYES</approverName>'+        
    '<approvalObject>Cedula Asesor</approvalObject>'+
    '<approvalRequestedDate>11/28/2014 14:39:03</approvalRequestedDate>'+
    '<approvalName>1-31091595</approvalName>'+
    '<approvalId>1-IIEFQ</approvalId>'+         
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Comision 'Cédula Prospectador'
    public static void CedulaProspector_test() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SDIAZ</requesterLogin>'+
    '<requesterEmpId>1-YS22</requesterEmpId>'+
    '<requesterName>SERGIO TOMAS DIAZ</requesterName>       '+
    '<approverLogin>RSALAZAR</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>ROSALINDA SALAZAR</approverName> '+
    '<approvalObject>Cedula Prospectador</approvalObject>'+
    '<approvalRequestedDate>11/24/2014 11:57:28</approvalRequestedDate>'+
    '<approvalName>1-30178198</approvalName>'+
    '<approvalId>1-I72QD</approvalId>   '+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>BOSQUE DE LOS NOGALES</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Nombre</name>'+
                            '<value>SERGIO DIAZ</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Codigo</name>'+
                            '<value>1-30178198</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>NOVIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Comisión</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Rol Ventas</name>'+
                            '<value>Prospectador</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Forma Pago</name>'+
                            '<value>NOVIEMBRE SEM3</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Numero Equipo</name>'+
                            '<value>1-3490403</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Empleado</name>'+
                            '<value>GABRIELA FRAIRE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cant Reservas</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cant Formalizadas</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cant Escrituradas</name>'+
                            '<value>1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cant Exigibles</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cant Canceladas</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Total a Pagar</name>'+
                            '<value>687.76</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
'</xml>';

                        
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    
    //Comision 'Cédula Prospectador' Excepcion
    public static void CedulaProspector_Xtest() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SDIAZ</requesterLogin>'+
    '<requesterEmpId>1-YS22</requesterEmpId>'+
    '<requesterName>SERGIO TOMAS DIAZ</requesterName>       '+
    '<approverLogin>RSALAZAR</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>ROSALINDA SALAZAR</approverName> '+
    '<approvalObject>Cedula Prospectador</approvalObject>'+
    '<approvalRequestedDate>11/24/2014 11:57:28</approvalRequestedDate>'+
    '<approvalName>1-30178198</approvalName>'+
    '<approvalId>1-I72QD</approvalId>   '+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>BOSQUE DE LOS NOGALES</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Comision 'Plan Comisión Asesor'
    public static void PlanComAsesor_test() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>        '+
    '<approverLogin>FLOZANO</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>Fernando Salvador Lozano</approverName>      '+
    '<approvalObject>Plan Comision Asesor</approvalObject>'+
    '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
    '<approvalName>1-31330637</approvalName>'+
    '<approvalId>1-INIW1</approvalId>       '+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Nombre</name>'+
                            '<value>UNO</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Codigo</name>'+
                            '<value>1-31330637</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Comisión</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Rol Ventas</name>'+
                            '<value>Asesor</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Forma Pago</name>'+
                            '<value>Ventas Netas</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Numero Equipo</name>'+
                            '<value>1-3490395</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Equipo</name>'+
                            '<value>ANDRES MONTAÑEZ</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Categoria</name>'+
                            '<value>Junior</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Base</name>'+
                            '<value>12</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Cumplimiento</name>'+
                            '<value>2</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Excedente</name>'+
                            '<value>0</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Etapa Venta</name>'+
                            '<value>03 Escrituración</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Pago</name>'+
                            '<value>50</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Meta Grupal</name>'+
                            '<value>16</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Meta Individual</name>'+
                            '<value>1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>No Miembros</name>'+
                            '<value>16</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
'</xml>';

                        
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Comision 'Plan Comisión Asesor' Excepcion
    public static void PlanComAsesor_Xtest() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>        '+
    '<approverLogin>FLOZANO</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>Fernando Salvador Lozano</approverName>      '+
    '<approvalObject>Plan Comision Asesor</approvalObject>'+
    '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
    '<approvalName>1-31330637</approvalName>'+
    '<approvalId>1-INIW1</approvalId>       '+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    
    //Comision 'Plan Comisión Prospectador'
    public static void PlanComPrsp_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+          
    '<approverLogin>AALVAREZ</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>AZAEL ALVAREZ</approverName>'+       
    '<approvalObject>Plan Comision Prospectador</approvalObject>'+
    '<approvalRequestedDate>12/09/2014 11:37:23</approvalRequestedDate>'+
    '<approvalName>1-31342301</approvalName>'+
    '<approvalId>1-INRVQ</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>BOSQUES DE SAN JUAN</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Nombre</name>'+
                            '<value>AQUILES BAEZ DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Codigo</name>'+
                            '<value>1-31342301</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Comisión</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Rol Ventas</name>'+
                            '<value>Prospectador</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Forma Pago</name>'+
                            '<value>Ventas Brutas</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Numero Equipo</name>'+
                            '<value>1-12196732</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Equipo</name>'+
                            '<value>EQUIPO TEMPORAL PROSP</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Categoria</name>'+
                            '<value>NA</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Base</name>'+
                            '<value>34</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Cumplimiento</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Excedente</name>'+
                            '<value>0</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Etapa Venta</name>'+
                            '<value>02 Formalización</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Pct Pago</name>'+
                            '<value>100</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Meta Grupal</name>'+
                            '<value>1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Meta Individual</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>No Miembros</name>'+
                            '<value>0</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';
     
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Comision 'Plan Comisión Prospectador' Excepcion
    public static void PlanComPrsp_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+          
    '<approverLogin>AALVAREZ</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>AZAEL ALVAREZ</approverName>'+       
    '<approvalObject>Plan Comision Prospectador</approvalObject>'+
    '<approvalRequestedDate>12/09/2014 11:37:23</approvalRequestedDate>'+
    '<approvalName>1-31342301</approvalName>'+
    '<approvalId>1-INRVQ</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>BOSQUES DE SAN JUAN</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
   
    //Comision 'Plan Bono Asesor'
    public static void PlanBonoAsesor_test() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>1-TEST</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono Asesor</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
        '<listOfApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Nombre</name>'+
                                '<value>UNO</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Codigo</name>'+
                                '<value>1-31330637</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Periodo</name>'+
                                '<value>DICIEMBRE 2014</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Tipo</name>'+
                                '<value>Comisión</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Rol Ventas</name>'+
                                '<value>Asesor</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Forma Pago</name>'+
                                '<value>Ventas Netas</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Numero Equipo</name>'+
                                '<value>1-3490395</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Nombre Equipo</name>'+
                                '<value>ANDRES MONTAÑEZ</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Categoria</name>'+
                                '<value>Junior</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Valor del Bono</name>'+
                                '<value>12</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Etapa Venta</name>'+
                                '<value>03 Escrituración</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Pct Pago</name>'+
                                '<value>50</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Meta Grupal</name>'+
                                '<value>16</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Meta Individual</name>'+
                                '<value>1</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>No Miembros</name>'+
                                '<value>16</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
        '</listOfApprovalData>'+
    '</xml>';
               
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Comision 'Plan Bono Asesor' Excepcion
    public static void PlanBonoAsesor_Xtest() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>Exception</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono Asesor</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    
    //Comision 'Plan Bono Col. Javer'
    public static void PlanBonoColJaver_test() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>1-TEST</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono Col. Javer</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
        '<listOfApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Nombre</name>'+
                                '<value>UNO</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Codigo</name>'+
                                '<value>1-31330637</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Periodo</name>'+
                                '<value>DICIEMBRE 2014</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Tipo</name>'+
                                '<value>Comisión</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Rol Ventas</name>'+
                                '<value>Asesor</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Forma Pago</name>'+
                                '<value>Ventas Netas</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Numero Equipo</name>'+
                                '<value>1-3490395</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Nombre Equipo</name>'+
                                '<value>ANDRES MONTAÑEZ</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Categoria</name>'+
                                '<value>Junior</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Valor del Bono</name>'+
                                '<value>12</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Etapa Venta</name>'+
                                '<value>03 Escrituración</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Pct Pago</name>'+
                                '<value>50</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Meta Grupal</name>'+
                                '<value>16</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Meta Individual</name>'+
                                '<value>1</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>No Miembros</name>'+
                                '<value>16</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
        '</listOfApprovalData>'+
    '</xml>';
               
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Comision 'Plan Bono Col. Javer' Exception
    public static void PlanBonoColJaver_Xtest() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>Exception</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono Col. Javer</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Comision 'Plan Bono Prospectador'
    public static void PlanBonoProspectador_test() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>1-TEST</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono Prospectador</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
        '<listOfApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Nombre</name>'+
                                '<value>UNO</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Codigo</name>'+
                                '<value>1-31330637</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Periodo</name>'+
                                '<value>DICIEMBRE 2014</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Tipo</name>'+
                                '<value>Comisión</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Rol Ventas</name>'+
                                '<value>Asesor</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Forma Pago</name>'+
                                '<value>Ventas Netas</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Numero Equipo</name>'+
                                '<value>1-3490395</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Nombre Equipo</name>'+
                                '<value>ANDRES MONTAÑEZ</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Categoria</name>'+
                                '<value>Junior</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Valor del Bono</name>'+
                                '<value>12</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Etapa Venta</name>'+
                                '<value>03 Escrituración</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Pct Pago</name>'+
                                '<value>50</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Meta Grupal</name>'+
                                '<value>16</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Meta Individual</name>'+
                                '<value>1</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>No Miembros</name>'+
                                '<value>16</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
        '</listOfApprovalData>'+
    '</xml>';

                        
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Comision 'Plan Bono Prospectador' Exception
    public static void PlanBonoProspectador_Xtest() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>Exception</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono Prospectador</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '</xml>';

                        
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Comision 'Plan Bono_Col. Javer'
    public static void PlanBono_ColJaver_test() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>1-TEST</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono_Col. Javer</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
        '<listOfApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Nombre</name>'+
                                '<value>UNO</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Codigo</name>'+
                                '<value>1-31330637</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Periodo</name>'+
                                '<value>DICIEMBRE 2014</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Tipo</name>'+
                                '<value>Comisión</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Rol Ventas</name>'+
                                '<value>Asesor</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Forma Pago</name>'+
                                '<value>Ventas Netas</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Numero Equipo</name>'+
                                '<value>1-3490395</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Nombre Equipo</name>'+
                                '<value>ANDRES MONTAÑEZ</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Categoria</name>'+
                                '<value>Junior</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Valor del Bono</name>'+
                                '<value>12</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Etapa Venta</name>'+
                                '<value>03 Escrituración</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Pct Pago</name>'+
                                '<value>50</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Meta Grupal</name>'+
                                '<value>16</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Meta Individual</name>'+
                                '<value>1</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>No Miembros</name>'+
                                '<value>16</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
        '</listOfApprovalData>'+
    '</xml>';
                        
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Comision 'Plan Bono_Col. Javer' Exception
    public static void PlanBono_ColJaver_Xtest() {
      String response =''+
    '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>        '+
        '<approverLogin>FLOZANO</approverLogin>'+
        '<approverEmpId>Exception</approverEmpId>'+
        '<approverName>Fernando Salvador Lozano</approverName>      '+
        '<approvalObject>Plan Bono_Col. Javer</approvalObject>'+
        '<approvalRequestedDate>12/08/2014 16:43:15</approvalRequestedDate>'+
        '<approvalName>1-31330637</approvalName>'+
        '<approvalId>1-INIW1</approvalId>       '+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
    '</xml>';
                        
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Planning 'Extension de Periodos' 
    public static void ExtPeriodos_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-RVGG</requesterEmpId>'+
    '<requesterName>Oscar Alejandro De Anda</requesterName>'+   
    '<approverLogin>SPGONZALEZ</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>SANDRA PATRICIA GONZALEZ</approverName>'+
    '<approvalId>1-FN0GW</approvalId>'+
    '<approvalObject>Extension de Periodos</approvalObject>'+
    '<approvalRequestedDate>10/30/2014 17:39:44</approvalRequestedDate>'+
    '<approvalName>Aprobacion de Extension de Periodo</approvalName>'+
    '<approvalType>Paralela</approvalType>'+
    '<approvalLevel>Unico</approvalLevel>'+
    '<approvalLevelValue/>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>OCTUBRE SEM5</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fin Periodo</name>'+
                            '<value>10/31/2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Extension</name>'+
                            '<value>10/31/2014</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Planning 'Extension de Periodos' Excepcion
    public static void ExtPeriodos_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-RVGG</requesterEmpId>'+
    '<requesterName>Oscar Alejandro De Anda</requesterName>'+   
    '<approverLogin>SPGONZALEZ</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>SANDRA PATRICIA GONZALEZ</approverName>'+
    '<approvalId>1-FN0GW</approvalId>'+
    '<approvalObject>Extension de Periodos</approvalObject>'+
    '<approvalRequestedDate>10/30/2014 17:39:44</approvalRequestedDate>'+
    '<approvalName>Aprobacion de Extension de Periodo</approvalName>'+
    '<approvalType>Paralela</approvalType>'+
    '<approvalLevel>Unico</approvalLevel>'+
    '<approvalLevelValue/>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Planning 'Bonificaciones Batch'
    public static void BonBatch_test() {
      String response =''+
      '<xml xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="ApprovalEAI.xsd">'+
        '<platform>Siebel</platform>'+
        '<token>14896C5C5759967674A4635010</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<approverLogin>APPROVER_USR</approverLogin>'+
        '<approverEmpId>1-TEST</approverEmpId>'+
        '<approvalObject>Bonificaciones Batch</approvalObject>'+
        '<approvalRequestedDate>11/25/2014 04:36:05</approvalRequestedDate>'+
        '<approvalName>1-IMHSF</approvalName>'+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
        '<listOfApprovalData>'+
            '<approvalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Fraccionamiento</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Periodo</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Prototipo</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Nombre Bonificacion</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Tipo</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Clase</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Monto/Porcentaje</name>'+
                                '<value/>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Fraccionamiento</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Periodo</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Prototipo</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Nombre Bonificacion</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Tipo</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Clase</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Monto/Porcentaje</name>'+
                                '<value/>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</approvalData>'+
        '</listOfApprovalData>'+
    '</xml>';
      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Planning 'Bonificaciones Batch' Excepcion
    public static void BonBatch_Xtest() {
      String response =''+
      '<xml xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="ApprovalEAI.xsd">'+
        '<platform>Siebel</platform>'+
        '<token>14896C5C5759967674A4635010</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<approverLogin>APPROVER_USR</approverLogin>'+
        '<approverEmpId>Exception</approverEmpId>'+
        '<approvalObject>Bonificaciones Batch</approvalObject>'+
        '<approvalRequestedDate>11/25/2014 04:36:05</approvalRequestedDate>'+
        '<approvalName>1-IMHSF</approvalName>'+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Planning 'Lista de Bonificaciones Batch'
    public static void ListBonBatch_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>ATORRES</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>JOSE ADRIAN TORRES</approverName>'+
    '<approvalObject>Lista de Bonificaciones Batch</approvalObject>'+
    '<approvalRequestedDate>12/08/2014 15:31:30</approvalRequestedDate>'+
    '<approvalName>1-INIUQ</approvalName>'+
    '<approvalId>1-INIUW</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>ANTARES PB</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Bonificacion</name>'+
                            '<value>BONFI VDR ALB</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Bonificación de contado</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Clase</name>'+
                            '<value>Porcentaje</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto/Porcentaje</name>'+
                            '<value>232</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>ANTARES PB</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Bonificacion</name>'+
                            '<value>BONFI VDR ALB</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Bonificación de mes</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Clase</name>'+
                            '<value>Importe</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto/Porcentaje</name>'+
                            '<value>2333</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>ANTARES PN</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Bonificacion</name>'+
                            '<value>BONIF VDR PROT 2 DIC 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Bonificación de contado</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Clase</name>'+
                            '<value>Importe</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto/Porcentaje</name>'+
                            '<value>2323</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>ANTARES PN</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Bonificacion</name>'+
                            '<value>BONIF VDR PROT 2 DIC 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Bonificación de mes</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Clase</name>'+
                            '<value>Porcentaje</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto/Porcentaje</name>'+
                            '<value>3</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Planning 'Lista de Bonificaciones Batch' Excepcion
    public static void ListBonBatch_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>ATORRES</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>JOSE ADRIAN TORRES</approverName>'+
    '<approvalObject>Lista de Bonificaciones Batch</approvalObject>'+
    '<approvalRequestedDate>12/08/2014 15:31:30</approvalRequestedDate>'+
    '<approvalName>1-INIUQ</approvalName>'+
    '<approvalId>1-INIUW</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Planning 'Lista de Financiamientos Batch'
    public static void ListFinBatch_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>ACAVAZOS</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>ALDO ISMAEL CAVAZOS</approverName>'+ 
    '<approvalObject>Lista de Financiamientos Batch</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 11:03:01</approvalRequestedDate>'+
    '<approvalName>1-IMHSF</approvalName>'+
    '<approvalId>1-IMHSN</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>1-20YID</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Financiamiento</name>'+
                            '<value>VI VDR FINANCIAMIENTO DIC 2014 PROT 1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Categoria</name>'+
                            '<value>Financiamiento de enganche</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Porcentaje</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plazo</name>'+
                            '<value>23</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto/Porcentaje</name>'+
                            '<value>23</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>1-20YOX</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Financiamiento</name>'+
                            '<value>VI VDR FINANCIAMIENTO DIC 2014 PROT 2</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Categoria</name>'+
                            '<value>Financiamiento de enganche</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Porcentaje</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plazo</name>'+
                            '<value>11</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto/Porcentaje</name>'+
                            '<value>12</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Nombre Financiamiento</name>'+
                            '<value>1-IMHSF</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Categoria</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>% de financiamiento</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plazo</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto/Porcentaje</name>'+
                            '<value/>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Planning 'Lista de Financiamientos Batch' Excepcion
    public static void ListFinBatch_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>ACAVAZOS</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>ALDO ISMAEL CAVAZOS</approverName>'+ 
    '<approvalObject>Lista de Financiamientos Batch</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 11:03:01</approvalRequestedDate>'+
    '<approvalName>1-IMHSF</approvalName>'+
    '<approvalId>1-IMHSN</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Planning 'Lista de Precios Batch Prods'
    public static void ListaPreciosBatchProds_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-7XQVA</requesterEmpId>'+
    '<requesterName>MARTHA PAULA VIRGINIA COXCA</requesterName>'+   
    '<approverLogin>VSANCHEZ</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>VILMA BERENICE SANCHEZ</approverName>'+      
    '<approvalObject>Lista de Precios Batch Prods</approvalObject>'+
    '<approvalRequestedDate>11/24/2014 09:42:10</approvalRequestedDate>'+
    '<approvalName>1-I63AD - LOS CARACOLES - DICIEMBRE 2014</approvalName>'+
    '<approvalId>1-I63AH</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>UEN</approvalLevel>'+
    '<approvalLevelValue>DIRECCION REGIONAL REYNOSA</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>AGUILA</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>AMBAR CONTEMPORANEA</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>VERONA PA</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>VERONA PA</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>VERONA PB</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>JAVER</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>AMBAR CONTEMPORANEA</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>LOS CARACOLES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>AGUILA</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Planning 'Lista de Precios Batch Prods' Excepcion
    public static void ListaPreciosBatchProds_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-7XQVA</requesterEmpId>'+
    '<requesterName>MARTHA PAULA VIRGINIA COXCA</requesterName>'+   
    '<approverLogin>VSANCHEZ</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>VILMA BERENICE SANCHEZ</approverName>'+      
    '<approvalObject>Lista de Precios Batch Prods</approvalObject>'+
    '<approvalRequestedDate>11/24/2014 09:42:10</approvalRequestedDate>'+
    '<approvalName>1-I63AD - LOS CARACOLES - DICIEMBRE 2014</approvalName>'+
    '<approvalId>1-I63AH</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>UEN</approvalLevel>'+
    '<approvalLevelValue>DIRECCION REGIONAL REYNOSA</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Planning 'Lista de Precios Batch'
    public static void ListaPreciosBatch_test() {
      String response =''+
     '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+      
    '<approverLogin>ATORRES</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>ALDO ISMAEL CAVAZOS</approverName>'+ 
    '<approvalObject>Lista de Precios Batch</approvalObject>'+
    '<approvalRequestedDate>12/04/2014 12:09:48</approvalRequestedDate>'+
    '<approvalName>1-ILRJS - DICIEMBRE 2014 - VALLE DEL ROBLE</approvalName>'+
    '<approvalId>1-I63AH</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>DICIEMBRE 2014</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>AGUILA</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Lista</name>'+
                            '<value>326900</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>>Precio Metro Excedente</name>'+
                            '<value>300</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Avenida</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Cablevision</name>'+
                            '<value>1200</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Esquina</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Lado Sol</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Lado Sombra</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Parque</name>'+
                            '<value>0</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+

            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Planning 'Lista de Precios Batch' Excepcion
    public static void ListaPreciosBatch_Xtest() {
      String response =''+
     '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+      
    '<approverLogin>ATORRES</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>ALDO ISMAEL CAVAZOS</approverName>'+ 
    '<approvalObject>Lista de Precios Batch</approvalObject>'+
    '<approvalRequestedDate>12/04/2014 12:09:48</approvalRequestedDate>'+
    '<approvalName>1-ILRJS - DICIEMBRE 2014 - VALLE DEL ROBLE</approvalName>'+
    '<approvalId>1-I63AH</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Planning 'Lista de Precios'
    public static void ListaPrecios_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+      
    '<approverLogin>RMARTINEZ</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>Rene Martinez</approverName>'+       
    '<approvalObject>Lista de Precios</approvalObject>'+
    '<approvalRequestedDate>11/28/2014 14:28:49</approvalRequestedDate>'+
    '<approvalName>Aprobación de Lista de Precios Individual</approvalName>'+
    '<approvalId>1-IHQBX</approvalId>'+         
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>PASEO DE GUADALUPE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>PASEO DE GUADALUPE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Periodo</name>'+
                            '<value>ENERO 2015</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Prototipo</name>'+
                            '<value>AGUILA ELITE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Lista</name>'+
                            '<value>560000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>>Precio Metro Excedente</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Avenida</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Cablevision</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Esquina</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Lado Sol</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Lado Sombra</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio Parque</name>'+
                            '<value>0</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Planning 'Lista de Precios' Excepcion
    public static void ListaPrecios_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+      
    '<approverLogin>RMARTINEZ</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>Rene Martinez</approverName>'+       
    '<approvalObject>Lista de Precios</approvalObject>'+
    '<approvalRequestedDate>11/28/2014 14:28:49</approvalRequestedDate>'+
    '<approvalName>Aprobación de Lista de Precios Individual</approvalName>'+
    '<approvalId>1-IHQBX</approvalId>'+         
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>PASEO DE GUADALUPE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    
    //Venta 'Bonif. Emp. de Plan de Venta'
    public static void BonEmpPlanVta_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-1132G</requesterEmpId>'+
    '<requesterName>SANDRA SELENE HERRERA</requesterName>'+         
    '<approverLogin>ASALAZAR</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>ALFREDO GERMAN SALAZAR</approverName>'+      
    '<approvalObject>Bonif. Emp. de Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/20/2014 16:16:08</approvalRequestedDate>'+
    '<approvalName>1-29972456-1</approvalName>'+
    '<approvalId>1-HUV90</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>UEN</approvalLevel>'+
    '<approvalLevelValue>DIRECCION REGIONAL ZONA 2</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>ANTONIO DE JESUS BARRERA VALDEZ</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>BOSQUE DE LOS NOGALES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-29972456</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plan de Venta</name>'+
                            '<value>1-29972456-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>366462</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Venta 'Bonif. Emp. de Plan de Venta' Exception
    public static void BonEmpPlanVta_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-1132G</requesterEmpId>'+
    '<requesterName>SANDRA SELENE HERRERA</requesterName>'+         
    '<approverLogin>ASALAZAR</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>ALFREDO GERMAN SALAZAR</approverName>'+      
    '<approvalObject>Bonif. Emp. de Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/20/2014 16:16:08</approvalRequestedDate>'+
    '<approvalName>1-29972456-1</approvalName>'+
    '<approvalId>1-HUV90</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>UEN</approvalLevel>'+
    '<approvalLevelValue>DIRECCION REGIONAL ZONA 2</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    
    
    //Venta 'Bonificacion de Plan de Venta'
    public static void BonPlanVta_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-14DDZ</requesterEmpId>'+
    '<requesterName>CONSUELO OLIVARES</requesterName>'+ 
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+   
    '<approvalObject>Bonificacion de Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:08:33</approvalRequestedDate>'+
    '<approvalName>1-31021638-1</approvalName>'+
    '<approvalId>1-IGYM2</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DE SANTA MARIA</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>FRANCISCO GOMEZ HERNANDEZ</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DE SANTA MARIA</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-31021638</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plan de Venta</name>'+
                            '<value>1-31021638-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>207210.36</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Bonificacion Autorizada</name>'+
                            '<value>12000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Bonificacion Solicitada</name>'+
                            '<value>18689.64</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Diferencia</name>'+
                            '<value>6689.64</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Venta 'Bonificacion de Plan de Venta' Exception
    public static void BonPlanVta_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-14DDZ</requesterEmpId>'+
    '<requesterName>CONSUELO OLIVARES</requesterName>'+ 
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+   
    '<approvalObject>Bonificacion de Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:08:33</approvalRequestedDate>'+
    '<approvalName>1-31021638-1</approvalName>'+
    '<approvalId>1-IGYM2</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DE SANTA MARIA</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Venta 'Excepcion Bonif. Emp. ColJaver'
    public static void ExcBonEmpColJaver_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-14DDZ</requesterEmpId>'+
    '<requesterName>CONSUELO OLIVARES</requesterName>'+ 
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+   
    '<approvalObject>Excepcion Bonif. Emp. ColJaver</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:08:33</approvalRequestedDate>'+
    '<approvalName>1-31021638-1</approvalName>'+
    '<approvalId>1-IGYM2</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DE SANTA MARIA</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>FRANCISCO GOMEZ HERNANDEZ</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DE SANTA MARIA</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-31021638</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plan de Venta</name>'+
                            '<value>1-31021638-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>207210.36</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Bonificacion Autorizada</name>'+
                            '<value>12000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Bonificacion Solicitada</name>'+
                            '<value>18689.64</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Diferencia</name>'+
                            '<value>6689.64</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Venta 'Excepcion Bonif. Emp. ColJaver' Exception
    public static void ExcBonEmpColJaver_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-14DDZ</requesterEmpId>'+
    '<requesterName>CONSUELO OLIVARES</requesterName>'+ 
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+   
    '<approvalObject>Excepcion Bonif. Emp. ColJaver</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:08:33</approvalRequestedDate>'+
    '<approvalName>1-31021638-1</approvalName>'+
    '<approvalId>1-IGYM2</approvalId>'+ 
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DE SANTA MARIA</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Venta 'Financiamiento Plan de Venta'
    public static void FinPlanVta_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-14CF9</requesterEmpId>'+
    '<requesterName>JAIME ARTURO VALLE</requesterName>'+        
    '<approverLogin>STREVINO</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>SERGIO RAUL TREVIÑO</approverName>'+     
    '<approvalObject>Financiamiento Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:37:55</approvalRequestedDate>'+
    '<approvalName>1-30424685-1</approvalName>'+
    '<approvalId>1-IH2I3</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DE LOS MOLINOS</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>MARIO LARIOS GONZALEZ</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DE LOS MOLINOS</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-30424685</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plan de Venta</name>'+
                            '<value>1-30424685-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>316000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Financiamiento Autorizado</name>'+
                            '<value>3</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Financiamiento Solicitado</name>'+
                            '<value>15325.514.8498449367089</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Diferencia</name>'+
                            '<value>1.8498449367089</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plazo Autorizado</name>'+
                            '<value>12</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plazo Solicitado</name>'+
                            '<value>12</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Venta 'Financiamiento Plan de Venta' Excepcion
    public static void FinPlanVta_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-14CF9</requesterEmpId>'+
    '<requesterName>JAIME ARTURO VALLE</requesterName>'+        
    '<approverLogin>STREVINO</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>SERGIO RAUL TREVIÑO</approverName>'+     
    '<approvalObject>Financiamiento Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:37:55</approvalRequestedDate>'+
    '<approvalName>1-30424685-1</approvalName>'+
    '<approvalId>1-IH2I3</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DE LOS MOLINOS</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Venta 'Paquetes de Plan de Venta'
    public static void PaqPlanVta_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-Z72Q</requesterEmpId>'+
    '<requesterName>VIVIANA ELIZABETH REVILLA</requesterName>'+     
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+       
    '<approvalObject>Paquetes de Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 18:45:50</approvalRequestedDate>'+
    '<approvalName>1-30403551-1</approvalName>'+
    '<approvalId>1-IGPOT</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>PRIVADA VIA SIETE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>JOSE ANTONIO ALVAREZ LLANAS</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>PRIVADA VIA SIETE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-30403551</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plan de Venta</name>'+
                            '<value>1-30403551-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>287000</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Producto</name>'+
                            '<value>PAQUETE 1402 -20,000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Paquete</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cantidad</name>'+
                            '<value>1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio</name>'+
                            '<value>287000</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Producto</name>'+
                            '<value>COMPLEMENTO 14C</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Paquete</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cantidad</name>'+
                            '<value>1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio</name>'+
                            '<value>287000</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Producto</name>'+
                            '<value>COMPLEMENTO 14F</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Tipo</name>'+
                            '<value>Paquete</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Cantidad</name>'+
                            '<value>1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Precio</name>'+
                            '<value>287000</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Venta 'Paquetes de Plan de Venta' Exception
    public static void PaqPlanVta_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-Z72Q</requesterEmpId>'+
    '<requesterName>VIVIANA ELIZABETH REVILLA</requesterName>'+     
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+       
    '<approvalObject>Paquetes de Plan de Venta</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 18:45:50</approvalRequestedDate>'+
    '<approvalName>1-30403551-1</approvalName>'+
    '<approvalId>1-IGPOT</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>PRIVADA VIA SIETE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Pre Venta 'VO. Menor a Presupuesto'
    public static void VOMenPres_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>186A494867C96445949405F49074A35720</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>LPORRAGAS</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>Luis Ignacio Porragas</approverName>'+
    '<approvalObject>VO. Menor a Presupuesto</approvalObject>'+
    '<approvalRequestedDate>01/28/2015 09:55:29</approvalRequestedDate>'+
    '<approvalName>1-32017531-1</approvalName>'+
    '<approvalId>1-JB73Z</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>PRIVADAS OCANIA</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>POMPOSO SANCHEZ ZENDEJAS</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>RINCONADA LAGO DE GUADALUPE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-2424241</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Plan de Venta</name>'+
                            '<value>1-2424241-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>415503</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Quote Id</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>sPriListId</name>'+
                            '<value/>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
   
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Pre Venta 'VO. Menor a Presupuesto' Exception
    public static void VOMenPres_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>186A494867C96445949405F49074A35720</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>LPORRAGAS</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>Luis Ignacio Porragas</approverName>'+
    '<approvalObject>VO. Menor a Presupuesto</approvalObject>'+
    '<approvalRequestedDate>01/28/2015 09:55:29</approvalRequestedDate>'+
    '<approvalName>1-32017531-1</approvalName>'+
    '<approvalId>1-JB73Z</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>PRIVADAS OCANIA</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    
    //Post Venta 'Financiamiento Post Venta'
    public static void FinPostVta_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+  
    '<approverLogin>GTOVAR</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>GERARDO TOVAR</approverName>'+       
    '<approvalObject>Financiamiento Post Venta</approvalObject>'+
    '<approvalRequestedDate>11/28/2014 14:20:13</approvalRequestedDate>'+
    '<approvalName>1-29960483</approvalName>'+
    '<approvalId>1-IIDIX</approvalId>'+         
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>BOSQUE DE LOS NOGALES</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>RODOLFO JASSO REYES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>BOSQUE DE LOS NOGALES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Escritura</name>'+
                            '<value>1-29960483</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>214000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto Subsidio</name>'+
                            '<value>3</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Financiamiento Solicitado</name>'+
                            '<value>214000</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Post Venta 'Financiamiento Post Venta' Exception
    public static void FinPostVta_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+  
    '<approverLogin>GTOVAR</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>GERARDO TOVAR</approverName>'+       
    '<approvalObject>Financiamiento Post Venta</approvalObject>'+
    '<approvalRequestedDate>11/28/2014 14:20:13</approvalRequestedDate>'+
    '<approvalName>1-29960483</approvalName>'+
    '<approvalId>1-IIDIX</approvalId>'+         
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>BOSQUE DE LOS NOGALES</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Post Venta 'Finan PostVenta Col Javer'
    public static void FinPVColJaver_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+  
    '<approverLogin>GTOVAR</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>GERARDO TOVAR</approverName>'+       
    '<approvalObject>Finan PostVenta Col Javer</approvalObject>'+
    '<approvalRequestedDate>11/28/2014 14:20:13</approvalRequestedDate>'+
    '<approvalName>1-29960483</approvalName>'+
    '<approvalId>1-IIDIX</approvalId>'+         
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>BOSQUE DE LOS NOGALES</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>RODOLFO JASSO REYES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>BOSQUE DE LOS NOGALES</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Escritura</name>'+
                            '<value>1-29960483</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>214000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Monto Subsidio</name>'+
                            '<value>3</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Financiamiento Solicitado</name>'+
                            '<value>214000</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Post Venta 'Finan PostVenta Col Javer' Exception
    public static void FinPVColJaver_Xtest() {
      String response =''+
      '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>1234</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>'+  
        '<approverLogin>GTOVAR</approverLogin>'+
        '<approverEmpId>Exception</approverEmpId>'+
        '<approverName>GERARDO TOVAR</approverName>'+       
        '<approvalObject>Finan PostVenta Col Javer</approvalObject>'+
        '<approvalRequestedDate>11/28/2014 14:20:13</approvalRequestedDate>'+
        '<approvalName>1-29960483</approvalName>'+
        '<approvalId>1-IIDIX</approvalId>'+         
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Fraccionamiento</approvalLevel>'+
        '<approvalLevelValue>BOSQUE DE LOS NOGALES</approvalLevelValue>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    
    //Post Venta 'Financiamiento Reestructura PV'
    public static void FinReestructuraPV_test() {
      String response =''+
      '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>CAD4A5E6366560A4C97987FA5073</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>'+
        '<approverLogin>LPORRAGAS</approverLogin>'+
        '<approverEmpId>1-TEST</approverEmpId>'+
        '<approverName>Luis Ignacio Porragas</approverName>'+
        '<approvalObject>Financiamiento Reestructura PV</approvalObject>'+
        '<approvalRequestedDate>01/30/2015 12:33:59</approvalRequestedDate>'+
        '<approvalName>1-5041919</approvalName>'+
        '<approvalId>1-JC99A</approvalId>'+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Unico</approvalLevel>'+
        '<approvalLevelValue/>'+
        '<listOfApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Cliente</name>'+
                                '<value>CAYETANO CAMPOS LOREDO</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Fraccionamiento</name>'+
                                '<value>VALLE DEL ROBLE</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Proceso</name>'+
                                '<value>1-5041919</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Monto a Reestructurar</name>'+
                                '<value>7859.48</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Pct a Reestructurar</name>'+
                                '<value>19.25</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Plazo</name>'+
                                '<value>21</value>'+
                            '</field>'+
                            '<field>'+
                                '<name>Frecuencia</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Fecha Inicio Cob</name>'+
                                '<value/>'+
                            '</field>'+
                            '<field>'+
                                '<name>Mensualidad Aproximada</name>'+
                                '<value>374.26095238095</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
        '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Post Venta 'Financiamiento Reestructura PV' Exception
    public static void FinReestructuraPV_Xtest() {
      String response =''+
      '<xml>'+
        '<platform>Siebel</platform>'+
        '<token>CAD4A5E6366560A4C97987FA5073</token>'+
        '<requesterLogin>SADMIN</requesterLogin>'+
        '<requesterEmpId>0-1</requesterEmpId>'+
        '<requesterName>Siebel Administrator</requesterName>'+
        '<approverLogin>LPORRAGAS</approverLogin>'+
        '<approverEmpId>Exception</approverEmpId>'+
        '<approverName>Luis Ignacio Porragas</approverName>'+
        '<approvalObject>Financiamiento Reestructura PV</approvalObject>'+
        '<approvalRequestedDate>01/30/2015 12:33:59</approvalRequestedDate>'+
        '<approvalName>1-5041919</approvalName>'+
        '<approvalId>1-JC99A</approvalId>'+
        '<approvalType>Secuencial</approvalType>'+
        '<approvalLevel>Unico</approvalLevel>'+
        '<approvalLevelValue/>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    
    //Post Venta 'Subsidio'
    public static void Subsidio_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-YOYM</requesterEmpId>'+
    '<requesterName>MAYRA KARINA ORNELAS</requesterName>'+      
    '<approverLogin>RSALAZAR</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>ROSALINDA SALAZAR</approverName>'+       
    '<approvalObject>Subsidio</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:23:54</approvalRequestedDate>'+
    '<approvalName>1-29975222</approvalName>'+
    '<approvalId>1-IH02S</approvalId>'+ 
    '<approvalType>Paralela</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VILLAS DEL JARAL</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>JULIO CESAR PALACIOS SOSA</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VILLAS DEL JARAL</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Escritura</name>'+
                            '<value>1-29975222</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Valor de Operacion</name>'+
                            '<value>301000</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Financiamiento Solicitado</name>'+
                            '<value>17907.96</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Subsidio</name>'+
                            '<value>61368.48</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Post Venta 'Subsidio' Exception
    public static void Subsidio_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>1-YOYM</requesterEmpId>'+
    '<requesterName>MAYRA KARINA ORNELAS</requesterName>'+      
    '<approverLogin>RSALAZAR</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>ROSALINDA SALAZAR</approverName>'+       
    '<approvalObject>Subsidio</approvalObject>'+
    '<approvalRequestedDate>11/25/2014 19:23:54</approvalRequestedDate>'+
    '<approvalName>1-29975222</approvalName>'+
    '<approvalId>1-IH02S</approvalId>'+ 
    '<approvalType>Paralela</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VILLAS DEL JARAL</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Post Venta 'Garantia'
    public static void Garantia_test() {
      String response =''+
   '<xml>'+
  '<platform>Siebel</platform>'+
  '<token>9AABCA8B542CE435C6941616472714D6F6C020D3</token>'+
  '<requesterLogin>SVAZQUEZ</requesterLogin>'+
  '<requesterEmpId>1-58SKB</requesterEmpId>'+
  '<requesterName>SANDRA VIOLETA VAZQUEZ</requesterName>'+
  '<approverLogin>DRAMIREZ</approverLogin>'+
  '<approverEmpId>1-TEST</approverEmpId>'+
  '<approverName>DANIEL RAMIREZ</approverName>'+
  '<approvalObject>Garantia</approvalObject>'+
  '<approvalRequestedDate>02/25/2015 09:19:42</approvalRequestedDate>'+
  '<approvalName>GARANTIAS</approvalName>'+
  '<approvalId>1-S5BCS</approvalId>'+
  '<approvalType>Secuencial</approvalType>'+
  '<approvalLevel>UEN</approvalLevel>'+
  '<approvalLevelValue>DIRECCION REGIONAL ZONA 2</approvalLevelValue>'+
  '<listOfApprovalData>'+
    '<ApprovalData>'+
      '<listOfRecords>'+
        '<record>'+
          '<listOfFields>'+
            '<field>'+
              '<name>Cliente</name>'+
              '<value/>'+
            '</field>'+
            '<field>'+
              '<name>Fraccionamiento</name>'+
              '<value/>'+
            '</field>'+
            '<field>'+
              '<name>Escritura</name>'+
              '<value>1-52T5T</value>'+
            '</field>'+
            '<field>'+
              '<name>Numero Garantia</name>'+
              '<value>1-47277241</value>'+
            '</field>'+
            '<field>'+
              '<name>Tipo Garantia</name>'+
              '<value>Instalaciones hidrosanitarias</value>'+
            '</field>'+
            '<field>'+
              '<name>Supervisor</name>'+
              '<value>JUAN CARLOS REYES</value>'+
            '</field>'+
            '<field>'+
              '<name>Detalle</name>'+
              '<value>FUGA EN BAÑO</value>'+
            '</field>'+
            '<field>'+
              '<name>Fecha Asignacion</name>'+
              '<value>02/25/2015</value>'+
            '</field>'+
            '<field>'+
              '<name>Fecha Vencimiento</name>'+
              '<value>11/09/2014</value>'+
            '</field>'+
            '<field>'+
              '<name>Dias Garantia</name>'+
              '<value>90</value>'+
            '</field>'+
          '</listOfFields>'+
        '</record>'+
      '</listOfRecords>'+
    '</ApprovalData>'+
  '</listOfApprovalData>'+

      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Post Venta 'Garantia' Exception
    public static void Garantia_Xtest() {
      String response =''+
    '<xml>'+
  '<platform>Siebel</platform>'+
  '<token>9AABCA8B542CE435C6941616472714D6F6C020D3</token>'+
  '<requesterLogin>SVAZQUEZ</requesterLogin>'+
  '<requesterEmpId>1-58SKB</requesterEmpId>'+
  '<requesterName>SANDRA VIOLETA VAZQUEZ</requesterName>'+
  '<approverLogin>DRAMIREZ</approverLogin>'+
  '<approverEmpId>1-TEST</approverEmpId>'+
  '<approverName>DANIEL RAMIREZ</approverName>'+
  '<approvalObject>Garantia</approvalObject>'+
  '<approvalRequestedDate>02/25/2015 09:19:42</approvalRequestedDate>'+
  '<approvalName>GARANTIAS</approvalName>'+
  '<approvalId>1-S5BCS</approvalId>'+
  '<approvalType>Secuencial</approvalType>'+
  '<approvalLevel>UEN</approvalLevel>'+
  '<approvalLevelValue>DIRECCION REGIONAL ZONA 2</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
     
    //Cancelacion 'Cancelacion de Escritura'
    public static void CancEscritura_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+  
    '<approverLogin>ANIEVES</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>JOSE ALBERTO NIEVES</approverName>'+ 
    '<approvalObject>Cancelacion de Escritura</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 11:15:11</approvalRequestedDate>'+
    '<approvalName>1-27895247</approvalName>'+
    '<approvalId>1-IMIJG</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>GILBERTO LUCIO ROJAS</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-27895247</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Estatus</name>'+
                            '<value>Cancelado</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Razon Rechazo</name>'+
                            '<value>Cambio de Empleo</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Gastos Admin</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Gastos Admin Propuesto</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Reembolso Generado</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Reembolso Propuesto</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Saldo</name>'+
                            '<value>0</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Cancelacion 'Cancelacion de Escritura' Exception
    public static void CancEscritura_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+  
    '<approverLogin>ANIEVES</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>JOSE ALBERTO NIEVES</approverName>'+ 
    '<approvalObject>Cancelacion de Escritura</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 11:15:11</approvalRequestedDate>'+
    '<approvalName>1-27895247</approvalName>'+
    '<approvalId>1-IMIJG</approvalId>'+     
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    //Cancelacion 'Cancelacion Formalizacion'
    public static void CancFormalizacion_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+      
    '<approverLogin>CTREJO</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>CECILIA TREJO</approverName>'+       
    '<approvalObject>Cancelacion Formalizacion</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 16:59:07</approvalRequestedDate>'+
    '<approvalName>1-31282637</approvalName>'+
    '<approvalId>1-IMRRN</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>ALE TEST DOS</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-31282637</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Estatus</name>'+
                            '<value>Formalizado</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Razon Rechazo</name>'+
                            '<value>Cambio de ubicación</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Gastos Admin</name>'+
                            '<value>-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Gastos Admin Propuesto</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Reembolso Generado</name>'+
                            '<value>-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Reembolso Propuesto</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Saldo</name>'+
                            '<value>6250</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Cancelacion 'Cancelacion Formalizacion' Exception
    public static void CancFormalizacion_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+      
    '<approverLogin>CTREJO</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>CECILIA TREJO</approverName>'+       
    '<approvalObject>Cancelacion Formalizacion</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 16:59:07</approvalRequestedDate>'+
    '<approvalName>1-31282637</approvalName>'+
    '<approvalId>1-IMRRN</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
    
    //Cancelacion 'Gastos Admin'
    public static void GastosAdmin_test() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>1-TEST</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+
    '<approvalObject>Gastos Admin</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 16:59:07</approvalRequestedDate>'+
    '<approvalName>1-31282637</approvalName>'+
    '<approvalId>1-INIUW</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>Cliente</name>'+
                            '<value>ALE TEST DOS</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Fraccionamiento</name>'+
                            '<value>VALLE DEL ROBLE</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Proceso</name>'+
                            '<value>1-31282637</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Estatus</name>'+
                            '<value>Formalizado</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Razon Rechazo</name>'+
                            '<value>Cambio de ubicación</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Gastos Admin Solicitados</name>'+
                            '<value>-1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Gastos Admin Propuestos</name>'+
                            '<value>0</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Saldo</name>'+
                            '<value>6250</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
      '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    }
    
    //Cancelacion 'Gastos Admin' Exception
    public static void GastosAdmin_Xtest() {
      String response =''+
      '<xml>'+
    '<platform>Siebel</platform>'+
    '<token>1234</token>'+
    '<requesterLogin>SADMIN</requesterLogin>'+
    '<requesterEmpId>0-1</requesterEmpId>'+
    '<requesterName>Siebel Administrator</requesterName>'+
    '<approverLogin>JCGARZA</approverLogin>'+
    '<approverEmpId>Exception</approverEmpId>'+
    '<approverName>JOSE CARLOS GARZA</approverName>'+
    '<approvalObject>Gastos Admin</approvalObject>'+
    '<approvalRequestedDate>12/05/2014 16:59:07</approvalRequestedDate>'+
    '<approvalName>1-31282637</approvalName>'+
    '<approvalId>1-INIUW</approvalId>'+
    '<approvalType>Secuencial</approvalType>'+
    '<approvalLevel>Fraccionamiento</approvalLevel>'+
    '<approvalLevelValue>VALLE DEL ROBLE</approvalLevelValue>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXML(reader);
    } 
    
}