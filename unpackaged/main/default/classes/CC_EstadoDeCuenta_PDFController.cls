public class CC_EstadoDeCuenta_PDFController {
    public List<Pago__c> pagoscancelados {get;set;}
    public List<Pago__c> pagoCuenta {get;set;}
    public List<Documento__c> pagares {get;set;}
    public CC_EstadoDeCuenta_PDFController(ApexPages.standardController stdController){
        Id cobranzaComercialId = stdController.getRecord().Id;
          pagares =[SELECT Id,Name,Importe_Aplicado_rollup__c, Tiene_Aplicacion_de_Pagos__c, Documento__c, Tipo_Documento__c, Tipo__c, Fecha_Documento__c, Fecha_Vencimiento__c, Importe_Aplicado__c, Importe__c, Saldo__c, Fecha_de_Pago__c FROM Documento__c where Cobranza_Comercial__c =:cobranzaComercialId];
          pagoscancelados = [SELECT Id, Name, Importe__c, Fecha_de_Pago__c, Fecha_de_Cancelacion__c, Tipo_de_Pago__c, Metodo_Pago__c, Estatus_del_Pago__c FROM Pago__c where Cobranza_Comercial__c =:cobranzaComercialId AND Estatus_del_Pago__c='Cancelado'];
          pagoCuenta = [SELECT Id, Name, Importe__c, Fecha_de_Pago__c, Fecha_de_Cancelacion__c, Tipo_de_Pago__c, Metodo_Pago__c, Estatus_del_Pago__c FROM Pago__c where Cobranza_Comercial__c =:cobranzaComercialId AND Estatus_del_Pago__c !='Cancelado'];
    }
}