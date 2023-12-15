@isTest
global class esbJaverComMxUpddatMock implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        esbJaverComMxUpddatTypes.UpdDatosEntregaRs_element response_x = 
            new esbJaverComMxUpddatTypes.UpdDatosEntregaRs_element();
        esbJaverComMxUpddatTypes.Result_element ResultMock = 
            new esbJaverComMxUpddatTypes.Result_element();
        ResultMock.Estatus = false;
        ResultMock.Message = 'test';
        response_x.Result = ResultMock;
        // end
        response.put('response_x', response_x); 
   }
}