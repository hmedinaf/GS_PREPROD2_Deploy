public class CPPT_clonar_ListaPrecios {
    public static Id idLista {get; set;}
    public static String callfunc{get;set;}
    
    //constructor para obtener el registro del producto
    public CPPT_clonar_ListaPrecios(ApexPages.StandardController controller) {
        idLista = controller.getId();
    }
    
    /*public PageReference clonarLista() {
        System.debug('+++Id Producto: ' + idLista);
        String nuevaLP = crearListaNueva(idLista);
        PageReference pageRef = new PageReference('/'+ nuevaLP);
        pageRef.setRedirect(true);
        return pageRef;
    }*/

    public static PageReference crearListaNueva(){
        Map<String,String> mapaMeses = New Map<String,String>();
        mapaMeses.put('1', '2');
        mapaMeses.put('2', '3');
        mapaMeses.put('3', '4');
        mapaMeses.put('4', '5');
        mapaMeses.put('5', '6');
        mapaMeses.put('6', '7');
        mapaMeses.put('7', '8');
        mapaMeses.put('8', '9');
        mapaMeses.put('9', '10');
        mapaMeses.put('10', '11');
        mapaMeses.put('11', '12');
        mapaMeses.put('12', '1');
        
        Pricebook2 pb2 = [SELECT Beneficio__c,
                          IVA__c,
                          Porcentaje_Precio_esquina__c,
                          Precio_frente_a_parque__c,
                          Prcentaje_Precio_frente_area_municipal__c,
                          Porcentaje_Precio_instalaciones__c,
                          Procentaje_Precio_lado_sol__c,
                          Porcentaje_Precio_lado_sombra__c,
                          Porcentaje_Precio_sobre_avenida__c,
                          Cantidad__c,
                          IsActive,
                          Casa_Amueblada__c,
                          Check_Precio_Unitario__c,
                          Clase_de_Bonificacion__c,
                          Clase_de_Financiamiento__c,
                          Estatus__c,
                          Estatus_Proceso_de_Venta__c,
                          Estatus_Promocion__c,
                          Fraccionamiento__c,
                          Ilimitado__c,
                          Importe_Financiamiento__c,
                          Monto_Bonificacion__c,
                          Name,
                          Nombre_Lista_Validacion__c,
                          Periodo_Fin__c,
                          Periodo_Inicio__c,
                          Plazos__c,
                          Porcentaje_Bonificacion__c,
                          Porcentaje_Fianciamiento__c,
                          Precio_de_Compra__c,
                          Precio_de_Venta__c,
                          Precio_de_Venta_Sugerido__c,
                          Precio_esquina__c,
                          Precio_frente_a_praque__c,
                          Precio_frente_area_municipal__c,
                          Precio_Instalaciones__c,
                          Precio_lado_sol__c,
                          Precio_lado_sombra__c,
                          Precio_Lista__c,
                          Precio_Min_Autorizado__c,
                          Precio_Min_Solicitado__c,
                          Precio_Presupuesto__c,
                          Precio_sobre_avenida__c,
                          Precio_superficie_excedente__c	,
                          Precio_Total__c,
                          Precio_Total_Excedente__c,
                          Precio_Total_Vivienda__c,
                          Precio_Unitario__c,
                          Presupuesto__c,
                          Prototipo__c,
                          Relacion_Precio_Producto__c,
                          Solicitar_Aprobaci_n__c,
                          Superficie_excedente__c,
                          RecordTypeId,
                          Tipo_de_Bonificacion__c,
                          Tipo_de_Financiamiento__c,
                          Tipo_de_Producto__c,
                          Vigente_Desde__c,
                          Vigente_Hasta__c,
                          Description
                          FROM Pricebook2 WHERE Id =: idLista];
        
        Pricebook2 nuevaLp = new Pricebook2();
        nuevaLP.Beneficio__c = pb2.Beneficio__c;
        nuevaLP.IVA__c = pb2.IVA__c;
        nuevaLP.Porcentaje_Precio_esquina__c = pb2.Porcentaje_Precio_esquina__c;
        nuevaLP.Precio_frente_a_parque__c = pb2.Precio_frente_a_parque__c;
        nuevaLP.Prcentaje_Precio_frente_area_municipal__c = pb2.Prcentaje_Precio_frente_area_municipal__c;
        nuevaLP.Porcentaje_Precio_instalaciones__c = pb2.Porcentaje_Precio_instalaciones__c;
        nuevaLP.Procentaje_Precio_lado_sol__c = pb2.Procentaje_Precio_lado_sol__c;
        nuevaLP.Porcentaje_Precio_lado_sombra__c = pb2.Porcentaje_Precio_lado_sombra__c;
        nuevaLP.Porcentaje_Precio_sobre_avenida__c = pb2.Porcentaje_Precio_sobre_avenida__c;
        nuevaLP.Cantidad__c = pb2.Cantidad__c;
        nuevaLP.IsActive = pb2.IsActive;
        nuevaLP.Casa_Amueblada__c = pb2.Casa_Amueblada__c;
        nuevaLP.Check_Precio_Unitario__c = pb2.Check_Precio_Unitario__c;
        nuevaLP.Clase_de_Bonificacion__c = pb2.Clase_de_Bonificacion__c;
        nuevaLP.Clase_de_Financiamiento__c = pb2.Clase_de_Financiamiento__c;
        nuevaLP.Estatus__c = 'En Progreso';
        //nuevaLP.Estatus_Proceso_de_Venta__c = pb2.Estatus_Proceso_de_Venta__c;
        //nuevaLP.Estatus_Promocion__c = pb2.Estatus_Promocion__c;
        nuevaLP.Fraccionamiento__c = pb2.Fraccionamiento__c;
        nuevaLP.Ilimitado__c = pb2.Ilimitado__c;
        nuevaLP.Importe_Financiamiento__c = pb2.Importe_Financiamiento__c;
        nuevaLP.Monto_Bonificacion__c = pb2.Monto_Bonificacion__c;
        nuevaLP.Name = pb2.Name+ '_copia';
        nuevaLP.Nombre_Lista_Validacion__c = pb2.Nombre_Lista_Validacion__c + '_copia';
        
        //Se calcula el periodo fin proximo
        String periodoFinProximo;
        Date fechaFinProxima_aux;
        if(pb2.Vigente_Hasta__c != null){
            Date fechaFinProxima = Date.valueOf(pb2.Vigente_Hasta__c);
            System.debug('antes fechaFinProxima: ' + fechaFinProxima);
            fechaFinProxima_aux = fechaFinProxima.addMonths(1);
            if(fechaFinProxima_aux.month() == 12){
                fechaFinProxima_aux = fechaFinProxima_aux.addDays(1);
            }
            periodoFinProximo = String.valueOf(fechaFinProxima_aux);
            nuevaLP.Periodo_Fin__c = periodoFinProximo;
            nuevaLP.Vigente_Hasta__c = fechaFinProxima_aux;
            System.debug('pb2.Periodo_Fin__c: ' + pb2.Periodo_Fin__c);
            System.debug('periodoFinProximo: ' + periodoFinProximo);
        }
        System.debug('pb2.Vigente_Desde__c: ' + pb2.Vigente_Desde__c);
        //Se calcula el periodo inicio proximo
        String periodoInicioProximo;
        Date fechaInicioProxima_aux;
        Date fechaInicioProxima;
        if(pb2.Vigente_Desde__c != null){
            fechaInicioProxima = Date.valueOf(pb2.Vigente_Desde__c);
            fechaInicioProxima_aux = fechaInicioProxima;
            periodoInicioProximo = String.valueOf(fechaInicioProxima_aux);
            nuevaLP.Periodo_Inicio__c = periodoInicioProximo;
            nuevaLP.Vigente_Desde__c = fechaInicioProxima_aux;
            System.debug('pb2.Periodo_Inicio__c: ' + pb2.Periodo_Inicio__c);
            System.debug('periodoInicioProximo: ' + periodoInicioProximo);
        }
        nuevaLP.Plazos__c = pb2.Plazos__c;
        nuevaLP.Porcentaje_Bonificacion__c = pb2.Porcentaje_Bonificacion__c;
        nuevaLP.Porcentaje_Fianciamiento__c = pb2.Porcentaje_Fianciamiento__c;
        nuevaLP.Precio_de_Compra__c = pb2.Precio_de_Compra__c;
        nuevaLP.Precio_de_Venta__c = pb2.Precio_de_Venta__c;
        nuevaLP.Precio_de_Venta_Sugerido__c = pb2.Precio_de_Venta_Sugerido__c;
        nuevaLP.Precio_esquina__c = pb2.Precio_esquina__c;
        nuevaLP.Precio_frente_a_praque__c = pb2.Precio_frente_a_praque__c;
        nuevaLP.Precio_frente_area_municipal__c = pb2.Precio_frente_area_municipal__c;
        nuevaLP.Precio_Instalaciones__c = pb2.Precio_Instalaciones__c;
        nuevaLP.Precio_lado_sol__c = pb2.Precio_lado_sol__c;
        nuevaLP.Precio_lado_sombra__c = pb2.Precio_lado_sombra__c;
        nuevaLP.Precio_Lista__c = pb2.Precio_Lista__c;
        nuevaLP.Precio_Min_Autorizado__c = pb2.Precio_Min_Autorizado__c;
        nuevaLP.Precio_Min_Solicitado__c = pb2.Precio_Min_Solicitado__c;
        nuevaLP.Precio_Presupuesto__c = pb2.Precio_Presupuesto__c;
        nuevaLP.Precio_sobre_avenida__c = pb2.Precio_sobre_avenida__c;
        nuevaLP.Precio_superficie_excedente__c = pb2.Precio_superficie_excedente__c;
        nuevaLP.Precio_Total__c = pb2.Precio_Total__c;
        nuevaLP.Precio_Unitario__c = pb2.Precio_Unitario__c;
        nuevaLP.Presupuesto__c = pb2.Presupuesto__c;
        nuevaLP.Prototipo__c = pb2.Prototipo__c;
        nuevaLP.Relacion_Precio_Producto__c = pb2.Relacion_Precio_Producto__c;
        nuevaLP.Solicitar_Aprobaci_n__c = pb2.Solicitar_Aprobaci_n__c;
        nuevaLP.Superficie_excedente__c = pb2.Superficie_excedente__c;
        nuevaLP.RecordTypeId = pb2.RecordTypeId;
        nuevaLP.Tipo_de_Bonificacion__c = pb2.Tipo_de_Bonificacion__c;
        nuevaLP.Tipo_de_Financiamiento__c = pb2.Tipo_de_Financiamiento__c;
        nuevaLP.Tipo_de_Producto__c = pb2.Tipo_de_Producto__c;
        nuevaLP.Description = pb2.Description;
        
        
        insert nuevaLP;
        System.debug('Se inserta lista');
        
        List<PricebookEntry> entradasNuevas = new List<PricebookEntry>();
        Set<Id> idProds = new Set<Id>();
        List<PricebookEntry> obtenerPbe = new List<PricebookEntry>([SELECT Id, Product2Id, Product2.Name FROM PricebookEntry WHERE Pricebook2Id=:idLista]);
        for(PriceBookEntry pEntry: obtenerPbe){
            idProds.add(pEntry.Product2Id);
        }
        System.debug('idProds: ' + idProds);
        List<Product2> prods = new List<Product2>([SELECT Id, Name, Precio_Venta__c, Precio_de_Compra__c FROM Product2 WHERE Id IN: idProds]);
        System.debug('prods: ' + prods);
        for(Product2 p : prods){
            PricebookEntry pb = new PricebookEntry();
            pb.Pricebook2Id=nuevaLP.Id;
            System.debug(pb.Product2Id=p.Id);
            pb.Product2Id=p.Id;
            pb.IsActive=true;
            pb.UnitPrice=0;
            pb.UseStandardPrice=false;
            entradasNuevas.add(pb);
        }
        System.debug('entradasNuevas: ' + entradasNuevas);
        System.debug('Se inserta entradas');
        insert entradasNuevas; 
        
        callfunc='<script> func(); </script>';
        
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Se ha clonado con exito la lista de precios ' + NuevaLP.Name));
        PageReference pageRef = new PageReference('/'+ nuevaLP.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
}