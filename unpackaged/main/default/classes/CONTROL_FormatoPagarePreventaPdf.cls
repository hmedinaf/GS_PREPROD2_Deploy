public with sharing class CONTROL_FormatoPagarePreventaPdf {
    
    public Id RecordId {get;set;}
    public string compania {get; set;}
    public double cantidad {get; set;}
    public string cantidadl {get; set;}
    public string domicilio {get; set;}
    public string telefono {get; set;}
    public string day {get; set;}
    public string month {get; set;}
    public string year {get; set;}
    public string suscriptor {get; set;}
    public string domicilioS {get; set;}
    public string telefonoS1 {get; set;}
    public string telefonoS2 {get; set;}
    public string telefonoS3 {get; set;}
    public string aval {get; set;}
    public string domicilioA {get; set;}
    public string telefonoA1 {get; set;}
    public string telefonoA2 {get; set;}
    public string telefonoA3 {get; set;}
    public string usuario {get; set;}
    public list<CONTROL_FormatoPagarePreventaPdfAux> aux {get; set;}
    public double total {get; set;}
    
    public CONTROL_FormatoPagarePreventaPdf(ApexPages.StandardController controller) {
        RecordId  = ApexPages.currentPage().getParameters().get('id');
        Plan_de_Venta__c pv = [Select Id, Diferencia_a_Pagar__c, Valor_de_Operacion__c, Aval__c, Domicilio_Aval__c, Ubicacion_Compania__c, 
            Oportunidad__r.Account.Name, Oportunidad__r.Account.BillingAddress, Oportunidad__r.Account.Phone, Oportunidad__r.Account.TelefonoCelular__c, 
            Oportunidad__r.Account.Otro_Telefono__c, Telefono_Celular_Aval__c, Telefono_Casa_Aval__c, Telefono_Otro_Aval__c,Oportunidad__r.Fraccionamiento__c,
            Enganche_a_Pagar__c, Oportunidad__r.Name
            FROM Plan_de_Venta__c
            WHERE Id = :RecordId Limit 1];
        Dictaminacion__c[] dc = [SELECT ID FROM Dictaminacion__c WHERE Oportunidad__c = :pv.Oportunidad__c LIMIT 1];
        Direcciones__c[] dirs = new List<Direcciones__c>();
        if (dc.size()>0){
            dirs = [SELECT Direccion__c FROM Direcciones__c WHERE Dictaminacion__c = :dc[0].Id AND Tipo__c = 'Dirección Principal'];
        }
        // Ubicacion__c[] u = [Select Id, Nombre_de_la_Compania__c, Direccion_Fisica__c, Telefono__c From Ubicacion__c Where Id = :pv.Ubicacion_Compania__c Limit 1];
        Fraccionamiento__c[] fr = [SELECT id, Compania_Asociada__r.Name,Compania_Asociada__r.BillingStreet,Compania_Asociada__r.Phone,
                Compania_Asociada__r.BillingState, Compania_Asociada__r.BillingCity
                FROM Fraccionamiento__c where ID = :pv.Oportunidad__r.Fraccionamiento__c];
        if(fr.size() == 0){
            compania = ' N/A';
            domicilio = ' N/A';
            telefono = ' N/A';
        }
        else{
            compania = ' ' + fr[0].Compania_Asociada__r.Name; //u[0].Nombre_de_la_Compania__c;
            domicilio = ' ' + fr[0].Compania_Asociada__r.BillingStreet+', '+fr[0].Compania_Asociada__r.BillingState+', '+fr[0].Compania_Asociada__r.BillingCity;
            telefono = ' Tel. ' + fr[0].Compania_Asociada__r.Phone;
        }
        cantidad = pv.Enganche_a_Pagar__c; //pv.Valor_de_Operacion__c;
        cantidadL = Numero_a_Letra.convertir(pv.Enganche_a_Pagar__c);
        fecha();
        suscriptor = pv.Oportunidad__r.Account.Name;
        if (dirs.size()>0){
            domicilioS = dirs[0].Direccion__c; // String.ValueOf(pv.Oportunidad__r.Account.BillingStreet);
        }
        
        telefonoS1 = String.ValueOf(pv.Oportunidad__r.Account.Phone);
        telefonoS2 = String.ValueOf(pv.Oportunidad__r.Account.TelefonoCelular__c);
        telefonoS3 = String.ValueOf(pv.Oportunidad__r.Account.Otro_Telefono__c);
        aval = pv.Aval__c;
        domicilioA = pv.Domicilio_Aval__c;
        telefonoA1 = String.ValueOf(pv.Telefono_Celular_Aval__c);
        telefonoA2 = String.ValueOf(pv.Telefono_Casa_Aval__c);
        telefonoA3 = String.ValueOf(pv.Telefono_Otro_Aval__c);
        usuario = UserInfo.getName();

        String codigoPagare = pv.Oportunidad__r.Name;
        String codigoPagareDV = CLASS_Oportunidad.CalculaDigitoVerificador(codigoPagare);

        List<Pagare_Preventa__c> pps = [Select Id, Name, Plan_de_Venta__c, Importe__c, Fecha_de_Vencimiento__c From Pagare_Preventa__c Where Plan_de_Venta__c = :RecordId];
        aux = new list<CONTROL_FormatoPagarePreventaPdfAux>();
        For(Pagare_Preventa__c pp : pps){
            aux.add(new CONTROL_FormatoPagarePreventaPdfAux(codigoPagareDV, (pp.Importe__c), (pp.Fecha_de_Vencimiento__c.format())));
        }
        total = pv.Diferencia_a_Pagar__c;
    }

    public void fecha(){
        Date d =date.today();
        day = ' ' + String.valueOf(d.day());
        Integer monthI = Integer.valueOf(d.month());
        switch on monthI {
            when 1 {
                month = ' Enero';
            }	
            when 2 {
                month = ' Febrero';
            }
            when 3 {
                month = ' Marzo';
            }
            when 4 {
                month = ' Abril';
            }
            when 5 {
                month = ' Mayo';
            }
            when 6 {
                month = ' Junio';
            }
            when 7 {
                month = ' Julio';
            }
            when 8 {
                month = ' Agosto';
            }
            when 9 {
                month = ' Septiembre';
            }
            when 10 {
                month = ' Octubre';
            }
            when 11 {
                month = ' Noviembre';
            }
            when else {
                month = ' Diciembre';
            }
        }
        year = ' ' + String.valueOf(d.year());
    }
}