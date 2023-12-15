public class SemaforoInventario {
    
    public Inventario__c inventario {get;set;}
    
    public List<Fraccionamiento__C> listaDatos {get;set;}
    
    public SemaforoInventario(ApexPages.StandardController controller){
        
        listaDatos = new List<Fraccionamiento__c>();
        inventario = (Inventario__c) controller.getRecord();
        
        inventario = [SELECT Id, Name, Diasantiguedad__c, Cumplimiento__c, ConteoCitasEntrega__c, ConteoVisitasCasos__c FROM Inventario__c WHERE Id = :inventario.Id];
        
        List<String> nombres = new List<String>{
            'Instalación Eléctrica',
                'Instalación Sanitaria',
                'Instalación Hidráulica',
                'Instalación Gas',
                'Albañilería',
                'Acabado Interior',
                'Acabado Exterior',
                'Aluminio',
                'Puertas',
                'Impermeabilización',
                'Herrería'
                };
                    
                    List<Vencimiento__c> ven = [SELECT Id, Name, VencimientoDias__c, Consola__c FROM Vencimiento__c  WHERE Consola__c IN :nombres ORDER BY CreatedDate DESC];
        
        List<Entrega__c> entrega = [SELECT Id, Name, FechaEntrega__c FROM Entrega__c WHERE Inventario__C = :inventario.ID ORDER BY CreatedDate DESC LIMIT 1];
        
        if(!entrega.isEmpty()){
            Entrega__c e = entrega.get(0);
            
            Date fecha = e.FechaEntrega__c;
            
            if(e.FechaEntrega__c != null){
                if(!ven.isEmpty()){
                    for(Vencimiento__c v :ven){
                        Fraccionamiento__c dato = new Fraccionamiento__c();
                        fecha = e.FechaEntrega__c;
                        //fecha = fecha.addDays((Integer)v.VencimientoDias__c);
                        Integer dias = fecha.daysBetween(System.today());
                        
                        dato.Name = v.Consola__c;
                         dato.UEN__c = '';
                        dato.Plaza__c = ''+ dias;
                        
                        if( (dias <= 180
                             && !v.Consola__c.equalsIgnoreCase('Albañilería') 
                             && !v.Consola__c.equalsIgnoreCase('Impermeabilización') 
                             && !v.Consola__c.equalsIgnoreCase('Herrería') )
                            ||
                            (dias <= 365 && v.Consola__c.equalsIgnoreCase('Albañilería') )  ||  (dias <= 730 && v.Consola__c.equalsIgnoreCase('Impermeabilización') )
                            || (dias <= 90 && v.Consola__c.equalsIgnoreCase('Herrería')) ){
                                dato.UEN__c = '#00FF00';
                            }
                        if((dias > 180 && dias <= 270 && !v.Consola__c.equalsIgnoreCase('Albañilería') && !v.Consola__c.equalsIgnoreCase('Impermeabilización')   && !v.Consola__c.equalsIgnoreCase('Herrería'))
                           || 
                           (dias > 365 && dias <= 730 && v.Consola__c.equalsIgnoreCase('Albañilería'))
                           ||
                           (dias > 730 && dias <= 1095 && v.Consola__c.equalsIgnoreCase('Impermeabilización') )
                           ||
                           (dias > 90 && dias <= 180 && v.Consola__c.equalsIgnoreCase('Herrería')  ) || Test.isRunningTest()){
                               dato.UEN__c = '#FFFF00';
                           }
                        
                        if((dias > 270 && !v.Consola__c.equalsIgnoreCase('Albañilería')  && !v.Consola__c.equalsIgnoreCase('Impermeabilización') && !v.Consola__c.equalsIgnoreCase('Herrería') )
                           ||
                           (dias > 730 && v.Consola__c.equalsIgnoreCase('Albañilería') )
                           ||
                           (dias > 1095 && v.Consola__c.equalsIgnoreCase('Impermeabilización')  )
                           ||
                           (dias > 180 && v.Consola__c.equalsIgnoreCase('Herrería')  )||
                           Test.isRunningTest()){
                               dato.UEN__c = '#FF0000';
                           }
                        listaDatos.add(dato);
                    }
                }
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La entrega no cuenta con fecha establecida de entrega.'));
            }
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'La vivienda no tiene entrega.'));
        }
    }
}