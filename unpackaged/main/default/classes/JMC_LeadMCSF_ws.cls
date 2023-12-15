/*
----------------------------------------------------------
* Nombre: JMC_LeadMCSF_ws
* Autor Saúl González
* Proyecto: MC - FreewayConsulting
* Descripción : Clase que expone y consume servicios REST para la comunicación con SOA MC y SF.

* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           08/02/2021     Saúl González		   	Creación
* --------------------------------------------------------------------------------
*/

@RestResource(urlMapping='/LeadMCSF/*')
global class JMC_LeadMCSF_ws {
 
    /*
    * @description expone servicio para obtener el objeto json de la tarea de datos que envía SOA MC
    * @param String paramJson
	* @return  String response
    */
    @HttpPost
    global static JMC_LeadMCSF_ws.Response leadPost() {
       	final JMC_LeadMCSF_ws.Response respuesta = new JMC_LeadMCSF_ws.Response();
        respuesta.idRespuesta = -1 ;
    	try {
            
            /*Http h = new Http();
			HttpRequest req = new HttpRequest();
            System.debug(req);*/
            
			final RestRequest req = RestContext.request;
            final Blob body = req.requestBody;
            
            System.debug(body); 
            final String requestString = body.toString(); 
            System.debug(requestString);
			Dom.Document domDoc = new Dom.Document();
            domDoc.load(requestString); 
            Dom.XMLNode root = domDoc.getRootElement();
            List<Dom.XMLNode> lstAllChild= root.getChildren();
            Map<String, String> mapToGetAllData = new Map<String, String>();
            for(Dom.XMLNode c : lstAllChild){
                if(String.isNotBlank(c.getName()))
                mapToGetAllData.put(c.getName(),c.getText());
                System.debug(c.getName()+'  '+c.getText());
            } 
            System.debug(mapToGetAllData);
            String jsonRequest = JSON.serialize(mapToGetAllData);
			final JMC_LeadsBusiness_ctrl tareaBussines = new JMC_LeadsBusiness_ctrl();
			Map<String,String> mapResponse =  new  Map<String,String>();
            mapResponse = tareaBussines.upLead(jsonRequest);
			respuesta.idRespuesta =Integer.valueOf(mapResponse.get('idRespuesta'));
	    	respuesta.respuesta = mapResponse.get('respuesta');
	    	respuesta.idSalesforce =  mapResponse.get('idSalesforce');
    	} catch (DmlException de) {
    		respuesta.error = ' Problemas al insertar los datos.'+de;
    	} catch (JSONException je) {
    		respuesta.error = ' Problema con el objeto JSON.';
        } catch (CalloutException ce) {
            respuesta.error = ' Problemas en la comunicación del servicio.';
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