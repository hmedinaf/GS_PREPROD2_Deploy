/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Actualiza información de entregas en Siebel al actualizar cuentas
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      24/02/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class UpdateEntregaSiebel {
    @future(callout = true)
    public static void sendData(String numeroProceso, String fechaHabitibilidad, String estatus, String fechaEntrega, Long telefonoCasa, 
                                Long telefonoCelular, Long telefonoOtro, Decimal telefonoRecado, String correo, Long numeroCliente){
        esbJaverComMxUpddat.UpdDatosEntregaBindingQSPort wsPort = new esbJaverComMxUpddat.UpdDatosEntregaBindingQSPort();
        wsPort.timeout_x = 100000;
        esbJaverComMxUpddatTypes.Result_element response = wsPort.UpdDatosEntrega(numeroProceso, fechaHabitibilidad, estatus,
                                    fechaEntrega, telefonoCasa, telefonoCelular, telefonoOtro, telefonoRecado, correo, numeroCliente);
        System.debug(response);
                                    
    }
}