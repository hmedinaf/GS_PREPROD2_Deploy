public class CLASS_Calc_Precios {
    public static void CLASS_Calc_Precios(Id planVentaId) {

        List <Plan_de_Venta__c> lstPlanDeVenta = [SELECT Id, Oportunidad__c, Lista_de_Precios_Vivienda_Reciente__c,
            Lista_de_Precios_Bonificacion_Reciente__r.Monto_Bonificacion__c,
            Lista_de_Precios_Financiamien_Reciente__r.Importe_Financiamiento__c,
            Lista_de_Precios_Financiamien_Reciente__r.Porcentaje_Fianciamiento__c,
            Area_Municipal__c, Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_Area_Municipal__c,
            Lista_de_Precios_Vivienda__r.Precio_Lista__c,
            Esquina__c, Lista_de_Precios_Vivienda__r.CALC_Precio_Esquina__c,
            Frente_Parque__c, Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_a_Parque__c,
            Instalaciones__c, Lista_de_Precios_Vivienda__r.CALC_Precio_Instalaciones__c,
            Lado_Sol__c, Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sol__c,
            Precio_Lado_Sombra__c, Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sombra__c,
            Lista_de_Precios_Promo_Precio_Reciente__r.Precio_Min_Solicitado__c,
            Vivienda__r.Precio_Total_Excedente__c,
            Sobre_Avenida__c, Lista_de_Precios_Vivienda__r.CALC_Precio__c,
            Lista_de_Precios_Vivienda__r.CALC_Precio_Superficie_Excedente__c,
            Vivienda__r.Precio_Unitario__c
            FROM Plan_de_Venta__c WHERE id = :planVentaId];
        Plan_de_Venta__c planDeVenta = lstPlanDeVenta[0];

        List <Opportunity> lstProcesoVenta = [SELECT Id FROM Opportunity WHERE id = :planDeVenta.Oportunidad__c];
        Opportunity procesoVenta = lstProcesoVenta[0];

        List <Pricebook2> lstPricebook = [SELECT Name, Fraccionamiento__c, Prototipo__c, Precio_Lista__c, Porcentaje_Precio_instalaciones__c, Precio_Instalaciones__c, Porcentaje_Precio_esquina__c, Precio_esquina__c,
            Prcentaje_Precio_frente_area_municipal__c, Precio_frente_area_municipal__c, Precio_frente_a_parque__c, Precio_frente_a_praque__c, 
            Procentaje_Precio_lado_sol__c, Precio_lado_sol__c, Porcentaje_Precio_lado_sombra__c, Precio_lado_sombra__c, 
            Porcentaje_Precio_sobre_avenida__c, Precio_sobre_avenida__c, Porcentaje_Precio_Superficie_Excedente__c, Precio_superficie_excedente__c,
            CALC_Precio_Esquina__c,CALC_Precio_Frente_Area_Municipal__c,CALC_Precio_Frente_a_Parque__c,CALC_Precio_Instalaciones__c,CALC_Precio_Lado_Sol__c,
            CALC_Precio_Lado_Sombra__c,CALC_Precio_Superficie_Excedente__c,CALC_Precio__c 
            FROM Pricebook2 WHERE id = :plandeVenta.Lista_de_Precios_Vivienda_Reciente__c];
        Pricebook2 pb = lstPricebook[0];

        List<Vivienda__c> lstViviendas = [SELECT Id, Name, Fraccionamiento__r.Name, Prototipo__r.Name, Prototipo__r.Precio_Presupuesto__c, Manzana__c, Lote__c, 
            Num_Interior__c, Unidad_Privativa__c, Precio_Total_F__c, Precio_Unitario__c, Check_Precio_Unitario__c, Superficie_Excedente__c, 
            Precio_Total_Excedente__c, Esquina__c, Frente_rea__c, Frente_Parque__c, Lado_Sol__c, Lado_Sombra__c, 
            Sobre_Avenida__c, Valor_Vivienda__c, Precio_Unitario_Chk_Img__c FROM Vivienda__c 
            WHERE Fraccionamiento__c =: pb.Fraccionamiento__c AND Prototipo__c =: pb.Prototipo__c AND Estatus__c = '17'];


        decimal trCalc_Monto_Desc_Preautorizado = planDeVenta.Lista_de_Precios_Bonificacion_Reciente__r.Monto_Bonificacion__c;
        decimal trCalc_Monto_Fin_Autorizado = planDeVenta.Lista_de_Precios_Financiamien_Reciente__r.Importe_Financiamiento__c;
        decimal trCalc_Porcentaje_Fin_Autorizado = planDeVenta.Lista_de_Precios_Financiamien_Reciente__r.Porcentaje_Fianciamiento__c;
        decimal trCalc_Precio_Area_Municipal = planDeVenta.Area_Municipal__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_Area_Municipal__c : 0;
        decimal trCalc_Precio = planDeVenta.Lista_de_Precios_Vivienda__r.Precio_Lista__c;
        decimal trCalc_Precio_Esquina = planDeVenta.Esquina__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Esquina__c : 0;
        decimal trCalc_Precio_Frente_Parque = planDeVenta.Frente_Parque__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Frente_a_Parque__c : 0;
        decimal trCalc_Precio_Instalaciones = planDeVenta.Instalaciones__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Instalaciones__c : 0;
        decimal trCalc_Precio_Lado_Sol = planDeVenta.Lado_Sol__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sol__c : 0;
        decimal trCalc_Precio_Lado_Sombra = planDeVenta.Lado_Sombra__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Lado_Sombra__c : 0;
        decimal trCalc_Precio_minimo_solicitado = planDeVenta.Lista_de_Precios_Promo_Precio_Reciente__r.Precio_Min_Solicitado__c;
        decimal trCalc_Precio_por_m2_exc = planDeVenta.Vivienda__r.Precio_Total_Excedente__c;
        decimal trCalc_Precio_Sobre_Avenida = planDeVenta.Sobre_Avenida__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio__c : 0;
        decimal trCalc_Precio_Superficie_Excedente = planDeVenta.Sobre_Avenida__c ? planDeVenta.Lista_de_Precios_Vivienda__r.CALC_Precio_Superficie_Excedente__c : 0;
        decimal trCalc_Precio_Unitario = planDeVenta.Vivienda__r.Precio_Unitario__c;
        decimal trCalc_Precio_Venta_Normal = planDeVenta.Vivienda__r.Precio_Unitario__c > 1 ? planDeVenta.Vivienda__r.Precio_Unitario__c : planDeVenta.Lista_de_Precios_Vivienda__r.Precio_Lista__c + planDeVenta.Importe_Condiciones_Especiales__c;

        //Precio de Lista.-"Precio de lista" (sin condiciones especiales) de la vivienda de acuerdo a la lista de precios que tiene al momento de haberse reservado en el plan de venta. 
        // "Importe Condiciones Especiales.-  Dato calculado de la siguiente fórmula: (Esquina +  Sobre Avenida + Sobre Parque +  Lado Sol +Lado Sombra + +  Instalaciones)"
        // "Terreno Excedente.- Dato calculado m2 excedentes * Precio por m2 exc Precio por m2 exc proviene del precio total excedente de la lista de precios vivienda (Módulo Administración de Precios)

        // Paquetes: es la suma del precio "Total" de los productos de tipo Paquete asignados al plan de venta
        // Promociones: es la suma del precio "Total" de los productos de tipo Promociones asignados al plan de venta
        // Regalos MKT:   es la suma del precio "Total" de los productos de tipo regalos MKT asignados al plan de venta
        // Complementos: es la suma del precio "Total" de los productos de tipo Complementos asignados al plan de venta
        // Casa Muestra: es la suma del precio "Total" de los productos de tipo Casa Muestra asignados al plan de venta
        // Otros Gastos: es la suma del precio "Total" de los productos de tipo Otros Gastos asignados al plan de venta
        // Bonificación.- Es el "Monto Descuento registrado en el plan de venta"

        // Valor de Operación.- Dato Calculado de la siguiente fórmula:
        // (((((Precio Unitario o Promoción de precio o Precio Venta Anticipada + Terreno excedente + Importe condiciones especiales)- Bonificación aplicada) – (Importe Descuento Empleado Javer) + Paquete + Promociones de Venta + Complementos + Otros Gastos + Casa Muestra"

        // "Total de Gastos.- Campo calculado que resulta de la siguiente fórmula de la Financiera ""1"":
        // (Gastos Orig Crédito +  Impuestos/Derechos +  Gastos de Escritura + Avalúo)"

        // "Crédito Neto Final.- Campo calculado que resulta de la siguiente fórmula de la Financiera ""1"":
        // (Monto de Crédito +  Subcuenta Vivienda +  Ahorro voluntario) -  Total de Gastos"

        // "Total de Gastos 2.- Campo calculado que resulta de la siguiente fórmula de la Financiera ""2"":
        // (Gastos Orig Crédito +  Impuestos/Derechos +  Gastos de Escritura + Avalúo)"

        // "Crédito Neto Final.- Campo calculado que resulta de la siguiente fórmula de la Financiera ""2"":
        // (Monto de Crédito +  Subcuenta Vivienda +  Ahorro voluntario) -  Total de Gastos"

        // "Total de Gastos.- Campo calculado que resulta de la siguiente fórmula de la Financiera ""3"":
        // (Gastos Orig Crédito +  Impuestos/Derechos +  Gastos de Escritura + Avalúo)"

        // "Crédito Neto Final.- Campo calculado que resulta de la siguiente fórmula de la Financiera ""3"":
        // (Monto de Crédito +  Subcuenta Vivienda +  Ahorro voluntario) -  Total de Gastos"

        // "Procentaje a Financiar.- Es el porcentaje que realmente se le va a financiar al cliente. Dato calculado resultante de la siguiente fórmula:
        // (Diferencia a Pagar / Valor de Operación) * 100"

        // "Importe del Pago.-Dato calculado resultante de las siguiente fórmula:
        // (Diferencia a Pagar / Plazo)"


        //Total de Gastos
        //"Total de Gastos= (Gastos Orig Crédito +  Impuestos/Derechos +  Gastos de Escritura + Avalúo).  
        // Referente a la precalificación del crédito del cliente.
        // ** Campo calculado por Financiera 1 , 2 o 3 según corresponda"

        // Credito Neto Final
        // "Crédito Neto Final = (Monto de Crédito +  Subcuenta Vivienda +  Ahorro voluntario) -  Total de Gastos
        // Referente a la precalificación del crédito del cliente.
        // ** Campo calculado por Financiera 1 , 2 o 3 según corresponda"

        // Enganche a Pagar
        // Valor de Operación - [(Crédito Neto Final Financiera 1 + Crédito Neto Final Financiera 2 +  Crédito Neto Final Financiera 3 + Subsidio + Anticipo) - (Total de Gastos Financiera 1 + Total de Gastos Financiera 2 + Total de Gastos Financiera 3)]"
        // "Enganche a Pagar.- Campo calculado que resulta de la siguiente fórmula:
        // Valor de Operación - [(Crédito Neto Final Financiera 1 + Crédito Neto Final Financiera 2 +  Crédito Neto Final Financiera 3 + Subsidio + Anticipo) - (Total de Gastos Financiera 1 + Total de Gastos Financiera 2 + Total de Gastos Financiera 3)]"

        // Precio Unitario
        // Está mostrando el precio total de producto (módulo Productos), debe mostrar el Precio de Venta del mismo.

        // Monto Descuento
        // Aparece habilitado y se le puede registrar y grabar importe aunque la clase bonificación de la lista de precios correspondiente se haya configurado de clase porcentaje
        // El monto de descuento, debe disminuir el valor de operación conforme a la fórmula de este, y no lo está restando
    }
}


        /*
        Decimal montoInstalaciones = 0;
        Decimal montoEsquina = 0;
        Decimal montoAreaMunicipal = 0;
        Decimal montoFrenteParque = 0;
        Decimal montoLadoSol = 0;
        Decimal montoadoSombra = 0;
        Decimal montoSobreAvenida = 0;
        // if (listaViviendas[i].Prototipo__r.Precio_Presupuesto__c!=null){
        //     if(pb.Porcentaje_Precio_instalaciones__c != null) montoInstalaciones = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c * pb.Porcentaje_Precio_instalaciones__c;
        //     if(pb.Porcentaje_Precio_esquina__c != null) montoEsquina = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c * pb.Porcentaje_Precio_esquina__c;
        //     if(pb.Prcentaje_Precio_frente_area_municipal__c != null) montoAreaMunicipal = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c * pb.Prcentaje_Precio_frente_area_municipal__c;
        //     if(pb.Precio_frente_a_parque__c != null) montoFrenteParque = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c * pb.Precio_frente_a_parque__c;
        //     if(pb.Procentaje_Precio_lado_sol__c != null) montoLadoSol = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c * pb.Procentaje_Precio_lado_sol__c;
        //     if(pb.Porcentaje_Precio_lado_sombra__c != null) montoadoSombra = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c * pb.Porcentaje_Precio_lado_sombra__c;
        //     if(pb.Porcentaje_Precio_sobre_avenida__c != null) montoSobreAvenida = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c * pb.Porcentaje_Precio_sobre_avenida__c;
        // }
        Decimal precioInstalaciones = 0;
        Decimal precioEsquina = 0;
        Decimal precioAreaMunicipal = 0;
        Decimal precioFrenteParque = 0;
        Decimal precioLadoSol = 0;
        Decimal precioLadoSombra = 0;
        Decimal precioSobreAvenida = 0;
        Decimal precioSuperficieExcedente = 0;
        Decimal precioTotal = 0;

        precioInstalaciones = pb.CALC_Precio_Instalaciones__c;
        precioEsquina = pb.CALC_Precio_esquina__c;
        precioAreaMunicipal = pb.CALC_Precio_frente_area_municipal__c;
        precioFrenteParque = pb.CALC_Precio_Frente_a_Parque__c;
        precioLadoSol = pb.CALC_Precio_Lado_Sol__c;
        precioLadoSombra = pb.CALC_Precio_Lado_Sombra__c;
        precioSobreAvenida = pb.CALC_Precio__c;

        if(pb.Precio_superficie_excedente__c != null){
            vi.precio_total_excedente = (v.Superficie_Excedente__c * pb.CALC_Precio_Superficie_Excedente__c).setScale(2);
        // }else if(pb.Porcentaje_Precio_Superficie_Excedente__c != null && pb.Precio_superficie_excedente__c == null){
        //     Decimal precioPorcentajeExcedente = listaViviendas[i].Prototipo__r.Precio_Presupuesto__c;
        //     Decimal auxCalculoPrecioExcedente = pb.Porcentaje_Precio_Superficie_Excedente__c * precioPorcentajeExcedente;
        //     Decimal calculeExcdenteFinal = auxCalculoPrecioExcedente * listaViviendas[i].Superficie_Excedente__c;
        //     vi.precio_total_excedente = calculeExcdenteFinal.setScale(2);
        } else {
            vi.precio_total_excedente = 0;
        }

        if(pb.Precio_superficie_excedente__c != null) {
            precioSuperficieExcedente = pb.CALC_Precio_superficie_excedente__c;
        } else {
            precioSuperficieExcedente=0;
        }

        vi.precio_total_sup_exc = precioSuperficieExcedente * v.Superficie_Excedente__c;

        vi.precio_total = pb.Precio_Lista__c + vi.precio_total_sup_exc;

        Decimal valorTotalVivienda=0;

        valorTotalVivienda = pb.Precio_Lista__c + vi.precio_total_excedente +
        precioInstalaciones + precioEsquina + precioAreaMunicipal + precioFrenteParque + precioLadoSol + precioLadoSombra + precioSobreAvenida;
        // montoInstalaciones + montoEsquina + montoAreaMunicipal + montoFrenteParque + montoLadoSol + montoadoSombra + montoSobreAvenida +

        //vi.precio_total = valorTotalVivienda.setScale(2);
        vi.precio_unitario = v.Precio_Unitario__c==null ? 0 : v.Precio_Unitario__c;
        vi.chk_precio_unitario = v.Check_Precio_Unitario__c;
        vi.sup_excedente = v.Superficie_Excedente__c==null ? 0 : v.Superficie_Excedente__c;

        if (v.Check_Precio_Unitario__c == FALSE) {
            //precio unitario = precio de Lista
            vi.precio_unitario = pb.Precio_Lista__c;
        }

        vi.precio_total_vivienda = valorTotalVivienda;

        vi.precio_total_unitario = vi.precio_unitario + vi.precio_total_excedente +
            precioInstalaciones + precioEsquina + precioAreaMunicipal + precioFrenteParque + precioLadoSol + precioLadoSombra + precioSobreAvenida;
        
        vi.image = v.Precio_Unitario_Chk_Img__c;

*/