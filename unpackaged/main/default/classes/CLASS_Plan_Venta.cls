public class CLASS_Plan_Venta {
    private static Boolean isExecuting = false;
    
    //Metodo que valida si requiere acreditados insert "Formalizado"
    /*  public void validaCoaCreditados(list<Plan_de_Venta__c> lstNew){

set<String> idsPlan = new set<String>();
set<String> idsOpp = new set<String>();
set<String> idsDictamin = new set<String>();

for(Plan_de_Venta__c plan : lstNew){
idsOpp.add(plan.Oportunidad__c);
}   

List<Contract> lstDictamin = new List<Contract>(); 
lstDictamin = [ SELECT Id, Oportunidad__c, Oportunidad__r.Producto_financiero__c FROM Contract WHERE Oportunidad__c IN: idsOpp ];
Map<String,List<Contract>> mapDictamin = new Map<String,List<Contract>>();

if(!lstDictamin.isEmpty()){

for(Contract con : lstDictamin){

idsDictamin.add(con.Id);

if(!mapDictamin.containsKey(con.Oportunidad__c)){
List<Contract> lstTemp = new List<Contract>();
lstTemp.add(con);
mapDictamin.put(con.Oportunidad__c,lstTemp); 
}else{
List<Contract> lstTemp = mapDictamin.get(con.Oportunidad__c);
lstTemp.add(con);
mapDictamin.put(con.Oportunidad__c,lstTemp);   
}

}
}

List<Co_Acreditado__c> lstCoacred = new List<Co_Acreditado__c>();
lstCoacred = [ SELECT Id, Contrato__c, Contrato__r.Oportunidad__c  FROM Co_Acreditado__c WHERE Contrato__c IN: idsDictamin ];
Map<String,List<Co_Acreditado__c>> mapCoAcred = new Map<String,List<Co_Acreditado__c>>();

if(!lstCoacred.isEmpty()){
for(Co_Acreditado__c coa : lstCoacred){
if(!mapCoAcred.containsKey(coa.Contrato__r.Oportunidad__c)){
List<Co_Acreditado__c> lstTemp = new List<Co_Acreditado__c>();
lstTemp.add(coa);
mapCoAcred.put(coa.Contrato__r.Oportunidad__c,lstTemp); 
}else{
List<Co_Acreditado__c> lstTemp = mapCoAcred.get(coa.Contrato__r.Oportunidad__c);
lstTemp.add(coa);
mapCoAcred.put(coa.Contrato__r.Oportunidad__c,lstTemp);  
}
}    
}

List<Productos_Financieros_Con_Coacreditados__mdt> lstProdFin = new List<Productos_Financieros_Con_Coacreditados__mdt>();
lstProdFin = Productos_Financieros_Con_Coacreditados__mdt.getAll().values();

for(Plan_de_Venta__c planVenta : lstNew){
if(mapDictamin.ContainsKey(planVenta.Oportunidad__c)){
for(Contract contr : mapDictamin.get(planVenta.Oportunidad__c)){
if(contr.Tipo_de_Tramite__c == 'Conyugal' && !mapCoAcred.ContainsKey(planVenta.Oportunidad__c)){
planVenta.addError('Si el tipo de tramite es ' + contr.Tipo_de_Tramite__c + ' es necesario tener al menos un coacreditado.');
}

if(!mapCoAcred.ContainsKey(planVenta.Oportunidad__c)){
for(Productos_Financieros_Con_Coacreditados__mdt prod : lstProdFin){
if(prod.Label == contr.Oportunidad__r.Producto_financiero__c){
planVenta.addError('Si el producto financiero es ' + contr.Oportunidad__r.Producto_financiero__c + ' es necesario tener al menos un coacreditado.');    
}
}
}

}
}else{
planVenta.addError('No es posible generar un plan de venta si no se cuenta con una dictaminacion completa.');
}
}  

} */
    
    //Metodo que valida si requiere acreditados update "Formalizado"
  /*  public void validaCoaCreditadosUp(Map<Id,Plan_de_Venta__c> mapOld, list<Plan_de_Venta__c> lstNew){
        
        set<String> idsPlan = new set<String>();
        set<String> idsOpp = new set<String>();
        set<String> idsDictamin = new set<String>();
        
        for(Plan_de_Venta__c plan : lstNew){
            if(mapOld.get(plan.Id).En_aprobacion__c != plan.En_aprobacion__c && 
               plan.En_aprobacion__c == true){
                   idsOpp.add(plan.Oportunidad__c); 
               }
        }  
        
        if(!idsOpp.isEmpty()){
            List<Contract> lstDictamin = new List<Contract>(); 
            lstDictamin = [ SELECT Id, Oportunidad__c, Oportunidad__r.Producto_financiero__c, Tipo_de_Tramite__c FROM Contract WHERE Oportunidad__c IN: idsOpp ];
            Map<String,List<Contract>> mapDictamin = new Map<String,List<Contract>>();
            
            if(!lstDictamin.isEmpty()){
                for(Contract con : lstDictamin){
                    idsDictamin.add(con.Id);
                    if(!mapDictamin.containsKey(con.Oportunidad__c)){
                        List<Contract> lstTemp = new List<Contract>();
                        lstTemp.add(con);
                        mapDictamin.put(con.Oportunidad__c,lstTemp); 
                    }
                    else{
                        List<Contract> lstTemp = mapDictamin.get(con.Oportunidad__c); lstTemp.add(con);  mapDictamin.put(con.Oportunidad__c,lstTemp);   
                    }
                }
            }
            List<Co_Acreditado__c> lstCoacred = new List<Co_Acreditado__c>();
            lstCoacred = [ SELECT Id, Contrato__c, Contrato__r.Oportunidad__c  FROM Co_Acreditado__c WHERE Contrato__c IN: idsDictamin ];
            Map<String,List<Co_Acreditado__c>> mapCoAcred = new Map<String,List<Co_Acreditado__c>>();
            
            if(!lstCoacred.isEmpty()){
                for(Co_Acreditado__c coa : lstCoacred){
                    if(!mapCoAcred.containsKey(coa.Contrato__r.Oportunidad__c)){
                        List<Co_Acreditado__c> lstTemp = new List<Co_Acreditado__c>();
                        lstTemp.add(coa);
                        mapCoAcred.put(coa.Contrato__r.Oportunidad__c,lstTemp); 
                    }
                    else{
                        List<Co_Acreditado__c> lstTemp = mapCoAcred.get(coa.Contrato__r.Oportunidad__c);  lstTemp.add(coa);  mapCoAcred.put(coa.Contrato__r.Oportunidad__c,lstTemp);  
                    }
                }    
            }
            
            List<Productos_Financieros_Con_Coacreditados__mdt> lstProdFin = new List<Productos_Financieros_Con_Coacreditados__mdt>();
            lstProdFin = Productos_Financieros_Con_Coacreditados__mdt.getAll().values();
            
            for(Plan_de_Venta__c planVenta : lstNew){
                if(mapDictamin.ContainsKey(planVenta.Oportunidad__c)){
                    for(Contract contr : mapDictamin.get(planVenta.Oportunidad__c)){
                        if(contr.Tipo_de_Tramite__c == 'Conyugal' && !mapCoAcred.ContainsKey(planVenta.Oportunidad__c)){
                            planVenta.addError('Si el tipo de tramite es ' + contr.Tipo_de_Tramite__c + ' es necesario tener al menos un coacreditado.');
                        }
                        if(!mapCoAcred.ContainsKey(planVenta.Oportunidad__c)){
                            for(Productos_Financieros_Con_Coacreditados__mdt prod : lstProdFin){
                                if(prod.Label == contr.Oportunidad__r.Producto_financiero__c){
                                    planVenta.addError('Si el producto financiero es ' + contr.Oportunidad__r.Producto_financiero__c + ' es necesario tener al menos un coacreditado.');    
                                }
                            }
                        }
                    }
                }else{
                    planVenta.addError('No es posible generar un plan de venta si no se cuenta con una dictaminacion completa.');
                }
            }    
        }
    } */
    
    //Metodo que valida si requiere representante legal "Formalizado"
    public static void validaRepLegal(Map<Id,Plan_de_Venta__c> mapOld, list<Plan_de_Venta__c> lstNew){
        set<String> idsOpp = new set<String>();
        for(Plan_de_Venta__c plan : lstNew ){
            if(mapOld.get(plan.Id).En_aprobacion__c != plan.En_aprobacion__c && plan.En_aprobacion__c == true){
                idsOpp.add(plan.Oportunidad__c);    
            }
        }
        if(!idsOpp.isEmpty()){
            Map<Id,Opportunity> mapOppInfo = new Map<Id,Opportunity>([SELECT Id, AccountId, Account.Tipo_Contribuyente__c  FROM Opportunity WHERE Id IN: idsOpp]);
            List<Contract> lstContract = new List<Contract>();
            lstContract = [SELECT Id, Oportunidad__c FROM Contract WHERE Oportunidad__c IN: idsOpp];
            Map<String,List<Contract>> mapContractByOpp = new Map<String,List<Contract>>();
            if(!lstContract.isEmpty()){
                for(Contract contrato : lstContract){
                    if(!mapContractByOpp.containsKey(contrato.Oportunidad__c)){
                        List<Contract> lstTemp = new List<Contract>();
                        lstTemp.add(contrato);
                        mapContractByOpp.put(contrato.Oportunidad__c,lstTemp); 
                    }
                    else{
                        List<Contract> lstTemp = mapContractByOpp.get(contrato.Oportunidad__c); lstTemp.add(contrato); mapContractByOpp.put(contrato.Oportunidad__c,lstTemp);   
                    }    
                }
            }
            List<Informacion_representante_legal__c> lstRepLegal = new List<Informacion_representante_legal__c>();
            lstRepLegal = [SELECT Id, Contrato__c, Contrato__r.Oportunidad__c FROM Informacion_representante_legal__c WHERE Contrato__r.Oportunidad__c IN: idsOpp];
            Map<String,List<Informacion_representante_legal__c>> mapRepLegalByContract = new Map<String,List<Informacion_representante_legal__c>>();
            if(!lstRepLegal.isEmpty()){
                for(Informacion_representante_legal__c repLeg : lstRepLegal){
                    if(!mapRepLegalByContract.containsKey(repLeg.Contrato__r.Oportunidad__c)){
                        List<Informacion_representante_legal__c> lstTemp = new List<Informacion_representante_legal__c>();
                        lstTemp.add(repLeg);
                        mapRepLegalByContract.put(repLeg.Contrato__r.Oportunidad__c,lstTemp); 
                    }
                    else{
                        List<Informacion_representante_legal__c> lstTemp = mapRepLegalByContract.get(repLeg.Contrato__r.Oportunidad__c);  lstTemp.add(repLeg); mapRepLegalByContract.put(repLeg.Contrato__r.Oportunidad__c,lstTemp);   
                    }    
                }
            }
            for(Plan_de_Venta__c plan : lstNew ){
                if(mapOppInfo.get(plan.Oportunidad__c).Account.Tipo_Contribuyente__c == 'Persona Física' && !mapRepLegalByContract.ContainsKey(plan.Oportunidad__c) && mapContractByOpp.containsKey(plan.Oportunidad__c)){
                    for(Contract contract : mapContractByOpp.get(plan.Oportunidad__c)){
                        if(contract.Firma_Directa_Cliente__c == 'NO' ||  contract.Firma_Directa_Apoderado_Legal__c == 'SI'){
                            plan.addError('Es necesario capturar al menos un representante legal en la dictaminacion, antes de solicitar la aprobacion del plan de venta.');   
                        }
                    }
                }
                else if(mapOppInfo.get(plan.Oportunidad__c).Account.Tipo_Contribuyente__c == 'Persona Moral' && !mapRepLegalByContract.ContainsKey(plan.Oportunidad__c) && mapContractByOpp.containsKey(plan.Oportunidad__c)){
                    for(Contract contract : mapContractByOpp.get(plan.Oportunidad__c)){
                        if(contract.Es_usted_el_Titular_de_Recursos__c == 'NO'||contract.Es_usted_el_Titular_de_Recursos__c == 'SI' ||contract.Escritura_a_favor_de_un_Tercero__c == 'NO' ||contract.Firma_Directa_Apoderado_Legal__c == 'SI' ||
                           contract.Escritura_a_favor_de_un_Tercero__c == 'SI' || contract.Firma_Directa_Cliente__c == 'NO' || contract.Firma_Directa_Cliente__c == 'SI' ||contract.Firma_Directa_Apoderado_Legal__c == 'NO'){
                               plan.addError('Es necesario capturar al menos un representante legal en la dictaminacion, antes de solicitar la aprobacion del plan de venta.');   
                           }
                    }
                }
            }
        }
    }

    public static void Aprobar_Plan_Venta(list <Plan_de_Venta__c> newList, Map<Id,Plan_de_Venta__c> mapOld) {
        boolean doUpdate = false;
        // List <Plan_de_Venta__c> updPdv = [SELECT El_Registro_Esta_Totalmente_Aprobado__c, Plan_de_Venta_Aprobado__c, En_aprobacion__c,
        //                     Estatus_Plan_de_venta__c, FlowOverride__c
        //                     FROM Plan_de_Venta__c
        //                     WHERE ID in :newList];
        for (Plan_de_Venta__c p :  newList) {
            system.debug ('*** Entro a Aprobar_Plan_Venta ***');
            if (p.El_Registro_Esta_Totalmente_Aprobado__c != mapOld.get(p.Id).El_Registro_Esta_Totalmente_Aprobado__c &&
                p.El_Registro_Esta_Totalmente_Aprobado__c == True) {
                system.debug('*** Entró a Plan de Venta Aprobado' );
                Plan_de_Venta__c newPdv = new Plan_de_Venta__c();
                //newPdv.id = p.Id;
                p.Plan_de_Venta_Aprobado__c = True;
                p.En_aprobacion__c = False;
                p.Estatus_Plan_de_venta__c = 'Aprobado';
                p.FlowOverride__c = datetime.now(); // Evitar recursividad
                doUpdate = true;
                // update p;
            }
        }
        // if (doUpdate) {
        //     update newList;
        // }
        // if (doUpdate && updPdv.size()>0) {
            // update newList; //updPdv;
        // }
    }

    public static void CLASS_Calc_Precios(list <Plan_de_Venta__c> newList) {
        if (!newList.isEmpty()) {
            isExecuting = true;
            system.debug('****** Entró a Calcular precios');

            List <Plan_de_Venta__c> lstPlanDeVenta = [SELECT Id, Oportunidad__c, Importe_Condiciones_Especiales__c, Lista_de_Precios_Vivienda_Reciente__c,
                Lista_de_Precios_Bonificacion_Reciente__r.Monto_Bonificacion__c,
                Lista_de_Precios_Financiamien_Reciente__r.Importe_Financiamiento__c,
                Lista_de_Precios_Financiamien_Reciente__r.Porcentaje_Fianciamiento__c,
                Area_Municipal__c, //Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_Area_Municipal__c,
                Lista_de_Precios_Vivienda_Reciente__r.Prcentaje_Precio_frente_area_municipal__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_area_municipal__c,
                Lista_de_Precios_Vivienda__r.Precio_Lista__c,
                Esquina__c, //Lista_de_Precios_Vivienda__r.CALC_Precio_Esquina__c,
                Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_esquina__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_esquina__c,
                Frente_Parque__c, //Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_a_Parque__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_a_parque__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_a_praque__c,
                Instalaciones__c, //Lista_de_Precios_Vivienda__r.CALC_Precio_Instalaciones__c,
                Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_instalaciones__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_Instalaciones__c,
                Lado_Sol__c, //Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sol__c,
                Lista_de_Precios_Vivienda_Reciente__r.Procentaje_Precio_lado_sol__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_lado_sol__c,
                Lado_Sombra__c, Precio_Lado_Sombra__c, //Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sombra__c,
                Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_lado_sombra__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_lado_sombra__c,
                Lista_de_Precios_Promo_Precio_Reciente__r.Precio_Min_Solicitado__c,
                Vivienda__r.Precio_Total_Excedente__c,
                Sobre_Avenida__c, Lista_de_Precios_Vivienda__r.CALC_Precio__c,
                Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_sobre_avenida__c,
                Lista_de_Precios_Vivienda_Reciente__r.Precio_sobre_avenida__c,
                Lista_de_Precios_Vivienda__r.CALC_Precio_Superficie_Excedente__c,
                Vivienda__r.Precio_Unitario__c,
                Lista_de_Precios_Vivienda__r.Precio_superficie_excedente__c,
                Precio_Lista_con_Descuento__c,
                Vivienda__r.Esquina__c,
                Vivienda__r.Sobre_Avenida__c,
                FlowOverride__c, Calc_Precios_Bypass__c
                FROM Plan_de_Venta__c WHERE id IN :newList];

            for (Plan_de_Venta__c planDeVenta : lstPlanDeVenta) {
                planDeVenta.trCalc_Monto_Desc_Preautorizado__c = planDeVenta.Lista_de_Precios_Bonificacion_Reciente__r.Monto_Bonificacion__c;
                planDeVenta.trCalc_Monto_Fin_Autorizado__c = planDeVenta.Lista_de_Precios_Financiamien_Reciente__r.Importe_Financiamiento__c;
                planDeVenta.trCalc_Porcentaje_Fin_Autorizado__c = planDeVenta.Lista_de_Precios_Financiamien_Reciente__r.Porcentaje_Fianciamiento__c;
                planDeVenta.trCalc_Precio__c = planDeVenta.Lista_de_Precios_Vivienda__r.Precio_Lista__c;

                // planDeVenta.trCalc_Precio_Area_Municipal__c = planDeVenta.Area_Municipal__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_Area_Municipal__c : 0;
                if (planDeVenta.Area_Municipal__c) {
                    if (planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Prcentaje_Precio_frente_area_municipal__c==null || planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Prcentaje_Precio_frente_area_municipal__c==0) { 
                        planDeVenta.trCalc_Precio_Area_Municipal__c = planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_area_municipal__c;
                    } else {
                        planDeVenta.trCalc_Precio_Area_Municipal__c = planDeVenta.Precio_Lista_con_Descuento__c * planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Prcentaje_Precio_frente_area_municipal__c/100;
                    }
                } else {
                    planDeVenta.trCalc_Precio_Area_Municipal__c = 0;
                }

                //planDeVenta.trCalc_Precio_Esquina__c = planDeVenta.Esquina__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Esquina__c : 0;
                if (planDeVenta.Vivienda__r.Esquina__c) {
                    if (planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_esquina__c==null || planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_esquina__c==0) {
                        planDeVenta.trCalc_Precio_Esquina__c = planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_esquina__c;
                        system.debug('Precio Esquina con %=null o 0: '+planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_esquina__c);
                    } else {
                        planDeVenta.trCalc_Precio_Esquina__c = planDeVenta.Precio_Lista_con_Descuento__c * planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_esquina__c/100;
                        system.debug('Precio Esquina con % no null: '+planDeVenta.trCalc_Precio_Esquina__c);
                    } 
                } else {
                    planDeVenta.trCalc_Precio_Esquina__c = 0;
                }

                // planDeVenta.trCalc_Precio_Sobre_Avenida__c = planDeVenta.Sobre_Avenida__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio__c : 0;
                if (planDeVenta.Vivienda__r.Sobre_Avenida__c) {
                    if (planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_sobre_avenida__c==null || planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_sobre_avenida__c==0) { 
                        planDeVenta.trCalc_Precio_Sobre_Avenida__c = planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_sobre_avenida__c;
                    } else {
                        planDeVenta.trCalc_Precio_Sobre_Avenida__c = planDeVenta.Precio_Lista_con_Descuento__c * planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_sobre_avenida__c/100;
                    } 
                } else {
                    planDeVenta.trCalc_Precio_Sobre_Avenida__c = 0;
                }

                // planDeVenta.trCalc_Precio_Frente_Parque__c = planDeVenta.Frente_Parque__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_a_Parque__c : 0;
                if (planDeVenta.Frente_Parque__c) {
                    if (planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_a_parque__c==null || planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_a_parque__c==0) { 
                        planDeVenta.trCalc_Precio_Frente_Parque__c = planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_a_praque__c;
                    } else {
                        planDeVenta.trCalc_Precio_Frente_Parque__c = planDeVenta.Precio_Lista_con_Descuento__c * planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_frente_a_parque__c/100;
                    } 
                } else {
                    planDeVenta.trCalc_Precio_Frente_Parque__c = 0;
                }

                // planDeVenta.trCalc_Precio_Instalaciones__c = planDeVenta.Instalaciones__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Instalaciones__c : 0;
                if (planDeVenta.Instalaciones__c) {
                    if (planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_instalaciones__c==null || planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_instalaciones__c==0) { 
                        planDeVenta.trCalc_Precio_Instalaciones__c = planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_Instalaciones__c;
                    } else {
                        planDeVenta.trCalc_Precio_Instalaciones__c = planDeVenta.Precio_Lista_con_Descuento__c * planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_instalaciones__c/100;
                    } 
                } else {
                    planDeVenta.trCalc_Precio_Instalaciones__c = 0;
                }

                // planDeVenta.trCalc_Precio_Lado_Sol__c = planDeVenta.Lado_Sol__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sol__c : 0;
                if (planDeVenta.Lado_Sol__c) {
                    if (planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Procentaje_Precio_lado_sol__c==null || planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Procentaje_Precio_lado_sol__c==0) { 
                        planDeVenta.trCalc_Precio_Lado_Sol__c = planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_lado_sol__c;
                    } else {
                        planDeVenta.trCalc_Precio_Lado_Sol__c = planDeVenta.Precio_Lista_con_Descuento__c * planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Procentaje_Precio_lado_sol__c/100;
                    } 
                } else {
                    planDeVenta.trCalc_Precio_Lado_Sol__c = 0;
                }

                // planDeVenta.trCalc_Precio_Lado_Sombra__c = planDeVenta.Lado_Sombra__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sombra__c : 0;
                if (planDeVenta.Lado_Sombra__c) {
                    if (planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_lado_sombra__c==null || planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_lado_sombra__c==0) { 
                        planDeVenta.trCalc_Precio_Lado_Sombra__c = planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Precio_lado_sombra__c;
                    } else {
                        planDeVenta.trCalc_Precio_Lado_Sombra__c = planDeVenta.Precio_Lista_con_Descuento__c * planDeVenta.Lista_de_Precios_Vivienda_Reciente__r.Porcentaje_Precio_lado_sombra__c/100;
                    } 
                } else {
                    planDeVenta.trCalc_Precio_Lado_Sombra__c = 0;
                }

                planDeVenta.trCalc_Precio_minimo_solicitado__c = planDeVenta.Lista_de_Precios_Promo_Precio_Reciente__r.Precio_Min_Solicitado__c;
                planDeVenta.trCalc_Precio_por_m2_exc__c = planDeVenta.Lista_de_Precios_Vivienda__r.Precio_superficie_excedente__c;

                planDeVenta.trCalc_Precio_Superficie_Excedente__c = planDeVenta.Sobre_Avenida__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Superficie_Excedente__c : 0;
                planDeVenta.trCalc_Precio_Unitario__c = planDeVenta.Vivienda__r.Precio_Unitario__c;
                // planDeVenta.trCalc_Precio_Venta_Normal__c = planDeVenta.Vivienda__r.Precio_Unitario__c > 1 ? planDeVenta.Vivienda__r.Precio_Unitario__c : planDeVenta.Lista_de_Precios_Vivienda__r.Precio_Lista__c + planDeVenta.Importe_Condiciones_Especiales__c;
                if (planDeVenta.Vivienda__r.Precio_Unitario__c > 1) {
                    planDeVenta.trCalc_Precio_Venta_Normal__c = planDeVenta.Vivienda__r.Precio_Unitario__c;
                } else {
                    planDeVenta.trCalc_Precio_Venta_Normal__c = planDeVenta.Lista_de_Precios_Vivienda__r.Precio_Lista__c == null ? 0 :planDeVenta.Lista_de_Precios_Vivienda__r.Precio_Lista__c + planDeVenta.Importe_Condiciones_Especiales__c == null ? 0 : planDeVenta.Importe_Condiciones_Especiales__c;
                }
                planDeVenta.Calc_Precios_Bypass__c=Datetime.Now();
                planDeVenta.FlowOverride__c=Datetime.Now();
            }

            update lstPlanDeVenta;
        }
        // isExecuting = false;
    }
}