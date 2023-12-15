@isTest
public class BatchIVRReminder_Test {

    @TestSetup
    static void setup() {
        Task task = new Task(ActivityDate = System.today() + 1);
        insert task;
    }
    
    static testmethod void BatchViviendaMasReciente(){
        Test.StartTest();
        BatchIVRReminder_Schedule BIR = new BatchIVRReminder_Schedule();      
        String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, BIR);
        Test.stopTest();
    }
}