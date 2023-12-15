public with sharing class CurpController{
    public PageReference redirect() {
        return new PageReference('https://consultas.curp.gob.mx/CurpSP/inicio2_2.jsp');
    }
}