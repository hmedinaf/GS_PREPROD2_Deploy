public class CLASS_Dictaminacion {

    //Valida si la oportunidad relacionada ya cuenta con una dictaminacion
    public void validaExistenciaDictaminacion(list<Contract> lstNew){
		set<String> idsOpp = new set<String>();
        
        for(Contract cont : lstNew ){
            idsOpp.add(cont.Oportunidad__c);
        }
        
        List<Contract> lstContractEx = new List<Contract>();
        lstContractEx = [ SELECT Id, Oportunidad__c FROM Contract WHERE Oportunidad__c IN: idsOpp];
        Map<String,List<Contract>> mapContractByOpp = new Map<String,List<Contract>>();
        
        if(!lstContractEx.isEmpty()){
            for(Contract cnt : lstContractEx){
                if(!mapContractByOpp.containsKey(cnt.Oportunidad__c)){
                   	List<Contract> lstTemp = new List<Contract>();
                   	lstTemp.add(cnt);
                   	mapContractByOpp.put(cnt.Oportunidad__c,lstTemp); 
                }else{
                 	List<Contract> lstTemp = mapContractByOpp.get(cnt.Oportunidad__c);
                	lstTemp.add(cnt);
                   	mapContractByOpp.put(cnt.Oportunidad__c,lstTemp);   
                }
            }
            
            for(Contract contrato : lstNew ){
            	if(mapContractByOpp.containsKey(contrato.Oportunidad__c)){
                	contrato.addError('Solo puede existir una dictaminacion por proceso de venta.');
            	}
        	}
        }
        
        
        
    }

	/**
	 * Author: Edgar Moran
	 * Validation: Solo se podrá agregar una dirección de cada tipo.
	 */
	public void validaDireccion(Map<Id,Contract> mapContracts){
		
	}
    
    //Valida si la nueva oportunidad relacionada ya cuenta con una dictaminacion
    public void validaExistenciaDictaminacionUp(Map<Id,Contract> mapOld, list<Contract> lstNew){
		set<String> idsOpp = new set<String>();
        
        for(Contract cont : lstNew ){
            if(mapOld.get(cont.Id).Oportunidad__c != cont.Oportunidad__c){
            	idsOpp.add(cont.Oportunidad__c);
            }
        }
        
        if(!idsOpp.isEmpty()){
        	List<Contract> lstContractEx = new List<Contract>();
        	lstContractEx = [ SELECT Id, Oportunidad__c FROM Contract WHERE Oportunidad__c IN: idsOpp];
        	Map<String,List<Contract>> mapContractByOpp = new Map<String,List<Contract>>();
        
        	if(!lstContractEx.isEmpty()){
            	for(Contract cnt : lstContractEx){
                	if(!mapContractByOpp.containsKey(cnt.Oportunidad__c)){
                   		List<Contract> lstTemp = new List<Contract>();
                   		lstTemp.add(cnt);
                   		mapContractByOpp.put(cnt.Oportunidad__c,lstTemp); 
                	}else{
                 		List<Contract> lstTemp = mapContractByOpp.get(cnt.Oportunidad__c);
                		lstTemp.add(cnt);
                   		mapContractByOpp.put(cnt.Oportunidad__c,lstTemp);   
                	}
            	}
            
            	for(Contract contrato : lstNew ){
            		if(mapContractByOpp.containsKey(contrato.Oportunidad__c)){
                		contrato.addError('Solo puede existir una dictaminacion por proceso de venta.');
            		}
        		}
        	}    
        }
        
        
        
    }
	
}