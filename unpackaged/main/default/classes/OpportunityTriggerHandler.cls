public with sharing class OpportunityTriggerHandler extends TriggerHandler{
    private Map<Id, Opportunity> newMap;
    private Map<Id, Opportunity> oldMap;
    private List<Opportunity> newList;
    private List<Opportunity> oldList;

    private static final String ACTIVATED = 'Activated';
    private static final String INSUFFICIENT_REFERENCES = 'Se necesita de al menos 2 referencias para cambiar de estatus.';

    private static final String MAIN_ADDRESS_MANDATORY = 'La dirección princial es necesaria para poder cambiar de estatus.';
    private static final String OFFICE_ADDRESS_MANDATORY = 'La dirección laboral es necesaria para poder cambiar de estatus.';
    private static final String MANDATORY_ADDRESS = 'La dirección laboral y principal son necesarias para poder cambiar el estatus.';
    private static final String MANDATORY_PERSON = 'Es necesario agregar la sección "PERFIL TERCERO", de acuerdo a su sub tipo fiscal';
    private static final String CESION_VIVIENDA_MANDATORY = 'Es necesario agregar la sección "CESIÓN VIVIENDA A OTRA P FISICA O MORAL", de acuerdo al sub tipo fiscal';
    private static final String CO_ACREDITADO_MANDATORY = 'Es necesario agregar los datos del CO Acreditado';
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

    private static final String FORMALIZADO = 'Formalizado';

    public OpportunityTriggerHandler() {
        this.newMap = (Map<Id, Opportunity>) trigger.newMap;
        this.oldMap = (Map<Id, Opportunity>) trigger.oldMap;
        this.newList = (List<Opportunity>) trigger.new;
        this.oldList = (List<Opportunity>) trigger.old;
    }

    public override void beforeUpdate(){
/*         List<Opportunity> oppList = new List<Opportunity>();
        
        for(Opportunity opp : this.newList){
            if(this.oldMap.get(opp.Id).StageName != opp.StageName && opp.StageName == FORMALIZADO){
                oppList.add(opp);
            }
        }

        if(!oppList.isEmpty()){
            validateContracts(oppList);
        } */
    }

    public void validateContracts(List<Opportunity> opportunityList){
        Set<Id> opportunityIds = new Set<Id>();

        for(Opportunity opp : opportunityList){
            opportunityIds.add(opp.Id);
        }

        List<Contract> contractList = [
            SELECT Sub_Tipo_Fiscal__c, Es_usted_el_Titular_de_Recursos__c, 
                Existe_un_Tercero_que_aporta_Recursos__c, Escritura_a_favor_de_un_Tercero__c,
                Tipo_de_Tramite__c, Oportunidad__c
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
        for(Opportunity opp : opportunityList){
            ct = contractByOppId.get(opp.Id);

            activeReferences = activeReferencesByContract.get(ct.Id);
            contractRelationsWrapper = contractRelationsById.get(ct.Id);

            if(activeReferences == null ||activeReferences < 2){
                opp.addError(INSUFFICIENT_REFERENCES);
            }

            //address related validations
            if(contractRelationsWrapper == null || (!contractRelationsWrapper.officeAddress && !contractRelationsWrapper.mainAddress)){
                opp.addError(MANDATORY_ADDRESS);

            }else if(!contractRelationsWrapper.officeAddress){
                opp.addError(OFFICE_ADDRESS_MANDATORY);

            }else if(!contractRelationsWrapper.mainAddress ){
                opp.addError(MAIN_ADDRESS_MANDATORY);
            }



            //tercera persona validations
            personTotal = ct.Sub_Tipo_Fiscal__c == NATURAL_PERSON ? 
                naturalPersonTotalById.get(ct.Id) : legalPersonTotalById.get(ct.Id);

            if((personTotal == 0 || personTotal == null)){
                if(ct.Es_usted_el_Titular_de_Recursos__c == NO || ct.Existe_un_Tercero_que_aporta_Recursos__c == YES){
                    opp.addError(MANDATORY_PERSON);
                }
            }


            //cesion vivienda validations
            housingTotal = housingTotalByContractId.get(ct.Id);
            if(ct.Escritura_a_favor_de_un_Tercero__c == YES && (housingTotal == null || housingTotal == 0)){
                opp.addError(CESION_VIVIENDA_MANDATORY);
            }

            //coacreditado validations
            coAcreditadoTotal = coacreditadoMap.get(ct.Id);
            if( (ct.Tipo_de_Tramite__c == CONYUGAL || PRODUCT_NAME_SET.contains(opp.Producto_financiero__c)) ){
                //TODO: add validation
                // HMF Comentado el 6/19/23 stopper en pruebas
                // if(coAcreditadoTotal == null || coAcreditadoTotal == 0){
                //     opp.addError(CO_ACREDITADO_MANDATORY);
                // }

                if(contractRelationsWrapper == null){
                    opp.addError(MANDATORY_ADDRESS);
    
                }else if(!contractRelationsWrapper.coAcreditadoOfficeAddress){
                    // opp.addError(CO_ACREDITADO_MANDATORY + ' - Direccion Laboral');
    
                }else if(!contractRelationsWrapper.coAcreditadomainAddress ){
                    // opp.addError(CO_ACREDITADO_MANDATORY + ' - Direccion Principal');
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
    }
}