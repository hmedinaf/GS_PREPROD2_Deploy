trigger CPPT_Rel_Prod_Frac on Relacion_Producto_Fraccionamiento__c (before insert, before update, after insert, after update) {
    if(Trigger.isBefore){
        Set<Id> fracSet = new Set<Id>(); 
        Set<Id> plazaSet = new Set<Id>();
        Map<Id, Fraccionamiento__c>  fracMap = new  Map<Id, Fraccionamiento__c>();
        Map<Id, Relacion_Producto_Plaza__c>  plazaMap = new  Map<Id, Relacion_Producto_Plaza__c>();
        for(Relacion_Producto_Fraccionamiento__c rpf : Trigger.New){
            fracSet.add(rpf.Fraccionamiento__c);
            plazaSet.add(rpf.Relacion_Producto_Plaza_Fraccionamiento__c);
        }
       if(fracSet !=null && fracSet.size()>0){
            fracMap = new  Map<Id, Fraccionamiento__c> ([SELECT Id, Name, Estado_Fracc__c FROM Fraccionamiento__c WHERE Id In : fracSet]);
        }
        if(plazaSet != null && plazaSet.size()>0){
            plazaMap = new  Map<Id, Relacion_Producto_Plaza__c> ([SELECT Id,Plaza__r.Name,Producto__r.Id, Producto__r.Numero_Filtro__c  FROM Relacion_Producto_Plaza__c WHERE Id In : plazaSet]);
        }
            if(Trigger.isInsert || Trigger.isUpdate){
            for(Relacion_Producto_Fraccionamiento__c rpf : Trigger.New){
                String plazaSelecc = '';  String plaza = '';  String nombre ='';  Decimal numFiltro = 0;
                if(plazaMap.containskey(rpf.Relacion_Producto_Plaza_Fraccionamiento__c)){
                    plazaSelecc  = plazaMap.get(rpf.Relacion_Producto_Plaza_Fraccionamiento__c).Plaza__r.Name;
                    numFiltro =  plazaMap.get(rpf.Relacion_Producto_Plaza_Fraccionamiento__c).Producto__r.Numero_Filtro__c;
                    rpf.Producto__c = plazaMap.get(rpf.Relacion_Producto_Plaza_Fraccionamiento__c).Producto__r.Id;
                }
                if(fracMap.containskey(rpf.Fraccionamiento__c)){
                    plaza  = fracMap.get(rpf.Fraccionamiento__c).Estado_Fracc__c;
                    nombre =  fracMap.get(rpf.Fraccionamiento__c).Name;
                }
                rpf.Name = nombre;
                if(rpf.Vigencia_Hasta__c != null){
                    rpf.Sin_vigencia__c = false;
                }
                else{
                    rpf.Sin_vigencia__c = true;
                }
                rpf.Plaza_Filtro__c = plazaSelecc;
                rpf.Producto_Numero_Filtro__c = numFiltro;
                if(plazaSelecc != plaza){
                    rpf.addError('Validar que el fraccionamiento corresponde a la plaza');
                }
            }
        }      
    }   
    /*for(Relacion_Producto_Fraccionamiento__c rpf : Trigger.New){
List<Fraccionamiento__c> fracc = [SELECT Name, Estado_Fracc__c FROM Fraccionamiento__c WHERE Id =:rpf.Fraccionamiento__c LIMIT 1];
List<Relacion_Producto_Plaza__c> pla = [SELECT Plaza__r.Name FROM Relacion_Producto_Plaza__c WHERE Id =: rpf.Relacion_Producto_Plaza_Fraccionamiento__c LIMIT 1];
List<Relacion_Producto_Plaza__c> prod = [SELECT Producto__r.Id, Producto__r.Numero_Filtro__c FROM Relacion_Producto_Plaza__c WHERE Id =: rpf.Relacion_Producto_Plaza_Fraccionamiento__c LIMIT 1];
String plazaSelecc = '';  String plaza = '';  String nombre ='';  Decimal numFiltro = 0;

if(pla != null && pla.size()>0){
plazaSelecc = pla[0].Plaza__r.Name;
}
if(fracc != null && fracc.size()>0){
plaza = fracc[0].Estado_Fracc__c; 
nombre = fracc[0].Name;
}
if(prod != null && prod.size()>0){
numFiltro = prod[0].Producto__r.Numero_Filtro__c;
rpf.Producto__c = prod[0].Producto__r.Id;
}
rpf.Name = nombre;
if(rpf.Vigencia_Hasta__c != null){
rpf.Sin_vigencia__c = false;
}
else{
rpf.Sin_vigencia__c = true;
}
rpf.Plaza_Filtro__c = plazaSelecc;
rpf.Producto_Numero_Filtro__c = numFiltro;
if(plazaSelecc != plaza){
rpf.addError('Validar que el fraccionamiento corresponde a la plaza');
}
} */
    /*    if(Trigger.isUpdate){
for(Relacion_Producto_Fraccionamiento__c rpf : Trigger.New){
Decimal numFiltro = [SELECT Id, Name, Numero_Filtro__c FROM Product2 WHERE Id =: rpf.Producto__c LIMIT 1].Numero_Filtro__c;
Relacion_Producto_Plaza__c pla = [SELECT Plaza__r.Name, Nombre_Filtro__c FROM Relacion_Producto_Plaza__c WHERE Id =: rpf.Relacion_Producto_Plaza_Fraccionamiento__c LIMIT 1];
Fraccionamiento__c fracc = [SELECT Name, Estado_Fracc__c FROM Fraccionamiento__c WHERE Id =:rpf.Fraccionamiento__c LIMIT 1];
String plazaSelecc = fracc.Estado_Fracc__c;
String nombre = fracc.Name;
String plaza = pla.Nombre_Filtro__c;
rpf.Name = nombre;
if(rpf.Vigencia_Hasta__c != null){
rpf.Sin_vigencia__c = false;
}else{
rpf.Sin_vigencia__c = true;
}
rpf.Plaza_Filtro__c = plaza;
rpf.Producto_Numero_Filtro__c = numFiltro;
if(plazaSelecc != plaza){
rpf.addError('Validar que el fraccionamiento corresponde a la plaza');
}
}
} */
    
    if(Trigger.isAfter){
        Set<String> relset = new Set<String>();     Set<String> prodset = new Set<String>();
        for(Relacion_Producto_Fraccionamiento__c rpf : Trigger.New){
            system.debug('rpf'+rpf);
            relset.add(rpf.Relacion_Producto_Plaza_Fraccionamiento__c);
        }
        if(relset !=null && relset.size()>0){
            List<Relacion_Producto_Plaza__c> palzaProd = [SELECT Id, Producto__r.Id, Tiene_Fraccionamiento__c FROM Relacion_Producto_Plaza__c WHERE Id In : relset];
            if(Trigger.isInsert || Trigger.isUpdate){
                if(palzaProd != null && palzaProd.size()>0){
                    for(Relacion_Producto_Plaza__c p : palzaProd){
                        prodset.add(p.Producto__r.Id);
                    }
                    if(prodset != null && prodset.size()>0){
                        List<Product2> prod = [SELECT Id, Fraccionamientos__c FROM Product2 WHERE Id  In : prodset];
                        if(prod != null && prod.size()>0){
                            for(Product2 p: prod){
                                p.Fraccionamientos__c = 'Begin;';
                            }
                        }
                        update prod;
                         system.debug('prod1119'+prod);
                    }
                }
            }
            if(Trigger.isInsert){
                if(palzaProd != null && palzaProd.size()>0){
                    for(Relacion_Producto_Plaza__c p : palzaProd){
                        if(p.Tiene_Fraccionamiento__c != true){
                            p.Tiene_Fraccionamiento__c = true;
                        }
                    }
                }
                update palzaProd;
            }
        }
    }
}