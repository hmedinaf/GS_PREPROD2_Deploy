global with sharing class Javer_ShPn_Util {
    /****************************************************************************** 
        Constantes
    */

    /****************************************************************************** 
        Variables
    */
    public static Id archivoXMLIdParent {get; set;}
    
    public static integer contador_ApprovalData  {get; set;}
    public static integer contador_record  {get; set;}
    public static integer contador_field  {get; set;}
    
    public static Map<Id,list<ApprovalDataSP__c>>  map_id_listApprovalData;
    public static Map<Integer,list<recordSP__c>> map_intNumLista_listrecord {get; set;}
    public static Map<Integer,list<fieldSP__c>> map_intNumLista_listfield {get; set;}
    
    
  
    
    /******************************************************************************
        Subclases:
    */
    public class Datos {
        public String idFlujo {get; set;}
        
        
        public String TipoXML {get; set;}
        public String NoDocumento {get; set;}
        public String Area {get; set;}
        public String Listas {get; set;}
        
        public String ApoderadoLegal  {get; set;}
        public String ApSatic  {get; set;}
        
        public String Accion  {get; set;}
        public String approverEmpId  {get; set;}
        
        
        public String Categoria  {get; set;}
        public String CentroCosto  {get; set;}
        public String Ciudad  {get; set;}
        public String Comentario  {get; set;}
        public String Comentarios  {get; set;}
        public String CompaniasKontrol  {get; set;}
        public String Concepto  {get; set;}
        public String Conjunto  {get; set;}
        public String Consecutivo  {get; set;}
        public String ContactoVendedor  {get; set;}
        public String Contratante  {get; set;}
        public String Contratista  {get; set;}
        public String ContratoTipo  {get; set;}
        
        public String Creado  {get; set;}
        public String CreadoPor  {get; set;}
        
        
        public String Descripcion  {get; set;}
        public String Direccion  {get; set;}
        public String Estado  {get; set;}
        public String Estatus  {get; set;}
        public String EstatusSolicitud  {get; set;}
        public String FechaFirmaContrato  {get; set;}
        public String FechaInicioObra  {get; set;}
        public String FechaTerminoObra  {get; set;}
        public String Fianza  {get; set;}
        public String FondoGarantiaDias  {get; set;}
        public String FondoGarantiaPorciento  {get; set;}
        public String Fraccionamiento  {get; set;}
        public String ImporteAccesorios  {get; set;}
        public String ImporteAnticipo  {get; set;}
        public String ImporteContrato  {get; set;}
        public String ImporteMolde  {get; set;}
        public String LineaProductos  {get; set;}
        public String No  {get; set;}
        public String Nombre  {get; set;}
        public String NombreJefe  {get; set;}
        public String NomRepLegal  {get; set;}
        public String Numero  {get; set;}
        public String Obraoadmin  {get; set;}
        public String platform  {get; set;}
        public String RazonSocialNombre  {get; set;}
        public String Rfc  {get; set;}
        public String Stati  {get; set;}
        public String SubCategoria  {get; set;}
        public String Suministro  {get; set;}
        public String Suplente  {get; set;}
        public String testigo_1  {get; set;}
        public String testigo_2  {get; set;}
        public String testigo_3  {get; set;}
        
        public String TipoContrato  {get; set;}
        public String TipoInsumo  {get; set;}
        public String TipoProveedor  {get; set;}
        public String Tramite  {get; set;}
        public String UEN  {get; set;}
        public String UnidadMedida  {get; set;}
        public String Usuario  {get; set;}
        public String UsuarioJefeInmediato  {get; set;}
        

        
        
        public String listOfApprovalData {get; set;}
        
        
        
        public CadenaXML cadenaXML {get; set;}
        public String token {get; set;}
        public String action {get; set;}
        public String src {get; set;}
      
      // Constructor
      public Datos() {
        idFlujo = '';
        
        TipoXML='';
        NoDocumento='';
        Area = '';
        Listas = '';
        
        ApoderadoLegal = '';
        ApSatic = '';
        Accion = '';
        approverEmpId = '';
        
        Categoria = '';
        CentroCosto = '';
        Ciudad = '';
        Comentario = '';
        Comentarios = '';
        CompaniasKontrol = '';
        Concepto = '';
        Conjunto = '';
        Consecutivo = '';
        ContactoVendedor = '';
        Contratante = '';
        Contratista = '';
        ContratoTipo = '';
        Creado = '';
        
        CreadoPor = '';
        Descripcion = '';
        Direccion = '';
        Estado = '';
        Estatus = '';
        EstatusSolicitud = '';
        FechaFirmaContrato = '';
        FechaInicioObra = '';
        FechaTerminoObra = '';
        Fianza = '';
        FondoGarantiaDias = '';
        FondoGarantiaPorciento = '';
        Fraccionamiento = '';
        ImporteAccesorios = '';
        ImporteAnticipo = '';
        ImporteContrato = '';
        ImporteMolde = '';
        LineaProductos = '';
        No = '';
        Nombre = '';
        NombreJefe = '';
        NomRepLegal = '';
        Numero = '';
        Obraoadmin = '';
        platform = '';
        RazonSocialNombre = '';
        Rfc = '';
        Stati = '';
        SubCategoria = '';
        Suministro = '';
        Suplente = '';
        testigo_1 = '';
        testigo_2 = '';
        testigo_3 = '';
        TipoContrato = '';
        TipoInsumo = '';
        TipoProveedor = '';
        Tramite = '';
        UEN = '';
        UnidadMedida = '';
        Usuario = '';
        UsuarioJefeInmediato = '';

      listOfApprovalData = '';
      
      token = '';
      action  = '';
      src  = '';
      cadenaXML = new CadenaXML();
      }  
    }
    
    public class CadenaXML {
      public DatosSiebel datosSiebel {get; set;}
      
      // Contructor
      public CadenaXML() {
        datosSiebel = new DatosSiebel();
      }
    }
    
    public class DatosSiebel {
      //public List<Proceso__c> listaSiebelProcesos {get; set;}
      public List<SharePointObj__c> listaSiebelProcesos {get; set;}
      public ApprovalDataClass approvalDataClass {get; set;}
      
      // Constructor
      public DatosSiebel() {
        listaSiebelProcesos = new List<SharePointObj__c>();
        approvalDataClass = new ApprovalDataClass();
      }
    }
    
    public class ApprovalDataClass {
      public List<ApprovalDataSP__c> listaApprovalData {get; set;}
      public RecordClass recordClass {get; set;}
      
      // Constructor
      public ApprovalDataClass() {
        listaApprovalData = new List<ApprovalDataSP__c>();
        recordClass = new RecordClass();
      }
    }
    
    public class RecordClass {
      public List<recordSP__c> listarecord {get; set;}
      public FieldClass fieldClass {get; set;}
      
      // Constructor
      public RecordClass() {
        listarecord = new List<recordSP__c>();
        fieldClass = new FieldClass();
      }
    }
    
    public class FieldClass {
      public List<fieldSP__c> listafield {get; set;}
      // Constructor
      public FieldClass() {
        listafield = new List<fieldSP__c>();
      }
    }
  
  
  public Javer_ShPn_Util(){
      //datos = new Datos();
      
  }  
    
  
  
  
  /******************************************************************************
        Método descargaParseXML
    */
    public static void descargaParseXMLSP(XmlStreamReader reader) {
        Id idDatoSiebel;
        contador_ApprovalData=0;
        contador_record=0;
        contador_field=0;
        
        Datos datos = new Datos();
        map_id_listApprovalData = new Map<Id,list<ApprovalDataSP__c>>();
        map_intNumLista_listrecord = new Map<Integer,list<recordSP__c>>();
        map_intNumLista_listfield = new Map<Integer,list<fieldSP__c>>();
        XmlStreamReader reader_AppData = reader;
        Map<Integer, Id> map_intNmListaAppData_idAppData = new Map<Integer, Id>();
        Map<Integer, Id> map_intNmListaRecord_idRecord = new Map<Integer, Id>();
        SharePointObj__c shrPntObject_Encabezado = new SharePointObj__c();
        while(reader.hasNext()) {
                // Buscamos el Start Element de variables encabezado
            if(reader.getEventType() == XmlTag.START_ELEMENT) {
                  
                  
                  if(reader.getLocalName() == 'Platform') {
                        shrPntObject_Encabezado.platform__c = datos.platform = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'TipoXML') {
                        shrPntObject_Encabezado.TipoXML__c = datos.TipoXML = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'NoDocumento') {
                        shrPntObject_Encabezado.NoDocumento__c = shrPntObject_Encabezado.Name = datos.NoDocumento = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'Aprobador') {
                        shrPntObject_Encabezado.approverEmpId__c = datos.approverEmpId = obtenerValor(reader);    
                    } else if(reader.getLocalName() == 'EstatusSolicitud') {
                        shrPntObject_Encabezado.EstatusSolicitud__c = datos.EstatusSolicitud = obtenerValor(reader);  
                    } 
                        
                        else if(reader.getLocalName() == 'NomRepLegal') {
                        shrPntObject_Encabezado.NomRepLegal__c = datos.NomRepLegal = obtenerValor(reader);    
                    } else if(reader.getLocalName() == 'Direccion') {
                        shrPntObject_Encabezado.Direccion__c = datos.Direccion = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'Ciudad') {
                        shrPntObject_Encabezado.Ciudad__c = datos.Ciudad = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'Estado') {
                        shrPntObject_Encabezado.Estado__c = datos.Estado = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'Numero') {
                        shrPntObject_Encabezado.Numero__c = datos.Numero = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'ContactoVendedor') {
                        shrPntObject_Encabezado.ContactoVendedor__c = datos.ContactoVendedor = obtenerValor(reader);
                    } else if(reader.getLocalName() == 'Tramite') {
                        shrPntObject_Encabezado.Tramite__c = datos.Tramite = obtenerValor(reader);
                    }
                
                
                
                        else if(reader.getLocalName() == 'TipoProveedor') {
                        shrPntObject_Encabezado.TipoProveedor__c = datos.TipoProveedor = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Rfc') {
                        shrPntObject_Encabezado.Rfc__c = datos.Rfc = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'RazonSocialNombre') {
                        shrPntObject_Encabezado.RazonSocialNombre__c = datos.RazonSocialNombre = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'CompaniasKontrol') {
                        shrPntObject_Encabezado.CompaniasKontrol__c = datos.CompaniasKontrol = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'LineaProductos') {
                        shrPntObject_Encabezado.LineaProductos__c = datos.LineaProductos = obtenerValor(reader);
                    }
                
                        else if(reader.getLocalName() == 'estatus') {
                        shrPntObject_Encabezado.estatus__c = datos.estatus = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'centroCosto') {
                        shrPntObject_Encabezado.CentroCosto__c = datos.CentroCosto = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'contratante') {
                        shrPntObject_Encabezado.Contratante__c = datos.Contratante = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'fraccionamiento') {
                        shrPntObject_Encabezado.Fraccionamiento__c = datos.Fraccionamiento = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'tipoContrato') {
                        shrPntObject_Encabezado.TipoContrato__c = datos.TipoContrato = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'ContratoTipo') {
                        shrPntObject_Encabezado.ContratoTipo__c = datos.ContratoTipo = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'concepto') {
                        shrPntObject_Encabezado.Concepto__c = datos.Concepto = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'descripcion') {
                        shrPntObject_Encabezado.Descripcion__c = datos.Descripcion = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'contratista') {
                        shrPntObject_Encabezado.Contratista__c = datos.Contratista = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'fechaFirmaContrato') {
                        shrPntObject_Encabezado.FechaFirmaContrato__c = datos.FechaFirmaContrato = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'fechaInicioObra') {
                        shrPntObject_Encabezado.FechaInicioObra__c = datos.FechaInicioObra = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'fechaTerminoObra') {
                        shrPntObject_Encabezado.FechaTerminoObra__c = datos.FechaTerminoObra = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'fondoGarantiaDias') {
                        shrPntObject_Encabezado.FondoGarantiaDias__c = datos.FondoGarantiaDias = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'fondoGarantiaPorciento') {
                        shrPntObject_Encabezado.FondoGarantiaPorciento__c = datos.FondoGarantiaPorciento = obtenerValor(reader);
                    }
                
                        else if(reader.getLocalName() == 'importeAccesorios') {
                        shrPntObject_Encabezado.ImporteAccesorios__c = datos.ImporteAccesorios = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'importeAnticipo') {
                        shrPntObject_Encabezado.ImporteAnticipo__c = datos.ImporteAnticipo = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'importeMolde') {
                        shrPntObject_Encabezado.ImporteMolde__c = datos.ImporteMolde = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'importeContrato') {
                        shrPntObject_Encabezado.ImporteContrato__c = datos.ImporteContrato = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'ApSatic') {
                        shrPntObject_Encabezado.ApSatic__c = datos.ApSatic = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'suministro') {
                        shrPntObject_Encabezado.Suministro__c = datos.Suministro = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'ApFianza') {
                        shrPntObject_Encabezado.Fianza__c = datos.Fianza = obtenerValor(reader);    
                    }
                
                
                        else if(reader.getLocalName() == 'testigo_1') {
                        shrPntObject_Encabezado.testigo_1__c = datos.testigo_1 = obtenerValor(reader);    
                    }   else if(reader.getLocalName() == 'testigo_2') {
                        shrPntObject_Encabezado.testigo_2__c = datos.testigo_2 = obtenerValor(reader);    
                    }   else if(reader.getLocalName() == 'testigo_3') {
                        shrPntObject_Encabezado.testigo_3__c = datos.testigo_3 = obtenerValor(reader);    
                    }   else if(reader.getLocalName() == 'Conjunto') {
                        shrPntObject_Encabezado.Conjunto__c = datos.Conjunto = obtenerValor(reader);
                    }   
                
                        else if(reader.getLocalName() == 'Static') {
                        shrPntObject_Encabezado.Static__c = datos.Stati = obtenerValor(reader);
                    }
                
                    
                        else if(reader.getLocalName() == 'Obraoadmin') {
                        shrPntObject_Encabezado.Obraoadmin__c = datos.Obraoadmin = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'TipoInsumo') {
                        shrPntObject_Encabezado.TipoInsumo__c = datos.TipoInsumo = obtenerValor(reader);
                    }
                
                        else if(reader.getLocalName() == 'Comentarios') {
                        shrPntObject_Encabezado.Comentarios__c = datos.Comentarios = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Creado') {
                        shrPntObject_Encabezado.Creado__c = datos.Creado = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'CreadoPor') {
                        shrPntObject_Encabezado.CreadoPor__c = datos.CreadoPor = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Nombre') {
                        shrPntObject_Encabezado.Nombre__c = shrPntObject_Encabezado.Nombre__c = datos.Nombre = obtenerValor(reader);                                
                    }   else if(reader.getLocalName() == 'NombreJefe') {
                        shrPntObject_Encabezado.NombreJefe__c = datos.NombreJefe = obtenerValor(reader);  
                    }   else if(reader.getLocalName() == 'UsuarioJefeInmediato') {
                        shrPntObject_Encabezado.UsuarioJefeInmediato__c = datos.UsuarioJefeInmediato = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Uen') {
                        shrPntObject_Encabezado.UEN__c = datos.UEN = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Area') {
                        shrPntObject_Encabezado.Area__c = datos.Area = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Accion') {
                        shrPntObject_Encabezado.Accion__c = datos.Accion = obtenerValor(reader);
                    } 
                
                
                
                        
                        else if(reader.getLocalName() == 'ApoderadoLegal') {
                        shrPntObject_Encabezado.ApoderadoLegal__c = datos.ApoderadoLegal = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Categoria') {
                        shrPntObject_Encabezado.Categoria__c = datos.Categoria = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Comentario') {
                        shrPntObject_Encabezado.Comentario__c = datos.Comentario = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Consecutivo') {
                        shrPntObject_Encabezado.Consecutivo__c = datos.Consecutivo = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'No') {
                        shrPntObject_Encabezado.No__c = datos.No = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'SubCategoria') {
                        shrPntObject_Encabezado.SubCategoria__c = datos.SubCategoria = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Suplente') {
                        shrPntObject_Encabezado.Suplente__c = datos.Suplente = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'UnidadMedida') {
                        shrPntObject_Encabezado.UnidadMedida__c = datos.UnidadMedida = obtenerValor(reader);
                    }   else if(reader.getLocalName() == 'Usuario') {
                        shrPntObject_Encabezado.Usuario__c = datos.Usuario = obtenerValor(reader);
                    }
                        
                        else if(reader.getLocalName() == 'Listas') {
                        shrPntObject_Encabezado.Listas__c = datos.Listas = obtenerValor(reader);
                    }
                    
                  
                  if (shrPntObject_Encabezado.Listas__c!=''){
                      //System.Debug('***shrPntObject_Encabezado 0*** '+ shrPntObject_Encabezado);
                      if (datos.cadenaXML.datosSiebel.listaSiebelProcesos.size() == 0 ){
                          datos.cadenaXML.datosSiebel.listaSiebelProcesos.add(shrPntObject_Encabezado);
                          try{ //System.Debug('***datos.cadenaXML.datosSiebel.listaSiebelProcesos 0*** '+ datos.cadenaXML.datosSiebel.listaSiebelProcesos);
                                insert datos.cadenaXML.datosSiebel.listaSiebelProcesos;
                                idDatoSiebel = datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id;
                           } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.insert(newCatch,false);
                          } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
                          } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
                          } //catch
                      } else {
                        //System.Debug('***shrPntObject_Encabezado else*** '+ shrPntObject_Encabezado);
                        try{
                                update shrPntObject_Encabezado;
                           } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.insert(newCatch,false);
                          } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
                          } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
                          } //catch
                      }
                      
                  }
                  if(reader.getLocalName() == 'ApprovalData' && datos.cadenaXML.datosSiebel.listaSiebelProcesos.size()==1) {
                      //System.Debug('***reader*** '+ reader);
                      
                      datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData.add(obtenerValorlistOfApprovalData(reader, 'ApprovalData', datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id));
                      
                  }
                  
                  
                  
            }
            reader.next();
        }
        
        if (datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id!=null && datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData!=null){
            try{
                insert datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData;
             } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                          } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                          } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                          } //catch
            
            List<recordSP__c> list_Record = new List<recordSP__c>();
            Set<String> set_llaveCompuestaRecord = new Set<String>();
            for (ApprovalDataSP__c objApprovalData : datos.cadenaXML.datosSiebel.approvalDataClass.listaApprovalData){   
                            if(map_id_listApprovalData.get(datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id)!=null){
                                map_id_listApprovalData.get(datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id).add(objApprovalData);
                            } else
                            {
                                map_id_listApprovalData.put(datos.cadenaXML.datosSiebel.listaSiebelProcesos[0].Id, new List<ApprovalDataSP__c>{objApprovalData});      
                            }
                            map_intNmListaAppData_idAppData.put( Integer.ValueOf( objApprovalData.Numero_de_Lista__c), objApprovalData.Id);
                            List<recordSP__c> list_Record_temp = new List<recordSP__c>( map_intNumLista_listrecord.get(Integer.ValueOf( objApprovalData.Numero_de_Lista__c) ) );
                            for(recordSP__c objRecord : list_Record_temp){
                                if (!set_llaveCompuestaRecord.contains(objRecord.name) ){
                                    set_llaveCompuestaRecord.add(objRecord.name);
                                    list_Record.add(objRecord);
                                }
                                
                            }                  
            }
            
            if ( !list_Record.isEmpty() ){
                List<recordSP__c> list_record_ins = new List<recordSP__c>(); 
                List<fieldSP__c> list_field = new List<fieldSP__c>();
                Set<String> set_llaveCompuestaField = new Set<String>();
                for(recordSP__c objrecord : list_Record ){
                    objrecord.ApprovalDataSP_Buscar__c = map_intNmListaAppData_idAppData.get( Integer.ValueOf( objrecord.Numero_de_Lista_Buscar__c) );
                    list_record_ins.add(objrecord);
                    //list_field.add(map_intNumLista_listfield.get( Integer.ValueOf(objrecord.Numero_de_Lista__c)  )  );
                    
                    List<fieldSP__c> list_field_temp = new List<fieldSP__c>( map_intNumLista_listfield.get(Integer.ValueOf( objrecord.Numero_de_Lista__c) ) );
                    for(fieldSP__c objField : list_field_temp){
                        if (!set_llaveCompuestaField.contains(objField.Llave_Compuesta__c) ){
                            set_llaveCompuestaField.add(objField.Llave_Compuesta__c);
                            list_field.add(objField);
                        }
                        
                    } 
                }
                try{
                    //System.Debug('***list_record_ins*** '+ list_record_ins);
                    insert list_record_ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
                for (recordSP__c objrecord :list_record_ins){
                    map_intNmListaRecord_idRecord.put( Integer.ValueOf(objrecord.Numero_de_Lista__c) , objrecord.Id);
                }
                if ( !list_field.isEmpty() ){
                    List<fieldSP__c> list_field_ins = new List<fieldSP__c>(); 
                    for(fieldSP__c objfield : list_field ){
                        objfield.recordSP_Buscar__c = map_intNmListaRecord_idRecord.get( Integer.ValueOf( objfield.Numero_de_Lista_Buscar__c) );
                        list_field_ins.add(objfield);
                    }
                    try{
                        insert list_field_ins;
                    } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
                }
            }
        }
        
        Boolean boolFlujoAprobValido = false;
        SharePointObj__c SharePointObj = [SELECT
                                            Id
                                            , Name
                                            , platform__c
                                            , TipoXML__c
                                            , NoDocumento__c
                                            , Area__c
                                            , ApoderadoLegal__c
                                            , Accion__c
                                            , ApSatic__c
                                            
                                            , Categoria__c
                                            , Listas__c
                                            , EstatusSolicitud__c
                                            , estatus__c
                                            , CentroCosto__c
                                            
                                            , Conjunto__c
                                            , Contratante__c 
                                            , UEN__c
                                            , Fraccionamiento__c
                                            , TipoContrato__c
                                            , ContratoTipo__c
                                            , Concepto__c
                                            , Descripcion__c
                                            , Contratista__c
                                            , FechaFirmaContrato__c
                                            , FechaInicioObra__c 
                                            , FechaTerminoObra__c
                                            , FondoGarantiaDias__c
                                            , FondoGarantiaPorciento__c
                                            , Obraoadmin__c
                                            , Suplente__c
                                            , TipoInsumo__c 
                                            , TipoProveedor__c
                                            , LineaProductos__c
                                            , approverEmpId__c
                                            , CreadoPor__c
                                            , Ciudad__c
                                            , Suministro__c
                                                    , Comentario__c
                                                    , Comentarios__c
                                                    , CompaniasKontrol__c
                                                    , ContactoVendedor__c
                                                    , Creado__c
                                                    
                                                    , Direccion__c
                                                    , Estado__c
                                                    , Fianza__c
                                                    , ImporteAccesorios__c
                                                    , ImporteAnticipo__c
                                                    , ImporteContrato__c
                                                    , ImporteMolde__c
                                                    , No__c
                                                    , Nombre__c
                                                    , NombreJefe__c
                                                    , NomRepLegal__c
                                                    , Numero__c
                                                    
                                                    , RazonSocialNombre__c
                                                    , Rfc__c
                                                    , Static__c
                                                    , testigo_1__c
                                                    , testigo_2__c
                                                    , testigo_3__c
                                                    , Tramite__c
                                                    , Usuario__c
                                                    , UsuarioJefeInmediato__c
                                        
                                            FROM 
                                            SharePointObj__c
                                            WHERE
                                            Id = :idDatoSiebel
                                            ];
                    
         if(SharePointObj.TipoXML__c=='Proveedores' 
            
            
            ){
                Proveedor__c objProveedor = new Proveedor__c();
                objProveedor = Crea_Proveedor(SharePointObj);
            //System.Debug('***SharePointObj objProveedor*** '+ SharePointObj);
            
            
            //System.Debug('***objProveedor*** '+ objProveedor);
            
            if (objProveedor == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, SharePointObj_Buscar__c FROM Catch__c WHERE SharePointObj_Buscar__c=:SharePointObj.Id  LIMIT 1]);
                      if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ SharePointObj.TipoXML__c+' con clave '+SharePointObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+SharePointObj.TipoXML__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.SharePointObj_Buscar__c = SharePointObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                            
                      
                }    
            } else {
                    try{
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(objProveedor.id);
                        
                        // Submit on behalf of a specific submitter
                        req1.setSubmitterId(objProveedor.OwnerId); 
                        req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Proveedor');
                        
                        //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Comision');
                        req1.setSkipEntryCriteria(false);
                        // Submit the approval request for the account
                        Approval.ProcessResult result = Approval.process(req1);
                        //System.debug('***result*** '+result);
                        SharePointObj.Id_Objeto_A_Aprobar_Buscar__c = objProveedor.Id;
                        SharePointObj.Estatus__c = 'En Proceso de Aprobación';
                        SharePointObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objProveedor.Id;
                        SharePointObj.OwnerId = objProveedor.OwnerId;
                        
                        
                        
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        SharePointObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                        
                        try{
                            update SharePointObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                        
                    } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
            }
            boolFlujoAprobValido = true;
            
        } else if(SharePointObj.TipoXML__c=='Insumos' 
            
            
            ){
                Insumo__c objInsumo = new Insumo__c();
                objInsumo = Crea_Insumo(SharePointObj);
            //System.Debug('***SharePointObj objInsumo*** '+ SharePointObj);
            
            
            //System.Debug('***objInsumo*** '+ objInsumo);
            
            if (objInsumo == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, SharePointObj_Buscar__c FROM Catch__c WHERE SharePointObj_Buscar__c=:SharePointObj.Id  LIMIT 1]);
                      if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ SharePointObj.TipoXML__c+' con clave '+SharePointObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+SharePointObj.TipoXML__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.SharePointObj_Buscar__c = SharePointObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                            
                      
                }    
            } else {
                    try{
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(objInsumo.id);
                        
                        // Submit on behalf of a specific submitter
                        req1.setSubmitterId(objInsumo.OwnerId); 
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Insumo');
                        
                        //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Comision');
                        req1.setSkipEntryCriteria(false);
                        // Submit the approval request for the account
                        Approval.ProcessResult result = Approval.process(req1);
                        //System.debug('***result*** '+result);
                        SharePointObj.Id_Objeto_A_Aprobar_Buscar__c = objInsumo.Id;
                        SharePointObj.Estatus__c = 'En Proceso de Aprobación';
                        SharePointObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objInsumo.Id;
                        SharePointObj.OwnerId = objInsumo.OwnerId;
                        
                        
                        
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        SharePointObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                        
                        try{
                            update SharePointObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                        
                    } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
            }
            boolFlujoAprobValido = true;
            
        }  else if(SharePointObj.TipoXML__c=='Contratos' 
            
            
            ){
                Contrato__c objContrato = new Contrato__c();
                objContrato = Crea_Contrato(SharePointObj);
            //System.Debug('***SharePointObj objContrato*** '+ SharePointObj);
            
            
            //System.Debug('***objContrato*** '+ objContrato);
            
            if (objContrato == null) {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                        List<Catch__c> listCatchPrevios = new List<Catch__c> ([SELECT Id, Name, SharePointObj_Buscar__c FROM Catch__c WHERE SharePointObj_Buscar__c=:SharePointObj.Id  LIMIT 1]);
                      if (listCatchPrevios.IsEmpty()){ String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); Catch__c newCatch = new Catch__c();newCatch.RecordTypeId = rtCatch;newCatch.descripcion__c = 'Uno o más requistos para construir el objeto tipo '+ SharePointObj.TipoXML__c+' con clave '+SharePointObj.Name+' no se cumplieron y no fue posible construir el Flujo de Aprobacion.';newCatch.Causa__c = 'El Flujo de Aprobación de tipo >'+SharePointObj.TipoXML__c+'< no se construyó.';newCatch.StackTrace__c = e.getStackTraceString();newCatch.SharePointObj_Buscar__c = SharePointObj.Id;Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } }
                            
                      
                }    
            } else {
                    try{
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(objContrato.id);
                        
                        // Submit on behalf of a specific submitter
                        req1.setSubmitterId(objContrato.OwnerId); 
                        req1.setProcessDefinitionNameOrId('Proc_Aprob_Contratos');
                        
                        //req1.setProcessDefinitionNameOrId('Proceso_de_Aprobacion_de_Comision');
                        req1.setSkipEntryCriteria(false);
                        // Submit the approval request for the account
                        Approval.ProcessResult result = Approval.process(req1);
                        //System.debug('***result*** '+result);
                        SharePointObj.Id_Objeto_A_Aprobar_Buscar__c = objContrato.Id;
                        SharePointObj.Estatus__c = 'En Proceso de Aprobación';
                        SharePointObj.Enlace_a_Registro_en_Aprobacion__c   = protocolAndHost()+'/'+objContrato.Id;
                        SharePointObj.OwnerId = objContrato.OwnerId;
                        
                        
                        
                        String strIdItemApproval = result.getNewWorkitemIds()[0];
                        strIdItemApproval = strIdItemApproval.substring(0,strIdItemApproval.length());
                        SharePointObj.Aprobacion_URL__c = protocolAndHost()+'/p/process/ProcessInstanceWorkitemWizardStageManager?id='+strIdItemApproval;
                        
                        try{
                            update SharePointObj; 
                        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
                        
                    } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                        } //catch
            }
            boolFlujoAprobValido = true;
            
        } 
        //Comprobamos si alguna vez entro en algun IF
        //Si nunca entro generamos una exception indicandolo
        if (!boolFlujoAprobValido){
            // En esta caso validamos si acaso el objeto se construyo
            // Si tenia nombre entonces el nombre del flujo no se encontro
            if (SharePointObj.TipoXML__c!=null){ try { throw new ErrorProcesoException(); } catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El campo de <TipoXML> con el valor: '+ SharePointObj.TipoXML__c+' no fue encontrado entre los Flujos de Aprobación.'; newCatch.Causa__c = 'Nombre de flujo no válido.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
            } 
            // Si no tenia nombre significa que no tiene datos de encabezado
            else { try { throw new ErrorProcesoException(); } catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no tiene información básica de encabezado.'; newCatch.Causa__c = 'El XML no tiene encabezado.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
            }
            
        }
    
    }
    
    /*****************************************************************************************************
        CREACÍON DEL REGISTRO EN EL OBJETO DE PROVEEDORES
    *****************************************************************************************************/
    
    private static Proveedor__c Crea_Proveedor(SharePointObj__c SharePointObj){
        
    Id idApprovalData_1;
    Id idApprovalData_2;
    Id idApprovalData_3;
    Id idApprovalData_4;
    System.Debug('***SharePointObj Crea_Proveedor*** '+ SharePointObj);
    
    //String str_idFlujo = SharePointObj.idFlujo__c;
    String str_TipoXML = SharePointObj.TipoXML__c;
    String str_NoDocumento = SharePointObj.NoDocumento__c;
    String str_Area = SharePointObj.Area__c;
    //String str_Listas = SharePointObj.Listas__c;
    //String str_ApoderadoLegal = SharePointObj.ApoderadoLegal__c;
    String str_Accion = SharePointObj.Accion__c;
    String str_approverEmpId = SharePointObj.approverEmpId__c;
    //String str_Categoria = SharePointObj.Categoria__c;
    //String str_CentroCosto = SharePointObj.CentroCosto__c;
    String str_Ciudad = SharePointObj.Ciudad__c;
    String str_Comentario = SharePointObj.Comentario__c;
    String str_Comentarios = SharePointObj.Comentarios__c;
    String str_CompaniasKontrol = SharePointObj.CompaniasKontrol__c;
    //String str_Concepto = SharePointObj.Concepto__c;
    //String str_Conjunto = SharePointObj.Conjunto__c;
    //String str_Consecutivo = SharePointObj.Consecutivo__c;
    String str_ContactoVendedor = SharePointObj.ContactoVendedor__c;
    //String str_Contratante = SharePointObj.Contratante__c;
    //String str_Contratista = SharePointObj.Contratista__c;
    String str_Creado = SharePointObj.Creado__c;
    String str_CreadoPor = SharePointObj.CreadoPor__c;
    //String str_Descripcion = SharePointObj.Descripcion__c;
    String str_Direccion = SharePointObj.Direccion__c;
    String str_Estado = SharePointObj.Estado__c;
    String str_EstatusSolicitud = SharePointObj.EstatusSolicitud__c;
    //String str_FechaFirmaContrato = SharePointObj.FechaFirmaContrato__c;
    //String str_FechaInicioObra = SharePointObj.FechaInicioObra__c;
    //String str_FechaTerminoObra = SharePointObj.FechaTerminoObra__c;
    //String str_Fianza = SharePointObj.Fianza__c;
    //String str_FondoGarantiaDias = SharePointObj.FondoGarantiaDias__c;
    //String str_FondoGarantiaPorciento = SharePointObj.FondoGarantiaPorciento__c;
    //String str_Fraccionamiento = SharePointObj.Fraccionamiento__c;
    //String str_ImporteAccesorios = SharePointObj.ImporteAccesorios__c;
    //String str_ImporteAnticipo = SharePointObj.ImporteAnticipo__c;
    //String str_ImporteContrato = SharePointObj.ImporteContrato__c;
    //String str_ImporteMolde = SharePointObj.ImporteMolde__c;
    String str_LineaProductos = SharePointObj.LineaProductos__c;
    //String str_No = SharePointObj.No__c;
    String str_Nombre = SharePointObj.Nombre__c;
    String str_NombreJefe = SharePointObj.NombreJefe__c;
    String str_NomRepLegal = SharePointObj.NomRepLegal__c;
    String str_Numero = SharePointObj.Numero__c;
    //String str_Obraoadmin = SharePointObj.Obraoadmin__c;
    String str_platform = SharePointObj.platform__c;
    String str_RazonSocialNombre = SharePointObj.RazonSocialNombre__c;
    String str_Rfc = SharePointObj.Rfc__c;
    //String str_Static = SharePointObj.Static__c;
    //String str_SubCategoria = SharePointObj.SubCategoria__c;
    //String str_Suministro = SharePointObj.Suministro__c;
    //String str_Suplente = SharePointObj.Suplente__c;
    //String str_TipoContrato = SharePointObj.TipoContrato__c;
    //String str_TipoInsumo = SharePointObj.TipoInsumo__c;
    String str_TipoProveedor = SharePointObj.TipoProveedor__c;
    String str_Tramite = SharePointObj.Tramite__c;
    String str_UEN = SharePointObj.UEN__c;
    //String str_UnidadMedida = SharePointObj.UnidadMedida__c;
    //String str_Usuario = SharePointObj.Usuario__c;
    String str_UsuarioJefeInmediato = SharePointObj.UsuarioJefeInmediato__c;
    
    Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
    for (User objUsr: [SELECT Id, UserSharePoint__c FROM User LIMIT 10000] ){
        if (objUsr.UserSharePoint__c!=null || objUsr.UserSharePoint__c!='' ){
            map_strEmpClave_UsrId.put(objUsr.UserSharePoint__c, objUsr.Id);
        }
        
    }
    
    //strEmpRequesterID = ApprvObj.requesterEmpId__c;
    //strEmpApproverID = ApprvObj.approverEmpId__c;
    //strApprovalID = ApprvObj.approvalId__c;
    //strToken = ApprvObj.token__c;
    //String strAppvObjLevel = ApprvObj.approvalLevel__c;
    ///String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
    
    
    for(ApprovalDataSP__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalDataSP__c WHERE SharePointObj_Buscar__c = :SharePointObj.Id ] ){
        if (ApprvData.Numero_de_Lista__c == 1){
            idApprovalData_1 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 2){
            idApprovalData_2 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 3){
            idApprovalData_3 = ApprvData.Id;
        } else if (ApprvData.Numero_de_Lista__c == 4){
            idApprovalData_4 = ApprvData.Id;
        }
        
    }
    // Obtiene datos del unico record de la lista relacionada 1
    // Obtiene datos de varios records de la lista relacionada 2
    Set<Id> set_idRecord = new Set<Id>();
    
    for (recordSP__c Record :[SELECT Id, Name FROM recordSP__c WHERE ApprovalDataSP_Buscar__c = :idApprovalData_1  ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Telefono_de_Proveedor__c> list_objTelProv = new List<Telefono_de_Proveedor__c>();
    String strRecordBuscar='';
    Telefono_de_Proveedor__c TelProvNew;
    for (fieldSP__c Field :[SELECT Id, Name, Value__c, RecordSP_Buscar__c FROM fieldSP__c WHERE RecordSP_Buscar__c IN :set_idRecord ORDER BY RecordSP_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.RecordSP_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objTelProv.add(TelProvNew);
            } 
            TelProvNew = new Telefono_de_Proveedor__c();    
            if (Field.Name=='Telefono'){
                TelProvNew.Telefono__c = Field.Value__c;
            }
            
            
            strRecordBuscar = Field.RecordSP_Buscar__c;
            
        } else {
            if (Field.Name=='Telefono'){
                TelProvNew.Telefono__c = Field.Value__c;
            }
        }
    }
    set_idRecord.removeAll( new Set<Id>(set_idRecord) );
    list_objTelProv.add(TelProvNew);
    //System.Debug('***list_objTelProv*** '+list_objTelProv);
       
    for (recordSP__c Record :[SELECT Id, Name FROM recordSP__c WHERE ApprovalDataSP_Buscar__c = :idApprovalData_2  ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Celular_de_Proveedor__c> list_objCelProv = new List<Celular_de_Proveedor__c>();
    strRecordBuscar='';
    Celular_de_Proveedor__c CelProvNew;
    for (fieldSP__c Field :[SELECT Id, Name, Value__c, RecordSP_Buscar__c FROM fieldSP__c WHERE RecordSP_Buscar__c IN :set_idRecord ORDER BY RecordSP_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.RecordSP_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objTelProv.add(TelProvNew);
            } 
            CelProvNew = new Celular_de_Proveedor__c();    
            if (Field.Name=='Celular'){
                CelProvNew.Celular__c = Field.Value__c;
            }
            /*
                else if (Field.Name=='Pct Base'){
                PagoPorCatNew.Base_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Cumplimiento'){
                PagoPorCatNew.Cumplimiento_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Excedente'){
                PagoPorCatNew.Excedente_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
            */
            
            strRecordBuscar = Field.RecordSP_Buscar__c;
            
        } else {
            if (Field.Name=='Celular'){
                CelProvNew.Celular__c = Field.Value__c;
            }
        }
    }
    set_idRecord.removeAll( new Set<Id>(set_idRecord) );
    list_objCelProv.add(CelProvNew);
    //System.Debug('***list_objCelProv*** '+list_objCelProv);    
        
    for (recordSP__c Record :[SELECT Id, Name FROM recordSP__c WHERE ApprovalDataSP_Buscar__c = :idApprovalData_3  ORDER BY Name Asc] ){
        set_idRecord.add(Record.Id);
    }
    //System.Debug('***set_idRecord*** '+set_idRecord);
    List<Email_de_Proveedor__c> list_objEmailProv = new List<Email_de_Proveedor__c>();
    strRecordBuscar='';
    Email_de_Proveedor__c EmailProvNew;
    for (fieldSP__c Field :[SELECT Id, Name, Value__c, RecordSP_Buscar__c FROM fieldSP__c WHERE RecordSP_Buscar__c IN :set_idRecord ORDER BY RecordSP_Buscar__c ] ){
        //System.Debug('***Field*** '+ Field);
        String strRecordBuscarField = Field.RecordSP_Buscar__c;
        //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
        //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
        if (strRecordBuscarField!= strRecordBuscar){
            if (strRecordBuscar!=''){
                list_objEmailProv.add(EmailProvNew);
            } 
            EmailProvNew = new Email_de_Proveedor__c();    
            if (Field.Name=='Email'){
                EmailProvNew.Email__c = Field.Value__c;
            }
            /*
                else if (Field.Name=='Pct Base'){
                PagoPorCatNew.Base_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Cumplimiento'){
                PagoPorCatNew.Cumplimiento_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            } else if (Field.Name=='Pct Excedente'){
                PagoPorCatNew.Excedente_Pct__c = asignaOLimpiaValorDouble(Field.Value__c);
            }
            */
            
            strRecordBuscar = Field.RecordSP_Buscar__c;
            
        } else {
            if (Field.Name=='Email'){
                EmailProvNew.Email__c = Field.Value__c;
            }
        }
    }
    set_idRecord.removeAll( new Set<Id>(set_idRecord) );
    list_objEmailProv.add(EmailProvNew);
    System.Debug('***list_objEmailProv*** '+list_objEmailProv);
    
    
    //System.Debug('***list_objEmailProv 1*** '+list_objEmailProv); 
    
    //System.Debug('***map_strEmpClave_UsrId*** '+map_strEmpClave_UsrId);
    Proveedor__c objProveedor;
    if(map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)!=null ){
        System.Debug('***if(map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)!=null )*** ');
        objProveedor = new Proveedor__c(Name = SharePointObj.Name
                                                    , Aprobador__c= map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)
                                                
                                                    , OwnerId = map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)
                                        
                                                    , platform__c = str_platform
                                                    //, TipoXML__c = str_TipoXML 
                                                    //, NoDocumento__c = str_NoDocumento
                                                    
                                                    
                                                    , EstatusSolicitud__c = str_EstatusSolicitud
                                                    , Accion__c = str_Accion
                                                    , CompaniasKontrol__c = str_CompaniasKontrol
                                                    , RazonSocialNombre__c = str_RazonSocialNombre
                                                    , Rfc__c = str_Rfc
                                                    , TipoProveedor__c = str_TipoProveedor
                                                    , LineaProductos__c = str_LineaProductos
                                                    , NomRepLegal__c = str_NomRepLegal
                                                    , Direccion__c = str_Direccion
                                                    , Ciudad__c = str_Ciudad
                                                    , Estado__c = str_Estado
                                                    , Numero__c = str_Numero
                                                    , ContactoVendedor__c = str_ContactoVendedor
                                                    , Tramite__c = str_Tramite
                                                    , Comentario__c = str_Comentario
                                                    , Creado__c = str_Creado
                                                    , CreadoPor__c = str_CreadoPor
                                                    , Nombre__c = str_Nombre
                                                    , NombreJefe__c = str_NombreJefe
                                                    , UsuarioJefeInmediato__c = str_UsuarioJefeInmediato
                                                    , UEN__c = str_UEN
                                                    , Area__c = str_Area
                                                    //, Listas__c = str_Listas
                                                    //, ApoderadoLegal__c = str_ApoderadoLegal
                                                    
                                                    //, approverEmpId__c = str_approverEmpId
                                                    //, Categoria__c = str_Categoria
                                                    //, CentroCosto__c = str_CentroCosto
                                                    
                                                    
                                                    //, Comentarios__c = str_Comentarios
                                                    
                                                    //, Concepto__c = str_Concepto
                                                    //, Conjunto__c = str_Conjunto
                                                    //, Consecutivo__c = str_Consecutivo
                                                    
                                                    //, Contratante__c = str_Contratante
                                                    //, Contratista__c = str_Contratista
                                                    
                                                    
                                                    //, Descripcion__c = str_Descripcion
                                                    
                                                    
                                                    
                                                    //, FechaFirmaContrato__c = str_FechaFirmaContrato
                                                    //, FechaInicioObra__c = str_FechaInicioObra
                                                    //, FechaTerminoObra__c = str_FechaTerminoObra
                                                    //, Fianza__c = str_Fianza
                                                    //, FondoGarantiaDias__c = str_FondoGarantiaDias
                                                    //, FondoGarantiaPorciento__c = str_FondoGarantiaPorciento
                                                    //, Fraccionamiento__c = str_Fraccionamiento
                                                    //, ImporteAccesorios__c = str_ImporteAccesorios
                                                    //, ImporteAnticipo__c = str_ImporteAnticipo
                                                    //, ImporteContrato__c = str_ImporteContrato
                                                    //, ImporteMolde__c = str_ImporteMolde
                                                    
                                                    //, No__c = str_No
                                                    
                                                    
                                                    
                                                    //, Obraoadmin__c = str_Obraoadmin
                                                    
                                                    
                                                    
                                                    //, Static__c = str_Static
                                                    //, SubCategoria__c = str_SubCategoria
                                                    //, Suministro__c = str_Suministro
                                                    //, Suplente__c = str_Suplente
                                                    //, TipoContrato__c = str_TipoContrato
                                                    //, TipoInsumo__c = str_TipoInsumo
                                                    
                                                    
                                                    
                                                    //, UnidadMedida__c = str_UnidadMedida
                                                    //, Usuario__c = str_Usuario
                                                    
                                        
                                                    );
        
        try{
            insert objProveedor;
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
        
        
        
        if ((!list_objTelProv.IsEmpty()  && list_objTelProv!=NULL) && objProveedor!=null){
            List<Telefono_de_Proveedor__c> list_TelProv_Ins = new List<Telefono_de_Proveedor__c>();
            Integer NumeroEnLista =1;
            for(Telefono_de_Proveedor__c TelProv2Ins : list_objTelProv){
                if (TelProv2Ins!=null){
                    TelProv2Ins.Name = String.ValueOf(NumeroEnLista++);
                    
                    TelProv2Ins.Proveedor_Buscar__c= objProveedor.Id;
                    list_TelProv_Ins.add(TelProv2Ins);
                }
                
            }
            if (!list_TelProv_Ins.IsEmpty()){
                try{
                    insert list_TelProv_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ((!list_objCelProv.IsEmpty()  && list_objCelProv!=NULL) && objProveedor!=null){
            List<Celular_de_Proveedor__c> list_CelProv_Ins = new List<Celular_de_Proveedor__c>();
            Integer NumeroEnLista =1;
            for(Celular_de_Proveedor__c CelProv2Ins : list_objCelProv){
                if (CelProv2Ins!=null){
                    CelProv2Ins.Name = String.ValueOf(NumeroEnLista++);
                    CelProv2Ins.Proveedor_Buscar__c= objProveedor.Id;
                    list_CelProv_Ins.add(CelProv2Ins);
                }
                
            }
            if (!list_CelProv_Ins.IsEmpty()){
                try{
                    insert list_CelProv_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
        if ((!list_objEmailProv.IsEmpty()  && list_objEmailProv!=NULL) && objProveedor!=null){
            List<Email_de_Proveedor__c> list_EmailProv_Ins = new List<Email_de_Proveedor__c>();
            Integer NumeroEnLista =1;
            for(Email_de_Proveedor__c EmailProv2Ins : list_objEmailProv){
                if (EmailProv2Ins!=null){
                    EmailProv2Ins.Name = String.ValueOf(NumeroEnLista++);
                    EmailProv2Ins.Proveedor_Buscar__c= objProveedor.Id;
                    list_EmailProv_Ins.add(EmailProv2Ins);
                }
                
            }
            if (!list_EmailProv_Ins.IsEmpty()){
                try{
                    insert list_EmailProv_Ins;
                } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
            }
        
        } 
        // No presenta lista relacionada
        else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
        }
        
        
     } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <Aprobador> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <Aprobador> no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                        newCatch.SharePointObj_Buscar__c = SharePointObj.Id;
                        //System.Debug('***newCatch *** '+newCatch);
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
    }
    return objProveedor;
    
    }
     
     
     private static Contrato__c Crea_Contrato(SharePointObj__c SharePointObj){
        Id idApprovalData_1;
        Id idApprovalData_2;
        Id idApprovalData_3;
        Id idApprovalData_4;
        System.Debug('***SharePointObj Crea_Proveedor*** '+ SharePointObj);
        
        //String str_idFlujo = SharePointObj.idFlujo__c;
        String str_TipoXML = SharePointObj.TipoXML__c;
        String str_NoDocumento = SharePointObj.NoDocumento__c;
        String str_Area = SharePointObj.Area__c;
        //String str_Listas = SharePointObj.Listas__c;
        String str_ApSatic = SharePointObj.ApSatic__c;
        String str_ApoderadoLegal = SharePointObj.ApoderadoLegal__c;
        String str_Accion = SharePointObj.Accion__c;
        String str_approverEmpId = SharePointObj.approverEmpId__c;// <Aprobador>
        
        //String str_Categoria = SharePointObj.Categoria__c;
        String str_CentroCosto = SharePointObj.CentroCosto__c;
        //String str_Ciudad = SharePointObj.Ciudad__c;
        String str_Comentario = SharePointObj.Comentario__c;
        String str_Comentarios = SharePointObj.Comentarios__c;
        //String str_CompaniasKontrol = SharePointObj.CompaniasKontrol__c;
        String str_Concepto = SharePointObj.Concepto__c;
        String str_Conjunto = SharePointObj.Conjunto__c;
        //String str_Consecutivo = SharePointObj.Consecutivo__c;
        //String str_ContactoVendedor = SharePointObj.ContactoVendedor__c;
        String str_Contratante = SharePointObj.Contratante__c;
        String str_Contratista = SharePointObj.Contratista__c;
        
        String str_Creado = SharePointObj.Creado__c;
        String str_CreadoPor = SharePointObj.CreadoPor__c;
        String str_Descripcion = SharePointObj.Descripcion__c;
        String str_Direccion = SharePointObj.Direccion__c;
        String str_Estado = SharePointObj.Estado__c;
        String str_EstatusSolicitud = SharePointObj.EstatusSolicitud__c;
        String str_Estatus = SharePointObj.Estatus__c;
        String str_FechaFirmaContrato = SharePointObj.FechaFirmaContrato__c;
        String str_FechaInicioObra = SharePointObj.FechaInicioObra__c;
        String str_FechaTerminoObra = SharePointObj.FechaTerminoObra__c;
        String str_Fianza = SharePointObj.Fianza__c;
        String str_FondoGarantiaDias = SharePointObj.FondoGarantiaDias__c;
        String str_FondoGarantiaPorciento = SharePointObj.FondoGarantiaPorciento__c;
        String str_Fraccionamiento = SharePointObj.Fraccionamiento__c;
        String str_ImporteAccesorios = SharePointObj.ImporteAccesorios__c;
        String str_ImporteAnticipo = SharePointObj.ImporteAnticipo__c;
        String str_ImporteContrato = SharePointObj.ImporteContrato__c;
        String str_ImporteMolde = SharePointObj.ImporteMolde__c;
        //String str_LineaProductos = SharePointObj.LineaProductos__c;
        String str_No = SharePointObj.No__c;
        String str_Nombre = SharePointObj.Nombre__c;
        String str_NombreJefe = SharePointObj.NombreJefe__c;
        String str_NomRepLegal = SharePointObj.NomRepLegal__c;
        String str_Numero = SharePointObj.Numero__c;
        //String str_Obraoadmin = SharePointObj.Obraoadmin__c;
        String str_platform = SharePointObj.platform__c;
        String str_RazonSocialNombre = SharePointObj.RazonSocialNombre__c;
        String str_Rfc = SharePointObj.Rfc__c;
        String str_Static = SharePointObj.Static__c;
        //String str_SubCategoria = SharePointObj.SubCategoria__c;
        String str_Suministro = SharePointObj.Suministro__c;
        String str_Suplente = SharePointObj.Suplente__c;
        String str_testigo_1 = SharePointObj.testigo_1__c;
        String str_testigo_2 = SharePointObj.testigo_2__c;
        String str_testigo_3 = SharePointObj.testigo_3__c;
       
        String str_TipoContrato = SharePointObj.TipoContrato__c;
        String str_ContratoTipo = SharePointObj.ContratoTipo__c;
        //String str_TipoInsumo = SharePointObj.TipoInsumo__c;
        //String str_TipoProveedor = SharePointObj.TipoProveedor__c;
        //String str_Tramite = SharePointObj.Tramite__c;
        String str_UEN = SharePointObj.UEN__c;
        //String str_UnidadMedida = SharePointObj.UnidadMedida__c;
        String str_Usuario = SharePointObj.Usuario__c;
        //String str_UsuarioJefeInmediato = SharePointObj.UsuarioJefeInmediato__c;
        
        Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
        for (User objUsr: [SELECT Id, UserSharePoint__c FROM User LIMIT 10000] ){
            if (objUsr.UserSharePoint__c!=null || objUsr.UserSharePoint__c!='' ){
                map_strEmpClave_UsrId.put(objUsr.UserSharePoint__c, objUsr.Id);
            }
            
        }
        
        //System.Debug('***map_strEmpClave_UsrId*** '+map_strEmpClave_UsrId);
        Contrato__c objContrato;
        if(map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)!=null ){
            System.Debug('***if(map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)!=null )*** ');
           
                                                        
                                      
            objContrato = new Contrato__c(Name = SharePointObj.Name
                                                    , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)
                                                    
                                                    , OwnerId = map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)
                                                    //, TipoXML__c = str_TipoXML
                                                    //, NoDocumento__c = str_NoDocumento
                                                    //, Area__c = str_Area
                                                    , ApSatic__c = str_ApSatic
                                                    , ApoderadoLegal__c = str_ApoderadoLegal
                                                    , Accion__c = str_Accion
                                                    
                                                    , CentroCosto__c = str_CentroCosto
                                                    , Comentario__c = str_Comentario
                                                    , Comentarios__c = str_Comentarios
                                                    , Concepto__c = str_Concepto
                                                    , Conjunto__c = str_Conjunto
                                                    , Contratante__c = str_Contratante
                                                    , Contratista__c = str_Contratista
                                                    
                                                    , Creado__c = str_Creado
                                                    , CreadoPor__c = str_CreadoPor
                                                    , Descripcion__c = str_Descripcion
                                                    , Direccion__c = str_Direccion
                                                    , Estado__c = str_Estado
                                                    , EstatusSolicitud__c = str_EstatusSolicitud
                                                    , Estatus__c = str_Estatus
                                                    , FechaFirmaContrato__c = str_FechaFirmaContrato
                                                    , FechaInicioObra__c = str_FechaInicioObra
                                                    , FechaTerminoObra__c = str_FechaTerminoObra
                                                    , Fianza__c = str_Fianza
                                                    , FondoGarantiaDias__c = str_FondoGarantiaDias
                                                    , FondoGarantiaPorciento__c = str_FondoGarantiaPorciento
                                                    , Fraccionamiento__c = str_Fraccionamiento
                                                    , ImporteAccesorios__c = str_ImporteAccesorios
                                                    , ImporteAnticipo__c = str_ImporteAnticipo
                                                    , ImporteContrato__c = str_ImporteContrato
                                                    , ImporteMolde__c = str_ImporteMolde
                                                    , No__c = str_No
                                                    , Nombre__c = str_Nombre
                                                    , NombreJefe__c = str_NombreJefe
                                                    , NomRepLegal__c = str_NomRepLegal
                                                    , Numero__c = str_Numero
                                                    , platform__c = str_platform
                                                    , RazonSocialNombre__c = str_RazonSocialNombre
                                                    , Rfc__c = str_Rfc
                                                    , Static__c = str_Static
                                                    , Suministro__c = str_Suministro
                                                    , Suplente__c = str_Suplente
                                                    , testigo_1__c = str_testigo_1
                                                    , testigo_2__c = str_testigo_2
                                                    , testigo_3__c = str_testigo_3
                                                    , TipoContrato__c = str_TipoContrato
                                                    , ContratoTipo__c = str_ContratoTipo
                                                    , UEN__c = str_UEN
                                                    , Usuario__c = str_Usuario
        
                                                    );
            try{
                insert objContrato;
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.insert(newCatch,false);
             } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
             } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
             } //catch
        } else {
            try { throw new ErrorProcesoException();
            } catch (ErrorProcesoException e) { 
                        String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                        Catch__c newCatch = new Catch__c();
                        newCatch.RecordTypeId = rtCatch;
                        newCatch.descripcion__c = 'El campo de <Aprobador> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                        newCatch.Causa__c = 'El Valor de <Aprobador>no es valido como aprobador.' ;
                        newCatch.StackTrace__c = e.getStackTraceString();
                        newCatch.SharePointObj_Buscar__c = SharePointObj.Id;
                        Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }    
        }    
            
            
        return objContrato;
     }
     
     
     private static Insumo__c Crea_Insumo(SharePointObj__c SharePointObj){
        
        Id idApprovalData_1;
        Id idApprovalData_2;
        Id idApprovalData_3;
        Id idApprovalData_4;
        System.Debug('***SharePointObj Crea_Insumo*** '+ SharePointObj);
        
        //String str_idFlujo = SharePointObj.idFlujo__c;
        String str_Obraoadmin = SharePointObj.Obraoadmin__c;
        String str_NoDocumento = SharePointObj.NoDocumento__c;
        String str_Area = SharePointObj.Area__c;
        //String str_Listas = SharePointObj.Listas__c;
        //String str_ApoderadoLegal = SharePointObj.ApoderadoLegal__c;
        String str_Accion = SharePointObj.Accion__c;
        String str_approverEmpId = SharePointObj.approverEmpId__c;
        //String str_Categoria = SharePointObj.Categoria__c;
        //String str_CentroCosto = SharePointObj.CentroCosto__c;
        //String str_Ciudad = SharePointObj.Ciudad__c;
        String str_Comentario = SharePointObj.Comentario__c;
        //String str_Comentarios = SharePointObj.Comentarios__c;
        //String str_CompaniasKontrol = SharePointObj.CompaniasKontrol__c;
        //String str_Concepto = SharePointObj.Concepto__c;
        //String str_Conjunto = SharePointObj.Conjunto__c;
        //String str_Consecutivo = SharePointObj.Consecutivo__c;
        //String str_ContactoVendedor = SharePointObj.ContactoVendedor__c;
        //String str_Contratante = SharePointObj.Contratante__c;
        //String str_Contratista = SharePointObj.Contratista__c;
        String str_Creado = SharePointObj.Creado__c;
        String str_CreadoPor = SharePointObj.CreadoPor__c;
        String str_Descripcion = SharePointObj.Descripcion__c;
        //String str_Direccion = SharePointObj.Direccion__c;
        //String str_Estado = SharePointObj.Estado__c;
        String str_EstatusSolicitud = SharePointObj.EstatusSolicitud__c;
        //String str_FechaFirmaContrato = SharePointObj.FechaFirmaContrato__c;
        //String str_FechaInicioObra = SharePointObj.FechaInicioObra__c;
        //String str_FechaTerminoObra = SharePointObj.FechaTerminoObra__c;
        //String str_Fianza = SharePointObj.Fianza__c;
        //String str_FondoGarantiaDias = SharePointObj.FondoGarantiaDias__c;
        //String str_FondoGarantiaPorciento = SharePointObj.FondoGarantiaPorciento__c;
        //String str_Fraccionamiento = SharePointObj.Fraccionamiento__c;
        //String str_ImporteAccesorios = SharePointObj.ImporteAccesorios__c;
        //String str_ImporteAnticipo = SharePointObj.ImporteAnticipo__c;
        //String str_ImporteContrato = SharePointObj.ImporteContrato__c;
        //String str_ImporteMolde = SharePointObj.ImporteMolde__c;
        //String str_LineaProductos = SharePointObj.LineaProductos__c;
        //String str_No = SharePointObj.No__c;
        String str_Nombre = SharePointObj.Nombre__c;
        String str_NombreJefe = SharePointObj.NombreJefe__c;
        //String str_NomRepLegal = SharePointObj.NomRepLegal__c;
        //String str_Numero = SharePointObj.Numero__c;
        //String str_Obraoadmin = SharePointObj.Obraoadmin__c;
        //String str_platform = SharePointObj.platform__c;
        //String str_RazonSocialNombre = SharePointObj.RazonSocialNombre__c;
        //String str_Rfc = SharePointObj.Rfc__c;
        //String str_Static = SharePointObj.Static__c;
        //String str_SubCategoria = SharePointObj.SubCategoria__c;
        //String str_Suministro = SharePointObj.Suministro__c;
        //String str_Suplente = SharePointObj.Suplente__c;
        //String str_TipoContrato = SharePointObj.TipoContrato__c;
        String str_TipoInsumo = SharePointObj.TipoInsumo__c;
        //String str_TipoProveedor = SharePointObj.TipoProveedor__c;
        //String str_Tramite = SharePointObj.Tramite__c;
        String str_UEN = SharePointObj.UEN__c;
        //String str_UnidadMedida = SharePointObj.UnidadMedida__c;
        //String str_Usuario = SharePointObj.Usuario__c;
        String str_UsuarioJefeInmediato = SharePointObj.UsuarioJefeInmediato__c;
        
        
        Map <String, Id> map_strEmpClave_UsrId = new Map <String, Id>();
        for (User objUsr: [SELECT Id, UserSharePoint__c FROM User LIMIT 10000] ){
            if (objUsr.UserSharePoint__c!=null || objUsr.UserSharePoint__c!='' ){
                map_strEmpClave_UsrId.put(objUsr.UserSharePoint__c, objUsr.Id);
            }
            
        }
        
        //strEmpRequesterID = ApprvObj.requesterEmpId__c;
        //strEmpApproverID = ApprvObj.approverEmpId__c;
        //strApprovalID = ApprvObj.approvalId__c;
        //strToken = ApprvObj.token__c;
        //String strAppvObjLevel = ApprvObj.approvalLevel__c;
        ///String strAppvObjFrccName = ApprvObj.approvalLevelValue__c;
        
        
        for(ApprovalDataSP__c ApprvData:[SELECT Id, Name, Numero_de_Lista__c FROM ApprovalDataSP__c WHERE SharePointObj_Buscar__c = :SharePointObj.Id ] ){
            if (ApprvData.Numero_de_Lista__c == 1){
                idApprovalData_1 = ApprvData.Id;
            }
            
        }
        // Obtiene datos del unico record de la lista relacionada 1
        // Obtiene datos de varios records de la lista relacionada 2
        Set<Id> set_idRecord = new Set<Id>();
        
        for (recordSP__c Record :[SELECT Id, Name FROM recordSP__c WHERE ApprovalDataSP_Buscar__c = :idApprovalData_1  ORDER BY Name Asc] ){
            set_idRecord.add(Record.Id);
        }
        //System.Debug('***set_idRecord*** '+set_idRecord);
        
        List<Insumo_de_Obra__c> list_objInsumoObra = new List<Insumo_de_Obra__c>();
        String strRecordBuscar='';
        Insumo_de_Obra__c InsumoObraNew;
        for (fieldSP__c Field :[SELECT Id, Name, Value__c, RecordSP_Buscar__c FROM fieldSP__c WHERE RecordSP_Buscar__c IN :set_idRecord ORDER BY RecordSP_Buscar__c ] ){
            System.Debug('***Field*** '+ Field);
            String strRecordBuscarField = Field.RecordSP_Buscar__c;
            //System.Debug('***strRecordBuscarField*** '+ strRecordBuscarField);
            //System.Debug('***strRecordBuscar*** '+ strRecordBuscar);
            if (strRecordBuscarField!= strRecordBuscar){
                if (strRecordBuscar!=''){
                    list_objInsumoObra.add(InsumoObraNew);
                } 
                InsumoObraNew = new Insumo_de_Obra__c();    
                if (Field.Name=='No'){
                    InsumoObraNew.No__c = Field.Value__c;
                } else if (Field.Name=='Categoria'){
                    InsumoObraNew.Categoria__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='SubCategoria'){
                    InsumoObraNew.SubCategoria__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='Consecutivo'){
                    InsumoObraNew.Consecutivo__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='Descripcion'){
                    InsumoObraNew.Descripcion__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='UnidadMedida'){
                    InsumoObraNew.UnidadMedida__c = asignaOLimpiaValor(Field.Value__c);
                }
                
                
                strRecordBuscar = Field.RecordSP_Buscar__c;
                
            } else {
                if (Field.Name=='No'){
                    InsumoObraNew.No__c = Field.Value__c;
                } else if (Field.Name=='Categoria'){
                    InsumoObraNew.Categoria__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='SubCategoria'){
                    InsumoObraNew.SubCategoria__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='Consecutivo'){
                    InsumoObraNew.Consecutivo__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='Descripcion'){
                    InsumoObraNew.Descripcion__c = asignaOLimpiaValor(Field.Value__c);
                } else if (Field.Name=='UnidadMedida'){
                    InsumoObraNew.UnidadMedida__c = asignaOLimpiaValor(Field.Value__c);
                }
            }
        }
        set_idRecord.removeAll( new Set<Id>(set_idRecord) );
        list_objInsumoObra.add(InsumoObraNew);
        System.Debug('***list_objInsumoObra*** '+list_objInsumoObra);
           
        
            
        
        
        
        //System.Debug('***list_objEmailProv 1*** '+list_objEmailProv); 
        
        //System.Debug('***map_strEmpClave_UsrId*** '+map_strEmpClave_UsrId);
        Insumo__c objInsumo;
        if(map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)!=null ){
            System.Debug('***if(map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)!=null )*** ');
            objInsumo = new Insumo__c(Name = SharePointObj.Name
                                                        , Aprobador_Buscar__c= map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)
                                                    
                                                        , OwnerId = map_strEmpClave_UsrId.get(SharePointObj.approverEmpId__c)
                                            
                                                        //, TipoXML__c = str_TipoXML 
                                                        //, NoDocumento__c = str_NoDocumento
                                                        , Area__c = str_Area
                                                        //, Listas__c = str_Listas
                                                        //, ApoderadoLegal__c = str_ApoderadoLegal
                                                        , Accion__c = str_Accion
                                                        //, approverEmpId__c = str_approverEmpId
                                                        //, Categoria__c = str_Categoria
                                                        //, CentroCosto__c = str_CentroCosto
                                                        //, Ciudad__c = str_Ciudad
                                                        , Comentario__c = str_Comentario
                                                        //, Comentarios__c = str_Comentarios
                                                        //, CompaniasKontrol__c = str_CompaniasKontrol
                                                        //, Concepto__c = str_Concepto
                                                        //, Conjunto__c = str_Conjunto
                                                        //, Consecutivo__c = str_Consecutivo
                                                        //, ContactoVendedor__c = str_ContactoVendedor
                                                        //, Contratante__c = str_Contratante
                                                        //, Contratista__c = str_Contratista
                                                        , Creado__c = str_Creado
                                                        , CreadoPor__c = str_CreadoPor
                                                        , Descripcion__c = str_Descripcion
                                                        //, Direccion__c = str_Direccion
                                                        //, Estado__c = str_Estado
                                                        , EstatusSolicitud__c = str_EstatusSolicitud
                                                        //, FechaFirmaContrato__c = str_FechaFirmaContrato
                                                        //, FechaInicioObra__c = str_FechaInicioObra
                                                        //, FechaTerminoObra__c = str_FechaTerminoObra
                                                        //, Fianza__c = str_Fianza
                                                        //, FondoGarantiaDias__c = str_FondoGarantiaDias
                                                        //, FondoGarantiaPorciento__c = str_FondoGarantiaPorciento
                                                        //, Fraccionamiento__c = str_Fraccionamiento
                                                        //, ImporteAccesorios__c = str_ImporteAccesorios
                                                        //, ImporteAnticipo__c = str_ImporteAnticipo
                                                        //, ImporteContrato__c = str_ImporteContrato
                                                        //, ImporteMolde__c = str_ImporteMolde
                                                        //, LineaProductos__c = str_LineaProductos
                                                        //, No__c = str_No
                                                        , Nombre__c = str_Nombre
                                                        , NombreJefe__c = str_NombreJefe
                                                        //, NomRepLegal__c = str_NomRepLegal
                                                        //, Numero__c = str_Numero
                                                        , Obraoadmin__c = str_Obraoadmin
                                                        //, platform__c = str_platform
                                                        //, RazonSocialNombre__c = str_RazonSocialNombre
                                                        //, Rfc__c = str_Rfc
                                                        //, Static__c = str_Static
                                                        //, SubCategoria__c = str_SubCategoria
                                                        //, Suministro__c = str_Suministro
                                                        //, Suplente__c = str_Suplente
                                                        //, TipoContrato__c = str_TipoContrato
                                                        , TipoInsumo__c = str_TipoInsumo
                                                        //, TipoProveedor__c = str_TipoProveedor
                                                        //, Tramite__c = str_Tramite
                                                        , UEN__c = str_UEN
                                                        //, UnidadMedida__c = str_UnidadMedida
                                                        //, Usuario__c = str_Usuario
                                                        , UsuarioJefeInmediato__c = str_UsuarioJefeInmediato
                                            
                                                        );
            
            try{
                insert objInsumo;
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } //catch
            
            
            
            if ((!list_objInsumoObra.IsEmpty()  && list_objInsumoObra!=NULL) && objInsumo!=null){
                List<Insumo_de_Obra__c> list_InsumoObra_Ins = new List<Insumo_de_Obra__c>();
                Integer NumeroLista =1;
                for(Insumo_de_Obra__c InsumoObra2Ins : list_objInsumoObra){
                    if (InsumoObra2Ins!=null){
                        InsumoObra2Ins.Name = String.ValueOf(NumeroLista++);
                        InsumoObra2Ins.Insumo_Buscar__c= objInsumo.Id;
                        list_InsumoObra_Ins.add(InsumoObra2Ins);
                    }
                    
                }
                if (!list_InsumoObra_Ins.IsEmpty()){
                    try{
                        insert list_InsumoObra_Ins;
                    } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                    } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                    } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                    } //catch
                }
            
            } 
            // No presenta lista relacionada
            else { try { throw new ErrorProcesoException();} catch (ErrorProcesoException e) { String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.descripcion__c = 'El XML que se ha enviado a Salesforce no presenta lista relacionada.'; newCatch.Causa__c = 'El XML no tiene lista relacionada.' ; newCatch.StackTrace__c = e.getStackTraceString(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }}
            }
            
            
         } else {
                try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                            String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('NullPointerException').getRecordTypeId(); 
                            Catch__c newCatch = new Catch__c();
                            newCatch.RecordTypeId = rtCatch;
                            newCatch.descripcion__c = 'El campo de <Aprobador> con el valor: '+ str_approverEmpId+' no fue encontrado entre los Usuarios para declararlo como Aprobador.';
                            newCatch.Causa__c = 'El Valor de <Aprobador> no es valido como aprobador.' ;
                            newCatch.StackTrace__c = e.getStackTraceString();
                            newCatch.SharePointObj_Buscar__c = SharePointObj.Id;
                            Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                }    
        }
        return objInsumo;
     }
    
          
  /******************************************************************************
        Métodos obtener valores de elementos
    */ 
  private static String obtenerValor(XmlStreamReader reader) {
      String valor = '';
    while(reader.hasNext()) {
          //System.Debug('***reader.getEventType()*** '+ reader.getEventType());
          
          
          if (reader.getEventType() == XmlTag.END_ELEMENT) {
               break;
          } else if (reader.getEventType() == XmlTag.CHARACTERS) {
               //System.Debug('***reader.getText()*** '+ reader.getText() );
               valor = asignaOLimpiaValor(reader.getText());
          }
      reader.next();
       }
       return valor;
  }
    
  
    
  
    
    /******************************************************************************
        Métodos obtener valores de secciones
    */        

    public static ApprovalDataSP__c obtenerValorlistOfApprovalData(XmlStreamReader reader, String localName, Id idParent) {
        
        ApprovalDataSP__c objApprovalData = new ApprovalDataSP__c();
        //contador_ApprovalData = 0;
        Datos datos= new Datos();
        contador_ApprovalData+=1;
        while(reader.hasNext()) {
              //System.Debug('***reader w*** '+ reader);
              if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == localName) {
                   //System.Debug('***reader if 1*** '+ reader);
                   break;
              } else if(reader.getEventType() == XmlTag.START_ELEMENT) {
                      //System.Debug('***reader if 3*** '+ reader);
                      //ApprovalData__c objApprovalData = new ApprovalData__c();
                      //System.Debug('***objApprovalData 0*** '+objApprovalData );
                      
                      objApprovalData.Numero_de_Lista__c = contador_ApprovalData;
                      objApprovalData.Name = String.ValueOf(contador_ApprovalData);
                      
                      
                      //System.Debug('***objApprovalData*** '+objApprovalData );
                      //System.Debug('*** objApprovalData 1*** '+  objApprovalData);
                      datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord.add(obtenerValorlistOfRecords(reader, 'record', Integer.ValueOf(objApprovalData.Numero_de_Lista__c)));
                      //System.Debug('*** datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord*** '+  datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord);
                      if (datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord.size()>0){
                          for (recordSP__c objRecord : datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord){
                              if(map_intNumLista_listrecord.get(Integer.ValueOf(objApprovalData.Numero_de_Lista__c))!=null){
                                  map_intNumLista_listrecord.get(Integer.ValueOf(objApprovalData.Numero_de_Lista__c)).add(objRecord);
                              } else {
                                  map_intNumLista_listrecord.put(Integer.ValueOf(objApprovalData.Numero_de_Lista__c), new List<recordSP__c>{objRecord});      
                              } 
                          } 
                      }
                      
              } 
          
          reader.next();
        }
        objApprovalData.SharePointObj_Buscar__c= idParent;
        //System.Debug('*** map_intNumLista_listrecord*** '+  map_intNumLista_listrecord);
        //System.Debug('*** datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord 2*** '+  datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.listarecord);
        return objApprovalData;
    }
    
    
 
   
    
    public static recordSP__c obtenerValorlistOfRecords(XmlStreamReader reader, String localName, Integer intNumListaBuscar) {
        
        recordSP__c record = new recordSP__c();
        //contador_record = 0;
        Datos datos= new Datos();
        contador_record+=1;
        while(reader.hasNext()) {
              //System.Debug('***reader w*** '+ reader);
              if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == localName) {
                   //System.Debug('***reader if 1*** '+ reader);
                   break;
              } else if(reader.getEventType() == XmlTag.START_ELEMENT) {
                      //System.Debug('***record 0*** '+ record);
                      
                      record.Numero_de_Lista__c = contador_record;     
                      record.Name  = 'R-'+String.ValueOf(contador_record)+'-'+String.ValueOf(intNumListaBuscar);
                      //System.Debug('***record 1*** '+ record);
                      datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.FieldClass.listafield.add(obtenerValorlistOfFields(reader, 'field', Integer.ValueOf( record.Numero_de_Lista__c)  ));
                      if (datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.FieldClass.listafield.size()>0){
                          
                          for (fieldSP__c objField : datos.cadenaXML.datosSiebel.approvalDataClass.recordClass.FieldClass.listafield){
                              if(map_intNumLista_listfield.get(Integer.ValueOf(record.Numero_de_Lista__c))!=null){
                                  map_intNumLista_listfield.get(Integer.ValueOf(record.Numero_de_Lista__c)).add(objField);
                              } else {
                                  map_intNumLista_listfield.put(Integer.ValueOf(record.Numero_de_Lista__c), new List<fieldSP__c>{objField});      
                              } 
                          } 
                      }
                      
              } 
          reader.next();
        }
        record.Numero_de_Lista_Buscar__c= intNumListaBuscar;
        //System.Debug('***map_intNumLista_listfield*** '+ map_intNumLista_listfield);
        return record;
    }
    

    
    private static fieldSP__c obtenerValorlistOfFields(XmlStreamReader reader, String localName , Integer intNumListaBuscar ) {
       
        fieldSP__c field = new fieldSP__c();
        //contador_field = 0;
        //Datos datos= new Datos();
        while(reader.hasNext()) {
              
              if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == localName) {
                   break;
              } else if(reader.getEventType() == XmlTag.START_ELEMENT) {
                      
                      if(reader.getLocalName() == 'name') {
                            field.Name = obtenerValor(reader);
                        } else if(reader.getLocalName() == 'value') {
                            field.Value__c = obtenerValor(reader);
                        } 
                      
                      //System.Debug('***field 1*** '+ field);
              }
          reader.next();
        }
        field.Llave_Compuesta__c = String.ValueOf(intNumListaBuscar)+'-'+ field.Name;
        field.Numero_de_Lista_Buscar__c= intNumListaBuscar;
        //System.Debug('***field*** '+ field);
        return field;
    }
    
    
    
  /******************************************************************************
        Métodos Generales
    */
  private static String asignaOLimpiaValor(String valor) {
        String nuevoValor = valor != null ? valor : '';
        return nuevoValor;
    }
    

    
  private static Date asignaOLimpiaValorDateFormatoMx(String valor) {
    // Reemplazamos el año 9999 con 4000
    //<apex:variable value="{!LEFT(stageKey,(FIND(':', stageKey) - 1))}" var="Folio"/>
    //                        <apex:variable value="{!RIGHT(stageKey, (LEN(stageKey) - FIND(':', stageKey) - 1  ))}" var="strSinFolio"/>
    //                        <apex:variable value="{!LEFT(strSinFolio,(FIND(':', strSinFolio) - 1))}" var="Inicio"/>
    //                        <apex:variable value="{!RIGHT(strSinFolio, (LEN(strSinFolio) - FIND(':', strSinFolio) - 1  ))}" var="strSinInicio"/>
    //                        <apex:variable value="{!LEFT(strSinInicio,(FIND(':', strSinInicio) - 1))}" var="Fin"/>
    //                        <apex:variable value="{!RIGHT(strSinInicio, (LEN(strSinInicio) - FIND(':', strSinInicio) - 1  ))}" var="strSinFin"/>
    //                        <apex:variable value="{!LEFT(strSinFin,(FIND(':', strSinFin) - 1))}" var="Tipo"/>
    //                        <apex:variable value="{!RIGHT(strSinFin, (LEN(strSinFin) - FIND(':', strSinFin) - 1  ))}" var="strSinTipo"/>
    //                        <apex:variable value="{!LEFT(strSinTipo,(FIND(':', strSinTipo) - 1))}" var="Desc"/>
     if(valor!=null){
    //if (LEN(valor)>0){
        
                //date fecha = date.valueOf(fechaTexto.substring(0,4)+'-'+fechaTexto.substring(4,6)+'-'+fechaTexto.substring(6,8) + ' ' + '00' + ':' + '00' + ':' + '00');
                
        // 10/31/2014
        String strMes = valor.substring(0,2);
        System.Debug('*** valor Despues de Mes*** '+valor);
        System.Debug('*** strMes *** '+strMes);
        //String strFechaSinMes = RIGHT(valor, (LEN(valor) - valor.indexOf('/') - 1  ));
        String strDia = valor.substring(3,5);
        System.Debug('*** strDia *** '+strDia);
        System.Debug('*** valor Despues de Dia*** '+valor);
        //String strFechaSinDia = RIGHT(strFechaSinMes, (LEN(strFechaSinMes) - strFechaSinMes.indexOf('/') - 1  ));
        String strAnio = valor.substring(6);
        System.Debug('*** strAnio *** '+strAnio);
        System.Debug('*** valor Despues de Anio*** '+valor);
        valor =  strMes+'-'+strDia+'-'+strAnio;
        //valor =  strMes+'/'+strDia+'/'+strAnio;
        System.Debug('*** valor Nuevo*** '+valor);
        
        //valor = valor.substring(3,4)+'/'+valor.substring(0,1)+'/'+valor.substring(8) ;
    }
    valor = valor.replace('9999', '4000');
        Date nuevoValor = valor != null ? Date.valueOf(valor) : null;
        return nuevoValor;
    }
    
    private static Date asignaOLimpiaValorDateFormatoMxValueOf(String valor) {
    // Reemplazamos el año 9999 con 4000
    //<apex:variable value="{!LEFT(stageKey,(FIND(':', stageKey) - 1))}" var="Folio"/>
    //                        <apex:variable value="{!RIGHT(stageKey, (LEN(stageKey) - FIND(':', stageKey) - 1  ))}" var="strSinFolio"/>
    //                        <apex:variable value="{!LEFT(strSinFolio,(FIND(':', strSinFolio) - 1))}" var="Inicio"/>
    //                        <apex:variable value="{!RIGHT(strSinFolio, (LEN(strSinFolio) - FIND(':', strSinFolio) - 1  ))}" var="strSinInicio"/>
    //                        <apex:variable value="{!LEFT(strSinInicio,(FIND(':', strSinInicio) - 1))}" var="Fin"/>
    //                        <apex:variable value="{!RIGHT(strSinInicio, (LEN(strSinInicio) - FIND(':', strSinInicio) - 1  ))}" var="strSinFin"/>
    //                        <apex:variable value="{!LEFT(strSinFin,(FIND(':', strSinFin) - 1))}" var="Tipo"/>
    //                        <apex:variable value="{!RIGHT(strSinFin, (LEN(strSinFin) - FIND(':', strSinFin) - 1  ))}" var="strSinTipo"/>
    //                        <apex:variable value="{!LEFT(strSinTipo,(FIND(':', strSinTipo) - 1))}" var="Desc"/>
     if(valor!=null){
    //if (LEN(valor)>0){
        
                //date fecha = date.valueOf(fechaTexto.substring(0,4)+'-'+fechaTexto.substring(4,6)+'-'+fechaTexto.substring(6,8) + ' ' + '00' + ':' + '00' + ':' + '00');
                
        // 10/31/2014
        String strMes = valor.substring(0,2);
        System.Debug('*** valor Despues de Mes*** '+valor);
        System.Debug('*** strMes *** '+strMes);
        //String strFechaSinMes = RIGHT(valor, (LEN(valor) - valor.indexOf('/') - 1  ));
        String strDia = valor.substring(3,5);
        System.Debug('*** strDia *** '+strDia);
        System.Debug('*** valor Despues de Dia*** '+valor);
        //String strFechaSinDia = RIGHT(strFechaSinMes, (LEN(strFechaSinMes) - strFechaSinMes.indexOf('/') - 1  ));
        String strAnio = valor.substring(6);
        System.Debug('*** strAnio *** '+strAnio);
        System.Debug('*** valor Despues de Anio*** '+valor);
        valor =  strAnio +'-'+ strMes +'-'+strDia;
        //valor =  strMes+'/'+strDia+'/'+strAnio;
        System.Debug('*** valor Nuevo*** '+valor);
        
        //valor = valor.substring(3,4)+'/'+valor.substring(0,1)+'/'+valor.substring(8) ;
        valor = valor.replace('9999', '4000');
    }
    
        Date nuevoValor = valor != null ? Date.valueOf(valor) : null;
        return nuevoValor;
    }
    
    
    
    public static String protocolAndHost() {
        String protocolAndHost_var;
                String orgId = UserInfo.getOrganizationId();
                String userId = UserInfo.getUserId();
                String sessionId = UserInfo.getSessionId();
    
                //we can trust getSalesforceBaseUrl within batches and schedules (but not in VF)
                if (sessionId == null) return Url.getSalesforceBaseUrl().toExternalForm().replace('http:', 'https:');
    
                PageReference pr = new PageReference('/id/' + orgId + '/' + userId);
                pr.getParameters().put('oauth_token', sessionId);
                pr.getParameters().put('format', 'json');
    
                //within test context use url class, else derive from identity api
                String data = Test.isRunningTest() ? '{"urls": {"rest": "' + Url.getSalesforceBaseUrl().toExternalForm() + '"}}' : pr.getContent().toString();
                Map<String,Object> result = (Map<String,Object>)Json.deserializeUntyped(data);
                Map<String,Object> urls = (Map<String,Object>)result.get('urls');
                Url rest = new Url((String)urls.get('rest'));
                protocolAndHost_var = rest.getProtocol() + '://' + rest.getHost();
           
    
            return protocolAndHost_var;
        
    }

  /******************************************************************************
        Métodos de Error
    */
  

    private class ErrorProcesoException extends Exception { }
  
  /******************************************************************************
        Métodos de Respuesta
    */
    @future(callout=true)
    public static void Envia_RespuestaSP(String strToken, String strAccion, String strIDObjetoRespuesta){
                
        try {
            Sistema__c Sistema = new Sistema__c();
            
            String cert;
            
            
            if (!Test.isRunningTest()) { 
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c, Cert_Password__c, Certificado_Autofirmado__c FROM Sistema__c WHERE Name='Configuracion en Javer ShPn Util' LIMIT 1 ];
            	if (Sistema.Certificado_Rec_Estatico__c!=null && Sistema.Cert_Password__c!=null ){
                    for (StaticResource sr : [Select Id, Body from StaticResource where Name =: Sistema.Certificado_Rec_Estatico__c]){
                        cert = EncodingUtil.base64Encode(sr.Body);
                    }
                }
            }else {
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c FROM Sistema__c WHERE Name='Configuracion en Javer ShPn Util-Test' LIMIT 1 ];
            }
            
            System.Debug('***Sistema*** '+ Sistema );
            System.Debug('***strToken*** '+ strToken );
            System.Debug('***strAccion*** '+ strAccion );
            System.Debug('***strIDObjetoRespuesta*** '+ strIDObjetoRespuesta );
            String s='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">'+
                           '<soapenv:Header/>'+
                           '<soapenv:Body>'+
                              '<tem:RegAprov>'+
                                 '<tem:token>' + strToken + '</tem:token>'+
                                 '<tem:action>' + strAccion + '</tem:action>'+
                                 '<tem:src>5</tem:src>'+
                              '</tem:RegAprov>'+
                           '</soapenv:Body>'+
                    '</soapenv:Envelope>';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Sistema.End_Point__c);
            //req.setEndpoint('https://ws.javer.com.mx:4390/WS/Wrapper1.svc');
            //https://qws.javer.com.mx:5532/WS/JWS_Wrapper.svc
            //req.setEndpoint('https://qws.javer.com.mx:5532/WS/Wrapper1.svc');
            req.setMethod('POST');
            req.setBody(s);
            req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
           
            
            req.setHeader('SOAPAction', '"http://tempuri.org/IWrapper1/RegAprov"');
            req.setHeader('Accept-Encoding', 'gzip,deflate');
                        
            req.setTimeout(120000);
            //if (!Test.isRunningTest() && cert!=null && Sistema.Cert_Password__c!=null) { 
            //	req.setClientCertificate(cert, Sistema.Cert_Password__c);
            //}
            
            //req.setClientCertificateName('SelfSignedCert_11Feb2015_172324');
            req.setClientCertificateName(Sistema.Certificado_Autofirmado__c);
            Http http = new Http();                                   
            HTTPResponse res = http.send(req);
            
            // Guardamos la respuesta como string
            String respuesta = '<?xml version="1.0"?>'+res.getBody();
            System.debug('***respuesta: **** '+respuesta);
            try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                            String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('CallOut').getRecordTypeId(); 
                            Catch__c newCatch = new Catch__c();
                            newCatch.RecordTypeId = rtCatch;
                            if (respuesta.length()>2450){
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta.SubString(0,2449)+' (...). *** Respuesta parcial por motivos de formato. Consulte al Administrador de Salesforce para conocer los detalles.';
                            } else{
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta;
                            }
                            if(respuesta.contains('n Exitosa')){
                                newCatch.Causa__c = 'Respuesta-SharePoint : Aprobación Exitosa';
                            } else if(respuesta.contains('No Aprobado')) {
                                newCatch.Causa__c = 'Respuesta-SharePoint : No aprobado';
                            }  else if(respuesta.contains('Ya se')) {
                                newCatch.Causa__c = 'Respuesta-SharePoint : Ya se había aprobado';
                            }else {
                                newCatch.Causa__c = 'Respuesta-SharePoint : Sin respuesta catalogada';
                            }
                        
                            
                            newCatch.StackTrace__c = e.getStackTraceString();
                            Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }
             
            SharePointObj__c SharePointObj= [SELECT Id
                                        , Name , Id_Objeto_A_Aprobar_Buscar__c
                                        , Estatus__c
                                        FROM SharePointObj__c 
                                         WHERE  Id_Objeto_A_Aprobar_Buscar_15__c = : strIDObjetoRespuesta 
                                         OR
                                         Id_Objeto_A_Aprobar_Buscar__c = : strIDObjetoRespuesta LIMIT 1 ];
            SharePointObj.Estatus__c  = strAccion == '0' ? 'Rechazada' : 'Aprobada'; 
            SharePointObj.Respuesta_Larga_SharePoint__c = respuesta;
            try{
              update SharePointObj; 
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } //catch
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.Registro_Salesforce_URL__c = protocolAndHost()+'/'+strIDObjetoRespuesta; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    }
    
    
    @future(callout=true)
    WebService static void WS_Envia_RespuestaSP(String strToken, String strAccion, String strIDObjetoRespuesta) {
    //public static void Envia_RespuestaSP(String strToken, String strAccion, String strIDObjetoRespuesta){
                
        try {
            Sistema__c Sistema = new Sistema__c();
            
            
            if (!Test.isRunningTest()) { 
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c, Certificado_Autofirmado__c FROM Sistema__c WHERE Name='Configuracion en Javer ShPn Util' LIMIT 1 ];
            
            }else {
                Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c FROM Sistema__c WHERE Name='Configuracion en Javer ShPn Util-Test' LIMIT 1 ];
            }
            
            System.Debug('***Sistema*** '+ Sistema );
            System.Debug('***strToken*** '+ strToken );
            System.Debug('***strAccion*** '+ strAccion );
            System.Debug('***strIDObjetoRespuesta*** '+ strIDObjetoRespuesta );
            String s='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">'+
                           '<soapenv:Header/>'+
                           '<soapenv:Body>'+
                              '<tem:RegAprov>'+
                                 '<tem:token>' + strToken + '</tem:token>'+
                                 '<tem:action>' + strAccion + '</tem:action>'+
                                 '<tem:src>5</tem:src>'+
                              '</tem:RegAprov>'+
                           '</soapenv:Body>'+
                    '</soapenv:Envelope>';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Sistema.End_Point__c);
            
            //req.setEndpoint('https://ws.javer.com.mx:4390/WS/Wrapper1.svc');
            //https://qws.javer.com.mx:5532/WS/JWS_Wrapper.svc
            //req.setEndpoint('https://qws.javer.com.mx:5532/WS/Wrapper1.svc');
            
            req.setMethod('POST');
            req.setBody(s);
            req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
           
            
            req.setHeader('SOAPAction', '"http://tempuri.org/IWrapper1/RegAprov"');
            req.setHeader('Accept-Encoding', 'gzip,deflate');
                        
            req.setTimeout(120000);
            //if (!Test.isRunningTest() && cert!=null && Sistema.Cert_Password__c!=null) { 
            //	req.setClientCertificate(cert, Sistema.Cert_Password__c);
            //}
            
            //req.setClientCertificateName('SelfSignedCert_11Feb2015_172324');
            if (Sistema.Certificado_Autofirmado__c !=null){
            	req.setClientCertificateName(Sistema.Certificado_Autofirmado__c);    
            }
            
            Http http = new Http();                                   
            HTTPResponse res = http.send(req);
            
            // Guardamos la respuesta como string
            String respuesta = '<?xml version="1.0"?>'+res.getBody();
            System.debug('***respuesta: **** '+respuesta);
            try { throw new ErrorProcesoException();
                } catch (ErrorProcesoException e) { 
                            String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('CallOut').getRecordTypeId(); 
                            Catch__c newCatch = new Catch__c();
                            newCatch.RecordTypeId = rtCatch;
                            if (respuesta.length()>2450){
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta.SubString(0,2449)+' (...). *** Respuesta parcial por motivos de formato. Consulte al Administrador de Salesforce para conocer los detalles.';
                            } else{
                                newCatch.descripcion__c = 'Respuesta es: '+respuesta;
                            }
                        if(respuesta.contains('exito')){
                                newCatch.Causa__c = 'Respuesta-SharePoint : Aprobación Exitosa';
                            } else if(respuesta.contains('No Aprobado')) {
                                newCatch.Causa__c = 'Respuesta-SharePoint : No aprobado';
                            }  else if(respuesta.contains('Ya se')) {
                                newCatch.Causa__c = 'Respuesta-SharePoint : Ya se había aprobado';
                            }else {
                                newCatch.Causa__c = 'Respuesta-SharePoint : Sin respuesta catalogada';
                            }
                        
                            
                            newCatch.StackTrace__c = e.getStackTraceString();
                            Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            }
             
            SharePointObj__c SharePointObj= [SELECT Id
                                        , Name , Id_Objeto_A_Aprobar_Buscar__c
                                        , Estatus__c
                                        FROM SharePointObj__c 
                                         WHERE  Id_Objeto_A_Aprobar_Buscar_15__c = : strIDObjetoRespuesta 
                                         OR
                                         Id_Objeto_A_Aprobar_Buscar__c = : strIDObjetoRespuesta LIMIT 1 ];
            SharePointObj.Estatus__c  = strAccion == '0' ? 'Rechazada' : 'Aprobada'; 
            SharePointObj.Respuesta_Larga_SharePoint__c = respuesta;
            try{
              update SharePointObj; 
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
            } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.SharePointObj_Buscar__c = SharePointObj.Id; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
            } //catch
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
        } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
        } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.Registro_Salesforce_URL__c = protocolAndHost()+'/'+strIDObjetoRespuesta; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
        } //catch
    }
  
  
  /******************************************************************************
        Métodos Web Services y de entrada de ejecución
    */     
    webservice static void buscarYProcesarArchivoSP(Id idArchivoXML) {
      XML_SharePoint__c archivoXML = [SELECT Id
                       FROM XML_SharePoint__c
                      WHERE Id = : idArchivoXML
                      LIMIT 1];
    System.Debug('*** archivoXML *** '+archivoXML); 
    Attachment doc = [SELECT Id, ParentId, Name, Body
                FROM Attachment
               WHERE ParentId = : idArchivoXML
            ORDER BY CreatedDate desc
               LIMIT 1];
    System.Debug('*** doc *** '+doc); 
    procesarArchivoSP(idArchivoXML, doc.Id);
    }
    
  @future
  public static void procesarArchivoSP_A(Id registro, Id idArchivo) {
    Javer_ShPn_Util.archivoXMLIdParent = registro;
    Attachment doc = [SELECT Id, Name, Body
                FROM Attachment
               WHERE Id = : idArchivo
               LIMIT 1];
    //EncodingUtil.base64Decode()
    XmlStreamReader reader = new XmlStreamReader(doc.Body.toString());
    Javer_ShPn_Util.descargaParseXMLSP(reader);
  }
  
  @future
  public static void procesarArchivoSP(Id registro, Id idArchivo) {
    Javer_ShPn_Util.archivoXMLIdParent = registro;
    Attachment doc = [SELECT Id, Name, Body
                FROM Attachment
               WHERE Id = : idArchivo
               LIMIT 1];
    // Define the email
    Sistema__c Sistema = new Sistema__c();
    if (!Test.isRunningTest()) { 
        Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c FROM Sistema__c WHERE Name='Configuracion en Javer ShPn Util' LIMIT 1 ];
    }else {
        Sistema = [SELECT Id, Name, Correo_Recep_XML_Asunto__c, Correo_Recep_XML_Mensaje__c , Correo_Recep_XML_Direcciones__c, End_Point__c, Certificado_Rec_Estatico__c FROM Sistema__c WHERE Name='Configuracion en Javer ShPn Util-Test' LIMIT 1 ];
    }
    
    System.Debug('*** Sistema *** '+Sistema);
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        // Take the PDF content
        Blob b = doc.body;
        // Create the email attachment
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        Datetime dtAhora = System.Now();
        System.Debug('***dtAhora*** '+dtAhora);
        String strFechaHora = String.ValueOf(dtAhora);
        System.Debug('***strFechaHora *** '+strFechaHora );
        
        String regExp = ' ';
        String replacement = '_';
        String strFechaHoraReplace = strFechaHora.replaceAll(regExp, replacement);
        System.Debug('***strFechaHoraReplace 1 *** '+strFechaHoraReplace );
        regExp = ':';
       
        strFechaHoraReplace = strFechaHoraReplace.replaceAll(regExp, replacement);
        System.Debug('***strFechaHoraReplace 2 *** '+strFechaHoraReplace );
        efa.setFileName( strFechaHoraReplace+'.xml');
        efa.setBody(b);

      if (Sistema!=null && Sistema.Name!='' && Sistema.Name!=null ){String addresses=Sistema.Correo_Recep_XML_Direcciones__c; String[] toAddresses = addresses.split(':', 0); String subject = Sistema.Correo_Recep_XML_Asunto__c; String body = Sistema.Correo_Recep_XML_Mensaje__c; email.setSubject( subject ); email.setToAddresses( toAddresses ); email.setPlainTextBody( body ); email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        //String addresses='pruebasblein@gmail.com:odeanda@javer.com.mx:hugo.ruiz@obelit.com:rmaldonado@javer.com.mx'
        //String subject ='Recepcion de XML en Ambiente de SandBox';
        //String body =' Se ha recibido en Salesforce Produccion el ar
        // Sets the paramaters of the email
        // Sends the email
        // 
        try{
          Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.XML_Siebel_Buscar__c = registro; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
         
    }
    
  //
  //
    //EncodingUtil.base64Decode()
      XmlStreamReader reader;
      try{
          reader = new XmlStreamReader(doc.Body.toString());
      } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } }
                } catch(AssertException e) {  if (e!=null){ if (e.getMessage()!=null){ String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause(); strCause = ExceptionCause.getMessage(); } String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('AssertException').getRecordTypeId();  Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Causa__c = strCause; newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } }
                } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); newCatch.XML_Siebel_Buscar__c = registro; String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.SaveResult sr = Database.insert(newCatch,false); if (sr.isSuccess()) { System.debug('Successfully inserted record. Record ID: ' + sr.getId()); } else {  for(Database.Error err : sr.getErrors()) { System.debug('The following error has occurred.');  System.debug(err.getStatusCode() + ': ' + err.getMessage()); System.debug('User fields that affected this error: ' + err.getFields()); } } } } 
                } //catch
    System.Debug('*** reader  *** '+reader );
    ///XmlStreamReader reader = new XmlStreamReader(doc.Body.toString());
    //Javer_Util.descargaParseXML(reader);
    Javer_ShPn_Util.descargaParseXMLSP(reader);
  }
    
    
    
    
    
  
   /******************************************************************************
        Métodos de Prueba
    */
    
    //Proveedores Test
    //
    //@future(callout=true)
    //static webservice void Proveedores_test(Id myAssigneeId) {
    public static  void Proveedores_test() {
        
        String response =''+
        '<xml>'+
        '<Platform>Sharepoint</Platform>'+
        '<TipoXML>Proveedores</TipoXML>'+
        '<NoDocumento>Prueba_Provedor_1.xml.xml</NoDocumento>'+
        '<Aprobador>test</Aprobador>'+
        '<EstatusSolicitud>Pendiente</EstatusSolicitud>'+
        '<Accion>Alta</Accion>'+
        '<CompaniasKontrol>No</CompaniasKontrol>'+
        '<RazonSocialNombre>Cementos maya</RazonSocialNombre>'+
        '<Rfc>CEMA010101</Rfc>'+
        '<TipoProveedor>MATERIALES</TipoProveedor>'+
        '<LineaProductos>CEMENTO</LineaProductos>'+
        '<NomRepLegal>Juan Perez</NomRepLegal>'+
        '<Direccion>calle Yuxchilan 3434</Direccion>'+
        '<Ciudad>Merida</Ciudad>'+
        '<Estado>Yucatan</Estado>'+
        '<Numero>001</Numero>'+
        '<ContactoVendedor>Pedro Navaja</ContactoVendedor>'+
        '<Tramite>Cheque</Tramite>'+
        '<Comentario>Comentariios</Comentario>'+
        '<Creado>01/01/2015</Creado>'+
        '<CreadoPor>jlguzman</CreadoPor>'+
        '<Nombre>Jose Luis G</Nombre>'+
        '<NombreJefe>Jorge Escandon</NombreJefe>'+
        '<UsuarioJefeInmediato>jlguzman</UsuarioJefeInmediato>'+
        '<Uen>Wen24</Uen>'+
        '<Area>Construccion</Area>'+
        '<Listas>sharepoint</Listas>'+
        '<listOfApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Telefono</name>'+
                                '<value>81800020</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Celular</name>'+
                                '<value>81897111</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
            '<ApprovalData>'+
                '<listOfRecords>'+
                    '<record>'+
                        '<listOfFields>'+
                            '<field>'+
                                '<name>Email</name>'+
                                '<value>jlguzman@javer</value>'+
                            '</field>'+
                        '</listOfFields>'+
                    '</record>'+
                '</listOfRecords>'+
            '</ApprovalData>'+
        '</listOfApprovalData>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXMLSP(reader);
    }
    
    
    //Proveedores Test Exception
    public static void Proveedores_testX() {
      String response =''+
        '<xml>'+
        '<Platform>Sharepoint</Platform>'+
        '<TipoXML>Proveedores</TipoXML>'+
        '<NoDocumento>Prueba_Provedor_1.xml.xml</NoDocumento>'+
        '<Aprobador>Exception</Aprobador>'+
        '<EstatusSolicitud>Pendiente</EstatusSolicitud>'+
        '<Accion>Alta</Accion>'+
        '<CompaniasKontrol>No</CompaniasKontrol>'+
        '<RazonSocialNombre>Cementos maya</RazonSocialNombre>'+
        '<Rfc>CEMA010101</Rfc>'+
        '<TipoProveedor>MATERIALES</TipoProveedor>'+
        '<LineaProductos>CEMENTO</LineaProductos>'+
        '<NomRepLegal>Juan Perez</NomRepLegal>'+
        '<Direccion>calle Yuxchilan 3434</Direccion>'+
        '<Ciudad>Merida</Ciudad>'+
        '<Estado>Yucatan</Estado>'+
        '<Numero>001</Numero>'+
        '<ContactoVendedor>Pedro Navaja</ContactoVendedor>'+
        '<Tramite>Cheque</Tramite>'+
        '<Comentario>Comentariios</Comentario>'+
        '<Creado>01/01/2015</Creado>'+
        '<CreadoPor>jlguzman</CreadoPor>'+
        '<Nombre>Jose Luis G</Nombre>'+
        '<NombreJefe>Jorge Escandon</NombreJefe>'+
        '<UsuarioJefeInmediato>jlguzman</UsuarioJefeInmediato>'+
        '<Uen>Wen24</Uen>'+
        '<Area>Construccion</Area>'+
        '<Listas>sharepoint</Listas>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXMLSP(reader);
    }
    
    //Insumo Test
    public static void Insumo_test() {
      String response =''+
    '<xml>'+
    '<Platform>Sharepoint</Platform>'+
    '<TipoXML>Insumos</TipoXML>'+
    '<NoDocumento>Prueba_Insumo_2.xml</NoDocumento>'+
    '<Aprobador>test</Aprobador>'+
    '<EstatusSolicitud>Pendiente por jefe inmediato</EstatusSolicitud>'+
    '<Obraoadmin>INSUMO DE OBRA</Obraoadmin>'+
    '<TipoInsumo>2. Mano de Obra</TipoInsumo>'+
    '<Comentario>COMENTA</Comentario>'+
    '<Creado/>'+
    '<CreadoPor/>'+
    '<Nombre>JOSE LUIS</Nombre>'+
    '<NombreJefe>JORGE ESCANDON</NombreJefe>'+
    '<UsuarioJefeInmediato>JLGUZMAN</UsuarioJefeInmediato>'+
    '<Uen>UEN4</Uen>'+
    '<Area>CONSTRUYE</Area>'+
    '<Accion>m</Accion>'+
    '<Listas>sharepoint</Listas>'+
    '<listOfApprovalData>'+
        '<ApprovalData>'+
            '<listOfRecords>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>No</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Categoria</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>SubCategoria</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Consecutivo</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>Descripcion</name>'+
                            '<value/>'+
                        '</field>'+
                        '<field>'+
                            '<name>UnidadMedida</name>'+
                            '<value/>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
                '<record>'+
                    '<listOfFields>'+
                        '<field>'+
                            '<name>No</name>'+
                            '<value>2</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Categoria</name>'+
                            '<value>2</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>SubCategoria</name>'+
                            '<value>01</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Consecutivo</name>'+
                            '<value>0001</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>Descripcion</name>'+
                            '<value>DATOS DE LINEA 1</value>'+
                        '</field>'+
                        '<field>'+
                            '<name>UnidadMedida</name>'+
                            '<value>M2</value>'+
                        '</field>'+
                    '</listOfFields>'+
                '</record>'+
            '</listOfRecords>'+
        '</ApprovalData>'+
    '</listOfApprovalData>'+
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXMLSP(reader);
    }
    
    //Insumo Test Exception
    public static void Insumo_testX() {
      String response =''+
    '<xml>'+
    '<Platform>Sharepoint</Platform>'+
    '<TipoXML>Insumos</TipoXML>'+
    '<NoDocumento>Prueba_Insumo_2.xml</NoDocumento>'+
    '<Aprobador>Exception</Aprobador>'+
    '<EstatusSolicitud>Pendiente por jefe inmediato</EstatusSolicitud>'+
    '<Obraoadmin>INSUMO DE OBRA</Obraoadmin>'+
    '<TipoInsumo>2. Mano de Obra</TipoInsumo>'+
    '<Comentario>COMENTA</Comentario>'+
    '<Creado/>'+
    '<CreadoPor/>'+
    '<Nombre>JOSE LUIS</Nombre>'+
    '<NombreJefe>JORGE ESCANDON</NombreJefe>'+
    '<UsuarioJefeInmediato>JLGUZMAN</UsuarioJefeInmediato>'+
    '<Uen>UEN4</Uen>'+
    '<Area>CONSTRUYE</Area>'+
    '<Accion>m</Accion>'+
    '<Listas>sharepoint</Listas>'+
    
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXMLSP(reader);
    }
    
    
    //Contrato Test
    public static void Contrato_test() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<TipoXML>Contratos</TipoXML>'+
    '<EstatusSolicitud>NUEVO</EstatusSolicitud>'+
    '<CentroCosto></CentroCosto>'+
    '<Aprobador>test</Aprobador>'+
    '<Nombre>Unico</Nombre>'+
    '<Contratante>Unico</Contratante>'+
    '<UEN></UEN>'+
    '<Fraccionamiento></Fraccionamiento>'+
    '<TipoContrato>Unico</TipoContrato>'+
    '<Concepto></Concepto>'+
    '<Descripcion></Descripcion>'+
    '<Contratista></Contratista>'+
    '<FechaFirmaContrato>Paralela</FechaFirmaContrato>'+
    '<FechaInicioObra>Unico</FechaInicioObra>'+
    '<FechaTerminoObra>Unico</FechaTerminoObra>'+
    '<FondoGarantiaDias>Unico</FondoGarantiaDias>'+
    '<FondoGarantiaPorciento>Unico</FondoGarantiaPorciento>'+
    '<ImporteAccesorios>Unico</ImporteAccesorios>'+
    '<ImporteAnticipo>Unico</ImporteAnticipo>'+
    '<ImporteMolde>Unico</ImporteMolde>'+
    '<ImporteContrato>Unico</ImporteContrato>'+
    '<Static>Unico</Static>'+
    '<Suministro>Unico</Suministro>'+
    '<Fianza>Unico</Fianza>'+
    '<Comentarios>Unico</Comentarios>'+
    '<Conjunto>Unico</Conjunto>'+
    '<Creado>Unico</Creado>'+
    '<ApoderadoLegal>Unico</ApoderadoLegal>'+
    '<Usuario>Unico</Usuario>'+
    '<Suplente>Unico</Suplente>'+
    +
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXMLSP(reader);
    } 
    
    //Contrato Test Exception
    public static void Contrato_testX() {
      String response =''+
    '<xml>'+
    '<platform>Siebel</platform>'+
    '<TipoXML>Contratos</TipoXML>'+
    '<EstatusSolicitud>NUEVO</EstatusSolicitud>'+
    '<CentroCosto></CentroCosto>'+
    '<Aprobador>Exception</Aprobador>'+
    '<Nombre>Unico</Nombre>'+
    '<Contratante>Unico</Contratante>'+
    '<UEN></UEN>'+
    '<Fraccionamiento></Fraccionamiento>'+
    '<TipoContrato>Unico</TipoContrato>'+
    '<Concepto></Concepto>'+
    '<Descripcion></Descripcion>'+
    '<Contratista></Contratista>'+
    '<FechaFirmaContrato>Paralela</FechaFirmaContrato>'+
    '<FechaInicioObra>Unico</FechaInicioObra>'+
    '<FechaTerminoObra>Unico</FechaTerminoObra>'+
    '<FondoGarantiaDias>Unico</FondoGarantiaDias>'+
    '<FondoGarantiaPorciento>Unico</FondoGarantiaPorciento>'+
    '<ImporteAccesorios>Unico</ImporteAccesorios>'+
    '<ImporteAnticipo>Unico</ImporteAnticipo>'+
    '<ImporteMolde>Unico</ImporteMolde>'+
    '<ImporteContrato>Unico</ImporteContrato>'+
    '<Static>Unico</Static>'+
    '<Suministro>Unico</Suministro>'+
    '<Fianza>Unico</Fianza>'+
    '<Comentarios>Unico</Comentarios>'+
    '<Conjunto>Unico</Conjunto>'+
    '<Creado>Unico</Creado>'+
    '<ApoderadoLegal>Unico</ApoderadoLegal>'+
    '<Usuario>Unico</Usuario>'+
    '<Suplente>Unico</Suplente>'+
    +
    '</xml>';

      XmlStreamReader reader = new XmlStreamReader(response);
      descargaParseXMLSP(reader);
    } 
    
  
  
}