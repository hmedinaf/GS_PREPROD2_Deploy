public class AccountSearchController { 
    @TestVisible public List<Account> acc { get; set; } 
    @TestVisible public String searchQuery { get; set; } 
    @TestVisible public String searchField { get; set; } 
    @TestVisible public String searchKey { get; set; } 

    @TestVisible public void search() {
        
        // SOQL query dynamically using the selected searchField and searchKey
        String fieldToQuery;
        if (searchField == 'NSS__c' || searchField == 'QUOTE_Nombre_Fracc__c' || searchField == 'FirstName'|| searchField == 'Apellidopaterno_cta__c' ||searchField == 'Apellidomaterno_cta__c' || 
            searchField == 'Nombre_Fraccionamiento__c' || searchField == 'Estatus_Cliente__c' || searchField == 'Nombre_del_Asesor__c' || searchField == 'CURP__c' || 
            searchField == 'Origen__c' || searchField == 'Canal_de_Venta__c' || searchField == 'Sub_canal_de_venta__c' || searchField == 'Estatus_Lista_Negra_QEQ__c' ||
             searchField == 'Numerodecliente__c' || searchField == 'Leader__c' || searchField == 'Numero_de_Cliente_AutoNum__c') {
            fieldToQuery = searchField;
        } else if ( searchField == 'FechaNacimiento_Formula__c' || searchField == 'Fecha_Asignacion_Asesor_Formula__c') 
        {
            fieldToQuery = string.valueOf(searchField) ; 
        }
        else if (searchField == 'Lead_Profiler__c') 
        {
            fieldToQuery = 'Lead_Profiler__r.Name';
        } else if (searchField == 'ParentId') 
        {
            fieldToQuery = 'Parent.Name';
        } else if (searchField == 'ParentId') 
        {
            fieldToQuery = 'Numero_de_Cliente_AutoNum__c';
        } else if (searchField == 'Tipo__c')
        {
            fieldToQuery = 'RecordTypeName__c';
        } else {
            // Default to search by Name if an invalid search field is selected
            fieldToQuery = 'Name';
        }
            String searchQuery = 'SELECT Id, Name, NSS__c, RecordTypeName__c, Estatus_Cliente__c, QUOTE_Nombre_Fracc__c, Owner.Name, Asesor__c, lastname, firstname, Nombre_Fraccionamiento__c, CreatedDate, Apellidopaterno_cta__c, Apellidomaterno_cta__c, FechaNacimiento__c, FechaNacimiento_Formula__c, Fecha_Asignacion_Asesor_Formula__c, Fecha_Asignacion_Asesor__c,Tipo__c, Nombre_del_Asesor__c, Lead_Profiler__c, CURP__c, Origen__c, Canal_de_Venta__c, Sub_canal_de_venta__c, Estatus_Lista_Negra_QEQ__c, Numerodecliente__c, Numero_de_Cliente_AutoNum__c ' +
            'FROM Account ' +
            'WHERE ' + fieldToQuery + ' LIKE \'%' + searchKey + '%\' ORDER BY CreatedDate DESC LIMIT 100';

            string whereClause = 'WHERE ' + fieldToQuery + ' LIKE \'%' + searchKey + '%\' ORDER BY CreatedDate DESC LIMIT 100';
        system.debug ('*** whereClause: '+ whereClause);

        // Execute the query and assign the results to the acc property
        acc = Database.query(searchQuery);
    }
    

    public void clear() {
        // Clear the search field and results
        searchField = '';
        searchKey = '';
        acc = null;
    }
}