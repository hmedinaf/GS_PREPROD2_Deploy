global class EntregaWS_Schedulable implements Schedulable {
   
    public void execute(SchedulableContext SC) {

        EntregasWS_Queueable EntregasWS_Queueable = new EntregasWS_Queueable(0);
        ID jobID = System.enqueueJob(EntregasWS_Queueable);
        
    }
    
}