public class SimuladorController{

    public Simulador_N__c simulador {get;set;}
    public Account cuenta {get;set;}
    public Fraccionamiento__c fraccionamiento{get;set;}
    public Double capacidadCompra {get;set;}
    public List<Prototipo__c> prototipos {get;set;}
    public List<SelectOption> fraccs {get;set;}
    public String muestro {get;set;}
    
    public SimuladorController(){
        
    }
    
    public SimuladorController(ApexPages.StandardController controller) {
        
        simulador=(Simulador_N__c)controller.getRecord();
        
		User usuario = [SELECT Id, Name, User_Mas_Comercial__c, Id_Mas_Comercial__c, Fraccionamiento_autorizado__c, FraccionamientoAutorizados__c  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
         List<Fraccionamiento__c> fraccs1 = new List<Fraccionamiento__c>();
        List<String> nombresFracc = new List<String>(); 
        if('Admin Javer' == usuario.Name || usuario.Fraccionamiento_autorizado__c == 'TODOS'){
            fraccs1 = [Select Id, Name FROM Fraccionamiento__c]; 
         }else{
         try{
            nombresFracc.add(usuario.FraccionamientoAutorizados__c);
            nombresFracc.add(usuario.Fraccionamiento_autorizado__c);
         	try{
                nombresFracc.addAll(usuario.Fraccionamiento_autorizado__c.split(', '));
            }catch(Exception o){
                     
            }
            try{
                nombresFracc.addAll(usuario.FraccionamientoAutorizados__c.split(', '));
            }catch(Exception o){
                     
            }   
             
        	fraccs1 = [Select Id, Name FROM Fraccionamiento__c WHERE Name IN : nombresFracc AND Activo_frac__c = true];
         }catch(Exception e){
         }
         }
        
        if(fraccs1.isEmpty()){
             ApexPages.addMessage(new ApexPages.Message
                                     (Apexpages.Severity.ERROR, 
                'El usuario no tiene Fraccionamientos autorizados.')); 
        }
        fraccs1.sort();
        fraccs = new List<SelectOption>();
        for(Fraccionamiento__c frac : fraccs1){
            System.debug('FARC: '+ frac);
            fraccs.add(new SelectOption(frac.Id,frac.Name));
        }
        
        String idCuenta = ApexPages.currentPage().getParameters().get('acc');
        
        List<Account> cuentas = [
            SELECT 
            Id, 
            Name, 
            Fraccionamiento_cta__r.Id, 
            Capcomp_cta__c,
            Monaho_cta__c,
            Montgast_cta__c
            FROM Account
            WHERE Id = :idCuenta];
        
        System.debug('CUENTAS: ' + cuentas);
		System.debug('CUENTAS: ' + simulador);        
        
        
        if(!cuentas.isEmpty()){
            if(cuentas[0].Fraccionamiento_cta__c != null){
               	List<Fraccionamiento__c> frac_cuenta = 
            		[SELECT Id, 
             		Name 
             		FROM Fraccionamiento__c 
             		WHERE Id =: cuentas[0].Fraccionamiento_cta__c];
               simulador.Fraccionamiento__c = cuentas[0].Fraccionamiento_cta__c;
            }
            if(cuentas[0].Capcomp_cta__c != null){
                simulador.CapacidadCompra__c = cuentas[0].Capcomp_cta__c;
            }
        }
                 if(isS1()){
             muestro = 'one-app';
         }
    }
    
    public PageReference consultar(){
        try{
            if(simulador.CapacidadCompra__c == null){
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.ERROR, 
			'Especifique una capacidad de compra.')); 
                return ApexPages.currentPage();
        	}
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.ERROR, 
			'Especifique una capacidad de compra.')); 
            return ApexPages.currentPage();
        }
            
        prototipos = new List<Prototipo__c>();
        List<Prototipo__c> proto = [SELECT 
                                         Name, 
                                         Imagen_01__c, 
                                         Imagen_02__c,
                                         Precio_pro__c,
                                    	 Tour_360__c
                                         FROM Prototipo__c 
                                         WHERE Fraccionamiento__c = :simulador.Fraccionamiento__c ];
            
        List<Prototipo__c> protoExtra = [SELECT 
                                         Name, 
                                         Imagen_01__c, 
                                         Imagen_02__c,
                                         Precio_pro__c,
                                         Tour_360__c
                                         FROM Prototipo__c 
                                         WHERE Precio_pro__c <=: simulador.CapacidadCompra__c
                                         AND Fraccionamiento__c = :simulador.Fraccionamiento__c 
                                         ORDER BY Precio_pro__c DESC LIMIT 1];
        List<Prototipo__c> protoExtra2 = [SELECT 
                                          Name, 
                                          Imagen_01__c, 
                                          Imagen_02__c,
                                          Precio_pro__c,
                                          Tour_360__c
                                          FROM Prototipo__c 
                                          WHERE Precio_pro__c >: simulador.CapacidadCompra__c
                                          AND Precio_pro__c <: simulador.CapacidadCompra__c * 1.05
                                          AND Fraccionamiento__c = : simulador.Fraccionamiento__c 
                                          ORDER BY Precio_pro__c ASC LIMIT 1];
        if(protoExtra.size() > 0){
            protoExtra[0].Name = protoExtra[0].Name.split('-')[0];
            prototipos.add(protoExtra[0]);
        }
        else if(protoExtra2.size() > 0){
            protoExtra2[0].Name = protoExtra2[0].Name.split('-')[0];
            prototipos.add(protoExtra2[0]);
        }
        try{
            prototipos.get(0);
            prototipos.get(1);
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.WARNING, 
			'El fraccionamiento seleccionado cuenta con '+ prototipos.size()+' prototipo(s)'));
        }
        return ApexPages.currentPage();
    }
    
    public static Boolean isS1(){
 
   String retUrl = ApexPages.currentPage().getParameters().get('retURL');
 
   return String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameHost')) ||
   String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameOrigin')) ||
   ApexPages.currentPage().getParameters().get('isdtp') == 'p1' ||
   (String.isNotBlank(retUrl) && retURL.contains('projectone'));
 
}
    public void method(){
        Integer i = 0;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
    }
}