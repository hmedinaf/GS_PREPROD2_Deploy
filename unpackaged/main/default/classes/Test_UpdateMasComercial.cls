@isTest
public class Test_UpdateMasComercial {
	static testMethod void runUpdateMasComercial(){
        Test.startTest();
        UpdateComercialSchedule up = new UpdateComercialSchedule();
        up.execute(null);
        Test.stopTest();
    }
}