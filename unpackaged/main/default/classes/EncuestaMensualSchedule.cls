public class EncuestaMensualSchedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        EncuestaMensual EM = new EncuestaMensual();
        Id batchId = Database.executeBatch(EM,9);    
    }
}