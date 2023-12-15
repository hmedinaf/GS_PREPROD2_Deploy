@isTest
public class SegmentoFraccionamientos_Test {
	static TestMethod void Test1() {
        List<String> fracs = new list<String>();
        Fraccionamiento__c f = new Fraccionamiento__c();
         f.name = 'frac1';
        insert f;
        fracs.add(f.id);
        Segmento_de_Fraccionamiento__c s = new Segmento_de_Fraccionamiento__c();
        insert s;
        String segId = s.id;
    	Test.startTest();
        SegmentoFraccionamientos.getFracc();
		SegmentoFraccionamientos.saveFraccs(fracs,segId);
        SegmentoFraccionamientos.saveFraccs(fracs,'');
        Test.stopTest();
    }
}