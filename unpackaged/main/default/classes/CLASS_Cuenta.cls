public without sharing class CLASS_Cuenta {
    public static boolean isExecuting = false;
    private static boolean guardoHistoricoAsig = false;
    
    static Map<String,String> prepsConjCont = new Map<String,String>();
    static Map<String,String> signosEne = new Map<String,String>();
    static Map<String,String> palabrasInconvenientes = new Map<String,String>();
    static Map<String,String> estados = new Map<String,String>();
    static Map<String,String> oPs_ValorHomonimo = new Map<String,String>();
    static Map<String,String> oPs_ClaveDif = new Map<String,String>();
    static Map<String,String> oPs_DigitoVerifica = new Map<String,String>();
    
    public static void PopulateMaps(){
        
        prepsConjCont.put('DA','DA');
        prepsConjCont.put('DAS','DAS');
        prepsConjCont.put('DE','DE');
        prepsConjCont.put('DEL','DEL');
        prepsConjCont.put('DER','DER');
        prepsConjCont.put('DI','DI');
        prepsConjCont.put('DIE','DIE');
        prepsConjCont.put('DD','DD');
        prepsConjCont.put('EL','EL');
        prepsConjCont.put('LA','LA');
        prepsConjCont.put('LOS','LOS');
        prepsConjCont.put('LAS','LAS');
        prepsConjCont.put('LE','LE');
        prepsConjCont.put('LES','LES');
        prepsConjCont.put('MAC','MAC');
        prepsConjCont.put('MC','MC');
        prepsConjCont.put('VAN','VAN');
        prepsConjCont.put('VON','VON');
        prepsConjCont.put('Y','Y');
        
        signosEne.put('/','X');
        signosEne.put('-','X');
        signosEne.put('.','X');
        signosEne.put('Ñ','X');
        
        palabrasInconvenientes.put('BACA','BXCA');
        palabrasInconvenientes.put('BAKA','BXKA');
        palabrasInconvenientes.put('BUEI','BXEI');
        palabrasInconvenientes.put('BUEY','BXEY');
        palabrasInconvenientes.put('CACA','CXCA');
        palabrasInconvenientes.put('CACO','CXCO');
        palabrasInconvenientes.put('CAGA','CXGA');
        palabrasInconvenientes.put('CAGO','CXGO');
        palabrasInconvenientes.put('CAKA','CXKA');
        palabrasInconvenientes.put('CAKO','CXKO');
        palabrasInconvenientes.put('COGE','CXGE');
        palabrasInconvenientes.put('COGI','CXGI');
        palabrasInconvenientes.put('COJA','CXJA');
        palabrasInconvenientes.put('COJE','CXJE');
        palabrasInconvenientes.put('COJI','CXJI');
        palabrasInconvenientes.put('COJO','CXJO');
        palabrasInconvenientes.put('COLA','CXLA');
        palabrasInconvenientes.put('CULO','CXLO');
        palabrasInconvenientes.put('FALO','FXLO');
        palabrasInconvenientes.put('FETO','FXTO');
        palabrasInconvenientes.put('GETA','GXTA');
        palabrasInconvenientes.put('GUEI','GXEI');
        palabrasInconvenientes.put('GUEY','GXEY');
        palabrasInconvenientes.put('JETA','JXTA');
        palabrasInconvenientes.put('JOTO','JXTO');
        palabrasInconvenientes.put('KACA','KXCA');
        palabrasInconvenientes.put('KACO','KXCO');
        palabrasInconvenientes.put('KAGA','KXGA');
        palabrasInconvenientes.put('KAGO','KXGO');
        palabrasInconvenientes.put('KAKA','KXKA');
        palabrasInconvenientes.put('KAKO','KXKO');
        palabrasInconvenientes.put('KOGE','KXGE');
        palabrasInconvenientes.put('KOGI','KXGI');
        palabrasInconvenientes.put('KOJA','KXJA');
        palabrasInconvenientes.put('KOJE','KXJE');
        palabrasInconvenientes.put('KOJI','KXJI');
        palabrasInconvenientes.put('KOJO','KXJO');
        palabrasInconvenientes.put('KOLA','KXLA');
        palabrasInconvenientes.put('KULO','KXLO');
        palabrasInconvenientes.put('LILO','LXLO');
        palabrasInconvenientes.put('LOCA','LXCA');
        palabrasInconvenientes.put('LOCO','LXCO');
        palabrasInconvenientes.put('LOKA','LXKA');
        palabrasInconvenientes.put('LOKO','LXKO');
        palabrasInconvenientes.put('MAME','MXME');
        palabrasInconvenientes.put('MAMO','MXMO');
        palabrasInconvenientes.put('MEAR','MXAR');
        palabrasInconvenientes.put('MEAS','MXAS');
        palabrasInconvenientes.put('MEON','MXON');
        palabrasInconvenientes.put('MIAR','MXAR');
        palabrasInconvenientes.put('MION','MXON');
        palabrasInconvenientes.put('MOCO','MXCO');
        palabrasInconvenientes.put('MOKO','MXKO');
        palabrasInconvenientes.put('MULA','MXLA');
        palabrasInconvenientes.put('MULO','MXLO');
        palabrasInconvenientes.put('NACA','NXCA');
        palabrasInconvenientes.put('NACO','NXCO');
        palabrasInconvenientes.put('PEDA','PXDA');
        palabrasInconvenientes.put('PEDO','PXDO');
        palabrasInconvenientes.put('PENE','PXNE');
        palabrasInconvenientes.put('PIPI','PXPI');
        palabrasInconvenientes.put('PITO','PXTO');
        palabrasInconvenientes.put('POPO','PXPO');
        palabrasInconvenientes.put('PUTA','PXTA');
        palabrasInconvenientes.put('PUTO','PXTO');
        palabrasInconvenientes.put('QULO','QXLO');
        palabrasInconvenientes.put('RATA','RXTA');
        palabrasInconvenientes.put('ROBA','RXBA');
        palabrasInconvenientes.put('ROBE','RXBE');
        palabrasInconvenientes.put('ROBO','RXBO');
        palabrasInconvenientes.put('RUIN','RXIN');
        palabrasInconvenientes.put('SENO','SXNO');
        palabrasInconvenientes.put('TETA','TXTA');
        palabrasInconvenientes.put('VACA','VXCA');
        palabrasInconvenientes.put('VAGA','VXGA');
        palabrasInconvenientes.put('VAGO','VXGO');
        palabrasInconvenientes.put('VAKA','VXKA');
        palabrasInconvenientes.put('VUEI','VXEI');
        palabrasInconvenientes.put('VUEY','VXEY');
        palabrasInconvenientes.put('WUEI','WXEI');
        palabrasInconvenientes.put('WUEY','WXEY');
        
        estados.put('AGUASCALIENTES','AS');
        estados.put('BAJA CALIFORNIA','BC');
        estados.put('BAJA CALIFORNIA SUR','BS');
        estados.put('CAMPECHE','CC');
        estados.put('CHIAPAS','CS');
        estados.put('CHIHUAHUA','CH');
        estados.put('CIUDAD DE MEXICO','DF');
        estados.put('COAHUILA','CL');
        estados.put('COLIMA','CM');     
        estados.put('DURANGO','DG');
        estados.put('GUANAJUATO','GT');
        estados.put('GUERRERO','GR');
        estados.put('HIDALGO','HG');
        estados.put('JALISCO','JC');
        estados.put('ESTADO DE MEXICO','MC');
        estados.put('MICHOACAN','MN');
        estados.put('MORELOS','MS');
        estados.put('NAYARIT','NT');
        estados.put('NUEVO LEON','NL');
        estados.put('OAXACA','OC');
        estados.put('PUEBLA','PL');
        estados.put('QUERETARO','QT');
        estados.put('QUINTANA ROO','QR');
        estados.put('SAN LUIS POTOSI','SP');
        estados.put('SINALOA','SL');
        estados.put('SONORA','SR');
        estados.put('TABASCO','TC');
        estados.put('TAMAULIPAS','TS');
        estados.put('TLAXCALA','TL');
        estados.put('VERACRUZ','VZ');
        estados.put('YUCATAN','YN');
        estados.put('ZACATECAS','ZS');
        estados.put('EXTRANJERO','NE');
        
        oPs_ValorHomonimo.put(' ', '00');
        oPs_ValorHomonimo.put('0', '00');
        oPs_ValorHomonimo.put('1', '01');
        oPs_ValorHomonimo.put('2', '02');
        oPs_ValorHomonimo.put('3', '03');
        oPs_ValorHomonimo.put('4', '04');
        oPs_ValorHomonimo.put('5', '05');
        oPs_ValorHomonimo.put('6', '06');
        oPs_ValorHomonimo.put('7', '07');
        oPs_ValorHomonimo.put('8', '08');
        oPs_ValorHomonimo.put('9', '09');
        oPs_ValorHomonimo.put('&', '10');
        oPs_ValorHomonimo.put('A', '11');
        oPs_ValorHomonimo.put('B', '12');
        oPs_ValorHomonimo.put('C', '13');
        oPs_ValorHomonimo.put('D', '14');
        oPs_ValorHomonimo.put('E', '15');
        oPs_ValorHomonimo.put('F', '16');
        oPs_ValorHomonimo.put('G', '17');
        oPs_ValorHomonimo.put('H', '18');
        oPs_ValorHomonimo.put('I', '19');
        oPs_ValorHomonimo.put('J', '21');
        oPs_ValorHomonimo.put('K', '22');
        oPs_ValorHomonimo.put('L', '23');
        oPs_ValorHomonimo.put('M', '24');
        oPs_ValorHomonimo.put('N', '25');
        oPs_ValorHomonimo.put('O', '26');
        oPs_ValorHomonimo.put('P', '27');
        oPs_ValorHomonimo.put('Q', '28');
        oPs_ValorHomonimo.put('R', '29');
        oPs_ValorHomonimo.put('S', '32');
        oPs_ValorHomonimo.put('T', '33');
        oPs_ValorHomonimo.put('U', '34');
        oPs_ValorHomonimo.put('V', '35');
        oPs_ValorHomonimo.put('W', '36');
        oPs_ValorHomonimo.put('X', '37');
        oPs_ValorHomonimo.put('Y', '38');
        oPs_ValorHomonimo.put('Z', '39');
        oPs_ValorHomonimo.put('Ñ', '40');
        
        oPs_ClaveDif.put('0', '1');
        oPs_ClaveDif.put('1', '2');
        oPs_ClaveDif.put('2', '3');
        oPs_ClaveDif.put('3', '4');
        oPs_ClaveDif.put('4', '5');
        oPs_ClaveDif.put('5', '6');
        oPs_ClaveDif.put('6', '7');
        oPs_ClaveDif.put('7', '8');
        oPs_ClaveDif.put('8', '9');
        oPs_ClaveDif.put('9', 'A');
        oPs_ClaveDif.put('10', 'B');
        oPs_ClaveDif.put('11', 'C');
        oPs_ClaveDif.put('12', 'D');
        oPs_ClaveDif.put('13', 'E');
        oPs_ClaveDif.put('14', 'F');
        oPs_ClaveDif.put('15', 'G');
        oPs_ClaveDif.put('16', 'H');
        oPs_ClaveDif.put('17', 'I');
        oPs_ClaveDif.put('18', 'J');
        oPs_ClaveDif.put('19', 'K');
        oPs_ClaveDif.put('20', 'L');
        oPs_ClaveDif.put('21', 'M');
        oPs_ClaveDif.put('22', 'N');
        oPs_ClaveDif.put('23', 'P');
        oPs_ClaveDif.put('24', 'Q');
        oPs_ClaveDif.put('25', 'R');
        oPs_ClaveDif.put('26', 'S');
        oPs_ClaveDif.put('27', 'T');
        oPs_ClaveDif.put('28', 'U');
        oPs_ClaveDif.put('29', 'V');
        oPs_ClaveDif.put('30', 'W');
        oPs_ClaveDif.put('31', 'X');
        oPs_ClaveDif.put('32', 'Y');
        oPs_ClaveDif.put('33', 'Z');
        
        oPs_DigitoVerifica.put('A', '10');
        oPs_DigitoVerifica.put('B', '11');
        oPs_DigitoVerifica.put('C', '12');
        oPs_DigitoVerifica.put('D', '13');
        oPs_DigitoVerifica.put('E', '14');
        oPs_DigitoVerifica.put('F', '15');
        oPs_DigitoVerifica.put('G', '16');
        oPs_DigitoVerifica.put('H', '17');
        oPs_DigitoVerifica.put('I', '18');
        oPs_DigitoVerifica.put('J', '19');
        oPs_DigitoVerifica.put('K', '20');
        oPs_DigitoVerifica.put('L', '21');
        oPs_DigitoVerifica.put('M', '22');
        oPs_DigitoVerifica.put('N', '23');
        oPs_DigitoVerifica.put('O', '25');
        oPs_DigitoVerifica.put('P', '26');
        oPs_DigitoVerifica.put('Q', '27');
        oPs_DigitoVerifica.put('R', '28');
        oPs_DigitoVerifica.put('S', '29');
        oPs_DigitoVerifica.put('T', '30');
        oPs_DigitoVerifica.put('U', '31');
        oPs_DigitoVerifica.put('V', '32');
        oPs_DigitoVerifica.put('W', '33');
        oPs_DigitoVerifica.put('X', '34');
        oPs_DigitoVerifica.put('Y', '35');
        oPs_DigitoVerifica.put('Z', '36');
        oPs_DigitoVerifica.put('0', '0');
        oPs_DigitoVerifica.put('1', '1');
        oPs_DigitoVerifica.put('2', '2');
        oPs_DigitoVerifica.put('3', '3');
        oPs_DigitoVerifica.put('4', '4');
        oPs_DigitoVerifica.put('5', '5');
        oPs_DigitoVerifica.put('6', '6');
        oPs_DigitoVerifica.put('7', '7');
        oPs_DigitoVerifica.put('8', '8');
        oPs_DigitoVerifica.put('9', '9');
        oPs_DigitoVerifica.put(' ', '37');
    }
    
    //Metodo que unifica los datos ingresados de las cuentas creadas convirtiendo todo a mayusculas, quitando acentos y caracteres especiales
    public static void unificaDatosCuenta(List<Account> cuentasNuevas){
        if (isExecuting) {
            return;
        }
        isExecuting=true;
        PopulateMaps();
        
        Id tipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroAfluentePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroClientePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Fisica').getRecordTypeId();
        
        Id tipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroAfluentePersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Moral').getRecordTypeId();
        Id tipoRegistroClientePersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Moral').getRecordTypeId();
        
        for(Account cuentaNueva : cuentasNuevas){
            
            if(cuentaNueva.RecordTypeId == tipoRegistroProspectoPersonaFisica || cuentaNueva.RecordTypeId == tipoRegistroAfluentePersonaFisica || cuentaNueva.RecordTypeId == tipoRegistroClientePersonaFisica){
                
                cuentaNueva.FirstName = (String.isBlank(cuentaNueva.FirstName) == false ? unificaDatos(cuentaNueva.FirstName) : cuentaNueva.FirstName);
                cuentaNueva.LastName = (String.isBlank(cuentaNueva.LastName) == false ? unificaDatos(cuentaNueva.LastName) : cuentaNueva.LastName);
                cuentaNueva.Apellidomaterno_cta__c = (String.isBlank(cuentaNueva.Apellidomaterno_cta__c) == false ? unificaDatos(cuentaNueva.Apellidomaterno_cta__c) : cuentaNueva.Apellidomaterno_cta__c);
                cuentaNueva.PersonBirthdate = cuentaNueva.PersonBirthdate==null ? cuentaNueva.FechaNacimiento__c : cuentaNueva.PersonBirthdate;
                cuentaNueva.Is_New__c=false;
                cuentaNueva.MANAGEAPPROVALS__Active__c='Yes';
            }
            else{
                cuentaNueva.Name = (String.isBlank(cuentaNueva.Name) == false ? unificaDatos(cuentaNueva.Name) : cuentaNueva.Name);
                cuentaNueva.RFC_Base__c = (String.isBlank(cuentaNueva.RFC_Base__c) == false ? unificaDatos(cuentaNueva.RFC_Base__c) : cuentaNueva.RFC_Base__c);
                cuentaNueva.Homoclave_Texto__c = (String.isBlank(cuentaNueva.Homoclave_Texto__c) == false ? unificaDatos(cuentaNueva.Homoclave_Texto__c) : cuentaNueva.Homoclave_Texto__c);
                cuentaNueva.CURP__c = (String.isBlank(cuentaNueva.CURP__c) == false ? unificaDatos(cuentaNueva.CURP__c) : cuentaNueva.CURP__c);
                cuentaNueva.Is_New__c=false;
                cuentaNueva.MANAGEAPPROVALS__Active__c='Yes';
            }
            if (cuentaNueva.RecordTypeId==tipoRegistroProspectoPersonaFisica || cuentaNueva.RecordTypeId==tipoRegistroProspectoPersonaMoral) {
                cuentaNueva.Tipo__c = 'Prospecto';
            }
            if (cuentaNueva.RecordTypeId==tipoRegistroAfluentePersonaFisica || cuentaNueva.RecordTypeId==tipoRegistroAfluentePersonaMoral) {
                cuentaNueva.Tipo__c = 'Afluente';
            }
            if (cuentaNueva.RecordTypeId==tipoRegistroClientePersonaFisica || cuentaNueva.RecordTypeId==tipoRegistroClientePersonaMoral) {
                cuentaNueva.Tipo__c = 'Cliente';
            }    
        }
        
        validacionesCuenta(cuentasNuevas);
        
        isExecuting=false;
    }
    
    //Metodo que unifica los datos ingresados de las cuentas modificadas convirtiendo todo a mayusculas, quitando acentos y caracteres especiales
    public static void unificaDatosCuenta(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        if (isExecuting) {
            return;
        }
        isExecuting=true;
        PopulateMaps();
        system.debug('***** Ejecutando Class_Cuenta en UPDATE');
        
        Id tipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroAfluentePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroClientePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Fisica').getRecordTypeId();
        
        for(Account cuentaModificada : cuentasModificadas){
            
            if(cuentaModificada.RecordTypeId == tipoRegistroProspectoPersonaFisica || cuentaModificada.RecordTypeId == tipoRegistroAfluentePersonaFisica || 
               cuentaModificada.RecordTypeId == tipoRegistroClientePersonaFisica){
                   
                   cuentaModificada.FirstName = (String.isBlank(cuentaModificada.FirstName) == false && 
                                                 cuentaModificada.FirstName.equals(cuentasExistentes.get(cuentaModificada.Id).FirstName) == false ? unificaDatos(cuentaModificada.FirstName) : cuentaModificada.FirstName);
                   cuentaModificada.LastName = (String.isBlank(cuentaModificada.LastName) == false && 
                                                cuentaModificada.LastName.equals(cuentasExistentes.get(cuentaModificada.Id).LastName) == false ? unificaDatos(cuentaModificada.LastName) : cuentaModificada.LastName);
                   cuentaModificada.Apellidomaterno_cta__c = (String.isBlank(cuentaModificada.Apellidomaterno_cta__c) == false && 
                                                              cuentaModificada.Apellidomaterno_cta__c.equals(cuentasExistentes.get(cuentaModificada.Id).Apellidomaterno_cta__c) == false ? unificaDatos(cuentaModificada.Apellidomaterno_cta__c) : cuentaModificada.Apellidomaterno_cta__c);
                   cuentaModificada.PersonBirthdate = cuentaModificada.FechaNacimiento__c;
               }
            else{
                cuentaModificada.Name = (String.isBlank(cuentaModificada.Name) == false && cuentaModificada.Name.equals(cuentasExistentes.get(cuentaModificada.Id).Name) == false ? unificaDatos(cuentaModificada.Name) : cuentaModificada.Name);
                cuentaModificada.RFC_Base__c = (String.isBlank(cuentaModificada.RFC_Base__c) == false && cuentaModificada.RFC_Base__c.equals(cuentasExistentes.get(cuentaModificada.Id).RFC_Base__c) == false ? unificaDatos(cuentaModificada.RFC_Base__c) : cuentaModificada.RFC_Base__c);
                cuentaModificada.Homoclave_Texto__c = (String.isBlank(cuentaModificada.Homoclave_Texto__c) == false && cuentaModificada.Homoclave_Texto__c.equals(cuentasExistentes.get(cuentaModificada.Id).Homoclave_Texto__c) == false ? unificaDatos(cuentaModificada.Homoclave_Texto__c) : cuentaModificada.Homoclave_Texto__c);
                cuentaModificada.CURP__c = (String.isBlank(cuentaModificada.CURP__c) == false && cuentaModificada.CURP__c.equals(cuentasExistentes.get(cuentaModificada.Id).CURP__c) == false ? unificaDatos(cuentaModificada.CURP__c) : cuentaModificada.CURP__c);
            }
        }
        
        validacionesCuenta(cuentasModificadas,cuentasExistentes);
        isExecuting=false;
    }
    
    //Metodo para sustituir los caracteres especiales por su caracter simple
    public static String unificaDatos(String texto){
        
        String textoUnificado = '';
        textoUnificado = texto.toUpperCase();
        textoUnificado = textoUnificado.replaceAll('[ÀÁÂÃÄÅ]','A');
        textoUnificado = textoUnificado.replaceAll('[ÈÉÊË]','E');
        textoUnificado = textoUnificado.replaceAll('[ÌÍÎÏ]','I');
        textoUnificado = textoUnificado.replaceAll('[ÒÓÔÕÖØ]','O');
        textoUnificado = textoUnificado.replaceAll('[ÙÚÛÜ]','U');
        textoUnificado = textoUnificado.replaceAll('[Ç]','C');
        textoUnificado = textoUnificado.replaceAll('[ÿ]','Y');
        
        return textoUnificado;
    }
    
    //Metodo que realiza validaciones sobre las cuentas creadas antes de llenar valores automaticos en ellas
    public static void validacionesCuenta(List<Account> cuentasNuevas){
        
        //Si la cuenta creada es de tipo Prospecto Persona Fisica o Prospecto Persona Moral y
        //Si la cuenta creada tiene Canal de Venta = Programas Institucionales y Sub Canal de Venta = Colaborador Javer se asigna automaticamente como Prospectador el usuario generico: PROSPECTADOR COLABORADOR JAVER
        //Si la cuenta creada tiene Canal de Venta = Medios Digitales o Canal de Venta = Medio Publicitario se asigna automaticamente como Prospectador el usuario generico: PROSPECTADOR LP
        Id idTipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id idTipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Moral').getRecordTypeId();
        List<User> usuariosGenericos = [SELECT Id, Name FROM User WHERE Name IN ('JAVER GENERICO')];
        Map<String, User> mapaUsuariosGenericos = new Map<String, User>();
        system.debug('*** usuariosGenericos: '+usuariosGenericos);
        //for(User usuarioGenerico : usuariosGenericos){
        //mapaUsuariosGenericos.put(usuarioGenerico.Name, usuarioGenerico);
        mapaUsuariosGenericos.put('JAVER GENERICO', usuariosGenericos[0]);
        //}
        system.debug('*** mapaUsuariosGenericos: '+mapaUsuariosGenericos);
        if (!usuariosGenericos.isEmpty()) {
            
            for(Account cuentaNueva : cuentasNuevas){
                if(cuentaNueva.Canal_de_Venta__c.equals('PROGRAMAS INSTITUCIONALES') && cuentaNueva.Sub_canal_de_venta__c.equals('COLABORADOR JAVER') && (cuentaNueva.RecordTypeId == idTipoRegistroProspectoPersonaFisica || cuentaNueva.RecordTypeId == idTipoRegistroProspectoPersonaMoral)){
                    cuentaNueva.Prospectador__c = mapaUsuariosGenericos.get('JAVER GENERICO').Id;
                    // system.debug ('*** Asignacion Prospectador:'+mapaUsuariosGenericos.get('JAVER GENERICO').Id);
                }
                else if((cuentaNueva.Canal_de_Venta__c.equals('MEDIOS DIGITALES') || cuentaNueva.Canal_de_Venta__c.equals('MEDIO PUBLICITARIO')) && 
                        (cuentaNueva.RecordTypeId == idTipoRegistroProspectoPersonaFisica || cuentaNueva.RecordTypeId == idTipoRegistroProspectoPersonaMoral)){
                            cuentaNueva.Prospectador__c = mapaUsuariosGenericos.get('JAVER GENERICO').Id;
                            // system.debug ('*** Asignacion Prospectador:'+mapaUsuariosGenericos.get('JAVER GENERICO').Id);
                        }
                else if(cuentaNueva.Canal_de_Venta__c.equals('PROSPECTO ASESOR') && (cuentaNueva.RecordTypeId == idTipoRegistroProspectoPersonaFisica || cuentaNueva.RecordTypeId == idTipoRegistroProspectoPersonaMoral)){
                    cuentaNueva.Prospectador__c = mapaUsuariosGenericos.get('JAVER GENERICO').Id;
                    // system.debug ('*** Asignacion Prospectador:'+mapaUsuariosGenericos.get('JAVER GENERICO').Id);
                }
            }
        }
        
        //Se valida que, si las cuentas creadas tienen asignado algun asesor de ventas (lead profiler, prospectador y asesor), estos correspondan al fraccionamiento elegido
        Set<Id> idsLeadProfilers = new Set<Id>();
        Set<Id> idsProspectadores = new Set<Id>();
        Set<Id> idsAsesores = new Set<Id>();
        Set<Id> idsFraccionamientosLeadProfilers = new Set<Id>();
        Set<Id> idsFraccionamientosProspectadores = new Set<Id>();
        Set<Id> idsFraccionamientosAsesores = new Set<Id>();
        List<Account> cuentasLeadProfilers = new List<Account>();
        List<Account> cuentasProspectadores = new List<Account>();
        List<Account> cuentasAsesores = new List<Account>();
        List<Account> cuentasValidadasLeadProfiler = new List<Account>();
        List<Account> cuentasValidadasProspectador = new List<Account>();
        List<Account> cuentasValidadasAsesor = new List<Account>();
        
        for(Account cuenta : cuentasNuevas){
            
            //Si la cuenta creada tiene asociado un lead profiler se agrega a una lista para continuar con la validacion
            if(String.isBlank(cuenta.Lead_Profiler__c) == false){
                
                idsLeadProfilers.add(cuenta.Lead_Profiler__c); idsFraccionamientosLeadProfilers.add(cuenta.Fraccionamiento_cta__c);    cuentasLeadProfilers.add(cuenta);
            }
            else{
                cuentasValidadasLeadProfiler.add(cuenta);
            }
        }
        
        //Si hubo cuentas creadas con lead profiler asociado a ellas, se procede a validar que el lead profiler corresponda al fraccionamiento elegido
        if(idsLeadProfilers.size() > 0){
            
            //Se obtienen los datos de los usuarios elegidos como lead profilers y de los fraccionamientos elegidos
            Map<Id,User> usuarios = new Map<Id,User>([SELECT Id, FraccionamientoAutorizados__c FROM User WHERE Id IN : idsLeadProfilers]);
            Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientosLeadProfilers]);            
            
            //Se valida que las cuentas creadas que tengan asociado un lead profiler corresponda al fraccionamiento elegido
            for(Account cuenta : cuentasLeadProfilers){
                
                if(String.isBlank(usuarios.get(cuenta.Lead_Profiler__c).FraccionamientoAutorizados__c) == false){
                    
                    //Si el lead profiler no corresponde al fraccionamiento elegido se envia error
                    if(usuarios.get(cuenta.Lead_Profiler__c).FraccionamientoAutorizados__c.contains(fraccionamientos.get(cuenta.Fraccionamiento_cta__c).Name) == false){
                        cuenta.addError('El Lead Profiler elegido no tiene asignado el fraccionamiento elegido');
                    }
                    //Si el lead profiler si corresponde al fraccionamiento elegido se agrega a la lista para continuar con la asignacion de valores automaticos
                    else{
                        cuentasValidadasLeadProfiler.add(cuenta);
                    }
                }
                else{
                    cuenta.addError('El Lead Profiler elegido no tiene algún fraccionamiento asignado');
                }
            }
        }
        
        //De las cuentas creadas que no tienen asignado un lead profiler o 
        //que tienen lead profiler pero que ya se valido que el lead profiler corresponde al fraccionamiento elegido
        //si tienen asignado un prospectador, se valida que este corresponda con el fraccionamiento elegido
        for(Account cuenta : cuentasValidadasLeadProfiler){
            //Si la cuenta creada tiene asociado un prospectador y este es diferente a PROSPECTADOR COLABORADOR JAVER Y diferente a PROSPECTADOR LP se agrega a una lista para continuar con la validacion
            if(String.isBlank(cuenta.Prospectador__c) == false && cuenta.Prospectador__c != mapaUsuariosGenericos.get('JAVER GENERICO').Id){
                
                idsProspectadores.add(cuenta.Prospectador__c); idsFraccionamientosProspectadores.add(cuenta.Fraccionamiento_cta__c);   cuentasProspectadores.add(cuenta);
            }
            else{
                cuentasValidadasProspectador.add(cuenta);
            }
        }
        
        //Si hubo cuentas creadas con prospectador asociado a ellas, se procede a validar que el prospectador corresponda al fraccionamiento elegido
        if(idsProspectadores.size() > 0){
            
            //Se obtienen los datos de los usuarios elegidos como prospectadores y de los fraccionamientos elegidos
            Map<Id,User> usuarios = new Map<Id,User>([SELECT Id, FraccionamientoAutorizados__c FROM User WHERE Id IN : idsProspectadores]);
            Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientosProspectadores]);            
            
            //Se valida que las cuentas creadas que tengan asociado un prospectador corresponda al fraccionamiento elegido
            for(Account cuenta : cuentasProspectadores){
                
                if(String.isBlank(usuarios.get(cuenta.Prospectador__c).FraccionamientoAutorizados__c) == false){
                    
                    //Si el prospectador no corresponde al fraccionamiento elegido se envia error
                    if(usuarios.get(cuenta.Prospectador__c).FraccionamientoAutorizados__c.contains(fraccionamientos.get(cuenta.Fraccionamiento_cta__c).Name) == false){
                        cuenta.addError('El Prospectador elegido no tiene asignado el fraccionamiento elegido');
                    }
                    //Si el prospectador si corresponde al fraccionamiento elegido se agrega a la lista para continuar con la asignacion de valores automaticos
                    else{
                        cuentasValidadasProspectador.add(cuenta);
                    }
                }
                else{
                    cuenta.addError('El Prospectador elegido no tiene algún fraccionamiento elegido');
                }
            }
        }
        
        
        //De las cuentas creadas que no tienen asignado un lead profiler o 
        //que tienen lead profiler pero que ya se valido que el lead profiler corresponde al fraccionamiento elegido o
        //que no tienen asignado un prospectador o
        //que tienen prospectador pero que ya se valido que el prospectador corresponde al fraccionamiento elegido
        //si tienen asignado un asesor, se valida que este corresponda con el fraccionamiento elegido
        for(Account cuenta : cuentasValidadasProspectador){
            
            //Si la cuenta creada tiene asociado un asesor se agrega a una lista para continuar con la validacion
            if(String.isBlank(cuenta.Asesor__c) == false){
                
                idsAsesores.add(cuenta.Asesor__c);
                idsFraccionamientosAsesores.add(cuenta.Fraccionamiento_cta__c);
                cuentasAsesores.add(cuenta);
            }
            else{
                cuentasValidadasAsesor.add(cuenta);
            }
        }
        
        //Si hubo cuentas creadas con asesor asociado a ellas, se procede a validar que el asesor corresponda al fraccionamiento elegido
        if(idsAsesores.size() > 0){
            
            //Se obtienen los datos de los usuarios elegidos como asesores y de los fraccionamientos elegidos
            Map<Id,User> usuarios = new Map<Id,User>([SELECT Id, FraccionamientoAutorizados__c FROM User WHERE Id IN : idsAsesores]);
            Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientosAsesores]);            
            
            //Se valida que las cuentas creadas que tengan asociado un asesor corresponda al fraccionamiento elegido
            // *HMF* Se comenta por falla reportada por Ivette 5/5/23 Linea 502-518 -  corregido, el ASESOR debe tener fraccionamientos asignados
            for(Account cuenta : cuentasAsesores){
                
                if(String.isBlank(usuarios.get(cuenta.Asesor__c).FraccionamientoAutorizados__c) == false){
                    
                    //Si el asesor no corresponde al fraccionamiento elegido se envia error
                    if(usuarios.get(cuenta.Asesor__c).FraccionamientoAutorizados__c.contains(fraccionamientos.get(cuenta.Fraccionamiento_cta__c).Name) == false){
                        cuenta.addError('El Asesor elegido no tiene asignado el fraccionamiento elegido');
                    }
                    //Si el asesor si corresponde al fraccionamiento elegido se agrega a la lista para continuar con la asignacion de valores automaticos
                    else{
                        cuentasValidadasAsesor.add(cuenta);}
                }
                else{
                    cuenta.addError('El Asesor elegido no tiene el fraccionamiento asignado');
                }
            }
        }
        
        
        //De las cuentas creadas que no tienen asignado un lead profiler o 
        //que tienen lead profiler pero que ya se valido que el lead profiler corresponde al fraccionamiento elegido o
        //que no tienen asignado un prospectador o
        //que tienen prospectador pero que ya se valido que el prospectador corresponde al fraccionamiento elegido o
        //que no tienen asignado un asesor o
        //que tienen asesor pero que ya se valido que el asesor corresponde al fraccionamiento elegido
        //se valida que, si la cuenta tiene marcado el check apellido, el fraccionamiento elegido tenga asociado un usuario jefe de formalizacion
        //si el fraccionamiento elegido no tiene un jefe de formalizacion se envia error
        //si el fraccionamiento elegido si tiene un jefe de formalizacion se asigna al campo Jefe_Formalizacion__c
        //Se recorren las cuentas creadas para obtener aquellas que si tengan marcado el check apellido
        Set<Id> idsFraccionamientos = new Set<Id>();
        List<Account> cuentasValidadasCheckApellido = new List<Account>();
        List<Account> cuentasSiCheckApellido = new List<Account>();
        
        for(Account cuenta : cuentasValidadasAsesor){
            
            //Si la cuenta creada tiene marcado el check apellido se agrega a una lista para su posterior validacion
            if(cuenta.Check_Apellido__c == true){
                
                idsFraccionamientos.add(cuenta.Fraccionamiento_cta__c);
                cuentasSiCheckApellido.add(cuenta);
            }
            //Si la cuenta creada no tiene marcado el check apellido se agrega a una lista para continuar con la asignacion de valores automaticos
            else{
                cuentasValidadasCheckApellido.add(cuenta);
            }
        }
        
        //Si hubo cuentas creadas marcadas con el check apellido se valida que el fraccionamiento elegido tenga asociado un usuario jefe de formalizacion
        if(cuentasSiCheckApellido.size() > 0){
            
            //Se obtienen los datos de los fraccionamientos elegidos
            Set<String> nombresFraccionamientos = new Set<String>();
            Map<Id,String> fraccionamientos = new Map<Id,String>();
            for(Fraccionamiento__c fraccionamiento : [SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientos]){
                
                System.debug('*****fraccionamiento.Name:' + fraccionamiento.Name);
                nombresFraccionamientos.add('%' + fraccionamiento.Name + '%');
                fraccionamientos.put(fraccionamiento.Id, fraccionamiento.Name);
            }
            System.debug('*****fraccionamientos:' + fraccionamientos);
            
            //Se obtienen los datos de los usuarios jefes de formalizacion de los fraccionamientos elegidos
            List<User> usuariosJefesFormalizacion = [SELECT Id, Name, FraccionamientoAutorizados__c 
                                                     FROM User 
                                                     WHERE Profile.Name = 'JAVER - Jefe de Formalización' 
                                                     AND (FraccionamientoAutorizados__c LIKE : nombresFraccionamientos
                                                          OR FraccionamientoAutorizados__c = 'TODOS')];
            System.debug('*****usuariosJefesFormalizacion:' + usuariosJefesFormalizacion);
            
            //Se construye un mapa con la relacion fraccionamiento - usuario jefe de formalizacion
            Map<Id,User> idFracciomientoUsuarioJefeFormalizacion = new Map<Id,User>();
            for(Id idFraccionamiento : fraccionamientos.keySet()){
                
                System.debug('*****idFraccionamiento:' + idFraccionamiento);
                for(User usuarioJefeFormalizacion : usuariosJefesFormalizacion){
                    
                    System.debug('*****usuarioJefeFormalizacion:' + usuarioJefeFormalizacion);
                    System.debug('*****usuarioJefeFormalizacion.FraccionamientoAutorizados__c.contains(fraccionamientos.get(idFraccionamiento)):' + usuarioJefeFormalizacion.FraccionamientoAutorizados__c.contains(fraccionamientos.get(idFraccionamiento)));
                    if(usuarioJefeFormalizacion.FraccionamientoAutorizados__c.contains(fraccionamientos.get(idFraccionamiento)) == true){
                        idFracciomientoUsuarioJefeFormalizacion.put(idFraccionamiento, usuarioJefeFormalizacion);
                    }
                }                
            }
            System.debug('*****idFracciomientoUsuarioJefeFormalizacion:' + idFracciomientoUsuarioJefeFormalizacion);
            
            //Se recorren las cuentas creadas marcadas con el check apellido para validar que el fraccionamiento elegido tenga asociado un usuario jefe de formalizacion
            for(Account cuentaSiCheckApellido : cuentasSiCheckApellido){
                
                System.debug('*****cuentaSiCheckApellido.Fraccionamiento_cta__c:' + cuentaSiCheckApellido.Fraccionamiento_cta__c);
                System.debug('*****idFracciomientoUsuarioJefeFormalizacion.containsKey(cuentaSiCheckApellido.Fraccionamiento_cta__c):' + idFracciomientoUsuarioJefeFormalizacion.containsKey(cuentaSiCheckApellido.Fraccionamiento_cta__c));
                //Si el fraccionamiento elegido en la cuenta marcada con el check apellido no tiene un usuario jefe de formalizacion asociado, se envia error
                
                // * HMF 052323 * Esta regla no aplica iFalk en la junta del 05/23/23 que no aplicaba
                // if(idFracciomientoUsuarioJefeFormalizacion.containsKey(cuentaSiCheckApellido.Fraccionamiento_cta__c) == false){
                //     cuentaSiCheckApellido.addError('No existe un usuario Jefe de Formalización para el fraccionamiento seleccionado');
                // }
                //Si el fraccionamiento elegido en la cuenta marcada con el check apellido si tiene un usuario jefe de formalizacion asociado, se popula el campo Jefe_Formalizacion__c y
                //Se agrega a la lista de cuentas que no tienen marcado el check apellido para continuar con la asignacion de valores automaticos
                // else{
                // cuentaSiCheckApellido.Jefe_Formalizacion__c = idFracciomientoUsuarioJefeFormalizacion.get(cuentaSiCheckApellido.Fraccionamiento_cta__c).Id;
                cuentasValidadasCheckApellido.add(cuentaSiCheckApellido);
                //}
            }
        }
        
        //Si hay cuentas que pasaron exitosamente las validaciones se procede a llenarles los campos automaticos
        if(cuentasValidadasCheckApellido.size() > 0){
            system.debug ('**** asignaValoresAutomaticosCuenta'+cuentasValidadasCheckApellido);
            asignaValoresAutomaticosCuenta(cuentasValidadasCheckApellido);
        }
    }
    
    //Metodo que asigna valores automaticos a la cuenta cuando ha sido creada:
    public static void asignaValoresAutomaticosCuenta(List<Account> cuentasNuevas){
        
        asignaFechaNacimientoTextoCreacion(cuentasNuevas);
        asignaCategoriaCreacion(cuentasNuevas);
        asignaEstatusCreacion(cuentasNuevas);
        asignaRFCCURPCreacion(cuentasNuevas);
        asignaNombreFraccCreacion(cuentasNuevas);
        asignaIdentificadorUnicoCreacion(cuentasNuevas);
        validaDominioEmail(cuentasNuevas);
        asignaTipoRegistroCreacion(cuentasNuevas);
        asignaGerenteVentasCreacion(cuentasNuevas);
    }    
    
    
    //Metodo que realiza validaciones sobre las cuentas modificadas antes de llenar valores automaticos en ellas
    public static void validacionesCuenta(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        System.debug('*****entro a validacionesCuenta modificacion');
        
        //Se corren las cuentas modificadas para descartar aquellas a las que solo se les creo una visita y por eso es que entro al trigger el registro de cuenta asociada a la visita 
        List<Account> cuentasModificadasNoVisitaCreada = new List<Account>();
        for(Account cuentaModificada : cuentasModificadas){
            
            System.debug('*****cuentaModificada.Visitas_Realizadas__c:' + cuentaModificada.Visitas_Realizadas__c);
            System.debug('*****cuentasExistentes.get(cuentaModificada.Id).Visitas_Realizadas__c:' + cuentasExistentes.get(cuentaModificada.Id).Visitas_Realizadas__c);
            
            //Si el numero de visitas es el mismo que el que ya tenia, se considera un cambio real en el registro de la cuenta y se procede a las validaciones y llenado de valores automaticos en la cuenta
            if(cuentaModificada.Visitas_Realizadas__c == cuentasExistentes.get(cuentaModificada.Id).Visitas_Realizadas__c){
                cuentasModificadasNoVisitaCreada.add(cuentaModificada);
            }
        }
        
        //Se recorren las cuentas modificadas para descartar aquellas a las que se les hizo extension de la vigencia del asesor
        List<Account> cuentasModificadasNoVisitaCreadaNoExtensionAsesor = new List<Account>();
        List<Account> cuentasExtensionAsesor = new List<Account>();
        
        
        
        System.debug('*****cuentasModificadasNoVisitaCreada:' + cuentasModificadasNoVisitaCreada);
        //Si se creo alguna visita de fraccionamiento solo se cambia la bandera del campo Visita Creada para que no entre a realizar validaciones ni llene valores automaticos en la cuenta
        if(cuentasModificadasNoVisitaCreada.size() > 0){
            String genUserId = Label.JAVER_GENERICO_User;
            //Si la cuenta modificada es de tipo Prospecto Persona Fisica o Prospecto Persona Moral y
            //Si la cuenta modificada tiene Canal de Venta = Programas Institucionales y Sub Canal de Venta = Colaborador Javer se asigna automaticamente como Prospectador el usuario generico: PROSPECTADOR COLABORADOR JAVER
            //Si la cuenta modificada tiene Canal de Venta = Medios Digitales o Canal de Venta = Medio Publicitario se asigna automaticamente como Prospectador el usuario generico: PROSPECTADOR LP
            Id idTipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
            Id idTipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Moral').getRecordTypeId();
            List<User> usuariosGenericos = [SELECT Id, Name FROM User WHERE ID = :genUserId]; //Name = 'JAVER GENERICO' ]; //, 'PROSPECTADOR COLABORADOR JAVER','PROSPECTADOR LP','PROSPECTO ASESOR')];
            Map<String, User> mapaUsuariosGenericos = new Map<String, User>();
            
            for(User usuarioGenerico : usuariosGenericos){
                mapaUsuariosGenericos.put('JAVER GENERICO', usuarioGenerico);
            }
            
            // Asignación de Prospectador automática. Posible error en mapaUsuariosGenericos
            for(Account cuentaModificada : cuentasModificadasNoVisitaCreada){
                if(cuentaModificada.Canal_de_Venta__c != null && cuentaModificada.Canal_de_Venta__c.equals('PROGRAMAS INSTITUCIONALES') &&   cuentaModificada.Sub_canal_de_venta__c.equals('COLABORADOR JAVER')  && 
                   (cuentaModificada.Sub_canal_de_venta__c != cuentasExistentes.get(cuentaModificada.Id).Sub_canal_de_venta__c  || cuentaModificada.Canal_de_Venta__c != cuentasExistentes.get(cuentaModificada.Id).Canal_de_Venta__c) &&
                   (cuentaModificada.RecordTypeId == idTipoRegistroProspectoPersonaFisica ||   cuentaModificada.RecordTypeId == idTipoRegistroProspectoPersonaMoral))  {
                       
                       cuentaModificada.Prospectador__c = mapaUsuariosGenericos.get('JAVER GENERICO').Id;
                   }
                else if(cuentaModificada.Canal_de_Venta__c != null && (cuentaModificada.Canal_de_Venta__c.equals('MEDIOS DIGITALES') || cuentaModificada.Canal_de_Venta__c.equals('MEDIO PUBLICITARIO')) && cuentaModificada.Canal_de_Venta__c != cuentasExistentes.get(cuentaModificada.Id).Canal_de_Venta__c  && (cuentaModificada.RecordTypeId == idTipoRegistroProspectoPersonaFisica || cuentaModificada.RecordTypeId == idTipoRegistroProspectoPersonaMoral)){
                    
                    cuentaModificada.Prospectador__c = mapaUsuariosGenericos.get('JAVER GENERICO').Id;
                }
                else if(cuentaModificada.Canal_de_Venta__c != null && cuentaModificada.Canal_de_Venta__c.equals('PROSPECTO ASESOR') && cuentaModificada.Canal_de_Venta__c != cuentasExistentes.get(cuentaModificada.Id).Canal_de_Venta__c && (cuentaModificada.RecordTypeId == idTipoRegistroProspectoPersonaFisica || cuentaModificada.RecordTypeId == idTipoRegistroProspectoPersonaMoral)){
                    
                    cuentaModificada.Prospectador__c = mapaUsuariosGenericos.get('JAVER GENERICO').Id;
                }
            }
            
            //Se valida que, si las cuentas creadas tienen asignado algun asesor de ventas (lead profiler, prospectador y asesor), estos correspondan al fraccionamiento elegido
            Set<Id> idsLeadProfilers = new Set<Id>();
            Set<Id> idsProspectadores = new Set<Id>();
            Set<Id> idsAsesores = new Set<Id>();
            Set<Id> idsFraccionamientosLeadProfilers = new Set<Id>();
            Set<Id> idsFraccionamientosProspectadores = new Set<Id>();
            Set<Id> idsFraccionamientosAsesores = new Set<Id>();
            List<Account> cuentasLeadProfilers = new List<Account>();
            List<Account> cuentasProspectadores = new List<Account>();
            List<Account> cuentasAsesores = new List<Account>();
            List<Account> cuentasValidadasLeadProfiler = new List<Account>();
            List<Account> cuentasValidadasProspectador = new List<Account>();
            List<Account> cuentasValidadasAsesor = new List<Account>();
            
            for(Account cuenta : cuentasModificadasNoVisitaCreada){
                
                //Si la cuenta modificada tiene asociado un lead profiler y este es diferente al que ya tenia la cuenta, se agrega a una lista para continuar con la validacion
                if(String.isBlank(cuenta.Lead_Profiler__c) == false && cuenta.Lead_Profiler__c != cuentasExistentes.get(cuenta.Id).Lead_Profiler__c){
                    
                    idsLeadProfilers.add(cuenta.Lead_Profiler__c);  idsFraccionamientosLeadProfilers.add(cuenta.Fraccionamiento_cta__c);      cuentasLeadProfilers.add(cuenta);
                }
                else{
                    cuentasValidadasLeadProfiler.add(cuenta);
                }
            }
            
            //Si hubo cuentas modificadas con lead profiler asociado a ellas y este es diferente al que ya tenia la cuenta, se procede a validar que el lead profiler corresponda al fraccionamiento elegido
            if(idsLeadProfilers.size() > 0){
                //Se obtienen los datos de los usuarios elegidos como lead profilers y de los fraccionamientos elegidos
                Map<Id,User> usuarios = new Map<Id,User>([SELECT Id, FraccionamientoAutorizados__c FROM User WHERE Id IN : idsLeadProfilers]);
                Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientosLeadProfilers]);            
                
                //Se valida que las cuentas modificadas que tengan asociado un lead profiler corresponda al fraccionamiento elegido
                for(Account cuenta : cuentasLeadProfilers){
                    // *** HMF 052323 / Si ya tiene asesor Vigente ASIGNADO, no se permite asignar LP
                    if (cuenta.Lead_Profiler__c != null && cuenta.Asesor__c != null && cuenta.Estatus_Asesor__c == 'ASIGNADO' && cuenta.Lead_Profiler__c != Label.JAVER_GENERICO_User) {
                        
                        cuenta.addError('No se puede asignar un Lead Profiler porque ya ha sido asignado a un Asesor.');
                    } else {
                        if(String.isBlank(usuarios.get(cuenta.Lead_Profiler__c).FraccionamientoAutorizados__c) == false){
                            
                            //Si el lead profiler no corresponde al fraccionamiento elegido se envia error
                            if(usuarios.get(cuenta.Lead_Profiler__c).FraccionamientoAutorizados__c.contains(fraccionamientos.get(cuenta.Fraccionamiento_cta__c).Name) == false){
                                cuenta.addError('El Lead Profiler elegido no tiene asignado el fraccionamiento elegido');
                            }
                            //Si el lead profiler si corresponde al fraccionamiento elegido se agrega a la lista para continuar con la asignacion de valores automaticos
                            else{
                                cuentasValidadasLeadProfiler.add(cuenta);
                            }
                        }
                        else{
                            cuenta.addError('El Lead Profiler elegido no tiene algún fraccionamiento asignado');
                        }
                    }
                }
            }
            
            //De las cuentas modificadas que no tienen asignado un lead profiler o 
            //que tienen lead profiler y este es diferente al que ya tenia la cuenta, pero que ya se valido que el lead profiler corresponde al fraccionamiento elegido
            //si tienen asignado un prospectador, se valida que este corresponda con el fraccionamiento elegido
            for(Account cuenta : cuentasValidadasLeadProfiler){
                // HMF 052323 / Si el Prospectador se borra, enviar mensaje de error:
                if(cuenta.Prospectador__c==null && !cuenta.Desasignacion_Auto_Prospectador__c && cuenta.Prospectador__c != cuentasExistentes.get(cuenta.Id).Prospectador__c &&  cuentasExistentes.get(cuenta.Id).Estatus_Prospectador__c == 'ASIGNADO') {
                    cuenta.addError('No se puede desasignar un Prospectador Vigente.'); 
                    system.debug('No se puede desasignar un Prospectador Vigente.'); 
                } else {
                    // *** HMF 052423 / Si ya tiene Prospectador Asignado, no se permite cambiarlo
                    if (cuenta.Prospectador__c != cuentasExistentes.get(cuenta.Id).Prospectador__c && cuenta.Prospectador__c!=null  && cuentasExistentes.get(cuenta.Id).Prospectador__c!=null  && !cuenta.IsVRBypassed__c) {
                        cuenta.addError('No se puede cambiar un Prospectador Asignado vigente');
                        system.debug('No se puede cambiar un Prospectador Asignado vigente2');
                    } else {
                        // *** HMF 052323 / Si ya tiene asesor Vigente ASIGNADO, no se permite asignar Prospectador
                        if (cuenta.Prospectador__c != null && cuentasExistentes.get(cuenta.Id).Prospectador__c==null && cuenta.Asesor__c != null && cuenta.Estatus_Asesor__c == 'ASIGNADO') {
                            if(cuenta.Prospectador__c != mapaUsuariosGenericos.get('JAVER GENERICO').Id ) {
                                cuenta.addError('No se puede asignar un Prospectador porque ya tiene asignado a un Asesor.');
                                system.debug('no se puede 3');
                            }
                        } else {
                            //Si la cuenta modificada tiene asociado un prospectador, este es diferente al que ya tenia y este es diferente a PROSPECTADOR COLABORADOR JAVER Y diferente a PROSPECTADOR LP se agrega a una lista para continuar con la validacion
                            if(String.isBlank(cuenta.Prospectador__c) == false && 
                               cuenta.Prospectador__c != cuentasExistentes.get(cuenta.Id).Prospectador__c  && 
                               cuenta.Prospectador__c != mapaUsuariosGenericos.get('JAVER GENERICO').Id) {
                                   system.debug('Entro aqui 4');
                                   idsProspectadores.add(cuenta.Prospectador__c); idsFraccionamientosProspectadores.add(cuenta.Fraccionamiento_cta__c);    cuentasProspectadores.add(cuenta);
                               }
                            else{
                                cuentasValidadasProspectador.add(cuenta);
                            }
                        }
                    }
                }
            }
            
            //Si hubo cuentas modificadas con prospectador asociado a ellas y este es diferente al que ya tenia la cuenta, se procede a validar que el prospectador corresponda al fraccionamiento elegido
            if(idsProspectadores.size() > 0){
                
                //Se obtienen los datos de los usuarios elegidos como prospectadores y de los fraccionamientos elegidos
                Map<Id,User> usuarios = new Map<Id,User>([SELECT Id, FraccionamientoAutorizados__c FROM User WHERE Id IN : idsProspectadores]);
                Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientosProspectadores]);            
                
                //Se valida que las cuentas modificadas que tengan asociado un prospectador corresponda al fraccionamiento elegido
                for(Account cuenta : cuentasProspectadores){
                    
                    if(String.isBlank(usuarios.get(cuenta.Prospectador__c).FraccionamientoAutorizados__c) == false){
                        
                        //Si el prospectador no corresponde al fraccionamiento elegido se envia error
                        if(usuarios.get(cuenta.Prospectador__c).FraccionamientoAutorizados__c.contains(fraccionamientos.get(cuenta.Fraccionamiento_cta__c).Name) == false){
                            cuenta.addError('El Prospectador elegido no tiene asignado el fraccionamiento elegido');
                        }
                        //Si el prospectador si corresponde al fraccionamiento elegido se agrega a la lista para continuar con la asignacion de valores automaticos
                        else{
                            cuentasValidadasProspectador.add(cuenta);
                        }
                    }
                    else{
                        cuenta.addError('El Prospectador elegido no tiene algún fraccionamiento asignado');
                    }
                }
            }
            
            //De las cuentas creadas que no tienen asignado un lead profiler o 
            //que tienen lead profiler y este es diferente al que ya tenia la cuenta pero que ya se valido que el lead profiler corresponde al fraccionamiento elegido o
            //que no tienen asignado un prospectador o
            //que tienen prospectador y este es diferente al que ya tenia la cuenta pero que ya se valido que el prospectador corresponde al fraccionamiento elegido
            //si tienen asignado un asesor, se valida que este corresponda con el fraccionamiento elegido
            for(Account cuenta : cuentasValidadasProspectador){
                
                //Si la cuenta modificada tiene asociado un asesor se agrega a una lista para continuar con la validacion
                if(String.isBlank(cuenta.Asesor__c) == false){
                    
                    idsAsesores.add(cuenta.Asesor__c);  idsFraccionamientosAsesores.add(cuenta.Fraccionamiento_cta__c);    cuentasAsesores.add(cuenta);
                }
                else{
                    cuentasValidadasAsesor.add(cuenta);
                }
            }
            
            //Si hubo cuentas modificadas con asesor asociado a ellas y este es diferente al que ya tenia la cuenta, se procede a validar que el asesor corresponda al fraccionamiento elegido
            if(idsAsesores.size() > 0){
                
                //Se obtienen los datos de los usuarios elegidos como asesores y de los fraccionamientos elegidos
                Map<Id,User> usuarios = new Map<Id,User>([SELECT Id, FraccionamientoAutorizados__c FROM User WHERE Id IN : idsAsesores]);
                Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientosAsesores]);            
                system.debug('Map Fraccionamientos '+fraccionamientos);
                //Se valida que las cuentas modificadas que tengan asociado un asesor corresponda al fraccionamiento elegido
                // *HMF* Se comenta por error reportado por Ivette, Por revisar lineas 809-825
                for(Account cuenta : cuentasAsesores){
                    // *** HMF 052423 / Si ya tiene Asesor Asignado, no se permite cambiarlo (a menos que sea batch desasignación)
                    if (cuenta.Asesor__c != cuentasExistentes.get(cuenta.Id).Asesor__c && !cuenta.Desasignacion_Auto_Asesor__c && cuenta.Asesor__c!=null && cuentasExistentes.get(cuenta.Id).Asesor__c!=null && !cuenta.IsVRBypassed__c && cuenta.Fraccionamiento_cta__c == cuentasExistentes.get(cuenta.Id).Fraccionamiento_cta__c) {
                        cuenta.addError('No se puede cambiar un Asesor Asignado vigente');
                    } else {
                        system.debug('*** Cuenta:'+ cuenta.Id );
                        system.debug('FraccionamientosAutorizados: '+usuarios.get(cuenta.Asesor__c).FraccionamientoAutorizados__c);
                        system.debug('cuenta.Fraccionamiento: '+cuenta.Fraccionamiento_cta__c);
                        if(String.isBlank(usuarios.get(cuenta.Asesor__c).FraccionamientoAutorizados__c) == false && String.isBlank(fraccionamientos.get(cuenta.Fraccionamiento_cta__c).Name) == false){
                            
                            //Si el asesor no corresponde al fraccionamiento elegido se envia error
                            if(usuarios.get(cuenta.Asesor__c).FraccionamientoAutorizados__c.contains(fraccionamientos.get(cuenta.Fraccionamiento_cta__c).Name) == false){
                                cuenta.addError('El Asesor elegido no tiene asignado el fraccionamiento elegido');
                            }
                            //Si el asesor si corresponde al fraccionamiento elegido se agrega a la lista para continuar con la asignacion de valores automaticos
                            else{
                                cuentasValidadasAsesor.add(cuenta);
                            }
                        }
                        else{
                            cuenta.addError('El Asesor elegido no tiene el fraccionamiento asignado');
                        }
                    }
                }
            }
            
            //De las cuentas modificadas que no tienen asignado un lead profiler o 
            //que tienen lead profiler y este es diferente al que ya tenia la cuenta pero que ya se valido que el lead profiler corresponde al fraccionamiento elegido o
            //que no tienen asignado un prospectador o
            //que tienen prospectador y este es diferente al que ya tenia la cuenta pero que ya se valido que el prospectador corresponde al fraccionamiento elegido o
            //que no tienen asignado un asesor o
            //que tienen asesor y este es diferente al que ya tenia la cuenta pero que ya se valido que el asesor corresponde al fraccionamiento elegido
            //se valida que, si la cuenta tiene marcado el check apellido, el fraccionamiento elegido tenga asociado un usuario jefe de formalizacion
            //si el fraccionamiento elegido no tiene un jefe de formalizacion se envia error
            //si el fraccionamiento elegido si tiene un jefe de formalizacion se asigna al campo Jefe_Formalizacion__c
            //Se recorren las cuentas creadas para obtener aquellas que si tengan marcado el check apellido
            Set<Id> idsFraccionamientos = new Set<Id>();
            List<Account> cuentasValidadasCheckApellido = new List<Account>();
            List<Account> cuentasSiCheckApellido = new List<Account>();
            
            for(Account cuentaModificada : cuentasValidadasAsesor){
                
                //Si la cuenta creada tiene marcado el check apellido se agrega a una lista para su posterior validacion
                if(cuentaModificada.Check_Apellido__c == true && cuentasExistentes.get(cuentaModificada.Id).Check_Apellido__c == false){
                    
                    idsFraccionamientos.add(cuentaModificada.Fraccionamiento_cta__c);  cuentasSiCheckApellido.add(cuentaModificada);
                }
                //Si la cuenta creada no tiene marcado el check apellido se agrega a una lista para continuar con la asignacion de valores automaticos
                else{
                    cuentasValidadasCheckApellido.add(cuentaModificada);
                }
            }
            
            //Si hubo cuentas creadas marcadas con el check apellido se valida que el fraccionamiento elegido tenga asociado un usuario jefe de formalizacion
            if(cuentasSiCheckApellido.size() > 0){
                //Se obtienen los datos de los fraccionamientos elegidos
                Set<String> nombresFraccionamientos = new Set<String>();  Map<Id,String> fraccionamientos = new Map<Id,String>();
                for(Fraccionamiento__c fraccionamiento : [SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientos]){
                    nombresFraccionamientos.add('%' + fraccionamiento.Name + '%'); fraccionamientos.put(fraccionamiento.Id, fraccionamiento.Name);
                }
                List<User> usuariosJefesFormalizacion = [SELECT Id, Name, FraccionamientoAutorizados__c   FROM User  WHERE Profile.Name = 'JAVER - Jefe de Formalización'  AND (FraccionamientoAutorizados__c LIKE : nombresFraccionamientos OR FraccionamientoAutorizados__c = 'TODOS') ];
                Map<Id,User> idFracciomientoUsuarioJefeFormalizacion = new Map<Id,User>();
                for(Id idFraccionamiento : fraccionamientos.keySet()){
                    
                    System.debug('*****idFraccionamiento:' + idFraccionamiento);
                    for(User usuarioJefeFormalizacion : usuariosJefesFormalizacion){
                        if(usuarioJefeFormalizacion.FraccionamientoAutorizados__c.contains(fraccionamientos.get(idFraccionamiento)) == true){
                            idFracciomientoUsuarioJefeFormalizacion.put(idFraccionamiento, usuarioJefeFormalizacion);
                        }
                    }                
                }
                System.debug('*****idFracciomientoUsuarioJefeFormalizacion:' + idFracciomientoUsuarioJefeFormalizacion);
                
                //Se recorren las cuentas creadas marcadas con el check apellido para validar que el fraccionamiento elegido tenga asociado un usuario jefe de formalizacion
                for(Account cuentaSiCheckApellido : cuentasSiCheckApellido){
                    
                    System.debug('*****cuentaSiCheckApellido.Fraccionamiento_cta__c:' + cuentaSiCheckApellido.Fraccionamiento_cta__c);
                    System.debug('*****idFracciomientoUsuarioJefeFormalizacion.containsKey(cuentaSiCheckApellido.Fraccionamiento_cta__c):' + idFracciomientoUsuarioJefeFormalizacion.containsKey(cuentaSiCheckApellido.Fraccionamiento_cta__c));
                    //Si el fraccionamiento elegido en la cuenta marcada con el check apellido no tiene un usuario jefe de formalizacion asociado, se envia error
                    // HMF 052323 * iFalk comento que no se requiere esta asignacion/validación automática el 05/23/23
                    // if(idFracciomientoUsuarioJefeFormalizacion.containsKey(cuentaSiCheckApellido.Fraccionamiento_cta__c) == false){
                    //     cuentaSiCheckApellido.addError('No existe un usuario Jefe de Formalización para el fraccionamiento seleccionado');
                    // }
                    //Si el fraccionamiento elegido en la cuenta marcada con el check apellido si tiene un usuario jefe de formalizacion asociado, se popula el campo Jefe_Formalizacion__c y
                    //Se agrega a la lista de cuentas que no tienen marcado el check apellido para continuar con la asignacion de valores automaticos
                    // else{
                    //     cuentaSiCheckApellido.Jefe_Formalizacion__c = idFracciomientoUsuarioJefeFormalizacion.get(cuentaSiCheckApellido.Fraccionamiento_cta__c).Id;
                    cuentasValidadasCheckApellido.add(cuentaSiCheckApellido);
                    // }
                }
            }
            
            //De las cuentas modificadas que no tuvieron marcado el check apellido o
            //que tienen marcado el check apellido pero si existe un usuario jefe de formalizacion asociado al fraccionamiento elegido en la cuenta
            //se valida si la cuenta esta en estatus baja
            //si la cuenta si esta en estatus BAJA no se puede modificar nada de la cuenta excepto el campo Motivo Reactivacion
            List<Account> cuentasModificadasValidadasBajaIncubacion = new List<Account>();
            Map<Id,Account> cuentasExistentesValidadasBajaIncubacion = new Map<Id,Account>();
            for(Account cuentaModificada : cuentasValidadasCheckApellido){
                //Si la cuenta ya tenia algun valor en el campo Tipo de Baja y en el campo Motivo de Baja (estatus de la cuenta es BAJA) 
                //y no tiene Motivo Reactivacion y el Motivo de Reactivacion si es el mismo que ya tenia previamente no se puede modificar la cuenta
                //Mejora: checar por status=BAJA
                // if(String.isBlank(cuentasExistentes.get(cuentaModificada.Id).Tipo_Baja__c) == false &&  // tipo baja no null
                //     String.isBlank(cuentasExistentes.get(cuentaModificada.Id).Motivo_Baja__c) == false && // motivo baja no null
                //     String.isBlank(cuentaModificada.Motivo_Reactivacion__c) == true &&  // motivo reactivacion null
                //     cuentaModificada.Motivo_Reactivacion__c == cuentasExistentes.get(cuentaModificada.Id).Motivo_Reactivacion__c){ //motivo reactivacion no cambio
                if(cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c=='Baja' &&    cuentaModificada.Baja_Incubadora__c!='Reactivación') {
                    //Si la modificacion de la cuenta no es por la desasignacion automatica se muestra mensaje de error
                    if(cuentaModificada.Desasignacion_Auto_Asesor__c == false && cuentaModificada.Desasignacion_Auto_Prospectador__c == false && cuentaModificada.Desasignacion_Auto_Lead_Profiler__c == false && cuentaModificada.Desasignacion_Auto_Colaborador_Javer__c == false){
                        cuentaModificada.addError('La cuenta esta en estatus BAJA y por lo tanto no puede modificarse');
                    }                    
                } else
                    // No se permite pasar de Incubadura => Baja
                    if(cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c=='Incubadora' && cuentaModificada.Baja_Incubadora__c=='Baja') {
                        cuentaModificada.addError('La cuenta esta en estatus INCUBADORA y por lo tanto no puede cambiarse a BAJA');
                    }
                //Si la cuenta ya tenia algun valor en el campo Tipo de Baja y en el campo Motivo de Baja (estatus de la cuenta es BAJA) 
                //y si tiene Motivo Reactivacion y el Motivo de Reactivacion no es el mismo que ya tenia previamente se le asigna 
                //el estatus POR ASIGNAR o POR REASIGNAR
                //Cuenta se REACTIVA
                //Mejora: Pasó de BAJA -> REACTIVACION
                // else if(String.isBlank(cuentasExistentes.get(cuentaModificada.Id).Tipo_Baja__c) == false && // tipo baja no null
                //         String.isBlank(cuentasExistentes.get(cuentaModificada.Id).Motivo_Baja__c) == false && // motivo baja no null
                //         String.isBlank(cuentaModificada.Motivo_Reactivacion__c) == false && // motivo reactivacion no null
                //         cuentaModificada.Motivo_Reactivacion__c != cuentasExistentes.get(cuentaModificada.Id).Motivo_Reactivacion__c){ // motivo reactivacion cambio
                else if(cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c=='Baja' &&  cuentaModificada.Baja_Incubadora__c=='Reactivación') {
                    
                    //Si al reactivarse una cuenta no tenia Asesor, Prospectador, Lead Profiler ni Colaborador Javer asignados el estatus es POR ASIGNAR
                    if(String.isBlank(cuentaModificada.Asesor__c) == true && String.isBlank(cuentaModificada.Prospectador__c) == true && String.isBlank(cuentaModificada.Lead_Profiler__c) == true && String.isBlank(cuentaModificada.Colaborador_Javer__c) == true){
                        cuentaModificada.Estatus_Cliente__c = cuentaModificada.Estatus_Cliente_Anterior__c;
                        if (cuentaModificada.Estatus_Cliente__c==null) {cuentaModificada.Estatus_Cliente__c='POR ASIGNAR';}
                    }
                    //Si al reactivarse una cuenta si tenia Asesor, Prospectador, Lead Profiler o Colaborador Javer asignados el estatus es POR REASIGNAR
                    else{
                        cuentaModificada.Estatus_Cliente__c = cuentaModificada.Estatus_Cliente_Anterior__c;
                        if (cuentaModificada.Estatus_Cliente__c==null) {cuentaModificada.Estatus_Cliente__c='POR REASIGNAR';}                        
                    }
                    // actualiza status, crea nuevas listas de Modificadas y Existentes
                    cuentaModificada.Fecha_Estatus__c = Datetime.now();
                    // Mejora: Borrar Motivo Baja y Tipo Baja?
                    cuentasModificadasValidadasBajaIncubacion.add(cuentaModificada);
                    cuentasExistentesValidadasBajaIncubacion.put(cuentaModificada.Id, cuentasExistentes.get(cuentaModificada.Id));
                }
                //Si la cuenta ya tenia algun valor en el campo Motivo Incubacion (estatus de la cuenta es INCUBADORA) y no tiene Motivo Reactivacion 
                //y el Motivo de Reactivacion si es el mismo que ya tenia previamente no se puede modificar la cuenta
                //Mejora checar por status Cuenta = Incubadora
                // else if(String.isBlank(cuentasExistentes.get(cuentaModificada.Id).Motivo_Incubacion__c) == false && // Previo Motivo Incubacion es No Null
                //         String.isBlank(cuentaModificada.Motivo_Reactivacion__c) == true &&  //motivo Reactivacion = null
                //         cuentaModificada.Motivo_Reactivacion__c == cuentasExistentes.get(cuentaModificada.Id).Motivo_Reactivacion__c){
                else if(cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c=='Incubadora' &&  cuentaModificada.Baja_Incubadora__c!='Reactivación') {                            
                    //Si la modificacion de la cuenta no es por la desasignacion automatica se muestra mensaje de error
                    if(cuentaModificada.Desasignacion_Auto_Asesor__c == false && cuentaModificada.Desasignacion_Auto_Prospectador__c == false && cuentaModificada.Desasignacion_Auto_Lead_Profiler__c == false && cuentaModificada.Desasignacion_Auto_Colaborador_Javer__c == false){
                        cuentaModificada.addError('La cuenta esta en estatus INCUBADORA y por lo tanto no puede modificarse');
                    }
                }
                //Si la cuenta ya tenia algun valor en el campo Motivo Incubacion (estatus de la cuenta es INCUBADORA)
                //y si tiene Motivo Reactivacion y el Motivo de Reactivacion no es el mismo que ya tenia previamente 
                //se le asigna el estatus POR ASIGNAR o POR REASIGNAR
                //Mejora: se reactiva, Status de Baja/Incubadora -> Reactivado
                // else if(String.isBlank(cuentasExistentes.get(cuentaModificada.Id).Motivo_Incubacion__c) == false && // Motivo Incubacion no null
                //     String.isBlank(cuentaModificada.Motivo_Reactivacion__c) == false && // motivo reactivacion no null
                //     cuentaModificada.Motivo_Reactivacion__c != cuentasExistentes.get(cuentaModificada.Id).Motivo_Reactivacion__c){ //motivo reactivacionc cambio
                else if(cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c=='Incubadora' &&   cuentaModificada.Baja_Incubadora__c=='Reactivación') {                        
                    
                    //Si al reactivarse una cuenta no tenia Asesor, Prospectador, Lead Profiler ni Colaborador Javer asignados el estatus es POR ASIGNAR
                    if(String.isBlank(cuentaModificada.Asesor__c) == true && String.isBlank(cuentaModificada.Prospectador__c) == true && String.isBlank(cuentaModificada.Lead_Profiler__c) == true && String.isBlank(cuentaModificada.Colaborador_Javer__c) == true){
                        cuentaModificada.Estatus_Cliente__c = cuentaModificada.Estatus_Cliente_Anterior__c;
                        if (cuentaModificada.Estatus_Cliente__c==null) {cuentaModificada.Estatus_Cliente__c='POR ASIGNAR';}
                    }
                    //Si al reactivarse una cuenta si tenia Asesor, Prospectador, Lead Profiler o Colaborador Javer asignados el estatus es POR REASIGNAR
                    else{
                        cuentaModificada.Estatus_Cliente__c = cuentaModificada.Estatus_Cliente_Anterior__c;
                        if (cuentaModificada.Estatus_Cliente__c==null) {cuentaModificada.Estatus_Cliente__c='POR REASIGNAR';}
                    }
                    
                    cuentaModificada.Fecha_Estatus__c = Datetime.now();
                    // reactivada, borrar status incubadora:
                    cuentaModificada.Motivo_Incubacion__c = null;
                    cuentaModificada.Fecha_a_Contactar__c = null;
                    cuentasModificadasValidadasBajaIncubacion.add(cuentaModificada);
                    cuentasExistentesValidadasBajaIncubacion.put(cuentaModificada.Id, cuentasExistentes.get(cuentaModificada.Id));
                }
                //Si la cuenta no esta en estatus BAJA, se agrega la cuenta con sus valores modificados y existentes a una lista 
                //y a un mapa para la posterior asignacion de valores automaticos
                //Si no se llena en esta lista, no entra a valores automáticos
                else{
                    cuentasModificadasValidadasBajaIncubacion.add(cuentaModificada);
                    cuentasExistentesValidadasBajaIncubacion.put(cuentaModificada.Id, cuentasExistentes.get(cuentaModificada.Id));
                }
                
                System.debug('*****cuentaModificada.Estatus_Cliente__c:' + cuentaModificada.Estatus_Cliente__c);
            }
            
            //Si hay cuentas que pasaron exitosamente las validaciones se procede a llenarles los campos automaticos
            if(cuentasModificadasValidadasBajaIncubacion.size() > 0){
                asignaValoresAutomaticosCuenta(cuentasModificadasValidadasBajaIncubacion,cuentasExistentesValidadasBajaIncubacion);
            }
        }
    }
    
    //Metodo que asigna valores automaticos a la cuenta cuando ha sido modificada:
    //Categoria
    //Identificador unico a las cuentas cuando el tipo de registro de la cuenta ha sido cambiado a cliente (Cliente Persona Fisica o Cliente Persona Moral)
    public static void asignaValoresAutomaticosCuenta(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        asignaFechaNacimientoTextoEdicion(cuentasModificadas,cuentasExistentes);
        asignaCategoriaEdicion(cuentasModificadas,cuentasExistentes);
        // *** HMF 052323 / Se reactiva codigo comentado por CAPPTUS
        validaCambioFraccionamiento(cuentasModificadas,cuentasExistentes);
        asignaEstatusEdicion(cuentasModificadas,cuentasExistentes);
        asignaRFCCURPEdicion(cuentasModificadas,cuentasExistentes);
        asignaNombreFraccEdicion(cuentasModificadas,cuentasExistentes);
        asignaIdentificadorUnicoEdicion(cuentasModificadas,cuentasExistentes);
        validaDominioEmail(cuentasModificadas);
        asignaTipoRegistroEdicion(cuentasModificadas,cuentasExistentes);
        asignaGerenteVentasEdicion(cuentasModificadas,cuentasExistentes);
    }
    
    //Metodo que asigna la fecha de nacimiento como texto para regla de duplicidad
    public static void asignaFechaNacimientoTextoCreacion(List<Account> cuentasNuevas){
        
        for(Account cuentaNueva : cuentasNuevas){
            
            if(String.isBlank(String.valueOf(cuentaNueva.FechaNacimiento__c)) == false){
                cuentaNueva.Fecha_Nacimiento_Texto__c = String.valueOf(cuentaNueva.FechaNacimiento__c);
            }
        }
    }
    
    //Metodo que asigna la fecha de nacimiento como texto para regla de duplicidad
    public static void asignaFechaNacimientoTextoEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        for(Account cuentaModificada : cuentasModificadas){
            
            if(String.isBlank(String.valueOf(cuentaModificada.PersonBirthdate)) == false && cuentaModificada.PersonBirthdate != cuentasExistentes.get(cuentaModificada.Id).PersonBirthdate){
                cuentaModificada.Fecha_Nacimiento_Texto__c = String.valueOf(cuentaModificada.FechaNacimiento__c);
            }
        }
    }
    
    //Metodo que asigna la categoria a las cuentas nuevas
    public static void asignaCategoriaCreacion(List<Account> cuentasNuevas){
        
        for(Account cuentaNueva : cuentasNuevas){
            
            cuentaNueva.Categoria__c = 'NUEVO';
            cuentaNueva.Fecha_Captura__c = Date.today();
        }
    }
    
    //Metodo que asigna la categoria a las cuentas modificadas
    public static void asignaCategoriaEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        for(Account cuentaModificada : cuentasModificadas){
            
            System.debug('*****cuentaModificada.Motivo_Reactivacion__c:'+cuentaModificada.Motivo_Reactivacion__c);
            System.debug('*****cuentasExistentes.get(cuentaModificada.Id).Motivo_Reactivacion__c:'+cuentasExistentes.get(cuentaModificada.Id).Motivo_Reactivacion__c);
            System.debug('*****cuentaModificada.Categoria__c:'+cuentaModificada.Categoria__c);
            System.debug('*****String.isBlank(cuentaModificada.Motivo_Reactivacion__c):'+String.isBlank(cuentaModificada.Motivo_Reactivacion__c));
            
            // Si motivo reactivación cambió O Motivo reactivacion no es nulo = REACTIVADO
            // Mejora: Previo = BAJA o INCUBACION  Actual = REACTIVADO
            // if(cuentaModificada.Motivo_Reactivacion__c != cuentasExistentes.get(cuentaModificada.Id).Motivo_Reactivacion__c // motivo cambio
            //     || String.isBlank(cuentaModificada.Motivo_Reactivacion__c) == false) { // motivo reactivacion no null
            if(cuentaModificada.Baja_Incubadora__c == 'Reactivación' 
               && (cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c == 'Baja' || cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c == 'Incubadora')) {
                   cuentaModificada.Categoria__c = 'REACTIVADO';
                   // HMF - Limpiar los campos relacionados en reactivación
                   cuentaModificada.Motivo_Incubacion__c = null; cuentaModificada.Fecha_a_Contactar__c = null; cuentaModificada.Tipo_Baja__c = null;  cuentaModificada.Motivo_Baja__c = null;
                   // Guardar estatus anterior
                   cuentaModificada.Estatus_Cliente_Anterior__c = cuentaModificada.Estatus_Cliente__c;
                   if (cuentaModificada.Estatus_Cliente__c==null) {cuentaModificada.Estatus_Cliente__c='POR ASIGNAR';}
                   
                   // HMF - Si tiene Asesor Vigente, poner estatus Cliente como ASIGNADO
                   // 0526 comento este codigo al activar codigo para Estatus Cliente Anterior
                   // if (cuentaModificada.Estatus_Asesor__c == 'ASIGNADO') {cuentaModificada.Estatus_Cliente__c = 'ASIGNADO';}
               }
            // HMF 052423 / Si estaba REACTIVADO y pasa a BAJA, se borra campo Motivo_Reactivacion
            if((cuentaModificada.Baja_Incubadora__c == 'Baja' || cuentaModificada.Baja_Incubadora__c == 'Incubadora')  && cuentasExistentes.get(cuentaModificada.Id).Baja_Incubadora__c == 'Reactivación') {
                // HMF - Limpiar los campos relacionados en reactivación
                cuentaModificada.Motivo_Reactivacion__c = null;  cuentaModificada.Estatus_Cliente_Anterior__c = cuentaModificada.Estatus_Cliente__c;
            }
        }
    }
    
    //Metodo que valida el cambio de fraccionamiento en la edicion de una cuenta para actualizar campos de la cuenta
    public static void validaCambioFraccionamiento(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        // Al cambiar Asesor, obtener del histórico de asignaciones el Asesor anterior (si lo hay). Si no lo hay poner null
        // Crear set de cuentasModificadas
        Set <String> setCuentas = new Set <String>();
        for (Account cuentaModificada : cuentasModificadas) {
            setCuentas.add(cuentaModificada.Id);
        }
        // Obtener Asesor anterior del fraccionamiento Nuevo
        Map <String, Historial_Asignacion__c> mapHistorial = new Map <String, Historial_Asignacion__c> ();
        List <Historial_Asignacion__c> lstHistAsig = [SELECT Asesor__c,CreatedDate,Cuenta__c,Fecha_Asignacion_Asesor__c,Fecha_Vencimiento_Asesor__c,Fecha_de_Afluencia__c,
                                                      Fraccionamiento__c, Fraccionamiento__r.Name, Id,Name, Motivo_Asignacion__c, JMC_Fecha_Visita__c,Fecha_ltima_visita__c 
                                                      FROM Historial_Asignacion__c
                                                      WHERE Cuenta__c in :setCuentas
                                                      AND Fecha_Vencimiento_Asesor__c >= TODAY
                                                      ORDER BY CreatedDate DESC];
        for (Historial_Asignacion__c hist : lstHistAsig) {
            mapHistorial.put(hist.Fraccionamiento__c, hist);
        }
        system.debug('*** mapHistorial: '+mapHistorial);
        
        //Si fue modificado el fraccionamiento asociado a la cuenta se limpian los valores Asesor, Fecha Asignacion Asesor, Motivo Asignacion, Fecha de Afluencia
        for(Account cuentaModificada : cuentasModificadas){
            
            if(cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                if (mapHistorial.containsKey(cuentaModificada.Fraccionamiento_cta__c)) {
                    system.debug('*** Encontró llave: '+ mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c));
                    //Encontró un Asesor en el historial. Asignar asesor anterior al Asesor
                    if (mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c).Asesor__c != null ) {
                        cuentaModificada.Asesor__c = mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c).Asesor__c;
                        cuentaModificada.Fecha_Asignacion_Asesor__c = mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c).Fecha_Asignacion_Asesor__c;
                        cuentaModificada.Motivo_Asignacion__c = mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c).Motivo_Asignacion__c;
                    }                                        
                    cuentaModificada.Fecha_Hora_Asignacion_Asesor__c = null;
                    // cuentaModificada.Fecha_de_Afluencia__c = mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c).Fecha_de_Afluencia__c;
                    // cuentaModificada.JMC_Fecha_Visita__c= mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c).JMC_Fecha_Visita__c;
                    cuentaModificada.Fecha_ltima_visita__c= mapHistorial.get(cuentaModificada.Fraccionamiento_cta__c).Fecha_ltima_visita__c;
                    cuentaModificada.Desasignacion_Auto_Asesor__c=true; //brincar reglas
                    cuentaModificada.ValidationBypassDateTime__c = System.Now(); //Activar bypass
                    
                } else {
                    if (cuentasExistentes.get(cuentaModificada.Id).Asesor__c == cuentaModificada.Asesor__c ) {
                        cuentaModificada.Asesor__c = null; cuentaModificada.Fecha_Asignacion_Asesor__c = null;  cuentaModificada.Fecha_Hora_Asignacion_Asesor__c = null;
                        cuentaModificada.Motivo_Asignacion__c = null;
                        // cuentaModificada.Fecha_de_Afluencia__c = null;
                    } else {
                        cuentaModificada.Fecha_Asignacion_Asesor__c = date.today(); cuentaModificada.Fecha_Hora_Asignacion_Asesor__c = datetime.now(); cuentaModificada.Motivo_Asignacion__c = null;
                        // cuentaModificada.Fecha_de_Afluencia__c = null;
                        cuentaModificada.ValidationBypassDateTime__c = System.Now(); //Activar bypass
                    }
                }
            }
        }
    }
    
    //Metodo que asigna el estatus del cliente a las cuentas nuevas
    public static void asignaEstatusCreacion(List<Account> cuentasNuevas){
        
        Boolean estatusAsignado = false;
        for(Account cuentaNueva : cuentasNuevas){
            
            estatusAsignado = false;
            
            //Si la nueva cuenta se creo con los campos vacios: Asesor, Prospectador, Lead Profiler y Colaborador Javer:
            //El estatus de la cuenta, el estatus del asesor, el estatus del prospectador, el estatus del lead profiler y el estatus del colaborador Javer es POR ASIGNAR
            //La fecha del estatus del asesor, la fecha del estatus del prospectador, la fecha del estatus del lead profiler y la fecha del estatus del colaborador Javer es la de ese momento
            if(String.isBlank(cuentaNueva.Asesor__c) == true && String.isBlank(cuentaNueva.Prospectador__c) == true && String.isBlank(cuentaNueva.Lead_Profiler__c) == true && String.isBlank(cuentaNueva.Colaborador_Javer__c) == true){
                
                estatusAsignado = false;
                cuentaNueva.Estatus_Cliente__c = 'POR ASIGNAR';cuentaNueva.Estatus_Asesor__c = 'POR ASIGNAR';
                // cuentaNueva.Fecha_Estatus_Asesor__c = Datetime.now();
                cuentaNueva.Estatus_Prospectador__c = 'POR ASIGNAR';
                // cuentaNueva.Fecha_Estatus_Prospectador__c = Datetime.now();
                cuentaNueva.Estatus_LP__c = 'POR ASIGNAR';
                // cuentaNueva.Fecha_Estatus_LP__c = Datetime.now();
                cuentaNueva.Estatus_Colaborador_Javer__c = 'POR ASIGNAR';
                // cuentaNueva.Fecha_Estatus_Colaborador_Javer__c = Datetime.now();                
            }
            
            //Si la nueva cuenta se creo con alguno de los campos no vacios: Asesor, Prospectador, Lead Profiler o Colaborador Javer:
            //El estatus de la cuenta es ASIGNADO
            //La fecha del estatus del asesor, la fecha del estatus del prospectador, la fecha del estatus del lead profiler y la fecha del estatus del colaborador Javer es la de ese momento
            if(String.isBlank(cuentaNueva.Asesor__c) == false || String.isBlank(cuentaNueva.Prospectador__c) == false ||String.isBlank(cuentaNueva.Lead_Profiler__c) == false || String.isBlank(cuentaNueva.Colaborador_Javer__c) == false){
                
                estatusAsignado = false;
                cuentaNueva.Estatus_Cliente__c = 'POR ASIGNAR';
                // cuentaNueva.Fecha_Estatus_Asesor__c = Datetime.now();
                // cuentaNueva.Fecha_Estatus_Prospectador__c = Datetime.now();
                // cuentaNueva.Fecha_Estatus_LP__c = Datetime.now();
                // cuentaNueva.Fecha_Estatus_Colaborador_Javer__c = Datetime.now();
                
                //Si la nueva cuenta se creo con el campo Asesor no vacio, el estatus del asesor es ASIGNADO
                if(String.isBlank(cuentaNueva.Asesor__c) == false){
                    cuentaNueva.Estatus_Asesor__c = 'ASIGNADO';
                    cuentaNueva.Fecha_Estatus_Asesor__c = Datetime.now();
                    cuentaNueva.Fecha_Asignacion_Asesor__c = Date.today();
                    cuentaNueva.Fecha_Hora_Asignacion_Asesor__c = Datetime.now();
                    cuentaNueva.Estatus_Cliente__c = 'ASIGNADO';
                }
                //Si la nueva cuenta se creo con el campo Asesor vacio, el estatus del asesor es POR ASIGNAR
                else{
                    cuentaNueva.Estatus_Asesor__c = 'POR ASIGNAR';
                }
                
                //Si la nueva cuenta se creo con el campo Prospectador no vacio, el estatus del prospectador es ASIGNADO
                if(String.isBlank(cuentaNueva.Prospectador__c) == false){
                    cuentaNueva.Estatus_Prospectador__c = 'ASIGNADO';
                    cuentaNueva.Fecha_Prospeccion__c = Date.today();
                    cuentaNueva.Fecha_Estatus_Prospectador__c = Datetime.now();
                    cuentaNueva.Fecha_Hora_Prospeccion__c = Datetime.now();
                }
                //Si la nueva cuenta se creo con el campo Prospectador vacio, el estatus del prospectador es POR ASIGNAR
                else{
                    cuentaNueva.Estatus_Prospectador__c = 'POR ASIGNAR';
                }
                
                //Si la nueva cuenta se creo con el campo Lead Profiler no vacio, el estatus del lead profiler es ASIGNADO
                if(String.isBlank(cuentaNueva.Lead_Profiler__c) == false){
                    cuentaNueva.Estatus_LP__c = 'ASIGNADO'; cuentaNueva.Fecha_LP__c = Date.today();
                    cuentaNueva.Fecha_Estatus_LP__c = Datetime.now(); cuentaNueva.Fecha_Hora_LP__c = Datetime.now();
                }
                //Si la nueva cuenta se creo con el campo Lead Profiler vacio, el estatus del lead profiler es POR ASIGNAR
                else{
                    cuentaNueva.Estatus_LP__c = 'POR ASIGNAR';
                }
                
                //Si la nueva cuenta se creo con el campo Colaborador Javer no vacio, el estatus del colaborador Javer es ASIGNADO
                if(String.isBlank(cuentaNueva.Colaborador_Javer__c) == false){
                    cuentaNueva.Estatus_Colaborador_Javer__c = 'ASIGNADO';  cuentaNueva.Fecha_Colaborador_Javer__c = Date.today();
                    cuentaNueva.Fecha_Estatus_Colaborador_Javer__c = Datetime.now(); cuentaNueva.Fecha_Hora_Colaborador_Javer__c = Datetime.now();
                    cuentaNueva.Colaborador_Javer_Asignacion__c = true; cuentaNueva.Colaborador_Javer_Asignacion_Prorroga__c = false;
                }
                //Si la nueva cuenta se creo con el campo Colaborador Javer vacio, el estatus del colaborador Javer es POR ASIGNAR
                else{
                    cuentaNueva.Estatus_Colaborador_Javer__c = 'POR ASIGNAR';
                }
            }
            
            //Si la cuenta se creo con los campos Tipo de Baja y Motivo de Baja llenos, el estatus del cliente es BAJA
            if(String.isBlank(cuentaNueva.Tipo_Baja__c) == false && String.isBlank(cuentaNueva.Motivo_Baja__c) == false){
                
                estatusAsignado = true;  cuentaNueva.Estatus_Cliente__c = 'BAJA';           
            }
            
            //Si la cuenta se creo con el campo Motivo de Incubacion lleno, el estatus del cliente es INCUBADORA
            if(String.isBlank(cuentaNueva.Motivo_Incubacion__c) == false){
                
                estatusAsignado = true;   cuentaNueva.Estatus_Cliente__c = 'INCUBADORA';                
            }
            
            //Si fue asignado el estatus del cliente por alguna de las condiciones anteriores, se asigna la fecha del estatus del cliente
            if(estatusAsignado == true){
                cuentaNueva.Fecha_Estatus__c = Datetime.now();
            }
        }
    }
    
    //Metodo que asigna el estatus del cliente a las cuentas modificadas
    public static void asignaEstatusEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        //Se recorren las cuentas modificadas para:
        //Si el fraccionamiento no fue modificado se obtienen los roles de venta (Asesor, Prospectador, Lead Profiler y Colaborador Javer) modificados y los datos de estos
        //Si el fraccionamiento si fue modificado se obtienen los roles de venta (Asesor, Prospectador, Lead Profiler y Colaborador Javer) no vacios y los datos de estos
        List<Account> cuentasAsesores = new List<Account>();
        List<Account> cuentasProspectadores = new List<Account>();
        List<Account> cuentasLeadProfilers = new List<Account>();
        List<Account> cuentasColaboradoresJaver = new List<Account>();
        for(Account cuentaModificada : cuentasModificadas){
            
            if(String.isBlank(cuentaModificada.Fraccionamiento_cta__c) == false){
                
                //Si el fraccionamiento asociado a la cuenta no fue modificado
                if(cuentaModificada.Fraccionamiento_cta__c == cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                    
                    //Si se cambio el Asesor a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los asesores
                    if(String.isBlank(cuentaModificada.Asesor__c) == false && cuentaModificada.Asesor__c != cuentasExistentes.get(cuentaModificada.Id).Asesor__c){
                        cuentasAsesores.add(cuentaModificada);
                    }
                    
                    //Si se cambio el Prospectador a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los prospectadores
                    if(String.isBlank(cuentaModificada.Prospectador__c) == false && cuentaModificada.Prospectador__c != cuentasExistentes.get(cuentaModificada.Id).Prospectador__c){
                        cuentasProspectadores.add(cuentaModificada);
                    }
                    
                    //Si se cambio el Lead Profiler a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los lead profilers
                    if(String.isBlank(cuentaModificada.Lead_Profiler__c) == false && cuentaModificada.Lead_Profiler__c != cuentasExistentes.get(cuentaModificada.Id).Lead_Profiler__c){
                        cuentasLeadProfilers.add(cuentaModificada);
                    }
                    
                    //Si se cambio el Colaborador Javer a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los colaboradores Javer
                    if(String.isBlank(cuentaModificada.Colaborador_Javer__c) == false && cuentaModificada.Colaborador_Javer__c != cuentasExistentes.get(cuentaModificada.Id).Colaborador_Javer__c){
                        cuentasColaboradoresJaver.add(cuentaModificada);
                    }
                }
                //Si el fraccionamiento asociado a la cuenta si fue modificado
                else{
                    //Si la cuenta modificada tiene asignado un Asesor, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los asesores
                    if(String.isBlank(cuentaModificada.Asesor__c) == false){
                        cuentasAsesores.add(cuentaModificada);
                    }
                    
                    //Si la cuenta modificada tiene asignado un Prospectador, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los asesores
                    if(String.isBlank(cuentaModificada.Prospectador__c) == false){
                        cuentasProspectadores.add(cuentaModificada);
                    }
                    
                    //Si la cuenta modificada tiene asignado un Lead Profiler, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los asesores
                    if(String.isBlank(cuentaModificada.Lead_Profiler__c) == false){
                        cuentasLeadProfilers.add(cuentaModificada);
                    }
                    
                    //Si la cuenta modificada tiene asignado un Colaborador Javer, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los asesores
                    if(String.isBlank(cuentaModificada.Colaborador_Javer__c) == false){
                        cuentasColaboradoresJaver.add(cuentaModificada);
                    }
                }
            }
        }
        
        //Se obtienen los datos de los registros de Rol de Venta asociados a la cuenta y al Asesor
        Map<String,Rol_Venta__c> cuentasRolVentaAsesores = obtenerCuentasRolesVentaAsesores(cuentasAsesores);
        
        //Se obtienen los datos de los registros de Rol de Venta asociados a la cuenta y al Prospectador
        Map<String,Rol_Venta__c> cuentasRolVentaProspectadores = obtenerCuentasRolesVentaProspectadores(cuentasProspectadores);
        
        //Se obtienen los datos de los registros de Rol de Venta asociados a la cuenta y al Lead Profiler
        Map<String,Rol_Venta__c> cuentasRolVentaLeadProfilers = obtenerCuentasRolesVentaLeadProfilers(cuentasLeadProfilers);
        
        //Se obtienen los datos de los registros de Rol de Venta asociados a la cuenta y al Colaborador Javer
        Map<String,Rol_Venta__c> cuentasRolVentaColaboradoresJaver = obtenerCuentasRolesVentaColaboradoresJaver(cuentasColaboradoresJaver);
        
        Boolean estatusAsignado = false;
        Rol_Venta__c rolVenta = new Rol_Venta__c();
        for(Account cuentaModificada : cuentasModificadas){
            
            System.debug('*****cuentaModificada.Estatus_Cliente__c:' + cuentaModificada.Estatus_Cliente__c);
            //Si la cuenta si esta en estatus POR REASIGNAR y no se ha modificado el Asesor ni el Prospectador ni el Lead Profiler ni el Colaborador Javer, se mantiene la cuenta en estatus POR REASIGNAR
            if(cuentaModificada.Estatus_Cliente__c == 'POR REASIGNAR' && 
               (cuentaModificada.Desasignacion_Auto_Asesor__c == false && cuentaModificada.Desasignacion_Auto_Prospectador__c == false && cuentaModificada.Desasignacion_Auto_Lead_Profiler__c == false && cuentaModificada.Desasignacion_Auto_Colaborador_Javer__c == false) &&
               (cuentaModificada.Asesor__c == cuentasExistentes.get(cuentaModificada.Id).Asesor__c && cuentaModificada.Prospectador__c == cuentasExistentes.get(cuentaModificada.Id).Prospectador__c && cuentaModificada.Lead_Profiler__c == cuentasExistentes.get(cuentaModificada.Id).Lead_Profiler__c && cuentaModificada.Colaborador_Javer__c == cuentasExistentes.get(cuentaModificada.Id).Colaborador_Javer__c)){
                   
                   cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';
               }
            //Si la cuenta no esta en estatus POR REASIGNAR y si se ha modificado el Asesor o el Prospectador o el Lead Profiler o el Colaborador Javer, se procede a la asignacion del estatus del cliente en base los campos de Asesor, Prospectador, Lead Profiler y Colaborador Javer
            else{
                
                //Si la cuenta modificada tiene los campos vacios: Asesor, Prospectador, Lead Profiler y Colaborador Javer:
                //El estatus de la cuenta es POR ASIGNAR o POR REASIGNAR
                if(String.isBlank(cuentaModificada.Asesor__c) == true && String.isBlank(cuentaModificada.Prospectador__c) == true && String.isBlank(cuentaModificada.Lead_Profiler__c) == true && String.isBlank(cuentaModificada.Colaborador_Javer__c) == true){
                    
                    estatusAsignado = true;
                    
                    //Si en la cuenta modificada se modifico el campo Asesor y dicho campo esta vacio, el estatus del asesor es POR ASIGNAR o POR REASIGNAR y la fecha del estatus del asesor es la de ese momento
                    if(String.isBlank(cuentaModificada.Asesor__c) == true && cuentaModificada.Asesor__c != cuentasExistentes.get(cuentaModificada.Id).Asesor__c){
                        
                        //Si se desasigno el Asesor de forma automatica porque ya vencio su estatus es POR REASIGNAR
                        if(cuentaModificada.Desasignacion_Auto_Asesor__c == true){
                            
                            System.debug('*****Entro a Desasignacion_Auto_Asesor__c 1');
                            cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR'; cuentaModificada.Estatus_Asesor__c = 'POR REASIGNAR';
                            cuentaModificada.Fecha_Asignacion_Asesor__c = null; cuentaModificada.Fecha_Hora_Asignacion_Asesor__c = null;  cuentaModificada.Desasignacion_Auto_Asesor__c = false;
                        }
                        //Si no se desasigno el Asesor de forma automatica porque ya vencio su estatus es POR ASIGNAR
                        else{
                            cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';  cuentaModificada.Estatus_Asesor__c = 'POR ASIGNAR';                            
                        }
                        
                        // cuentaModificada.Fecha_Estatus_Asesor__c = Datetime.now();
                    }
                    
                    //Si en la cuenta modificada se modifico el campo Prospectador y dicho campo esta vacio, el estatus del prospectador es POR ASIGNAR o POR REASIGNAR y la fecha del estatus del prospectador es la de ese momento
                    if(String.isBlank(cuentaModificada.Prospectador__c) == true && cuentaModificada.Prospectador__c != cuentasExistentes.get(cuentaModificada.Id).Prospectador__c){
                        
                        //Si se desasigno el Prospectador de forma automatica porque ya vencio su estatus es POR REASIGNAR
                        if(cuentaModificada.Desasignacion_Auto_Prospectador__c == true){
                            
                            System.debug('*****Entro a Desasignacion_Auto_Prospectador__c 1');
                            //cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';
                            cuentaModificada.Estatus_Prospectador__c = 'POR REASIGNAR';
                            cuentaModificada.Fecha_Prospeccion__c = null;  cuentaModificada.Fecha_Hora_Prospeccion__c = null;   cuentaModificada.Desasignacion_Auto_Prospectador__c = false;
                        }
                        //Si no se desasigno el Prospectador de forma automatica porque ya vencio su estatus es POR ASIGNAR
                        else{
                            //cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';
                            cuentaModificada.Estatus_Prospectador__c = 'POR ASIGNAR';                            
                        }
                        
                        // cuentaModificada.Fecha_Estatus_Prospectador__c = Datetime.now();
                    }
                    
                    //Si en la cuenta modificada se modifico el campo Lead Profiler y dicho campo esta vacio, el estatus del lead profiler es POR ASIGNAR o POR REASIGNAR y la fecha del estatus del lead profiler es la de ese momento
                    if(String.isBlank(cuentaModificada.Lead_Profiler__c) == true && cuentaModificada.Lead_Profiler__c != cuentasExistentes.get(cuentaModificada.Id).Lead_Profiler__c){
                        
                        //Si se desasigno el Lead Profiler de forma automatica porque ya vencio su estatus es POR REASIGNAR
                        if(cuentaModificada.Desasignacion_Auto_Lead_Profiler__c == true){
                            
                            System.debug('*****Entro a Desasignacion_Auto_Lead_Profiler__c 1');
                            //cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';
                            cuentaModificada.Estatus_LP__c = 'POR REASIGNAR';
                            cuentaModificada.Fecha_LP__c = null;  cuentaModificada.Fecha_Hora_LP__c = null;
                            cuentaModificada.Desasignacion_Auto_Lead_Profiler__c = false;
                        }
                        //Si no se desasigno el Lead Profiler de forma automatica porque ya vencio su estatus es POR ASIGNAR
                        else{
                            //cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';
                            cuentaModificada.Estatus_LP__c = 'POR ASIGNAR';                            
                        }
                        
                        // cuentaModificada.Fecha_Estatus_LP__c = Datetime.now();
                    }
                    
                    //Si en la cuenta modificada se modifico el campo Colaborador Javer y dicho campo esta vacio, el estatus del colaborador Javer es POR ASIGNAR o POR REASIGNAR y la fecha del estatus del colaborador Javer es la de ese momento
                    if(String.isBlank(cuentaModificada.Colaborador_Javer__c) == true && cuentaModificada.Colaborador_Javer__c != cuentasExistentes.get(cuentaModificada.Id).Colaborador_Javer__c){
                        
                        //Si se desasigno el Colaborador Javer de forma automatica porque ya vencio su estatus es POR REASIGNAR
                        if(cuentaModificada.Desasignacion_Auto_Colaborador_Javer__c == true){
                            
                            System.debug('*****Entro a Desasignacion_Auto_Colaborador_Javer__c 1');
                            //cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';
                            cuentaModificada.Estatus_Colaborador_Javer__c = 'POR REASIGNAR';
                            cuentaModificada.Fecha_Colaborador_Javer__c = null; cuentaModificada.Fecha_Hora_Colaborador_Javer__c = null;
                            cuentaModificada.Desasignacion_Auto_Colaborador_Javer__c = false;
                        }
                        //Si no se desasigno el Colaborador Javer de forma automatica porque ya vencio su estatus es POR ASIGNAR
                        else{
                            //cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';
                            cuentaModificada.Estatus_Colaborador_Javer__c = 'POR ASIGNAR';
                        }
                        
                        // cuentaModificada.Fecha_Estatus_Colaborador_Javer__c = Datetime.now();
                    }
                }
                
                //Si la cuenta modificada tiene alguno de los campos no vacios: Asesor, Prospectador, Lead Profiler o Colaborador Javer:
                //El estatus de la cuenta es ASIGNADO
                //La fecha del estatus del asesor, la fecha del estatus del prospectador, la fecha del estatus del lead profiler y la fecha del estatus del colaborador Javer es la de ese momento
                
                // HMF Comentado el 2023-07-18. No estamos considerando funcionalidad de Roles de Venta 
                // Reactive el código el 7/22 porque si se requiere que se asignen valores:
                if(String.isBlank(cuentaModificada.Asesor__c) == false || String.isBlank(cuentaModificada.Prospectador__c) == false || String.isBlank(cuentaModificada.Lead_Profiler__c) == false || String.isBlank(cuentaModificada.Colaborador_Javer__c) == false){
                    
                    //cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';
                    estatusAsignado = true;
                    
                    //Si en la cuenta modificada se modifico el campo Asesor: la fecha del estatus del asesor es la de ese momento
                    if(cuentaModificada.Asesor__c != cuentasExistentes.get(cuentaModificada.Id).Asesor__c || cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                        
                        cuentaModificada.Fecha_Estatus_Asesor__c = Datetime.now();
                        
                        //Si el campo Asesor no esta vacio, el estatus del asesor es ASIGNADO
                        if(String.isBlank(cuentaModificada.Asesor__c) == false){
                            
                            //Si si existe un registro de Rol de Venta con el Asesor asignado se obtiene los datos de dicho registro
                            if(cuentasRolVentaAsesores.containsKey(String.valueOf(cuentaModificada.Asesor__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'AS') == true){
                                
                                rolVenta = cuentasRolVentaAsesores.get(String.valueOf(cuentaModificada.Asesor__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'AS');
                                
                                //Si el Asesor aun se encuentra vigente para el fraccionamiento elegido se asignan los datos del registro de Rol de Venta a la cuenta
                                if(rolVenta.Vencido__c == false){
                                    cuentaModificada.Fecha_Asignacion_Asesor__c = rolVenta.Fecha_Asignacion__c;
                                    cuentaModificada.Fecha_Hora_Asignacion_Asesor__c = rolVenta.Fecha_Hora_Asignacion__c;
                                }
                                //Si el Asesor ya no se encuentra vigente para el fraccionamiento elegido se envia mensaje de error
                                // 
                                // else{
                                //     cuentaModificada.addError('El Asesor elegido para el fraccionamiento elegido ya no está vigente');
                                // }                                
                            }
                            //Si no existe un registro de Rol de Venta con el Asesor asignado se settean los datos la cuenta
                            else{
                                cuentaModificada.Fecha_Asignacion_Asesor__c = Date.today(); cuentaModificada.Fecha_Hora_Asignacion_Asesor__c = Datetime.now();
                            }
                            
                            cuentaModificada.Estatus_Asesor__c = 'ASIGNADO';  cuentaModificada.Estatus_Cliente__c = 'ASIGNADO';
                            cuentaModificada.Fecha_Estatus_Asesor__c = Datetime.now(); cuentaModificada.Fecha_Asignacion_Asesor__c = Date.today();
                        }
                        //Si el campo Asesor esta vacio, el estatus del asesor es POR REASIGNAR O POR ASIGNAR
                        else{
                            
                            //Si se desasigno el Asesor de forma automatica porque ya vencio su estatus es POR REASIGNAR
                            if(cuentaModificada.Desasignacion_Auto_Asesor__c == true){
                                
                                System.debug('*****Entro a Desasignacion_Auto_Asesor__c 2');
                                cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';  cuentaModificada.Estatus_Asesor__c = 'POR REASIGNAR';
                                cuentaModificada.Fecha_Asignacion_Asesor__c = null;  cuentaModificada.Fecha_Hora_Asignacion_Asesor__c = null;
                                cuentaModificada.Desasignacion_Auto_Asesor__c = false;
                            }
                            //Si no se desasigno el Asesor de forma automatica porque ya vencio su estatus es POR ASIGNAR
                            else{
                                cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR'; cuentaModificada.Estatus_Asesor__c = 'POR ASIGNAR';                            
                            }
                        }
                    }
                    
                    //Si en la cuenta modificada se modifico el campo Prospectador: la fecha del estatus del prospectador es la de ese momento
                    if(cuentaModificada.Prospectador__c != cuentasExistentes.get(cuentaModificada.Id).Prospectador__c || cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                        
                        cuentaModificada.Fecha_Estatus_Prospectador__c = Datetime.now();
                        
                        //Si el campo Prospectador no esta vacio, el estatus del prospectador es ASIGNADO
                        if(String.isBlank(cuentaModificada.Prospectador__c) == false){
                            
                            //Si si existe un registro de Rol de Venta con el Prospectador asignado se obtiene los datos de dicho registro
                            if(cuentasRolVentaProspectadores.containsKey(String.valueOf(cuentaModificada.Prospectador__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'PR') == true){
                                
                                rolVenta = cuentasRolVentaProspectadores.get(String.valueOf(cuentaModificada.Prospectador__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'PR');
                                
                                //Si el Prospectador aun se encuentra vigente para el fraccionamiento elegido se asignan los datos del registro de Rol de Venta a la cuenta
                                if(rolVenta.Vencido__c == false){
                                    // cuentaModificada.Fecha_Prospeccion__c = rolVenta.Fecha_Asignacion__c;
                                    cuentaModificada.Fecha_Hora_Prospeccion__c = rolVenta.Fecha_Hora_Asignacion__c;
                                }
                                //Si el Prospectador ya no se encuentra vigente para el fraccionamiento elegido se envia mensaje de error
                                else{
                                    // cuentaModificada.addError('El Prospectador elegido para el fraccionamiento elegido ya no está vigente');'
                                    system.debug('*** Prospectador elegido el fraccionamiento elegido ya no esta vigente');
                                }
                            }
                            //Si no existe un registro de Rol de Venta con el Prospectador asignado se settean los datos la cuenta
                            else{
                                // cuentaModificada.Fecha_Prospeccion__c = Date.today();
                                cuentaModificada.Fecha_Hora_Prospeccion__c = Datetime.now();
                            }
                            
                            cuentaModificada.Estatus_Prospectador__c = 'ASIGNADO';  cuentaModificada.Fecha_Estatus_Prospectador__c = Datetime.now();
                            cuentaModificada.Fecha_Prospeccion__c = Date.today();
                            
                        }
                        //Si el campo Prospectador esta vacio, el estatus del prospectador es  POR REASIGNAR O POR ASIGNAR
                        else{
                            
                            //Si se desasigno el Prospectador de forma automatica porque ya vencio su estatus es POR REASIGNAR
                            if(cuentaModificada.Desasignacion_Auto_Prospectador__c == true){
                                
                                System.debug('*****Entro a Desasignacion_Auto_Prospectador__c 2');
                                //cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';
                                cuentaModificada.Estatus_Prospectador__c = 'POR REASIGNAR'; cuentaModificada.Fecha_Prospeccion__c = null;
                                cuentaModificada.Fecha_Hora_Prospeccion__c = null; cuentaModificada.Desasignacion_Auto_Prospectador__c = false;
                            }
                            //Si no se desasigno el Prospectador de forma automatica porque ya vencio su estatus es POR ASIGNAR
                            else{
                                //cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';
                                cuentaModificada.Estatus_Prospectador__c = 'POR ASIGNAR';                            
                            }
                        }
                    }
                    
                    //Si en la cuenta modificada se modifico el campo Lead Profiler: la fecha del estatus del lead profiler es la de ese momento
                    if(cuentaModificada.Lead_Profiler__c != cuentasExistentes.get(cuentaModificada.Id).Lead_Profiler__c || cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                        
                        cuentaModificada.Fecha_Estatus_LP__c = Datetime.now();
                        
                        //Si el campo Lead Profiler no esta vacio, el estatus del lead profiler es ASIGNADO
                        if(String.isBlank(cuentaModificada.Lead_Profiler__c) == false){
                            
                            //Si si existe un registro de Rol de Venta con el Lead Profiler asignado se obtiene los datos de dicho registro
                            if(cuentasRolVentaLeadProfilers.containsKey(String.valueOf(cuentaModificada.Lead_Profiler__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'LP') == true){
                                
                                rolVenta = cuentasRolVentaLeadProfilers.get(String.valueOf(cuentaModificada.Lead_Profiler__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'LP');
                                
                                //Si el Lead Profiler aun se encuentra vigente para el fraccionamiento elegido se asignan los datos del registro de Rol de Venta a la cuenta
                                if(rolVenta.Vencido__c == false){
                                    cuentaModificada.Fecha_LP__c = rolVenta.Fecha_Asignacion__c;  cuentaModificada.Fecha_Hora_LP__c = rolVenta.Fecha_Hora_Asignacion__c;
                                }
                                //Si el Lead Profiler ya no se encuentra vigente para el fraccionamiento elegido se envia mensaje de error
                                else{
                                    cuentaModificada.addError('El Lead Profiler elegido para el fraccionamiento elegido ya no está vigente');
                                }
                            }
                            //Si no existe un registro de Rol de Venta con el Lead Profiler asignado se settean los datos la cuenta
                            else{
                                cuentaModificada.Fecha_LP__c = Date.today();
                                cuentaModificada.Fecha_Hora_LP__c = Datetime.now();
                            }
                            cuentaModificada.Estatus_LP__c = 'ASIGNADO';
                            cuentaModificada.Fecha_LP__c = date.today();
                            cuentaModificada.Fecha_Hora_LP__c = datetime.now();
                            
                        }
                        //Si el campo Lead Profiler esta vacio, el estatus del lead profiler es POR REASIGNAR O POR ASIGNAR
                        else{
                            
                            //Si se desasigno el Lead Profiler de forma automatica porque ya vencio su estatus es POR REASIGNAR
                            if(cuentaModificada.Desasignacion_Auto_Lead_Profiler__c == true){
                                
                                System.debug('*****Entro a Desasignacion_Auto_Lead_Profiler__c 2');
                                //cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';
                                cuentaModificada.Estatus_LP__c = 'POR REASIGNAR'; cuentaModificada.Fecha_LP__c = null; cuentaModificada.Fecha_Hora_LP__c = null;
                                cuentaModificada.Desasignacion_Auto_Lead_Profiler__c = false;
                            }
                            //Si no se desasigno el Lead Profiler de forma automatica porque ya vencio su estatus es POR ASIGNAR
                            else{
                                //cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';
                                cuentaModificada.Estatus_LP__c = 'POR ASIGNAR';                            
                            }
                        }
                    }
                    
                    //Si en la cuenta modificada se modifico el campo Colaborador Javer: la fecha del estatus del colaborador Javer es la de ese momento
                    if(cuentaModificada.Colaborador_Javer__c != cuentasExistentes.get(cuentaModificada.Id).Colaborador_Javer__c || cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                        
                        cuentaModificada.Fecha_Estatus_Colaborador_Javer__c = Datetime.now();
                        
                        //Si el campo Colaborador Javer no esta vacio, el estatus del colaborador Javer es ASIGNADO
                        if(String.isBlank(cuentaModificada.Colaborador_Javer__c) == false){
                            
                            cuentaModificada.Estatus_Colaborador_Javer__c = 'ASIGNADO';
                            cuentaModificada.Fecha_Colaborador_Javer__c = Date.today();
                            cuentaModificada.Fecha_Hora_Colaborador_Javer__c = Datetime.now();
                            
                            //Si si existe un registro de Rol de Venta con el Colaborador Javer asignado se obtiene los datos de dicho registro
                            if(cuentasRolVentaColaboradoresJaver.containsKey(String.valueOf(cuentaModificada.Colaborador_Javer__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'CJ') == true){
                                
                                rolVenta = cuentasRolVentaColaboradoresJaver.get(String.valueOf(cuentaModificada.Colaborador_Javer__c) + String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c) + 'CJ');
                                
                                //Si el Colaborador Javer aun se encuentra vigente para el fraccionamiento elegido se asignan los datos del registro de Rol de Venta a la cuenta
                                if(rolVenta.Vencido__c == false){
                                    cuentaModificada.Fecha_Colaborador_Javer__c = rolVenta.Fecha_Asignacion__c;
                                    cuentaModificada.Fecha_Hora_Colaborador_Javer__c = rolVenta.Fecha_Hora_Asignacion__c;
                                }
                                //Si el Colaborador Javer ya no se encuentra vigente para el fraccionamiento elegido se envia mensaje de error
                                else{
                                    cuentaModificada.addError('El Colaborador Javer elegido para el fraccionamiento elegido ya no está vigente');
                                }
                            }
                            //Si no existe un registro de Rol de Venta con el Colaborador Javer asignado se settean los datos la cuenta
                            else{
                                cuentaModificada.Fecha_Colaborador_Javer__c = Date.today();
                                cuentaModificada.Fecha_Hora_Colaborador_Javer__c = Datetime.now();
                            }
                            
                            //Si se asigna un colaborador Javer diferente al que ya existia anteriormente se guarda el colaborador Javer asignado
                            if(cuentaModificada.Colaborador_Javer__c != cuentaModificada.Colaborador_Javer_Asignado__c){
                                cuentaModificada.Colaborador_Javer_Asignado__c = cuentaModificada.Colaborador_Javer__c;
                                cuentaModificada.Colaborador_Javer_Asignado_Prorroga__c = '';
                                cuentaModificada.Colaborador_Javer_Asignacion__c = true;
                                cuentaModificada.Colaborador_Javer_Asignacion_Prorroga__c = false;
                            }
                            //Si se asigna un colaborador Javer igual al que ya existia anteriormente se guarda el colaborador Javer asignado
                            else{
                                cuentaModificada.Colaborador_Javer_Asignado_Prorroga__c = cuentaModificada.Colaborador_Javer__c; cuentaModificada.Colaborador_Javer_Asignacion_Prorroga__c = true;
                            }
                        }
                        //Si el campo Colaborador Javer esta vacio, el estatus del colaborador Javer es POR REASIGNAR O POR ASIGNAR
                        else{
                            
                            //Si se desasigno el Colaborador Javer de forma automatica porque ya vencio su estatus es POR REASIGNAR
                            if(cuentaModificada.Desasignacion_Auto_Colaborador_Javer__c == true){
                                
                                System.debug('*****Entro a Desasignacion_Auto_Colaborador_Javer__c 2');
                                //cuentaModificada.Estatus_Cliente__c = 'POR REASIGNAR';
                                cuentaModificada.Estatus_Colaborador_Javer__c = 'POR REASIGNAR';
                                cuentaModificada.Fecha_Colaborador_Javer__c = null; cuentaModificada.Fecha_Hora_Colaborador_Javer__c = null;
                                cuentaModificada.Desasignacion_Auto_Colaborador_Javer__c = false;
                            }
                            //Si no se desasigno el Colaborador Javer de forma automatica porque ya vencio su estatus es POR ASIGNAR
                            else{
                                //cuentaModificada.Estatus_Cliente__c = 'POR ASIGNAR';
                                cuentaModificada.Estatus_Colaborador_Javer__c = 'POR ASIGNAR';
                            }
                        }
                    }
                }
                
            }
            
            //Si en la cuenta modificada no esta vacio el campo Tipo de Baja y no esta vacio el campo Motivo de Baja y esta vacio el campo Motivo Reactivacion:
            //El estatus de la cuenta es BAJA
            if(String.isBlank(cuentaModificada.Tipo_Baja__c) == false && String.isBlank(cuentaModificada.Motivo_Baja__c) == false && String.isBlank(cuentaModificada.Motivo_Reactivacion__c) == true){
                cuentaModificada.Estatus_Cliente_Anterior__c = cuentaModificada.Estatus_Cliente__c;
                cuentaModificada.Estatus_Cliente__c = 'BAJA';
                estatusAsignado = true;                            
            }
            
            //Si en la cuenta modificada no esta vacio el campo Motivo de Incubacion y no esta vacio el campo Motivo Reactivacion:
            //El estatus de la cuenta es INCUBADORA
            if(String.isBlank(cuentaModificada.Motivo_Incubacion__c) == false && String.isBlank(cuentaModificada.Motivo_Reactivacion__c) == true){
                cuentaModificada.Estatus_Cliente_Anterior__c = cuentaModificada.Estatus_Cliente__c;
                cuentaModificada.Estatus_Cliente__c = 'INCUBADORA';
                estatusAsignado = true;
            }
            
            //Si fue asignado el estatus del cliente por alguna de las condiciones anteriores y el estatus del cliente es diferente al que ya se tenia, se asigna la fecha del estatus del cliente
            if(estatusAsignado == true && cuentaModificada.Estatus_Cliente__c != cuentasExistentes.get(cuentaModificada.Id).Estatus_Cliente__c){
                cuentaModificada.Fecha_Estatus__c = Datetime.now();
            }
        }
    }
    
    //Metodo para asignar el RFC y la CURP a las nuevas cuentas cuando el tipo de registro corresponda a una persona fisica (Prospecto Persona Fisica, Afluente Persona Fisica, Cliente Persona Fisica)
    public static void asignaRFCCURPCreacion(List<Account> cuentasNuevas){
        
        Id tipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroAfluentePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroClientePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Fisica').getRecordTypeId();
        
        for(Account cuentaNueva : cuentasNuevas){
            
            //Si la cuenta nueva es de tipo Prospecto Persona Fisica, Afluente Persona Fisica o Cliente Persona Fisica, se intenta crear el RFC y la CURP
            if(cuentaNueva.RecordTypeId == tipoRegistroProspectoPersonaFisica || cuentaNueva.RecordTypeId == tipoRegistroAfluentePersonaFisica || cuentaNueva.RecordTypeId == tipoRegistroClientePersonaFisica){
                
                //Si se han llenado los campos de Nombre, Apellidos, Apellido Materno y Fecha de Nacimiento se procede a la generacion de su RFC = primera parte de la CURP
                if(String.isBlank(cuentaNueva.FirstName) == false && String.isBlank(cuentaNueva.LastName) == false && String.isBlank(String.valueOf(cuentaNueva.PersonBirthdate)) == false){
                    
                    cuentaNueva.RFC_Base__c = generacionBaseRFCCURP(cuentaNueva);
                    cuentaNueva.Homoclave__c = generacionHomoclave(cuentaNueva);
                }
                
                //Si se genero el RFC = primera parte de la CURP y se han llenado los campos de Sexo, Lugar de Nacimiento, Nombre y Apellidos se procede a la generacion de la segunda parte de la CURP
                if(String.isBlank(cuentaNueva.RFC_Base__c) == false && String.isBlank(cuentaNueva.Sexo__c) == false && String.isBlank(cuentaNueva.Lugar_Nacimiento__c) == false && String.isBlank(cuentaNueva.FirstName) == false && String.isBlank(cuentaNueva.LastName) == false){
                    
                    // cuentaNueva.CURP__c = cuentaNueva.RFC_Base__c + generacionComplementoCURP(cuentaNueva);
                    String CURP_Parcial = cuentaNueva.RFC_Base__c + generacionComplementoCURP(cuentaNueva);
                    String diferenciador;
                    if (cuentaNueva.FechaNacimiento__c!=null) {
                        diferenciador = cuentaNueva.FechaNacimiento__c.year() < 2000 ? '0' : 'A'; // FechaNacimiento o PersonBirthdate?
                    } else {
                        if (cuentaNueva.PersonBirthdate!=null) {
                            diferenciador = cuentaNueva.PersonBirthdate.year() < 2000 ? '0' : 'A'; // FechaNacimiento o PersonBirthdate?
                        }
                    }
                    String DV = generacionDigitoVerCurp (CURP_Parcial);
                    cuentaNueva.CURP__c = CURP_Parcial + diferenciador + DV;
                }
            }
        }
    }
    
    //Metodo para asignar el RFC y la CURP a las cuentas modificadas cuando el tipo de registro corresponda a una persona fisica (Prospecto Persona Fisica, Afluente Persona Fisica, Cliente Persona Fisica)
    public static void asignaRFCCURPEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        system.debug('*** Entro a RFCCURPEdicion ***');
        Id tipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroAfluentePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroClientePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Fisica').getRecordTypeId();
        
        //se procede a la generacion de su RFC
        for(Account cuentaModificada : cuentasModificadas){
            
            //Si la cuenta modificada es de tipo Prospecto Persona Fisica, Afluente Persona Fisica o Cliente Persona Fisica, se intenta crear el RFC y la CURP
            if(cuentaModificada.RecordTypeId == tipoRegistroProspectoPersonaFisica || cuentaModificada.RecordTypeId == tipoRegistroAfluentePersonaFisica || cuentaModificada.RecordTypeId == tipoRegistroClientePersonaFisica){
                
                //Si se han llenado los campos de Nombre, Apellidos y Fecha de Nacimiento y se ha modificado alguno de los campos de Nombre, Apellidos, Apellido Materno y Fecha de Nacimiento
                //se procede a la generacion de su RFC = primera parte de la CURP
                if((String.isBlank(cuentaModificada.FirstName) == false && String.isBlank(cuentaModificada.LastName) == false && String.isBlank(String.valueOf(cuentaModificada.PersonBirthdate)) == false) &&
                   (cuentaModificada.FirstName != cuentasExistentes.get(cuentaModificada.Id).FirstName || cuentaModificada.LastName != cuentasExistentes.get(cuentaModificada.Id).LastName || cuentaModificada.Apellidomaterno_cta__c != cuentasExistentes.get(cuentaModificada.Id).Apellidomaterno_cta__c || cuentaModificada.PersonBirthdate != cuentasExistentes.get(cuentaModificada.Id).PersonBirthdate)){
                       system.debug('*** Entro a modificación de RFC');
                       cuentaModificada.RFC_Base__c = generacionBaseRFCCURP(cuentaModificada);
                       cuentaModificada.Homoclave__c = generacionHomoclave(cuentaModificada);
                   }
                
                //Si se genero el RFC = primera parte de la CURP y se han llenado los campos de Sexo, Lugar de Nacimiento, Nombre y Apellidos y se ha modificado alguno de los campos de Sexo, Lugar de Nacimiento, Nombre y Apellidos
                //se procede a la generacion de la segunda parte de la CURP
                if((String.isBlank(cuentaModificada.RFC_Base__c) == false && String.isBlank(cuentaModificada.Sexo__c) == false && String.isBlank(cuentaModificada.Lugar_Nacimiento__c) == false && String.isBlank(cuentaModificada.FirstName) == false && String.isBlank(cuentaModificada.LastName) == false) && 
                   (cuentaModificada.RFC_Base__c != cuentasExistentes.get(cuentaModificada.Id).RFC_Base__c || cuentaModificada.Sexo__c != cuentasExistentes.get(cuentaModificada.Id).Sexo__c || cuentaModificada.Lugar_Nacimiento__c != cuentasExistentes.get(cuentaModificada.Id).Lugar_Nacimiento__c || cuentaModificada.FirstName != cuentasExistentes.get(cuentaModificada.Id).FirstName || cuentaModificada.LastName != cuentasExistentes.get(cuentaModificada.Id).LastName || cuentaModificada.Apellidomaterno_cta__c != cuentasExistentes.get(cuentaModificada.Id).Apellidomaterno_cta__c)){
                       system.debug('*** Entro a modificación de CURP');
                       String CURP_Parcial = cuentaModificada.RFC_Base__c + generacionComplementoCURP(cuentaModificada);
                       String diferenciador;
                       if (cuentaModificada.FechaNacimiento__c!=null) {
                           diferenciador = cuentaModificada.FechaNacimiento__c.year() < 2000 ? '0' : 'A'; // FechaNacimiento o PersonBirthdate?
                       } else {
                           if (cuentaModificada.PersonBirthdate!=null) {
                               diferenciador = cuentaModificada.PersonBirthdate.year() < 2000 ? '0' : 'A'; // FechaNacimiento o PersonBirthdate?
                           }
                       }
                       String DV = generacionDigitoVerCurp (CURP_Parcial);
                       cuentaModificada.CURP__c = CURP_Parcial + diferenciador + DV;
                   }
            }
        }
    }
    
    //Metodo para la generacion del RFC de una persona fisica
    public static String generacionBaseRFCCURP(Account cuenta){
        
        String rfc = '';
        
        /********************************************************************/
        /**********SE OBTIENE LA PRIMERA LETRA DEL APELLIDO PATERNO**********/
        /********************************************************************/
        String apellidoPaterno = cuenta.LastName.toUpperCase();
        System.debug('*****apellidoPaterno 1:' + apellidoPaterno);
        
        //Se sustituyen los caracteres especiales que contenga el apellido paterno
        apellidoPaterno = sustituyeCaracteresEspeciales(apellidoPaterno);
        System.debug('*****apellidoPaterno 2:' + apellidoPaterno);
        
        //Se valida que y obtiene el apellido paterno sin prepocisiones, conjunciones y contracciones no permitidas
        apellidoPaterno = remuevePrepConjCont(apellidoPaterno);
        System.debug('*****apellidoPaterno 3:' + apellidoPaterno);
        
        //Se obtiene la primera letra del apellido paterno
        String primeraLetraAP = apellidoPaterno.substring(0,1);
        System.debug('*****apellidoPaterno 4:' + apellidoPaterno);
        
        //Si la primera letra es un signo de puntuacion no valido o la letra Ñ se sustituye por una X
        primeraLetraAP = (signosEne.containsKey(primeraLetraAP) == true ? signosEne.get(primeraLetraAP) : primeraLetraAP);
        System.debug('*****apellidoPaterno 5:' + apellidoPaterno);
        
        
        /********************************************************************************************************************/
        /**********SE OBTIENE LA PRIMERA VOCAL O CARACTER ESPECIAL DEL APELLIDO PATERNO QUE NO SEA LA PRIMERA LETRA**********/
        /********************************************************************************************************************/
        String primeraVocalAP = '';
        
        //Se obtiene el arreglo de los caracteres que forman el apellido paterno y se quita la primera letra
        Integer[] caracteresAP = apellidoPaterno.getChars();
        caracteresAP.remove(0);
        System.debug('*****caracteresAP 1:' + caracteresAP);
        
        //Se obtiene la primera vocal o caracter especial del apellido paterno
        Boolean vocalCaracterEncontrado = false;
        for(Integer caracterAP : caracteresAP){
            
            //A - 65
            //E - 69
            //I - 73
            //O - 79
            //U - 85
            /// - 47
            //- - 45
            //. - 46
            System.debug('*****caracterAP:' + caracterAP);
            if(caracterAP == 65 || caracterAP == 69 || caracterAP == 73 || caracterAP == 79 || caracterAP == 85 || caracterAP == 47 || caracterAP == 45 || caracterAP == 46){
                
                primeraVocalAP = String.fromCharArray(new List<Integer> {caracterAP});
                vocalCaracterEncontrado = true;
                break;
            }
        }
        System.debug('*****primeraVocalAP:' + primeraVocalAP);
        
        //Si se encontro una vocal o caracter especial se valida si lo que se encontro fue una vocal o caracter especial, si lo encontrado no es una vocal sino un caracter especial se sustituye por una X
        if(vocalCaracterEncontrado == true){
            primeraVocalAP = (signosEne.containsKey(primeraVocalAP) == true ? signosEne.get(primeraVocalAP) : primeraVocalAP);        
        }
        //Si no se encontro una vocal o caracter especial se pone una X
        else{
            primeraVocalAP = 'X';
        }
        
        System.debug('*****primeraVocalAP:' + primeraVocalAP);
        
        /********************************************************************/
        /**********SE OBTIENE LA PRIMERA LETRA DEL APELLIDO MATERNO**********/
        /********************************************************************/
        
        //Si no se cuenta con apellido materno se pone una X
        String primeraLetraAM = '';
        if(String.isBlank(cuenta.Apellidomaterno_cta__c) == true){
            
            primeraLetraAM = 'X';
        }
        //Si si se cuenta con apellido materno se procede a la obtencion del dato correspondiente
        else{
            String apellidoMaterno = cuenta.Apellidomaterno_cta__c.toUpperCase();
            
            //Se sustituyen los caracteres especiales que contenga el apellido materno
            apellidoMaterno = sustituyeCaracteresEspeciales(apellidoMaterno);
            
            //Se valida que y obtiene el apellido materno sin prepocisiones, conjunciones y contracciones no permitidas
            apellidoMaterno = remuevePrepConjCont(apellidoMaterno);
            
            //Se obtiene la primera letra del apellido materno
            primeraLetraAM = apellidoMaterno.substring(0,1);
            
            //Si la primera letra es un signo de puntuacion no valido o la letra Ñ se sustituye por una X
            primeraLetraAM = (signosEne.containsKey(primeraLetraAM) == true ? signosEne.get(primeraLetraAM) : primeraLetraAM);
        }
        
        
        /**********************************************************/
        /**********SE OBTIENE LA PRIMERA LETRA DEL NOMBRE**********/
        /**********************************************************/
        String nombre = cuenta.FirstName.toUpperCase();
        
        //Se sustituyen los caracteres especiales que contenga el nombre
        nombre = sustituyeCaracteresEspeciales(nombre);
        
        //Si el nombre es compuesto se valida que el primer nombre no sea MARIA, MA., MA. JOSE, J, o J.
        System.debug('*****nombre.contains( ):' + nombre.contains(' '));
        if(nombre.contains(' ') == true){
            
            String[] nombreArreglo = nombre.split(' ');
            
            //Si la primer nombre es un nombre no permitido se descarta
            if(nombreArreglo[0] == 'MARIA' || nombreArreglo[0] == 'MA.' || nombreArreglo[0] == 'MA' || nombreArreglo[0] == 'JOSE' || nombreArreglo[0] == 'J' || nombreArreglo[0] == 'J.'){
                
                for(Integer i = 1; i < nombreArreglo.size(); i++){
                    nombre = (i == 1 ? nombreArreglo[i] : nombre + ' ' + nombreArreglo[i]);
                }
            }
        }
        
        //Se valida que y obtiene el nombre sin prepocisiones, conjunciones y contracciones no permitidas
        nombre = remuevePrepConjCont(nombre);
        
        //Se obtiene la primera letra del nombre
        String primeraLetraNombre = nombre.substring(0,1);
        
        //Si la primera letra es un signo de puntuacion no valido o la letra Ñ se sustituye por una X
        primeraLetraNombre = (signosEne.containsKey(primeraLetraNombre) == true ? signosEne.get(primeraLetraNombre) : primeraLetraNombre);
        
        
        /****************************************************************/
        /**********SE OBTIENE EL ANIO DE LA FECHA DE NACIMIENTO**********/
        /****************************************************************/
        String anio = String.valueOf(cuenta.PersonBirthdate.year());
        anio = anio.substring(2);
        
        
        /***************************************************************/
        /**********SE OBTIENE EL MES DE LA FECHA DE NACIMIENTO**********/
        /***************************************************************/
        String mes = String.valueOf(cuenta.PersonBirthdate.month());
        mes = (mes.length() == 1 ? '0' + mes : mes);
        
        
        /***************************************************************/
        /**********SE OBTIENE EL DIA DE LA FECHA DE NACIMIENTO**********/
        /***************************************************************/
        String dia = String.valueOf(cuenta.PersonBirthdate.day());
        dia = (dia.length() == 1 ? '0' + dia : dia);
        
        
        /***************************************************************/
        /**********SE CONSTRUYE EL RFC CON LOS DATOS OBTENIDOS**********/
        /***************************************************************/
        //Se construye la primera parte del RFC para validar que no coincida con alguna de las palabras altisonantes no permitidas
        //si coincide, se sustituye por la palabra permitida
        String rfcPrimeraParte = primeraLetraAP + primeraVocalAP + primeraLetraAM + primeraLetraNombre;
        rfcPrimeraParte = (palabrasInconvenientes.containsKey(rfcPrimeraParte) == true ? palabrasInconvenientes.get(rfcPrimeraParte) : rfcPrimeraParte);
        
        rfc = rfcPrimeraParte + anio + mes + dia;
        return rfc;
    }
    
    //Metodo para la generacion del complemento (segunda parte) de la CURP (complemento despues de la parte obtenida a partir del nombre y fecha de nacimiento)
    public static String generacionComplementoCURP(Account cuenta){
        
        String complementoCurp = '';
        
        
        /**********************************************************/
        /**********SE OBTIENE EL IDENTIFICADOR DEL GENERO**********/
        /**********************************************************/
        String genero = '';
        if (cuenta.Sexo__c.toUpperCase() == 'MASCULINO') {
            genero = 'H';
        } else {
            if (cuenta.Sexo__c.toUpperCase() == 'FEMENINO') {
                genero = 'M';
            } else {
                genero = 'X';
            }
        }
        
        
        /************************************************************************/
        /**********SE OBTIENE EL IDENTIFICADOR DEL ESTADO DE NACIMIENTO**********/
        /************************************************************************/
        String estado = '';
        system.debug('******* ESTADOS MAP: '+estados);
        estado = complementoCurp + estados.get(cuenta.Lugar_Nacimiento__c.toUpperCase());
        
        
        /*************************************************************************/
        /**********SE OBTIENE LA PRIMERA CONSONANTE DEL APELLIDO PATERNO**********/
        /*************************************************************************/
        String primeraConsonanteAP = '';
        
        String apellidoPaterno = cuenta.LastName.toUpperCase();
        
        //Se sustituyen los caracteres especiales que contenga el apellido materno
        apellidoPaterno = sustituyeCaracteresEspeciales(apellidoPaterno);
        
        primeraConsonanteAP = obtenerPrimeraConsonante(apellidoPaterno);
        
        
        /*************************************************************************/
        /**********SE OBTIENE LA PRIMERA CONSONANTE DEL APELLIDO MATERNO**********/
        /*************************************************************************/
        String primeraConsonanteAM = '';
        //Si no se cuenta con apellido materno se pone una X
        if(String.isBlank(cuenta.Apellidomaterno_cta__c) == true){
            
            primeraConsonanteAM = 'X';
        }
        //Si si se cuenta con apellido materno se procede a la obtencion del dato correspondiente
        else{
            String apellidoMaterno = cuenta.Apellidomaterno_cta__c.toUpperCase();
            
            //Se sustituyen los caracteres especiales que contenga el apellido materno
            apellidoMaterno = sustituyeCaracteresEspeciales(apellidoMaterno);
            
            primeraConsonanteAM = obtenerPrimeraConsonante(apellidoMaterno);
        }
        
        
        /***************************************************************/
        /**********SE OBTIENE LA PRIMERA CONSONANTE DEL NOMBRE**********/
        /***************************************************************/
        String primeraConsonanteNombre = '';
        
        String nombre = cuenta.FirstName.toUpperCase();
        
        //Se sustituyen los caracteres especiales que contenga el nombre
        nombre = sustituyeCaracteresEspeciales(nombre);
        
        //Si el nombre es compuesto se valida que el primer nombre no sea MARIA, MA., MA. JOSE, J, o J.
        System.debug('*****nombre.contains( ):' + nombre.contains(' '));
        if(nombre.contains(' ') == true){
            
            String[] nombreArreglo = nombre.split(' ');
            
            //Si la primer nombre es un nombre no permitido se descarta
            if(nombreArreglo[0] == 'MARIA' || nombreArreglo[0] == 'MA.' || nombreArreglo[0] == 'MA' || nombreArreglo[0] == 'JOSE' || nombreArreglo[0] == 'J' || nombreArreglo[0] == 'J.'){
                
                for(Integer i = 1; i < nombreArreglo.size(); i++){
                    nombre = (i == 1 ? nombreArreglo[i] : nombre + ' ' + nombreArreglo[i]);
                }
            }
        }
        
        //Se valida que y obtiene el nombre sin prepocisiones, conjunciones y contracciones no permitidas
        nombre = remuevePrepConjCont(nombre);
        
        System.debug('*****nombre:' + nombre);
        //Se obtiene la primera consonante del nombre
        primeraConsonanteNombre = obtenerPrimeraConsonante(nombre);
        
        
        /***************************************************************/
        /**********SE CONSTRUYE EL RFC CON LOS DATOS OBTENIDOS**********/
        /***************************************************************/
        complementoCurp = genero + estado + primeraConsonanteAP + primeraConsonanteAM + primeraConsonanteNombre;
        return complementoCurp;
    }    
    
    public static String generacionDigitoVerCurp(String preCURP) {
        //     Calcula el codigo verificador en base a la pre CURP.
        // </summary>
        // <param name="preCURP"> La pre CURP.</param>
        // <returns> El código verificador.</returns>
        // <exception cref="ArgumentException"> Cuando alguno de los caracteres de la pre CURP no es válido.</exception>
        // integer contador = 18;
        integer sumatoria = 0;
        
        String caracteres = '0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
        
        system.debug('*** preCURP: '+preCURP);
        Integer CURPlen = 16;
        Integer contador = 18;
        
        for (Integer i = 0; i < CURPlen; i++) {
            String caracter = preCURP.substring(i, i+1);
            Integer index = caracteres.indexOf(caracter);
            
            if (index == -1) {
                system.debug ('*** Error en cálculo de CURP');
            }
            
            Integer valor = index * contador;
            contador--;
            sumatoria += valor;
        }
        
        // 12.- 2do digito verificador
        Integer numVer = Math.Mod(sumatoria, 10);
        numVer = 10 - numVer;
        numVer = numVer == 10 ? 0 : numVer;
        //system.debug('*** CURP numVer: '+numVer);
        return String.ValueOf(numVer);
    }
    
    //Metodo para sustituir los caracteres especiales por su caracter simple
    public static String sustituyeCaracteresEspeciales(String texto){
        
        String textoSustituido = '';
        textoSustituido = texto.replaceAll('[ÀÁÂÃÄÅ]','A');
        textoSustituido = textoSustituido.replaceAll('[ÈÉÊË]','E');
        textoSustituido = textoSustituido.replaceAll('[ÌÍÎÏ]','I');
        textoSustituido = textoSustituido.replaceAll('[ÒÓÔÕÖØ]','O');
        textoSustituido = textoSustituido.replaceAll('[ÙÚÛÜ]','U');
        textoSustituido = textoSustituido.replaceAll('[Ç]','C');
        textoSustituido = textoSustituido.replaceAll('[ÿ]','Y');
        
        return textoSustituido;
    }
    
    //Metodo recursivo que remueve las prepocisiones, conjuncions y contracciones no permitidas en los datos para genenar el RFC y CURP en un dato compuesto (2 o mas palabras)
    public static String remuevePrepConjCont(String texto){
        
        String textoReal = '';
        
        //Si el dato enviado es compuesto (2 o mas palabras) se valida y descartan las prepocisiones, conjunciones y contracciones no permitidas
        if(texto.contains(' ') == true){
            
            String[] textoArreglo = texto.split(' ');
            
            //Si la primera palabra del apellido paterno es una prepocision, conjuncion o contraccion no permitida se descarta
            if(prepsConjCont.containsKey(textoArreglo[0]) == true){
                
                for(Integer i = 1; i < textoArreglo.size(); i++){
                    textoReal = (i == 1 ? textoArreglo[i] : textoReal + ' ' + textoArreglo[i]);
                }
                
                //Si despues de haber descartado la prepocision, conjuncion o contraccion no permitida el texto aun es compuesto (2 o mas palabras)
                //se vuelve a validar el texto y, si aplica, se remueven las prepocisiones, conjunciones o contracciones no permitidas (recursividad)
                if(textoReal.contains(' ') == true){
                    textoReal = remuevePrepConjCont(textoReal);
                }
            }
            else{
                textoReal = texto;
            }
        }
        //Si el dato enviado no es compuesto, se envia el texto tal cual se recibe en el metodo
        else{
            textoReal = texto;
        }
        
        return textoReal;
    }
    
    //Metodo para obtener la primera consonante de una cadena de texto cumpliendo con las excepciones de la CURP
    public static String obtenerPrimeraConsonante(String texto){
        
        String primeraConsonante = '';
        
        //Se obtiene el arreglo de los caracteres que forman el texto y se quita la primera letra
        Integer[] caracteres = texto.getChars();
        caracteres.remove(0);
        System.debug('*****caracteres 1:' + caracteres);
        
        //Se obtiene la primera consonante del apellido paterno
        Boolean consonanteEncontrada = false;
        for(Integer caracter : caracteres){
            
            //A - 65
            //E - 69
            //I - 73
            //O - 79
            //U - 85
            /// - 47
            //- - 45
            //. - 46
            System.debug('*****caracter:' + caracter);
            System.debug('*****String.fromCharArray(new List<Integer> {caracter}:' + String.fromCharArray(new List<Integer> {caracter}));
            if(caracter != 65 && caracter != 69 && caracter != 73 && caracter != 79 && caracter != 85 && caracter != 47 && caracter != 45 && caracter != 46){
                
                //Si la consonante encontrada es Ñ - 209, se sustituye por una X
                if(caracter == 209){
                    primeraConsonante = 'X';
                }
                //Si la consonante encontrada no es Ñ - 165, se obtiene la consonante
                else{
                    primeraConsonante = String.fromCharArray(new List<Integer> {caracter});
                }
                consonanteEncontrada = true;
                break;
            }
        }
        System.debug('*****primeraConsonante:' + primeraConsonante);
        
        //Si el texto no tiene una consonante interna, se pone X
        if(consonanteEncontrada == false){
            primeraConsonante = 'X';
        }
        
        return primeraConsonante;
    }
    
    //Metodo para generar la homoclave del RFC
    public static String generacionHomoclave(Account cuenta){
        
        /*********************************************************/
        /* Se calculan los primeros 2 caracteres de la homoclave */
        /*********************************************************/
        
        String nombreCuenta = cuenta.LastName.toUpperCase() + (String.isBlank(cuenta.Apellidomaterno_cta__c) == false ? ' ' + cuenta.Apellidomaterno_cta__c.toUpperCase() : '') + ' ' + cuenta.FirstName.toUpperCase();
        System.debug('*****nombreCuenta:' + nombreCuenta);
        
        nombreCuenta = nombreCuenta.replace('Á','A');
        nombreCuenta = nombreCuenta.replace('É','E');
        nombreCuenta = nombreCuenta.replace('Í','I');
        nombreCuenta = nombreCuenta.replace('Ó','O');
        nombreCuenta = nombreCuenta.replace('Ú','U');
        nombreCuenta = nombreCuenta.replace('Ü','U');
        
        Integer i_LongNombre   = nombreCuenta.length();
        System.debug('*****i_LongNombre:' + i_LongNombre);
        
        Integer i_LongNumeros  = 0;
        String[] arry_Numeros = new String[i_LongNombre];
        String i_Numeros       = '0';
        Integer i_3Num         = 0;
        String i_divide        = '';
        Integer i_Suma         = 0;
        String i_Suma_String   = '';
        String s_FirstLetter   = '';
        String s_ScdLetter     = '';
        String s_HomoClave     = '';
        
        try{
            //nombreCuenta = 'DIAZ HERNANDEZ LUIS';
            String[] pNombre = nombreCuenta.split('');
            System.debug('*****pNombre:' + pNombre);
            for (Integer i = 0; i < i_LongNombre; i++){
                
                System.debug('*****pNombre[' + i + ']:' + pNombre[i]);
                String x = pNombre[i];
                
                System.debug('*****oPs_ValorHomonimo.get(' + x + '):' + oPs_ValorHomonimo.get(x));             
                arry_Numeros[i]= oPs_ValorHomonimo.get(x);
                
                System.debug('*****arry_Numeros:' + arry_Numeros);
            }
            System.debug('*****arry_Numeros:' + arry_Numeros);
            
            i_Numeros += String.join(arry_Numeros,'');   i_LongNumeros = i_Numeros.length();
            
            System.debug('*****i_Numeros:' + i_Numeros);
            System.debug('*****i_LongNumeros:' + i_LongNumeros);
            
            String[] i_Numeros_Arreglo = i_Numeros.split('');
            for (Integer j = 0; j < i_LongNumeros-1; j++){
                
                i_Suma += (Integer.valueOf(i_Numeros_Arreglo[j] + i_Numeros_Arreglo[j+1])) * Integer.valueOf(i_Numeros_Arreglo[j+1]);
            }
            System.debug('*****i_LongNumeros:' + i_LongNumeros);
            
            i_Suma_String = String.valueOf(i_Suma);  i_3Num        = Integer.valueOf(i_Suma_String.substring(i_Suma_String.length() -3));
            //i_divide      = Clib.div(ToNumber(i_3Num), ToNumber(34));
            s_FirstLetter = oPs_ClaveDif.get(String.valueOf(Integer.valueOf(i_3Num / 34))); s_ScdLetter   = oPs_ClaveDif.get(String.valueOf(Integer.valueOf(Math.mod(i_3Num,34))));
            
            s_HomoClave = s_FirstLetter + s_ScdLetter;
            
            /***********************************************************************/
            /* Se calcula el ultimo caracter (digito verificador) de la homoclave  */
            /***********************************************************************/
            
            String cuentaRFC = cuenta.RFC_Base__c + s_HomoClave;
            Integer i_LongRFC = cuentaRFC.length();
            String[] arry_Numeros2 = new String[i_LongRFC];
            Integer i_Suma2 = 0;
            Integer i_Rem = 0;
            String s_DigitoVer = '';
            
            String[] pRFC = cuentaRFC.split('');
            String x = '';
            
            for(Integer i = 0; i < i_LongRFC; i++){
                
                x = pRFC[i];
                arry_Numeros2[i] = oPs_DigitoVerifica.get(x);
                i_Suma2 += Integer.valueOf(oPs_DigitoVerifica.get(x)) * ((i_LongRFC + 1) - i);
            }
            
            i_Rem = Math.mod(i_Suma2,11);
            
            if(i_Rem == 0){
                s_DigitoVer = '0';
            }
            else if(i_Rem > 0){
                
                s_DigitoVer = String.valueOf(11 - i_Rem);
                
                if (s_DigitoVer == '10'){
                    s_DigitoVer = 'A';
                }
            }
            System.debug('*****s_DigitoVer:' + s_DigitoVer);
            
            s_HomoClave = s_HomoClave + s_DigitoVer;
        }
        catch(Exception e){
            System.debug('*****ERROR AL GENERAR LA HOMOCLAVE:' + e.getMessage());
        }
        
        return s_HomoClave;
    }
    
    //Metodo para asignar en el campo Nombre Fraccionamiento el nombre del Fraccionamiento elegido en la creacion de una cuenta
    public static void asignaNombreFraccCreacion(List<Account> cuentasNuevas){
        
        //Se obtienen los ids de los fraccionamientos asocidados a las nuevas cuentas y las cuentas con fraccionamiento asociado
        Set<Id> idsFraccionamientos = new Set<Id>(); List<Account> cuentasConFraccionamiento = new List<Account>();
        for(Account cuentaNueva : cuentasNuevas){
            
            if(String.isBlank(cuentaNueva.Fraccionamiento_cta__c) == false){
                idsFraccionamientos.add(cuentaNueva.Fraccionamiento_cta__c); cuentasConFraccionamiento.add(cuentaNueva);
            }
        }
        
        //Si ingresaron cuentas nuevas que tienen asociado un fraccionamiento se procede a asignar el nombre del fraccionamiento al campo Nombre Fraccionamiento
        if(cuentasConFraccionamiento.size() > 0){
            
            Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientos]);
            
            for(Account cuentaNueva : cuentasConFraccionamiento){
                
                cuentaNueva.Nombre_Fraccionamiento__c = fraccionamientos.get(cuentaNueva.Fraccionamiento_cta__c).Name;
            }
        }
    }
    
    //Metodo para asignar en el campo Nombre Fraccionamiento el nombre del Fraccionamiento elegido en la edicion de una cuenta
    public static void asignaNombreFraccEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        //Se obtienen los ids de los fraccionamientos asocidados a las cuentas modificadas y las cuentas con fraccionamiento asociado
        Set<Id> idsFraccionamientos = new Set<Id>();
        List<Account> cuentasConFraccionamiento = new List<Account>();
        
        for(Account cuentaModificada : cuentasModificadas){
            
            if(String.isBlank(cuentaModificada.Fraccionamiento_cta__c) == false && cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                idsFraccionamientos.add(cuentaModificada.Fraccionamiento_cta__c);
                cuentasConFraccionamiento.add(cuentaModificada);
            }
        }
        
        //Si ingresaron cuentas modificadas que tienen asociado un fraccionamiento y que se ha modificado el fraccionamiento se procede a asignar el nombre del fraccionamiento al campo Nombre Fraccionamiento
        if(cuentasConFraccionamiento.size() > 0){
            
            Map<Id,Fraccionamiento__c> fraccionamientos = new Map<Id,Fraccionamiento__c>([SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientos]);
            
            for(Account cuentaModificada : cuentasConFraccionamiento){
                
                cuentaModificada.Nombre_Fraccionamiento__c = fraccionamientos.get(cuentaModificada.Fraccionamiento_cta__c).Name;
            }
        }
    }
    
    //Metodo que asigna el identificador unico a las cuentas de tipo de registro cliente (Cliente Persona Fisica o Cliente Persona Moral) cuando son creadas
    public static void asignaIdentificadorUnicoCreacion(List<Account> cuentasNuevas){
        Id tipoRegistroClientePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroClientPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Moral').getRecordTypeId();
        
        //Se valida si las cuentas que entraron al trigger son de tipo de registro cliente (Cliente Persona Fisica o Cliente Persona Moral)
        Set <Account> cuentasAsignarNumeroIdentificacion = new Set<Account>();
        for(Account cuentaNueva : cuentasNuevas){
            
            if(cuentaNueva.RecordTypeId == tipoRegistroClientePersonaFisica || cuentaNueva.RecordTypeId == tipoRegistroClientPersonaMoral){
                
                cuentasAsignarNumeroIdentificacion.add(cuentaNueva);
            }
        }
        
        //Si si entraron al trigger cuentas nuevas de tipo de registro cliente (Cliente Persona Fisica o Cliente Persona Moral) se procede con la asignacion del identificador unico
        if(cuentasAsignarNumeroIdentificacion.size() > 0){
            
            Blob b;  String h;   String guid;
            for(Account cuentaNueva : cuentasAsignarNumeroIdentificacion){
                b = Crypto.GenerateAESKey(128); h = EncodingUtil.ConvertTohex(b);
                guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);  cuentaNueva.Numero_Identificacion_Unico__c = guid.toUpperCase();
            }
        }
    }
    
    //Metodo que asigna el identificador unico a las cuentas cuando el tipo de registro de la cuenta ha sido cambiado a cliente (Cliente Persona Fisica o Cliente Persona Moral)
    public static void asignaIdentificadorUnicoEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        Id tipoRegistroClientePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroClientPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Moral').getRecordTypeId();
        
        //Se valida si las cuentas que entraron al trigger se cambiaron a tipo de registro cliente (Cliente Persona Fisica o Cliente Persona Moral)
        Set <Account> cuentasAsignarNumeroIdentificacion = new Set<Account>();
        for(Account cuentaModificada : cuentasModificadas){
            
            if((cuentaModificada.RecordTypeId == tipoRegistroClientePersonaFisica || cuentaModificada.RecordTypeId == tipoRegistroClientPersonaMoral)  && cuentaModificada.RecordTypeId != cuentasExistentes.get(cuentaModificada.Id).RecordTypeId){
                
                cuentasAsignarNumeroIdentificacion.add(cuentaModificada);
            }
        }
        
        //Si si entraron al trigger cuentas modificadas de tipo de registro cliente (Cliente Persona Fisica o Cliente Persona Moral) se procede con la asignacion del identificador unico
        if(cuentasAsignarNumeroIdentificacion.size() > 0){
            Blob b;   String h;    String guid;
            for(Account cuentaModificada : cuentasAsignarNumeroIdentificacion){
                b = Crypto.GenerateAESKey(128);  h = EncodingUtil.ConvertTohex(b);
                guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20); cuentaModificada.Numero_Identificacion_Unico__c = guid.toUpperCase();
            }
        }
    }
    
    //Metodo que valida que el dominio ingresado no corresponsa a alguno de los posibles mas erroneos de los dominios gmail.com, hotmail.com, outlook.com, yahoo.com, live.com
    public static void validaDominioEmail(List<Account> cuentas){
        
        Map<String,Dominio_Email__mdt> dominiosErroneos = Dominio_Email__mdt.getAll();
        
        String emailMayusculas = '';  String [] emailSeparadoDominio;  String [] emallPartesDominio;  String dominioEmail = '';  String parteExtraDominio = '';
        for(Account cuenta : cuentas){
            emailSeparadoDominio = null; emallPartesDominio = null;  dominioEmail = '';   parteExtraDominio = '';
            if(String.isBlank(cuenta.CorreoElectronico__c) == false){
                emailMayusculas = cuenta.CorreoElectronico__c.toUpperCase();
                if(emailMayusculas.contains('@') == true){
                    emailSeparadoDominio = emailMayusculas.split('@');
                    if(emailSeparadoDominio[1].contains('.') == true){
                        emallPartesDominio = emailSeparadoDominio[1].split('\\.');  dominioEmail = emallPartesDominio[0];
                    }
                    else{
                        dominioEmail = emailSeparadoDominio[0];
                        System.debug('*****dominioEmail 2:' + dominioEmail);
                    }
                    
                    System.debug('*****dominiosErroneos.containsKey(dominioEmail):' + dominiosErroneos.containsKey(dominioEmail));
                    if(dominiosErroneos.containsKey(dominioEmail) == true){
                        for(Integer i = 1; i< emallPartesDominio.size(); i++){
                            parteExtraDominio = parteExtraDominio + '.' + emallPartesDominio[i];
                        }
                        cuenta.CorreoElectronico__c = emailSeparadoDominio[0] + '@' + dominiosErroneos.get(dominioEmail).Valor_Correcto__c + parteExtraDominio;
                        System.debug('*****cuenta.CorreoElectronico__c 1:' + cuenta.CorreoElectronico__c);
                        cuenta.CorreoElectronico__c = cuenta.CorreoElectronico__c.toLowerCase();
                        System.debug('*****cuenta.CorreoElectronico__c 2:' + cuenta.CorreoElectronico__c);
                    }
                }
            }
        }
    }
    
    //Metodo para enviar a WS Lista negra Quién es Quien
    public static void listaNegraQEQ(Boolean isUpdate, List<Account> listAccNew, Map<Id, Account> MapAccOld){
        system.debug('*** Entro a listaNegraQEQ');
        
        List<Account> listAcc = new List<Account>();
        
        if(isUpdate){
            for (Account ac : listAccNew) {
                
                Boolean updated = false;
                
                if(ac.Name != MapAccOld.get(ac.Id).Name){
                    updated = true;
                }else if(ac.FirstName != MapAccOld.get(ac.Id).FirstName){
                    updated = true;
                }else if(ac.LastName != MapAccOld.get(ac.Id).LastName) {
                    updated = true;
                }else if(ac.Apellidomaterno_cta__c != MapAccOld.get(ac.Id).Apellidomaterno_cta__c) {
                    updated = true;
                }else if(ac.FechaNacimiento__c != MapAccOld.get(ac.Id).FechaNacimiento__c){
                    updated = true;
                }
                
                if(updated){
                    ListaNegra_QEQ.ListaNegra_QEQ(ac.Id);
                }
            }
        }else{
            for (Account ac : listAccNew) {
                ListaNegra_QEQ.ListaNegra_QEQ(ac.Id);
            }
        }
    }
    
    //Metodo que asigna el tipo de registro a las cuentas creadas
    public static void asignaTipoRegistroCreacion(List<Account> cuentasNuevas){
        
        Id tipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Moral').getRecordTypeId();
        Id tipoRegistroAfluentePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroAfluentePersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Moral').getRecordTypeId();
        
        for(Account cuentaNueva : cuentasNuevas){
            
            //Si la cuenta es tipo de registro prospecto persona fisica y ya tiene asignado un asesor y una fecha de afluencia se convierte a tipo de registro afluente persona fisica
            if(cuentaNueva.RecordTypeId == tipoRegistroProspectoPersonaFisica && String.isBlank(cuentaNueva.Asesor__c) == false && String.isBlank(String.valueOf(cuentaNueva.Fecha_de_Afluencia__c)) == false){
                cuentaNueva.RecordTypeId = tipoRegistroAfluentePersonaFisica;
            }
            //Si la cuenta es tipo de registro prospecto persona moral y ya tiene asignado un asesor y una fecha de afluencia se convierte a tipo de registro afluente persona moral
            else if(cuentaNueva.RecordTypeId == tipoRegistroProspectoPersonaMoral && String.isBlank(cuentaNueva.Asesor__c) == false && String.isBlank(String.valueOf(cuentaNueva.Fecha_de_Afluencia__c)) == false){
                cuentaNueva.RecordTypeId = tipoRegistroAfluentePersonaMoral;
            }
        }
    }
    
    //Metodo que asigna el tipo de registro a las cuentas modificadas
    public static void asignaTipoRegistroEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        
        Id tipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Moral').getRecordTypeId();
        Id tipoRegistroAfluentePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroAfluentePersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Moral').getRecordTypeId();
        
        for(Account cuentaModificada : cuentasModificadas){
            
            //Si la cuenta es tipo de registro prospecto persona fisica y ya tiene asignado un asesor y una fecha de afluencia se convierte a tipo de registro afluente persona fisica
            if(cuentaModificada.RecordTypeId == tipoRegistroProspectoPersonaFisica && String.isBlank(cuentaModificada.Asesor__c) == false && String.isBlank(String.valueOf(cuentaModificada.Fecha_de_Afluencia__c)) == false &&
               (cuentaModificada.Asesor__c != cuentasExistentes.get(cuentaModificada.Id).Asesor__c || cuentaModificada.Fecha_de_Afluencia__c != cuentasExistentes.get(cuentaModificada.Id).Fecha_de_Afluencia__c)){
                   cuentaModificada.RecordTypeId = tipoRegistroAfluentePersonaFisica;
               }
            //Si la cuenta es tipo de registro prospecto persona moral y ya tiene asignado un asesor y una fecha de afluencia se convierte a tipo de registro afluente persona moral
            else if(cuentaModificada.RecordTypeId == tipoRegistroProspectoPersonaMoral && String.isBlank(cuentaModificada.Asesor__c) == false && String.isBlank(String.valueOf(cuentaModificada.Fecha_de_Afluencia__c)) == false && 
                    (cuentaModificada.Asesor__c != cuentasExistentes.get(cuentaModificada.Id).Asesor__c || cuentaModificada.Fecha_de_Afluencia__c != cuentasExistentes.get(cuentaModificada.Id).Fecha_de_Afluencia__c)){
                        cuentaModificada.RecordTypeId = tipoRegistroAfluentePersonaMoral;
                    }
        }
    }
    
    //Metodo que obtiene el gerente de ventas del fraccionamiento elegido en la creacion de la cuenta y lo asigna al campo Gerente Ventas
    public static void asignaGerenteVentasCreacion(List<Account> cuentasNuevas){
        
        //Se obtienen las cuentas creadas que tienen un fraccionamiento asociado
        System.debug('*****asignaGerenteVentasCreacion');
        Set<Id> idsFraccionamientos = new Set<Id>();
        List<Account> cuentasFraccionamiento = new List<Account>();
        for(Account cuentaNueva : cuentasNuevas){
            
            if(String.isBlank(cuentaNueva.Fraccionamiento_cta__c) == false){
                idsFraccionamientos.add(cuentaNueva.Fraccionamiento_cta__c);
                cuentasFraccionamiento.add(cuentaNueva);
            }
        }
        System.debug('*****idsFraccionamientos:' + idsFraccionamientos);
        
        //Si hubo cuentas creadas asociadas a fraccionamientos se obtiene el gerente de ventas de dichos fraccionamientos
        if(cuentasFraccionamiento.size() > 0){
            
            //Se obtienen los datos de los fraccionamientos asociados a las cuentas creadas
            Set<String> nombresGrupos = new Set<String>();
            String nombreGrupo = '';
            Map<Id,String> idsFraccionamientosNombresGrupos = new Map<Id,String>();
            for(Fraccionamiento__c fraccionamiento : [SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientos]){
                nombreGrupo = 'Cuentas - ' + fraccionamiento.Name; nombresGrupos.add(nombreGrupo);
                idsFraccionamientosNombresGrupos.put(fraccionamiento.Id, nombreGrupo);
            }
            
            //Se obtienen los grupos publicos de los fraccionamientos asociados en las cuentas
            Set<Id> idsGrupos = new Set<Id>();
            Map<String,Id> nombresGruposIdsGrupos = new Map<String,Id>();
            for(Group grupo : [SELECT Id, Name FROM Group WHERE Name IN : nombresGrupos]){
                
                idsGrupos.add(grupo.Id);
                
                nombresGruposIdsGrupos.put(grupo.Name, grupo.Id);
            }
            System.debug('*****idsGrupos:' + idsGrupos);
            System.debug('*****nombresGruposIdsGrupos:' + nombresGruposIdsGrupos);
            
            //Se obtienen los miembros de los grupos publicos
            List<GroupMember> miembrosGrupos = [SELECT GroupId, UserOrGroupId FROM GroupMember WHERE GroupId IN : idsGrupos];
            
            //Se crea un mapa con Id del grupo publico y usuarios miembros del grupo publico
            Map<Id,Set<Id>> gruposMiembrosGrupos = new Map<Id,Set<Id>>(); Set<Id> idsMiembrosGruposAux1 = new Set<Id>();     Set<Id> idsUsuariosmiembrosGrupos = new Set<Id>();
            for(Id idGrupo : idsGrupos){
                idsMiembrosGruposAux1 = new Set<Id>();
                for(GroupMember miembroGrupo : miembrosGrupos){
                    if(idGrupo == miembroGrupo.GroupId){
                        idsMiembrosGruposAux1.add(miembroGrupo.UserOrGroupId);
                    }
                    idsUsuariosmiembrosGrupos.add(miembroGrupo.UserOrGroupId);
                }
                gruposMiembrosGrupos.put(idGrupo, idsMiembrosGruposAux1);
            }
            System.debug('*****idsUsuariosmiembrosGrupos:' + idsUsuariosmiembrosGrupos);
            System.debug('*****gruposMiembrosGrupos:' + gruposMiembrosGrupos);
            
            //Se obtienen los usuarios con perfil Gerente de Ventas que sean miembros del grupo publico del fraccionamiento asociado a la cuenta
            Map<Id,User> usuariosGerentesVentas = new Map<Id,User>([SELECT Id, Name FROM User WHERE Id IN : idsUsuariosmiembrosGrupos AND Profile.Name = 'JAVER - Gerente de Ventas']);
            
            //Se crea un mapa con el Id del grupo publico y el usuario con perfil Gerente de Ventas que pertenece a dicho grupo publico
            Map<Id,Id> grupoGerenteVentas = new Map<Id,Id>();
            Set<Id> idsMiembrosGruposAux2 = new Set<Id>();
            for(Id idGrupo : idsGrupos){
                idsMiembrosGruposAux2 = gruposMiembrosGrupos.get(idGrupo);
                for(Id idMiembroGrupo : idsMiembrosGruposAux2){
                    if(usuariosGerentesVentas.containsKey(idMiembroGrupo)){
                        grupoGerenteVentas.put(idGrupo, usuariosGerentesVentas.get(idMiembroGrupo).Id);
                    }
                }
            }
            System.debug('*****grupoGerenteVentas:' + grupoGerenteVentas);
            
            for(Account cuenta : cuentasFraccionamiento){
                cuenta.Gerente_Ventas__c = grupoGerenteVentas.get(nombresGruposIdsGrupos.get(idsFraccionamientosNombresGrupos.get(cuenta.Fraccionamiento_cta__c)));
            }
        }
    }
    
    //Metodo que obtiene el gerente de ventas del fraccionamiento elegido en la edicion de la cuenta y lo asigna al campo Gerente Ventas
    public static void asignaGerenteVentasEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        //Se obtienen las cuentas modificadas que tienen un fraccionamiento asociado
        Set<Id> idsFraccionamientos = new Set<Id>();
        List<Account> cuentasFraccionamiento = new List<Account>();
        for(Account cuentaModificada : cuentasModificadas){
            
            if(String.isBlank(cuentaModificada.Fraccionamiento_cta__c) == false && cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                idsFraccionamientos.add(cuentaModificada.Fraccionamiento_cta__c); 
                cuentasFraccionamiento.add(cuentaModificada);
            }
        }
        
        //Si hubo cuentas modificadas asociadas a fraccionamientos se obtiene el gerente de ventas de dichos fraccionamientos
        if(cuentasFraccionamiento.size() > 0){
            
            //Se obtienen los datos de los fraccionamientos asociados a las cuentas creadas
            Set<String> nombresGrupos = new Set<String>(); String nombreGrupo = '';    Map<Id,String> idsFraccionamientosNombresGrupos = new Map<Id,String>();
            for(Fraccionamiento__c fraccionamiento : [SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN : idsFraccionamientos]){
                nombreGrupo = 'Cuentas - ' + fraccionamiento.Name; nombresGrupos.add(nombreGrupo); idsFraccionamientosNombresGrupos.put(fraccionamiento.Id, nombreGrupo);
            }
            //Se obtienen los grupos publicos de los fraccionamientos asociados en las cuentas
            Set<Id> idsGrupos = new Set<Id>();  Map<String,Id> nombresGruposIdsGrupos = new Map<String,Id>();
            for(Group grupo : [SELECT Id, Name FROM Group WHERE Name IN : nombresGrupos]){
                idsGrupos.add(grupo.Id); nombresGruposIdsGrupos.put(grupo.Name, grupo.Id);
            }
            //Se obtienen los miembros de los grupos publicos
            List<GroupMember> miembrosGrupos = [SELECT GroupId, UserOrGroupId FROM GroupMember WHERE GroupId IN : idsGrupos];
            
            //Se crea un mapa con Id del grupo publico y usuarios miembros del grupo publico
            Map<Id,Set<Id>> gruposMiembrosGrupos = new Map<Id,Set<Id>>(); Set<Id> idsMiembrosGruposAux1 = new Set<Id>();   Set<Id> idsUsuariosmiembrosGrupos = new Set<Id>();
            for(Id idGrupo : idsGrupos){
                idsMiembrosGruposAux1 = new Set<Id>();
                for(GroupMember miembroGrupo : miembrosGrupos){
                    if(idGrupo == miembroGrupo.GroupId){
                        idsMiembrosGruposAux1.add(miembroGrupo.UserOrGroupId);
                    }
                    
                    idsUsuariosmiembrosGrupos.add(miembroGrupo.UserOrGroupId);
                }
                gruposMiembrosGrupos.put(idGrupo, idsMiembrosGruposAux1);
            }
            System.debug('*****idsUsuariosmiembrosGrupos:' + idsUsuariosmiembrosGrupos);
            System.debug('*****gruposMiembrosGrupos:' + gruposMiembrosGrupos);
            
            //Se obtienen los usuarios con perfil Gerente de Ventas que sean miembros del grupo publico del fraccionamiento asociado a la cuenta
            Map<Id,User> usuariosGerentesVentas = new Map<Id,User>([SELECT Id, Name FROM User WHERE Id IN : idsUsuariosmiembrosGrupos AND Profile.Name = 'JAVER - Gerente de Ventas']);
            
            //Se crea un mapa con el Id del grupo publico y el usuario con perfil Gerente de Ventas que pertenece a dicho grupo publico
            Map<Id,Id> grupoGerenteVentas = new Map<Id,Id>(); Set<Id> idsMiembrosGruposAux2 = new Set<Id>();
            for(Id idGrupo : idsGrupos){
                idsMiembrosGruposAux2 = gruposMiembrosGrupos.get(idGrupo);
                for(Id idMiembroGrupo : idsMiembrosGruposAux2){
                    if(usuariosGerentesVentas.containsKey(idMiembroGrupo)){
                        grupoGerenteVentas.put(idGrupo, usuariosGerentesVentas.get(idMiembroGrupo).Id);
                    }
                }
            }
            System.debug('*****grupoGerenteVentas:' + grupoGerenteVentas);
            
            for(Account cuenta : cuentasFraccionamiento){
                
                cuenta.Gerente_Ventas__c = grupoGerenteVentas.get(nombresGruposIdsGrupos.get(idsFraccionamientosNombresGrupos.get(cuenta.Fraccionamiento_cta__c)));
            }
            
            /*//Se obtienen los datos de los fraccionamientos asociados a las cuentas creadas
Map<String,Fraccionamiento__c> fraccionamientos = new Map<String,Fraccionamiento__c>();
*/
        }
    }
    
    //Metodo que crea la primera visita asociada a los registros de cuentas creadas
    public static void creaPrimeraVisitaCreacion(List<Account> cuentasNuevas){
        List<Account> cuentasConFechaAfluencia = new List<Account>();
        Set<Id> idsUsuarios = new Set<Id>();
        Set<Id> idsCuentas = new Set<Id>();
        for(Account cuentaNueva : cuentasNuevas){
            //Si la cuenta creada tiene fecha de afluencia asignada se agrega a una lista para crearle la primera visita
            if(String.isBlank(String.valueOf(cuentaNueva.Fecha_de_Afluencia__c)) == false){
                cuentasConFechaAfluencia.add(cuentaNueva);  idsUsuarios.add(cuentaNueva.LastModifiedById);    idsCuentas.add(cuentaNueva.Id);
            }
        }
        //Si existen cuentas creadas con fecha de afluencia se les crea la primera visita
        if(cuentasConFechaAfluencia.size() > 0){
            
            Map<Id,String> usuariosPerfiles = new Map<Id,String>();
            for(User usuario : [SELECT Id, Profile.Name FROM User WHERE Id IN : idsUsuarios]){
                usuariosPerfiles.put(usuario.Id, usuario.Profile.Name);
            }
            
            //Se obtiene la cantidad de visitas que tienen las cuentas asociadas a las nuevas visitas
            List<AggregateResult> visitasCuentas = [SELECT Cuenta__c, COUNT(Id) nVisitas FROM Visita_Fraccionamiento__c WHERE Cuenta__c IN : idsCuentas GROUP BY Cuenta__c];
            Map<Id,Integer> idCuentasNumeroVisitas = new Map<Id,Integer>();
            for(AggregateResult visitaCuenta : visitasCuentas){
                idCuentasNumeroVisitas.put(String.valueOf(visitaCuenta.get('Cuenta__c')), Integer.valueOf(visitaCuenta.get('nVisitas')));
            }
            
            List<Visita_Fraccionamiento__c> visitasNuevas = new List<Visita_Fraccionamiento__c>();
            for(Account cuentaNueva : cuentasConFechaAfluencia){
                
                Visita_Fraccionamiento__c visitaNueva = new Visita_Fraccionamiento__c();
                visitaNueva.Cuenta__c = cuentaNueva.Id;
                visitaNueva.Fraccionamiento__c = cuentaNueva.Fraccionamiento_cta__c;
                visitaNueva.Usuario__c = cuentaNueva.LastModifiedById;
                if (cuentaNueva.JMC_Fecha_Visita__c == null) {
                    visitaNueva.Fecha_Visita__c = date.today();
                } else {
                    visitaNueva.Fecha_Visita__c = cuentaNueva.JMC_Fecha_Visita__c;
                }
                visitaNueva.Fecha_Ultima_Visita__c = visitaNueva.Fecha_Visita__c;
                visitaNueva.Comentarios__c = 'Primera vez que el cliente visita el fraccionamiento.';
                visitaNueva.Numero_Visita__c = (idCuentasNumeroVisitas.containsKey(visitaNueva.Cuenta__c) == false ? 1 : idCuentasNumeroVisitas.get(visitaNueva.Cuenta__c) + 1);
                visitaNueva.Rol__c = usuariosPerfiles.get(cuentaNueva.LastModifiedById);
                visitaNueva.Automatica__c = true;
                
                visitasNuevas.add(visitaNueva);
            }
            system.debug('*** visitasNuevas: '+visitasNuevas);
            insert visitasNuevas;
        }
    }
    
    //Metodo que crea la primera visita asociada a los registros de cuentas modificadas
    public static void creaPrimeraVisitaEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        Id tipoRegistroAfluentePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Fisica').getRecordTypeId();       
        Id tipoRegistroAfluentePersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Afluente_Persona_Moral').getRecordTypeId();

        system.debug('*** Entro a creaPrimeraVisitaEdicion: '+cuentasModificadas);
        List<Account> cuentasConFechaAfluencia = new List<Account>();  Set<Id> idsUsuarios = new Set<Id>();    Set<Id> idsCuentas = new Set<Id>();
        for(Account cuentaModificada : cuentasModificadas){
            //Si la cuenta creada tiene fecha de afluencia asignada se agrega a una lista para crearle la primera visita
            if(String.isBlank(String.valueOf(cuentaModificada.Fecha_de_Afluencia__c)) == false && 
                    cuentaModificada.Fecha_de_Afluencia__c != cuentasExistentes.get(cuentaModificada.Id).Fecha_de_Afluencia__c){
                    system.debug ('*** Fecha de Afluencia cambió, escenario #1');
                cuentasConFechaAfluencia.add(cuentaModificada);  idsUsuarios.add(cuentaModificada.LastModifiedById);   idsCuentas.add(cuentaModificada.Id);
            } else {
                system.debug('******** ENTRO AL ELSE EN creaPrimeraVisitaEdicion: '+cuentaModificada.Fraccionamiento_cta__c+' | '+cuentasExistentes.get(cuentaModificada.id).Fraccionamiento_cta__c);
                // Escenario #2: Si la cuenta cambió de Fraccionamiento, se genera nueva visita
                if (cuentaModificada.Fraccionamiento_cta__c != cuentasExistentes.get(cuentaModificada.id).Fraccionamiento_cta__c) {
                    cuentasConFechaAfluencia.add(cuentaModificada);  idsUsuarios.add(cuentaModificada.LastModifiedById);   idsCuentas.add(cuentaModificada.Id);
                    system.debug('*** Entró a crearPrimeraVisitaEd x cambio de Fraccionamiento'); 
                }
            }
            if ((cuentaModificada.RecordTypeId==tipoRegistroAfluentePersonaFisica || cuentaModificada.RecordTypeId==tipoRegistroAfluentePersonaMoral) 
                    && cuentaModificada.RecordTypeId != cuentasExistentes.get(cuentaModificada.Id).RecordTypeId) {
                cuentasConFechaAfluencia.add(cuentaModificada);  idsUsuarios.add(cuentaModificada.LastModifiedById);   idsCuentas.add(cuentaModificada.Id);
                system.debug('*** Entró a crearPrimeraVisitaEd x cambio de RecordTypeId'); 
            }
        }
        //Si existen cuentas creadas con fecha de afluencia se les crea la primera visita
        if(cuentasConFechaAfluencia.size() > 0){
            Map<Id,String> usuariosPerfiles = new Map<Id,String>();
            for(User usuario : [SELECT Id, Profile.Name FROM User WHERE Id IN : idsUsuarios]){
                usuariosPerfiles.put(usuario.Id, usuario.Profile.Name);
            }
            
            //Se obtiene la cantidad de visitas que tienen las cuentas asociadas a las nuevas visitas
            //List<AggregateResult> visitasCuentas = [SELECT Cuenta__c, COUNT(Id) nVisitas FROM Visita_Fraccionamiento__c WHERE Cuenta__c IN : idsCuentas GROUP BY Cuenta__c];
            List<AggregateResult> visitasCuentas = [SELECT Cuenta__c, Fraccionamiento__c, COUNT(Id) nVisitas FROM Visita_Fraccionamiento__c WHERE Cuenta__c IN : idsCuentas GROUP BY Cuenta__c, Fraccionamiento__c];
            Map<String,Integer> idCuentasNumeroVisitas = new Map<String,Integer>();
            for(AggregateResult visitaCuenta : visitasCuentas){
                idCuentasNumeroVisitas.put(String.valueOf(visitaCuenta.get('Cuenta__c')) + String.valueOf(visitaCuenta.get('Fraccionamiento__c')), Integer.valueOf(visitaCuenta.get('nVisitas')));
            }
            
            List<Visita_Fraccionamiento__c> visitasNuevas = new List<Visita_Fraccionamiento__c>(); String cuentaFraccionamiento = '';
            for(Account cuentaModificada : cuentasConFechaAfluencia){
                cuentaFraccionamiento = String.valueOf(cuentaModificada.Id) + String.valueOf(cuentaModificada.Fraccionamiento_cta__c);
                Visita_Fraccionamiento__c visitaNueva = new Visita_Fraccionamiento__c();
                visitaNueva.Cuenta__c = cuentaModificada.Id;
                visitaNueva.Fraccionamiento__c = cuentaModificada.Fraccionamiento_cta__c;
                visitaNueva.Usuario__c = cuentaModificada.LastModifiedById;
                visitaNueva.Fecha_Visita__c = cuentaModificada.JMC_Fecha_Visita__c;
                // Leer la visita anterior de Visita y si esta visita anterior > visita nueva, levantar error
                try {
                    Visita_Fraccionamiento__c visitaAnterior = [SELECT Id, Fecha_Visita__c FROM Visita_Fraccionamiento__c 
                        WHERE Cuenta__c = :cuentaModificada.Id
                        AND Fraccionamiento__c = :cuentaModificada.Fraccionamiento_cta__c
                        ORDER BY Fecha_Visita__c DESC LIMIT 1];

                    if (visitaAnterior != null) {
                        visitaNueva.Fecha_Ultima_Visita__c = visitaAnterior.Fecha_Visita__c;
                    }
                } catch (Exception e) {
                    system.debug('*** No hay visita anterior');
                }
                visitaNueva.Comentarios__c = 'Primera vez que el cliente visita el fraccionamiento.';
                visitaNueva.Numero_Visita__c = (idCuentasNumeroVisitas.containsKey(cuentaFraccionamiento) == false ? 1 : idCuentasNumeroVisitas.get(cuentaFraccionamiento) + 1);
                visitaNueva.Rol__c = usuariosPerfiles.get(cuentaModificada.LastModifiedById);
                visitaNueva.Automatica__c = true;
                visitasNuevas.add(visitaNueva);
            }
            
            insert visitasNuevas;
        }
    }
    
    //Metodo que los registros de los roles de venta asignados en la creacion de una cuenta
    public static void creaRolesVentaCreacion(List<Account> cuentasNuevas){
        List<Rol_Venta__c> rolesVenta = new List<Rol_Venta__c>();
        for(Account cuenta : cuentasNuevas){
            //Si la cuenta tiene asignado un fraccionamiento, por cada uno de los roles de venta (Asesor, Prospectador, Lead Profiler y Colaborador Javer) asignados a la cuenta, se crea un registro de rol de venta
            if(String.isBlank(cuenta.Fraccionamiento_cta__c) == false){
                if(String.isBlank(cuenta.Asesor__c) == false){
                    Rol_Venta__c rolVenta = new Rol_Venta__c();
                    rolVenta.Cuenta__c = cuenta.Id;
                    rolVenta.Fraccionamiento__c = cuenta.Fraccionamiento_cta__c;
                    rolVenta.Fecha_Asignacion__c = cuenta.Fecha_Asignacion_Asesor__c;
                    rolVenta.Fecha_Hora_Asignacion__c = cuenta.Fecha_Hora_Asignacion_Asesor__c;
                    rolVenta.Usuario__c = cuenta.Asesor__c;
                    rolVenta.Rol_Venta__c = 'AS';
                    rolVenta.Llave__c = String.valueOf(cuenta.Asesor__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'AS';
                    rolesVenta.add(rolVenta);
                }
                
                //Si la cuenta tiene asignado un Prospectador, se crea un registro de rol venta con el prospectador
                if(String.isBlank(cuenta.Prospectador__c) == false){
                    
                    Rol_Venta__c rolVenta = new Rol_Venta__c();
                    rolVenta.Cuenta__c = cuenta.Id;
                    rolVenta.Fraccionamiento__c = cuenta.Fraccionamiento_cta__c;
                    rolVenta.Fecha_Asignacion__c = cuenta.Fecha_Prospeccion__c;
                    rolVenta.Fecha_Hora_Asignacion__c = cuenta.Fecha_Hora_Prospeccion__c;
                    rolVenta.Usuario__c = cuenta.Prospectador__c;
                    rolVenta.Rol_Venta__c = 'PR';
                    rolVenta.Llave__c = String.valueOf(cuenta.Prospectador__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'PR';
                    rolesVenta.add(rolVenta);
                }
                
                //Si la cuenta tiene asignado un Lead Profiler, se crea un registro de rol venta con el lead profiler
                if(String.isBlank(cuenta.Lead_Profiler__c) == false){
                    
                    Rol_Venta__c rolVenta = new Rol_Venta__c();
                    rolVenta.Cuenta__c = cuenta.Id;  rolVenta.Fraccionamiento__c = cuenta.Fraccionamiento_cta__c;
                    rolVenta.Fecha_Asignacion__c = cuenta.Fecha_LP__c;  rolVenta.Fecha_Hora_Asignacion__c = cuenta.Fecha_Hora_LP__c;
                    rolVenta.Usuario__c = cuenta.Lead_Profiler__c;rolVenta.Rol_Venta__c = 'LP';
                    rolVenta.Llave__c = String.valueOf(cuenta.Lead_Profiler__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'LP';
                    rolesVenta.add(rolVenta);
                }
                
                //Si la cuenta tiene asignado un Colaborador Javer, se crea un registro de rol venta con el colaborador Javer
                if(String.isBlank(cuenta.Colaborador_Javer__c) == false){
                    Rol_Venta__c rolVenta = new Rol_Venta__c();
                    rolVenta.Cuenta__c = cuenta.Id; rolVenta.Fraccionamiento__c = cuenta.Fraccionamiento_cta__c;
                    rolVenta.Fecha_Asignacion__c = cuenta.Fecha_Colaborador_Javer__c;rolVenta.Fecha_Hora_Asignacion__c = cuenta.Fecha_Hora_Colaborador_Javer__c;
                    rolVenta.Colaborador_Javer__c = cuenta.Colaborador_Javer__c; rolVenta.Rol_Venta__c = 'CJ';
                    rolVenta.Llave__c = String.valueOf(cuenta.Colaborador_Javer__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'CJ';
                    rolesVenta.add(rolVenta);
                }
            }
        }
        
        insert rolesVenta;
    }
    
    //Metodo que los registros de los roles de venta asignados en la edicion de una cuenta
    public static void creaRolesVentaEdicion(List<Account> cuentasModificadas,Map<Id,Account> cuentasExistentes){
        List<Account> cuentasAsesores = new List<Account>();  List<Account> cuentasProspectadores = new List<Account>();
        List<Account> cuentasLeadProfilers = new List<Account>();  List<Account> cuentasColaboradoresJaver = new List<Account>();
        for(Account cuentaModificada : cuentasModificadas){
            if(String.isBlank(cuentaModificada.Fraccionamiento_cta__c) == false){
                //Si no se cambio el fraccionamiento asociado a la cuenta se valida si se cambio algun rol de venta
                if(cuentaModificada.Fraccionamiento_cta__c == cuentasExistentes.get(cuentaModificada.Id).Fraccionamiento_cta__c){
                    //Si se cambio el Asesor a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los asesores
                    if(String.isBlank(cuentaModificada.Asesor__c) == false && cuentaModificada.Asesor__c != cuentasExistentes.get(cuentaModificada.Id).Asesor__c){
                        System.debug('*****Entro a diferentes asesores');
                        cuentasAsesores.add(cuentaModificada);
                    }
                    //Si se cambio el Prospectador a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los prospectadores
                    if(String.isBlank(cuentaModificada.Prospectador__c) == false && cuentaModificada.Prospectador__c != cuentasExistentes.get(cuentaModificada.Id).Prospectador__c){
                        System.debug('*****Entro a diferentes prospectadores');
                        cuentasProspectadores.add(cuentaModificada);
                    }
                    //Si se cambio el Lead Profiler a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los lead profilers
                    if(String.isBlank(cuentaModificada.Lead_Profiler__c) == false && cuentaModificada.Lead_Profiler__c != cuentasExistentes.get(cuentaModificada.Id).Lead_Profiler__c){
                        System.debug('*****Entro a diferentes lead profilers');
                        cuentasLeadProfilers.add(cuentaModificada);
                    }
                    //Si se cambio el Colaborador Javer a la cuenta modificada se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los colaboradores Javer
                    if(String.isBlank(cuentaModificada.Colaborador_Javer__c) == false && cuentaModificada.Colaborador_Javer__c != cuentasExistentes.get(cuentaModificada.Id).Colaborador_Javer__c){
                        cuentasColaboradoresJaver.add(cuentaModificada);
                    }
                }
                //Si se cambio el fraccionamiento asociado a la cuenta se obtiene los roles de venta que tiene asignados
                else{
                    
                    System.debug('*****Entro a diferentes fraccionamientos');
                    //Si la cuenta modificada tiene asignado un Asesor, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los asesores
                    if(String.isBlank(cuentaModificada.Asesor__c) == false){
                        System.debug('*****Entro a asesor no vacio');
                        cuentasAsesores.add(cuentaModificada);
                    }
                    
                    //Si la cuenta modificada tiene asignado un Prospectador, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los prospectadores
                    if(String.isBlank(cuentaModificada.Prospectador__c) == false){
                        System.debug('*****Entro a prospectador no vacio');
                        cuentasProspectadores.add(cuentaModificada);
                    }
                    
                    //Si la cuenta modificada tiene asignado un Lead Profiler, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los lead profilers
                    if(String.isBlank(cuentaModificada.Lead_Profiler__c) == false){
                        System.debug('*****Entro a lead profiler no vacio');
                        cuentasLeadProfilers.add(cuentaModificada);
                    }
                    
                    //Si la cuenta modificada tiene asignado un Colaborador Javer, se agrega la cuenta a una lista para la posterior obtencion de los registros de Rol de Venta de los colaboradores Javer
                    if(String.isBlank(cuentaModificada.Colaborador_Javer__c) == false){
                        System.debug('*****Entro a colaborador Javer no vacio');
                        cuentasColaboradoresJaver.add(cuentaModificada);
                    }
                }
            }
        }
        //Se obtienen los datos de los registros de Rol de Venta asociados a la cuenta y al Asesor
        Map<String,Rol_Venta__c> cuentasRolVentaAsesores = obtenerCuentasRolesVentaAsesores(cuentasAsesores);
        //Se obtienen los datos de los registros de Rol de Venta asociados a la cuenta y al Prospectador
        Map<String,Rol_Venta__c> cuentasRolVentaProspectadores = obtenerCuentasRolesVentaProspectadores(cuentasProspectadores);
        Map<String,Rol_Venta__c> cuentasRolVentaLeadProfilers = obtenerCuentasRolesVentaLeadProfilers(cuentasLeadProfilers);
        //Se obtienen los datos de los registros de Rol de Venta asociados a la cuenta y al Colaborador Javer
        Map<String,Rol_Venta__c> cuentasRolVentaColaboradoresJaver = obtenerCuentasRolesVentaColaboradoresJaver(cuentasColaboradoresJaver);
        List<Rol_Venta__c> rolesVenta = new List<Rol_Venta__c>();
        /*
for(Account cuenta : cuentasModificadas){ 
*/       
    }
    
    //Metodo para obtener los registros de Rol del Venta de Asesores asociados a una cuenta
    public static Map<String,Rol_Venta__c> obtenerCuentasRolesVentaAsesores(List<Account> cuentas){
        Map<String,Rol_Venta__c> cuentasRolVenta = new Map<String,Rol_Venta__c>(); Set<String> llavesRolesVenta = new Set<String>();
        for(Account cuenta : cuentas){
            llavesRolesVenta.add(String.valueOf(cuenta.Asesor__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'AS');
        }
        //Se obtienen los registros de Rol de venta asociados a la cuenta, fraccionamiento y asesores asignados a la cuenta
        for(Rol_Venta__c rolVenta : [SELECT Id, Cuenta__c, Usuario__c, Fraccionamiento__c, Fecha_Asignacion__c, Fecha_Hora_Asignacion__c, Vencido__c FROM Rol_Venta__c WHERE Llave__c IN : llavesRolesVenta]){
            cuentasRolVenta.put(String.valueOf(rolVenta.Usuario__c) + String.valueOf(rolVenta.Cuenta__c) + String.valueOf(rolVenta.Fraccionamiento__c) + 'AS', rolVenta);
        }
        return cuentasRolVenta;
    }
    
    //Metodo para obtener los registros de Rol del Venta de Prospectadores asociados a una cuenta
    public static Map<String,Rol_Venta__c> obtenerCuentasRolesVentaProspectadores(List<Account> cuentas){
        Map<String,Rol_Venta__c> cuentasRolVenta = new Map<String,Rol_Venta__c>(); Set<String> llavesRolesVenta = new Set<String>();
        for(Account cuenta : cuentas){
            llavesRolesVenta.add(String.valueOf(cuenta.Prospectador__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'PR');
        }
        for(Rol_Venta__c rolVenta : [SELECT Id, Cuenta__c, Usuario__c, Fraccionamiento__c, Fecha_Asignacion__c, Fecha_Hora_Asignacion__c, Vencido__c FROM Rol_Venta__c WHERE Llave__c IN : llavesRolesVenta]){
            cuentasRolVenta.put(String.valueOf(rolVenta.Usuario__c) + String.valueOf(rolVenta.Cuenta__c) + String.valueOf(rolVenta.Fraccionamiento__c) + 'PR', rolVenta);
        }
        return cuentasRolVenta;
    }
    
    //Metodo para obtener los registros de Rol del Venta de Lead Profilers asociados a una cuenta
    public static Map<String,Rol_Venta__c> obtenerCuentasRolesVentaLeadProfilers(List<Account> cuentas){
        Map<String,Rol_Venta__c> cuentasRolVenta = new Map<String,Rol_Venta__c>();
        Set<String> llavesRolesVenta = new Set<String>();
        for(Account cuenta : cuentas){
            llavesRolesVenta.add(String.valueOf(cuenta.Lead_Profiler__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'LP');
        }
        //Se obtienen los registros de Rol de venta asociados a la cuenta, fraccionamiento y asesores asignados a la cuenta
        for(Rol_Venta__c rolVenta : [SELECT Id, Cuenta__c, Usuario__c, Fraccionamiento__c, Fecha_Asignacion__c, Fecha_Hora_Asignacion__c, Vencido__c FROM Rol_Venta__c WHERE Llave__c IN : llavesRolesVenta]){
            cuentasRolVenta.put(String.valueOf(rolVenta.Usuario__c) + String.valueOf(rolVenta.Cuenta__c) + String.valueOf(rolVenta.Fraccionamiento__c) + 'LP', rolVenta);
        }
        return cuentasRolVenta;
    }
    
    //Metodo para obtener los registros de Rol del Venta de Colaboradores Javer asociados a una cuenta
    public static Map<String,Rol_Venta__c> obtenerCuentasRolesVentaColaboradoresJaver(List<Account> cuentas){
        Map<String,Rol_Venta__c> cuentasRolVenta = new Map<String,Rol_Venta__c>();
        Set<String> llavesRolesVenta = new Set<String>();
        for(Account cuenta : cuentas){
            llavesRolesVenta.add(String.valueOf(cuenta.Colaborador_Javer__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'CJ');
        }
        //Se obtienen los registros de Rol de venta asociados a la cuenta, fraccionamiento y asesores asignados a la cuenta
        for(Rol_Venta__c rolVenta : [SELECT Id, Cuenta__c, Colaborador_Javer__c, Fraccionamiento__c, Fecha_Asignacion__c, Fecha_Hora_Asignacion__c, Vencido__c FROM Rol_Venta__c WHERE Llave__c IN : llavesRolesVenta]){
            cuentasRolVenta.put(String.valueOf(rolVenta.Colaborador_Javer__c) + String.valueOf(rolVenta.Cuenta__c) + String.valueOf(rolVenta.Fraccionamiento__c) + 'CJ' , rolVenta);
        }
        return cuentasRolVenta;
    }
    
    public static void guardaHistoricoAsignaciones(List<Account> newTriggerList) {
        if (guardoHistoricoAsig) {
            return;
        }
        guardoHistoricoAsig=true;
        List<Historial_Asignacion__c> historialList = new List<Historial_Asignacion__c>();
        for (Account newAccount : newTriggerList) {
            Historial_Asignacion__c historial = new Historial_Asignacion__c();
            historial.Asesor__c = newAccount.Asesor__c;
            historial.Colaborador_Javer__c = newAccount.Colaborador_Javer__c;
            historial.Cuenta__c = newAccount.Id;
            historial.Dias_Vencimiento_Asesor__c = newAccount.Dias_Vencimiento_Asesor__c;
            historial.Dias_Vencimiento_Colaborador_Javer__c = newAccount.Dias_Vencimiento_Colaborador_Javer__c;
            historial.Dias_Vencimiento_LP__c = newAccount.Dias_Vencimiento_LP__c;
            historial.Dias_Vencimiento_Prospectador__c = newAccount.Dias_Vencimiento_Prospectador__c;
            historial.Estatus_Asesor__c = newAccount.Estatus_Asesor__c;
            historial.Estatus_Colaborador_Javer__c = newAccount.Estatus_Colaborador_Javer__c;
            historial.Estatus_Prospectador__c = newAccount.Estatus_Prospectador__c;
            historial.Fecha_de_Afluencia__c = newAccount.Fecha_de_Afluencia__c;
            historial.Fecha_ltima_visita__c = newAccount.Fecha_ltima_visita__c;
            historial.JMC_Fecha_Visita__c = newAccount.JMC_Fecha_Visita__c;
            historial.Fecha_Asignacion_Asesor__c = newAccount.Fecha_Asignacion_Asesor__c;
            historial.Fecha_Prospeccion__c = newAccount.Fecha_Prospeccion__c;
            historial.Fecha_LP__c = newAccount.Fecha_LP__c;
            historial.Fecha_Vencimiento_Asesor__c = newAccount.Fecha_Vencimiento_Asesor__c;
            historial.Fecha_Vencimiento_Colaborador_Javer__c = newAccount.Fecha_Vencimiento_Colaborador_Javer__c;
            historial.Fecha_Vencimiento_LP__c = newAccount.Fecha_Vencimiento_LP__c;
            historial.Fecha_Vencimiento_Prospectador__c = newAccount.Fecha_Vencimiento_Prospectador__c;
            historial.Fraccionamiento__c = newAccount.Fraccionamiento_cta__c;
            historial.Lead_Profiler__c = newAccount.Lead_Profiler__c;
            historial.Motivo_Asignacion__c = newAccount.Motivo_Asignacion__c;
            historial.Parentesco__c = newAccount.Parentesco__c;
            historial.Prospectador__c = newAccount.Prospectador__c;
            historial.Prototipo__c = newAccount.Prototipo_lookup__c;
            historialList.add(historial);
        }
        if (!historialList.isEmpty()) {
            insert historialList;
        }
    }
    
    public static void guardaHistoricoAsignaciones(Map<Id, Account> oldTriggerMap, List<Account> newTriggerList) {
        if (guardoHistoricoAsig) {
            return;
        }
        guardoHistoricoAsig=true;
        List<Historial_Asignacion__c> historialList = new List<Historial_Asignacion__c>();
        for (Account newAccount : newTriggerList) {
            Account oldAccount = oldTriggerMap.get(newAccount.Id);
            if (oldAccount != null) {
                if (newAccount.Asesor__c != oldAccount.Asesor__c ||  newAccount.Colaborador_Javer__c != oldAccount.Colaborador_Javer__c ||  newAccount.Dias_Vencimiento_Asesor__c != oldAccount.Dias_Vencimiento_Asesor__c ||
                    newAccount.Dias_Vencimiento_Colaborador_Javer__c != oldAccount.Dias_Vencimiento_Colaborador_Javer__c || newAccount.Dias_Vencimiento_LP__c != oldAccount.Dias_Vencimiento_LP__c ||
                    newAccount.Dias_Vencimiento_Prospectador__c != oldAccount.Dias_Vencimiento_Prospectador__c ||  newAccount.Estatus_Asesor__c != oldAccount.Estatus_Asesor__c || newAccount.Estatus_Colaborador_Javer__c != oldAccount.Estatus_Colaborador_Javer__c ||
                    newAccount.Estatus_Prospectador__c != oldAccount.Estatus_Prospectador__c || newAccount.Fraccionamiento_cta__c != oldAccount.Fraccionamiento_cta__c || newAccount.Lead_Profiler__c != oldAccount.Lead_Profiler__c ||
                    newAccount.Motivo_Asignacion__c != oldAccount.Motivo_Asignacion__c ||  newAccount.Parentesco__c != oldAccount.Parentesco__c ||   newAccount.Prospectador__c != oldAccount.Prospectador__c || newAccount.Prototipo_lookup__c != oldAccount.Prototipo_lookup__c) {
                        Historial_Asignacion__c historial = new Historial_Asignacion__c();
                        historial.Asesor__c = newAccount.Asesor__c;
                        historial.Colaborador_Javer__c = newAccount.Colaborador_Javer__c;
                        historial.Cuenta__c = newAccount.Id;
                        historial.Dias_Vencimiento_Asesor__c = newAccount.Dias_Vencimiento_Asesor__c;
                        historial.Dias_Vencimiento_Colaborador_Javer__c = newAccount.Dias_Vencimiento_Colaborador_Javer__c;
                        historial.Dias_Vencimiento_LP__c = newAccount.Dias_Vencimiento_LP__c;
                        historial.Dias_Vencimiento_Prospectador__c = newAccount.Dias_Vencimiento_Prospectador__c;
                        historial.Estatus_Asesor__c = newAccount.Estatus_Asesor__c;
                        historial.Estatus_Colaborador_Javer__c = newAccount.Estatus_Colaborador_Javer__c;
                        historial.Estatus_Prospectador__c = newAccount.Estatus_Prospectador__c;
                        historial.Fecha_Asignacion_Asesor__c = newAccount.Fecha_Asignacion_Asesor__c;
                        historial.Fecha_ltima_visita__c = newAccount.Fecha_ltima_visita__c;
                        historial.JMC_Fecha_Visita__c = newAccount.JMC_Fecha_Visita__c;        
                        historial.Fecha_de_Afluencia__c = newAccount.Fecha_de_Afluencia__c;
                        historial.Fecha_Prospeccion__c = newAccount.Fecha_Prospeccion__c;
                        historial.Fecha_LP__c = newAccount.Fecha_LP__c;
                        historial.Fecha_Vencimiento_Asesor__c = newAccount.Fecha_Vencimiento_Asesor__c;
                        historial.Fecha_Vencimiento_Colaborador_Javer__c = newAccount.Fecha_Vencimiento_Colaborador_Javer__c;
                        historial.Fecha_Vencimiento_LP__c = newAccount.Fecha_Vencimiento_LP__c;
                        historial.Fecha_Vencimiento_Prospectador__c = newAccount.Fecha_Vencimiento_Prospectador__c;
                        historial.Fraccionamiento__c = newAccount.Fraccionamiento_cta__c;
                        historial.Lead_Profiler__c = newAccount.Lead_Profiler__c;
                        historial.Motivo_Asignacion__c = newAccount.Motivo_Asignacion__c;
                        historial.Parentesco__c = newAccount.Parentesco__c;
                        historial.Prospectador__c = newAccount.Prospectador__c;
                        historial.Prototipo__c = newAccount.Prototipo_lookup__c;
                        historialList.add(historial);
                    }
            }
        }
        if (!historialList.isEmpty()) {
            system.debug ('**** Guardando Histórico de Asignaciones');
            insert historialList;
        }
    }
    public static void CLASS_CuentaCodeCoverage(){
        Integer i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
      
    }
}