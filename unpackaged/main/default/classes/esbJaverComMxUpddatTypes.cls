//Generated by wsdl2apex

public class esbJaverComMxUpddatTypes {
    public class UpdDatosEntregaRs_element {
        public esbJaverComMxUpddatTypes.Result_element Result;
        private String[] Result_type_info = new String[]{'Result','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types','true','false'};
        private String[] field_order_type_info = new String[]{'Result'};
    }
    public class UpdDatosEntregaRq_element {
        public String NumeroProceso;
        public String FechaHabitibilidad;
        public String Estatus;
        public String FechaEntrega;
        public Long TelefonoCasa;
        public Long TelefonoCelular;
        public Long TelefonoOtro;
        public Decimal TelefonoRecado;
        public String Correo;
        public Long NumeroCliente;
        private String[] NumeroProceso_type_info = new String[]{'NumeroProceso','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] FechaHabitibilidad_type_info = new String[]{'FechaHabitibilidad','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] Estatus_type_info = new String[]{'Estatus','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] FechaEntrega_type_info = new String[]{'FechaEntrega','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] TelefonoCasa_type_info = new String[]{'TelefonoCasa','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] TelefonoCelular_type_info = new String[]{'TelefonoCelular','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] TelefonoOtro_type_info = new String[]{'TelefonoOtro','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] TelefonoRecado_type_info = new String[]{'TelefonoRecado','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] Correo_type_info = new String[]{'Correo','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] NumeroCliente_type_info = new String[]{'NumeroCliente','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types','true','false'};
        private String[] field_order_type_info = new String[]{'NumeroProceso','FechaHabitibilidad','Estatus','FechaEntrega','TelefonoCasa','TelefonoCelular','TelefonoOtro','TelefonoRecado','Correo','NumeroCliente'};
    }
    public class Result_element {
        public Boolean Estatus;
        public String Message;
        private String[] Estatus_type_info = new String[]{'Estatus','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'1','1','false'};
        private String[] Message_type_info = new String[]{'Message','http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://esb.javer.com.mx/AtencionClientes/UpdDatosEntrega/types','true','false'};
        private String[] field_order_type_info = new String[]{'Success','SysMessage'};
    }
}