global class EntregaWS_Schedulable_1Day implements Schedulable {
   
    public void execute(SchedulableContext SC) {

        EntregasWS_Queueable EntregasWS_Queueable = new EntregasWS_Queueable(1);
        ID jobID = System.enqueueJob(EntregasWS_Queueable);
        
    }
    
}