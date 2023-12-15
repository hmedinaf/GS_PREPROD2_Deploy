public with sharing class CONTROL_FormatoPagarePreventaPdfAux {
    
    public string numero {get; set;}
    public decimal importe {get; set;}
    public string fecha {get; set;}

    
    public CONTROL_FormatoPagarePreventaPdfAux(string n, decimal i, string f) {
        numero = n;
        importe = i;
        fecha = f;
    }
}