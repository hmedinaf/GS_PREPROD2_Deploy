public class PromocionTriggerHandler {
    public static void handleAfterInsert(List <Promocion__c> newList) {
        List<String> setFracc = new List<String> ();
        String sFraccs = '';
        Date Fecha;
        Set <String> setFraccs = new Set <String>();
        for (Promocion__c p : newList) {
            Fecha = p.Fecha_Final__c;
            setFraccs.add(p.Fraccionamiento__c);
        }
        for (Fraccionamiento__c f : [SELECT Id, Name FROM Fraccionamiento__c WHERE Id in :setFraccs]) {
            sFraccs = '\''+ f.Name + '\'';
        }

        // Quitar la primer ,
        //sFraccs = sFraccs.substring(2, sFraccs.length() - 1);
        system.debug ('Fraccs: '+sFraccs);
        String stringQry = 'SELECT Id, Email, Name from User WHERE Fraccionamientos__c IN ('+sFraccs+')';
        system.debug('stringQry: '+stringQry);

        // Buscar Usuarios que tengan ese fraccionamiento
        List <User> userSendEmail = Database.Query(stringQry);
        system.debug ('*** userSendEmail: '+userSendEmail);

        for (User usr : userSendEmail){
            String body='<p>Estimado '+usr.Name+':</p><p>Un nuevo material de apoyo ha sido creado y está disponible en el sitio para su consulta y descarga.</p> <p>Consulte la fecha de vigencia que se encuentra en el PDF descargable.</p><br><p>Saludos,</p><p>Equipo Javer</p>';
            EnviaNotificacionNuevoMatierial.Envia(usr.Email, '*TEST* Material de Apoyo Javer', body);
        }
    }
}