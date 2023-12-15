@isTest
public class AccountSearchController2_Test {
	static TestMethod void Test1() {
        AccountSearchController2 cont = new AccountSearchController2();
        cont.search();
        cont.searchField = 'NSS__c';cont.search();
        cont.searchField = 'FechaNacimiento_Formula__c';cont.search();
        cont.searchField = 'Lead_Profiler__c';cont.search();
        cont.searchField = 'ParentId';cont.search();
        cont.clear();
    }
}