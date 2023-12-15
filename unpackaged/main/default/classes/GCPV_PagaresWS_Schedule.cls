global class GCPV_PagaresWS_Schedule implements Schedulable {
    public void execute(SchedulableContext SC) {
        GCPV_PagaresWS.getPagares('1');
    }
}