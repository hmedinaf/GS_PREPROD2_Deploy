@isTest(SeeAllData=false)
public class Test_ChecklistMigration {
    
    static void setup() {
        
    }
    
    static testmethod void test() {        
        Checklist_Migration SM = new Checklist_Migration();
        Id batchId = Database.executeBatch(SM,10);
    }
}