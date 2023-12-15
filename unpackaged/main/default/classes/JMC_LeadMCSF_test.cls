/*
----------------------------------------------------------
* Nombre: JMC_LeadMCSF_test
* Autor Saúl González	
* Proyecto: Kavak
* Descripción : Clase con metódos test 
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           19/03/2021     Saúl González           	Creación
* --------------------------------------------------------------------------------
*/
@isTest
private class JMC_LeadMCSF_test {
    
    /*
	* @description Method que ejecuta los metodos de la clase de utilerias
	*/
    static testMethod void testDoPost(){
        string xml = '<OrderDetails>'+
            '<OrderDetailID>2584</OrderDetailID>'+
            '<GiftWrapCost>0.0000</GiftWrapCost>'+
            '<GiftWrapNote/>'+
            '<ProductCode>800006</ProductCode>'+
            '</OrderDetails>';
            RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/LeadMCSF/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(xml);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        JMC_LeadMCSF_ws.leadPost();
        Test.stopTest();
        
        
    }   
}