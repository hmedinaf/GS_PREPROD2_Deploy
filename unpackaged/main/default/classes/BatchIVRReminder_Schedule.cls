/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Runs BatchIVRReminder everyday
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      17/12/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public class BatchIVRReminder_Schedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        BatchIVRReminder BIR = new BatchIVRReminder();
        Id batchId = Database.executeBatch(BIR,20);
    }
}