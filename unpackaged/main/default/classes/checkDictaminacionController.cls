public class checkDictaminacionController {

    @AuraEnabled
    public static List<CheckInfo> getCheckInfo(ID dictId) {
        boolean chk_Checklist;
        List <CheckInfo> lCheckInfo = new List <CheckInfo> ();

        List <Dictaminacion__c> lDict = [SELECT Id, Check_Inf_Laboral__c, Check_Inf_Cliente__c, Check_Inf_Cliente_Moral__c, Notaria__c,No_Escritura__c,
                                Ya_Capturo_Representante_Legal__c, Ya_Capturo_Info_CoAcreditado__c, Direccion_Empresa__c,Ya_Capturo_Referencia_Familiar__c,
                                CHK_Alta_SHCP__c, CHK_Cedula_Fiscal__c, CHK_Comprobante_de_Domicilio__c, CHK_CURP__c, 
                                CHK_Escritura__c, CHK_Facultades_Servidor_Publico__c, CHK_Identificacion_Oficial__c,
                                CHK_INE_Representante_Legal__c, CHK_Recibos_de_Nomina__c, Tipo_Contribuyente_c__c,
                                Es_usted_el_Titular_de_Recursos__c,Existe_un_Tercero_que_aporta_Recursos__c,Escritura_a_favor_de_un_Tercero__c,
                                Firma_Directa_Cliente__c,Firma_Directa_Apoderado_Legal__c, Check_Inf_Empresa__c, Direccion_Principal__c,
                                Direccion_Laboral__c,Integracion_EBS__c
                                FROM Dictaminacion__c WHERE Id = :dictId];

        String tipoPersona = lDict[0].Tipo_Contribuyente_c__c;

        // PERSONA FISICA:
        if (tipoPersona == 'PERSONA FISICA') {
            lCheckInfo.add(addCheckInfo ('Información General del Cliente', lDict[0].Check_Inf_Cliente__c));
            // nuevas notas:
            // Informacion Laboral = siempre
            lCheckInfo.add(addCheckInfo ('Información Laboral', lDict[0].Check_Inf_Laboral__c));
            lCheckInfo.add(addCheckInfo ('Información de la Empresa', lDict[0].Check_Inf_Empresa__c));

            // Check Direcciones, PF=Principal+Laboral
            //List <Direcciones__c> ldirPF = [SELECT ID, NAME FROM Direcciones__c WHERE Contrato__c = :dictId AND Tipo__c in ('Dirección Principal','Dirección Laboral')];
            //lCheckInfo.add(addCheckInfo ('Información Dirección', ldirPF.size() == 2));
            lCheckInfo.add(addCheckInfo ('Información Dirección', ldict[0].Direccion_Laboral__c!=null && ldict[0].Direccion_Principal__c!=null ));

            // Informacion Cliente = siempre
            // Preguntas Clientes = siempre
            // Representante Legal Perfil Tercero Moral = cuando Perfil Tercero Moral(1)
            // Info Rep Legal /Apoderado/ servidor Público = cuando se solicita Representante Legal del Cliente
            // Escritura Otra Persona Fisico o Moral

            chk_Checklist = (lDict[0].CHK_Alta_SHCP__c || lDict[0].CHK_Comprobante_de_Domicilio__c || lDict[0].CHK_CURP__c || lDict[0].CHK_Recibos_de_Nomina__c  
                || lDict[0].CHK_Identificacion_Oficial__c);

            // Regla Representante Legal
            // *Dato obligatorio si ¿Es usted el Titular de Recursos?=NO (Perfil Cliente)
            // *Dato obligatorio si ¿Existe un Tercero que aporta Recursos Total o Parcial?=SI (Perfil Cliente)
            // Por lo que aún debería de marcarlo como incompleto (tachita roja) ya que es obligatorio llenar el
            //  objeto de Información Representante Legal para perfil 1 tercero cuando se tengan esas condiciones 
            //  (que son las que tengo actualmente) y ahorita no los tengo lleno

            // Titular Recursos=NO
            // Existe un Tercero que Aporta Recursos=SI o
            Boolean SolicitarReprLegal=FALSE;
            Boolean Chk_ReprLegal=FALSE;
            if (lDict[0].Es_usted_el_Titular_de_Recursos__c=='NO' && lDict[0].Existe_un_Tercero_que_aporta_Recursos__c=='SI') {
                SolicitarReprLegal=TRUE;
            }

            // Firma Directa Apoderado Legal=SI
            // FIrma Directo el Cliente = NO  y Firma Directa Apoderado Legal = SI        
            if (SolicitarReprLegal && lDict[0].Firma_Directa_Cliente__c=='NO' && lDict[0].Firma_Directa_Apoderado_Legal__c=='SI') {
                list <Informacion_representante_legal__c> ireplegal = [SELECT ID, Registro_completo__c FROM Informacion_representante_legal__c WHERE Dictaminacion__c = :dictId];
                if (!ireplegal.isEmpty()) {
                    lCheckInfo.add(addCheckInfo ('Información Representante Legal', ireplegal[0].Registro_completo__c));
                } else {
                    lCheckInfo.add(addCheckInfo ('Información Representante Legal', FALSE));
                }
            }

            // Si titular de recursos=NO, checar por INf laboral, inf de Cliente, Preguntas al CLiente y Checklist + PERFIL TERCERO 1 (Azul)
            // ¿Existe un Tercero que aporta recursos total o parcial?=SI
            //if (lDict[0].Es_usted_el_Titular_de_Recursos__c=='NO') {



            if (lDict[0].Existe_un_Tercero_que_aporta_Recursos__c=='SI') {
                // Buscar Perfil Tercero Moral primero
                list <Perfil_Tercero_Moral__c> lptm = [SELECT Id FROM Perfil_Tercero_Moral__c WHERE Dictaminacion_Lookup__c = :dictId];
                // lCheckInfo.add(addCheckInfo ('Información Perfil Tercero', lptm.size() > 0));
                Boolean bInfoPerTercero = lptm.size() > 0;

                // SI tiene Perfil Tercero Moral, debe tener Informacion Representante Legal Tercero
                if (lptm.size()>0) {
                    // Buscar en Informacion_representante_legal__c ligado a Dictaminación y ligado a "Perfil Tercero Moral
                    List <Informacion_representante_legal__c> lInfoRepLegTer = [SELECT Id, Registro_completo__c FROM Informacion_representante_legal__c
                            WHERE Dictaminacion__c = :dictId and Perfil_Tercero_Persona_Moral__c = :lptm[0].Id];
                    if (!lInfoRepLegTer.isEmpty()) {
                        lCheckInfo.add(addCheckInfo ('Información Representante Legal Tercero', lInfoRepLegTer[0].Registro_completo__c));
                    } else {
                        lCheckInfo.add(addCheckInfo ('Información Representante Legal Tercero', FALSE));
                    }
                } else {
                    list <Perfil_Tercero_Fisico__c> lptf = [SELECT Id, Registro_completo__c FROM Perfil_Tercero_Fisico__c WHERE Dictaminacion_Lookup__c = :dictId];
                    if (!lptf.isEmpty()) {
                        bInfoPerTercero = lptf[0].Registro_completo__c;
                    } else {
                        bInfoPerTercero=false;
                    } 
                }
                lCheckInfo.add(addCheckInfo ('Información Perfil Tercero', bInfoPerTercero));
            }
            // Si Escritura a favor de un Tercero = SI
            if (lDict[0].Escritura_a_favor_de_un_Tercero__c=='SI') {
                list <Cesion_a_Otra_Persona_Fisica_o_Moral__c> copfom = [SELECT ID FROM Cesion_a_Otra_Persona_Fisica_o_Moral__c WHERE Dictaminacion__c = :dictId];
                if (copfom.size()>0) {
                    // lCheckInfo.add(addCheckInfo ('Información Cesión de Vivienda', copfom.size() > 0));
                    lCheckInfo.add(addCheckInfo ('Escritura otra Persona Física o Moral', copfom.size() > 0));
                } else {
                    lCheckInfo.add(addCheckInfo ('Escritura otra Persona Física o Moral', false));
                }
            }

            // Referencias Familiares. PF = Debe haber 2 =check true / PM Igual
            List <Referencia_familiar__c> lrfPF = [SELECT ID FROM Referencia_familiar__c WHERE Dictaminacion__c = :dictId
                AND Nombre__c <> NULL AND Apellido_Paterno__c <> NULL];
            lCheckInfo.add(addCheckInfo ('Información Referencias Familiares', lrfPF.size() > 1));
        } else {
            // PERSONA MORAL
            // Información Laboral = SIEMPRE
            lCheckInfo.add(addCheckInfo ('Información Laboral', lDict[0].Check_Inf_Laboral__c));
            lCheckInfo.add(addCheckInfo ('Información de la Empresa', lDict[0].Check_Inf_Empresa__c));
            // Información Cliente = SIEMPRE
            // En cualquier condición se evalua/regresa Informacion Empresa / Informacion Clientes / Preguntas al Cliente / Checklist
            lCheckInfo.add(addCheckInfo ('Información General del Cliente', lDict[0].Check_Inf_Cliente_Moral__c));
            // Info Rep Legal / Apoderado / servidor Público = SIEMPRE
            // Escritura otra Persona Fisica o Moral = Misma Regla Que PF

            // Check Direcciones, PF=Principal+Laboral
            //List <Direcciones__c> ldirPF = [SELECT ID FROM Direcciones__c WHERE Contrato__c = :dictId AND Tipo__c in ('Dirección Principal','Dirección Empresa')];
            lCheckInfo.add(addCheckInfo ('Información Dirección', ldict[0].Direccion_Empresa__c!=null && ldict[0].Direccion_Principal__c!=null ));

            // Si Escritura a favor de un Tercero = SI
            if (lDict[0].Escritura_a_favor_de_un_Tercero__c=='SI') {
                list <Cesion_a_Otra_Persona_Fisica_o_Moral__c> copfom = [SELECT ID FROM Cesion_a_Otra_Persona_Fisica_o_Moral__c WHERE Dictaminacion__c = :dictId];
                if (copfom.size()>0) {
                    // lCheckInfo.add(addCheckInfo ('Información Cesión de Vivienda', copfom.size() > 0));
                    lCheckInfo.add(addCheckInfo ('Escritura otra Persona Física o Moral', copfom.size() > 0));
                }
            }
            
            // Datos del poder = SIEMPRE
            // Preguntas al cliente = SIEMPRE
            // Check list P Moral (anexo 4) = SIEMPRE
            // Representante legal perfil tercero moral cuando 
            // Representante legal cesión vivienda moral


            chk_Checklist = lDict[0].CHK_Comprobante_de_Domicilio__c || lDict[0].CHK_Identificacion_Oficial__c || lDict[0].CHK_Cedula_Fiscal__c  
                || lDict[0].CHK_Escritura__c || lDict[0].CHK_INE_Representante_Legal__c || lDict[0].CHK_Facultades_Servidor_Publico__c;

            // Representante Legal, en cualquier combinación, se presenta Informacion Rep Legal -- OK
            list <Informacion_representante_legal__c> ireplegal = [SELECT ID, Registro_completo__c FROM Informacion_representante_legal__c WHERE Dictaminacion__c = :dictId];
            if (!ireplegal.isEmpty()) {
                lCheckInfo.add(addCheckInfo ('Información Representante Legal', ireplegal[0].Registro_completo__c));
            } else {
                lCheckInfo.add(addCheckInfo ('Información Representante Legal', FALSE));
            }

            // Perfil Tercero Físico o Moral siempre que Escritura a Favor de un tercero != SI
            // Se requiere una de las dos figuras, Perfil Tercero Fisico O Moral
            // if (lDict[0].Escritura_a_favor_de_un_Tercero__c!='SI') {
            if (lDict[0].Existe_un_Tercero_que_aporta_Recursos__c=='SI') {
                list <Perfil_Tercero_Fisico__c> lptf = [SELECT Id, Registro_Completo__c FROM Perfil_Tercero_Fisico__c WHERE Dictaminacion_Lookup__c = :dictId];
                    if (!lptf.isEmpty()) {
                        lCheckInfo.add(addCheckInfo ('Información Perfil Tercero', lptf[0].Registro_Completo__c));
                    } else {
                        // Buscar Perfil Tercero Moral
                        list <Perfil_Tercero_Moral__c> lptm = [SELECT Id, Registro_Completo__c FROM Perfil_Tercero_Moral__c WHERE Dictaminacion_Lookup__c = :dictId];
                        if (!lptm.isEmpty()){
                            lCheckInfo.add(addCheckInfo ('Información Perfil Tercero', lptm[0].Registro_Completo__c));
                        } else {
                            lCheckInfo.add(addCheckInfo ('Información Perfil Tercero', FALSE));
                        }
                    }
            }
            // Si Escritura a favor de un Tercero = SI
            if (lDict[0].Escritura_a_favor_de_un_Tercero__c=='SI') {
                list <Cesion_a_Otra_Persona_Fisica_o_Moral__c> copfom = [SELECT ID FROM Cesion_a_Otra_Persona_Fisica_o_Moral__c WHERE Dictaminacion__c = :dictId];
                if (copfom.size()>0) {
                    lCheckInfo.add(addCheckInfo ('Información Cesión de Vivienda', copfom.size() > 0));
                }
            }


            // Escritura Otra Persona Física o Moral
            // if (lDict[0].Escritura_a_favor_de_un_Tercero__c=='SI') {
            //     list <Cesion_a_Otra_Persona_Fisica_o_Moral__c> copf = [SELECT ID, No_Escritura__c FROM Cesion_a_Otra_Persona_Fisica_o_Moral__c 
            //                 WHERE Contrato__c = :dictId AND No_Escritura__c != NULL];
            //     lCheckInfo.add(addCheckInfo ('Información Escritura otra Persona Física o Moral', copf.size() > 0));
            // }

            // Si es datos del poder ir hasta Informacion Representante Legal Tercero (dentro de Perfil Tercero Persona Moral) y obtener Escritura Poliza o Acta, Fecha 
            // de escritura poder y notario/corredor
            list <Informacion_representante_legal__c> lirlt = [SELECT ID, Name FROM Informacion_representante_legal__c 
                    WHERE Dictaminacion__c = :dictId
                    AND Escritura_poliza_o_acta__c != NULL
                    AND Fecha_de_escritura_del_poder__c != NULL
                    AND Notario_corredor_del_poder__c != NULL ];
            lCheckInfo.add(addCheckInfo ('Datos del Poder', lirlt.size() > 0));

            // if (lDict[0].Es_usted_el_Titular_de_Recursos__c=='NO' || lDict[0].Existe_un_Tercero_que_aporta_Recursos__c=='SI') {
            //     list <Perfil_Tercero_Fisico__c> lptf = [SELECT Id FROM Perfil_Tercero_Fisico__c WHERE Dictaminacion__c = :dictId];
            //     lCheckInfo.add(addCheckInfo ('Información Perfil Tercero', lptf.size() > 0));
            // }


            // Referencias Familiares. PF = Debe haber 2 =check true / PM Igual
            List <Referencia_familiar__c> lrfPF = [SELECT ID FROM Referencia_familiar__c WHERE Dictaminacion__c = :dictId
                AND Nombre__c <> NULL AND Apellido_Paterno__c <> NULL];
            lCheckInfo.add(addCheckInfo ('Información Referencias Familiares', lrfPF.size() > 1));

        }

        // if (lDict[0].Tipo_Contribuyente_c__c == 'PERSONA FISICA') {
        //     chk_Checklist = lDict[0].CHK_Alta_SHCP__c && lDict[0].CHK_Comprobante_de_Domicilio__c && lDict[0].CHK_CURP__c && lDict[0].CHK_Recibos_de_Nomina__c  && lDict[0].CHK_Identificacion_Oficial__c;
        // } else {
        //     chk_Checklist = lDict[0].CHK_Comprobante_de_Domicilio__c && lDict[0].CHK_Identificacion_Oficial__c && lDict[0].CHK_Cedula_Fiscal__c  
        //         && lDict[0].CHK_Escritura__c  && lDict[0].CHK_INE_Representante_Legal__c  && lDict[0].CHK_Facultades_Servidor_Publico__c;}

        lCheckInfo.add(addCheckInfo ('Checklist documentos', chk_Checklist));

        Boolean Dict_Completa=TRUE;
        for (CheckInfo ci : lCheckInfo) {
            system.debug('*** Dictaminacion Completa!');
            Dict_Completa = ci.Valor && Dict_Completa; //Si alguno es False, la bandera se vuelve FALSE
        }
        
        Dictaminacion__c updDictaminacion = new Dictaminacion__c();

        // Llamar a EBS con Req 3 solo si no se ha invocado anteriormente
        if (Dict_Completa && !lDict[0].Integracion_EBS__c) {
            Id pdvId = [SELECT id, Plan_de_Venta__c FROM Opportunity WHERE Dictaminacion__c = :dictId].Plan_de_Venta__c;
            system.debug ('*** Llamando a Integracion EBS: '+pdvId);
            Integracion_EBS.Inserta_Integracion_EBS ('3', pdvId);
            updDictaminacion.Integracion_EBS__c = true;
        }

        updDictaminacion.Id = dictId;
        updDictaminacion.Chk_Dictaminacion_Completa__c = Dict_Completa;
        updDictaminacion.ValidationBypassDateTime__c = DateTime.Now();
        try {
            system.debug('*** Actualizando Dictaminación');
            update updDictaminacion;
        } catch (Exception e) {
            system.debug('checkDictaminacionController Error: '+e);
        }

        return lCheckInfo;
    }

    public static CheckInfo addCheckInfo (String documento, Boolean icono) {
        CheckInfo newInfo = new CheckInfo();
        newInfo.documento = documento;
        newInfo.valor = icono;
        newInfo.icono = (icono==true) ? 'action:approval' : 'action:close';
        return newInfo;
    }

    class CheckInfo {
        @AuraEnabled
        public String documento {get;set;}
        @AuraEnabled
        public Boolean valor {get;set;}
        @AuraEnabled
        public String icono {get;set;}
    }
}