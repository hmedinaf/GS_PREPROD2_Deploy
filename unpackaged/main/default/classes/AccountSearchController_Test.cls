@isTest
public class AccountSearchController_Test {
	static TestMethod void Test1() {
        AccountSearchController cont = new AccountSearchController();
        cont.search();
        cont.searchField = 'NSS__c';cont.search();
        cont.searchField = 'FechaNacimiento_Formula__c';cont.search();
        cont.searchField = 'Lead_Profiler__c';cont.search();
        cont.searchField = 'ParentId';cont.search();
        cont.clear();
    }
}