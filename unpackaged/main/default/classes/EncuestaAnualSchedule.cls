public class EncuestaAnualSchedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        EncuestaAnual EA = new EncuestaAnual();
        Id batchId = Database.executeBatch(EA,9);    
    }
}