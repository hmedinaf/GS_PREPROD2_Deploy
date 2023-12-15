public class ReporteAtnController {
    public Casos_Residente__c caso{get;set;}
    public User propietario {get;set;}
    public Inventario__c vivienda {get;set;}
    public Account residente {get;set;}
    public id conjuntoId {get;set;}
    public String fv {get;set;}
    public String f {get;set;}
    public String d {get;set;}
    public String m {get;set;}
    public String a {get;set;}
    public String filename {get;set;}
    public boolean show {get;set;}
    
    public List<Casos_Residente__c> listCasos {get;set;}
    public Conjunto_Casos__c conjunto {get;set;}
    public void prepare(){
        if(caso.Conjunto_Casos__c == null){
            System.debug('listCasos'+listCasos);
            for(Casos_Residente__c casoTemp : listCasos){
                System.debug('casoTemp'+casoTemp);
                if(casoTemp.Conjunto_Casos__c != null){
                    conjuntoId = caso.Conjunto_Casos__c;
                }
            }
            
            if(conjuntoId == null){
                conjunto = new Conjunto_Casos__c();
                insert conjunto;
            }else{
                conjunto = new Conjunto_Casos__c(Id=conjuntoId);
            }
            
            for(Casos_Residente__c casoTemp : listCasos){
                if(casoTemp.Status__c != 'Asignado' && casoTemp.Status__c != 'En proceso' && casoTemp.Status__c != 'No procede'){
                    casoTemp.Conjunto_Casos__c = conjunto.Id;
                }
            }
            
            update listCasos;
        }
    }
    
    public ReporteAtnController(){
        show = true;
        Date fechaCierre;
        String casoId = Apexpages.currentPage().getparameters().get('id');
        caso = [SELECT Id, Fecha_Programada_de_Visita__c, OwnerId, ContactMobile__c, ContactEmail__c, 
                ViviendaProceso__c, Name, Cuenta__c, Detalledelreporte__c, Conjunto_Casos__c, Fecha_Cierre_Cancelacion__c 
                FROM Casos_Residente__c WHERE Id =: casoId];
        
        listCasos = [SELECT Id, Status__c, OwnerId, ContactMobile__c, ContactEmail__c, ViviendaProceso__c, Name, Cuenta__c, Detalledelreporte__c, Conjunto_Casos__c, Fecha_Programada_de_Visita__c
                     FROM Casos_Residente__c WHERE ViviendaProceso__c =: caso.ViviendaProceso__c AND Fecha_Programada_de_Visita__c =: caso.Fecha_Programada_de_Visita__c AND Fecha_Programada_de_Visita__c != null];
        
        List<Conjunto_Visitas__c> conjuntosVisitas = [SELECT Id, Caso_ATC__c, Estatus__c, Cita_Visita__r.Fechaprogramadadevisita__c FROM Conjunto_Visitas__c WHERE Caso_ATC__c IN: listCasos ORDER BY Cita_Visita__r.Fechaprogramadadevisita__c LIMIT 1];
        system.debug('conjuntosVisitas'+conjuntosVisitas);
        if(!conjuntosVisitas.isEmpty()){
            fechaCierre = conjuntosVisitas[0].Cita_Visita__r.Fechaprogramadadevisita__c;
        }else{
            List<Visita__c> visitas = [SELECT Id, CasoResidente__c, Estatus__c, Fechaprogramadadevisita__c FROM Visita__c WHERE CasoResidente__c IN: listCasos ORDER BY Fechaprogramadadevisita__c LIMIT 1];
            if(!visitas.isEmpty()){
                fechaCierre = visitas[0].Fechaprogramadadevisita__c;
            }else{
                show = false;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se necesita una cita programada para descargar el folio.'));      
                isS1(); 
            }
        }
        
        try{
            d = fechaCierre.day()+'';  m = fechaCierre.month()+''; a = fechaCierre.year()+'';
            propietario = [SELECT Name FROM User WHERE Id=:caso.OwnerId];
            residente = [SELECT Name,Phone,CorreoElectronico__c FROM Account WHERE Id=:caso.Cuenta__c];
            vivienda = [SELECT Manzana__c,Lote__c,Sector__c,Unidad_privativa__c,FechaEntrega__c,Fracc__r.Name,Cuenta__r.Name,MLI__c,Direccionoficial__c,Interior__c FROM Inventario__c WHERE Id=:caso.ViviendaProceso__c];
            try{
                f = vivienda.FechaEntrega__c.day() + '-' + vivienda.FechaEntrega__c.month() + '-' + vivienda.FechaEntrega__c.year();
                
                //AggregateResult visita = [SELECT MAX(Fechaprogramadadevisita__c) FROM Visita__c WHERE CasoResidente__c =:casoId][0];
                //Date fechaVisita = (Date)visita.get('expr0');
                //fv = fechaVisita.day() + '-' + fechaVisita.month() + '-' + fechaVisita.year();
            }
            catch(Exception o){     }
            filename = 'filename=Reporte_'+caso.Name+'.pdf';
            if(isS1()){
                Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment;' + filename);
            }else{
                Apexpages.currentPage().getHeaders().put('content-disposition', filename);   
            }
            filename = 'filename=Reporte_'+caso.Name+'.pdf';
            Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment;' + filename);
        } catch(Exception e){
            show = false;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ''));
            isS1();
        }
    }
    
    public static Boolean isS1(){ 
        String retUrl = ApexPages.currentPage().getParameters().get('retURL');
        return String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameHost')) ||
            String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameOrigin')) ||
            ApexPages.currentPage().getParameters().get('isdtp') == 'p1' ||
            (String.isNotBlank(retUrl) && retURL.contains('projectone'));
    }
    
    /* public void testClassMethod(){
String i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
i = 'test';
}*/
}