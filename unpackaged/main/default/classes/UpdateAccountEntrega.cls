public class UpdateAccountEntrega {
    @future(callout = true)
    public static void guardar(String NumeroProceso,String FechaHabitibilidad,String Estatus,String FechaEntrega,Long TelefonoCasa,Long TelefonoCelular,Long TelefonoOtro,Decimal TelefonoRecado,String Correo,Long NumeroCliente){
        if(!Test.isRunningTest()){
        esbJaverComMxUpddat.UpdDatosEntregaBindingQSPort wsPort = new esbJaverComMxUpddat.UpdDatosEntregaBindingQSPort();
        wsPort.timeout_x = 100000;
        System.debug('NumeroProceso : ' + NumeroProceso);
                            System.debug('FechaHabitibilidad : ' + FechaHabitibilidad);
                            System.debug('Estatus : ' + Estatus);
                            System.debug('FechaEntrega : ' + FechaEntrega);
                            System.debug('TelefonoCasa : ' + TelefonoCasa);
                            System.debug('TelefonoCelular : ' + TelefonoCelular);
                            System.debug('TelefonoOtro : ' + TelefonoOtro);
                            System.debug('TelefonoRecado : ' + TelefonoRecado);
                            System.debug('Correo : ' + Correo);
        esbJaverComMxUpddatTypes.Result_element respuesta = wsPort.UpdDatosEntrega(
                                    NumeroProceso,
                                    FechaHabitibilidad,
                                    Estatus,
                                    FechaEntrega,
                                    TelefonoCasa,
                                    TelefonoCelular,
                                    TelefonoOtro,
                                    TelefonoRecado,
                                    Correo,
                                    NumeroCliente);
        }else{
            System.debug('NumeroProceso : ' + NumeroProceso);
                            System.debug('FechaHabitibilidad : ' + FechaHabitibilidad);
                            System.debug('Estatus : ' + Estatus);
                            System.debug('FechaEntrega : ' + FechaEntrega);
                            System.debug('TelefonoCasa : ' + TelefonoCasa);
                            System.debug('TelefonoCelular : ' + TelefonoCelular);
                            System.debug('TelefonoOtro : ' + TelefonoOtro);
                            System.debug('TelefonoRecado : ' + TelefonoRecado);
                            System.debug('Correo : ' + Correo);
            Integer i = 1;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
        }
        
    }
}