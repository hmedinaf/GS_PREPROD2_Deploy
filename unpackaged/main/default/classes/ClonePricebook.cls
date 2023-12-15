public class ClonePricebook {
    @AuraEnabled
    public static String clonePb(string pId, Date fDate, Date SDate){
        List<PricebookEntry> pbeList = new List<PricebookEntry>(); Set<Id> prodId = new Set<Id>();
        string message = '';
        try {
            Map<String, string> monthMap = new Map<string, string>(); 
            
            monthMap.put('ENERO', 'FEBRERO');monthMap.put('FEBRERO', 'MARZO');  monthMap.put('MARZO', 'ABRIL'); monthMap.put('ABRIL', 'MAYO'); monthMap.put('MAYO', 'JUNIO'); monthMap.put('JUNIO', 'JULIO');
            monthMap.put('JULIO', 'AGOSTO');  monthMap.put('AGOSTO', 'SEPTIEMBRE');  monthMap.put('SEPTIEMBRE', 'OCTUBRE');monthMap.put('OCTUBRE', 'NOVIEMBRE'); 
            monthMap.put('NOVIEMBRE', 'DICIEMBRE'); monthMap.put('DICIEMBRE', 'ENERO');
            
            Pricebook2 pb2 = [SELECT Id,Beneficio__c,IVA__c, Porcentaje_Precio_esquina__c, Precio_frente_a_parque__c, Prcentaje_Precio_frente_area_municipal__c, Porcentaje_Precio_instalaciones__c,
                              Procentaje_Precio_lado_sol__c, Porcentaje_Precio_lado_sombra__c, Porcentaje_Precio_sobre_avenida__c, Cantidad__c, IsActive,Casa_Amueblada__c,
                              Check_Precio_Unitario__c, Clase_de_Bonificacion__c, Clase_de_Financiamiento__c,Estatus__c, Estatus_Proceso_de_Venta__c, Estatus_Promocion__c, Fraccionamiento__c,
                              Ilimitado__c, Importe_Financiamiento__c, Monto_Bonificacion__c, Name, Nombre_Lista_Validacion__c, Periodo_Fin__c,Periodo_Inicio__c, Plazos__c,
                              Porcentaje_Bonificacion__c,Porcentaje_Fianciamiento__c,Precio_de_Compra__c, Precio_de_Venta__c, Precio_de_Venta_Sugerido__c,Precio_esquina__c,
                              Precio_frente_a_praque__c, Precio_frente_area_municipal__c, Precio_Instalaciones__c,Precio_lado_sol__c, Precio_lado_sombra__c,Precio_Lista__c, Precio_Min_Autorizado__c,
                              Precio_Min_Solicitado__c,Precio_Presupuesto__c, Precio_sobre_avenida__c, Precio_superficie_excedente__c, Precio_Total__c,Precio_Total_Excedente__c,
                              Precio_Total_Vivienda__c, Precio_Unitario__c,Presupuesto__c, Prototipo__c,Relacion_Precio_Producto__c,Solicitar_Aprobaci_n__c,Superficie_excedente__c,
                              RecordTypeId,Tipo_de_Bonificacion__c, Tipo_de_Financiamiento__c,Tipo_de_Producto__c,Vigente_Desde__c,Vigente_Hasta__c,Description, Porcentaje_Precio_Superficie_Excedente__c,
                              Fecha_de_Aprobacion__c,Fraccinamiento_Vigencia__c,Nombre_Trunc__c,Precio_Comercial_sin_Mts2__c,Precio_Presupuesto_F__c, RecordType.Name
                              FROM Pricebook2 WHERE Id =: pId];
            String periodoFinProximo;  Date fechaFinProxima_aux;   String periodoInicioProximo; Date fechaInicioProxima_aux; Date fechaInicioProxima;
            Pricebook2 pb = new Pricebook2();
            pb.Beneficio__c = pb2.Beneficio__c;
            pb.IVA__c = pb2.IVA__c;
            pb.Porcentaje_Precio_esquina__c = pb2.Porcentaje_Precio_esquina__c;
            pb.Precio_frente_a_parque__c = pb2.Precio_frente_a_parque__c;
            pb.Prcentaje_Precio_frente_area_municipal__c = pb2.Prcentaje_Precio_frente_area_municipal__c;
            pb.Porcentaje_Precio_instalaciones__c = pb2.Porcentaje_Precio_instalaciones__c;
            pb.Procentaje_Precio_lado_sol__c = pb2.Procentaje_Precio_lado_sol__c;
            pb.Porcentaje_Precio_lado_sombra__c = pb2.Porcentaje_Precio_lado_sombra__c;
            pb.Porcentaje_Precio_sobre_avenida__c = pb2.Porcentaje_Precio_sobre_avenida__c;
            pb.Cantidad__c = pb2.Cantidad__c;
            pb.IsActive = true;
            pb.Casa_Amueblada__c = pb2.Casa_Amueblada__c;
            pb.Check_Precio_Unitario__c = pb2.Check_Precio_Unitario__c;
            pb.Clase_de_Bonificacion__c = pb2.Clase_de_Bonificacion__c;
            pb.Clase_de_Financiamiento__c = pb2.Clase_de_Financiamiento__c;
            pb.Estatus__c = 'En Progreso';
            pb.Estatus_Proceso_de_Venta__c = pb2.Estatus_Proceso_de_Venta__c;
            pb.Estatus_Promocion__c = pb2.Estatus_Promocion__c;
            pb.Fraccionamiento__c = pb2.Fraccionamiento__c;
            pb.Ilimitado__c = pb2.Ilimitado__c;
            pb.Importe_Financiamiento__c = pb2.Importe_Financiamiento__c;
            pb.IsActive  = True;
            pb.Lista_Duplicada__c  = True;
            pb.Lista_de_Precios_Origen__c = pb2.id ;
            pb.Monto_Bonificacion__c = pb2.Monto_Bonificacion__c;
            pb.Name = pb2.Name+ '_copia';
            pb.Nombre_Lista_Validacion__c = pb2.Nombre_Lista_Validacion__c + '_copia';
            pb.Fecha_de_Aprobacion__c = null;
            system.debug('pb2.Periodo_Fin__c '+pb2.Periodo_Fin__c ); 
            if(pb2.Periodo_Fin__c != null){
                if(pb2.Periodo_Fin__c.contains('-')){
                    Date fechaFinProxima = Date.valueOf(pb2.Periodo_Fin__c);
                    fechaFinProxima_aux = fechaFinProxima.addMonths(1);
                    if(fechaFinProxima_aux.month() == 12){
                        fechaFinProxima_aux = fechaFinProxima_aux.addDays(1);
                    }
                    periodoFinProximo = String.valueOf(fechaFinProxima_aux); 
                    pb.Periodo_Fin__c = periodoFinProximo;
                }
                else{
                    String monthName =  pb2.Periodo_Fin__c.substringBefore(' ');  Integer yearName =  Integer.valueOf(pb2.Periodo_Fin__c.substringAfter(' '));
                    String nxtnmonth = monthMap.get(monthName);
                    if( monthName == 'DICIEMBRE'){
                        yearName = yearName+1;
                    }
                    pb.Periodo_Fin__c = String.valueOf(nxtnmonth + ' '+ yearName);
                }
            }
            if(pb2.Periodo_Inicio__c != null){
                if(pb2.Periodo_Fin__c.contains('-')){
                    fechaInicioProxima = Date.valueOf(pb2.Periodo_Inicio__c);
                    fechaInicioProxima_aux = fechaInicioProxima.addMonths(1);
                    periodoInicioProximo = String.valueOf(fechaInicioProxima_aux); 
                    pb.Periodo_Inicio__c = periodoInicioProximo;
                }
                else{
                    String monthName1 =  pb2.Periodo_Inicio__c.substringBefore(' ');  Integer yearName1 =  Integer.valueOf(pb2.Periodo_Inicio__c.substringAfter(' '));
                    String nxtnmonth1 = monthMap.get(monthName1);
                    pb.Periodo_Inicio__c = String.valueOf(nxtnmonth1 + ' '+ yearName1);
                }
            }
            pb.Plazos__c = pb2.Plazos__c;
            pb.Porcentaje_Bonificacion__c = pb2.Porcentaje_Bonificacion__c;
            pb.Porcentaje_Fianciamiento__c = pb2.Porcentaje_Fianciamiento__c;
            pb.Precio_de_Compra__c = pb2.Precio_de_Compra__c;
            pb.Precio_de_Venta__c = pb2.Precio_de_Venta__c;
            pb.Precio_de_Venta_Sugerido__c = pb2.Precio_de_Venta_Sugerido__c;
            pb.Precio_esquina__c = pb2.Precio_esquina__c;
            pb.Precio_frente_a_praque__c = pb2.Precio_frente_a_praque__c;
            pb.Precio_frente_area_municipal__c = pb2.Precio_frente_area_municipal__c;
            pb.Precio_Instalaciones__c = pb2.Precio_Instalaciones__c;
            pb.Precio_lado_sol__c = pb2.Precio_lado_sol__c;
            pb.Precio_lado_sombra__c = pb2.Precio_lado_sombra__c;
            pb.Precio_Lista__c = pb2.Precio_Lista__c;
            pb.Precio_Min_Autorizado__c = pb2.Precio_Min_Autorizado__c;
            pb.Precio_Min_Solicitado__c = pb2.Precio_Min_Solicitado__c;
            pb.Precio_Presupuesto__c = pb2.Precio_Presupuesto__c;
            pb.Precio_sobre_avenida__c = pb2.Precio_sobre_avenida__c;
            pb.Precio_superficie_excedente__c = pb2.Precio_superficie_excedente__c;
            pb.Precio_Total__c = pb2.Precio_Total__c;
            pb.Precio_Unitario__c = pb2.Precio_Unitario__c;
            pb.Presupuesto__c = pb2.Presupuesto__c;
            pb.Prototipo__c = pb2.Prototipo__c;
            pb.Relacion_Precio_Producto__c = pb2.Relacion_Precio_Producto__c;
            pb.Solicitar_Aprobaci_n__c = pb2.Solicitar_Aprobaci_n__c;
            pb.Superficie_excedente__c = pb2.Superficie_excedente__c;
            pb.RecordTypeId = pb2.RecordTypeId;
            pb.Tipo_de_Bonificacion__c = pb2.Tipo_de_Bonificacion__c;
            pb.Tipo_de_Financiamiento__c = pb2.Tipo_de_Financiamiento__c;
            pb.Tipo_de_Producto__c = pb2.Tipo_de_Producto__c;
            pb.Description = pb2.Description;
            pb.Vigente_Desde__c= fDate;
            pb.Vigente_Hasta__c= SDate;
            pb.Porcentaje_Precio_Superficie_Excedente__c =pb2.Porcentaje_Precio_Superficie_Excedente__c;
            pb.Fecha_de_Aprobacion__c = pb2.Fecha_de_Aprobacion__c;
            pb.Fraccinamiento_Vigencia__c = pb2.Fraccinamiento_Vigencia__c;
            insert pb;
            map <Id, PricebookEntry> mapPbE =  new map <Id, PricebookEntry>();
            List<PricebookEntry> Pbe = new List<PricebookEntry>([SELECT Id, Product2Id,IsActive, UnitPrice, UseStandardPrice, Product2.Name FROM PricebookEntry WHERE Pricebook2Id=:pId  AND IsActive  = true]);
            for(PriceBookEntry pEntry: Pbe){
                prodId.add(pEntry.Product2Id);
                mapPbE.put(pEntry.Product2Id, pEntry);
            }
            // Si vivienda, debe ser disponible y activos
            if (pb2.RecordType.Name == 'Vivienda' || pb2.RecordType.Name == 'Regalo MKT' || pb2.RecordType.Name == 'Promoción Venta' || pb2.RecordType.Name == 'Producto Genérico'  || pb2.RecordType.Name == 'Paquete') {
                List<Product2> prods = new List<Product2>([SELECT Id, Name, Precio_Venta__c, Precio_de_Compra__c, Estatus_Vivienda__c, Estatus_Vivienda_F__c,IsActive FROM Product2
                                                        WHERE Id IN: prodId AND IsActive = true]);
                for(Product2 p : prods){
                    if (pb2.RecordType.Name != 'Vivienda' || (pb2.RecordType.Name == 'Vivienda' && p.Estatus_Vivienda__c == '17')) {
                        PricebookEntry pb1 = new PricebookEntry();
                        pb1.Pricebook2Id=pb.Id;
                        pb1.Product2Id=p.Id;
                        pb1.IsActive=true;
                        pb1.UnitPrice=mapPbE.get(p.Id).UnitPrice;
                        pb1.UseStandardPrice=mapPbE.get(p.Id).UseStandardPrice;
                        pbeList.add(pb1);
                        system.debug('*** Clonando producto '+p.Id);
                    }
                }
                if (pbeList.Size()>0) {
                    insert pbeList; 
                }
            }
            message = 'Se ha clonado con exito la lista de precios';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            system.debug('message'+message);
            if(message.contains('duplicate value found: Nombre_Lista_Validacion__c duplicates value on record')){
                message = 'Ya exite una lista con las mismas fetchas';
            }
            return message;
        }        
    }
}