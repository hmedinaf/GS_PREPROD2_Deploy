public with sharing class Numero_a_Letra {

    private static final list<String> UNIDADES = new list<String>{'', 'un ', 'dos ', 'tres ', 'cuatro ', 'cinco ', 'seis ', 'siete ', 'ocho ', 'nueve '};
    private static final list<String> DECENAS = new list<String>{'diez ', 'once ', 'doce ', 'trece ', 'catorce ', 'quince ', 'dieciseis ',
        'diecisiete ', 'dieciocho ', 'diecinueve ', 'veinte ', 'treinta ', 'cuarenta ',
        'cincuenta ', 'sesenta ', 'setenta ', 'ochenta ', 'noventa '};
    private static final list<String> CENTENAS = new list<String>{'', 'ciento ', 'doscientos ', 'trecientos ', 'cuatrocientos ', 'quinientos ', 'seiscientos ',
        'setecientos ', 'ochocientos ', 'novecientos '};

    public static String convertir(Decimal n){

        String numero = String.ValueOf(n);
        String literal = '';
        String parte_decimal = '';
        String r = '';
        //remplazar (.) por (,)
        numero = numero.replace('.', ',');
        
        //si el numero no tiene parte decimal, se le agrega (,00)
        if (numero.indexOf(',') == -1) {
            numero = numero + ',00';
        }

        //se valida formato de entrada -> Entre 0,00 y 999 999 999,00
        if (Pattern.matches('\\d{1,9},\\d{1,2}', numero)) {

            //se divide el numero 0000000,00 -> entero y decimal
            list<String> nums = numero.split(',');
            
            //formato a parte decimal
            parte_decimal = nums[1];
            if(parte_decimal.length() == 1){
                parte_decimal += '0/100 M.N.';
            }
            else{
                parte_decimal = nums[1] + '/100 M.N.';
            }

            //se convierte el numero a literal
            if (Integer.ValueOf(nums[0]) == 0) {//si el valor es cero
                literal = 'cero ';
            } else if (Integer.ValueOf(nums[0]) > 999999) {//si es millon
                literal = getMillones(nums[0]);
            } else if (Integer.ValueOf(nums[0]) > 999) {//si es miles
                literal = getMiles(nums[0]);
            } else if (Integer.ValueOf(nums[0]) > 99) {//si es centena
                literal = getCentenas(nums[0]);
            } else if (Integer.ValueOf(nums[0]) > 9) {//si es decena
                literal = getDecenas(nums[0]);
            } else {//sino unidades -> 1-9
                literal = getUnidades(nums[0]);
            }


            literal = literal.toUpperCase();
            r = ' (' + literal + 'PESOS ' + parte_decimal + '),';
        }
        return r;
    }

    private static String getUnidades(String numero) {// 1 - 9
        //si tuviera algun 0 antes se lo quita -> 09 = 9 o 009=9
        String num = numero.substring(numero.length() - 1);
        return UNIDADES[Integer.ValueOf(num)];
    }

    private static String getDecenas(String num) {// 99 
        integer n = Integer.ValueOf(num);
        if (n < 10) {//para casos como -> 01 - 09 
            return getUnidades(num); 
        } else if (n > 19) {//para 20...99 
            String u = getUnidades(num);
            if (u.equals('')) { //para 20,30,40,50,60,70,80,90 '
                return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8]; 
            } else { 
                if(n == 21) {
                    return DECENAS[Integer.valueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 22) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 23) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 24) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 25) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 26) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 27) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 28) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } if(n == 29) {
                    return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8].substring(0,5) + 'i' + u;
                } 
                return DECENAS[Integer.ValueOf(num.substring(0, 1)) + 8] + 'y ' + u; } 
            } else {//numeros entre 11 y 19 
                return DECENAS[n - 10]; 
            }
        }

    private static String getCentenas(String num) {// 999 o 099
        if (Integer.ValueOf(num) > 99) {//es centena
            if (Integer.ValueOf(num) == 100) {//caso especial
                return 'cien ';
            } else {
                return CENTENAS[Integer.ValueOf(num.substring(0, 1))] + getDecenas(num.substring(1));
            }
        } else {//por Ej. 099 
            //se quita el 0 antes de convertir a decenas
            return getDecenas(Integer.ValueOf(num) + '');
        }
    }

    private static String getMiles(String numero) {// 999 999
        //obtiene las centenas
        String c = numero.substring(numero.length() - 3);
        //obtiene los miles
        String m = numero.substring(0, numero.length() - 3);
        String n = '';
        //se comprueba que miles tenga valor entero
        if (Integer.ValueOf(m) > 0) {
            if(Integer.ValueOf(m) == 1){
                return 'mil ' + getCentenas(c);
            }else{
                n = getCentenas(m);
                return n + 'mil ' + getCentenas(c);
            }
        } else {
            return '' + getCentenas(c);
        }

    }

    private static String getMillones(String numero) { //000 000 000        
        //se obtiene los miles
        String miles = numero.substring(numero.length() - 6);
        //se obtiene los millones
        String millon = numero.substring(0, numero.length() - 6);
        String n = '';
        if (Integer.ValueOf(millon) > 1) {
            n = getCentenas(millon) + 'millones ';
        } else {
            n = getUnidades(millon) + 'millon ';
        }
        return n + getMiles(miles);
    }
}