/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Runs BatchLinkTalkdeskActivityHourly every 30 minutes
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      12/01/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class BatchLinkTalkdeskActivityHourly_Schedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        BatchLinkTalkdeskActivityHourly BIR = new BatchLinkTalkdeskActivityHourly();
        Id batchId = Database.executeBatch(BIR,20);
    }
}