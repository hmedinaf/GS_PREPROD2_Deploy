/*
----------------------------------------------------------
* Nombre: Lead_tgr 
* Autor Saúl González
* Proyecto: Javer
* Descripción : trigger para Lead
*
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           22/02/2021     Saúl González            Creación
* --------------------------------------------------------------------------------
*/

trigger Lead_tgr on Lead (before update,before insert,after insert, after update) {
    if (trigger.isAfter) {
        if(Trigger.isInsert){ 
            //LeadHandler_cls.validMail(Trigger.new);
        } 
        if(Trigger.isUpdate) {
            //LeadHandler_cls.valWSUpd(Trigger.new, Trigger.old, Trigger.NewMap,Trigger.OldMap);
            //LeadHandler_cls.valLeadP(Trigger.new, Trigger.old, Trigger.NewMap,Trigger.OldMap);
            //LeadHandler_cls.validMailUPD(Trigger.new, Trigger.OldMap);
        } 
    }
    if (trigger.isBefore) {
        if(Trigger.isInsert) {
            //LeadHandler_cls.updateFraccionamientoWTL(Trigger.new);
            //LeadHandler_cls.inFrac(Trigger.new); 
            //LeadHandler_cls.valPhone(Trigger.new); 
            //LeadHandler_cls.valCellphone(Trigger.new); 
        } else if(Trigger.isUpdate) {
            //LeadHandler_cls.upFrac(Trigger.new, Trigger.old, Trigger.NewMap,Trigger.OldMap);        
            //LeadHandler_cls.valPhone(Trigger.new); 
            //LeadHandler_cls.valCellphone(Trigger.new);       
        }
    }
}