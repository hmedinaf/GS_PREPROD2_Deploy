public class CurpGenerator {
    private static final String X = 'X';
    private static final String RFC_TEMPLATE = '{0}{1}{2}{3}';
    private static final String CURP_TEMPLATE = '{0}{1}{2}{3}{4}{5}';
    private static final String N_TILDE = 'Ñ';
    Person person;
    private String rfc;
    private String preCURP;
    public String CURP;

    public CurpGenerator(Person person){
        this.person = person;
    }

    /**
     * gets the base RFC
     * The RFC has the following format:
     * last name first Letter + last name first consonant +
     * mother maiden name first letter + name first letter +
     * last two digits birth year + birth month + birth day.
     * 
     * @author Juan Ortega Silveira
     * @param person object to store all the data to get the RFC
     * @return  `String`
     */
    public String generateBaseRFC(){
        String lastNameFirstLetter;
        String mmnFirstLetter; //mother maiden name first letter;

        lastNameFirstLetter = getFirstLetter(this.person.getLastName());
        mmnFirstLetter = getFirstLetter(this.person.getMotherMaidenName());
        
        String lnFirstVowel = getFirstVowel(this.person.getLastName().substring(1));

        //removes illegal name if applies
        String name = removeIllegalName(this.person.getName());
        String nameFirstLetter = getFirstLetter(name);

        //concat the obtained letters from the person full name.
        String joinedString = lastNameFirstLetter + lnFirstVowel + 
            mmnFirstLetter + 
            nameFirstLetter;

        if(Constants.INCONVENIENT_WORDS.containsKey(joinedString)){
            joinedString = Constants.INCONVENIENT_WORDS.get(joinedString);
        }

        this.rfc = String.format(RFC_TEMPLATE,
        new List<Object>{
            joinedString,
            String.valueOf(this.person.getBirthYear()).substring(2),
            twoDigitFormat(this.person.getBirthMonth()),
            twoDigitFormat(this.person.getBirthDay())
        });

        //concats the formated result = OESJ + 96 + 01 + 12
        return String.format(RFC_TEMPLATE,
            new List<Object>{
                joinedString,
                String.valueOf(this.person.getBirthYear()).substring(2),
                twoDigitFormat(this.person.getBirthMonth()),
                twoDigitFormat(this.person.getBirthDay())
            }
        );
    }

    public String generateHomoclave(){
        Map <string, string> oPs_ValorHomonimo =  new Map <String, String>();
        oPs_ValorHomonimo.put(' ', '00');
        oPs_ValorHomonimo.put('0', '00');
        oPs_ValorHomonimo.put('1', '01');
        oPs_ValorHomonimo.put('2', '02');
        oPs_ValorHomonimo.put('3', '03');
        oPs_ValorHomonimo.put('4', '04');
        oPs_ValorHomonimo.put('5', '05');
        oPs_ValorHomonimo.put('6', '06');
        oPs_ValorHomonimo.put('7', '07');
        oPs_ValorHomonimo.put('8', '08');
        oPs_ValorHomonimo.put('9', '09');
        oPs_ValorHomonimo.put('&', '10');
        oPs_ValorHomonimo.put('A', '11');
        oPs_ValorHomonimo.put('B', '12');
        oPs_ValorHomonimo.put('C', '13');
        oPs_ValorHomonimo.put('D', '14');
        oPs_ValorHomonimo.put('E', '15');
        oPs_ValorHomonimo.put('F', '16');
        oPs_ValorHomonimo.put('G', '17');
        oPs_ValorHomonimo.put('H', '18');
        oPs_ValorHomonimo.put('I', '19');
        oPs_ValorHomonimo.put('J', '21');
        oPs_ValorHomonimo.put('K', '22');
        oPs_ValorHomonimo.put('L', '23');
        oPs_ValorHomonimo.put('M', '24');
        oPs_ValorHomonimo.put('N', '25');
        oPs_ValorHomonimo.put('O', '26');
        oPs_ValorHomonimo.put('P', '27');
        oPs_ValorHomonimo.put('Q', '28');
        oPs_ValorHomonimo.put('R', '29');
        oPs_ValorHomonimo.put('S', '32');
        oPs_ValorHomonimo.put('T', '33');
        oPs_ValorHomonimo.put('U', '34');
        oPs_ValorHomonimo.put('V', '35');
        oPs_ValorHomonimo.put('W', '36');
        oPs_ValorHomonimo.put('X', '37');
        oPs_ValorHomonimo.put('Y', '38');
        oPs_ValorHomonimo.put('Z', '39');
        oPs_ValorHomonimo.put('Ñ', '40');

        Map <String, String> oPs_ClaveDif = new Map<String,String>();
        oPs_ClaveDif.put('0', '1');
        oPs_ClaveDif.put('1', '2');
        oPs_ClaveDif.put('2', '3');
        oPs_ClaveDif.put('3', '4');
        oPs_ClaveDif.put('4', '5');
        oPs_ClaveDif.put('5', '6');
        oPs_ClaveDif.put('6', '7');
        oPs_ClaveDif.put('7', '8');
        oPs_ClaveDif.put('8', '9');
        oPs_ClaveDif.put('9', 'A');
        oPs_ClaveDif.put('10', 'B');
        oPs_ClaveDif.put('11', 'C');
        oPs_ClaveDif.put('12', 'D');
        oPs_ClaveDif.put('13', 'E');
        oPs_ClaveDif.put('14', 'F');
        oPs_ClaveDif.put('15', 'G');
        oPs_ClaveDif.put('16', 'H');
        oPs_ClaveDif.put('17', 'I');
        oPs_ClaveDif.put('18', 'J');
        oPs_ClaveDif.put('19', 'K');
        oPs_ClaveDif.put('20', 'L');
        oPs_ClaveDif.put('21', 'M');
        oPs_ClaveDif.put('22', 'N');
        oPs_ClaveDif.put('23', 'P');
        oPs_ClaveDif.put('24', 'Q');
        oPs_ClaveDif.put('25', 'R');
        oPs_ClaveDif.put('26', 'S');
        oPs_ClaveDif.put('27', 'T');
        oPs_ClaveDif.put('28', 'U');
        oPs_ClaveDif.put('29', 'V');
        oPs_ClaveDif.put('30', 'W');
        oPs_ClaveDif.put('31', 'X');
        oPs_ClaveDif.put('32', 'Y');
        oPs_ClaveDif.put('33', 'Z');

        Map <String, String> oPs_DigitoVerifica = new Map<String, String>();
        oPs_DigitoVerifica.put('A', '10');
        oPs_DigitoVerifica.put('B', '11');
        oPs_DigitoVerifica.put('C', '12');
        oPs_DigitoVerifica.put('D', '13');
        oPs_DigitoVerifica.put('E', '14');
        oPs_DigitoVerifica.put('F', '15');
        oPs_DigitoVerifica.put('G', '16');
        oPs_DigitoVerifica.put('H', '17');
        oPs_DigitoVerifica.put('I', '18');
        oPs_DigitoVerifica.put('J', '19');
        oPs_DigitoVerifica.put('K', '20');
        oPs_DigitoVerifica.put('L', '21');
        oPs_DigitoVerifica.put('M', '22');
        oPs_DigitoVerifica.put('N', '23');
        oPs_DigitoVerifica.put('O', '25');
        oPs_DigitoVerifica.put('P', '26');
        oPs_DigitoVerifica.put('Q', '27');
        oPs_DigitoVerifica.put('R', '28');
        oPs_DigitoVerifica.put('S', '29');
        oPs_DigitoVerifica.put('T', '30');
        oPs_DigitoVerifica.put('U', '31');
        oPs_DigitoVerifica.put('V', '32');
        oPs_DigitoVerifica.put('W', '33');
        oPs_DigitoVerifica.put('X', '34');
        oPs_DigitoVerifica.put('Y', '35');
        oPs_DigitoVerifica.put('Z', '36');
        oPs_DigitoVerifica.put('0', '0');
        oPs_DigitoVerifica.put('1', '1');
        oPs_DigitoVerifica.put('2', '2');
        oPs_DigitoVerifica.put('3', '3');
        oPs_DigitoVerifica.put('4', '4');
        oPs_DigitoVerifica.put('5', '5');
        oPs_DigitoVerifica.put('6', '6');
        oPs_DigitoVerifica.put('7', '7');
        oPs_DigitoVerifica.put('8', '8');
        oPs_DigitoVerifica.put('9', '9');
        oPs_DigitoVerifica.put(' ', '37');


        /*********************************************************/
        /* Se calculan los primeros 2 caracteres de la homoclave */
        /*********************************************************/
        String Nombre = this.person.getName();
        String Paterno = this.person.getLastName();
        String Materno = this.person.getMotherMaidenName();        
        
        String nombreCuenta = Paterno.toUpperCase() + 
            (String.isBlank(Materno) == false ? ' ' + 
            Materno.toUpperCase() : '') + ' ' + 
            Nombre.toUpperCase();
        // System.debug('*****nombreCuenta:' + nombreCuenta);

        nombreCuenta = nombreCuenta.replace('Á','A');
        nombreCuenta = nombreCuenta.replace('É','E');
        nombreCuenta = nombreCuenta.replace('Í','I');
        nombreCuenta = nombreCuenta.replace('Ó','O');
        nombreCuenta = nombreCuenta.replace('Ú','U');
        nombreCuenta = nombreCuenta.replace('Ü','U');

        Integer i_LongNombre   = nombreCuenta.length();
        // system.debug('*****i_LongNombre:' + i_LongNombre);

        Integer i_LongNumeros  = 0;
        String[] arry_Numeros = new String[i_LongNombre];
        String i_Numeros       = '0';
        Integer i_3Num         = 0;
        String i_divide        = '';
        Integer i_Suma         = 0;
        String i_Suma_String   = '';
        String s_FirstLetter   = '';
        String s_ScdLetter     = '';
        String s_HomoClave     = '';

        try{
            //nombreCuenta = 'DIAZ HERNANDEZ LUIS';
            String[] pNombre = nombreCuenta.split('');
            // system.debug('*****pNombre:' + pNombre);
            for (Integer i = 0; i < i_LongNombre; i++){

                // system.debug('*****pNombre[' + i + ']:' + pNombre[i]);
                String x = pNombre[i];

                // System.debug('*****oPs_ValorHomonimo.get(' + x + '):' + oPs_ValorHomonimo.get(x));             
                arry_Numeros[i]= oPs_ValorHomonimo.get(x);

                // System.debug('*****arry_Numeros:' + arry_Numeros);
            }
            // System.debug('*****arry_Numeros:' + arry_Numeros);

            i_Numeros += String.join(arry_Numeros,'');
            i_LongNumeros = i_Numeros.length();

            // System.debug('*****i_Numeros:' + i_Numeros);
            // System.debug('*****i_LongNumeros:' + i_LongNumeros);

            String[] i_Numeros_Arreglo = i_Numeros.split('');
            for (Integer j = 0; j < i_LongNumeros-1; j++){

                // System.debug('Integer.valueOf(i_Numeros_Arreglo[j]):' + Integer.valueOf(i_Numeros_Arreglo[j]));
                // System.debug('Integer.valueOf(i_Numeros_Arreglo[j+1]):' + Integer.valueOf(i_Numeros_Arreglo[j+1]));
                // System.debug('Integer.valueOf(i_Numeros_Arreglo[j]) + Integer.valueOf(i_Numeros_Arreglo[j+1]):' + (Integer.valueOf(i_Numeros_Arreglo[j]) + Integer.valueOf(i_Numeros_Arreglo[j+1])));
                // System.debug('(Integer.valueOf(i_Numeros_Arreglo[j]) + Integer.valueOf(i_Numeros_Arreglo[j+1])) * Integer.valueOf(i_Numeros_Arreglo[j+1]):' + (Integer.valueOf(i_Numeros_Arreglo[j]) + Integer.valueOf(i_Numeros_Arreglo[j+1])) * Integer.valueOf(i_Numeros_Arreglo[j+1]));

                i_Suma += (Integer.valueOf(i_Numeros_Arreglo[j] + i_Numeros_Arreglo[j+1])) * Integer.valueOf(i_Numeros_Arreglo[j+1]);
            }
            // System.debug('*****i_LongNumeros:' + i_LongNumeros);

            i_Suma_String = String.valueOf(i_Suma);
            i_3Num        = Integer.valueOf(i_Suma_String.substring(i_Suma_String.length() -3));
            //i_divide      = Clib.div(ToNumber(i_3Num), ToNumber(34));
            s_FirstLetter = oPs_ClaveDif.get(String.valueOf(Integer.valueOf(i_3Num / 34)));
            s_ScdLetter   = oPs_ClaveDif.get(String.valueOf(Integer.valueOf(Math.mod(i_3Num,34))));

            // System.debug('*****i_Suma_String:' + i_Suma_String);
            // System.debug('*****i_3Num:' + i_3Num);
            // System.debug('*****s_FirstLetter:' + s_FirstLetter);
            // System.debug('*****s_ScdLetter:' + s_ScdLetter);

            s_HomoClave = s_FirstLetter + s_ScdLetter;
            // System.debug('*****s_HomoClave:' + s_HomoClave);


            /***********************************************************************/
            /* Se calcula el ultimo caracter (digito verificador) de la homoclave  */
            /***********************************************************************/

            String cuentaRFC = this.rfc + s_HomoClave;
            Integer i_LongRFC = cuentaRFC.length();
            String[] arry_Numeros2 = new String[i_LongRFC];
            Integer i_Suma2 = 0;
            Integer i_Rem = 0;
            String s_DigitoVer = '';

            String[] pRFC = cuentaRFC.split('');
            String x = '';
            
            for(Integer i = 0; i < i_LongRFC; i++){

                x = pRFC[i];
                arry_Numeros2[i] = oPs_DigitoVerifica.get(x);
                i_Suma2 += Integer.valueOf(oPs_DigitoVerifica.get(x)) * ((i_LongRFC + 1) - i);
            }

            i_Rem = Math.mod(i_Suma2,11);

            if(i_Rem == 0){
                s_DigitoVer = '0';
            }
            else if(i_Rem > 0){

                s_DigitoVer = String.valueOf(11 - i_Rem);

                if (s_DigitoVer == '10'){
                    s_DigitoVer = 'A';
                }
            }
            // System.debug('*****s_DigitoVer:' + s_DigitoVer);

            s_HomoClave = s_HomoClave + s_DigitoVer;
        }
        catch(Exception e){
            // System.debug('*****ERROR AL GENERAR LA HOMOCLAVE:' + e.getMessage());
        }

        return s_HomoClave;
    }

    /**
     * gets the person CURP
     * 
     * The curp has the following format:
     * RFC + (H/M) + state Code + last name first consonant but first letter+
     * mother maiden name first consonant but first letter +
     * name first consonant but first letter.
     * @author Juan Ortega Silveira 
     * @param person 
     * @return  `String`
     */
    public String generateCurp(){

        this.rfc = this.rfc != null ? this.rfc : generateBaseRFC();
        String stateCode = Constants.STATE_CODE_BY_STATE_NAME.get(this.person.getBirthPlace());

        //gets mother maiden name and last name first consonant but first letter;
        String lnFirstConsonant = getFirstConsonant(this.person.getLastName().substring(1));
        String mmnFirstConsonant = getFirstConsonant(this.person.getMotherMaidenName().substring(1));

        //gets name first consonant but first letter
        String name = removeIllegalName(this.person.getName());
        String nameFirstConsonant = getFirstConsonant(name.substring(1));

        this.preCURP = String.format(CURP_TEMPLATE,
            new List<Object>{
                rfc,
                this.person.getGenderCode(),
                stateCode,
                lnFirstConsonant,
                mmnFirstConsonant,
                nameFirstConsonant
            });

        String digitoVer = generacionDigitoVerCurp();
        // System.debug ('**** digitoVer: '+digitoVer);

        String diferenciador;
        
        if (this.person.getBirthYear() != null) {
            diferenciador = this.person.getBirthYear() < 2000 ? '0' : 'A';
        }

        this.CURP = this.preCURP + diferenciador + digitoVer;

        return this.CURP;
        // String.format(CURP_TEMPLATE,
        //     new List<Object>{
        //         rfc,
        //         this.person.getGenderCode(),
        //         stateCode,
        //         lnFirstConsonant,
        //         mmnFirstConsonant,
        //         nameFirstConsonant
        //     });
    }

    public String generacionDigitoVerCurp() {
        //     Calcula el codigo verificador en base a la pre CURP.
        // </summary>
        // <param name="preCURP"> La pre CURP.</param>
        // <returns> El código verificador.</returns>
        // <exception cref="ArgumentException"> Cuando alguno de los caracteres de la pre CURP no es válido.</exception>
        // integer contador = 18;
        integer sumatoria = 0;

        String caracteres = '0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';

        String preCURP = this.preCURP;

        // System.debug('*** preCURP: '+preCURP);
        Integer CURPlen = 16;
        Integer contador = 18;

        if (preCURP.length() < 16) {
            return '0';
        }
        
        for (Integer i = 0; i < CURPlen; i++) {
            String caracter = preCURP.substring(i, i+1);
            Integer index = caracteres.indexOf(caracter);
            
            if (index == -1) {
                system.debug ('*** Error en cálculo de CURP');
            }
            
            Integer valor = index * contador;
            contador--;
            sumatoria += valor;
        }

        // 12.- 2do digito verificador
        Integer numVer = Math.Mod(sumatoria, 10);
        numVer = 10 - numVer;
        numVer = numVer == 10 ? 0 : numVer;
        //system.debug('*** CURP numVer: '+numVer);
        return String.ValueOf(numVer);
    }

    /**
     * appends 0 to the start if the number is <= 9
     * @param digit 
     * @return  `String`
     */
    private String twoDigitFormat(Integer digit){
        return digit <= 9 ? '0' + digit : String.valueOf(digit);
    }

    /**
     * gets the string first letter or 'X' if the first letter is an invalid char.
     * @author Juan Ortega Silveira
     * @param input String to get the first letter from
     * @return `String`
     */
    private String getFirstLetter(String input){
        String firstLetter = input.substring(0,1);

        return Constants.SIGNOS_ENE.contains(firstLetter) ? 
            X : firstLetter;
    }

    /**
     * gets the string first vowel or 'X' if the first match is an invalid char.
     * @author Juan Ortega Silveira
     * @param input 
     * @return  `String`
     */
    private String getFirstVowel(String input){
        List<String> inputSplit = input.split('');

        for(String s : inputSplit){
            if(Constants.VOWEL_SET.contains(s)){
                return s;
            }else if(Constants.SPECIAL_SIGN_SET.contains(s)){
                return X;
            }
        }

        return X;
    }

    /**
     * gets the string first consonant of 'X' if the first match is an invalid char
     * or if there is no consonant in the input.
     * @author Juan Ortega Silveira
     * @param input 
     * @return  `String`
     */
    private String getFirstConsonant(String input){
        List<String> inputSplit = input.split('');

        for(String s : inputSplit){
            if(!Constants.VOWEL_SET.contains(s) && !Constants.SIGNOS_ENE.contains(s)){
                return s;
            }else if(s == N_TILDE){
                return X;
            }
        }

        return X;
    }

    /**
     * remove the first name if it is an illegal one.
     * @param name 
     * @return  `String`
     */
    private String removeIllegalName(String name){
        if(name.contains(' ')){
            List<String> nameSplit = name.split(' ');
            
            if(Constants.ILLEGAL_NAME_SET.contains(nameSplit[0])){
                nameSplit.remove(0);
                
                return String.join(nameSplit,'');
            }
        }

        return name;
    }

}