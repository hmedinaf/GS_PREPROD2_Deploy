@isTest
private class TaskProcessorTest {
    @testSetup 
    static void setup() {
        List<Task> tasks = new List<Task>();
        for (Integer i=0;i<90;i++) {
            tasks.add(new Task(CallObject='{4e0a4436-1dd2-11b2-8660-a12208748'+ i + '}'));
        }
        insert tasks;
    }
    static testmethod void test() {        
        Test.startTest();
        TaskProcessor LP = new TaskProcessor();
        Id batchId = Database.executeBatch(LP,90);     
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        //System.assertEquals(500, [select count() from task where TaskSource = 'Dreamforce']);
    }
    
    static testMethod void runScheduledCalls(){
        Test.startTest();
        LlamadasWSSchedule callWS = new LlamadasWSSchedule();
        callWS.execute(null);
        Test.stopTest();
    }
    
}