//Generated by wsdl2apex

public class esbJaverComMxAtencionclientesInvviv {
    public class Result_element {
        public Boolean Success;
        public String SysMessage;
        private String[] Success_type_info = new String[]{'Success','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] SysMessage_type_info = new String[]{'SysMessage','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types','true','false'};
        private String[] field_order_type_info = new String[]{'Success','SysMessage'};
    }
    public class GetInvViviendaRs_element {
        public esbJaverComMxAtencionclientesInvviv.Result_element Result;
        public esbJaverComMxAtencionclientesInvviv.ReporteInvVivienda_element ReporteInvVivienda;
        private String[] Result_type_info = new String[]{'Result','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] ReporteInvVivienda_type_info = new String[]{'ReporteInvVivienda','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types','true','false'};
        private String[] field_order_type_info = new String[]{'Result','ReporteInvVivienda'};
    }
    public class GetInvViviendaRq_element {
        public String NumDias;
        private String[] NumDias_type_info = new String[]{'NumDias','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types','true','false'};
        private String[] field_order_type_info = new String[]{'NumDias'};
    }
    public class Row_element {
        public String IdVivienda;
        public String Fraccionamiento;
        public String Prototipo;
        public String NumInterno;
        public String NunInterior;
        public String IdManzana;
        public String Manzana;
        public String IdLote;
        public String Lote;
        public String Sector;
        public String UnidadPrivativa;
        public String Condominio;
        public String Dtu;
        public String DireccionOficial;
        public String Frente;
        public String Seccion;
        public String Conjunto;
        public String Concepto;
        private String[] IdVivienda_type_info = new String[]{'IdVivienda','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Fraccionamiento_type_info = new String[]{'Fraccionamiento','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Prototipo_type_info = new String[]{'Prototipo','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] NumInterno_type_info = new String[]{'NumInterno','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] NunInterior_type_info = new String[]{'NunInterior','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] IdManzana_type_info = new String[]{'IdManzana','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Manzana_type_info = new String[]{'Manzana','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] IdLote_type_info = new String[]{'IdLote','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Lote_type_info = new String[]{'Lote','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Sector_type_info = new String[]{'Sector','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] UnidadPrivativa_type_info = new String[]{'UnidadPrivativa','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Condominio_type_info = new String[]{'Condominio','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Dtu_type_info = new String[]{'Dtu','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] DireccionOficial_type_info = new String[]{'DireccionOficial','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Frente_type_info = new String[]{'Frente','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Seccion_type_info = new String[]{'Seccion','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Conjunto_type_info = new String[]{'Conjunto','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] Concepto_type_info = new String[]{'Concepto','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types','true','false'};
        private String[] field_order_type_info = new String[]{'IdVivienda','Fraccionamiento','Prototipo','NumInterno','NunInterior','IdManzana','Manzana','IdLote','Lote','Sector','UnidadPrivativa','Condominio','Dtu','DireccionOficial','Frente','Seccion','Conjunto','Concepto'};
    }
    public class ReporteInvVivienda_element {
        public esbJaverComMxAtencionclientesInvviv.Row_element[] Row;
        public Long ItemQuantity;
        private String[] Row_type_info = new String[]{'Row','http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',null,'0','-1','false'};
        private String[] ItemQuantity_att_info = new String[]{'ItemQuantity'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types','true','false'};
        private String[] field_order_type_info = new String[]{'Row'};
    }
    public class InvViviendaBindingQSPort {
        public String endpoint_x = 'https://esb.javer.com.mx:11902/AtencionClientes/ProxyServices/InvViviendaProxy';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types', 'esbJaverComMxAtencionclientesInvviv', 'http://esb.javer.com.mx/AtencionClientes/InvVivienda', 'esbJaverComMxAtencionclientesInvviv'};
        public esbJaverComMxAtencionclientesInvviv.GetInvViviendaRs_element GetInvVivienda(String NumDias) {
            esbJaverComMxAtencionclientesInvviv.GetInvViviendaRq_element request_x = new esbJaverComMxAtencionclientesInvviv.GetInvViviendaRq_element();
            request_x.NumDias = NumDias;
            esbJaverComMxAtencionclientesInvviv.GetInvViviendaRs_element response_x;
            Map<String, esbJaverComMxAtencionclientesInvviv.GetInvViviendaRs_element> response_map_x = new Map<String, esbJaverComMxAtencionclientesInvviv.GetInvViviendaRs_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'GetInvVivienda',
              'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',
              'GetInvViviendaRq',
              'http://esb.javer.com.mx/AtencionClientes/InvVivienda/types',
              'GetInvViviendaRs',
              'esbJaverComMxAtencionclientesInvviv.GetInvViviendaRs_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
    }
    public void method(){
        Integer i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
    }
    
}