global class SCHEDULE_Workday implements Schedulable{
    
    global void execute(SchedulableContext sc) {
		
		Id BatchId = Database.executeBatch(new BATCH_WorkdayOficialFirmada());
	}
}