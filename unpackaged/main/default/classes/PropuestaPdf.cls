public class PropuestaPdf {
    public Account Account{get;set;}
    public string pId{get;set;}
    public PropuestaPdf (){
        pId = ApexPages.currentPage().getParameters().get('accId') ;
        Account  = [Select Id,Zona__c,PersonMobilePhone,Tipo__c,Tipo_de_Direccion__c,Sexo__c,FechaNacimiento__c,Canal_de_Venta__c,Sub_canal_de_venta__c,BillingColony__c,BillingCity,BillingState,BillingCountry,BillingStreet,NumeroExterior__c,NumeroInterior__c,
                    CorreoElectronico__c,TelefonoCelular__c,Otro_Telefono__c,Colonia_cta__c,MANAGEAPPROVALS__Active__c,FirstName,Lastname ,Name,Phone, RecordTypeName__c,Apellidomaterno_cta__c,RecordType.Name,Fraccionamiento_cta__c,Fraccionamiento_cta__r.Name ,
                    Prospectador__c,BillingPostalCode,Prospectador__r.Name,Estatus_Prospectador__c,Fecha_Prospeccion__c,Fecha_Vencimiento_Prospectador__c,Asesor__c,Asesor__r.Name,Estatus_Asesor__c,FechaAsignacion__c,Ingresos_Mensuales__c,
                    Colaborador_Javer__c,Estatus_Colaborador_Javer__c, Fecha_Colaborador_Javer__c ,Fecha_Vencimiento_Colaborador_Javer__c,Empresa__c,Puesto__c,TelefonoTrabajo__c,anios__c,Meses__c,
                    NSS__c,QUOTE_Lote_Tipo__c,QUOTE_Construccion__c,QUOTE_Esquina__c,QUOTE_Terreno_Excedente__c,QUOTE_Ubicacion_Especial__c,QUOTE_Otros__c,QUOTE_Precio_de_Lista__c,QUOTE_Paquete_Descripcion__c,Estado_Civil__c,Hijos__c,
                    QUOTE_Total_Paquete__c,QUOTE_Bonificacion__c,QUOTE_Promocion__c,QUOTE_Gastos__c,Tipo_Credito__c,QUOTE_Credito_Bancario__c,QUOTE_Credito_INFONAVIT__c,QUOTE_Subcuenta__c,QUOTE_Mensualidad_Banco__c,DependientesEconomicos__c,
                    QUOTE_Mensualidad_INFONAVIT__c,QUOTE_Total_Terreno_Excedente__c,QUOTE_Ingreso_Solicitado__c,Fecha_Propuesta__c,QUOTE_Enganche_a_Pagar__c,QUOTE_Nombre_Fracc__c,QUOTE_Gastos_Credito__c,QUOTE_Monto_que_Recibira_JAVER__c,Prototipo_lookup__c,
                    Nombre_del_Asesor__c,QUOTE_Correo_Asesor__c,QUOTE_Telefono_Asesor__c,QUOTE_Precio__c, QUOTE_Precio_Total__c,Nombre__c, QUOTE_Total_Atributos__c,Quote_Prototipo__c,QUOTE_m2_Excedentes__c,QUOTE_Folio_Cotizacion_Formula__c from Account  where Id= :pId];
        system.debug('Account'+Account);
    }
}