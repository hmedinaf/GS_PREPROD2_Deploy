public class StringUtils {

    public static String replaceSpecialChars(String text){
        String textoSustituido = '';
        textoSustituido = text.replaceAll('[ÀÁÂÃÄÅ]','A');
        textoSustituido = textoSustituido.replaceAll('[ÈÉÊË]','E');
        textoSustituido = textoSustituido.replaceAll('[ÌÍÎÏ]','I');
        textoSustituido = textoSustituido.replaceAll('[ÒÓÔÕÖØ]','O');
        textoSustituido = textoSustituido.replaceAll('[ÙÚÛÜ]','U');
        textoSustituido = textoSustituido.replaceAll('[Ç]','C');
        textoSustituido = textoSustituido.replaceAll('[ÿ]','Y');

        return textoSustituido;
    }

    /* Función para capitalizar las primeras letras de cada palabra del string de entrada */
    public static String capitalizeWords(String input) {
        if (input == null) {
            return input;
        }
        
        String[] words = input.split('\\s+');
        String capitalizedString = '';
        
        for (String word : words) {
            if (word != null) {
                capitalizedString += word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase() + ' ';
            }
        }
        
        return capitalizedString.trim();
    }
    
}