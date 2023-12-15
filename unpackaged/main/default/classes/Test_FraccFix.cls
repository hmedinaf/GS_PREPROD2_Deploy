@isTest(SeeAllData=false)
public class Test_FraccFix {
    
    static void setup() {
        
    }
    
    static testmethod void test() {        
        FraccFix SM = new FraccFix();
        Id batchId = Database.executeBatch(SM,10);
    }
}