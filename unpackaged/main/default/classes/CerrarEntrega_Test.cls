@IsTest
public class CerrarEntrega_Test {
    @IsTest
    static void testCerrarEntrega() {
        Account ac = new Account();
        ac.name= 'CUENTA ASIGNACION GENERICA';
        ac.Phone = '+528119928819';
        ac.Otro_Telefono__c = '+528119928819'; 
        ac.Apellidomaterno_cta__c = 'materno';
        ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert ac;
        Contact con = new Contact(LastName ='Test Contact',AccountId = ac.Id, email='test@test.com');
        insert con; 
        Entrega__c entrega = new Entrega__c();
        entrega.Name = 'Test Entrega';
        entrega.Estatus__c = 'Entregado';
        insert entrega;
        Inventario__c inventario = new Inventario__c();
        inventario.Name = 'Test Inventario';
        insert inventario;
        ContentVersion conVer = new ContentVersion();
        conVer.FirstPublishLocationId = entrega.Id; 
        conVer.PathOnClient = 'test.txt';
        conVer.Title = 'test';
        conVer.VersionData = EncodingUtil.base64Decode('test     ====');
        insert conVer;
        ApexPages.StandardController controller = new ApexPages.StandardController(entrega);
        CerrarEntrega cerrarEntrega = new CerrarEntrega(controller);
        Test.startTest();
        cerrarEntrega.run();
        Test.stopTest();
        
       // System.assertEquals('Entregado', entrega.Estatus__c);
       // System.assertEquals('Entregado', inventario.Entregada__c);
        
    }
}