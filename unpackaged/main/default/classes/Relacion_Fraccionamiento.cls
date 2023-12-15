public class Relacion_Fraccionamiento {
    @AuraEnabled
    public static wrap fetchPlaza(string pId){
        wrap wr = new Wrap();
        List<Relacion_Producto_Plaza__c> plazas = [SELECT Id,Name, Plaza__c, Plaza__r.Name , Producto__c FROM Relacion_Producto_Plaza__c WHERE Producto__c =: pId];
        //return plazas;
        wr.plazas = plazas;
        Id userId =  UserInfo.getUserId();
        User  u =[Select Id,Name,Phone,SenderEmail,Email,state, Profile.Name,Fraccionamientos__c from User where Id=:userId];
        List<String> fracList  = new List<String>();
        if(u.Fraccionamientos__c != null && u.Fraccionamientos__c != ''){
            fracList = u.Fraccionamientos__c.split(';');
        }
       fracList.sort();
        wr.fracList = fracList;
        return wr;
    }
    //Relacion_Producto_Fraccionamiento__c frac replaced with string frac
    @AuraEnabled
    public static String saveFraccRecord(Relacion_Producto_Fraccionamiento__c fracobj,String frac, String plaza, string prodId, Boolean showDate){
        string message = '';
        try {
            system.debug('frac'+frac);
            //List<Fraccionamiento__c> fraclist = [Select Id, Name from Fraccionamiento__c where Id =: frac.Fraccionamiento__c];
            List<Fraccionamiento__c> fraclist = [Select Id, Name from Fraccionamiento__c where Name =: frac LIMIT 1];
            String fracName  ;
            if(fraclist != null && fraclist.size()>0){
                fracName = fraclist[0].Name;
            }
            list<Relacion_Producto_Fraccionamiento__c> flist= [select id, Name , Producto__c from Relacion_Producto_Fraccionamiento__c Where Name =: fracName AND Producto__c = :prodId];
            if(flist != null && flist.size()>0){
                message = 'Error al duplicar!'; 
            }
            else{
                Relacion_Producto_Fraccionamiento__c fracc = new Relacion_Producto_Fraccionamiento__c();
                fracc.Name = 'x';
                fracc.Producto__c = prodId;
                fracc.Relacion_Producto_Plaza_Fraccionamiento__c = plaza;
                //fracc.Fraccionamiento__c = frac.Fraccionamiento__c;
                fracc.Fraccionamiento__c = fraclist[0].Id;
                fracc.Vigencia_Hasta__c =fracobj.Vigencia_Hasta__c;
                fracc.Sin_vigencia__c = showDate;
                insert fracc;
                system.debug('fracc'+fracc);
                message = 'success!';
            }
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    }
    public class wrap{
        @AuraEnabled public List<String> fracList;
        @AuraEnabled public List<Relacion_Producto_Plaza__c> plazas;
    }
}