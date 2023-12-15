public class InfRepLegalTriggerHandler {
    public static void updateRFCyCURP(List<Informacion_representante_legal__c> newList) {
        CurpGenerator curpGenerator;
        Person person;
        for (Informacion_representante_legal__c repLegal : newList) {
            if(validateData(repLegal)){
                person = new Person()
                    .setName(repLegal.Name)
                    .setLastName(repLegal.Apellido_Paterno__c)
                    .setMotherMaidenName(repLegal.Apellido_Materno__c)
                    .setGender(repLegal.Sexo__c)
                    .setBirthDate(repLegal.Fecha_de_Nacimiento__c)
                    .setBirthPlace(repLegal.Lugar_de_nacimiento__c);
    
                curpGenerator = new CurpGenerator(person);
    
                if (repLegal.RFC__c==null) {
                    repLegal.RFC__c = curpGenerator.generateBaseRFC();
                    repLegal.RFC__c += curpGenerator.generateHomoclave();
                }
                if (repLegal.CURP__c==null) {
                    repLegal.CURP__c = curpGenerator.generateCurp();
                }
            }
        }
    }

    private static Boolean validateData(Informacion_representante_legal__c rl){
        return rl.Name != null && 
            rl.Apellido_Paterno__c != null && 
            rl.Apellido_Materno__c != null &&
            rl.Sexo__c != null && rl.Fecha_de_Nacimiento__c != null &&
            rl.Lugar_de_nacimiento__c != null;
    }
}