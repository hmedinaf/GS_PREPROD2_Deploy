global class ResponseWS {

  webservice String id {get; set;}
  webservice String success {get; set;}
  webservice String tipo_de_error {get; set;}
  webservice Integer codigo_de_error {get; set;}
  webservice String mensaje {get; set;}
  private String action;

  public ResponseWS(String id, String act) {
    this.id = id;
    this.success = '200 (OK)';
    this.action = act;
  }

  public ResponseWS(String id, String errType, Integer errCode, String msg, String act) {
    this.id = id;
    this.success = '400 (ERROR)';
    this.tipo_de_error = errType;
    this.codigo_de_error = errCode;
    this.mensaje = msg;
    this.action = act;
  }

  public String getAction() {
    return this.action;
  }
}