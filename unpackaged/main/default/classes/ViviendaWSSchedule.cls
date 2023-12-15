global class ViviendaWSSchedule implements Schedulable {   
    public void execute(SchedulableContext SC) {
      	ViviendaWSController.run('1');
    }
}