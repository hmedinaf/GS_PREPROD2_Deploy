@isTest
public class CustomLookup_Test {
    @isTest
    public static void testSearchDB() {
        Account acc = new Account();
        acc.name= 'TEST';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819'; 
        acc.Apellidomaterno_cta__c = 'materno';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        User result1 = CustomLookup.fetchUser();
        String result = CustomLookup.searchDB('Account', 'false', 'Name', 'Id', 'Name', 'Test');
        CustomLookup.ResultWrapper[] resultList = (CustomLookup.ResultWrapper[]) JSON.deserialize(result, CustomLookup.ResultWrapper[].class);
        System.assertEquals(1, resultList.size());
        CustomLookup.ResultWrapper obj = resultList[0];
        System.assertEquals('Account', obj.objName);
        System.assertEquals('TEST', obj.Name);
        System.assertEquals(acc.Id, obj.Id);
    }
}