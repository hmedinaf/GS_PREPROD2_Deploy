public class CPPT_Clonar_producto {
    
    public Id idProd {get; set;}
    
    
    //constructor para obtener el registro del producto
    public CPPT_Clonar_producto(ApexPages.StandardController controller) {
        idProd = controller.getId();
    }
    
    public PageReference clonarProducto() {
        System.debug('+++Id Producto: ' + idProd);
        String idNuevoProd = creaProducto(idProd);
        PageReference pageRef = new PageReference('/'+idNuevoProd);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public static String creaProducto(String idProd){
        
        //Se obtienen los registros relacionados
        List<Relacion_Precio_Proveedor__c> rsProveedores = [SELECT Id, Proveedor__c  FROM Relacion_Precio_Proveedor__c WHERE Producto__c =: idProd];
        List<Relacion_Producto_Plaza__c> rsPlazas = [SELECT Id, Plaza__c  FROM Relacion_Producto_Plaza__c WHERE Producto__c =: idProd];
        Set<Id> idFraccionamientos = new Set<Id>();
        for(Relacion_Producto_Plaza__c rpf : rsPlazas){
            idFraccionamientos.add(rpf.Id);
        }
        List<Relacion_Producto_Fraccionamiento__c> rsFraccionamientos = [SELECT Id, Fraccionamiento__c  FROM Relacion_Producto_Fraccionamiento__c WHERE Relacion_Producto_Plaza_Fraccionamiento__c IN: idFraccionamientos];
        
        Product2 prod = [SELECT Id, Name,
                         Activo__c, IsActive, Beneficio__c, Codigo_de_Producto__c, ProductCode, Description, Direccion__c, Family, Codigo_de_Producto_Javer__c, ExternalId,
                         Id_Externo__c, Inactivo__c, IVA__c, Lote__c, Manzana__c, Marca__c, Num_Interior__c, Num_Interno__c, Plaza__c, Precio_de_Compra__c, Precio_de_Venta_Sugerido__c,
                         Precio_Total__c, Precio_Venta__c, StockKeepingUnit, Tipo_de_Producto__c, RecordTypeId, QuantityUnitOfMeasure, Unidad_Privada__c, DisplayUrl, Vigencia_Hasta__c
                         FROM Product2 WHERE Id =: idProd];
        
        Product2 nuevoProd = new Product2();
        nuevoProd.Name = prod.Name + '_copia';
        nuevoProd.Activo__c = prod.Activo__c;
        nuevoProd.IsActive = prod.IsActive;
        nuevoProd.Beneficio__c = prod.Beneficio__c;
        nuevoProd.ProductCode = prod.ProductCode;
        nuevoProd.Description= prod.Description;
        nuevoProd.Direccion__c = prod.Direccion__c;
        nuevoProd.Family = prod.Family;
        nuevoProd.Codigo_de_Producto_Javer__c = prod.Codigo_de_Producto_Javer__c;
        nuevoProd.ExternalId = prod.ExternalId;
        nuevoProd.Id_Externo__c = prod.Id_Externo__c;
        nuevoProd.Inactivo__c = prod.Inactivo__c;
        nuevoProd.IVA__c = prod.IVA__c;
        nuevoProd.Lote__c = prod.Lote__c;
        nuevoProd.Manzana__c = prod.Manzana__c;
        nuevoProd.Marca__c = prod.Marca__c;
        nuevoProd.Num_Interior__c = prod.Num_Interior__c;
        nuevoProd.Num_Interno__c = prod.Num_Interno__c;
        nuevoProd.Plaza__c = prod.Plaza__c;
        nuevoProd.Precio_de_Compra__c = prod.Precio_de_Compra__c;
        nuevoProd.Precio_Venta__c = prod.Precio_Venta__c;
        nuevoProd.StockKeepingUnit = prod.StockKeepingUnit;
        nuevoProd.Tipo_de_Producto__c = prod.Tipo_de_Producto__c;
        nuevoProd.RecordTypeId = prod.RecordTypeId;
        nuevoProd.QuantityUnitOfMeasure = prod.QuantityUnitOfMeasure;
        nuevoProd.Unidad_Privada__c = prod.Unidad_Privada__c;
        nuevoProd.DisplayUrl = prod.DisplayUrl;
        nuevoProd.Vigencia_Hasta__c = prod.Vigencia_Hasta__c;
        
        
        insert nuevoProd;
        System.debug('Se inserta nuevo producto');
        
        List<Relacion_Precio_Proveedor__c> proveedoresAsignar = new List<Relacion_Precio_Proveedor__c>();
        for(Relacion_Precio_Proveedor__c idProv: rsProveedores){
            Relacion_Precio_Proveedor__c newProv = New Relacion_Precio_Proveedor__c();
            newProv.Proveedor__c = idProv.Proveedor__c;
            newProv.Producto__c = nuevoProd.Id;
            proveedoresAsignar.add(newProv);
        }
        System.debug('proveedoresAsignar: ' + proveedoresAsignar);
       
        
        List<Relacion_Producto_Plaza__c> plazasAsignar = new List<Relacion_Producto_Plaza__c>();
        for(Relacion_Producto_Plaza__c idPlaza: rsPlazas){
            Relacion_Producto_Plaza__c newPlaza = New Relacion_Producto_Plaza__c();
            newPlaza.Plaza__c = idPlaza.Plaza__c;
            newPlaza.Producto__c = nuevoProd.Id;
            plazasAsignar.add(newPlaza);
        }
        System.debug('plazasAsignar: ' + plazasAsignar);
        
        /*List<Relacion_Producto_Fraccionamiento__c> fraccionamientosAsignar = new List<Relacion_Producto_Fraccionamiento__c>();
        for(Relacion_Producto_Fraccionamiento__c idFracc: rsFraccionamientos){
            Relacion_Producto_Fraccionamiento__c newFrac = New Relacion_Producto_Fraccionamiento__c();
            newFrac.Fraccionamiento__c = idFracc.Fraccionamiento__c;
            newFrac.Producto__c = nuevoProd.Id;
            fraccionamientosAsignar.add(newFrac);
        }
        System.debug('fraccionamientosAsignar: ' + fraccionamientosAsignar);*/
        
        insert proveedoresAsignar;
        System.debug('Se asignan proveedores a nuevo producto ');
        insert plazasAsignar; 
        System.debug('Se asignan plazas a nuevo producto ');
        /*insert fraccionamientosAsignar; 
        System.debug('Se asignan fraccionamientos a nuevo producto ');*/
        
        return nuevoProd.Id;
    }
}