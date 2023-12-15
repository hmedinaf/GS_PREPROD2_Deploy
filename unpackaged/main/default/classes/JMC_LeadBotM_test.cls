/*
----------------------------------------------------------
* Nombre: JMC_LeadBotM_test
* Autor Saúl González	
* Proyecto: Kavak
* Descripción : Clase con metódos test 
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           23/03/2021     Saúl González           	Creación
* --------------------------------------------------------------------------------
*/
@isTest
private class JMC_LeadBotM_test {

    /*
	* @description Method que ejecuta los metodos de la clase de utilerias
	*/
    static testMethod void testDoPost(){
        string xml = '{"firstName":"Juan","middleName":"Manuel","lastName":"Pérez","phone":"8888888888","fechaNacimiento":"2021-03-28","status":"Creación de Lead",'+
   '"email":"correo@correo.com","fraccionamiento":"","tipoCredito":"INFONAVIT","nss":"98765432103","curp":"curp321654hdjskl03","fuente":"Chat Sitio",'+
   '"canal":"Medios Digitales","subCanalVenta":"Buen Fin","presupuestoCompra":"$700,001 a $1,000,000","leadProfiler":"JORGE ISAAC CRUZ MANZANERO",'+
   '"analisisInterno":"No validado","comentarios":"Comentarios Lead","capacidadCompra":"100"}';
            RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/LeadBotM/';  
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(xml);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        JMC_LeadBotM_ctrl.leadPost();
        Test.stopTest();
        
        
    }   
}