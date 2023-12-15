public class CrearCasoController {
    
    public Casos_Residente__c caso {get;set;}
    public Entrega__c entrega {get;set;}
    
    public boolean showButtons {get;set;}
    public CrearCasoController(ApexPages.StandardController controller) {
        RecordType garantia = [SELECT ID, Name FROM RecordType WHERE Name = 'Servicios' LIMIT 1];
        
        caso = (Casos_Residente__c) controller.getRecord();
        caso.OwnerId = UserInfo.getUserId();
        
        String idInventario = '';
        showButtons = true;
        try{
            idInventario = ApexPages.currentPage().getParameters().get('i');
            Inventario__c i = [SELECT ID, Name, Cuenta__c,Entregada__c FROM Inventario__c WHERE Id =: idInventario];
            try{
                entrega = [SELECT Id, Name, FechaEntrega__c FROM Entrega__C WHERE Inventario__c = :i.Id ORDER BY CreatedDate DESC LIMIT 1];
            }catch(Exception o){
                
            }
            
            caso.ViviendaProceso__c = i.Id;
            caso.Cuenta__c = i.Cuenta__c;
            caso.RecordTypeId = garantia.Id;
            
            String c = i.Entregada__c; 
            if(c == 'Entregado' && c != null && c != ''){ 
                showButtons = true;
            }else{ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'La vivienda no está entregada.'));
                showButtons = false;
                //alert('La vivienda no está entregada'); 
            }
            
        }catch(Exception o){
            if(!o.getMessage().equals('List has no rows for assignment to SObject')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, o.getMessage()));
            }
        }
        
        //Cuenta y vivienda del inventario de donde se haga el caso
    }
    
    public PageReference guardar(){
        PageReference page = ApexPages.currentPage();
        List<Vencimiento__c> v = [SELECT Id, Name, VencimientoDias__c FROM Vencimiento__c  WHERE Clasificacion__c = :caso.Clasificacion__c ORDER BY CreatedDate DESC LIMIT 1];
        
        Entrega__c e = [SELECT Id, Name, FechaEntrega__c FROM Entrega__c WHERE Inventario__c =: caso.ViviendaProceso__c ORDER BY CreatedDate DESC LIMIT 1];
        
        Date fecha = e.FechaEntrega__c;
        if(!v.isEmpty()){
            fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
            caso.DiasVencimiento__c = fecha.daysBetween(System.today());
            if(fecha < (System.today())){
                caso.Garantiavencida__c = true;
                caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
            }
        }
        caso.Nomenclatura__c = caso.Tipo__c.substring(0,1) + ' - ' + caso.Clasificacion__c.substring(0,2);
        
        try{
            caso.Nomenclatura__c += ' - ' + caso.Catalagodefalla__c.substring(0,4);
        }catch(Exception o){
            
        }
        try{
        upsert caso;
        }catch(Exception o){
            
        }
        page = new PageReference('/apex/VisitaCita?caso='+ caso.Id);
        
        return page;
    }
    
}