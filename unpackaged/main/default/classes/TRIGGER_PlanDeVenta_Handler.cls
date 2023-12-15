public with sharing class TRIGGER_PlanDeVenta_Handler extends triggerHandler{
    
    private Map<Id, Plan_de_Venta__c> newMap;
    private Map<Id, Plan_de_Venta__c> oldMap;
    private List<Plan_de_Venta__c> newList;
    private List<Plan_de_Venta__c> oldList;
    private Set<Id> idSet;
    
    private static final String ACTIVATED = 'Activated';
    private static final String INSUFFICIENT_REFERENCES = 'Se necesita de al menos 2 referencias para cambiar de estatus.';
    
    private static final String MAIN_ADDRESS_MANDATORY = 'La dirección princial es necesaria para poder cambiar de estatus.';
    private static final String OFFICE_ADDRESS_MANDATORY = 'La dirección laboral es necesaria para poder cambiar de estatus.';
    private static final String MANDATORY_ADDRESS = 'La dirección laboral y principal son necesarias para poder cambiar el estatus.';
    private static final String MANDATORY_PERSON = 'Es necesario agregar la sección "PERFIL TERCERO", de acuerdo a su sub tipo fiscal';
    private static final String CESION_VIVIENDA_MANDATORY = 'Es necesario agregar la sección "CESIÓN VIVIENDA A OTRA P FISICA O MORAL", de acuerdo al sub tipo fiscal';
    private static final String CO_ACREDITADO_MANDATORY = 'Es necesario agregar los datos del CO Acreditado';
    private static final String PLAN_VENTA_MANDATORY = 'Es necesario contar con una dictaminación para cambiar de estatus';
    private static final String MAIN_ADDRESS = 'Dirección Principal';
    private static final String OFFICE_ADDRESS = 'Dirección Laboral';
    private static final String CO_MAIN_ADDRESS = 'Dirección Principal CO Acreditado';
    private static final String CO_OFFICE_ADDRESS = 'Dirección Laboral CO Acreditado';
    private static final String CONYUGAL = 'Conyugal';
    
    private static final Set<String> PRODUCT_NAME_SET = new Set<String>{
        'FOVISSSTE PARA TODOS', 
            'COFINAVIT CONYUGAL', 
            'CONYUGAL', 
            'CONYUGAL C/SUBSIDIO 2.6 VSM', 
            'CONYUGAL C/SUBSIDIO 5 VSM', 
            'UNAMOS CREDITOS'
            };
                
                private set<String> MandatoryAddressSet = new Set<String>{
                    MAIN_ADDRESS,
                        OFFICE_ADDRESS,
                        CO_MAIN_ADDRESS,
                        CO_OFFICE_ADDRESS
                        };
                            
                            private static final String NATURAL_PERSON = 'PERSONA FISICA';
    private static final String LEGAL_PERSON = 'PERSONA MORAL';
    
    private static final String YES = 'SI'; 
    private static final String NO = 'NO'; 
    private static final String APROBADO = 'Aprobado';
    
    public TRIGGER_PlanDeVenta_Handler(){
        this.newMap = (Map<Id, Plan_de_Venta__c>) Trigger.newMap;
        this.oldMap = (Map<Id, Plan_de_Venta__c>) Trigger.oldMap;
        this.newList = (List<Plan_de_Venta__c>) Trigger.new;
        this.oldList = (List<Plan_de_Venta__c>) Trigger.old;
        this.idSet = this.newMap.keySet();
    }
    
    public override void afterUpdate(){
        system.debug('*** Entro a PlanDeVenta Trigger afterUpdate');
        // En reserva Vivienda, invocar servicio Integracion EBS Cliente
        for(Plan_de_Venta__c pdv : this.newList){
            system.debug('*** Eval  pdv.Vivienda:'+pdv.Vivienda__c);
            if(!pdv.IsVRBypassed__c && this.oldMap.get(pdv.Id).Vivienda__c != pdv.Vivienda__c && pdv.Vivienda__c != NULL && this.oldMap.get(pdv.Id).Vivienda__c==null){ //&& pdv.Estatus__c == 'Reservado')
                system.debug('*** Llamando servicio Integracion EBS');
                String Requisicion = pdv.Reubicacion_Aux__c==false ? '2' : '20';  // Req=20 (Reubicacion), o Req=2 (Reservacion)
                Integracion_EBS.Inserta_Integracion_EBS(Requisicion, pdv.Id);
            }
        }

        Set<Id> idSetToUpdate = New Set<Id>();
        for(id i : idSet){
            Plan_de_Venta__c oldPdV = oldMap.get(i);
            Plan_de_Venta__c newPdV = newMap.get(i);
            if(!newPdV.IsVRBypassed__c && (oldPdV.Plazo__c != newPdV.Plazo__c || oldPdV.Fecha_de_Vencimiento__c != newPdV.Fecha_de_Vencimiento__c || oldPdV.Frecuencia__c != newPdV.Frecuencia__c) &&
               (newPdV.Plazo__c != null && newPdV.Fecha_de_Vencimiento__c != null && newPdV.Frecuencia__c != null) && newPdV.Modificacion_Automatica__c == oldPdV.Modificacion_Automatica__c){
                   idSetToUpdate.add(i);
               }
        }
        List<Pagare_Preventa__c> pagaresPreventaExistentes = [Select Id, Plan_de_Venta__c, Fecha_de_Vencimiento__c, Importe__c From Pagare_Preventa__c Where Plan_de_Venta__c in :idSetToUpdate];
        Delete(pagaresPreventaExistentes);
        List<Pagare_Preventa__c> pagaresPreventaNuevos = New List<Pagare_Preventa__c>();
        for(id i : idSetToUpdate){
            Plan_de_Venta__c pdv = newMap.get(i);
            Integer plazo = (integer)pdv.Plazo__c;
            String frecuencia = pdv.Frecuencia__c;
            Date inicio = pdv.Fecha_de_Vencimiento__c;
            Double pagar = (pdv.Diferencia_a_Pagar__c/plazo);
            Integer aux = 1;
            for(Integer j=0; j<plazo; j++){
                Pagare_Preventa__c pp = New Pagare_Preventa__c();
                pp.Plan_de_Venta__c = i;
                pp.No_Pagare__c = j+1;
                
                if(frecuencia == 'Semanal'){
                    pp.Fecha_de_Vencimiento__c = inicio;
                    pp.Importe__c = pagar;
                    inicio = inicio.addDays(7);
                }
                else if(frecuencia == 'Quincenal'){
                    pp.Importe__c = pagar;
                    if(aux == 1){
                        pp.Fecha_de_Vencimiento__c = inicio;  aux = 0;
                    }
                    else{
                        pp.Fecha_de_Vencimiento__c = inicio.addDays(15);  aux = 1; inicio = inicio.addMonths(1);
                    }
                }
                else if(frecuencia == 'Mensual'){
                    pp.Fecha_de_Vencimiento__c = inicio;  pp.Importe__c = pagar; inicio = inicio.addMonths(1);
                }
                pagaresPreventaNuevos.add(pp);
            }
        }
        Insert(pagaresPreventaNuevos);
    }
    
    public override void beforeUpdate(){
        List<Plan_de_Venta__c> pdvList = new List<Plan_de_Venta__c>();
        List<Plan_de_Venta__c> pdvToEBS = new List<Plan_de_Venta__c>();
        
        for(Plan_de_Venta__c pdv : this.newList){
            if(this.oldMap.get(pdv.Id).Estatus_Plan_de_venta__c != pdv.Estatus_Plan_de_venta__c && pdv.Estatus_Plan_de_venta__c == APROBADO){
                pdvList.add(pdv);
            }
            // Si vivienda pasó de Reservada a no Reservada marcar bandera Reubicacion_Aux__c
            if(pdv.Vivienda__c==null && this.oldMap.get(pdv.Id).Vivienda__c!=null) {
                pdv.Reubicacion_Aux__c=true;
            }
        }
        // HMF Comentado el 7/26/23. Dictaminación ya no va en contract
        /*
if(!pdvList.isEmpty()){
validateContracts(pdvList);
}
*/

    }
    /* public void validateContracts(List<Plan_de_Venta__c> pdvList){
Set<Id> opportunityIds = new Set<Id>();

for(Plan_de_Venta__c pdv : pdvList){
opportunityIds.add(pdv.Oportunidad__c);
}

List<Contract> contractList = [
SELECT Sub_Tipo_Fiscal__c, Es_usted_el_Titular_de_Recursos__c, 
Existe_un_Tercero_que_aporta_Recursos__c, Escritura_a_favor_de_un_Tercero__c,
Tipo_de_Tramite__c, Oportunidad__c, Oportunidad__r.Producto_financiero__c
FROM Contract
WHERE Oportunidad__c IN : opportunityIds
];

Map<Id,Contract> contractByOppId = new Map<Id,Contract>();

for(Contract ct : contractList){
contractByOppId.put(ct.Oportunidad__c, ct);
}


Set<Id> contractIds = new Set<Id>();
Set<Id> legalPersonContractIds = new Set<Id>();
Set<Id> naturalPersonContractIds = new Set<Id>();

for(Contract ct : contractList){
contractIds.add(ct.Id);

if(ct.Sub_Tipo_Fiscal__c == LEGAL_PERSON){
legalPersonContractIds.add(ct.Id);
}else if(ct.Sub_Tipo_Fiscal__c == NATURAL_PERSON){
naturalPersonContractIds.add(ct.Id);
}
}

//formating results
List<AggregateResult> ActiveReferencesList = [
SELECT COUNT(Id)activeReferences, Contrato__c
FROM Referencia_familiar__c 
WHERE Contrato__c IN : contractIds 
GROUP BY Contrato__c ];

Map<Id,Integer> activeReferencesByContract = new Map<Id,Integer>();
Id contract;
Integer activeReferences;

for(AggregateResult ag : ActiveReferencesList){
contract = (Id) ag.get('contrato__c');
activeReferences = (Integer) ag.get('activeReferences');

activeReferencesByContract.put(contract, activeReferences);
}

//to check address validations
List<Direcciones__c> addressList = [
SELECT Contrato__c, Tipo__c
FROM Direcciones__c
WHERE Contrato__c IN : contractIds
AND Tipo__c IN : MandatoryAddressSet
];

Map<Id, ContractRelations> contractRelationsById = new Map<Id,ContractRelations>();
ContractRelations contractRelationsWrapper;

for(Direcciones__c address : addressList){
contractRelationsWrapper = contractRelationsById.get(address.Contrato__c);

if(contractRelationsWrapper == null){
contractRelationsWrapper = new ContractRelations();
contractRelationsById.put(address.Contrato__c, contractRelationsWrapper);
}

contractRelationsWrapper.setAddress(address.Tipo__c);

}

//natural and legal third person queries
Map<Id, Integer> legalPersonTotalById = new Map<Id, Integer>();
if(!legalPersonContractIds.isEmpty()){

List<AggregateResult> legalPersonList = [
SELECT COUNT(Id)legalPersonTotal, Dictaminacion__c
FROM Perfil_Tercero_Moral__c
WHERE Dictaminacion__c IN : legalPersonContractIds
GROUP BY Dictaminacion__c
];

Id contractId;
Integer legalPersonTotal;

for(AggregateResult ag : legalPersonList){
contractId = (Id) ag.get('Dictaminacion__c');
legalPersonTotal = (Integer) ag.get('legalPersonTotal');

legalPersonTotalById.put(contract, legalPersonTotal);
}
}

Map<Id, Integer> naturalPersonTotalById = new Map<Id, Integer>();

if(!naturalPersonContractIds.isEmpty()){
List<AggregateResult> natualPersonList= [
SELECT COUNT(Id)naturalPersonTotal, Dictaminacion__c
FROM Perfil_Tercero_Fisico__c
WHERE Dictaminacion__c IN : naturalPersonContractIds
GROUP BY Dictaminacion__c
];

Id contractId;
Integer naturalPersonTotal;

for(AggregateResult ag : natualPersonList){
contractId = (Id) ag.get('Dictaminacion__c');
naturalPersonTotal = (Integer) ag.get('naturalPersonTotal');
naturalPersonTotalById.put(contract, naturalPersonTotal);
}
}

//cesion vivienda queries
List<AggregateResult>  aggregateResults = [
SELECT COUNT(Id)housingTotal, Contrato__c
FROM Cesion_a_Otra_Persona_Fisica_o_Moral__c
WHERE Contrato__c IN : contractIds
GROUP BY Contrato__c
];

Map<Id,Integer> housingTotalByContractId = new Map<Id, Integer>();

for(AggregateResult ag : aggregateResults){

HousingTotalByContractId.put(
(Id) ag.get('Contrato__c'), 
(Integer) ag.get('housingTotal'));
}

//Co Acreditado validations
List<AggregateResult>  coAcreditadoResults = [
SELECT COUNT(Id)total, Contrato__c
FROM Co_Acreditado__c
WHERE Contrato__c IN : contractIds
GROUP BY Contrato__c
];

Map<Id,Integer> coacreditadoMap = new Map<Id, Integer>();

for(AggregateResult ag : coAcreditadoResults){
coacreditadoMap.put(
(Id) ag.get('Contrato__c'), 
(Integer) ag.get('total'));
}

Integer personTotal;
Integer housingTotal;
Integer oppLineItemTotal;
Integer coAcreditadoTotal;
Contract ct;
for(Plan_de_Venta__c pdv : pdvList){
ct = contractByOppId.get(pdv.Oportunidad__c);

if(ct == null){
pdv.addError(PLAN_VENTA_MANDATORY);
return;
}

activeReferences = activeReferencesByContract.get(ct.Id);
contractRelationsWrapper = contractRelationsById.get(ct.Id);

if(activeReferences == null ||activeReferences < 2){
pdv.addError(INSUFFICIENT_REFERENCES);
}

//address related validations
if(contractRelationsWrapper == null){
pdv.addError(MANDATORY_ADDRESS);

}else if(!contractRelationsWrapper.officeAddress){
pdv.addError(OFFICE_ADDRESS_MANDATORY);

}else if(!contractRelationsWrapper.mainAddress ){
pdv.addError(MAIN_ADDRESS_MANDATORY);
}

//tercera persona validations
personTotal = ct.Sub_Tipo_Fiscal__c == NATURAL_PERSON ? 
naturalPersonTotalById.get(ct.Id) : legalPersonTotalById.get(ct.Id);

if((personTotal == 0 || personTotal == null)){
if(ct.Es_usted_el_Titular_de_Recursos__c == NO || ct.Existe_un_Tercero_que_aporta_Recursos__c == YES){
pdv.addError(MANDATORY_PERSON);
}
}


//cesion vivienda validations
housingTotal = housingTotalByContractId.get(ct.Id);
if(ct.Escritura_a_favor_de_un_Tercero__c == YES && (housingTotal == null || housingTotal == 0)){
pdv.addError(CESION_VIVIENDA_MANDATORY);
}

//coacreditado validations
coAcreditadoTotal = coacreditadoMap.get(ct.Id);
if( (ct.Tipo_de_Tramite__c == CONYUGAL || PRODUCT_NAME_SET.contains(ct.Oportunidad__r.Producto_financiero__c)) ){
//TODO: add validation
// HMF 6/19/23 Comentado por que es stopper en pruebas
if(contractRelationsWrapper == null){
pdv.addError(MANDATORY_ADDRESS);

}else if(!contractRelationsWrapper.coAcreditadoOfficeAddress){
// pdv.addError(CO_ACREDITADO_MANDATORY + ' - Direccion Laboral');

}else if(!contractRelationsWrapper.coAcreditadomainAddress ){
// pdv.addError(CO_ACREDITADO_MANDATORY + ' - Direccion Principal');
}

if(coAcreditadoTotal == null || coAcreditadoTotal == 0){
// pdv.addError(CO_ACREDITADO_MANDATORY);
}
}
}
} 
    private class ContractRelations {
        public Boolean officeAddress;
        public Boolean mainAddress;
        public Boolean coAcreditadoOfficeAddress;
        public Boolean coAcreditadomainAddress;
        public ContractRelations(){
            this.officeAddress = false;
            this.mainAddress = false;
            this.coAcreditadoOfficeAddress = false;
            this.coAcreditadomainAddress = false;
        }
        public void setAddress(String type){
            if(type == MAIN_ADDRESS){
                this.mainAddress = true;
            }else if(type == OFFICE_ADDRESS){
                this.officeAddress = true;
            }else if(type == CO_MAIN_ADDRESS){
                this.coAcreditadomainAddress = true;
            }else if(type == CO_OFFICE_ADDRESS){
                this.coAcreditadoOfficeAddress = true;
            }
        } 
    } */
}