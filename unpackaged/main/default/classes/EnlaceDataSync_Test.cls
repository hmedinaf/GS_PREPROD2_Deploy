@isTest (seeAllData=true)
public class EnlaceDataSync_Test {
    @isTest
    public static void testUpdateAccount() {
        // Create a test JSON string
        String testJson = '{' +
            '"User": "IFALK",' +
            '"Nombre": "EMILIO",' +
            '"ApellidoPaterno": "MONTALVO",' +
            '"ApellidoMaterno": "SALAZAR",' +
            '"idcuenta": "12345123",' +
            '"FechaNacimiento": "10/01/1996",' +
            '"nss": "63646272736",' +
            '"tipoRegistro": "PROSPECTO",' +
            '"tipoCredito": "CONTADO",' +
            '"estatusCuenta": "",' +
            '"fraccionamiento": "ACACIAS",' +
            '"origen": "ENFOQUE COMERCIAL (SISTEMA COMERCIAL)",' +
            '"prospectador": "JAVIER ROMO",' +
            '"fechaProspeccion": "20/04/2023",' +
            '"asesor": "JAVIER ROMO",' +
            '"leadProfilerCheck": "",' +
            '"colaboradorJaver": "IFALK",' +
            '"fechaAsignacion": "04/03/2023",' +
            '"canalVenta": "Medios Digitales",' +
            '"subCanalVenta": "Facebook",' +
            '"telefonoCasa": "+12105589933",' +
            '"telefonoCelular": "+525527371762",' +
            '"tipoDireccion": "Dirección Principal",' +
            '"pais": "México",' +
            '"estado": "NL",' +
            '"municipio": "",' +
            '"colonia": "",' +
            '"calle": "Lazaro Cardenas",' +
            '"numInterior": "B",' +
            '"numExterior": "2333",' +
            '"cp": "01236",' +
            '"empresaTrabajo": "EMPRESA SA DE CV",' +
            '"puestoTrabajo": "GERENTE",' +
            '"telefonoTrabajo": "+526775432245",' +
            '"aniosTrabajo": "5",' +
            '"mesesTrabajo": "8",' +
            '"estadoCivil": "SOLTERO",' +
            '"ingresoMensual": "45,000 - 54,999",' +
            '"depEconomicos": "2",' +
            '"numHijos": "1",' +
            '"sexo": "MASCULINO",' +
            '"Perfil": "ASESOR",' +
            '"EjecutivoVenta": "JAVIER ROMO",' +
            '"CorreoElectronico": "elena.robles@empresa.com",' +
            '"FechaVencimiento": "20/04/2023",' +
            '"DiasVencimiento": "15"' +
        '}';


        RestRequest req = new RestRequest();
        req.requestBody = Blob.valueOf(testJson);
        RestContext.request = req;

        // Call the updateAccount method
        Test.startTest();
        Map<String, String> results = new Map<String,String>();
        results = EnlaceDataSync.updateAccount();
        Test.stopTest();


    }
}