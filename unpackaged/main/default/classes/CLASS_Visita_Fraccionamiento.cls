public with sharing class CLASS_Visita_Fraccionamiento {
    
    //Metodo que asigna valores a la visita al momento de la creacion
    public void asignaValoresAutomaticos(List<Visita_Fraccionamiento__c> visitasNuevas){

        List<Visita_Fraccionamiento__c> visitasNuevasNoAutomaticas = new List<Visita_Fraccionamiento__c>();
        for(Visita_Fraccionamiento__c visitaNueva : visitasNuevas){

            if(visitaNueva.Automatica__c == false){
                visitasNuevasNoAutomaticas.add(visitaNueva);
            }
        }

        if(visitasNuevasNoAutomaticas.size() > 0){

            String nombrePerfilUsuario = [SELECT Profile.Name FROM User WHERE Id =: Userinfo.getUserId()].Profile.Name;

            //Se obtienen los ids de la cuentas asociadas a las nuevas visitas
            Set<Id> idsCuentas = new Set<Id>();
            for(Visita_Fraccionamiento__c visitaNueva : visitasNuevas){

                idsCuentas.add(visitaNueva.Cuenta__c);
            }

            //Se obtiene la cantidad de visitas que tienen las cuentas asociadas a las nuevas visitas
            //List<AggregateResult> visitasCuentas = [SELECT Cuenta__c, COUNT(Id) nVisitas FROM Visita_Fraccionamiento__c WHERE Cuenta__c IN : idsCuentas GROUP BY Cuenta__c];
            List<AggregateResult> visitasCuentas = [SELECT Cuenta__c, Fraccionamiento__c, COUNT(Id) nVisitas FROM Visita_Fraccionamiento__c WHERE Cuenta__c IN : idsCuentas GROUP BY Cuenta__c, Fraccionamiento__c];
            Map<String,Integer> idCuentasNumeroVisitas = new Map<String,Integer>();
            for(AggregateResult visitaCuenta : visitasCuentas){
                idCuentasNumeroVisitas.put(String.valueOf(visitaCuenta.get('Cuenta__c')) + String.valueOf(visitaCuenta.get('Fraccionamiento__c')),Integer.valueOf(visitaCuenta.get('nVisitas')));
            }

            //Se obtienen los datos de las cuentas asociadas a las nuevas visitas
            Map<Id,Account> cuentas = new Map<Id,Account>([SELECT Id, Fecha_de_Afluencia__c, RecordType.DeveloperName, Fraccionamiento_cta__c FROM Account WHERE Id IN : idsCuentas]);

            //Por cada una de las visitas nuevas
            List<Account> cuentasActualizar = new List<Account>();
            Account cuentaActualizar = new Account();
            String cuentaFraccionamiento = '';  
            for(Visita_Fraccionamiento__c visitaNueva : visitasNuevas){

                cuentaFraccionamiento = String.valueOf(visitaNueva.Cuenta__c) + String.valueOf(cuentas.get(visitaNueva.Cuenta__c).Fraccionamiento_cta__c);

                //Se asigna el numero de visita consecutiva que le corresponde a la nueva visita en base a la cantidad de visitas que ya tiene la cuenta
                //visitaNueva.Numero_Visita__c = (idCuentasNumeroVisitas.containsKey(visitaNueva.Cuenta__c) == false ? 1 : idCuentasNumeroVisitas.get(visitaNueva.Cuenta__c) + 1);
                visitaNueva.Numero_Visita__c = (idCuentasNumeroVisitas.containsKey(cuentaFraccionamiento) == false ? 1 : idCuentasNumeroVisitas.get(cuentaFraccionamiento) + 1);
                visitaNueva.Usuario__c = Userinfo.getUserId();
                visitaNueva.Rol__c = nombrePerfilUsuario;
                visitaNueva.Fraccionamiento__c = cuentas.get(visitaNueva.Cuenta__c).Fraccionamiento_cta__c;
                visitaNueva.Automatica__c = false;

                //Si es la primera visita se pone/agrega el texto definido por negocio
                if(visitaNueva.Numero_Visita__c == 1){

                    visitaNueva.Comentarios__c = (String.isBlank(visitaNueva.Comentarios__c) == true ? 'Primera vez que el cliente visita el fraccionamiento.' : 'Primera vez que el cliente visita el fraccionamiento. ' + visitaNueva.Comentarios__c);
                    cuentaActualizar = cuentas.get(visitaNueva.Cuenta__c);
                    //cuentaActualizar.Fecha_de_Afluencia__c = Date.valueOf(visitaNueva.Fecha_Visita__c);
                    //cuentasActualizar.add(cuentaActualizar);
                }
            }
        }
    }
}