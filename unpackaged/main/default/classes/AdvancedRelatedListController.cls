public class AdvancedRelatedListController {
    
    @AuraEnabled
    public static ReturnWrapper fetchRecords(String parentRecordId, String sObjectName, String fieldsList, String isEdit) {
        ReturnWrapper result = new ReturnWrapper();
        List<FieldWrapper> fieldsWP = new List<FieldWrapper>();
        try {
            Set<String> fields = new Set<String>(fieldsList.split(','));
            Schema.SObjectType objectName = Schema.getGlobalDescribe().get(sObjectName);
            Map<String,Schema.SObjectField> sObjectFieldMap = objectName.getDescribe().fields.getMap();
            
            if(objectName == null) {
                throw new MyException('Object API Name is Not Valid');
            }
            Boolean childObjectFlag = false;
            String relationshipName = '';
            for(Schema.ChildRelationship f : Id.valueof(parentRecordId).getSobjectType().getDescribe().getChildRelationships()) {
                if(String.valueof(f.getChildSObject()).toLowerCase() == sObjectName.toLowerCase()) {
                    childObjectFlag = true;
                    relationshipName = String.valueof(f.getField());
                }
            }
            
            if(!childObjectFlag)
                throw new MyException('Object you selected is not a child object of this record. Object Name : ' + sObjectName);
            
            Set<String> validFields = new Set<String>();
            for(String field : fields) {
                if(String.isNotBlank(field)) {
                    if(!sObjectFieldMap.keySet().contains(field.trim().toLowerCase())) {
                        throw new MyException('Fields API Name is Not Valid. Field : ' + field.trim());
                    }
                    Schema.DescribeFieldResult fieldDesc = sObjectFieldMap.get(field.trim().toLowerCase()).getDescribe();
                    if(String.valueof(fieldDesc.getType()) == 'LOCATION') {
                        throw new MyException('Geo Location Fields are not supported : Field ' + field.trim());
                    }
                    if(String.valueof(fieldDesc.getType()) == 'PICKLIST') {
                        if(fieldDesc.getName() == 'Tipo_Documento__c' || fieldDesc.getName() == 'Tipo_Pagare__c' || fieldDesc.getName() == 'Estatus_Pagare__c'){
                            fieldsWP.add(new FieldWrapper(fieldDesc.getLabel(), fieldDesc.getName(), String.valueof(fieldDesc.getType()), apexTypetoJSType.get(String.valueof(fieldDesc.getType())), false, getPicklistValues(sObjectName, fieldDesc.getName())));
                        }
                        else{
                            fieldsWP.add(new FieldWrapper(fieldDesc.getLabel(), fieldDesc.getName(), String.valueof(fieldDesc.getType()), apexTypetoJSType.get(String.valueof(fieldDesc.getType())), fieldDesc.isUpdateable(), getPicklistValues(sObjectName, fieldDesc.getName())));
                        }
                    } else {
                        if(fieldDesc.getName() == 'Tipo_Documento__c' || fieldDesc.getName() == 'Tipo_Pagare__c' || fieldDesc.getName() == 'Estatus_Pagare__c'){
                            fieldsWP.add(new FieldWrapper(fieldDesc.getLabel(), fieldDesc.getName(), String.valueof(fieldDesc.getType()), apexTypetoJSType.get(String.valueof(fieldDesc.getType())), false, null));
                        }
                        else{
                            fieldsWP.add(new FieldWrapper(fieldDesc.getLabel(), fieldDesc.getName(), String.valueof(fieldDesc.getType()), apexTypetoJSType.get(String.valueof(fieldDesc.getType())), fieldDesc.isUpdateable(), null));
                        }
                    }
                    validFields.add(field);
                }
            }
            
            String query = 'SELECT ' + String.join(new List<String>(validFields), ',');
            if(!validFields.contains('id')) {
                query += ', id';
            }
            
            if(String.valueOf(objectName) == 'Pagare_Preventa__c'){
                query += ' FROM ' + objectName + ' WHERE '+ relationshipName + ' = \'' + parentRecordId + '\' ORDER BY Fecha_de_Vencimiento__c LIMIT 49999';
            }
            else{
                query += ' FROM ' + objectName + ' WHERE '+ relationshipName + ' = \'' + parentRecordId + '\' ORDER BY CreatedDate LIMIT 49999';
            }
            
            result.fieldsList = fieldsWP;
            result.recordList = Database.query(query);
            
            return result;
        } catch (Exception err) {
            throw new AuraHandledException(err.getMessage());
        }
    }
    
    private static List<PicklistOptions> getPicklistValues(String objectName, String fieldName) {
        List<PicklistOptions> picklistValues = new List<PicklistOptions>();
        List<Schema.PicklistEntry> ple = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().get(fieldName).getDescribe().getPicklistValues();
        for(Schema.PicklistEntry pkValue : ple) {
            picklistValues.add( new PicklistOptions(pkValue.getLabel(), pkValue.getValue()) );
        }
        return picklistValues;
    }
    
    @AuraEnabled
    public static String saveRecord(String objectName, String recordData, String recordDataOriginal) {
        try {
            Map<String, Object> fieldMap = (Map<String, Object>)JSON.deserializeUntyped(recordData);
            Map<String, Object> fieldMapOriginal = (Map<String, Object>)JSON.deserializeUntyped(recordDataOriginal);
            System.debug('*****fieldMap:' + fieldMap);
            System.debug('*****fieldMapOriginal:' + fieldMapOriginal);
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectName);
            SObject newSobject = targetType.newSObject();
            for (String key : fieldMap.keySet()) {
                Object value = fieldMap.get(key);
                
                Schema.DisplayType valueType = targetType.getDescribe().fields.getMap().get(key).getDescribe().getType();
                if (value instanceof String && valueType != Schema.DisplayType.String) {
                    String svalue = (String)value;
                    if (valueType == Schema.DisplayType.Date)
                        newSobject.put(key, Date.valueOf(svalue));
                    else if(valueType == Schema.DisplayType.DateTime)
                        newSobject.put(key, DateTime.valueOf(svalue));
                    else if (valueType == Schema.DisplayType.Percent || valueType == Schema.DisplayType.Currency)
                        newSobject.put(key, svalue == '' ? null : Decimal.valueOf(svalue));
                    else if (valueType == Schema.DisplayType.Double)
                        newSobject.put(key, svalue == '' ? null : Double.valueOf(svalue));
                    else if (valueType == Schema.DisplayType.Integer)
                        newSobject.put(key, Integer.valueOf(svalue));
                    else if (valueType == Schema.DisplayType.Base64)
                        newSobject.put(key, Blob.valueOf(svalue));
                    else if (valueType == Schema.DisplayType.Time)
                        newSobject.put(key, Time.newInstance(Integer.valueOf(svalue.split(':')[0]), Integer.valueOf(svalue.split(':')[1]), 00, 00));
                    else
                        newSobject.put(key, svalue);
                }
                else
                    newSobject.put(key, value);
                
                if(objectName == 'Pagare_Preventa__c'){
                    if(key == 'Fecha_de_Vencimiento__c' && value != fieldMapOriginal.get(key)){
                        newSobject.put('Modificado_Manualmente_Fecha_Vencimiento__c', true);
                    }
                    if(key == 'Importe__c' && value != fieldMapOriginal.get(key)){
                        newSobject.put('Modificado_Manualmente_Importe__c', true);
                    }
                }
            }
            
            if(objectName == 'Pagare_Preventa__c'){
                newSobject.put('Modificado_Manualmente__c', true);
            }
            
            update newSobject;
            return 'success';
        } catch(Exception err) {
            throw new AuraHandledException(err.getMessage());
        }
    }
    
    @AuraEnabled
    public static Boolean enableCreateRecordStages(String recordId){
        Plan_de_Venta__c planVenta = [SELECT ID, Oportunidad__r.StageName, Estatus_Plan_de_venta__c FROM Plan_de_Venta__c WHERE Id =: recordId];
        if(planVenta.Oportunidad__r.StageName == 'Reservado' || planVenta.Estatus_Plan_de_venta__c == 'En Progreso' || planVenta.Estatus_Plan_de_venta__c == 'En Progreso'){
            return true;
        }
        else{
            return false;
        }
    }
    
    @AuraEnabled
    public static Boolean enableCreateRecordAmounts(String recordId){
        
        Plan_de_Venta__c planVenta = [SELECT ID, Diferencia_a_Pagar__c FROM Plan_de_Venta__c WHERE Id =: recordId];
        
        AggregateResult[] resultado = [SELECT SUM(Importe__c) SumaImportes FROM Pagare_Preventa__c WHERE Plan_de_Venta__c =: recordId];
        Decimal sumaImportes = (Decimal) resultado[0].get('SumaImportes');
        
        System.debug('*****planVenta.Diferencia_a_Pagar__c:' + planVenta.Diferencia_a_Pagar__c);
        System.debug('*****sumaImportes:' + sumaImportes);
        if(planVenta.Diferencia_a_Pagar__c == sumaImportes){
            return false;
        }
        else{
            return true;
        }
    }
    
    @AuraEnabled
    public static Boolean enableDeleteRecords(String recordId){
        
        Plan_de_Venta__c planVenta = [SELECT ID, Oportunidad__r.StageName, Estatus_Plan_de_venta__c FROM Plan_de_Venta__c WHERE Id =: recordId];
        
        System.debug('*****planVenta.Oportunidad__r.StageName:' + planVenta.Oportunidad__r.StageName);
        System.debug('*****planVenta.Estatus_Plan_de_venta__c:' + planVenta.Estatus_Plan_de_venta__c);
        if(planVenta.Oportunidad__r.StageName == 'Reservado' || planVenta.Estatus_Plan_de_venta__c == 'En Progreso' || planVenta.Estatus_Plan_de_venta__c == 'En Progreso'){
            return true;
        }
        else{
            return false;
        }
    }
    
    @AuraEnabled
    public static Boolean enableUpdateRecord(String recordId){
        
        Plan_de_Venta__c planVenta = [SELECT ID, Oportunidad__r.StageName, Estatus_Plan_de_venta__c FROM Plan_de_Venta__c WHERE Id =: recordId];
        
        System.debug('*****planVenta.Oportunidad__r.StageName:' + planVenta.Oportunidad__r.StageName);
        System.debug('*****planVenta.Estatus_Plan_de_venta__c:' + planVenta.Estatus_Plan_de_venta__c);
        if(planVenta.Oportunidad__r.StageName == 'Reservado' || planVenta.Estatus_Plan_de_venta__c == 'En Progreso' || planVenta.Estatus_Plan_de_venta__c == 'En Progreso'){
            return true;
        }
        else{
            return false;
        }
    }
    
    @AuraEnabled
    public static String deleteRecords(String objectName, String recordId) {
        
        try {
            System.debug('*****deleteAllRecords');
            System.debug('*****objectName:' + objectName);
            System.debug('*****recordId:' + recordId);
            
            Id realRecordId = Id.valueOf(recordId);
            String parentObjectName = realRecordId.getSObjectType().getDescribe().getName();
            System.debug('*****parentObjectName:' + parentObjectName);
            
            String query = 'SELECT Id FROM ' + objectName + ' WHERE ' + parentObjectName +' = \'' + recordId + '\'';
            System.debug('*****query:' + query);
            
            List<sObject> sobjList = Database.query(query);
            System.debug('*****sobjList:' + sobjList);
            
            delete sobjList;
            
            if(objectName == 'Pagare_Preventa__c'){
                
                Plan_de_Venta__c planVenta = [SELECT Id, Plazo__c, Frecuencia__c, Fecha_de_Vencimiento__c, Modificacion_Automatica__c, Primer_Pagare_Preventa_Manual__c FROM Plan_de_Venta__c WHERE Id =: recordId];
                planVenta.Plazo__c = null;
                planVenta.Frecuencia__c = null;
                planVenta.Fecha_de_Vencimiento__c = null;
                planVenta.Primer_Pagare_Preventa_Manual__c = false;
                planVenta.Modificacion_Automatica__c = (String.isBlank(String.valueOf(planVenta.Modificacion_Automatica__c)) ? 1 : planVenta.Modificacion_Automatica__c + 1);
                update planVenta;
            }
            return 'success';
            
        } catch(Exception err) {
            throw new AuraHandledException(err.getMessage());
        }
    }
    
    @AuraEnabled
    public static String deleteRecord(String objectName, String recordId, String recordParentId) {
        
        try {
            System.debug('*****deleteRecord');
            System.debug('*****objectName:' + objectName);
            System.debug('*****recordId:' + recordId);
            
            if(objectName == 'Pagare_Preventa__c'){
                
                Pagare_Preventa__c pagarePreventa =  [SELECT Id, Importe__c, Eliminado_Manualmente__c FROM Pagare_Preventa__c WHERE Id =: recordId];
                pagarePreventa.Eliminado_Manualmente__c = true;
                update pagarePreventa;                
                
                Plan_de_Venta__c planVenta = [SELECT Id, Plazo__c, Anticipo__c, Modificacion_Automatica__c FROM Plan_de_Venta__c WHERE Id =: recordParentId];
                planVenta.Plazo__c = planVenta.Plazo__c - 1;
                planVenta.Anticipo__c = planVenta.Anticipo__c - pagarePreventa.Importe__c;
                planVenta.Modificacion_Automatica__c = (String.isBlank(String.valueOf(planVenta.Modificacion_Automatica__c)) ? 1 : planVenta.Modificacion_Automatica__c + 1);
                
                update planVenta;
                delete pagarePreventa;                
            }
            else{
                
                String query = 'SELECT Id FROM ' + objectName + ' WHERE Id = \'' + recordId + '\'';
                System.debug('*****query:' + query);
                
                List<sObject> sobjList = Database.query(query);
                System.debug('*****sobjList:' + sobjList);
                
                delete sobjList;
            }
            return 'success';
            
        } catch(Exception err) {
            throw new AuraHandledException(err.getMessage());
        }
    }
    
    public static Map<String, String> apexTypetoJSType = new Map<String, String> {
        'ID' => 'id',
            'PHONE' => 'tel',
            'URL' => 'url',
            'EMAIL' => 'email',
            'ADDRESS' => 'text',
            'TEXTAREA' => 'text',
            'STRING' => 'text',
            'REFERENCE' => 'text',
            'MULTIPICKLIST' => 'text',
            'PICKLIST' => 'picklist',
            'BOOLEAN' => 'checkbox',
            'DATE' => 'date',
            'DATETIME' => 'datetime',
            'TIME' => 'time',
            'DOUBLE' => 'number',
            'INTEGER' => 'number',
            'CURRENCY' => 'currency',
            'PERCENT' => 'number'
            };
                
                public class ReturnWrapper {
                    @AuraEnabled public List<sObject> recordList;
                    @AuraEnabled public List<FieldWrapper> fieldsList;
                }
    
    public class FieldWrapper {
        @AuraEnabled public String label;
        @AuraEnabled public String value;
        @AuraEnabled public String dataType;
        @AuraEnabled public String ltngType;
        @AuraEnabled public Boolean isEditable;
        @AuraEnabled public List<PicklistOptions> picklistValues;
        public FieldWrapper(String label, String value, String dataType, String ltngType, Boolean isEditable, List<PicklistOptions> picklistValues) {
            this.label = label;
            this.value = value;
            this.dataType = dataType;
            this.ltngType = ltngType;
            this.isEditable = isEditable;
            this.picklistValues = picklistValues;
        }
    }
    
    public class PicklistOptions {
        @AuraEnabled public String label;
        @AuraEnabled public String value;
        public PicklistOptions(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }
    
    public class PagaresPreventaOriginales{
        @AuraEnabled public Map<Id,Pagare_Preventa__c> pagaresPreventaOriginales = new Map<Id,Pagare_Preventa__c>();
    }
}

/*
Code by CafeForce.com | support@cafeforce.com
DO NOT REMOVE THIS FOOTER FOR FREE CODE USAGE 
*/