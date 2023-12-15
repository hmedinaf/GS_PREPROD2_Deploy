global class SCHEDULE_CuentasDesasignacion implements Schedulable{
    
    global void execute(SchedulableContext sc) {
		
		Id BatchId = Database.executeBatch(new BATCH_CuentasDesasignacion());
	}
}