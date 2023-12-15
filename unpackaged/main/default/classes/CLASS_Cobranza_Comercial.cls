public with sharing class CLASS_Cobranza_Comercial {
    
    //Metodo que valida los datos en la creacion de un registro de Cobranza Comercial
    /*FALTA CUBRIR ESCENARIO SI POSTERIOR A LA CREACION DEL REGISTRO DE COBRANZA COMERCIAL SE CREA EL REGISTRO DE:
        COBRANZA POSTVENTA
        TITULACION
        ENTREGA
        PRODUCTO DE OPORTUNIDAD OTROS GASTOS
        PRODUCTO DE OPORTUNIDAD PROMOCIONES
        PRODUCTO DE OPORTUNIDAD PAQUETES
    EN ESTOS ESCENARIOS SE DEBEN ACTUALIZAR LOS CAMPOS DEL REGISTRO DE OTRA RELACION COBRANZA COMERCIAL O COBRANZA COMERCIAL QUE CORRESPONDAN
        OTRA RELACION COBRANZA COMERCIAL - COBRANZA POSTVENTA - Cobranza_Postventa__c
        COBRANZA COMERCIAL - TITULACION - Titulacion__c
        COBRANZA COMERCIAL - ENTREGA - Entrega__c
        COBRANZA COMERCIAL - MONTO PRODUCTOS DE OPORTUNIDAD OTROS GASTOS - Monto_Producto_Oportunidad_Otros_Gastos__c
        COBRANZA COMERCIAL - MONTO PRODUCTOS DE OPORTUNIDAD PROMOCIONES - Monto_Producto_Oportunidad_Promociones__c
        COBRANZA COMERCIAL - MONTO PRODUCTOS DE OPORTUNIDAD PAQUETES - Monto_Producto_Oportunidad_Paquetes__c
    */
    public void validaDatos(List<Cobranza_Comercial__c> cobranzasComercialesNuevas){

        Set<Id> idsProcesosVenta = new Set<Id>();
        for(Cobranza_Comercial__c cobranzaComercial : cobranzasComercialesNuevas){

            idsProcesosVenta.add(cobranzaComercial.Proceso_Venta__c);
        }

        //Se obtienen los datos de las oportunidades relacionadas a los registros a crear de Cobranza Comercial
        Map<Id,Opportunity> procesosVenta = new Map<Id,Opportunity>([SELECT Id, Name, Cantidad_Cobranzas_Comerciales__c, StageName, AccountId, Plan_de_Venta__c, Plan_de_Venta__r.Vivienda__c, Plan_de_Venta__r.Vivienda__r.Fraccionamiento__c, Plan_de_Venta__r.Vivienda__r.Prototipo__c, Plan_de_Venta__r.Vivienda__r.Id_Vivienda__c FROM Opportunity WHERE Id IN : idsProcesosVenta]);
        
        //Se obtienen las viviendas relacionadas al plan de ventas relacionado a los registros a crear de Cobranza Comercial
        Map<Id,Id> procesosVentaViviendas = new Map<Id,Id>();
        Map<Id,String> nombresProcesosVenta = new Map<Id,String>();
        for(Id idProcesoVenta : procesosVenta.keySet()){

            nombresProcesosVenta.put(idProcesoVenta, procesosVenta.get(idProcesoVenta).Name);
            procesosVentaViviendas.put(idProcesoVenta, procesosVenta.get(idProcesoVenta).Plan_de_Venta__r.Vivienda__c);
        }

        //Se obtienen las listas de precios de tipo de registro Vivienda relacionadas a las viviendas relacionadas al plan de ventas relacionado a los registros a crear de Cobranza Comercial
        Map<Id,Id> viviendasViviendasListasPrecios = new Map<Id,Id>();
        Id tipoRegistroVivienda = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Vivienda').getRecordTypeId();
        for(PricebookEntry entradaListaPrecios : [SELECT Id, Product2.Vivienda__c, Pricebook2Id FROM PricebookEntry WHERE Product2.Vivienda__c IN :procesosVentaViviendas.values() AND Pricebook2.RecordTypeId =: tipoRegistroVivienda AND Pricebook2.Vigente_Desde__c < TODAY AND Pricebook2.Vigente_Hasta__c > TODAY]){
            viviendasViviendasListasPrecios.put(entradaListaPrecios.Product2.Vivienda__c, entradaListaPrecios.Pricebook2Id);
        }

        //Se obtienen las listas de precios de tipo de registro Promocion Precio relacionadas a las viviendas relacionadas al plan de ventas relacionado a los registros a crear de Cobranza Comercial
        Map<Id,Id> viviendasPromocionPrecioListasPrecios = new Map<Id,Id>();
        Id tipoRegistroPromocionPrecio = Schema.SObjectType.Pricebook2.getRecordTypeInfosByDeveloperName().get('Promocion_Precio').getRecordTypeId();
        for(PricebookEntry entradaListaPrecios : [SELECT Id, Product2.Vivienda__c, Pricebook2Id FROM PricebookEntry WHERE Product2.Vivienda__c IN :procesosVentaViviendas.values() AND Pricebook2.RecordTypeId =: tipoRegistroPromocionPrecio AND Pricebook2.Vigente_Desde__c < TODAY AND Pricebook2.Vigente_Hasta__c > TODAY]){
            viviendasPromocionPrecioListasPrecios.put(entradaListaPrecios.Product2.Vivienda__c, entradaListaPrecios.Pricebook2Id);
        }

        //Se obtienen los datos de las cobranzas postventa relacionadas a las oportunidades relacionadas a los registros a crear de Cobranza Comercial
        Map<Id,Cobranza_Postventa__c> cobranzasPostventa = new Map<Id,Cobranza_Postventa__c>();
        for(Cobranza_Postventa__c cobranzaPostventa : [SELECT Id, Proceso_Venta__c FROM Cobranza_Postventa__c WHERE Proceso_Venta__c IN : idsProcesosVenta]){
            cobranzasPostventa.put(cobranzaPostventa.Proceso_Venta__c, cobranzaPostventa);
        }

        //Se obtienen los datos de las titulaciones relacionadas a las oportunidades relacionadas a los registros a crear de Cobranza Comercial
        Map<Id,Titulacion__c> titulaciones = new Map<Id,Titulacion__c>();
        for(Titulacion__c titulacion : [SELECT Id, Proceso_de_Venta__c FROM Titulacion__c WHERE Proceso_de_Venta__c IN : idsProcesosVenta]){
            titulaciones.put(titulacion.Proceso_de_Venta__c, titulacion);
        }

        //Se obtienen los datos de las entregas cuyo Proceso ATC (Inventario) este relacionado a la Cuenta, Fraccionamiento, Prototipo y Vivienda este relacionado a
        //la Cuenta, Fraccionamiento, Prototipo y Vivienda del Plan de Venta relacionado a los registros a crear de Cobranza Comercial
        Map<String,Entrega__c> entregas = new Map<String,Entrega__c>();
        for(Entrega__c entrega : [SELECT Id, Numero_Proceso__c FROM Entrega__c WHERE Numero_Proceso__c IN : nombresProcesosVenta.values()]){
            entregas.put(entrega.Numero_Proceso__c, entrega);
        }

        //Se obtiene el monto de los productos de oportunidad de Tipo de Registro = Productos Genericos y de Tipo de Producto = Otros Gastos relacionados a las oportunidades relacionadas a los registros a crear de Cobranza Comercial
        Id tipoRegistroProductoGenerico = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Productos_Genericos').getRecordTypeId();
        Map<Id,Decimal> productosOportunidadMontoOtrosGastos = new Map<Id,Decimal>();
        Decimal montoProductosOportunidadOtrosGastos = 0;
        for(Opportunity oportunidad : [SELECT Id, (SELECT Id, UnitPrice FROM OpportunityLineItems WHERE Product2.RecordTypeId =: tipoRegistroProductoGenerico AND Product2.Tipo_de_Producto__c = 'Otros Gastos') FROM Opportunity WHERE Id IN : idsProcesosVenta]){

            for(OpportunityLineItem productoOportunidad : oportunidad.OpportunityLineItems){
                montoProductosOportunidadOtrosGastos = montoProductosOportunidadOtrosGastos + productoOportunidad.UnitPrice;
            }
            productosOportunidadMontoOtrosGastos.put(oportunidad.Id, montoProductosOportunidadOtrosGastos);
        }

        //Se obtiene el monto de los productos de oportunidad de Tipo de Registro = Productos Genericos y de Tipo de Producto = Otros Gastos relacionados a las oportunidades relacionadas a los registros a crear de Cobranza Comercial
        Id tipoRegistroPromocionVenta = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Promocion_de_Venta').getRecordTypeId();
        Map<Id,Decimal> productosOportunidadMontoPromociones = new Map<Id,Decimal>();
        Decimal montoProductosOportunidadPromociones = 0;
        for(Opportunity oportunidad : [SELECT Id, (SELECT Id, Product2.Precio_Venta__c FROM OpportunityLineItems WHERE Product2.RecordTypeId =: tipoRegistroPromocionVenta) FROM Opportunity WHERE Id IN : idsProcesosVenta]){

            for(OpportunityLineItem productoOportunidad : oportunidad.OpportunityLineItems){
                montoProductosOportunidadPromociones = montoProductosOportunidadPromociones + productoOportunidad.Product2.Precio_Venta__c;
            }
            productosOportunidadMontoPromociones.put(oportunidad.Id, montoProductosOportunidadPromociones);
        }

        //Se obtiene el monto de los productos de oportunidad de Tipo de Registro = Productos Genericos y de Tipo de Producto = Otros Gastos relacionados a las oportunidades relacionadas a los registros a crear de Cobranza Comercial
        Id tipoRegistroPaquetes = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Paquetes').getRecordTypeId();
        Map<Id,Decimal> productosOportunidadMontoPaquetes = new Map<Id,Decimal>();
        Decimal montoProductosOportunidadPaquetes = 0;
        for(Opportunity oportunidad : [SELECT Id, (SELECT Id, Product2.Precio_Venta__c FROM OpportunityLineItems WHERE Product2.RecordTypeId =: tipoRegistroPromocionVenta) FROM Opportunity WHERE Id IN : idsProcesosVenta]){

            for(OpportunityLineItem productoOportunidad : oportunidad.OpportunityLineItems){
                montoProductosOportunidadPaquetes = montoProductosOportunidadPaquetes + productoOportunidad.Product2.Precio_Venta__c;
            }
            productosOportunidadMontoPaquetes.put(oportunidad.Id, montoProductosOportunidadPaquetes);
        }

        //Se recorren las cobranzas comerciales a crear para crear los registros de Otra Relacion Cobranza Comercial
        Map<Id,Otra_Relacion_Cobranza_Comercial__c> procesosVentaOtrasRelacionesCobranzaComercial = new Map<Id,Otra_Relacion_Cobranza_Comercial__c>();
        Otra_Relacion_Cobranza_Comercial__c otraRelacionCobranzaComercial = new Otra_Relacion_Cobranza_Comercial__c();
        for(Cobranza_Comercial__c cobranzaComercial : cobranzasComercialesNuevas){

            otraRelacionCobranzaComercial = new Otra_Relacion_Cobranza_Comercial__c();

            //Se asigna el registro de Lista de Precios de tipo de registro Vivienda de la Vivienda
            otraRelacionCobranzaComercial.Lista_Precios_Vivienda_Vivienda__c = (viviendasViviendasListasPrecios.containsKey(procesosVenta.get(cobranzaComercial.Proceso_Venta__c).Plan_de_Venta__r.Vivienda__c) == true ? viviendasViviendasListasPrecios.get(procesosVenta.get(cobranzaComercial.Proceso_Venta__c).Plan_de_Venta__r.Vivienda__c) : null);

            //Se asigna el registro de Lista de Precios de tipo de registro Promocion Precio de la Vivienda
            otraRelacionCobranzaComercial.Lista_Precios_Promocion_Precio_Vivienda__c = (viviendasPromocionPrecioListasPrecios.containsKey(procesosVenta.get(cobranzaComercial.Proceso_Venta__c).Plan_de_Venta__r.Vivienda__c) == true ? viviendasPromocionPrecioListasPrecios.get(procesosVenta.get(cobranzaComercial.Proceso_Venta__c).Plan_de_Venta__r.Vivienda__c) : null);

            //Se asigna el registro de Cobranza Postventa
            otraRelacionCobranzaComercial.Cobranza_Postventa__c = (cobranzasPostventa.containsKey(cobranzaComercial.Proceso_Venta__c) == true ? cobranzasPostventa.get(cobranzaComercial.Proceso_Venta__c).Id : null);

            procesosVentaOtrasRelacionesCobranzaComercial.put(cobranzaComercial.Proceso_Venta__c, otraRelacionCobranzaComercial);
        }
        insert procesosVentaOtrasRelacionesCobranzaComercial.values();

        //Se recorren las cobranzas comerciales a crear para asignarles los datos automaticamente
        for(Cobranza_Comercial__c cobranzaComercial : cobranzasComercialesNuevas){

            //Se asigna el registro de Cuenta
            cobranzaComercial.Cliente__c = procesosVenta.get(cobranzaComercial.Proceso_Venta__c).AccountId;
                
            //Se asigna el registro de Plan de Venta
            // ** HMF / condicionado a que si plan venta viene vacio, aplica codigo de CAPPTUS el 6/6
            if (cobranzaComercial.Plan_Venta__c == null) {
                cobranzaComercial.Plan_Venta__c = procesosVenta.get(cobranzaComercial.Proceso_Venta__c).Plan_de_Venta__c;}

            //Se asigna el registro de Fraccionamiento
            cobranzaComercial.Fraccionamiento__c = procesosVenta.get(cobranzaComercial.Proceso_Venta__c).Plan_de_Venta__r.Vivienda__r.Fraccionamiento__c;

            //Se asigna el registro de Prototipo
            cobranzaComercial.Prototipo__c = procesosVenta.get(cobranzaComercial.Proceso_Venta__c).Plan_de_Venta__r.Vivienda__r.Prototipo__c;

            //Se asigna el registro de Titulacion
            cobranzaComercial.Titulacion__c = (titulaciones.containsKey(cobranzaComercial.Proceso_Venta__c) == true ? titulaciones.get(cobranzaComercial.Proceso_Venta__c).Id : null);

            //Se asigna el registro de Entrega
            cobranzaComercial.Entrega__c = (entregas.containsKey(nombresProcesosVenta.get(cobranzaComercial.Proceso_Venta__c)) == true ? entregas.get(nombresProcesosVenta.get(cobranzaComercial.Proceso_Venta__c)).Id : null);

            //Se asigna el dato del Monto Productos Oportunidad Otros Gastos
            cobranzaComercial.Otros_Gastos__c = (productosOportunidadMontoOtrosGastos.containsKey(cobranzaComercial.Proceso_Venta__c) == true ? productosOportunidadMontoOtrosGastos.get(cobranzaComercial.Proceso_Venta__c) : null);

            //Se asigna el dato del Monto Productos Oportunidad Promociones
            cobranzaComercial.Promociones__c = (productosOportunidadMontoPromociones.containsKey(cobranzaComercial.Proceso_Venta__c) == true ? productosOportunidadMontoPromociones.get(cobranzaComercial.Proceso_Venta__c) : null);

            //Se asigna el dato del Monto Productos Oportunidad Paquetes
            cobranzaComercial.Paquetes__c = (productosOportunidadMontoPaquetes.containsKey(cobranzaComercial.Proceso_Venta__c) == true ? productosOportunidadMontoPaquetes.get(cobranzaComercial.Proceso_Venta__c) : null);

            //Se asigna el registro de Otra Relacion Cobranza Comercial
            cobranzaComercial.Otra_Relacion_Cobranza_Comercial__c = procesosVentaOtrasRelacionesCobranzaComercial.get(cobranzaComercial.Proceso_Venta__c).Id;

            //Se asigna el Sub Estatus del Proceso
            cobranzaComercial.Sub_Estatus_Proceso__c = 'EN_PROGRESO';
        }
    }

    //Metodo que crea los pagares enganche cuando se crea un registro de Cobranza Comercial
    public void creaPagareEnganche(List<Cobranza_Comercial__c> cobranzasComercialesNuevas){

        //Se obtienen los planes de venta asociados a los registros de Cobranza Comercial recien creados
        Set<Id> idsPlanesVenta = new Set <Id>();
        Map<Id,Id> cobranzasComercialesPlanesVenta = new Map<Id,Id>();
        for(Cobranza_Comercial__c cobranzaComercial : cobranzasComercialesNuevas){
            idsPlanesVenta.add(cobranzaComercial.Plan_Venta__c);
            cobranzasComercialesPlanesVenta.put(cobranzaComercial.Id, cobranzaComercial.Plan_Venta__c);
        }

        //Se obtienen los pagares preventa asociados a los planes de venta asociados a los registros de Cobranza Comercial recien creados
        //Map<Id,List<Pagare_Preventa__c>> planVentaPagaresPreventa = new Map<Id,List<Pagare_Preventa__c>>();
        Map<Id,Decimal> planVentaMontoPagaresPreventa = new Map<Id,Decimal>();
        Decimal montoPagaresPreventa = 0;
        for(Plan_de_Venta__c planVenta : [SELECT Id, (SELECT Id, Importe__c FROM Pagares_Preventa__r) FROM Plan_de_Venta__c WHERE Id IN : idsPlanesVenta]){
            //planVentaPagaresPreventa.put(planVenta.Id, planVenta.Pagares_Preventa__r);

            montoPagaresPreventa = 0;
            for(Pagare_Preventa__c pagarePreventa : planVenta.Pagares_Preventa__r){
                montoPagaresPreventa = montoPagaresPreventa + pagarePreventa.Importe__c;
            }
            planVentaMontoPagaresPreventa.put(planVenta.Id, montoPagaresPreventa);
        }

        //Este proceso de creación de Pagarés de Enganche se cometo porque hay un Flow que sustituye a esta funcionalidad
        //Este proceso estaba creando un Pagare de Enganche cuando no debía crearlo
        //Se crean los pagares enganche con el monto de los pagares preventa asociados a los planes de venta asociados a los registros de Cobranza Comercial recien creados
        //List<Documento__c> pagaresNuevos = new List<Documento__c>();
        //for(Id idCobranzaComercial : cobranzasComercialesPlanesVenta.keySet()){

        //    Documento__c pagareNuevo = new Documento__c();
        //    pagareNuevo.Cobranza_Comercial__c = idCobranzaComercial;
        //    pagareNuevo.Importe__c = planVentaMontoPagaresPreventa.get(cobranzasComercialesPlanesVenta.get(idCobranzaComercial));
        //    pagareNuevo.Tipo__c = 'PAGARE_ENGANCHE';
        //    pagareNuevo.Estatus__c = 'Abierto';
        //    pagareNuevo.RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByDeveloperName().get('Pagare').getRecordTypeId();
        //    pagaresNuevos.add(pagareNuevo);
       // }

       // if(pagaresNuevos.size() > 0){
       //     insert pagaresNuevos;
       // }
    }

    //Metodo que elimina los registros de Otra Relacion Cobranza Comercial cuando se va a eliminar un registro de Cobranza Comercial
    public void eliminaOtraRelacionCobranzaComercial(List<Cobranza_Comercial__c> cobranzasComercialesExistentes){

        Set<Id> idsOtrasRelacionesCobranzaComercial = new Set<Id>();
        for(Cobranza_Comercial__c cobranzaComercial : cobranzasComercialesExistentes){

            idsOtrasRelacionesCobranzaComercial.add(cobranzaComercial.Otra_Relacion_Cobranza_Comercial__c);
        }
        System.debug('*****idsOtrasRelacionesCobranzaComercial:' + idsOtrasRelacionesCobranzaComercial);

        List<Otra_Relacion_Cobranza_Comercial__c> otrasRelacionesCobranzaComercial = [SELECT Id FROM Otra_Relacion_Cobranza_Comercial__c WHERE Id IN : idsOtrasRelacionesCobranzaComercial];
        System.debug('*****otrasRelacionesCobranzaComercial:' + otrasRelacionesCobranzaComercial);

        if(otrasRelacionesCobranzaComercial.size() > 0){
            delete otrasRelacionesCobranzaComercial;
        }
    }
}