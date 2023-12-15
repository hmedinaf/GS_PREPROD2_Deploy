/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-29-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger TRIGGER_Cuenta on Account (before insert, before update, after insert, after update) {

    // CLASS_Cuenta classCuenta = new CLASS_Cuenta();
    List <Account> trNewNoBypass = new List <Account>();
    List <Account> trNoBypass = new List <Account>();

    // Obtener los tipos de registro
    Id rJavAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Javer Account').getRecordTypeId();
    Id rComJav = Schema.SObjectType.Account.getRecordTypeInfosByName().get('COMPAÑÍA JAVER').getRecordTypeId();
    Id rCon = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Contacto').getRecordTypeId();
    Id rConSolLec = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Contacto solo lectura').getRecordTypeId();
    Id rPro = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Prospecto').getRecordTypeId();
    Id rClientesATC = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('ClientesATC').getRecordTypeId();
    Id rClientesATCPA = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            for (Account tr : Trigger.new) {
                // Si pertenece a alguno de estos tipos de registros, no pasar a unificaDatosCuenta
                if (tr.RecordTypeId!=rJavAcc && tr.RecordTypeId!=rComJav && tr.RecordTypeId!=rCon && tr.RecordTypeId!=rConSolLec && 
                    tr.RecordTypeId!=rPro && tr.RecordTypeId!=rClientesATC && tr.RecordTypeId!=rClientesATCPA &&
                    !tr.IsVRBypassed__c ) {
                    trNewNoBypass.add(tr);
                }
            }
            if (trNewNoBypass.size()>0) {
                CLASS_Cuenta.unificaDatosCuenta(trNewNoBypass);
            }
        }
        else if(Trigger.isUpdate){
            for (Account tr : Trigger.new) {
                if (!tr.IsVRBypassed__c && tr.RecordTypeId!=rClientesATC && tr.RecordTypeId!=rClientesATCPA) {
                    trNewNoBypass.add(tr);
                }
                // HMF 2023-07-11 - Quick fix a si el Fraccionamiento si pasa de tener dato a null
                if (tr.Fraccionamiento_cta__c==null && Trigger.oldMap.get(tr.Id).Fraccionamiento_cta__c != tr.Fraccionamiento_cta__c) {
                    tr.Fraccionamiento_cta__c = Trigger.oldMap.get(tr.Id).Fraccionamiento_cta__c;
                }
                if (tr.Tipo_Baja__c != null && Trigger.oldMap.get(tr.Id).Tipo_Baja__c == null) {
                    tr.Baja_Incubadora__c='Baja';
                }
                if (tr.Motivo_Incubacion__c != null && Trigger.oldMap.get(tr.Id).Motivo_Incubacion__c == null) {
                    tr.Baja_Incubadora__c='Incubadora';
                }

                if (tr.Baja_Incubadora__c=='Baja' || tr.Baja_Incubadora__c=='Incubadora') {
                    tr.MANAGEAPPROVALS__Active__c = 'No';
                }
            }
            // classCuenta.unificaDatosCuenta(Trigger.new,Trigger.oldMap);
            // No ejecutar dependiendo del tipo de registro
            if (!trNewNoBypass.isEmpty()) {
                CLASS_Cuenta.unificaDatosCuenta(trNewNoBypass,Trigger.oldMap);
            }
        }
    }else{
        if(Trigger.isInsert){
            for (Account tr : Trigger.new) {
                if (!tr.IsVRBypassed__c && tr.RecordTypeId!=rClientesATC && tr.RecordTypeId!=rClientesATCPA) {
                    trNewNoBypass.add(tr);
                }
            }
            CLASS_Cuenta.listaNegraQEQ(false, Trigger.New, null);  CLASS_Cuenta.creaPrimeraVisitaCreacion(Trigger.new);
            if(trNewNoBypass.size()>0) {
                CLASS_Cuenta.creaRolesVentaCreacion(trNewNoBypass);CLASS_Cuenta.guardaHistoricoAsignaciones(trNewNoBypass);
            }

            // enqueue GuardarMasComercial call job for processing
            // CLASS_Cuenta.IsExecuting=true;
            // GuardarMasComercialQbApx masComercialJob = new GuardarMasComercialQbApx(Trigger.new);
            // ID jobID = System.enqueueJob(masComercialJob);

        }
        else if(Trigger.isUpdate){
            for (Account tr : Trigger.new) {
                if (!tr.IsVRBypassed__c && tr.RecordTypeId!=rClientesATC && tr.RecordTypeId!=rClientesATCPA) {
                    trNewNoBypass.add(tr);
                }
                //if (tr.Trigger_Override__c == Trigger.oldMap.get(tr.Id).Trigger_Override__c) {
                if (!tr.IsTRBypassed__c && tr.RecordTypeId!=rClientesATC && tr.RecordTypeId!=rClientesATCPA) {
                    trNoBypass.add(tr);
                }
            }

            // enqueue GuardarMasComercial call job for processing
            if (!CLASS_Cuenta.IsExecuting && trNoBypass.size()>0) {
                CLASS_Cuenta.IsExecuting=true;  GuardarMasComercialQbApx masComercialJob = new GuardarMasComercialQbApx(trNoBypass);ID jobID = System.enqueueJob(masComercialJob);
            }

            // classCuenta.listaNegraQEQ(true, Trigger.new, Trigger.oldMap);
            // classCuenta.creaPrimeraVisitaEdicion(Trigger.new, Trigger.oldMap);
            // classCuenta.creaRolesVentaEdicion(Trigger.new, Trigger.oldMap);
            CLASS_Cuenta.listaNegraQEQ(true, Trigger.new, Trigger.oldMap);
            CLASS_Cuenta.creaPrimeraVisitaEdicion( Trigger.new, Trigger.oldMap);
            if (!trNewNoBypass.isEmpty()) {
                CLASS_Cuenta.creaRolesVentaEdicion(trNewNoBypass, Trigger.oldMap);
            }
            CLASS_Cuenta.guardaHistoricoAsignaciones(Trigger.oldMap, Trigger.new);
        }
    }
}