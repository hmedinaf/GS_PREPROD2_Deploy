/******* Author : Ajay Choudhary (ajay@wakencode.com, Wakencode Technologies)*********
 ******* Last Updated Date : 17th August 2023 ****************************************
 ******* Info : Test Class for MassApproval apex class *******************************
 ******* Update 1 : ________________________________________ *************************
 *************************************************************************************/
@isTest
public class MassApprovalTest {
    
    static testMethod void testMassApproval(){
        Plan_de_Venta__c pagares = new Plan_de_Venta__c(
            Fondo_de_Garantia_No_Cubierto__c = false,                       // Fondo de Garantía No Cubierto
            Exepcion_Fondo_de_Garantia_Aprobado__c = false,                 // Exepción Fondo de Garantía Aprobado
            Tipo__c = 'Plan de Venta',                                      // Tipo
            Estatus_Plan_de_venta__c = 'En Progreso',                       // Estatus Plan de Venta
            Monto_de_Descuadre_VO__c = 0.00,                                // Monto de Descuadre VO
            Casilla_Descuento_Empleado_Javer__c = true,                     // Descuento Empleado Javer
            Excepcion_Descuento_Empleado_JAVER__c = false,                  // Excepción Descuento Empleado JAVER
            Fecha_Proyeccion_escritura__c = Date.today().addDays(120),      // Fecha Proyección de escritura
            Paquetes_Promociones_de_Venta_Duplicadas__c = false,            // Paquetes/Promociones de Venta Duplicadas
            Financiamiento_Plan_de_Venta__c = false,                        // Financiamiento Plan de Venta
            VO_menor_a_P_M_nimo_de_Venta__c = false,                        // V.O. menor a P. Mínimo de Venta
            Producto_Bonificacion_menor_a_P_M_nim__c = false,               // Prod + Bonif menor a P. Mínimo de Venta
            Fondo_de_Garantia__c = false,                                   // Fondo de Garantía
            Venta_Anticipada__c = false,                                    // Venta Anticipada
            Check_Contrato_Firmado__c = false,                              // Check Contrato Firmado
            Revision_APC__c = false,                                        // Revisión APC
            Fecha_de_actualizacion_plan__c = Date.today().addDays(120)      // Fecha de actualización plan
        );
        insert pagares;
        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        app.setObjectId(pagares.id);
        Approval.ProcessResult result = Approval.process(app);
        Mass_Approval_Config__mdt config = new Mass_Approval_Config__mdt();
        config.MasterLabel = 'Plan de Venta';
        config.Object_Api_Name__c = 'Plan_de_Venta__c';
        config.DeveloperName = 'Plan_de_Venta';
        MassApproval.getObjectConfigs();
        MassApproval.getAllProcessItems('Plan_de_Venta__c', config, 'All');
         MassApproval.getAllProcessItems('Plan_de_Venta__c', config, 'Approved');
        MassApproval.getAllProcessSteps(result.getInstanceId());
        MassApproval.ApprovalRequestData data = new MassApproval.ApprovalRequestData();
        data.actorId = result.getActorIds()[0];
        data.actorName = '';
        data.comments = 'test';
        data.createdByName = 'test';
        data.createdDate = Date.today();
        data.processInstanceId = result.getInstanceId();
        data.recordId = pagares.Id;
        MassApproval.reAssignProcessItems(JSON.serialize(new List<MassApproval.ApprovalRequestData>{data}));
        MassApproval.approveRejectRecords(JSON.serialize(new List<MassApproval.ApprovalRequestData>{data}), 'Approve');
        
    }
    
}