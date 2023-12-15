public class UserTrigger_Handler {
    public static void updFraccionamientos(List <User> newList) {
        // String query = 'SELECT Id, ' + fieldName + ' FROM ' + objectName + ' WHERE ' + fieldName + ' != null';
        // List<SObject> records = Database.query(query);

        // Iterate through the records and convert the multipicklist values to a comma-separated string
        for (User r : newList) {
            if (r.FRACCIONAMIENTOS__c != null) {
                String[] fraccs = r.FRACCIONAMIENTOS__c.split(';');
                String convertedValues = '';

                List<String> selectedValues = new List<String>();
                for (String f : fraccs) {
                    selectedValues.add(f);
                }

                convertedValues = String.join(selectedValues, ',');
                
                // Store the converted values in a string field
                r.FraccionamientoAutorizados__c = convertedValues;
                r.Fraccionamiento_autorizado__c = convertedValues;
            }
        }
    }
}