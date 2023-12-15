global class BATCH_WorkdayWorking implements Database.Batchable<SObject>, Database.AllowsCallouts{
    
    //Metodo para obtener los registros de prototipos a actualizar por el servicio de Workday
	global Database.QueryLocator start(Database.BatchableContext BC) {

        //Se obtienen todos los prototipos que no tengan un Precio Presupuesto de la version Oficial Firmada
        String soqlquery = 'SELECT Id, Id_Prototipo__c, Precio_Presupuesto__c, Version_Precio_Presupuesto__c, Fraccionamiento__c, Fraccionamiento__r.Codigo_Fraccionamiento__c FROM Prototipo__c WHERE Version_Precio_Presupuesto__c != \'Oficial Firmada\'';
		
		return Database.getQueryLocator(soqlquery);
    }
    
    //Metodo donde se invoca al servicio web de Workday para actualizar el Precio Presupuesto de los prototipos
	global void execute(Database.BatchableContext BC, List<Prototipo__c> prototipos) {

        System.debug('*****execute BATCH_WorkdayWorking');

        Boolean esSandbox = [SELECT IsSandbox FROM Organization LIMIT 1].isSandbox;
        System.debug('*****esSandbox:' + esSandbox);

        String requestedDate = DateTime.now().format('yyyy-MM-dd') + 'T' + DateTime.now().format('HH:mm:ss');
        System.debug('*****requestedDate:' + requestedDate);

        String versionName = (esSandbox == true ? 'Budget ' + DateTime.now().format('yyyy') + ' v1' : 'Budget ' + DateTime.now().format('yyyy') + ' Working');
        System.debug('*****versionName:' + versionName);

        String timeSpan = DateTime.now().format('MM') + '/' + DateTime.now().format('yyyy');
        System.debug('*****timeSpan:' + timeSpan);

        String cuerpoPeticion = '{'+
		    '"@Version": "1",'+
		    '"@RequestDate": "' + requestedDate + '",'+
		    '"@SourceSystem": "SALESFORCE",'+
		    '"@TransactionID": "",'+
		    '"Version": {'+
                '"@Name": "' + versionName + '",'+
		        '"@IsDefault": false'+
		    '},'+
		    '"Format": {'+
		        '"@UseInternalCodes": true,'+
		        '"@IncludeUnmappedItems": false'+
		    '},'+
		    '"Filters": {'+
		        '"Accounts": {'+
		            '"Account": ['+
		                '{'+
		                    '"@Code": "Ingresos.PrecLista",'+
		                    '"@IsAssumption": false,'+
		                    '"@IncludeDescendants": true'+
		                '}'+
		            ']'+
		        '},'+
		        '"Levels": {'+
		            '"Level": ['+
		                '{'+
		                    '"@Name": "OPE",'+
		                    '"@IsRollup": false,'+
		                    '"@IncludeDescendants": true'+
		                '}'+
		            ']'+
		        '},'+
		        '"TimeSpan": {'+
                    '"@Start": "' + timeSpan + '",'+
		            '"@End": "' + timeSpan + '"'+
		        '}'+
		    '},'+
		    '"Dimensions": {'+
		        '"Dimension": ['+
		            '{'+
		                '"@Name": "Prototipo"'+
		            '}'+
		        ']'+
		    '},'+
		    '"Rules": {'+
		        '"@IncludeZeroRows": false,'+
		        '"@IncludeRollupLevels": true,'+
		        '"@MarkInvalidValues": false,'+
		        '"@MarkBlanks": false,'+
		        '"@TimeRollups": false'+
		    '}'+
        '}';
        System.debug('*****cuerpoPeticion:' + cuerpoPeticion);

        String endPoint = (esSandbox == true ? 'https://qesb.javer.com.mx:11962/services/Workday/ManageWorkday/rest/ExportData' : 'https://esb.javer.com.mx:11902/services/Workday/ManageWorkday/rest/ExportData');
        System.debug('*****endPoint:' + endPoint);
        
        HttpRequest peticion = new HttpRequest();
        peticion.setMethod('POST');
        peticion.setHeader('Content-Type', 'application/json;charset=UTF-8');
        peticion.setHeader('Accept', 'application/json');
        peticion.setEndpoint(endPoint);
        peticion.setBody(cuerpoPeticion);
        System.debug('*****peticion:' + peticion);

        Http http = new Http();
        HttpResponse respuesta = http.send(peticion);
        System.debug('*****respuesta:' + respuesta);
        System.debug('*****respuesta.getBody():' + respuesta.getBody());

        String respuestaMod = respuesta.getBody().replace('@','');

        if(respuestaMod.contains('MessagesValue') == false){

            RespuestaJSONSinMensaje resultado = (RespuestaJSONSinMensaje) System.JSON.deserialize(respuestaMod, RespuestaJSONSinMensaje.class);
            System.debug('*****resultado:' + resultado);

            List<Output> outputs = resultado.Response.Output;
            System.debug('*****outputs:' + outputs);

            Map<String,RegistroWorkday> registrosWorkday = new Map<String,RegistroWorkday>();            
            String idFraccionamiento = '';
            String idPrototipo = '';
            if(outputs != null){          

                for(Output output : outputs){

                    List<Row> rows = output.Row;
                    System.debug('*****rows:' + rows);

                    idFraccionamiento = '';
                    idPrototipo = '';                
                    RegistroWorkday registroWorkday = new RegistroWorkday();
                    for(Row row : rows){

                        System.debug('*****row.Name:' + row.Name);
                        System.debug('*****row.Value:' + row.Value);

                        if(row.Name == 'Account Name'){
                            registroWorkday.AccountName = row.Value;
                        }
                        else if(row.Name == 'Account Code'){
                            registroWorkday.AccountCode = row.Value;
                        }
                        else if(row.Name == 'Level Name'){
                            registroWorkday.LevelName = row.Value;
                            idFraccionamiento = row.Value;
                        }
                        else if(row.Name == 'Prototipo'){
                            registroWorkday.Prototipo = row.Value;
                            idPrototipo = row.Value;
                        }
                        else{
                            registroWorkday.Precio = row.Value;
                        }
                    }
                    registrosWorkday.put(idFraccionamiento + idPrototipo,registroWorkday);
                }
            }
            System.debug('*****registrosWorkday:' + registrosWorkday);

            List<Prototipo__c> prototiposActualizar = new List<Prototipo__c>();
            for(Prototipo__c prototipo : prototipos){

                if(registrosWorkday.containsKey(prototipo.Fraccionamiento__r.Codigo_Fraccionamiento__c + prototipo.Id_Prototipo__c) == true){

                    prototipo.Precio_Presupuesto__c = Decimal.valueOf(registrosWorkday.get(prototipo.Fraccionamiento__r.Codigo_Fraccionamiento__c + prototipo.Id_Prototipo__c).Precio);
                    prototipo.Version_Precio_Presupuesto__c = 'Oficial Firmada';
                    prototiposActualizar.add(prototipo);
                    System.debug('*****prototipo:' + prototipo);
                }
            }
            System.debug('*****prototiposActualizar:' + prototiposActualizar);

            if(prototiposActualizar.size() > 0){
                update prototiposActualizar;
            }
        }
        /*para la clase de prueba de esta parte se puede hacer poniendo los parametros:
        "Version": {
		    "@Name": "Budget 2022 ASDF",
		    "@IsDefault": false
        }*/
        else{
            RespuestaJSONConMensaje resultado = (RespuestaJSONConMensaje) System.JSON.deserialize(respuestaMod, RespuestaJSONConMensaje.class);
            System.debug('*****resultado:' + resultado);
            System.debug('*****resultado.Response.Messages.get(0).Message.get(0).Key:' + resultado.Response.Messages.get(0).Message.get(0).Key);
            System.debug('*****resultado.Response.Messages.get(0).Message.get(0).MessagesValue:' + resultado.Response.Messages.get(0).Message.get(0).MessagesValue);
        }
    }

    global void finish(Database.BatchableContext BC) { 
 		
    }

    class RespuestaJSONSinMensaje{
		String ESB_Id;
		Boolean Success;
		ResponseSinMensaje response;
		String ResponseDate;
    }

    class RespuestaJSONConMensaje{
		String ESB_Id;
		Boolean Success;
		ResponseConMensaje response;
		String ResponseDate;
    }

    class ResponseSinMensaje{
		Boolean Success;
		List<Output> Output;
}

    class ResponseConMensaje{
		list<Messages> Messages;
		Boolean Success;
		List<Output> Output;
    }

    class Messages {
        List<Message> Message;
    }

    class Message{
		String Key;
		String MessagesValue;
    }

    class Output{
		List<Row> Row;
    }

    class Row{
		String Name;
		String Value;
    }

    class RegistroWorkday{

        String AccountName;
        String AccountCode;
        String LevelName;
        String Prototipo;
        String Precio;
    }

        /* RESPUESTA DE EJEMPLO DE SERVICIO DE WORKDAY
        {
            "@ResponseDate": "2022-10-19T13:07:06.792-05:00",
            "@Success": true,
            "@ESB_Id": "2670477",
            "Response": {
                "@Success": true,
                "Messages": [
                    {
                        "Message": [
                            {
                                "@Key": "error-invalid-version",
                                "@MessagesValue": "Version is not valid."
                            }
                        ]
                    }
                ]
                "Output": [
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "A23"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "3013"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "2724.5192422838536"
                            }
                        ]
                    },
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "A23"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "3014"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "3082.498249424881"
                            }
                        ]
                    },
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "A34"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "311"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "548.9424889162577"
                            }
                        ]
                    },
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "A34"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "1055"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "656.7921289613257"
                            }
                        ]
                    },
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "A23"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "3015"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "3632.3272843614473"
                            }
                        ]
                    },
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "A34"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "339"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "429.92432058779497"
                            }
                        ]
                    },
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "A34"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "1179"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "433.33333333333337"
                            }
                        ]
                    },
                    {
                        "Row": [
                            {
                                "@Name": "Account Name",
                                "@Value": "Precio Mensual"
                            },
                            {
                                "@Name": "Account Code",
                                "@Value": "Ingresos.PrecLista"
                            },
                            {
                                "@Name": "Level Name",
                                "@Value": "D29"
                            },
                            {
                                "@Name": "Prototipo",
                                "@Value": "2706"
                            },
                            {
                                "@Name": "10/2022",
                                "@Value": "2290.0"
                            }
                        ]
                    }
                ]
            }
        }*/
}