public with sharing class CLASS_PagarePreventa {
    //Metodo que asigna automaticamente el tipo de documento Factura a los pagares preventa creados
    public void asignaTipoDocumento(List<Pagare_Preventa__c> pagaresPreventaNuevos){
        for(Pagare_Preventa__c pagarePreventa : pagaresPreventaNuevos){
            pagarePreventa.Tipo_Documento__c = 'Factura';
            pagarePreventa.Tipo_Pagare__c = 'Pagaré Preventa';
            pagarePreventa.Estatus_Pagare__c = 'NA';
        }
    }
    //Metodo que valida si el Pagare Preventa fue creado manualmente (desde el componente Lightning) para:
    //Crear los nuevos Pagares Preventa originados de dicha creacion manual
    //Actualizar el registro de Plan de Venta correspondiente al Pagare Preventa creado
    public void validaCreacionManual(List<Pagare_Preventa__c> pagaresPreventaNuevos){
        Set<Id> idsPlanesVenta = new Set<Id>();
        Map<Id,Pagare_Preventa__c> planesVentaPagaresPreventa = new Map<Id,Pagare_Preventa__c>();
        for(Pagare_Preventa__c pagarePreventa : pagaresPreventaNuevos){
            if(pagarePreventa.Creado_Manualmente__c == true){
                idsPlanesVenta.add(pagarePreventa.Plan_de_Venta__c);
                planesVentaPagaresPreventa.put(pagarePreventa.Plan_de_Venta__c, pagarePreventa);
            }
        }
        system.debug('idsPlanesVenta'+idsPlanesVenta);
        //Si se crearon pagares preventa de forma manual
        if(idsPlanesVenta.size() > 0){
            List<Plan_de_Venta__c> planesVenta = [SELECT Id, Plazo__c, Frecuencia__c, Fecha_de_Vencimiento__c, Diferencia_a_Pagar__c, Modificacion_Automatica__c, Primer_Pagare_Preventa_Manual__c FROM Plan_de_Venta__c WHERE Id IN: idsPlanesVenta];
            //Se obtienen los pagares de venta existentes creados automaticamente relacionados a los planes de venta
            List<Pagare_Preventa__c> pagaresPreventaExistentesNoManuales = [SELECT Id FROM Pagare_Preventa__c WHERE Plan_de_Venta__c IN: idsPlanesVenta AND Creado_Manualmente__c = false AND Modificado_Manualmente_Fecha_Vencimiento__c = false AND Modificado_Manualmente_Importe__c = false];
            delete pagaresPreventaExistentesNoManuales;
            
            //Se obtienen los pagares de venta existentes creados o modificados manualmente relacionados a los planes de venta
            Map<Id,Integer> planesVentaCantidadPagares = new Map<Id,Integer>();
            Map<Id,Decimal> planesVentaSumaImportes = new Map<Id,Decimal>();
            for(AggregateResult resultado : [SELECT COUNT(Id) nPagaresPreventa, sum(Importe__c) sumaImportes, Plan_de_Venta__c FROM Pagare_Preventa__c WHERE Plan_de_Venta__c IN: idsPlanesVenta AND (Creado_Manualmente__c = true OR Modificado_Manualmente_Fecha_Vencimiento__c = true OR Modificado_Manualmente_Importe__c = true) GROUP BY Plan_de_Venta__c]){
                system.debug('resultado'+resultado);
                planesVentaCantidadPagares.put((Id)resultado.get('Plan_de_Venta__c'), (Integer)resultado.get('nPagaresPreventa'));
                planesVentaSumaImportes.put((Id)resultado.get('Plan_de_Venta__c'), (Decimal)resultado.get('sumaImportes'));
            }
            
            //Por cada uno de los planes de venta en los que se creo un pagare preventa de forma manual se crean nuevos pagares preventa con los datos correspondientes
            List<Pagare_Preventa__c> pagaresPreventaCrear = new List<Pagare_Preventa__c>();
            List<Plan_de_Venta__c> planesVentaActualizar = new List<Plan_de_Venta__c>();
            Integer plazoAux = 0;
            String frecuenciaAux = '';
            Date inicioAux = Date.today();
            Decimal diferenciaPagarAux = 0;
            Boolean primerPagarePreventaAux = false;
            Boolean primerPagarePreventaManualAux = false;
            try {
                for(Plan_de_Venta__c planVenta : planesVenta){
                    
                    plazoAux = Integer.valueOf(planVenta.Plazo__c) - (planesVentaCantidadPagares.containsKey(planVenta.Id) == true ? planesVentaCantidadPagares.get(planVenta.Id) : 0);
                    
                    frecuenciaAux = planVenta.Frecuencia__c;
                    
                    //Si la fecha de vencimiento del pagare preventa creado manualmente es menor a la fecha de vencimiento del plan de venta significa que:
                    //La fecha de vencimiento del plan de venta es la fecha de vencimiento del pagare de venta creado manualmente
                    if(planesVentaPagaresPreventa.get(planVenta.Id).Fecha_de_Vencimiento__c < planVenta.Fecha_de_Vencimiento__c){
                        inicioAux = planesVentaPagaresPreventa.get(planVenta.Id).Fecha_de_Vencimiento__c;  primerPagarePreventaAux = true;    planVenta.Primer_Pagare_Preventa_Manual__c = true;
                    }
                    //Si la fecha de vencimiento del pagare preventa creado manualmente es mayor a la fecha de vencimiento del plan de venta significa que:
                    //La fecha de vencimiento del plan de venta es la fecha de vencimiento del plan de venta
                    else{
                        inicioAux = planVenta.Fecha_de_Vencimiento__c;
                        primerPagarePreventaAux = false;
                    }
                    
                    diferenciaPagarAux = planVenta.Diferencia_a_Pagar__c - planesVentaPagaresPreventa.get(planVenta.Id).Importe__c - (planesVentaSumaImportes.containsKey(planVenta.Id) == true ? planesVentaSumaImportes.get(planVenta.Id) : 0);
                    
                    primerPagarePreventaManualAux = planVenta.Primer_Pagare_Preventa_Manual__c;
                    
                    //Se agregan a una lista cada uno de los pagares preventa creados para despues hacer una sola insercion
                    for(Pagare_Preventa__c pagarePreventaNuevo : creaPagaresPreventa(planVenta.Id, plazoAux, frecuenciaAux, inicioAux, diferenciaPagarAux, primerPagarePreventaAux, primerPagarePreventaManualAux)){
                        pagaresPreventaCrear.add(pagarePreventaNuevo);
                    }
                    
                    //Se asignan los datos de los planes de venta modificados
                    planVenta.Plazo__c = planVenta.Plazo__c + 1;
                    planVenta.Fecha_de_Vencimiento__c = inicioAux;
                    planVenta.Modificacion_Automatica__c = (String.isBlank(String.valueOf(planVenta.Modificacion_Automatica__c)) ? 1 : planVenta.Modificacion_Automatica__c + 1);
                    planesVentaActualizar.add(planVenta);
                }
                
                //Se insertan los nuevos pagares preventa
                insert pagaresPreventaCrear;
                
                //Se actualizan los planes de venta
                update planesVentaActualizar;
            } catch (DmlException e) {
                system.debug('Error: '+e.getMessage());
            }
        } 
    }
    
    //Metodo que valida si el Pagare Preventa fue modificado manualmente (desde el componente Lightning) pero no para eliminar para:
    //Modificar los Pagares Preventa existentes relacionados al Plan de Venta correspondiente al Pagare Preventa modificado
    //Actualizar el registro de Plan de Venta correspondiente al Pagare Preventa modificado
    public void validaModificacionManual(List<Pagare_Preventa__c> pagaresPreventaModificados, Map<Id,Pagare_Preventa__c> pagaresPreventaAnteriores){
        
        Set<Id> idsPlanesVentaModificadosImporte = new Set<Id>();
        Map<Id,Pagare_Preventa__c> planesVentaPagaresPreventaModImporte = new Map<Id,Pagare_Preventa__c>();
        Set<Id> idsPagaresPreventaModImporte = new Set<Id>();
        Set<Id> idsPlanesVentaModificadosFechaVencimiento = new Set<Id>();
        Map<Id,Pagare_Preventa__c> planesVentaPagaresPreventaModFechaVencimiento = new Map<Id,Pagare_Preventa__c>();
        Set<Id> idsPagaresPreventaModFechaVencimiento = new Set<Id>();
        for(Pagare_Preventa__c pagarePreventa : pagaresPreventaModificados){
            
            if(pagarePreventa.Modificado_Manualmente_Importe__c == true && pagarePreventa.Importe__c != pagaresPreventaAnteriores.get(pagarePreventa.Id).Importe__c && pagarePreventa.Eliminado_Manualmente__c == false){
                
                idsPlanesVentaModificadosImporte.add(pagarePreventa.Plan_de_Venta__c);
                planesVentaPagaresPreventaModImporte.put(pagarePreventa.Plan_de_Venta__c, pagarePreventa);
                idsPagaresPreventaModImporte.add(pagarePreventa.Id);                
            }
            
            if(pagarePreventa.Modificado_Manualmente_Fecha_Vencimiento__c == true && pagarePreventa.Fecha_de_Vencimiento__c != pagaresPreventaAnteriores.get(pagarePreventa.Id).Fecha_de_Vencimiento__c && pagarePreventa.Eliminado_Manualmente__c == false){
                
                idsPlanesVentaModificadosFechaVencimiento.add(pagarePreventa.Plan_de_Venta__c);
                planesVentaPagaresPreventaModFechaVencimiento.put(pagarePreventa.Plan_de_Venta__c, pagarePreventa);
                idsPagaresPreventaModFechaVencimiento.add(pagarePreventa.Id);
            }
        }
        
        //Si hubo pagares preventa a los que se le modifico manualmente el importe, se actualizan los montos de los pagares preventa existentes relacionados al plan de venta relacionado al pagare preventa modificado
        if(idsPlanesVentaModificadosImporte.size() > 0){
            
            //Se obtienen los pagares preventa que no han sido modificados manualmente o creados manualmente relacionados a los planes de venta relacionados a los pagares preventa que entraron al 
            //trigger y que fueron manualmente modificados
            System.debug('*****idsPagaresPreventaModImporte:' + idsPagaresPreventaModImporte);
            System.debug('*****idsPlanesVentaModificadosImporte:' + idsPlanesVentaModificadosImporte);
            Map<Id,List<Pagare_Preventa__c>> planVentaPagaresPreventa = new Map<Id,List<Pagare_Preventa__c>>();
            Map<Id,Plan_de_Venta__c> planesVenta = new Map<Id,Plan_de_Venta__c>();
            for(Plan_de_Venta__c planVenta : [SELECT Id, Plazo__c, Diferencia_a_Pagar__c, (SELECT Id, Importe__c FROM Pagares_Preventa__r WHERE Id NOT IN : idsPagaresPreventaModImporte AND (Creado_Manualmente__c = false AND Modificado_Manualmente_Importe__c = false)) FROM Plan_de_Venta__c WHERE Id IN : idsPlanesVentaModificadosImporte]){
                planVentaPagaresPreventa.put(planVenta.Id, planVenta.Pagares_Preventa__r);
                planesVenta.put(planVenta.Id, planVenta);
            }
            
            //Se obtienen los pagares de venta existentes creados o modificados manualmente relacionados a los planes de venta
            Map<Id,Integer> planesVentaCantidadPagares = new Map<Id,Integer>();
            Map<Id,Decimal> planesVentaSumaImportes = new Map<Id,Decimal>();
            for(AggregateResult resultado : [SELECT COUNT(Id) nPagaresPreventa,  sum(Importe__c) sumaImportes, Plan_de_Venta__c FROM Pagare_Preventa__c WHERE Plan_de_Venta__c IN: idsPlanesVentaModificadosImporte AND (Creado_Manualmente__c = true OR Modificado_Manualmente_Importe__c = true) AND Id NOT IN : idsPagaresPreventaModImporte GROUP BY Plan_de_Venta__c]){
                planesVentaCantidadPagares.put((Id)resultado.get('Plan_de_Venta__c'), (Integer)resultado.get('nPagaresPreventa'));
                planesVentaSumaImportes.put((Id)resultado.get('Plan_de_Venta__c'), (Decimal)resultado.get('sumaImportes'));
            }
            
            /*for(AggregateResult resultado : [SELECT sum(Importe__c) sumaImportes, Plan_de_Venta__c FROM Pagare_Preventa__c WHERE Plan_de_Venta__c IN: idsPlanesVentaModificadosImporte AND (Creado_Manualmente__c = true OR Modificado_Manualmente_Importe__c = true) AND Id NOT IN : idsPagaresPreventaModImporte GROUP BY Plan_de_Venta__c]){
planesVentaSumaImportes.put((Id)resultado.get('Plan_de_Venta__c'), (Decimal)resultado.get('sumaImportes'));
}*/
            
            Plan_de_Venta__c planVenta = new Plan_de_Venta__c();
            Decimal diferenciaPagar = 0;
            Integer plazo = 0;
            Decimal monto = 0;
            List<Pagare_Preventa__c> pagaresPreventaActualizar = new List<Pagare_Preventa__c>();
            for(Id idPlanVentaModificadoImporte : idsPlanesVentaModificadosImporte){
                
                planVenta = planesVenta.get(idPlanVentaModificadoImporte);
                plazo = Integer.valueOf(planVenta.Plazo__c) - (planesVentaCantidadPagares.containsKey(idPlanVentaModificadoImporte) == true ? planesVentaCantidadPagares.get(idPlanVentaModificadoImporte) + 1 : 1);
                diferenciaPagar = planVenta.Diferencia_a_Pagar__c - (planesVentaSumaImportes.containsKey(idPlanVentaModificadoImporte) == true ? planesVentaSumaImportes.get(idPlanVentaModificadoImporte) : 0) - planesVentaPagaresPreventaModImporte.get(idPlanVentaModificadoImporte).Importe__c;
                //Si plazo = 0 significa que todos los pagares preventa fueron modificados manualmente
                if(plazo == 0){
                    if(diferenciaPagar > 0){
                        planesVentaPagaresPreventaModImporte.get(idPlanVentaModificadoImporte).addError('Todos los pagarés preventa fueron modificados pero la suma de sus importes no cubren la Diferencia a Pagar');
                    }
                }
                else{
                    
                    monto = diferenciaPagar / plazo;
                    for(Pagare_Preventa__c pagarePreventa : planVentaPagaresPreventa.get(idPlanVentaModificadoImporte)){
                        pagarePreventa.Importe__c = monto;
                        pagaresPreventaActualizar.add(pagarePreventa);
                    }
                }
            }
            if(pagaresPreventaActualizar.size() > 0){
                update pagaresPreventaActualizar;
            }
        }
        //Si hubo pagares preventa a los que se le modifico manualmente la fecha de vencimiento, se actualizan las fechas de vencimiento de los pagares preventa existentes relacionados al plan de venta relacionado al pagare preventa modificado
        if(idsPlanesVentaModificadosFechaVencimiento.size() > 0){
            
            //Se obtienen los pagares preventa con la fecha de vencimiento mas antigua
            Map<Id,Id> planesVentaPagarePreventaAntiguo = new Map<Id,Id>();
            for(AggregateResult resultado : [SELECT MIN(Fecha_de_Vencimiento__c), MIN(Id) idPagarePreventa, Plan_de_Venta__c FROM Pagare_Preventa__c WHERE Plan_de_Venta__c IN : idsPlanesVentaModificadosFechaVencimiento GROUP BY Plan_de_Venta__c]){
                planesVentaPagarePreventaAntiguo.put((Id)resultado.get('Plan_de_Venta__c'), (Id)resultado.get('idPagarePreventa'));
            }
            Set<Id> idsPlanesVentaPagarePreventaInicialModificado = new Set<Id>();
         
            for(Id idPlanVentaModificadoFechaVencimiento : idsPlanesVentaModificadosFechaVencimiento){
                system.debug(planesVentaPagarePreventaAntiguo.get(idPlanVentaModificadoFechaVencimiento) == planesVentaPagaresPreventaModFechaVencimiento.get(idPlanVentaModificadoFechaVencimiento).Id);
                //Si el pagare preventa mas viejo es el pagare preventa al que se le ha modificado manualmente la fecha de vencimiento
                //Se actualiza la fecha de vencimiento a los pagares que no se les ha modificado manualmente la fecha de vencimiento
                if(planesVentaPagarePreventaAntiguo.get(idPlanVentaModificadoFechaVencimiento) == planesVentaPagaresPreventaModFechaVencimiento.get(idPlanVentaModificadoFechaVencimiento).Id){
                    idsPlanesVentaPagarePreventaInicialModificado.add(idPlanVentaModificadoFechaVencimiento);
                }
            }
            //Si hubo pagares preventa a los que se les modifico manualmente la fecha de vencimiento se actualizan los pagares preventa a los que no se les ha actualizado manualmente la fecha de vencimiento
            //relacionados al plan de venta relacionado al pagare preventa modificado manualmente
            if(idsPlanesVentaPagarePreventaInicialModificado.size() > 0){
                
                //Se obtienen los pagares preventa que no han sido modificados manualmente o creados manualmente relacionados a los planes de venta relacionados a los pagares preventa que entraron al 
                //trigger y que fueron manualmente modificados
                Map<Id,List<Pagare_Preventa__c>> planVentaPagaresPreventa = new Map<Id,List<Pagare_Preventa__c>>();  Map<Id,Plan_de_Venta__c> planesVenta = new Map<Id,Plan_de_Venta__c>();
                for(Plan_de_Venta__c planVenta : [SELECT Id, Frecuencia__c, Fecha_de_Vencimiento__c, Modificacion_Automatica__c, (SELECT Id, Fecha_de_Vencimiento__c FROM Pagares_Preventa__r WHERE Id NOT IN : idsPagaresPreventaModFechaVencimiento AND (Creado_Manualmente__c = false AND Modificado_Manualmente_Fecha_Vencimiento__c = false) ORDER BY Fecha_de_Vencimiento__c ASC) FROM Plan_de_Venta__c WHERE Id IN : idsPlanesVentaPagarePreventaInicialModificado]){
                    planVentaPagaresPreventa.put(planVenta.Id, planVenta.Pagares_Preventa__r);  planesVenta.put(planVenta.Id, planVenta);
                }
                
                Plan_de_Venta__c planVenta = new Plan_de_Venta__c();   List<Plan_de_Venta__c> planesVentaActualizar = new List<Plan_de_Venta__c>();   Date inicio = Date.today(); List<Pagare_Preventa__c> pagaresPreventaActualizar = new List<Pagare_Preventa__c>(); Integer aux = 1;
                for(Id idPlanVentaPagarePreventaInicialModificado : idsPlanesVentaPagarePreventaInicialModificado){
                    inicio = planesVentaPagaresPreventaModFechaVencimiento.get(idPlanVentaPagarePreventaInicialModificado).Fecha_de_Vencimiento__c;
                    planVenta = planesVenta.get(idPlanVentaPagarePreventaInicialModificado);  planVenta.Fecha_de_Vencimiento__c = inicio;
                    planVenta.Modificacion_Automatica__c = (String.isBlank(String.valueOf(planVenta.Modificacion_Automatica__c)) ? 1 : planVenta.Modificacion_Automatica__c + 1);
                    planesVentaActualizar.add(planVenta);
                    if(planVenta.Frecuencia__c == 'Semanal'){   inicio = inicio.addDays(7);   }
                    else if(planVenta.Frecuencia__c == 'Quincenal'){     inicio = inicio.addDays(15);aux = 0;      }
                    else if(planVenta.Frecuencia__c == 'Mensual'){
                        inicio = inicio.addMonths(1);
                    }
                    for(Pagare_Preventa__c pagarePreventa : planVentaPagaresPreventa.get(idPlanVentaPagarePreventaInicialModificado)){
                        if(planVenta.Frecuencia__c == 'Semanal'){
                            pagarePreventa.Fecha_de_Vencimiento__c = inicio; inicio = inicio.addDays(7);
                        }
                        else if(planVenta.Frecuencia__c == 'Quincenal'){
                            if(aux == 1){
                                pagarePreventa.Fecha_de_Vencimiento__c = inicio; aux = 0;
                            }else{
                                pagarePreventa.Fecha_de_Vencimiento__c = inicio.addDays(15);   aux = 1;   inicio = inicio.addMonths(1);
                            }  }
                        else if(planVenta.Frecuencia__c == 'Mensual'){
                            pagarePreventa.Fecha_de_Vencimiento__c = inicio; inicio = inicio.addMonths(1);
                        }
                        pagaresPreventaActualizar.add(pagarePreventa);
                    }
                }
                
                if(planesVentaActualizar.size() > 0){
                    update planesVentaActualizar;
                }
                
                if(pagaresPreventaActualizar.size() > 0){
                    update pagaresPreventaActualizar;
                }
            }
        }
    }
    
    //Metodo que valida si el Pagare Preventa fue eliminado manualmente (desde el componente Lightning) para:
    //Modificar los Pagares Preventa existentes relacionados al Plan de Venta correspondiente al Pagare Preventa modificado
    //Actualizar el registro de Plan de Venta correspondiente al Pagare Preventa modificado
    public void validaEliminacionManual(List<Pagare_Preventa__c> pagaresEliminados){
        Set<Id> idsPlanesVentaPagarePreventaEliminado = new Set<Id>();
        Map<Id,Pagare_Preventa__c> planesVentaPagaresPreventaEliminados = new Map<Id,Pagare_Preventa__c>();
        Set<Id> idsPagaresPreventaEliminados = new Set<Id>();
        for(Pagare_Preventa__c pagarePreventa : pagaresEliminados){
            if(pagarePreventa.Eliminado_Manualmente__c == true){
                idsPlanesVentaPagarePreventaEliminado.add(pagarePreventa.Plan_de_Venta__c);
                planesVentaPagaresPreventaEliminados.put(pagarePreventa.Plan_de_Venta__c, pagarePreventa);
                idsPagaresPreventaEliminados.add(pagarePreventa.Id);
            }
        }
        if(idsPlanesVentaPagarePreventaEliminado.size() > 0){
            //Se obtienen los planes de venta y sus correspondientes pagares preventa que no fueron creados o modificados en importe manualmente
            Map<Id,List<Pagare_Preventa__c>> planVentaPagaresPreventa = new Map<Id,List<Pagare_Preventa__c>>();
            Map<Id,Plan_de_Venta__c> planesVenta = new Map<Id,Plan_de_Venta__c>();
            for(Plan_de_Venta__c planVenta : [SELECT Id, Plazo__c, Diferencia_a_Pagar__c, (SELECT Id, Importe__c FROM Pagares_Preventa__r WHERE Id NOT IN : idsPagaresPreventaEliminados AND (Creado_Manualmente__c = false AND Modificado_Manualmente_Importe__c = false)) FROM Plan_de_Venta__c WHERE Id IN : idsPlanesVentaPagarePreventaEliminado]){
                planVentaPagaresPreventa.put(planVenta.Id, planVenta.Pagares_Preventa__r);
                planesVenta.put(planVenta.Id, planVenta);
            }
            //Se obtienen los pagares de venta existentes creados o modificados en importe manualmente relacionados a los planes de venta
            Map<Id,Integer> planesVentaCantidadPagares = new Map<Id,Integer>();
            Map<Id,Decimal> planesVentaSumaImportes = new Map<Id,Decimal>();
            for(AggregateResult resultado : [SELECT COUNT(Id) nPagaresPreventa,  sum(Importe__c) sumaImportes, Plan_de_Venta__c FROM Pagare_Preventa__c
                                             WHERE Plan_de_Venta__c IN: idsPlanesVentaPagarePreventaEliminado AND (Creado_Manualmente__c = true OR Modificado_Manualmente_Importe__c = true) AND Id NOT IN : idsPagaresPreventaEliminados GROUP BY Plan_de_Venta__c]){
                                                 planesVentaCantidadPagares.put((Id)resultado.get('Plan_de_Venta__c'), (Integer)resultado.get('nPagaresPreventa'));
                                                 planesVentaSumaImportes.put((Id)resultado.get('Plan_de_Venta__c'), (Decimal)resultado.get('sumaImportes'));
                                             }
            System.debug('*****:planesVentaCantidadPagares:' + planesVentaCantidadPagares);
            System.debug('*****:planesVentaSumaImportes:' + planesVentaSumaImportes);
            
            Plan_de_Venta__c planVenta = new Plan_de_Venta__c();
            Integer plazo = 0;
            Decimal diferenciaPagar = 0;
            Decimal pagar = 0;
            List<Pagare_Preventa__c> pagaresPreventaActualizar = new List<Pagare_Preventa__c>();
            for(Id idPlanVentaPagarePreventaEliminado : idsPlanesVentaPagarePreventaEliminado){
                planVenta = planesVenta.get(idPlanVentaPagarePreventaEliminado);
                plazo = Integer.valueOf(planVenta.Plazo__c) - planesVentaCantidadPagares.get(idPlanVentaPagarePreventaEliminado);
                System.debug('*****:planVenta.Diferencia_a_Pagar__c:' + planVenta.Diferencia_a_Pagar__c);
                System.debug('*****:p:' + planesVentaSumaImportes.get(idPlanVentaPagarePreventaEliminado));
                diferenciaPagar = planVenta.Diferencia_a_Pagar__c - planesVentaSumaImportes.get(idPlanVentaPagarePreventaEliminado);
                System.debug('*****:diferenciaPagar:' + diferenciaPagar);
                
                pagar = (diferenciaPagar/plazo);
                System.debug('*****:pagar:' + pagar);
                
                for(Pagare_Preventa__c pagarePreventa : planVentaPagaresPreventa.get(idPlanVentaPagarePreventaEliminado)){
                    pagarePreventa.Importe__c = pagar;  pagaresPreventaActualizar.add(pagarePreventa);
                }
            }
            
            if(pagaresPreventaActualizar.size() > 0){
                update pagaresPreventaActualizar;
            }
        }
    }
    
    //Metodo para generar nuevos pagares preventa
    public List<Pagare_Preventa__c> creaPagaresPreventa(Id idPlanVenta, Integer plazo, String frecuencia, Date inicio, Decimal diferenciaPagar, Boolean primerPagarePreventa, Boolean primerPagarePreventaManual){
        
        List<Pagare_Preventa__c> pagaresPreventaNuevos = new List<Pagare_Preventa__c>();
        
        Integer aux = 1;
        Double pagar = (diferenciaPagar/plazo);
        if(primerPagarePreventa == true || primerPagarePreventaManual == true){
            
            if(frecuencia == 'Semanal'){  inicio = inicio.addDays(7);   }
            else if(frecuencia == 'Quincenal'){
                inicio = inicio.addDays(15); aux = 0;
            }
            else if(frecuencia == 'Mensual'){  inicio = inicio.addMonths(1);   }
        }        
        
        for(Integer j=0; j<plazo; j++){
            Pagare_Preventa__c pagarePreventaNuevo = new Pagare_Preventa__c();
            pagarePreventaNuevo.Plan_de_Venta__c = idPlanVenta;
            
            if(frecuencia == 'Semanal'){
                pagarePreventaNuevo.Fecha_de_Vencimiento__c = inicio;
                pagarePreventaNuevo.Importe__c = pagar;
                inicio = inicio.addDays(7);
            }
            else if(frecuencia == 'Quincenal'){
                pagarePreventaNuevo.Importe__c = pagar;
                if(aux == 1){
                    pagarePreventaNuevo.Fecha_de_Vencimiento__c = inicio;
                    aux = 0;
                }else{
                    pagarePreventaNuevo.Fecha_de_Vencimiento__c = inicio.addDays(15);
                    aux = 1;
                    inicio = inicio.addMonths(1);
                }
            }
            else if(frecuencia == 'Mensual'){
                pagarePreventaNuevo.Fecha_de_Vencimiento__c = inicio;  pagarePreventaNuevo.Importe__c = pagar;   inicio = inicio.addMonths(1);
            }
            pagaresPreventaNuevos.add(pagarePreventaNuevo);
        }
        return pagaresPreventaNuevos;
    }
}