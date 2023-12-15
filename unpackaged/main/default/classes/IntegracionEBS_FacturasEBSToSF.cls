/**
 * @description       : 
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-10-03
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
@RestResource(urlMapping='/EBSToSf/Facturas/*')
global with sharing class IntegracionEBS_FacturasEBSToSF
{
    @HttpPost
    global static ResponseWrapper doPost()
    {
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String requestString = body.toString();

        RequestWrapper reqW = (RequestWrapper)JSON.deserialize(requestString,RequestWrapper.class);

        Integracion_EBS_Facturas__c iebsf;

        ResponseWrapper respW = new ResponseWrapper();
        
        try
        {
            respW.MensajeApi = 'Creado en CRM';
            respW.RespuestaApi = '1';

            iebsf = new Integracion_EBS_Facturas__c();

            iebsf.IdFacturaAr__c = String.valueOf(reqW.IdFacturaAr);
            iebsf.CategoriaDesc__c = reqW.CategoriaDesc;
            iebsf.ConflictId__c = reqW.ConflictId;
            iebsf.DocumentoAplicado__c = reqW.DocumentoAplicado;
            iebsf.DocumentoClase__c = reqW.DocumentoClase;
            iebsf.DocumentoDesc__c = reqW.DocumentoDesc;
            iebsf.DocumentoRef__c = reqW.DocumentoRef;
            iebsf.EntidadLegal__c = reqW.EntidadLegal;
            iebsf.EstatusFactura__c = reqW.EstatusFactura;
            iebsf.EstatusProceso__c = reqW.EstatusProceso;
            iebsf.EstatusReg__c = reqW.EstatusReg;
            iebsf.FechaContable__c = String.isNotBlank(reqW.FechaContable) ? Date.valueOf(reqW.FechaContable) : null;
            //iebsf.FechaCreacion__c = reqW.FechaCreacion; //No tenemos un campo de fecha creacion en SF, solo existe el campo estandar de salesforce. ¿Es necesario crear uno?
            iebsf.FechaReestructura__c = String.isNotBlank(reqW.FechaReestructura) ? Date.valueOf(reqW.FechaReestructura) : null;
            iebsf.FechaVencimiento__c = String.isNotBlank(reqW.FechaVencimiento) ? Date.valueOf(reqW.FechaVencimiento) : null;
            iebsf.FideicomosoDesc__c = reqW.FideicomosoDesc;
            iebsf.FideicomisoFact__c = reqW.FideicomisoFact;
            iebsf.FinancieraDesc__c = reqW.FinancieraDesc;
            iebsf.FinancieraNum__c = reqW.FinancieraNum;
            iebsf.IdAplicarDocto__c = reqW.IdAplicarDocto;
            iebsf.IdClase__c = reqW.IdClase;
            iebsf.IdClienteAr__c = String.valueOf(reqW.IdClienteAr);
            iebsf.IdCobranzaMultiple__c = reqW.IdCobranzaMultiple;
            iebsf.IdDireccionRegional__c = reqW.IdDireccionRegional;
            iebsf.IdDocumentoTipo__c = reqW.IdDocumentoTipo;
            //iebsf.IdFacturaCrm__c = reqW.IdFacturaCrm;
            iebsf.IdFraccionamiento__c = reqW.IdFraccionamiento;
            iebsf.IdInterface__c = String.valueOf(reqW.IdInterface);
            //iebsf.IdInterfaceCrm__c = reqW.IdInterfaceCrm;
            iebsf.IdLote__c = reqW.IdLote;
            iebsf.IdManzana__c = reqW.IdManzana;
            iebsf.IdMunicipio__c = reqW.IdMunicipio;
            iebsf.IdPagareConta__c = reqW.IdPagareConta;
            iebsf.IdPagareReversa__c = reqW.IdPagareReversa;
            iebsf.IdProcesoAr__c = String.valueOf(reqW.IdProcesoAr);
            iebsf.IdPrototipo__c = reqW.IdPrototipo;
            iebsf.IdReestructura__c = reqW.IdReestructura;
            iebsf.IdTipoFactura__c = reqW.IdTipoFactura;
            iebsf.ImporteFactura__c = Decimal.valueOf(reqW.ImporteFactura);
            iebsf.IndAntesEscritura__c = reqW.IndAntesEscritura;
            iebsf.IndGastoAdmin__c = reqW.IndGastoAdmin;
            iebsf.IndIntereses__c = reqW.IndIntereses;
            iebsf.IndReembolso__c = reqW.IndReembolso;
            iebsf.IndReestructurado__c = reqW.IndReestructurado;
            iebsf.ModificationNum__c = reqW.ModificationNum;
            iebsf.Moneda__c = reqW.Moneda;
            iebsf.MontoFinanciado__c = reqW.MontoFinanciado;
            iebsf.NumCredito__c = reqW.NumCredito;
            iebsf.NumFactura__c = reqW.NumFactura;
            iebsf.OrigenDesc__c = reqW.OrigenDesc;
            iebsf.RequisicionCrm__c = reqW.RequisicionCrm;
            //iebsf.RetryCount__c = reqW.RetryCount;
            //iebsf.RowId__c = reqW.RowId;
            iebsf.TermPago__c = reqW.TermPago;
            iebsf.TipoFactura__c = reqW.TipoFactura;
            iebsf.ValorCobJaver__c = reqW.ValorCobJaver;
            iebsf.ValorOperacion__c = reqW.ValorOperacion;
            

            iebsf.Request_EBS_hacia_CRM__c = requestString;
            iebsf.Estatus_Integracion__c = 'Integrado';

            insert iebsf;

            respW.IdFacturaCrm = iebsf.Id;
            iebsf.Response_EBS_hacia_CRM__c = JSON.serialize(respW);
            update iebsf;


            return respW;
        }
        catch (Exception e)
        {
            String msjApi = 'Error: ' + e.getMessage();
            respW.MensajeApi = msjApi;//.substring(0, 1999);
            respW.RespuestaApi = '-1';

            return respW;
        }

    }
    
    /*
    @HttpGet
    global static void doGet()
    {
        //ToDo
    }

    @HttpDelete
    global static void doDelete()
    {
        //ToDo
    }*/

    global class RequestWrapper
    {
        public Integer IdFacturaAr;
		public Integer CategoriaDesc;
		public String ConflictId;
		public String DocumentoAplicado;
		public String DocumentoClase;
		public String DocumentoDesc;
		public String DocumentoRef;
		public String EntidadLegal;
		public String EstatusFactura;
		public Integer EstatusProceso;
		public Integer EstatusReg;
		public String FechaContable;
		//public String FechaCreacion;
		public String FechaReestructura;
		public String FechaVencimiento;
		public Integer FideicomosoDesc;
		public Integer FideicomisoFact;
		public String FinancieraDesc;
		public String FinancieraNum;
		public Integer IdAplicarDocto;
		public Integer IdClase;
		public Integer IdClienteAr;
		public Integer IdCobranzaMultiple;
		public Integer IdDireccionRegional;
		public Integer IdDocumentoTipo;
		//public String IdFacturaCrm;
		public Integer IdFraccionamiento;
		public Integer IdInterface;
		//public String  IdInterfaceCrm;
		public Integer IdLote;
		public Integer IdManzana;
		public Integer IdMunicipio;
		public Integer IdPagareConta;
		public Integer IdPagareReversa;
		public Integer IdProcesoAr;
		public Integer IdPrototipo;
		public Integer IdReestructura;
		public Integer IdTipoFactura;
		public String ImporteFactura;
		public Integer IndAntesEscritura;
		public String IndGastoAdmin;
		public String IndIntereses;
		public String IndReembolso;
		public String IndReestructurado;
		public Integer ModificationNum;
		public String Moneda;
		public String MontoFinanciado;
		public String NumCredito;
		public String NumFactura;
		public String OrigenDesc;
		public String RequisicionCrm;
		//public Integer RetryCount;
		//public String RowId;
		public String TermPago;
		public String TipoFactura;
		public String ValorCobJaver;
		public Integer ValorOperacion;
    }

    global class ResponseWrapper
    {
        public String MensajeApi;
        public String RespuestaApi;
        public String IdFacturaCrm;
    }
}