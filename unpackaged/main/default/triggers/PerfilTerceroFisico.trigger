trigger PerfilTerceroFisico on Perfil_Tercero_Fisico__c (before insert, before update) {
    if (trigger.isBefore) {
        if (trigger.isInsert) {
            PerfilTerceroFisTriggerHandler.updateRFCyCURP(Trigger.new);
        }
        if (trigger.isUpdate) {
            list <Perfil_Tercero_Fisico__c> listUpdRfc = new list <Perfil_Tercero_Fisico__c>();
            for (Perfil_Tercero_Fisico__c p : Trigger.New) {
                if (p.Nombre__c != trigger.oldMap.get(p.id).Nombre__c ||
                    p.Apellido_Paterno__c != trigger.oldMap.get(p.id).Apellido_Paterno__c ||
                    p.Apellido_Materno__c != trigger.oldMap.get(p.id).Apellido_Materno__c ||
                    p.Sexo__c != trigger.oldMap.get(p.id).Sexo__c ||
                    p.Fecha_de_Nacimiento__c != trigger.oldMap.get(p.id).Fecha_de_Nacimiento__c ||
                    p.Lugar_de_nacimiento__c != trigger.oldMap.get(p.id).Lugar_de_nacimiento__c) 
                {
                    listUpdRfc.add(p);
                }
            }
            PerfilTerceroFisTriggerHandler.updateRFCyCURP(listUpdRfc);
        }
    }
}