@isTest
public class Relacion_Fraccionamiento_Test {
	static TestMethod void Test1() {
        Product2 p = new Product2();
        p.name = 'pro';
        p.Precio_Venta__c = 12;
        p.Description = 'Description';
        insert p;
        
        Plaza__c plaza = new Plaza__c();
        plaza.name = 'Querétaro';
        insert plaza;
        
        Proveedor__c Proveedor = new Proveedor__c();
        Proveedor.name = 'Proveedor';
        Proveedor.Rfc__c = 'Rfc';
        Proveedor.Contacto__c = 'Contacto';
        Proveedor.Correo__c = 'test@abc.com';
        Proveedor.Nombre_Comercial__c = 'Nombre_Comercial';
        insert Proveedor;
        
        Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c();
        prov.Producto__c =  p.id;
        prov.Proveedor__c = Proveedor.id;
        insert prov;
        
        Relacion_Producto_Plaza__c rP = new Relacion_Producto_Plaza__c(); 
        rP.Producto__c = p.id;
        rP.Plaza__c = plaza.id;
        insert rP;
        
        Fraccionamiento__c f = new Fraccionamiento__c();
        f.name = 'Fraccionamiento';
        f.Estado_fracc__c = plaza.Name;
        insert f;
            
        Relacion_Producto_Fraccionamiento__c frac = new Relacion_Producto_Fraccionamiento__c();
        frac.name = 'test frac';
        frac.Producto__c = p.id;
        frac.Relacion_Producto_Plaza_Fraccionamiento__c = rP.id;
        frac.Fraccionamiento__c = f.id;
        insert frac;
        
        Relacion_Producto_Fraccionamiento__c frac1 = new Relacion_Producto_Fraccionamiento__c();
        
    	Test.startTest();
        Relacion_Fraccionamiento.fetchPlaza(rP.id);
		Relacion_Fraccionamiento.saveFraccRecord(frac,rP.id,p.id,true);
        Relacion_Fraccionamiento.saveFraccRecord(frac1,rP.id,p.id,true);
        Relacion_Plaza.saveRecord(plaza.id,p.id);
        Relacion_Plaza.saveRecord(rP.id,p.id);
        Relacion_Proveedor.saveRecord(plaza.id,p.id);
        Relacion_Proveedor.saveRecord(Proveedor.id,p.id);
        Test.stopTest();
    }
}