public with sharing class ReferenciaDePago {
    
    private static final list<Integer> multiplicador = new list<Integer>{23, 19, 17, 13, 11, 23, 19, 17, 13, 11, 23, 19, 17, 13, 11};
    private static Integer suma = 0;
    private static Integer remainder = 0;
    private static final Integer base333 = 333;
    private static final Integer modulo97 = 97;
    
    public static String generarReferencia(String numero){

        String regex = '[a-zA-Z]{1,}|\\-';
        numero = numero.replaceAll(regex, '');
        numero = numero.remove(' ');

        Integer digitos = 15-numero.length();
        For(Integer i = 0; i < digitos; i++){
            numero = '0' + numero;
        }
        For(Integer i = 0; i < 15; i++){
            suma += Integer.ValueOf(numero.substring(i, i+1)) * multiplicador[i];
        }
        system.debug(suma);
        suma += base333;
        remainder = Math.mod(suma,modulo97) + 1;
        if(remainder<10){
            return (numero+'0'+remainder);
        }
        else{
            return (numero+remainder);
        }
    }
}