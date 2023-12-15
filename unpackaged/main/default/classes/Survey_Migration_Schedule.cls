public class Survey_Migration_Schedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        Survey_Migration_Daily SM = new Survey_Migration_Daily();
        Id batchId = Database.executeBatch(SM,2);
    }
}