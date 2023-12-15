public class PerfilTerceroFisTriggerHandler {

    public static void updateRFCyCURP(List<Perfil_Tercero_Fisico__c> newList) {
        CurpGenerator curpGenerator;
        Person person;
        system.debug ('*** entro al updateRFCyCURP');
        for (Perfil_Tercero_Fisico__c per : newList) {
            if(validateData(per)){
                system.debug ('*** persona validada');
                person = new Person()
                    .setName(per.Nombre__c)
                    .setLastName(per.Apellido_Paterno__c)
                    .setMotherMaidenName(per.Apellido_Materno__c)
                    .setGender(per.Sexo__c)
                    .setBirthDate(per.Fecha_de_Nacimiento__c)
                    .setBirthPlace(per.Lugar_de_nacimiento__c);
    
                curpGenerator = new CurpGenerator(person);
    
                if (per.RFC__c==null) {
                    per.RFC__c = curpGenerator.generateBaseRFC();
                    per.RFC__c += curpGenerator.generateHomoclave();
                }
                if (per.CURP__c==null) {
                    per.CURP__c = curpGenerator.generateCurp();
                }
            }
        }
    }

    private static Boolean validateData(Perfil_Tercero_Fisico__c pf){
        return pf.Nombre__c != null && 
        pf.Apellido_Paterno__c != null && 
        pf.Apellido_Materno__c != null &&
        pf.Sexo__c != null && pf.Fecha_de_Nacimiento__c != null &&
        pf.Lugar_de_nacimiento__c != null;
    }
}