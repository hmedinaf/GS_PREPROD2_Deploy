@isTest
public class Calendar_Test {
    @testSetup static void setup() {
          Id redtId = [Select Id,developername, Name from recordtype where developername = 'Tarea'].Id;
    	Task t = new Task(Status = 'In Progress',Priority = 'Normal',Subject = 'subject' ,ActivityDate = system.today().addDays(+3), recordtypeId = redtId);
        insert t;
        Event ev = new Event(EndDateTime =system.today().addDays(+5) , StartDateTime =system.today().addDays(+3),Subject = 'test');
        insert ev;
    }
    static TestMethod void testMethod1() {
        string taskId = [select id from task where Status =: 'In Progress'].Id;
        string eventId = [select id from Event where Subject = 'test'].Id;
        Date filterDate = system.today().addDays(+3);
        Datetime startDateTime = Datetime.newInstance(2023, 3, 14,23, 0, 0);
        Datetime EndDateTime = Datetime.newInstance(2023, 3, 15,23, 0, 0);
        Test.startTest();
        Calendar.getAllEvents();
        Calendar.fetchEveTasks(filterDate);
        Calendar.saveTasks('Test', system.today(), 'In Progress','test');
        Calendar.saveEvents('Test', system.today(),filterDate, 'test');
        Calendar.EditEvents(eventId);
        Calendar.EditTask(taskId);
        Calendar.changeEveTasks(taskId);
        Calendar.updateEvents('Subject',startDateTime,EndDateTime,'Description', eventId);
        Calendar.updateTask('Subject',system.today(),'Completada','Description', taskId);
        Calendar.deletetaskRecord(taskId);
        Calendar.deleteEventRecord(eventId);
        Test.stopTest();
    }
    static TestMethod void testMethod2() {
        string taskId = [select id from task where Status =: 'In Progress'].Id;
        Event ev = [select id from Event where Subject = 'test'];
        Test.startTest();
        Date filterDate;
        Calendar.fetchEveTasks(filterDate);
        Calendar.updateTask('Subject',system.today(),'process','Description', taskId);
        Calendar.saveTasks('Test', system.today(), 'Completada','test');
        Test.stopTest();
    }
}