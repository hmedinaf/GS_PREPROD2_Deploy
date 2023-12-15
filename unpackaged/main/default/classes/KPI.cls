public class KPI {
    @AuraEnabled
    public static String fetchDashboards(){
        Dashboard db = [Select Id, title From Dashboard where title = 'KPIDashboard'];
        if(db != null){
            return db.Id;
        }
        else{
            return null;
        }
    }
}