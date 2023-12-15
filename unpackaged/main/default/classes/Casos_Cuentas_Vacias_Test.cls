@isTest(SeeAllData=false)
public class Casos_Cuentas_Vacias_Test {
 static void setup() {
        
    }
    
    static testmethod void testMigrate3(){
        Casos_Cuentas_UPD SM3 = new Casos_Cuentas_UPD();
        Id batchId3 = Database.executeBatch(SM3,10);
       
    }
}