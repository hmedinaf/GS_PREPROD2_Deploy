public class CLASS_ProductoPlanVenta {
    public static void ValidaCasaMuestra(List<Producto_de_Plan_de_Venta__c> newList) {
        for (Producto_de_Plan_de_Venta__c pr : newList) {
            List <Plan_de_Venta__c> pdv = [SELECT id, Vivienda_Es_Casa_Muestra__c FROM Plan_de_Venta__c WHERE Id = :pr.Plan_de_Venta__c LIMIT 1];
            if (pdv.size()>0) {
                if (!pdv[0].Vivienda_Es_Casa_Muestra__c && pr.Tipo_de_Producto__c=='Casa Muestra'){
                    system.debug('**** No se permite agregar Casa Muestra con flag Casa Muestra');
                    pr.addError('No se puede agregar un Producto Casa Muestra porque la Vivienda esta marcada como Casa Muestra');
                }
            }
        }
    }
}