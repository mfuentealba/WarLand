console.log("Inicio 0.0.2");


var arrSocket = {};
var usuario = 0;
var net = require('net');
var eventos = require('events');
var EmisorEventos = eventos.EventEmitter; 
var ee = new EmisorEventos(); 

var mysql = require('mysql');

var connection = mysql.createPool({
  connectionLimit : 1000,
  host     : '127.0.0.1',
  user     : 'remate',
  password : 'remate',
  database : 'remate'
});

var arrResult;
var posibleNivel = {};
var sqlExec = "SELECT `fecha`, `precio_bid`, `precio_ask`, `nemo`, `tendencia` FROM `precios_analisis` WHERE `nemo` = 'EURUSD' ORDER BY `precios`.`fecha` ASC"; 
dbExecute(sqlExec, prueba, []);

function prueba(err, results, fields, arrParam){
	if(err) {    
		console.log('[ERROR EN CONSULTA]');
	}
	else {    
		if(results.length > 0){
			arrResult = results;
			//console.log(arrResult);
			/*for(var i = 0; i < results.length; i++){
				arrResult = JSON.stringify(results[i]);
				resultados += '|';
			}*/
		}
	}	
}



function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}



function dbExecute(queryExec, fnCallback, arrParam, arrParamQuery){
	connection.getConnection(function(err,conn){
		if (err) {
			console.log(err);
			conn.release();
			console.log({"code" : 100, "status" : "Error in connection database"});
			return;
		}   
		//console.log(conn);
		console.log('connected as id ' + conn.threadId);

		conn.query(queryExec, arrParamQuery, function(err, results, fields){
				if(fnCallback != null){
					fnCallback(err, results, fields, arrParam);			
				}
				conn.release();

			});

		conn.on('error', function(err) {      
		   console.log({"code" : 100, "status" : "Error in connection database"});
		   return;     
		});
   });

}

ee.on('datos', function(fecha){
   console.log(fecha);
});
/*setInterval(function(){
   ee.emit('datos', Date.now());
}, 500); 
*/
function onConnect()
{
    console.log("Connected to Flash");    
}

function receiveData(socket, d) {
	if(d === "@quit") {
		socket.end('Goodbye!\n');
	}
	else {
		var opt = '' + d;
		var usuario;
		var partida = 0;
		var creador;
		var oponente;
		var finStream;
		socket.arrOpt = arrOpt;
		//arrSocket
		console.log("********************************************************************");
		console.log("From Flash = " + d);
		
		var arrOpt = opt.split('|');
		
		console.log(arrOpt);
	 
		console.log("EJECUTANDO");
		switch(arrOpt[0]){
			case "GP":
				var echo = {};
				row = arrResult[0];
				row.precio_bid = Math.floor(row.precio_bid * 10000) / 10000;
				echo.ten = 'N';
				echo.precio = row.precio_bid;
				echo.dif = 0;
				row.mov = 0;
				row.movAcum = 0;
				socket.write("RECEP|INI|" + JSON.stringify(echo) + "|" + arrOpt[1], 'utf8');
				for(var i = 1; i < arrResult.length; i++){
				  // sleep(1);
				   sleep(100);
				   echo = {};
				   //console.log(JSON.stringify(arrResult[i]));
				   row = arrResult[i];
				   row.precio_bid = Math.floor(row.precio_bid * 10000) / 10000;
				   echo.precio = row.precio_bid;

					if(arrResult[i].precio_bid < row.precio_bid){
					   //sql = "UPDATE `precios_analisis` SET `tendencia`='A' WHERE `fecha`='" . row.fecha . "'";
						row.tendencia = 'A';
				    } else if(arrResult[i - 1].precio_bid > row.precio_bid){
						//sql = "UPDATE `precios_analisis` SET `tendencia`='B' WHERE `fecha`='" . row.fecha . "'";
						row.tendencia = 'B';
				    } else {
						row.tendencia = 'N';
				    }

					echo.ten = row.tendencia;
					row.movAcum = 0;
					//arrResult[i] = row;
					if(arrResult[i].tendencia != 'N' && arrResult[i - 1].tendencia != 'N' && arrResult[i].tendencia != arrResult[i - 1].tendencia){
						clave = Math.round(arrResult[i - 1].precio_bid, 4);//floor(arrResult[i - 1].precio_bid * 1000) / 1000;
						if(posibleNivel.hasOwnProperty(clave)){
							posibleNivel[clave][posibleNivel[clave].length] = i;
						} else {
							
							posibleNivel[clave] = [];
							posibleNivel[clave][0] = i;
						}             
					} else {			  

					}
				   arrResult[i].mov = Math.round((arrResult[i].precio_bid - arrResult[i - 1].precio_bid) * 10000);//Math.round(arrResult[i].precio_bid - arrResult[i - 1].precio_bid, 4);
				   arrResult[i].movAcum = arrResult[i - 1].movAcum + arrResult[i].mov;
				   echo.dif = arrResult[i].mov;
				   console.log(JSON.stringify(arrResult[i]));
				   echo.difAcum = arrResult[i].movAcum;
				   //console.log(echo);
				   socket.write("RECEP|INI|" + JSON.stringify(echo) + "|" + arrOpt[1], 'utf8');
				}				
			break;
		}
	}	
}


function closeSocket(socket) {
	console.log('***************************************');
	console.log('ingresando en closeSocket');//53820010
	
	
}

function onClose(socket)
{
	console.log("ingresando en onClose");
}

function onError()
{
    console.log("SE DESCONECTO");
}


function newSocket(socket) {
	console.log("/************************************************************/");
	console.log('ingresando en newSocket');
	//socket.id = '0';
	console.log('Welcome to the Telnet server!\n');
	socket.on('data', function(data) {
		receiveData(socket, data);
	})
	socket.on('end', function() {
		closeSocket(socket);
	})
	socket.on("close", function(){
		onClose(socket);
	});
	socket.on('error', function(err) {
		console.log('[ERROR DE SOCKET]');
	})
	
	socket.on('disconnect', function(err) {
		console.log('[ERROR DE SOCKET FINAL....DESCONEXION]');
	})
	
	socket.addListener('build', function() {
		console.log('[HOLA]');
	})
	
	//console.log(socket);
	socket.nombre = 'U' + usuario;
	//ee.on('build', saludo);
	ee.emit('build');
	/*socket.ee = new EmisorEventos();
	socket.ee.on('build',  function() {
		console.log('[HOLA]');
	});
	ee.parent = socket;*/
	arrSocket['U' + (usuario++)] = socket;
	
	
	
	
	
	//console.log(socket.nombre + '\n');
}



function saludo(socket){
	console.log(this);//.parent.nombre);
	//console.log(arrSocket);
	//console.log(socket);
}


var server = net.createServer(newSocket);

server.listen(9004);
