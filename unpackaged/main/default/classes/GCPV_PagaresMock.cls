global class GCPV_PagaresMock implements HttpCalloutMock {

// Implement this interface method
    
    global HTTPResponse respond(HTTPRequest req) {
    
    // Optionally, only send a mock response for a specific endpoint
    // and method.
    // Create a fake response

    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json');
    String responseJSON = '{"ReportePostVentaSBL" : {    "@ItemQuantity" : 1,    "Row" : [ {      "NumPagare" : "1-5355962988",      "ImportePago" : 342000,      "TipoPagare" : "Pagaré Post Venta",      "FechaPagare" : "29/08/2018",      "TipoDocumento" : "Factura",      "VencimientoPagare" : "21/10/2018",      "AplicadoFactura" : "1-5355977122",      "EstadoDocumento" : "Cerrado",      "UltimaActualizacion" : "21/08/2021",      "NumProceso" : "1-5355957411" } ]  }}';
    response.setBody(responseJSON);
    response.setStatusCode(200);
    
    return response;
    
    }

}