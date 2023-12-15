public class CLASS_Direcciones {

    public void validaDireccionesExistentes(list<Direcciones__c> lstNew){
        system.debug('entro');
        Set<String> idsDictaminaciones = new Set<String>();
        
        for(Direcciones__c dir : lstNew){
            idsDictaminaciones.add(dir.Contrato__c);
        }
        
        list<Direcciones__c> lstDirecciones = new list<Direcciones__c>();
        lstDirecciones = [SELECT Id, Name, Tipo__c FROM Direcciones__c WHERE Contrato__c IN: idsDictaminaciones];
        
        if(!lstDirecciones.IsEmpty()){
            for(Direcciones__c dirEntrante : lstNew){
            	for(Direcciones__c dirExistente : lstDirecciones){
                    if(dirEntrante.Tipo__c == dirExistente.Tipo__c){
                        dirEntrante.addError('ya existe una dirección del tipo "' + dirEntrante.Tipo__c + '".');
                    }
            	}    
            }
        }
        
    }
    
    public void validaDireccionesExistentesUp(Map<Id,Direcciones__c> mapOld, list<Direcciones__c> lstNew){
        
        Set<String> idsDictaminaciones = new Set<String>();
        
        for(Direcciones__c dir : lstNew){
            if(mapOld.get(dir.Id).Tipo__c != dir.Tipo__c){
            	idsDictaminaciones.add(dir.Contrato__c);    
            }
        }
        
        if(!idsDictaminaciones.IsEmpty()){
            
            list<Direcciones__c> lstDirecciones = new list<Direcciones__c>();
        	lstDirecciones = [SELECT Id, Name, Tipo__c FROM Direcciones__c WHERE Contrato__c IN: idsDictaminaciones];
            
            for(Direcciones__c dirEntrante : lstNew){
            	for(Direcciones__c dirExistente : lstDirecciones){
                    if(dirEntrante.Tipo__c == dirExistente.Tipo__c){
                        dirEntrante.addError('Ya existe una dirección del tipo "' + dirEntrante.Tipo__c + '".');
                    }
            	}    
            }
        }
        
    }
}