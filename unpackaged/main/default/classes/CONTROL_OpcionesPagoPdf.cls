public with sharing class CONTROL_OpcionesPagoPdf {
    
    public Id RecordId {get;set;}
    public string compania {get; set;}
    public string suscriptor {get; set;}
    public string domicilioV {get; set;}
    public string fraccV {get; set;}
    public string manzV {get; set;}
    public string loteV {get; set;}
    public string interiorV {get; set;}
    public string referencia {get; set;}
    public string RFC {get; set;}
    public string convenioEmpresa_Santander {get; set;}
    public string claveRAP_HSBC {get; set;}
    public string clabe_Santander {get; set;}
    public string clabe_HSBC {get; set;}
    public string telefonoCobranza {get; set;}
    public string correoCobranza {get; set;}
    public string cuentaExtranjera {get; set;}
    public string bancoIntermediario {get; set;}

    public CONTROL_OpcionesPagoPdf(ApexPages.StandardController controller) {
        RecordId  = ApexPages.currentPage().getParameters().get('id');
        Plan_de_Venta__c pv = [Select Id, Name, Oportunidad__r.Account.Name, Vivienda__c, Ubicacion_Compania__c, Oportunidad__r.Name From Plan_de_Venta__c Where Id = :RecordId Limit 1];
        Vivienda__c [] v = [Select Id, Direccion__c, Manzana__c, Lote__c, Num_Interior__c, Fraccionamiento__r.Name From Vivienda__c Where Id = :pv.Vivienda__c Limit 1];
        Ubicacion__c[] u = [Select Id, Nombre_de_la_Compania__c, Direccion_Fisica__c, Telefono__c, Telefono_Cobranza__c, Email_Cobranza__c, RFC__c, Convenio_Empresa__c, CLABE_Santander__c, CLABE_HSBC__c, Clave_RAP_HSBC__c, Banco_Intermediario__c, Cuenta_Extranjera__c From Ubicacion__c Where Id = :pv.Ubicacion_Compania__c Limit 1];
        suscriptor = pv.Oportunidad__r.Account.Name;
        // referencia = ReferenciaDePago.generarReferencia(pv.Name);
        String numPlanVenta = pv.Oportunidad__r.Name; //.substring(2,12);
        system.debug('*** numPlanVenta: '+numPlanVenta);
        // String digito = CLASS_Oportunidad.CalculaDigitoVerificador(numPlanVenta);
        referencia = CLASS_Oportunidad.CalculaDigitoVerificador(numPlanVenta); //pv.Oportunidad__r.Name+'-'+digito;

        if(v.size() == 0){
            domicilioV = ' N/A';
            fraccV = ' N/A';
            manzV = ' N/A';
            loteV = ' N/A';
            interiorV = ' N/A';
        }
        else{
            domicilioV = ' ' + v[0].Direccion__c;
            fraccV = ' ' + v[0].Fraccionamiento__r.Name;
            manzV = ' ' + v[0].Manzana__c;
            loteV = ' ' + v[0].Lote__c;
            interiorV = ' ' + v[0].Num_Interior__c;
        }
        if(u.size() == 0){
            compania = ' N/A';
            RFC = ' N/A';
            convenioEmpresa_Santander = ' N/A';
            claveRAP_HSBC = ' N/A';
            clabe_Santander = ' N/A';
            clabe_HSBC = ' N/A';
            telefonoCobranza = ' N/A';
            correoCobranza = ' N/A';
            bancoIntermediario = ' N/A';
            cuentaExtranjera = ' N/A';
        }
        else{
            compania = ' ' + u[0].Nombre_de_la_Compania__c;
            RFC = ' RFC: ' + u[0].RFC__c;
            convenioEmpresa_Santander = ' ' + u[0].Convenio_Empresa__c;
            claveRAP_HSBC = ' ' + u[0].Clave_RAP_HSBC__c;
            clabe_Santander = ' ' + u[0].CLABE_Santander__c;
            clabe_HSBC = ' ' + u[0].CLABE_HSBC__c;
            telefonoCobranza = ' ' + u[0].Telefono_Cobranza__c;
            correoCobranza = ' ' + u[0].Email_Cobranza__c;
            bancoIntermediario = ' ' + u[0].Banco_Intermediario__c;
            cuentaExtranjera = ' ' + u[0].Cuenta_Extranjera__c;
        }
    }
}