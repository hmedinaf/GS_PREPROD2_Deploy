public class Integracion_EBS {
    public static void Inserta_Integracion_EBS(String ClaveRequisicion, Id planVentaId) {

        if (planVentaId!=null) {
            //Id planVentaId = listPDV[0].Id;
            // Create a new instance of the custom object
            Integracion_EBS_Clientes__c newRec = new Integracion_EBS_Clientes__c();

            // Obtener info de Plan de Venta
            List <Plan_de_Venta__c> lPDV = [SELECT Id, Oportunidad__c, Vivienda__c FROM Plan_de_Venta__c WHERE Id = :planVentaId];
            // Obtener Información sobre Proceso de Venta relacionado:
            List <Opportunity> lOpp = [SELECT ID, Name, AccountId, Dictaminacion__c, Fraccionamiento__r.UEN__c, Fecha_Formalizacion__c, Fecha_Escrituracion__c,
                        Prototipo__r.Name, Fraccionamiento__r.Name, Id_Proceso_AR__c
                    FROM Opportunity WHERE Id=:lPDV[0].Oportunidad__c];
            // Obtener Información de Account
            List <Account> lAcc = [SELECT Id,Apellidomaterno_cta__c,LastName,BillingStreet,BillingCity,BillingState,BillingPostalCode,Colonia_cta__c,CURP__c,Edad__c, 
                Name,
                FirstName,
                FechaEscrituracion__c,	
                FechaFormalizacion__c,	
                FechaNacimiento__c,	
                Fraccionamiento_cta__r.Name,
                ID_CLIENTE_AR__c,
                ID_PROCESO_AR__c,	
                NumeroInterior__c,	
                JMC_Lote__c,	
                Lugar_Nacimiento__c,	
                JMC_Manzana__c,	
                Nacionalidad__c,	
                NSS__c,	
                NumeroExterior__c,	
                BillingCountry,	
                Prototipo_lookup__r.Nombre_Prototipo__c,
                ReferenciaBancariaCliente__c,
                RFC_Completo__c,
                No_Cliente__c,
                Sexo__c,
                TelefonoCelular__c,
                Phone,
                TelefonoOtro__c,
                Tipo_Credito__c,
                QUOTE_Lote_Tipo__c,
                Estatus_Integracion__c,
                UEN__c,
                RecordType.name,
                Numero_de_Cliente_AutoNum__c
            FROM Account WHERE Id = :lOpp[0].AccountId];

            // Obtener codigos AR (si existen)
            String IdClienteAR='';
            String IdProcesoAR='';
            List <Control_AR__c> ctrlAR = [SELECT Id, Id_Cliente_AR__c, Id_Proceso_AR__c FROM Control_AR__c WHERE Account__c = :lOpp[0].AccountId];
            if (ctrlAR.size()>0) {
                idClienteAR = ctrlAR[0].ID_Cliente_AR__c;
                idProcesoAR = ctrlAR[0].Id_Proceso_AR__c;
            }
            system.debug('*** Id Cliente AR: '+idClienteAR);

            // Obtener Direccion Principal
            List<Direcciones__c> dirPrincipal = [SELECT Tipo__c,Calle__c,Pais__r.Name,Estado__r.Name,Municipio__r.Name,Codigo_Postal__r.Name,Colonia__r.Name,Calle_y_Numero__c,Direccion__c,Pais__r.CodigoPais__c
                FROM Direcciones__c
                WHERE Dictaminacion__c = :lOpp[0].Dictaminacion__c
                AND Tipo__c = 'Dirección Principal'
                AND Dictaminacion__c!=null];
            string calle='';string ciudad=''; string codigo_postal='';string colonia='';string estado='';string domicilio_oficial='';string pais='';
            if (dirPrincipal.size()>0) {
                calle = dirPrincipal[0].Calle_y_Numero__c;
                ciudad = capitalizeFirstWord(dirPrincipal[0].Municipio__r.Name);
                codigo_postal = dirPrincipal[0].Codigo_Postal__r.Name;
                colonia = capitalizeFirstWord(dirPrincipal[0].Colonia__r.Name);
                estado = capitalizeFirstWord(dirPrincipal[0].Estado__r.Name);
                domicilio_oficial = dirPrincipal[0].Direccion__c;
                pais = dirPrincipal[0].Pais__r.CodigoPais__c;
            }

            // Obtener Referencias Familiares
            List <Referencia_familiar__c> refs = [SELECT Id, Apellido_Paterno__c, Apellido_Materno__c, Nombre__c, Telefono_1__c, Telefono_2__c, Dictaminacion__c
                FROM Referencia_familiar__c WHERE Dictaminacion__c = :lOpp[0].Dictaminacion__c AND Dictaminacion__c!=null];

            // Obtener datos de la vivienda
            List <Vivienda__c> lVivienda = [SELECT Id, Num_Interno__c, Num_Interior__c, Lote__c, Manzana__c, Excendente_M2__c FROM Vivienda__c WHERE ID = :lPDV[0].Vivienda__c];
            // SI no hay vivienda, salir
            if (lVivienda.isEmpty()) {
                system.debug('*** no hay Vivienda');
                return;
            }
            if (ClaveRequisicion == '6' || ClaveRequisicion == '7') {
                system.debug('Consultando Titulacion');
                List <Titulacion__c> titl = [SELECT Id, Fecha_de_Escritura__c, Numero_de_Credito__c from Titulacion__c WHERE Plan_de_Venta__c = :planVentaId];
                system.debug('*** List Titulacion'+titl);
                if (!titl.isEmpty()) {
                    newRec.Fecha_Escrituracion__c = titl[0].Fecha_de_Escritura__c;
                    system.debug ('*** fecha escrituracion: '+titl[0].Fecha_de_Escritura__c);
                }
            }
            // Set field values
            system.debug('Requisicion: '+ClaveRequisicion);
            system.debug('Id Cliente AR: '+lAcc[0].ID_CLIENTE_AR__c);
            system.debug('Id Proceso AR: '+lOpp[0].Id_Proceso_AR__c);
            if (ClaveRequisicion == '2' && lAcc[0].ID_CLIENTE_AR__c!=null && lOpp[0].Id_Proceso_AR__c==null) {
                ClaveRequisicion = '4';
            }
            newRec.Requisicion_CRM__c = ClaveRequisicion;
            system.debug ('*** ClaveRequisicion: '+ClaveRequisicion);
            newRec.Proceso_de_Venta__c = lOpp[0].Id;
            if (lAcc[0].RecordType.name.Contains('MORAL')) {
                newRec.Nombre__c = lAcc[0].Name;
                newRec.Nombre_Cliente__c  = lAcc[0].Name;
            } else {
                newRec.Apellido_Materno__c = lAcc[0].Apellidomaterno_cta__c;
                newRec.Apellido_Paterno__c = lAcc[0].LastName;
                newRec.Nombre__c = lAcc[0].FirstName;
                if (lAcc[0].Apellidomaterno_cta__c!=null) {
                    newRec.Nombre_Cliente__c = lAcc[0].FirstName +' '+ lAcc[0].LastName +' '+ lAcc[0].Apellidomaterno_cta__c;
                } else {
                    newRec.Nombre_Cliente__c = lAcc[0].FirstName +' '+ lAcc[0].LastName;
                }
            }
            newRec.Calle__c = calle;
            newRec.Ciudad__c = ciudad;
            newRec.Codigo_Postal__c = codigo_postal;
            newRec.Colonia__c = colonia;
            newRec.CURP__c = lAcc[0].CURP__c;
            newRec.Domicilio_Oficial__c = domicilio_oficial;
            newRec.Edad__c = String.ValueOf(lAcc[0].Edad__c);
            newRec.Estado__c = estado;
            // if (ClaveRequisicion=='6' || ClaveRequisicion=='7') 
            //     newRec.Fecha_Escrituracion__c = lOpp[0].Fecha_Escrituracion__c;
            // if (ClaveRequisicion=='6' || ClaveRequisicion=='5' || ClaveRequisicion=='7') 
            newRec.Fecha_Formalizacion__c = lOpp[0].Fecha_Formalizacion__c;
            newRec.Fecha_Nacimiento__c = lAcc[0].FechaNacimiento__c;
            // newRec.Fideicomiso__c = 'Fideicomiso Value'; NOT FOUND
            newRec.Fraccionamiento__c = lOpp[0].Fraccionamiento__r.name; // lAcc[0].Fraccionamiento_cta__r.Name;

            newRec.Id_Cliente_AR__c = lAcc[0].ID_CLIENTE_AR__c!=null ? lAcc[0].ID_CLIENTE_AR__c : idClienteAR; // idClienteAR;
            newRec.Id_Cliente_CRM__c = lAcc[0].ID; 
            newRec.Id_Interfase__c = null; // Lo popula EBSEnviarProcesoDeVenta a partir de autonumber  //integer.valueof(lAcc[0].Numero_de_Cliente_AutoNum__c.substring(5, 10));  //999; // que es esto?
            newRec.Id_Interfase_CRM__c = '';
            newRec.Id_Pago__c = '';
            newRec.Id_Proceso_AR__c = lOpp[0].Id_Proceso_AR__c!=null ? lOpp[0].Id_Proceso_AR__c : idProcesoAR;  //idProcesoAR; //lAcc[0].ID_PROCESO_AR__c;
            newRec.Ind_Exigible__c = ClaveRequisicion=='7'? 1 : 0; // Se obtiene del check si Vivienda Cobrada
            if (!lVivienda.isEmpty()) {
                newRec.Numero_Interno__c = lVivienda[0].Num_Interno__c;
                newRec.Interior__c = lVivienda[0].Num_Interior__c;
                newRec.Lote__c = lVivienda[0].Lote__c;
                newRec.Manzana__c = lVivienda[0].Manzana__c;
            }
            newRec.Lugar_Nacimiento__c = capitalizeFirstWord(lAcc[0].Lugar_Nacimiento__c);
            //newRec.Mensaje_API__c = 'Mensaje API Value';
            newRec.Metros_Terreno_Excedente__c = double.valueOf(lVivienda[0].Excendente_M2__c);
            newRec.Nacionalidad__c = capitalizeFirstWord(lAcc[0].Nacionalidad__c);

            if (!refs.isEmpty()) {
                newRec.Nombre_Referencia_1__c = refs.size()>0 ? refs[0].Apellido_Paterno__c+' '+refs[0].Apellido_Materno__c+' '+refs[0].Nombre__c : null;
                newRec.Nombre_Referencia_2__c = refs.size()>1 ? refs[1].Apellido_Paterno__c+' '+refs[1].Apellido_Materno__c+' '+refs[1].Nombre__c : null; 
                newRec.Nombre_Referencia_3__c = refs.size()>2 ? refs[2].Apellido_Paterno__c+' '+refs[2].Apellido_Materno__c+' '+refs[2].Nombre__c : null; 
                newRec.Telefono_Referencia_1__c = refs.size()>0 ? refs[0].Telefono_1__c : null;
                newRec.Telefono_Referencia_2__c = refs.size()>1 ? refs[1].Telefono_1__c : null;
                newRec.Telefono_Referencia_3__c = refs.size()>2 ? refs[2].Telefono_1__c : null;
                newRec.Telefono_Ref_Otro_1__c = refs.size()>0 ? refs[0].Telefono_2__c : null;
                newRec.Telefono_Ref_Otro_2__c = refs.size()>1 ? refs[1].Telefono_2__c : null;
                newRec.Telefono_Ref_Otro_3__c = refs.size()>2 ? refs[2].Telefono_2__c : null;    
            }

            newRec.NSS__c = lAcc[0].NSS__c;
            newRec.Num_Proceso_AR__c = lOpp[0].Name;
            newRec.Numero_Domicilio__c = lAcc[0].NumeroExterior__c;
            
            newRec.Pais__c = 'MX'; //pais;
            newRec.Prototipo__c = lOpp[0].Prototipo__r.Name; //lAcc[0].Prototipo_lookup__r.Nombre_Prototipo__c;

            newRec.Referencia_Bancaria__c = CLASS_Oportunidad.CalculaDigitoVerificador(lOpp[0].Name); //lAcc[0].ReferenciaBancariaCliente__c;
            // newRec.Respuesta_API__c = 'Respuesta API Value'; // lo popula el servicio
            newRec.RFC__c = lAcc[0].RFC_Completo__c;
            newRec.Row_Id__c = lAcc[0].No_Cliente__c;
            newRec.Sexo__c = capitalizeFirstWord(lAcc[0].Sexo__c);
            newRec.Telefono_Celular__c = lAcc[0].TelefonoCelular__c!=null ? lAcc[0].TelefonoCelular__c.Replace('+','').substring(2,12) : null;
            newRec.Telefono_Particular__c = lAcc[0].Phone!=null ? lAcc[0].Phone.Replace('+','').substring(2,12) : null;

            newRec.Tipo_Credito__c = lAcc[0].Tipo_Credito__c;
            newRec.Tipo_Lote__c = 'Viviendas'; //lAcc[0].QUOTE_Lote_Tipo__c;
            newRec.UEN__c = lOpp[0].Fraccionamiento__r.UEN__c;
            newRec.Estatus_Integracion__c = 'Nuevo';

            // Insert the newRec
            insert newRec;
            system.debug ('*** Insert en Integracion EBS: '+newRec);
        }
    }

    public static String capitalizeFirstWord(String input) {
        if (input == null || input == '') return input;
        String[] words = input.split(' ');
        for (Integer i = 0; i < words.size(); i++) {
            if (words[i] != '') {
                words[i] = words[i].substring(0,1).toUpperCase() + words[i].substring(1).toLowerCase();
            }
        }
        return String.join(words, ' ');
    }

    @InvocableMethod(label='Insert Integracion EBS')
    public static void invokeInserta_Integracion_EBS(List<InvocableParameters> params) {
        String ClaveRequisicion = params[0].ClaveRequisicion;
        Id planVentaId = params[0].PlanVentaId;
        Inserta_Integracion_EBS(ClaveRequisicion, planVentaId);
    }

    public class InvocableParameters {
        @InvocableVariable(label='Clave Requisicion')
        public String ClaveRequisicion;
        @InvocableVariable(label='Plan Venta ID')
        public Id PlanVentaId;
    }
}