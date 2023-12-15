/**
 * @description       : 
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-07-31
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
public with sharing class IntegracionEBS_FacturasSfCRMtoERPReq
{
    
    private static Boolean isSandbox;
    private static Parametros_Integracion_EBS__mdt mdt;

    public class IntegracionEBSCallable
    {
      @InvocableVariable(label='ID registro Integracion EBS Facturas' required=true)
      public String iEbsId;
    }

    @InvocableMethod(label='Integraciones EBS: Enviar Factura' description='Enviar Factura a EBS' category='Callout') 
    public static void EBSEnviarFactura(List<IntegracionEBSCallable> integracionEBS)
    {
        isSandbox = [SELECT IsSandbox, Id FROM Organization].IsSandbox;

        if(isSandbox)
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Sandbox');
        else
            mdt = Parametros_Integracion_EBS__mdt.getInstance('Produccion');

        for (IntegracionEBSCallable p : integracionEBS)
        {
            Integracion_EBS_Facturas__c iEbs =
            [
                SELECT
                    Id
                    ,Name
                    ,CategoriaDesc__c
                    ,ConflictId__c
                    ,CreatedDate
                    ,CreatedById
                    ,CreatedBy.Name
                    ,DocumentoAplicado__c
                    ,DocumentoClase__c
                    ,DocumentoDesc__c
                    ,DocumentoRef__c
                    ,EntidadLegal__c
                    ,Estatus_Integracion__c
                    ,EstatusFactura__c
                    ,EstatusProceso__c
                    ,EstatusReg__c
                    ,FechaContable__c
                    ,FechaReestructura__c
                    ,FechaVencimiento__c
                    ,FideicomisoFact__c
                    ,FideicomosoDesc__c
                    ,FinancieraDesc__c
                    ,FinancieraNum__c
                    ,IdAplicarDocto__c
                    ,IdClase__c
                    ,IdClienteAr__c
                    ,IdCobranzaMultiple__c
                    ,IdDireccionRegional__c
                    ,IdDocumentoTipo__c
                    ,IdFacturaAr__c
                    ,IdFacturaCrm__c
                    ,IdFraccionamiento__c
                    ,Id_Interface_AutoNo__c
                    ,IdInterface__c
                    ,IdInterfaceCrm__c
                    ,IdLote__c
                    ,IdManzana__c
                    ,IdMunicipio__c
                    ,IdPagareConta__c
                    ,IdPagareReversa__c
                    ,IdProcesoAr__c
                    ,IdPrototipo__c
                    ,IdReestructura__c
                    ,IdTipoFactura__c
                    ,ImporteFactura__c
                    ,IndAntesEscritura__c
                    ,IndGastoAdmin__c
                    ,IndIntereses__c
                    ,IndReembolso__c
                    ,IndReestructurado__c
                    ,LastModifiedDate
                    ,LastModifiedById
                    ,LastModifiedBy.Name
                    ,ModificationNum__c
                    ,Moneda__c
                    ,MontoFinanciado__c
                    ,NumCredito__c
                    ,NumFactura__c
                    ,OrigenDesc__c
                    ,RequisicionCrm__c
                    //,RespuestaApi__c
                    ,RetryCount__c
                    ,RowId__c
                    ,TermPago__c
                    ,TipoFactura__c
                    ,ValorCobJaver__c
                    ,ValorOperacion__c
                FROM Integracion_EBS_Facturas__c WHERE ID = :p.iEbsId
            ];

            InsFacturasSfCRMtoERP ebsData = new InsFacturasSfCRMtoERP();
            EBSRequest ebsReq = new EBSRequest();

            ebsData.CategoriaDesc = Integer.valueOf(iEbs.CategoriaDesc__c);
            ebsData.ConflictId = iEbs.ConflictId__c;
            ebsData.Created = Date.valueOf(iEbs.CreatedDate);
            ebsData.CreatedBy = 'ADMIN JAVER'; // iEbs.CreatedBy.Name;
            ebsData.DbLastUpd = null;
            ebsData.DbLastUpdSrc = null;
            ebsData.DocumentoAplicado = iEbs.DocumentoAplicado__c;
            ebsData.DocumentoClase = iEbs.DocumentoClase__c;
            ebsData.DocumentoDesc = iEbs.DocumentoDesc__c;
            ebsData.DocumentoRef = iEbs.DocumentoRef__c;
            ebsData.EntidadLegal = iEbs.EntidadLegal__c;
            ebsData.EstatusFactura = iEbs.EstatusFactura__c;
            ebsData.EstatusProceso = Integer.valueOf(iEbs.EstatusProceso__c);
            ebsData.EstatusReg = Integer.valueOf(iEbs.EstatusReg__c);
            ebsData.FechaContable = IntegracionEBS_ClientesSfCRMtoERPReq.formatFecha(iEbs.FechaContable__c);
            ebsData.FechaCreacion = IntegracionEBS_ClientesSfCRMtoERPReq.formatFecha(iEbs.CreatedDate);
            ebsData.FechaReestructura = IntegracionEBS_ClientesSfCRMtoERPReq.formatFecha(iEbs.FechaReestructura__c);
            ebsData.FechaVencimiento = IntegracionEBS_ClientesSfCRMtoERPReq.formatFecha(iEbs.FechaVencimiento__c);
            ebsData.FideicomisoFact = Integer.valueOf(iEbs.FideicomisoFact__c);
            ebsData.FideicomosoDesc = Integer.valueOf(iEbs.FideicomosoDesc__c);
            ebsData.FinancieraDesc = iEbs.FinancieraDesc__c;
            ebsData.FinancieraNum = iEbs.FinancieraNum__c;
            ebsData.IdAplicarDocto = Integer.valueOf(iEbs.IdAplicarDocto__c);
            ebsData.IdClase = Integer.valueOf(iEbs.IdClase__c);
            ebsData.IdClienteAr = Integer.valueOf(iEbs.IdClienteAr__c);
            ebsData.IdCobranzaMultiple = Integer.valueOf(iEbs.IdCobranzaMultiple__c);
            ebsData.IdDireccionRegional = Integer.valueOf(iEbs.IdDireccionRegional__c);
            ebsData.IdDocumentoTipo = Integer.valueOf(iEbs.IdDocumentoTipo__c);
            ebsData.IdFacturaAr = iEbs.IdFacturaAr__c!=null?Integer.valueOf(iEbs.IdFacturaAr__c):null;
            ebsData.IdFacturaCrm = iEbs.IdFacturaCrm__c;
            ebsData.IdFraccionamiento = Integer.valueOf(iEbs.IdFraccionamiento__c);
            ebsData.IdInterface = Integer.valueOf(iEbs.Id_Interface_AutoNo__c);
            ebsData.IdInterfaceCrm = iEbs.Id;
            ebsData.IdLote = Integer.valueOf(iEbs.IdLote__c);
            ebsData.IdManzana = Integer.valueOf(iEbs.IdManzana__c);
            ebsData.IdMunicipio = Integer.valueOf(iEbs.IdMunicipio__c);
            ebsData.IdPagareConta = Integer.valueOf(iEbs.IdPagareConta__c);
            ebsData.IdPagareReversa = Integer.valueOf(iEbs.IdPagareReversa__c);
            ebsData.IdProcesoAr = Integer.valueOf(iEbs.IdProcesoAr__c);
            ebsData.IdPrototipo = Integer.valueOf(iEbs.IdPrototipo__c);
            ebsData.IdReestructura = Integer.valueOf(iEbs.IdReestructura__c);
            ebsData.IdTipoFactura = iEbs.IdTipoFactura__c!=null?Integer.valueOf(iEbs.IdTipoFactura__c):null;
            ebsData.ImporteFactura = String.valueOf(iEbs.ImporteFactura__c);
            ebsData.IndAntesEscritura = Integer.valueOf(iEbs.IndAntesEscritura__c);
            ebsData.IndGastoAdmin = iEbs.IndGastoAdmin__c;
            ebsData.IndIntereses = iEbs.IndIntereses__c;
            ebsData.IndReembolso = iEbs.IndReembolso__c;
            ebsData.IndReestructurado = iEbs.IndReestructurado__c;
            ebsData.LastUdp = Date.valueOf(iEbs.LastModifiedDate);
            ebsData.LastUpdBy = iEbs.LastModifiedBy.Name;
            ebsData.ModificationNum = Integer.valueOf(iEbs.ModificationNum__c);
            ebsData.Moneda = iEbs.Moneda__c;
            ebsData.MontoFinanciado = iEbs.MontoFinanciado__c;
            ebsData.NumCredito = iEbs.NumCredito__c;
            ebsData.NumFactura = iEbs.NumFactura__c;
            ebsData.OrigenDesc = iEbs.OrigenDesc__c;
            ebsData.RequisicionCrm = iEbs.RequisicionCrm__c;
            ebsData.RespuestaApi = '0';
            ebsData.RetryCount = Integer.valueOf(iEbs.RetryCount__c);
            ebsData.RowId = string.valueOf(iEbs.Id_Interface_AutoNo__c); //iEbs.RowId__c;
            ebsData.TermPago = iEbs.TermPago__c;
            ebsData.TipoFactura = iEbs.TipoFactura__c;
            ebsData.ValorCobJaver = iEbs.ValorCobJaver__c;
            ebsData.ValorOperacion = Integer.valueOf(iEbs.ValorOperacion__c);

            ebsReq.InsFacturasSfCRMtoERP = ebsData;

            String body = JSON.serialize(ebsReq);

            System.debug('EBSRequest: ' + body);

            String esbURL = mdt.URL_base__c + '' + mdt.Servicio_Facturas__c;

            System.enqueueJob(new QueueableIntegracionEBSCall(esbURL, 'POST', body, iEbs.Id));
        }
    }


    public class EBSRequest {
        //public String @Version;
        //public String @RequestDate;
        //public String @SourceSystem;
        //public String @TransactionID;
        public InsFacturasSfCRMtoERP InsFacturasSfCRMtoERP;
    }

    public class InsFacturasSfCRMtoERP {
        public Integer IdFacturaAr;
		public Date LastUdp;
		public String LastUpdBy;
		public String RespuestaApi;
		public Integer CategoriaDesc;
		public String ConflictId;
		public Date Created;
		public String CreatedBy;
		public String DbLastUpd;
		public String DbLastUpdSrc;
		public String DocumentoAplicado;
		public String DocumentoClase;
		public String DocumentoDesc;
		public String DocumentoRef;
		public String EntidadLegal;
		public String EstatusFactura;
		public Integer EstatusProceso;
		public Integer EstatusReg;
		public String FechaContable;
		public String FechaCreacion;
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
		public String IdFacturaCrm;
		public Integer IdFraccionamiento;
		public Integer IdInterface;
		public String  IdInterfaceCrm;
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
		public Integer RetryCount;
		public String RowId;
		public String TermPago;
		public String TipoFactura;
		public String ValorCobJaver;
		public Integer ValorOperacion;
    }


    public class EBSResponse {

        public String ResponseDate;
        public Boolean Success;
        public String ESB_Id;
        public String NombreCompleto;
        public String Departamento;
        public String Oficina;
        public String Estado;
        public FacturasSfCRMtoERP FacturasSfCRMtoERP;        
    }

    public class FacturasSfCRMtoERP {
        public FacturasSfCRMtoERPResponse FacturasSfCRMtoERPResponse;
    }

    public class FacturasSfCRMtoERPResponse {
        public String MensajeApi;
        public String RespuestaApi;
    }


    public class QueueableIntegracionEBSCall implements System.Queueable, Database.AllowsCallouts {

        private final String url;
        private final String method;
        private final String body;
        private final String recordId;
  
        public QueueableIntegracionEBSCall(String url, String method, String body, String recordId) {
            this.url = url;
            this.method = method;
            this.body = body;
            this.recordId = recordId;
        }
  
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method);
            req.setBody(body);
            req.setHeader('Accept', 'application/json');
			req.setHeader('Content-Type', 'application/json');
            Http http = new Http();
            HttpResponse res = new HTTPResponse();

            String errorNoControlado = '';

            if (!Test.isRunningTest()) {
                try {
                    res = http.send(req);    
                } catch (Exception e) {
                    errorNoControlado = e.getMessage();
                }
            } else {
                System.debug(body);
            }

            System.debug('errorNoControlado:: ' + errorNoControlado);

            Integracion_EBS_Facturas__c integracionEBS = [SELECT Id FROM Integracion_EBS_Facturas__c WHERE ID = :recordId];

            if(String.isBlank(errorNoControlado))
            {
                System.debug('EBSResponse: ' + res.getBody());
                String respBody = res.getBody();
                respBody = respBody.replaceAll('@', '');
                System.debug('Body sin arrobas: ' + respBody);

                EBSResponse ebsRes = new EBSResponse();
                ebsRes = (EBSResponse) JSON.deserialize(respBody, EBSResponse.CLASS);
                System.debug('EBSResponse deserializado: ' + ebsRes);

                if(res.getStatusCode() == 200)
                {
                    if(ebsRes.Success)
                    {
                        integracionEBS.Estatus_Integracion__c = 'Enviado';
                        integracionEBS.Request_CRM_hacia_EBS__c = body;
                        integracionEBS.Response_CRM_hacia_EBS__c = respBody;
                        integracionEBS.Respuesta_API__c = ebsRes.FacturasSfCRMtoERP.FacturasSfCRMtoERPResponse.RespuestaApi;
                        //integracionEBS.Id_Cliente_AR__c = ebsRes.ESB_Id;
                        //integracionEBS.Id_Cliente_AR__c = ebsRes.ESB_Id;
                        update integracionEBS;
                    }
                    else
                    {
                        integracionEBS.Estatus_Integracion__c = 'Error';
                        integracionEBS.Respuesta_API__c = ebsRes.FacturasSfCRMtoERP.FacturasSfCRMtoERPResponse.MensajeApi;
                        integracionEBS.Request_CRM_hacia_EBS__c = body;
                        integracionEBS.Response_CRM_hacia_EBS__c = respBody;
                        update integracionEBS;
                    }
                }
                else
                {
                    integracionEBS.Estatus_Integracion__c = 'Error';
                    integracionEBS.Respuesta_API__c = res.getBody();
                    integracionEBS.Request_CRM_hacia_EBS__c = body;
                    integracionEBS.Response_CRM_hacia_EBS__c = respBody;
                    update integracionEBS;
                }
            }
            else
            {
                integracionEBS.Estatus_Integracion__c = 'Error';
                integracionEBS.Respuesta_API__c = errorNoControlado;
                integracionEBS.Request_CRM_hacia_EBS__c = body;
                update integracionEBS;
            }
        }
    }
}