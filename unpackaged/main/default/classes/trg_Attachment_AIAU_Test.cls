@isTest
private class trg_Attachment_AIAU_Test {
    ///////////////////////////////////////
    // Clase de prueba para probar el funcionamiento del
    // trigger 'trg_Attachment_AIAU'
    static TestMethod void testMethod1() {
        Sistema__c Sistema = new Sistema__c();
        Sistema.Name = 'Configuracion en Javer Util-Test';
        insert Sistema;
        XML_Siebel__c XMLSiebel_new = new XML_Siebel__c(name='Test');
        insert XMLSiebel_new;
        String body_xml =''+'<xml>'+'<platform>Siebel</platform>'+'<token>1234</token>'+'<requesterLogin>SADMIN</requesterLogin>'+'<requesterEmpId>0-1</requesterEmpId>'+'<requesterName>Siebel Administrator</requesterName>'+'<approverLogin>CRG</approverLogin>'+'<approverEmpId>1-TEST</approverEmpId>'+'<Aprobador>1-ROID</Aprobador>'+'<approverName>CARLOS REYES</approverName>'+'<approvalObject>Cedula Asesor</approvalObject>'+'<approvalRequestedDate>11/28/2014 14:39:03</approvalRequestedDate>'+'<approvalName>1-31091595</approvalName>'+'<approvalId>1-IIEFQ</approvalId>'+'<approvalType>Secuencial</approvalType>'+'<approvalLevel>Fraccionamiento</approvalLevel>'+'<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+'<listOfApprovalData>'+'   <ApprovalData>'+'   <listOfRecords>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Nombre</name>'+'  <value>ANDRES MONTAÑEZ</value>'+'  </field>'+'  <field>'+'  <name>Codigo</name>'+'  <value>1-31091595</value>'+'  </field>'+'  <field>'+'  <name>Periodo</name>'+'  <value>NOVIEMBRE 2014</value>'+'  </field>'+'  <field>'+'  <name>Tipo</name>'+'  <value>Comisión</value>'+'  </field>'+'  <field>'+'  <name>Rol Ventas</name>'+'  <value>Asesor</value>'+'  </field>'+'  <field>'+'  <name>Forma Pago</name>'+'  <value>NOVIEMBRE SEM4</value>'+'  </field>'+'  <field>'+'  <name>Numero Equipo</name>'+'  <value>1-3490395</value>'+'  </field>'+'</listOfFields>'+'</record>'+'   </listOfRecords>'+'   </ApprovalData>'+'   <ApprovalData>'+'   <listOfRecords>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>ELVIRA MORENO</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MA ISABEL HERNANDEZ</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MONICA JOANA SANCHEZ</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>ROBERTO ALFONSO PAYAN</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MARTHA IVETTE PONCE</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>IRMA ARENAS</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>RODOLFO DIAZ</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MA GUILLERMINA SALAS</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'   </listOfRecords>'+'   </ApprovalData>'+'   </listOfApprovalData>'+'</xml>';
        Attachment att = new Attachment(); 
        att.ParentId=XMLSiebel_new.id ;
        att.Name='Test';
        att.Body=Blob.valueOf(body_xml);
        att.ContentType='application/xml';
        Test.startTest();
        insert att;
        Test.stopTest();
    }
    static TestMethod void testMethod2() {
        Sistema__c Sistema = new Sistema__c();
        Sistema.Name = 'Configuracion en Javer ShPn Util-Test';
        Sistema.Correo_Recep_XML_Asunto__c = 'Asunto';
        Sistema.Correo_Recep_XML_Direcciones__c = 'example@example.com';
        Sistema.Correo_Recep_XML_Mensaje__c = 'Mensaje';
        insert Sistema;
        XML_SharePoint__c XMLSharePoint_new = new XML_SharePoint__c(name='Test');
        insert XMLSharePoint_new;
        String body_xml =''+'<xml>'+'<platform>Siebel</platform>'+'<token>1234</token>'+'<requesterLogin>SADMIN</requesterLogin>'+'<requesterEmpId>0-1</requesterEmpId>'+'<requesterName>Siebel Administrator</requesterName>'+'<approverLogin>CRG</approverLogin>'+'<approverEmpId>1-TEST</approverEmpId>'+'<Aprobador>1-ROID</Aprobador>'+'<approverName>CARLOS REYES</approverName>'+'<approvalObject>Cedula Asesor</approvalObject>'+'<approvalRequestedDate>11/28/2014 14:39:03</approvalRequestedDate>'+'<approvalName>1-31091595</approvalName>'+'<approvalId>1-IIEFQ</approvalId>'+'<approvalType>Secuencial</approvalType>'+'<approvalLevel>Fraccionamiento</approvalLevel>'+'<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+'<listOfApprovalData>'+'   <ApprovalData>'+'   <listOfRecords>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Nombre</name>'+'  <value>ANDRES MONTAÑEZ</value>'+'  </field>'+'  <field>'+'  <name>Codigo</name>'+'  <value>1-31091595</value>'+'  </field>'+'  <field>'+'  <name>Periodo</name>'+'  <value>NOVIEMBRE 2014</value>'+'  </field>'+'  <field>'+'  <name>Tipo</name>'+'  <value>Comisión</value>'+'  </field>'+'  <field>'+'  <name>Rol Ventas</name>'+'  <value>Asesor</value>'+'  </field>'+'  <field>'+'  <name>Forma Pago</name>'+'  <value>NOVIEMBRE SEM4</value>'+'  </field>'+'  <field>'+'  <name>Numero Equipo</name>'+'  <value>1-3490395</value>'+'  </field>'+'</listOfFields>'+'</record>'+'   </listOfRecords>'+'   </ApprovalData>'+'   <ApprovalData>'+'   <listOfRecords>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>ELVIRA MORENO</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MA ISABEL HERNANDEZ</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MONICA JOANA SANCHEZ</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>ROBERTO ALFONSO PAYAN</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MARTHA IVETTE PONCE</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>IRMA ARENAS</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>RODOLFO DIAZ</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'<record>'+'<listOfFields>'+'  <field>'+'  <name>Empleado</name>'+'  <value>MA GUILLERMINA SALAS</value>'+'  </field>'+'  <field>'+'  <name>Cant Reservas</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Formalizadas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Escrituradas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Cant Exigibles</name>'+'  <value/>'+'  </field>'+'  <field>'+'  <name>Cant Canceladas</name>'+'  <value>0</value>'+'  </field>'+'  <field>'+'  <name>Total a Pagar</name>'+'  <value>0</value>'+'  </field>'+'</listOfFields>'+'</record>'+'   </listOfRecords>'+'   </ApprovalData>'+'   </listOfApprovalData>'+'</xml>';
        Attachment att = new Attachment(); 
        att.ParentId = XMLSharePoint_new.id ;
        att.Name='Test';
        att.Body=Blob.valueOf(body_xml);
        att.ContentType='application/xml';
        Test.startTest();
        insert att;
        Test.stopTest();
    }
    
    /*    private static User CreateUserTest(String strProfile){
Profile prof = [SELECT Id FROM Profile WHERE Name=:strProfile];
User user = new User();

user.FirstName = 'Test';
user.LastName = 'Name';
user.CompanyName = 'IT Test Company';
user.MobilePhone = '123-456-7890';
user.EmpId1__c = '1-TEST';
user.UserSharePoint__c = 'usersharepoint';
user.Username = 'testUser-' + generateRandomString() + '@test.com';
user.Email = 'testUser-' + generateRandomString() + '@test.com';
user.Alias = 'test';
user.CommunityNickname = 'test1';
user.TimeZoneSidKey = 'America/New_York';
user.LocaleSidKey = 'en_US';
user.EmailEncodingKey = 'UTF-8';
user.ProfileId = prof.Id;
user.LanguageLocaleKey = 'en_US';

user.Street = '123 Test St';
user.City = 'Testcity';
user.State = 'va';
user.PostalCode = '23223';
user.Country = 'USA';

insert user;
return user;
}

private static String generateRandomString() {
return '' + math.rint( math.random() * 100000 );
}

private static Sistema__c CreateSistemaTest(String strName){

Sistema__c Sistema = new Sistema__c();

Sistema.Name = strName;
Sistema.Correo_Recep_XML_Asunto__c = 'Asunto';
Sistema.Correo_Recep_XML_Direcciones__c = 'example@example.com';
Sistema.Correo_Recep_XML_Mensaje__c = 'Mensaje';
Sistema.End_Point__c = 'https://endpoint.example.com/url_wrapper';
Sistema.End_Point_Descripcion__c = 'Direccion de EndPoint de Prueba';
Sistema.Limpieza_de_Aprob_Agendada__c = false;
Sistema.Limpieza_Job_Id__c = '';
Sistema.Limpieza_Recurrencia__c ='0 40 18 * * ?';
Sistema.Max_antiguedad_sin_resolucion__c =1;
insert Sistema;
return Sistema;
} 

static testMethod void runPositiveTest_AttFileSiebel() {
User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
//    Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
Test.startTest();

XML_Siebel__c XMLSiebel_new = new XML_Siebel__c(name='Test');
try {
insert XMLSiebel_new;
} catch (DmlException e) {
//System.Debug( e.getMessage() );
System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
} //catch
String body_xml =''+

'<xml>'+
'<platform>Siebel</platform>'+
'<token>1234</token>'+
'<requesterLogin>SADMIN</requesterLogin>'+
'<requesterEmpId>0-1</requesterEmpId>'+
'<requesterName>Siebel Administrator</requesterName>'+  
'<approverLogin>CRG</approverLogin>'+
'<approverEmpId>1-TEST</approverEmpId>'+
'<Aprobador>1-ROID</Aprobador>'+
'<approverName>CARLOS REYES</approverName>'+        
'<approvalObject>Cedula Asesor</approvalObject>'+
'<approvalRequestedDate>11/28/2014 14:39:03</approvalRequestedDate>'+
'<approvalName>1-31091595</approvalName>'+
'<approvalId>1-IIEFQ</approvalId>'+         
'<approvalType>Secuencial</approvalType>'+
'<approvalLevel>Fraccionamiento</approvalLevel>'+
'<approvalLevelValue>LOS ALAMOS</approvalLevelValue>'+
'<listOfApprovalData>'+
'   <ApprovalData>'+
'           <listOfRecords>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Nombre</name>'+
'                           <value>ANDRES MONTAÑEZ</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Codigo</name>'+
'                           <value>1-31091595</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Periodo</name>'+
'                           <value>NOVIEMBRE 2014</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Tipo</name>'+
'                           <value>Comisión</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Rol Ventas</name>'+
'                           <value>Asesor</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Forma Pago</name>'+
'                           <value>NOVIEMBRE SEM4</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Numero Equipo</name>'+
'                           <value>1-3490395</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'           </listOfRecords>'+
'       </ApprovalData>'+
'       <ApprovalData>'+
'           <listOfRecords>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>ELVIRA MORENO</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>MA ISABEL HERNANDEZ</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>MONICA JOANA SANCHEZ</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>ROBERTO ALFONSO PAYAN</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>MARTHA IVETTE PONCE</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>IRMA ARENAS</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>RODOLFO DIAZ</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'               <record>'+
'                   <listOfFields>'+
'                       <field>'+
'                           <name>Empleado</name>'+
'                           <value>MA GUILLERMINA SALAS</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Reservas</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Formalizadas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Escrituradas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Exigibles</name>'+
'                           <value/>'+
'                       </field>'+
'                       <field>'+
'                           <name>Cant Canceladas</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                       <field>'+
'                           <name>Total a Pagar</name>'+
'                           <value>0</value>'+
'                       </field>'+
'                   </listOfFields>'+
'               </record>'+
'           </listOfRecords>'+
'       </ApprovalData>'+
'   </listOfApprovalData>'+

'</xml>';

Attachment[] attRecords = new Attachment[] {
new Attachment(ParentId=XMLSiebel_new.id, Name='Test', Body=Blob.valueOf(body_xml), ContentType='application/xml')

};
insert attRecords;
List<Attachment> attachments=[select id, name from Attachment where parent.id=:XMLSiebel_new.id];
System.assertEquals(1, attachments.size());
Test.stopTest();
}

static testMethod void runPositiveTest_AttFileSharePoint() {
User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
//Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer ShPn Util-Test');
Test.startTest();
XML_SharePoint__c XMLSharePoint_new = new XML_SharePoint__c(name='Test');
try {
insert XMLSharePoint_new;
} catch (DmlException e) {
//System.Debug( e.getMessage() );
System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
} //catch
String body_xml =''+                
'<xml>'+
'<Platform>Sharepoint</Platform>'+
'<TipoXML>Proveedores</TipoXML>'+
'<NoDocumento>Prueba_Provedor_1.xml.xml</NoDocumento>'+
'<Aprobador>test</Aprobador>'+
'<EstatusSolicitud>Pendiente</EstatusSolicitud>'+
'<Accion>Alta</Accion>'+
'<CompaniasKontrol>No</CompaniasKontrol>'+
'<RazonSocialNombre>Cementos maya</RazonSocialNombre>'+
'<Rfc>CEMA010101</Rfc>'+
'<TipoProveedor>MATERIALES</TipoProveedor>'+
'<LineaProductos>CEMENTO</LineaProductos>'+
'<NomRepLegal>Juan Perez</NomRepLegal>'+
'<Direccion>calle Yuxchilan 3434</Direccion>'+
'<Ciudad>Merida</Ciudad>'+
'<Estado>Yucatan</Estado>'+
'<Numero>001</Numero>'+
'<ContactoVendedor>Pedro Navaja</ContactoVendedor>'+
'<Tramite>Cheque</Tramite>'+
'<Comentario>Comentariios</Comentario>'+
'<Creado>01/01/2015</Creado>'+
'<CreadoPor>jlguzman</CreadoPor>'+
'<Nombre>Jose Luis G</Nombre>'+
'<NombreJefe>Jorge Escandon</NombreJefe>'+
'<UsuarioJefeInmediato>jlguzman</UsuarioJefeInmediato>'+
'<Uen>Wen24</Uen>'+
'<Area>Construccion</Area>'+
'<Listas>sharepoint</Listas>'+
'<listOfApprovalData>'+
'<ApprovalData>'+
'<listOfRecords>'+
'<record>'+
'<listOfFields>'+
'<field>'+
'<name>Telefono</name>'+
'<value>81800020</value>'+
'</field>'+
'</listOfFields>'+
'</record>'+
'</listOfRecords>'+
'</ApprovalData>'+
'<ApprovalData>'+
'<listOfRecords>'+
'<record>'+
'<listOfFields>'+
'<field>'+
'<name>Celular</name>'+
'<value>81897111</value>'+
'</field>'+
'</listOfFields>'+
'</record>'+
'</listOfRecords>'+
'</ApprovalData>'+
'<ApprovalData>'+
'<listOfRecords>'+
'<record>'+
'<listOfFields>'+
'<field>'+
'<name>Email</name>'+
'<value>jlguzman@javer</value>'+
'</field>'+
'</listOfFields>'+
'</record>'+
'</listOfRecords>'+
'</ApprovalData>'+
'</listOfApprovalData>'+
'</xml>';

Attachment[] attRecords = new Attachment[] {
new Attachment(ParentId=XMLSharePoint_new.id, Name='Test', Body=Blob.valueOf(body_xml), ContentType='application/xml')

};
insert attRecords;
List<Attachment> attachments=[select id, name from Attachment where parent.id=:XMLSharePoint_new.id];
System.assertEquals(1, attachments.size());
Test.stopTest();
} */
}