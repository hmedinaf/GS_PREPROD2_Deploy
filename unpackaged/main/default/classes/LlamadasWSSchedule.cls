public class LlamadasWSSchedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        TaskProcessor LP = new TaskProcessor();
        Id batchId = Database.executeBatch(LP,90);
    }
}