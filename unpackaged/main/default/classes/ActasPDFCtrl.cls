public class ActasPDFCtrl {
	public Ecotecnologia__c ECO {get;set;}
    public String ActaName {get;set;}
    public ActasPDFCtrl(){
        ActaName = Apexpages.currentPage().getParameters().get('ActaName');
        try{
            ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                   CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                   FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                   Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                   PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                   InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                   ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                   FROM Ecotecnologia__c WHERE Name =: ActaName LIMIT 1];
        }catch(Exception e){
            ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                   CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                   FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                   Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                   PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                   InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                   ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                   FROM Ecotecnologia__c WHERE Name =: 'default' LIMIT 1];
        }
        if(UserInfo.getUiTheme() == 'Theme4t'){
            Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + ActaName + '.pdf');
        }else{
        }
    }
}