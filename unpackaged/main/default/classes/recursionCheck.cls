public class recursionCheck{
    public static Boolean shouldIRun = true;
    public static Boolean PATCPagare = false;
    public static Boolean entregasWS = false;
    
    public static Boolean canIRun(){
         return shouldIRun; 
    }
    
    public static void stopRecursion(){
        shouldIRun = false;
    }
    
    public static void allowTorun(){
        shouldIRun = true;
    }
}