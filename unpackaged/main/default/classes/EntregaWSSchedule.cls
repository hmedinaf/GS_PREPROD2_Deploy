global class EntregaWSSchedule implements Schedulable {
   
    public void execute(SchedulableContext SC) {
      	ImportarEntregaWS.run(1);
    }
}