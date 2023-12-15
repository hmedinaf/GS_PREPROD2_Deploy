public with sharing class CONTROL_AvisoPrivacidadPdf {
    
    public string compania {get; set;}
    public string domicilio {get; set;}

    public CONTROL_AvisoPrivacidadPdf(ApexPages.StandardController controller) {
        Plan_de_Venta__c pVAux = (Plan_de_Venta__c)controller.getRecord();
        Plan_de_Venta__c pv = [Select Id, Ubicacion_Compania__c From Plan_de_Venta__c Where Id = : pVAux.Id Limit 1];
        Ubicacion__c[] u = [Select Id, Nombre_de_la_Compania__c, Direccion_Fisica__c From Ubicacion__c Where Id = :pv.Ubicacion_Compania__c Limit 1];
        if(u.size() == 0){
            compania = ' N/A';
            domicilio = ' N/A';
        }
        else{
            compania = ' ' + u[0].Nombre_de_la_Compania__c;
            domicilio = ' ' + u[0].Direccion_Fisica__c;
        }   
    }
}