trigger TRIGGER_Dictaminacion on Contract (before insert, before update) {
    public static Boolean bypassTrigger = false;

    new DictaminacionTriggerHandler().run();
    
	CLASS_Dictaminacion triggerClass = new CLASS_Dictaminacion();
   	
    if(Trigger.IsBefore && Trigger.IsInsert && !bypassTrigger){
        triggerClass.validaExistenciaDictaminacion(Trigger.New);
    }
    
    if(Trigger.IsBefore && Trigger.IsUpdate && !bypassTrigger){
       triggerClass.validaExistenciaDictaminacionUp(Trigger.OldMap, Trigger.New);
    }
}