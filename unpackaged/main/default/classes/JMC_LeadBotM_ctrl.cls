/*
----------------------------------------------------------
* Nombre: JMC_LeadBotM_ctrl
* Autor Saúl González
* Proyecto: MC - FreewayConsulting
* Descripción : Clase que expone servicio REST para la comunicación Bot y SFC

* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           22/02/2021     Saúl González		   	Creación
* --------------------------------------------------------------------------------
*/

@RestResource(urlMapping='/LeadBotM/*')
global class JMC_LeadBotM_ctrl {

    /*
    * @description expone servicio para obtener el objeto json de la tarea de datos que envía SOA MC
    * @param String paramJson
	* @return  String response
    */
    @HttpPost
    global static JMC_LeadBotM_ctrl.Response leadPost() {
       	final JMC_LeadBotM_ctrl.Response respuesta = new JMC_LeadBotM_ctrl.Response();
        respuesta.idRespuesta = -1 ;
    	try {
			final RestRequest req = RestContext.request;
            final Blob body = req.requestBody;
            final String requestString = body.toString();
			final JMC_LeadsBusiness_ctrl tareaBussines = new JMC_LeadsBusiness_ctrl();
			Map<String,String> mapResponse =  new  Map<String,String>();
            mapResponse = tareaBussines.leadBot(requestString);
		    respuesta.idRespuesta =Integer.valueOf(mapResponse.get('idRespuesta'));
	    	respuesta.respuesta = mapResponse.get('respuesta');
	    	respuesta.idSalesforce =  mapResponse.get('idSalesforce');
    	} catch (Exception de) {
    		respuesta.error = ' Problemas al insertar los datos.';
    	}
    	return respuesta;
    }
    
    /*
    * @description clase para respuesta
    */
    global  class Response {
        /*Descripción de la respuesta de la insersión*/
    	private string respuesta;
        /*´Descrpción en caso de cachar algún error*/
    	private string error;
        /*Id de caso creado al momento de insertar*/
    	private string idSalesforce;
        /*Id de respuesta 0 = éxito o 1 = error*/
    	private Integer idRespuesta;
    }
}