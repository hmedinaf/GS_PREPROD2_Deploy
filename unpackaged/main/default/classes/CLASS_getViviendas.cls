public class CLASS_getViviendas {
    public List<Vivienda> viviendas {get; set;}
    
    @AuraEnabled 
    public static String getRelatedList(Id recordId)
    {
        Id tipoLista = [SELECT Id, Relacion_Precio_Producto__r.Id, RecordtypeId FROM Pricebook2 WHERE Id = : recordId].RecordtypeId;
        Id idRelacion = [SELECT Id, Relacion_Precio_Producto__r.Id FROM Pricebook2 WHERE Id = : recordId].Relacion_Precio_Producto__r.Id;        
        String nombreTr = [SELECT Name FROM RecordType WHERE Id =: tipoLista].Name;
        return nombreTr;
    }
    
    @AuraEnabled
    public static list<Vivienda> getProductosVivienda(Id recordId){
        System.debug('recordId: ' + recordId );
        Pricebook2 pb = [SELECT Name, Fraccionamiento__c, Prototipo__c, Precio_Lista__c, Porcentaje_Precio_instalaciones__c, Precio_Instalaciones__c, Porcentaje_Precio_esquina__c, Precio_esquina__c,
                         Prcentaje_Precio_frente_area_municipal__c, Precio_frente_area_municipal__c, Precio_frente_a_parque__c, Precio_frente_a_praque__c, 
                         Procentaje_Precio_lado_sol__c, Precio_lado_sol__c, Porcentaje_Precio_lado_sombra__c, Precio_lado_sombra__c, 
                         Porcentaje_Precio_sobre_avenida__c, Precio_sobre_avenida__c, Porcentaje_Precio_Superficie_Excedente__c, Precio_superficie_excedente__c,
                         CALC_Precio_Esquina__c,CALC_Precio_Frente_Area_Municipal__c,CALC_Precio_Frente_a_Parque__c,CALC_Precio_Instalaciones__c,CALC_Precio_Lado_Sol__c,
                         CALC_Precio_Lado_Sombra__c,CALC_Precio_Superficie_Excedente__c,CALC_Precio__c 
                         FROM Pricebook2 WHERE Id = :recordId LIMIT 1];
        
        System.debug('Lista de precios: ' + pb);
        List<Vivienda__c> listaViviendas = [SELECT Id, Name, Fraccionamiento__r.Name, Prototipo__r.Name, Prototipo__r.Precio_Presupuesto__c, Manzana__c, Lote__c, 
                                            Num_Interior__c, Unidad_Privativa__c, Precio_Total_F__c, Precio_Unitario__c, Check_Precio_Unitario__c, Superficie_Excedente__c, 
                                            Precio_Total_Excedente__c, Instalaciones__c, Esquina__c, Frente_rea__c, Frente_Parque__c, Lado_Sol__c, Lado_Sombra__c, 
                                            Sobre_Avenida__c, Valor_Vivienda__c, Precio_Unitario_Chk_Img__c, Excendente_M2__c FROM Vivienda__c 
                                            WHERE Fraccionamiento__c =: pb.Fraccionamiento__c AND Prototipo__c =: pb.Prototipo__c AND Estatus__c = '17'];
        System.debug('listaViviendas: ' + listaViviendas);
        List<Vivienda> viviendas = new List<Vivienda>();
        Integer i = 0;
        for(Vivienda__c v : listaViviendas){
            Vivienda vi = new Vivienda();
            
            vi.nombre = v.Name;
            vi.fraccionamiento = v.Fraccionamiento__r.Name;
            vi.prototipo = v.Prototipo__r.Name;
            vi.manzana = v.Manzana__c;
            vi.lote = v.Lote__c;
            vi.no_int = v.Num_Interior__c;
            vi.u_privativa = v.Unidad_Privativa__c;
            vi.precio_total_excedente = 0;
            //Calculando el precio total de viviendas
            //Se obtienen los montos de los porcentajes
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
            
            if (v.Instalaciones__c) precioInstalaciones = pb.CALC_Precio_Instalaciones__c;
            if (v.Esquina__c) precioEsquina = pb.CALC_Precio_esquina__c;
            if (v.Frente_rea__c) precioAreaMunicipal = pb.CALC_Precio_frente_area_municipal__c;
            if (v.Frente_Parque__c) precioFrenteParque = pb.CALC_Precio_Frente_a_Parque__c;
            if (v.Lado_Sol__c) precioLadoSol = pb.CALC_Precio_Lado_Sol__c;
            if (v.Lado_Sombra__c) precioLadoSombra = pb.CALC_Precio_Lado_Sombra__c;
            if (v.Sobre_Avenida__c) precioSobreAvenida = pb.CALC_Precio__c;
            
            if(v.Excendente_M2__c!=null && pb.CALC_Precio_Superficie_Excedente__c!=null){
                vi.precio_total_excedente = (v.Excendente_M2__c * pb.CALC_Precio_Superficie_Excedente__c).setScale(2);
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

            if (v.Superficie_Excedente__c!=null) {
                vi.precio_total_sup_exc = precioSuperficieExcedente * v.Superficie_Excedente__c;
            } else {
                vi.precio_total_sup_exc = 0;
            }


            // if (v.Superficie_Excedente__c!=null) {
            //     vi.precio_total_sup_exc = v.Superficie_Excedente__c * precioSuperficieExcedente;
            //     vi.precio_total = pb.Precio_Lista__c + vi.precio_total_sup_exc;
            // } else {
            //     vi.precio_total_sup_exc=0;
            //     vi.precio_total=0;
            // }

            vi.precio_total = pb.Precio_Lista__c + vi.precio_total_sup_exc;

            Decimal valorTotalVivienda=0;
            // valorTotalVivienda = pb.Precio_Lista__c + vi.precio_total_excedente +
            //     montoInstalaciones + montoEsquina + montoAreaMunicipal + montoFrenteParque + montoLadoSol + montoadoSombra + montoSobreAvenida +
            //     precioInstalaciones + precioEsquina + precioAreaMunicipal + precioFrenteParque + precioLadoSol + precioLadoSombra + precioSobreAvenida;

            // Nota error incidente LISTA DE PRECIOS fila J293
            //Precio total de vivienda = Precio lista + condiciones especiales (Precio Instalaciones, precio esquina, precio frente área municipal, 
            //    precio frenta a parque , precio lado sol, precio lado sombra, precio sobre avenida) + precio total excedente

            valorTotalVivienda = pb.Precio_Lista__c + vi.precio_total_excedente +
                precioInstalaciones + precioEsquina + precioAreaMunicipal + precioFrenteParque + precioLadoSol + precioLadoSombra + precioSobreAvenida;
                // montoInstalaciones + montoEsquina + montoAreaMunicipal + montoFrenteParque + montoLadoSol + montoadoSombra + montoSobreAvenida +

            //vi.precio_total = valorTotalVivienda.setScale(2);
            vi.precio_unitario = v.Precio_Unitario__c==null ? 0 : v.Precio_Unitario__c;
            vi.chk_precio_unitario = v.Check_Precio_Unitario__c;
            vi.sup_excedente = v.Excendente_M2__c==null ? 0 : v.Excendente_M2__c;

            if (v.Check_Precio_Unitario__c == FALSE) {
                //precio unitario = precio de Lista
                vi.precio_unitario = pb.Precio_Lista__c;
            }

            vi.precio_total_vivienda = valorTotalVivienda;

            vi.precio_total_unitario = vi.precio_unitario + vi.precio_total_excedente +
                precioInstalaciones + precioEsquina + precioAreaMunicipal + precioFrenteParque + precioLadoSol + precioLadoSombra + precioSobreAvenida;
            
            vi.image = v.Precio_Unitario_Chk_Img__c;


            viviendas.add(vi);
            i++;
        }
        System.debug('### viviendas: ' + viviendas);
        return viviendas;
    }
    
    public class Vivienda {
        @AuraEnabled
        public String nombre {get;set;}
        @AuraEnabled
        public String fraccionamiento {get;set;}
        @AuraEnabled
        public String prototipo {get;set;}
        @AuraEnabled
        public String manzana {get;set;}
        @AuraEnabled
        public String lote {get;set;}
        @AuraEnabled
        public String no_int {get;set;}
        @AuraEnabled
        public String u_privativa {get;set;}
        @AuraEnabled
        public Double precio_total {get;set;}
        @AuraEnabled
        public Double precio_unitario {get;set;}
        @AuraEnabled
        public Boolean chk_precio_unitario {get;set;}
        @AuraEnabled
        public Double sup_excedente {get;set;}
        @AuraEnabled
        public Double precio_total_excedente {get;set;}
        @AuraEnabled
        public Double precio_prsupuesto {get;set;}
        @AuraEnabled
        public Double valor_vivienda {get;set;}
        @AuraEnabled
        public String image {get;set;}
        @AuraEnabled
        public Double precio_total_vivienda {get;set;}
        @AuraEnabled
        public Double precio_total_sup_exc {get;set;}
        @AuraEnabled
        public Double precio_total_unitario {get;set;}
    }
}