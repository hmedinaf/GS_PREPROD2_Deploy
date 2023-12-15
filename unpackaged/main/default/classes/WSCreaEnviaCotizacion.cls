@RestResource(urlMapping='/WSCreaEnviaCotizacion')
global class WSCreaEnviaCotizacion {
    @HTTPPUT
    global static void CreaEnviaCotizacion(String accId) {
        system.debug('** Response:'+accId);

        // EjecutaFlow(accId);

    }

    // @future(callout=true)
    // public static void EjecutaFlow(String AccId){
    //     Map<String, Object> Params = new Map<String, Object>();
        // Params.put('RecordId', AccId);

        // // Create a new instance of the flow to execute
        // Flow.Interview.Crear_y_Enviar_Cotizacion_Flow myFlow = new Flow.Interview.Crear_y_Enviar_Cotizacion_Flow(Params);

        // // Start the flow and get the flow result
        // myFlow.start();
    // }
}