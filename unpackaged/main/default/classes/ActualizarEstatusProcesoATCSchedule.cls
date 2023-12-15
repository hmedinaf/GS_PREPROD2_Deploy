public class ActualizarEstatusProcesoATCSchedule implements Schedulable {

    public void execute(SchedulableContext SC) { 
        ActualizarEstatusProcesoATC.execute();
        
    }
}