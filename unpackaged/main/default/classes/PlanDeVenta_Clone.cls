public class PlanDeVenta_Clone {
	@AuraEnabled
    public static String clonePDV(String recId){
        try{
            Set<String> SobjectFields = Schema.getGlobalDescribe().get('Plan_de_Venta__c').getDescribe().fields.getMap().keySet();
            List<String> fieldsInList = new List<String>(SobjectFields);
            List<Plan_de_Venta__c> originalRecord = Database.query('SELECT ' + String.join(fieldsInList, ',') + ' FROM Plan_de_Venta__c WHERE Id=:recId');
            List<Producto_de_Plan_de_Venta__c> productosToClone = new List<Producto_de_Plan_de_Venta__c>();
            
            Plan_de_Venta__c clonedRecord = originalRecord[0].clone(false,true,false,false);
            clonedRecord.Tipo__c = 'Reestructura';
            clonedRecord.Plan_de_Venta_Original__c = originalRecord[0].Id;
            clonedRecord.Estatus_Plan_de_venta__c = 'En Progreso'; 
            insert clonedRecord;
            
            for(Producto_de_Plan_de_Venta__c pdv: [SELECT Id,Cantidad__c,Lista_de_Precios__c,Precio_Unitario__c,Producto__c,Producto_de_oportunidad__c,Tipo_de_Producto__c 
                                                   FROM Producto_de_Plan_de_Venta__c WHERE Plan_de_Venta__c =: originalRecord[0].Id])
            {
                Producto_de_Plan_de_Venta__c newPDF = pdv.clone(false,true,false,false);
                newPDF.Plan_de_Venta__c = clonedRecord.Id;
                productosToClone.add(newPDF);
            }
            insert productosToClone;
            
            originalRecord[0].Tipo__c = 'Plan de Venta Cancelado';
            
            update originalRecord[0];
            return clonedRecord.Id;
        }
        catch(Exception e){
            return 'ERROR: '+e.getMessage();
        }
    }
}