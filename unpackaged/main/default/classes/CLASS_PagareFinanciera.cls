public with sharing class CLASS_PagareFinanciera {

    public static void creaPagaresFinanciera(String idCobranzaComercial, Integer plazo, String frecuencia, 
        Date inicio, Decimal diferenciaPagar, Boolean primerPagareFinanciera, Boolean primerPagareFinancieraManual) {

        Id pagareRT = SObjectType.Documento__c.getRecordTypeInfosByDeveloperName().get('Pagare').getRecordTypeId();
        system.debug('*** pagare RT '+pagareRT);

        List<Documento__c> pagaresFinancieraNuevos = new List<Documento__c>();

        Integer aux = 1;
        Double pagar = (diferenciaPagar/plazo);
        if(primerPagareFinanciera == true || primerPagareFinancieraManual == true){

            if(frecuencia == 'Semanal'){
                inicio = inicio.addDays(7);
            }
            else if(frecuencia == 'Quincenal'){
                inicio = inicio.addDays(15);
                aux = 0;
            }
            else if(frecuencia == 'Mensual'){
                inicio = inicio.addMonths(1);
            }
        }        
        
        for(Integer j=0; j<plazo; j++){
            Documento__c pagareFinancieraNuevo = new Documento__c();
            pagareFinancieraNuevo.Cobranza_Comercial__c = idCobranzaComercial;
            pagareFinancieraNuevo.Tipo__c = 'PAGARE_FINANCIERA';
            pagareFinancieraNuevo.RecordTypeId = pagareRT;
            pagareFinancieraNuevo.Estatus__c = 'ABIERTO';
            pagareFinancieraNuevo.Valor_de_la_Operaci_n__c = false; //??

                
            if(frecuencia == 'Semanal'){
                pagareFinancieraNuevo.Fecha_Vencimiento__c = inicio;
                pagareFinancieraNuevo.Importe__c = pagar;
                inicio = inicio.addDays(7);
            }
            else if(frecuencia == 'Quincenal'){
                pagareFinancieraNuevo.Importe__c = pagar;
                if(aux == 1){
                    pagareFinancieraNuevo.Fecha_Vencimiento__c = inicio;
                    aux = 0;
                }else{
                    pagareFinancieraNuevo.Fecha_Vencimiento__c = inicio.addDays(15);
                    aux = 1;
                    inicio = inicio.addMonths(1);
                }
            }
            else if(frecuencia == 'Mensual'){
                pagareFinancieraNuevo.Fecha_Vencimiento__c = inicio;
                pagareFinancieraNuevo.Importe__c = pagar;
                inicio = inicio.addMonths(1);
            }
            pagaresFinancieraNuevos.add(pagareFinancieraNuevo);
        }

        insert pagaresFinancieraNuevos;
        // return pagaresPreventaNuevos;


    }
}