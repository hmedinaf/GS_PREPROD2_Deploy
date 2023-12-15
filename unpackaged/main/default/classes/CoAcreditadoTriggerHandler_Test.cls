@isTest
public class CoAcreditadoTriggerHandler_Test {
	static TestMethod void Test1() {
        Co_Acreditado__c c = new Co_Acreditado__c(Apellido_Paterno_CO_Acreditado__c = 'Paterno', Apellido_Materno_CO_Acreditado__c = 'Materno', Sexo__c = 'MASCULINO',
                                                 Nombre__c = 'nom',Fecha_de_Nacimiento_CO_Acreditado__c = system.today(),Lugar_de_nacimiento__c = 'AGUASCALIENTES');
        insert c;
        c.Lugar_de_nacimiento__c = 'BAJA CALIFORNIA';
        update c;
    }
}