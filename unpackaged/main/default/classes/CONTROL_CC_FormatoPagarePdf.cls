public with sharing class CONTROL_CC_FormatoPagarePdf {
    
    public Id RecordId {get;set;}
    public string compania {get; set;}
    public double cantidad {get; set;}
    public string cantidadl {get; set;}
    public string domicilio {get; set;}
    public string telefono {get; set;}
    public string day {get; set;}
    public string month {get; set;}
    public string year {get; set;}
    public string suscriptor {get; set;}
    public string domicilioS {get; set;}
    public string telefonoS1 {get; set;}
    public string telefonoS2 {get; set;}
    public string telefonoS3 {get; set;}
    public string aval {get; set;}
    public string domicilioA {get; set;}
    public string telefonoA1 {get; set;}
    public string telefonoA2 {get; set;}
    public string telefonoA3 {get; set;}
    public string usuario {get; set;}
    public list<CONTROL_FormatoPagarePreventaPdfAux> aux {get; set;}
    public double total {get; set;}
    
    public CONTROL_CC_FormatoPagarePdf(ApexPages.StandardController controller) {
        RecordId  = ApexPages.currentPage().getParameters().get('id');
        Cobranza_Comercial__c cc = [Select Id, name, Valor_Operacion__c, Nombre_del_Cliente__c, Proceso_Venta__c, Compania_Javer__c From cobranza_comercial__c  Where Id = :RecordId Limit 1];
        
        cantidad = cc.Valor_Operacion__c;
        cantidadL = Numero_a_Letra.convertir(cc.Valor_Operacion__c);
        fecha();
        suscriptor = String.ValueOf(cc.Nombre_del_Cliente__c);
     /*   domicilioS = String.ValueOf(cc.Proceso_Venta__r.AccountId.BillingAddress);
        telefonoS1 = String.ValueOf(cc.Proceso_Venta__r.AccountId.Phone);
        telefonoS2 = String.ValueOf(cc.Proceso_Venta__r.AccountId.TelefonoCelular__c);
        telefonoS3 = String.ValueOf(cc.Proceso_Venta__r.AccountId.Otro_Telefono__c);
        aval = cc.Aval__c;
        domicilioA = cc.Domicilio_Aval__c;
        telefonoA1 = String.ValueOf(cc.Telefono_Celular_Aval__c);
        telefonoA2 = String.ValueOf(cc.Telefono_Casa_Aval__c);
        telefonoA3 = String.ValueOf(cc.Telefono_Otro_Aval__c);
        usuario = UserInfo.getName(); */

        List<Documento__c> dpp = [Select Id, Name, Cobranza_Comercial__c, Importe__c, Fecha_Vencimiento__c From Documento__c Where cobranza_comercial__c = :RecordId];
        aux = new list<CONTROL_FormatoPagarePreventaPdfAux>();
        For(Documento__c doc : dpp){
            aux.add(new CONTROL_FormatoPagarePreventaPdfAux(doc.Name, doc.Importe__c, (doc.Fecha_Vencimiento__c.format())));
        }
        total = cc.Diferencia_a_Pagar__c;

    }

    public void fecha(){
        Date d =date.today();
        day = ' ' + String.valueOf(d.day());
        Integer monthI = Integer.valueOf(d.month());
        switch on monthI {
            when 1 {
                month = ' Enero';
            }  
            when 2 {
                month = ' Febrero';
            }
            when 3 {
                month = ' Marzo';
            }
            when 4 {
                month = ' Abril';
            }
            when 5 {
                month = ' Mayo';
            }
            when 6 {
                month = ' Junio';
            }
            when 7 {
                month = ' Julio';
            }
            when 8 {
                month = ' Agosto';
            }
            when 9 {
                month = ' Septiembre';
            }
            when 10 {
                month = ' Octubre';
            }
            when 11 {
                month = ' Noviembre';
            }
            when else {
                month = ' Diciembre';
            }
        }
        year = ' ' + String.valueOf(d.year());
    }
}