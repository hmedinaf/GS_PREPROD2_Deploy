@isTest
private class UpdateEntregaSiebel_Test{
    @isTest static void testCallout(){              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new esbJaverComMxUpddatMock());
        // Call the method that invokes a callout
        UpdateEntregaSiebel.sendData('', '', '', '', 0, 0, 0, 0, '', 0);
        // Verify that a fake result is returned=
    }
}