public with sharing class CONTROL_PlanPagosCobranzaComercial {
    
    public Cobranza_Comercial__c cobranzaComercial {get; set;}

    public CONTROL_PlanPagosCobranzaComercial(ApexPages.StandardController stdController) {

        Id idCobranzaComercial = stdController.getId();
        cobranzaComercial = [SELECT Id FROM Cobranza_Comercial__c WHERE Id =: idCobranzaComercial];
    }

    //Metodo para cancelar la creacion de plan de pagos
    public PageReference cancelar(){

        PageReference pg = new PageReference('/' + cobranzaComercial.Id);
        pg.setRedirect(true);
        return pg;
    }
}