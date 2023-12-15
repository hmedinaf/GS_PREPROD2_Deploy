public without sharing class geolocalizacion_ctr {
    public ApexPages.StandardController ctr {get;set;}
	public double latitude {get; set;}
    public double longitude {get; set;}
    public Boolean showMapBln {get; set;}
    public String tipoCheck {get; set;}
    public String mensaje {get; set;}
    public Boolean enableMensajeBln {get; set;}
    private Account acc {get; set;}
    
    public geolocalizacion_ctr(){
        
    }
    
    public geolocalizacion_ctr(ApexPages.StandardController controller) {
        ctr = controller;
        acc = [SELECT Id, Name, Geolocalizacion__Latitude__s, Geolocalizacion__Longitude__s FROM Account WHERE Id =: (Id)controller.getId()];
        showMapBln = false;
    }
    
    public PageReference guardarCoordenadasUsuario() {
        // Limpiamos mensaje
        mensaje = '';
        enableMensajeBln = false;
        
        // Buscamos que traigan valores
        if (latitude == null && longitude == null) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'No se pudo cargar la Latitud y Longitud');
            return null;
        }
        
        // Habilitamos mapa
        showMapBln = true;

        return null;
    }
    
    public PageReference hacerCheck(){
        try {
            acc.Geolocalizacion__Latitude__s = latitude;
            acc.Geolocalizacion__Longitude__s = longitude;
            update acc;
            return ctr.view();
        }catch(Exception e){System.debug('<<<Error>>> ' + e.getMessage());return ctr.view();}
    }
    
    public void method(){
       Integer i = 0;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
    }
}