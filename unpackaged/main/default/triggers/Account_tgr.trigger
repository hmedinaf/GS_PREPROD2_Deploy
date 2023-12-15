/*
----------------------------------------------------------
* Nombre: Account_tgr 
* Autor Saúl González
* Proyecto: MC - FreewayConsulting
* Descripción : trigger para Account
*
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           09/03/2021     Saúl González            Creación
* --------------------------------------------------------------------------------
*/
trigger Account_tgr on Account (before update,before insert,after insert, after update) {
	if (trigger.isAfter) {
        if(Trigger.isInsert){ 
        } else if(Trigger.isUpdate) {
        }
    }
    if (trigger.isBefore) {
        if(Trigger.isInsert){
        } else if(Trigger.isUpdate){
            //LeadHandler_cls.valWSUpd(Trigger.new, Trigger.old, Trigger.NewMap,Trigger.OldMap);
        }
    }
}