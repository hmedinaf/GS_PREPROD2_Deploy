@isTest 
public class UpdateAccountEntrega_Test {
	static testMethod void Testmethod1() {
        long tele = long.valueOf('+528119928819');
        UpdateAccountEntrega.guardar('NumeroProceso','FechaHabitibilidad','Por Asignar',string.valueOfGmt(system.today()),tele,tele,tele,tele,'Abc@test.com',tele);
    }
}