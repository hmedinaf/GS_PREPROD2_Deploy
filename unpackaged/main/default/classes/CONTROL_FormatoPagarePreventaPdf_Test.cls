@isTest
public class CONTROL_FormatoPagarePreventaPdf_Test {
    @testSetup static void methodName() {
        Compania__c  comp = new Compania__c(Name = 'CASAS JAVER, S.A. DE C.V.'); 
        insert comp;
        Ubicacion__c u = new Ubicacion__c(Compania__c=comp.Id, Estado__c='Nuevo León',Telefono__c='2224456677', Direccion_Fisica__c='Pabellon M, Humberto Jiménez López 190, Centro, 64000 Monterrey, N.L., México', Direccion_Fiscal__c='Pabellon M, Humberto Jiménez López 190, Centro, 64000 Monterrey, N.L., México', Referencia_FEMSA__c='Ejemplo Referencia FEM', Representante_Legal__c='Ejemplo Representante Legal Completo', RFC__c='Ejemplo RFC', Representante_Legal_Nombre__c='Ejemplo Representante Legal Nombre', Representante_Legal_Apellido_Paterno__c='Ejemplo Representante Legal Apellido Paterno', Representante_Legal_Apellido_Materno__c='Ejemplo Representante Legal Apellido Materno',
                                          Referencia_Santander__c='Ejemplo Referencia San', Referencia_HSBC__c='Ejemplo Referencia HSB', SPEI_Santander__c='Ejemplo SPEI Santander', SPEI_HSBC__c='Ejemplo SPEI HSBC', Municipio__c='Monterrey', Convenio_Empresa__c='Ejemplo Convenio / Emp', Clave_RAP_HSBC__c='Ejemplo Clave RAP HSBC', Banco_Intermediario__c='Ejemplo Banco Intermed', Cuenta_Extranjera__c='Ejemplo Cuenta Extranj', Telefono_Cobranza__c='(81) 11-33-66-99', Email_Cobranza__c='cobranza@javer.com.mx', CLABE_Santander__c='CLABESANTANDER', CLABE_HSBC__c='CLABEHSBC');
        insert u;
        Plan_de_Venta__c planVenta = new Plan_de_Venta__c(Ubicacion_Compania__c = u.Id,  Exepcion_Fondo_de_Garantia_Aprobado__c = true, Fecha_Proyeccion_escritura__c = Date.today(),
                                                          Plan_de_Venta_Aprobado__c = false);
        insert planVenta;
        
        Pagare_Preventa__c pagares = new Pagare_Preventa__c();
        pagares.Plan_de_Venta__c = planVenta.id;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pagares.Eliminado_Manualmente__c = true;
        pagares.Importe__c = 1.0;
        insert pagares;  
    }
    @isTest
    static void test1(){
        Plan_de_Venta__c planVenta = [select id from Plan_de_Venta__c where Plan_de_Venta_Aprobado__c = false];
        Test.startTest();
        PageReference page = Page.FormatoPagarePreventaPdf;
        page.getParameters().put('id', planVenta.Id);
        Test.setCurrentPageReference(page);
        ApexPages.StandardController controller = new ApexPages.StandardController(planVenta);
        CONTROL_FormatoPagarePreventaPdf co = new CONTROL_FormatoPagarePreventaPdf(controller);
        Test.stopTest();
    }
       
}