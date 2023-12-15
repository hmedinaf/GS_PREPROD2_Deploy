@isTest
public class CPPT_Lista_Precios_Test {
    static TestMethod void Test1() {
        Fraccionamiento__c f = new Fraccionamiento__c(name = 'ACACIAS');
        insert f;
        Prototipo__c pro = new Prototipo__c(name = 'test pro',Fraccionamiento__c = f.id);
        insert pro;
        
        Prototipo__c p1 = new Prototipo__c(name = 'test1',Fraccionamiento__c = f.id);
        insert p1;
        Pricebook2 pb3 = new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today(),Vigente_Hasta__c= Date.newInstance(2023, 10, 30),
                                        Description = 'test',Prototipo__c = p1.id); 
        pb3.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Paquete').getRecordTypeId();
        insert pb3;
        Pricebook2 pb4 = new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today(),Vigente_Hasta__c= Date.newInstance(2023, 10, 30),
                                        Description = 'test',Prototipo__c = p1.id);
        pb4.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Promocion_Venta').getRecordTypeId();
        insert pb4;
        Pricebook2 pb5= new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today(),Vigente_Hasta__c= Date.newInstance(2023, 10, 30),
                                       Cantidad__c = 12, Description = 'test',Prototipo__c = p1.id);
        pb5.RecordTypeId  = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Promocion_Precio').getRecordTypeId();
        insert pb5;
        Pricebook2 pb6 = new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today(),Vigente_Hasta__c= Date.newInstance(2023, 08, 30),
                                        Estatus_Proceso_de_Venta__c = 'Formalizado',Precio_Min_Solicitado__c = 12, Precio_Min_Autorizado__c = 12,Description = 'test',
                                       Prototipo__c = p1.id);
        pb6.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Regalo_MKT').getRecordTypeId();
        
        insert pb6;
        Pricebook2 pb8 = new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today(),Vigente_Hasta__c= Date.newInstance(2023, 10, 30),
                                        Description = 'test');
        pb8.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Producto_Generico').getRecordTypeId();
        insert pb8;
        Pricebook2 pb9 = new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today(),Vigente_Hasta__c= Date.newInstance(2023, 10, 30),
                                        Porcentaje_Fianciamiento__c = 10,Description = 'test',Prototipo__c = p1.id);
        pb9.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Financiamiento').getRecordTypeId();
        insert pb9;
        // Exception cases---->
        Pricebook2 pb7 = new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = Date.newInstance(system.today().addYears(-1).year(), system.today().addMonths(-1).month(), system.today().addDays(-1).day()),
                                        Vigente_Hasta__c= Date.newInstance(2023, 10, 30),Prototipo__c = p1.id,
                                        Description = 'test');
        pb7.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Producto_Generico').getRecordTypeId();
        try{
            insert pb7;
        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        
        Pricebook2 pb0 = new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today().addMonths(-3),
                                        Vigente_Hasta__c= Date.newInstance(system.today().addYears(-1).year(), system.today().addMonths(-1).month(), system.today().addDays(-1).day()),
                                        Description = 'test',Prototipo__c = p1.id);
        pb0.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Bonificacion').getRecordTypeId();
       try{
            insert pb0;
       } catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        
        Prototipo__c p = new Prototipo__c(name = 'test',Fraccionamiento__c = f.id);
        insert p;
        
        pb3.name = 'test updated';
        pb3.Prototipo__c = p.id;
        try{
            update pb3;
       } catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        
        pb4.name = 'test updated';
        pb4.Prototipo__c = p.id;
        try{
            update pb4;
       } catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        
        pb5.name = 'test updated';
        pb5.Prototipo__c = p.id;
        pb5.Ilimitado__c = true;
        pb5.Cantidad__c = 12;
        try{
            update pb5;
       } catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        pb6.name = 'test updated';
        pb6.Prototipo__c = p.id;
        try{
            update pb6;
       } catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        pb9.name = 'test updated';
            update pb9;
           
    }
}