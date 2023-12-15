global class LimpiezaAprobSchClass implements Schedulable
{  
    global static String LimpiezaAprobSchMe(String mode )
    {
        LimpiezaAprobSchClass LimpAprob_sch = new LimpiezaAprobSchClass();
        
        String sch = mode; // base this on mode or whatever your params are
        String recurrencia=mode.Substring(0, 6);
        String jobID;
        if (!Test.isRunningTest()) { jobID = system.schedule('Limp.Aprob.Aged'+mode, sch, LimpAprob_sch);
        } else {
            jobID = system.schedule('Limp.Aprob.Aged.Test'+mode, sch, LimpAprob_sch);
        }
        
        return jobID;
    }

  global void execute(SchedulableContext sc)
  {
    String fecha;
    Datetime dt = Datetime.NOW();
    fecha = dt.format('yyyyMMdd');
    CronTrigger ct = [SELECT TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :sc.getTriggerId()];
    System.Debug('***ct*** '+ct);
    String IdJob = ct.Id;
    IdJob = IdJob.Substring(0,15);
    Javer_Util_Future juf_class = new Javer_Util_Future();
    if (!Test.isRunningTest()) { Sistema__c Sst = [SELECT Id, Name,  Limpieza_Job_Id__c, Limpieza_Recurrencia__c, Max_antiguedad_sin_resolucion__c  FROM Sistema__c WHERE Limpieza_Job_Id__c =:IdJob LIMIT 1]; System.Debug('***Sst*** '+Sst); if (Sst.Max_antiguedad_sin_resolucion__c!=null){ Javer_Util_Future.limpia_aprob_siebel(Integer.ValueOf( Sst.Max_antiguedad_sin_resolucion__c) );  }
    } else {
        Javer_Util_Future.limpia_aprob_siebel(1 );
    } 
    
  }
}