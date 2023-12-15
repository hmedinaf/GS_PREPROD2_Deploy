public class PlanPagosCobranzaComercial2 {
    public Boolean showModal { get; set; }
    public String recordId { get; set; }
    public Integer plazo { get; set; }
    public String frecuencia { get; set; }
    public Date inicio { get; set; }
    public Double diferenciaPagar { get; set; }
    
    public Cobranza_Comercial__c cobranzaComercial {get; set;}

    public PlanPagosCobranzaComercial2() {
        showModal = false;
    }

    public PlanPagosCobranzaComercial2(ApexPages.StandardController stdController) {

        Id idCobranzaComercial = stdController.getId();
        recordId = stdController.getId();
        cobranzaComercial = [SELECT Id, Plazo__c, Frecuencia__c, Fecha_Inicio_de_Financiamiento__c, Suma_Total_de_Pagares__c FROM Cobranza_Comercial__c WHERE Id =: idCobranzaComercial];
        plazo = Integer.ValueOf(cobranzaComercial.Plazo__c);
        frecuencia = cobranzaComercial.Frecuencia__c;
        inicio = cobranzaComercial.Fecha_Inicio_de_Financiamiento__c;
        diferenciaPagar = cobranzaComercial.Suma_Total_de_Pagares__c;
    }

    
    public PageReference executeApexClass() {
        // Id idCobranzaComercial = stdController.getId();
        system.debug('**** Este es el cobranzaComercialID: '+recordId);
        // Apex code to be executed

        // Obtener los datos de Cobranza Comercial

        system.debug('*** Ejecutando crear pagarés');
        
        CLASS_PagareFinanciera.creaPagaresFinanciera(recordId, plazo, frecuencia, inicio, diferenciaPagar, true, true);

        //showModal = false;
        PageReference pg = new PageReference('/' + recordId);
        pg.setRedirect(true);
        return pg;
    }

    //Metodo para cancelar la creacion de plan de pagos
    public PageReference cancelar(){

        PageReference pg = new PageReference('/' + cobranzaComercial.Id);
        pg.setRedirect(true);
        return pg;
    }
}