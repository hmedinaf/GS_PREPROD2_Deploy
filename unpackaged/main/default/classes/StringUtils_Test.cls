@isTest
public class StringUtils_Test {
    static TestMethod void Test1() {
        String inputText = 'ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÇÿ';
        String expectedOutput = 'AAAAAAEEEEIIIIOOOOOOUUUUC';
        Set<String> inv = new Set<String>();
        inv.add('ÅÈÉÊËÌÍ');
        Test.startTest();
        StringUtils.replaceSpecialChars(inputText);
        StringBuilder sc = new StringBuilder(inputText);
        sc.setString(inputText);
        sc.replaceSpecialChars();
        sc.getString();
        sc.removePrepConjCont();
        sc.removeInvalidWords(inv);
        Test.stopTest();
    }
    static TestMethod void Test2() {
        String inputText = 'A B C';
        Test.startTest();
        StringBuilder sc = new StringBuilder(inputText);
        sc.removePrepConjCont();
        Test.stopTest();
    }
}