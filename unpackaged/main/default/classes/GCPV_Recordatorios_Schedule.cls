public class GCPV_Recordatorios_Schedule {
	public void execute(SchedulableContext SC) {
        GCPV_Recordatorios_Batch EM = new GCPV_Recordatorios_Batch();
        Id batchId = Database.executeBatch(EM,200);    
    }
}