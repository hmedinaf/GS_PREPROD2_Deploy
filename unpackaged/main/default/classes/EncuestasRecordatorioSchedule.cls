public class EncuestasRecordatorioSchedule implements Schedulable{
    public void execute(SchedulableContext SC) {
        EncuestasRecordatorioDiario ERD = new EncuestasRecordatorioDiario();
        Id batchId = Database.executeBatch(ERD,9);    
    }
}