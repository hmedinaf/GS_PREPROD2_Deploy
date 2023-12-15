public class CLASS_RelacionPrecioProducto {
    @AuraEnabled
    public static String getRelatedList(Id recordId)
    {
        Id tipoLista = [SELECT Id, Relacion_Precio_Producto__r.Id, RecordtypeId FROM Pricebook2 WHERE Id = : recordId].RecordtypeId;
        Id idRelacion = [SELECT Id, Relacion_Precio_Producto__r.Id FROM Pricebook2 WHERE Id = : recordId].Relacion_Precio_Producto__r.Id;        
        String nombreTr = [SELECT Name FROM RecordType WHERE Id =: tipoLista].Name;
        return nombreTr;
    }
    
    @AuraEnabled
    public static list<Product2> getProductos(Id recordId){
        Id idRelacion = [SELECT Id, Relacion_Precio_Producto__r.Id FROM Pricebook2 WHERE Id = : recordId].Relacion_Precio_Producto__r.Id;
        List<PricebookEntry> pe = [Select Product2Id from PricebookEntry WHERE Pricebook2Id = :recordId];
           system.debug('pe'+pe);
        Set<String> idProds = new Set<String>();
        for(PricebookEntry ids : pe){
            idProds.add(ids.Product2Id);
        }
        List<Product2> listaProductos = [Select Id, Name, Precio_Venta__c, Precio_de_Compra__c, IVA__c, Precio_Total__c, Beneficio__c, Beneficio2__c, Precio_de_Venta_Sugerido__c, Tipo_de_producto__c from Product2 where Id in: idProds];
        return listaProductos;
    }
    
    @AuraEnabled
    public static list<Product2> getProductosVivienda(Id recordId){
        List<PricebookEntry> pe = [Select Product2Id from PricebookEntry WHERE Pricebook2Id = :recordId];
        system.debug('pe'+pe);
        Set<String> idProds = new Set<String>();
        for(PricebookEntry ids : pe){
              system.debug('pe'+ids.Product2Id);
            idProds.add(ids.Product2Id);
        }
        List<Product2> listaProductos = [Select Id, Name, Id_Externo__c, Num_Interno__c, Manzana__c, Lote__c, Num_Interior__c from Product2 where Id in: idProds];
        return listaProductos;
    }
    
    /*@AuraEnabled
    public static list<vivienda> getViviendas(){
        String IdFraccionamiento;
        String IdPrototipo;
        String IdEstatusVivienda;
        String NumInterno;
        String Direccion;
        String VigenciaUltimoAvaluo;
        String FechaUltimoAvaluo;
        String MetrosSuperficie;
        String MetrosSuperficieExcedente;
        String BanDtu;
        String BanAreaMuni;
        String BanEsquina;
        String BanFrenteParque;
        String BanSobreAvenida;
        String BanLadoSol;
        String BanLadoSombra;
        String Fideicomiso;
        String Piso;
        String Manzana;
        String Lote;
        String NumInterior;
        String BanDti;
        String BanMuestra;
        vivienda viv = new vivienda();
        vivienda viv2 = new vivienda();
        List<vivienda> listaVivienda = new List<vivienda>();
        
        String body = '{'+
            '"Dias" : 120,'+
            '"Estatus" : [ 17,11 ],'+
            '"IdVivienda" : "353341"'+
            '}';
        
        HttpRequest http_request = new HttpRequest();
        http_request.setEndpoint('https://qesb.javer.com.mx:11962/services/ManageViviendas/rest/ExtractViviendas');
        http_request.setMethod('POST');
        http_request.setHeader('Content-Type', 'application/json');
        http_request.setHeader('Authorization', 'Inherit auth from parent');
        http_request.setBody(body);
        Http http = new Http();
        HTTPResponse http_response = http.send(http_request);
        if(http_response.getStatusCode() == 200) {
            system.debug(http_response.getBody());
            JSONParser parser = JSON.createParser(http_response.getBody());
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Fraccionamiento')) {
                    parser.nextToken();
                    viv.IdFraccionamiento = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Prototipo')){
                    parser.nextToken();
                    viv.IdPrototipo = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'IdEstatusVivienda')){
                    parser.nextToken();
                    viv.IdEstatusVivienda = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'NumInterno')){
                    parser.nextToken();
                    viv.NumInterno = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Direccion')){
                    parser.nextToken();
                    viv.Direccion = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'VigenciaUltimoAvaluo')){
                    parser.nextToken();
                    viv.VigenciaUltimoAvaluo = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'FechaUltimoAvaluo')){
                    parser.nextToken();
                    viv.FechaUltimoAvaluo = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'MetrosSuperficie')){
                    parser.nextToken();
                    viv.MetrosSuperficie = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'MetrosSuperficieExcedente')){
                    parser.nextToken();
                    viv.MetrosSuperficieExcedente = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanDtu')){
                    parser.nextToken();
                    viv.BanDtu = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanAreaMuni')){
                    parser.nextToken();
                    viv.BanAreaMuni = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanEsquina')){
                    parser.nextToken();
                    viv.BanEsquina = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanFrenteParque')){
                    parser.nextToken();
                    viv.BanFrenteParque = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanSobreAvenida')){
                    parser.nextToken();
                    viv.BanSobreAvenida = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanLadoSol')){
                    parser.nextToken();
                    viv.BanLadoSol = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanLadoSombra')){
                    parser.nextToken();
                    viv.BanLadoSombra = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Fideicomiso')){
                    parser.nextToken();
                    viv.Fideicomiso = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Piso')){
                    parser.nextToken();
                    viv.Piso = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Manzana')){
                    parser.nextToken();
                    viv.Manzana = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Lote')){
                    parser.nextToken();
                    viv.Lote = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'NumInterior')){
                    parser.nextToken();
                    viv.NumInterior = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanDti')){
                    parser.nextToken();
                    viv.BanDti = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanMuestra')){
                    parser.nextToken();
                    viv.BanMuestra = parser.getText();
                }
            }
            System.debug('IdFraccionamiento ' + viv.IdFraccionamiento);
            System.debug('IdPrototipo ' + viv.IdPrototipo);
            System.debug('IdEstatusVivienda ' + viv.IdEstatusVivienda);
            System.debug('NumInterno ' + viv.NumInterno);
            System.debug('Direccion ' + viv.Direccion);
            System.debug('VigenciaUltimoAvaluo ' + viv.VigenciaUltimoAvaluo);
            System.debug('FechaUltimoAvaluo ' + viv.FechaUltimoAvaluo);
            System.debug('MetrosSuperficie ' + viv.MetrosSuperficie);
            System.debug('MetrosSuperficieExcedente ' + viv.MetrosSuperficieExcedente);
            System.debug('BanDtu ' + viv.BanDtu);
            System.debug('BanAreaMuni ' + viv.BanAreaMuni);
            System.debug('BanEsquina ' + viv.BanEsquina);
            System.debug('BanFrenteParque ' + viv.BanFrenteParque);
            System.debug('BanSobreAvenida ' + viv.BanSobreAvenida);
            System.debug('BanLadoSol ' + viv.BanLadoSol);
            System.debug('BanLadoSombra ' + viv.BanLadoSombra);
            System.debug('Fideicomiso ' + viv.Fideicomiso);
            System.debug('Piso ' + viv.Piso);
            System.debug('Manzana ' + viv.Manzana);
            System.debug('Lote ' + viv.Lote);
            System.debug('NumInterior ' + viv.NumInterior);
            System.debug('BanDti ' + viv.BanDti);
            System.debug('BanMuestra ' + viv.BanMuestra);
            
            listaVivienda.add(viv);
        }
        else {
            system.debug(http_response.getStatus() + ' ' + http_response.getStatusCode());
        }
        //+++++++++++++++++++++++ Segunda Petición +++++++++++++++++++++++++++++++++++++++++++++++++
        String body2 = '{'+
            '"Dias" : 120,'+
            '"Estatus" : [ 17,11 ],'+
            '"IdVivienda" : "8588"'+
            '}';
        
        HttpRequest http_request2 = new HttpRequest();
        http_request2.setEndpoint('https://qesb.javer.com.mx:11962/services/ManageViviendas/rest/ExtractViviendas');
        http_request2.setMethod('POST');
        http_request2.setHeader('Content-Type', 'application/json');
        http_request2.setHeader('Authorization', 'Inherit auth from parent');
        http_request2.setBody(body2);
        Http http2 = new Http();
        HTTPResponse http_response2 = http.send(http_request2);
        if(http_response2.getStatusCode() == 200) {
            system.debug(http_response.getBody());
            JSONParser parser = JSON.createParser(http_response2.getBody());
            Double grandTotal = 0.0;
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'IdFraccionamiento')) {
                    parser.nextToken();
                    viv2.IdFraccionamiento = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'IdPrototipo')){
                    parser.nextToken();
                    viv2.IdPrototipo = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'IdEstatusVivienda')){
                    parser.nextToken();
                    viv2.IdEstatusVivienda = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'NumInterno')){
                    parser.nextToken();
                    viv2.NumInterno = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Direccion')){
                    parser.nextToken();
                    viv2.Direccion = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'VigenciaUltimoAvaluo')){
                    parser.nextToken();
                    viv2.VigenciaUltimoAvaluo = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'FechaUltimoAvaluo')){
                    parser.nextToken();
                    viv2.FechaUltimoAvaluo = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'MetrosSuperficie')){
                    parser.nextToken();
                    viv2.MetrosSuperficie = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'MetrosSuperficieExcedente')){
                    parser.nextToken();
                    viv2.MetrosSuperficieExcedente = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanDtu')){
                    parser.nextToken();
                    viv2.BanDtu = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanAreaMuni')){
                    parser.nextToken();
                    viv2.BanAreaMuni = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanEsquina')){
                    parser.nextToken();
                    viv2.BanEsquina = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanFrenteParque')){
                    parser.nextToken();
                    viv2.BanFrenteParque = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanSobreAvenida')){
                    parser.nextToken();
                    viv2.BanSobreAvenida = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanLadoSol')){
                    parser.nextToken();
                    viv2.BanLadoSol = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanLadoSombra')){
                    parser.nextToken();
                    viv2.BanLadoSombra = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Fideicomiso')){
                    parser.nextToken();
                    viv2.Fideicomiso = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Piso')){
                    parser.nextToken();
                    viv2.Piso = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Manzana')){
                    parser.nextToken();
                    viv2.Manzana = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'Lote')){
                    parser.nextToken();
                    viv2.Lote = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'NumInterior')){
                    parser.nextToken();
                    viv2.NumInterior = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanDti')){
                    parser.nextToken();
                    viv2.BanDti = parser.getText();
                }else if((parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'BanMuestra')){
                    parser.nextToken();
                    viv2.BanMuestra = parser.getText();
                }
            }
            System.debug('IdFraccionamiento ' + viv2.IdFraccionamiento);
            System.debug('IdPrototipo ' + viv2.IdPrototipo);
            System.debug('IdEstatusVivienda ' + viv2.IdEstatusVivienda);
            System.debug('NumInterno ' + viv2.NumInterno);
            System.debug('Direccion ' + viv2.Direccion);
            System.debug('VigenciaUltimoAvaluo ' + viv2.VigenciaUltimoAvaluo);
            System.debug('FechaUltimoAvaluo ' + viv2.FechaUltimoAvaluo);
            System.debug('MetrosSuperficie ' + viv2.MetrosSuperficie);
            System.debug('MetrosSuperficieExcedente ' + viv2.MetrosSuperficieExcedente);
            System.debug('BanDtu ' + viv2.BanDtu);
            System.debug('BanAreaMuni ' + viv2.BanAreaMuni);
            System.debug('BanEsquina ' + viv2.BanEsquina);
            System.debug('BanFrenteParque ' + viv2.BanFrenteParque);
            System.debug('BanSobreAvenida ' + viv2.BanSobreAvenida);
            System.debug('BanLadoSol ' + viv2.BanLadoSol);
            System.debug('BanLadoSombra ' + viv2.BanLadoSombra);
            System.debug('Fideicomiso ' + viv2.Fideicomiso);
            System.debug('Piso ' + viv2.Piso);
            System.debug('Manzana ' + viv2.Manzana);
            System.debug('Lote ' + viv2.Lote);
            System.debug('NumInterior ' + viv2.NumInterior);
            System.debug('BanDti ' + viv2.BanDti);
            System.debug('BanMuestra ' + viv2.BanMuestra);
            
            listaVivienda.add(viv2);
        }
        else {
            system.debug(http_response2.getStatus() + ' ' + http_response2.getStatusCode());
        }
       return listaVivienda;
    }*/
    
    /*@AuraEnabled
    public static Proveedor__c creaProveedor(Proveedor__c ac, String prod){
        ac.Producto__c = prod;
        insert ac;
        return ac;
    }*/
    
    /*public class vivienda {
        @AuraEnabled
        public String IdFraccionamiento {get; set;}
        @AuraEnabled
        public String IdPrototipo {get; set;}
        @AuraEnabled
        public String IdEstatusVivienda {get; set;}
        @AuraEnabled
        public String NumInterno {get; set;}
        @AuraEnabled
        public String Direccion {get; set;}
        @AuraEnabled
        public String VigenciaUltimoAvaluo {get; set;}
        @AuraEnabled
        public String FechaUltimoAvaluo {get; set;}
        @AuraEnabled
        public String MetrosSuperficie {get; set;}
        @AuraEnabled
        public String MetrosSuperficieExcedente {get; set;}
        @AuraEnabled
        public String BanDtu {get; set;}
        @AuraEnabled
        public String BanAreaMuni {get; set;}
        @AuraEnabled
        public String BanEsquina {get; set;}
        @AuraEnabled
        public String BanFrenteParque {get; set;}
        @AuraEnabled
        public String BanSobreAvenida {get; set;}
        @AuraEnabled
        public String BanLadoSol {get; set;}
        @AuraEnabled
        public String BanLadoSombra {get; set;}
        @AuraEnabled
        public String Fideicomiso {get; set;}
        @AuraEnabled
        public String Piso {get; set;}
        @AuraEnabled
        public String Manzana {get; set;}
        @AuraEnabled
        public String Lote {get; set;}
        @AuraEnabled
        public String NumInterior {get; set;}
        @AuraEnabled
        public String BanDti {get; set;}
        @AuraEnabled
        public String BanMuestra {get; set;}
    }*/
}