public class ActasInventarioController {
    public String residenteName {get;set;} 
    public Inventario__c inv {get;set;}
    public Ecotecnologia__c ECO {get;set;}
    public Account cuenta {get;set;}
    public User residente {get;set;}
    public Entrega__c entrega {get;set;}
    public String fechaHoy {get;set;}
    public String filename {get;set;}
    public String idInven;
    public Boolean download;
    public Blob pdfBlob;
    public Attachment a {get;set;}
    public boolean isMobile {get;set;}
    public ActasInventarioController(){
        residente = new User();
        fechaHoy = System.today().format();
        isMobile = UserInfo.getUiTheme() == 'Theme4t';
        idInven = Apexpages.currentPage().getparameters().get('id');
        try{
            download = Boolean.valueOf(Apexpages.currentPage().getparameters().get('download'));
        }catch(Exception e){
            download = False;            
        }
        System.debug('ID -- ' + idInven);
        residenteName = UserInfo.getName();
        List<Inventario__c> inventarios = 
            [SELECT 
             Id,
             Fraccionamiento__c,
             Prototipo__c,
             Condominio__c, 
             Cuenta__c, 
             Manzana__c, 
             Lote__c, 
             NumeroInterior__c,
             Interior__c,
             Unidad_privativa__c, 
             Direccionoficial__c,
             NumeroProceso__c,
             FechaActas__c
             FROM Inventario__c 
             WHERE Id = :idInven];
        
        List<Visita__c> visita = [SELECT Id, Name, OwnerId FROM Visita__c WHERE Inventario__c = :inventarios.get(0).Id ORDER BY CreatedDate DESC LIMIT 1];
        
        if(!visita.isEmpty()){
            residente = [SELECT Id, Name FROM User 
                         WHERE Id = :visita.get(0).OwnerId ];
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'El inventario no tiene visitas'));
        }
        
        if(!inventarios.isEmpty()){
            inv = inventarios.get(0);
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'La Entrega no tiene un inventario definido'));
        }
        
        cuenta = [SELECT Name, Nombre_cta__c, Apellidomaterno_cta__c, Apellidopaterno_cta__c, Empresa__c FROM Account WHERE Id = :inv.Cuenta__c];
        
        try{
            ECO = [SELECT Id, AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                   CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                   FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                   Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                   PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                   InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                   ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                   FROM Ecotecnologia__c WHERE Proceso_ATC__c =: inv.Id LIMIT 1];
        }catch(Exception e){
            System.debug('SIN ACTA PATC ID');
            try{
                String EcoName = inv.Prototipo__c + ' - ' + inv.Fraccionamiento__c + ' - ' + cuenta.Name;
                Integer maxSize = 79;
                if(EcoName.length() > maxSize ){
                    EcoName = EcoName.substring(0, maxSize);
                }
                ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                       CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                       FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                       Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                       PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                       InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                       ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                       FROM Ecotecnologia__c WHERE Name =: EcoName LIMIT 1];
            }catch(Exception er){
                System.debug('SIN ACTA PROTO - FRACC - NAME');
                try{
                    ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                           CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                           FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                           Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                           PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                           InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                           ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                           FROM Ecotecnologia__c WHERE Name =: inv.Prototipo__c + ' - ' + inv.Fraccionamiento__c LIMIT 1];
                }catch(Exception ex){
                    System.debug('SIN ACTA PROTO - FRACC');
                    ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                           CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                           FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                           Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                           PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                           InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                           ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                           FROM Ecotecnologia__c WHERE Name =: 'default' LIMIT 1];
                    system.debug(ex);
                }
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Porfavor realice el prellenado del acta de este Prototipo - Fraccionamiento'));
                system.debug(er);
            }
            System.debug(e);
        }
        
        String nombrec = 
            cuenta.Nombre_cta__c.toUpperCase() + ' ' 
            + cuenta.Apellidopaterno_cta__c.toUpperCase() + ' ' 
            + cuenta.Apellidomaterno_cta__c.toUpperCase();
        
        filename = 'filename=' + inv.Manzana__c + '-' +inv.Lote__c + '-' + nombrec + '_' + inv.NumeroProceso__c + '.pdf';
        //Manzana-lote-nombreCliente_num proceso
        if(isS1()){
            Apexpages.currentPage().getHeaders().put('content-disposition', '' + filename);
        }else{
            Apexpages.currentPage().getHeaders().put('content-disposition', filename);   
        }
        
        if(download){
            Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + inv.Manzana__c + '-' +inv.Lote__c + '-' + nombrec + '_' + inv.NumeroProceso__c + '.pdf');
        }else{
            Apexpages.currentPage().getHeaders().put('content-disposition', 'filename=' + inv.Manzana__c + '-' +inv.Lote__c + '-' + nombrec + '_' + inv.NumeroProceso__c + '.pdf');
        }
    }
    
    public static Boolean isS1(){
        
        String retUrl = ApexPages.currentPage().getParameters().get('retURL');
        
        return String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameHost')) ||
            String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameOrigin')) ||
            ApexPages.currentPage().getParameters().get('isdtp') == 'p1' ||
            (String.isNotBlank(retUrl) && retURL.contains('projectone'));
        
    }
    
    public pagereference PDFActa(){
        try{
            if(true){
                return null;
            }/*
String nombrec = 
cuenta.Nombre_cta__c.toUpperCase() + ' ' 
+ cuenta.Apellidopaterno_cta__c.toUpperCase() + ' ' 
+ cuenta.Apellidomaterno_cta__c.toUpperCase();
PageReference pdfPage = Page.actas_Inventario;
pdfPage.getParameters().put('Id',idInven);
pdfBlob = pdfPage.getContent();
String nombre = inv.Manzana__c + '-' +inv.Lote__c + '-' + nombrec + '_' + inv.NumeroProceso__c + '.pdf';

List<Attachment> resultado = [SELECT Id FROM Attachment WHERE Name = :nombre];
a = new Attachment(parentId = idInven, name= nombre, body = pdfBlob);
try{
if(resultado.size() > 1){
delete resultado;
}else if(resultado.size() == 1){
a.Id = resultado.get(0).id;
}
}catch(Exception o){

}
system.debug(a);
upsert a;*/
            return new PageReference('/' + a.Id);
        }catch(Exception e){
            System.debug('----ERROR----'+e.getMessage());
            return null;
        }
    }
}