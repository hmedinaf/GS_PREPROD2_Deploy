@isTest(SeeAllData=false)
public class Test_Survey8 {
    static void setup() {
        
    }
    
    static testmethod void testMigrate8(){
        Survey_Migration_Schedule SMD = new Survey_Migration_Schedule();
        SMD.execute(null);
    }
}