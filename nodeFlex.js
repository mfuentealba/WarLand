
console.log("Inicio 0.0.2");



var net = require('net');
var mongodb = require('mongodb'); 
var Db = require('mongodb').Db;
var servMongo = new mongodb.Server("127.0.0.1", 27017, {});
var dbTest = new Db('chess', servMongo)
var collection
dbTest.open(function (error, client) {
  if (error) throw error;

  //en el parámetro client recibimos el cliente para comenzar a hacer llamadas
  //este parámetro sería lo mismo que hicimos por consola al llamar a mongo
  
  //Obtenemos la coleccion personas que creamos antes
  collection = dbTest.collection('fen');
  //var collection = dbTest.Collection(client, 'fen');
  
  //disparamos un query buscando la persona que habiamos insertado por consola
  collection.find().toArray(function(err, docs) {

    //imprimimos en la consola el resultado
    console.dir(docs);
	collection.remove();
  });
});



var arrSocket = {};

var mysql      = require('mysql');


/*var connection = mysql.createConnection({
  host     : '127.0.0.1',
  user     : '',
  password : 'cuculiche', 
  database : 'warland'
});*/

var connection = mysql.createPool({
  connectionLimit : 1000,
  host     : '127.0.0.1',
  user     : 'warland',
  password : 'cuculiche',
  database : 'warland'
});


/*

connection.on('error', function(err) {   
  console.log('sin conexion');   
  connection = mysql.createConnection({
		  host     : '127.0.0.1',
		  user     : 'warland',
		  password : 'cuculiche', 
		  database : 'warland'
		});
               
});
*/

/*
var sqlExec = "UPDATE sesion SET estado = 'E'";        
connection.query(sqlExec, []);
 */
// --------------------------------------
// Construct The Socket
// --------------------------------------
// create the server and register event listeners
var arrSocket ={};



       
//connection.query(sqlExec, []);

function prueba(err, results, fields, arrParam){
	
	console.log("HOLA MUNDO");
	console.log(arrParam);
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



var sqlExec = "UPDATE sesion SET estado = 'E'"; 
dbExecute(sqlExec, prueba, []);



sqlExec = "TRUNCATE TABLE partida";        
dbExecute(sqlExec, prueba, [sqlExec], []);

sqlExec = "TRUNCATE TABLE movida";        
dbExecute(sqlExec, null, [], []);

sqlExec = "TRUNCATE TABLE fen_hist";        
dbExecute(sqlExec, null, [], []);


sqlExec = "TRUNCATE TABLE fen";        
dbExecute(sqlExec, null, [], []);

sqlExec = "TRUNCATE TABLE ERROR";        
dbExecute(sqlExec, null, [], []);

 
// --------------------------------------
// Events
// --------------------------------------
/**
 * Handles the Event: <code>"connect"</code>.
 *
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
		//console.log(connection);
		if(connection){
			
		}
	//    mySocket.write(d, 'utf8');
		var arrOpt = opt.split('|');
		
		console.log(arrOpt);
	 
		console.log("EJECUTANDO");
		switch(arrOpt[0]){
			case "CREAR_CUENTA":
				var sqlExec = "SELECT p.id FROM player p WHERE user = ?";
								
				console.log(sqlExec);		
				usuario = JSON.parse(arrOpt[1]);
				console.log(usuario);
				console.log('Buscando usuario....');
				finStream = arrOpt[arrOpt.length - 1];
				dbExecute(sqlExec, crearCuenta, [socket, usuario, arrOpt], [usuario.user]);
				
				var json = '';
			break;
			case "LR"://Login
				var sqlExec = "SELECT p.id, user, puntosBlitz, triunfos, derrotas, tablas, usuario_id, monedaRoja, monedaVerde, monedaAzul, saldo, puntosBala, puntosNormal  FROM player p LEFT JOIN sesion s on s.usuario_id = p.id AND estado = 'V' WHERE user = ?";
								
				console.log(sqlExec);		
				usuario = arrOpt[1];
				console.log('Buscando usuario....');
				finStream = arrOpt[arrOpt.length - 1];
				dbExecute(sqlExec, registroUser, [socket, usuario, arrOpt], [usuario]);
				
				var json = '';
			break;
			
			case "PO"://Login
				var sqlExec = "SELECT p.id, user, puntosBlitz, triunfos, derrotas, tablas, usuario_id, monedaRoja, monedaVerde, monedaAzul, saldo, puntosBala, puntosNormal  FROM player p LEFT JOIN sesion s on s.usuario_id = p.id AND estado = 'V' WHERE p.id = ?";
								
				console.log(sqlExec);		
				usuario = arrOpt[1];
				console.log('Buscando usuario....');
				finStream = arrOpt[arrOpt.length - 1];
				dbExecute(sqlExec, perfilOponente, [socket, usuario, arrOpt], [usuario]);
				
				var json = '';
			break;
			
			case "TP"://Busqueda todas las partidas
				var sqlExec = "SELECT `id`, `idPlayer1`, `idPlayer2`, `color_p1`, `estado`, `resultado`, `detalle_fin`, `p1_conn`, `p2_conn`, `duracion`, `apuesta`, `minELO`, `maxELO`, `torneo_id`, `tipo`, `puntosJ1`, `puntosJ2`, `ganancia`, `Player1`, `Player2` FROM `partida` WHERE idPLayer1 <> ? AND idPLayer2 is null AND estado = 'V'";
				console.log("TODAS LAS PARTIDAS PARA USUARIO : " + socket.id);
				usuario = arrOpt[1];
				
				dbExecute(sqlExec, todaLasPartidas, [socket, arrOpt], [usuario]);
				
				
			break;
				  
			case "TT"://Busqueda todos los torneos
				var sqlExec = "SELECT `id`, `creadorId`, `minELO`, `maxELO`, `inscripcion`, `duracion`, `sistemaJuego`, `rondas`, `maxJugadores`, `ganadorId`, `premio`, `estado` FROM `torneo` where creadorId <> " + socket.id;
				console.log("TODAS LAS PARTIDAS PARA USUARIO : " + socket.id);
				
				dbExecute(queryExec, fnGetTorneos, [socket], []);
				
				
			break;
			
			case "TM"://Busqueda todas las Transacciones
				var sqlExec = "SELECT `id`, `creadorId`, `cantidad`, `precio`, `tipo`, `estado`, `fechaHora`, `moneda`, concat('Precio: ', `precio`) precioMSG FROM `mercado`";
				//console.log("TODAS LAS PARTIDAS PARA USUARIO : " + socket.id);
				
				dbExecute(queryExec, fnGetTransacciones, [socket], []);
				
				
				
			break;
			
			
			
			
			case "CP":
				/*usuario = arrOpt[1];
                creador = arrOpt[1];
				var color = arrOpt[2];
				var tiempo = arrOpt[3];*/
				var obj = JSON.parse(arrOpt[1]);
				var sqlExec = "SELECT saldo - " + obj.apuesta + " sld " + 
						" FROM player WHERE id = ?";							
				//console.log(obj);
				//console.log("SELECT saldo - " + obj.apuesta + " sld " + " FROM player WHERE id = " + obj.idPlayer1);
				dbExecute(sqlExec, confirmandoPartida, [socket, arrOpt, obj], [obj.idPlayer1]);
				/*var res = connection.query(sqlExec, [obj.idPlayer1],
					function(err, results, fields) {
						confirmandoPartida(err, results, fields, socket, arrOpt, obj)
						
					})*/
              
	        break;
			
			case "CM":
				var obj = JSON.parse(arrOpt[1]);
				var sqlExec = "SELECT saldo - " + obj.cantidad + " sld " + 
						" FROM player WHERE id = ?";							
			
				console.log("SELECT saldo - " + obj.cantidad + " sld " + 
						" FROM player WHERE id = ? " + obj.creadorId);
				dbExecute(queryExec, fnGetTransacciones, [socket], []);
				var res = connection.query(sqlExec, [obj.creadorId],
					function(err, results, fields) {
						confirmandoMercado(err, results, fields, socket, arrOpt, obj);
						
					})
              
	        break;
			
			case "CT":
				var sqlExec = "SELECT count(*) res FROM torneo WHERE creadorId = ? AND estado = 'V'";
				console.log(arrOpt[1]);
				var obj = JSON.parse(arrOpt[1]);
				
				console.log(obj);
				dbExecute(queryExec, fnGetTransacciones, [socket], []);
				var res = connection.query(sqlExec, [obj.creadorId],
				function(err, results, fields) {
								confirmandoTorneo(err, results, fields, socket, arrOpt, obj)
								
							})
				
					
	        break;
			
			
			case "OFERTA_TABLAS":
				arrSocket['U' + socket.oponente].write('RECEP|OFERTA_TABLAS|' + arrOpt[arrOpt.length - 1], 'utf8'); 
			break;
			
			case "BP":
	            var sqlExec = 'SELECT id, idPlayer1, color_p1 FROM partida WHERE idPLayer2 is null AND id = ?';
				console.log("SELECT id, idPlayer1, color_p1 FROM partida WHERE idPLayer2 is null AND id = ?");
				usuario = arrOpt[1];
				oponente = arrOpt[1];
				var color = arrOpt[2];
				var tiempo = arrOpt[3];
				var puntos = arrOpt[5];
				var saldo = arrOpt[6];
				var colorOponente;
				switch(color){
					case 'Aleatorio':
						sqlExec = 'SELECT id, idPlayer1, color_p1 FROM partida WHERE idPLayer2 is null AND id = ?';
					break;
					
					case 'Blancas':
						color = 'B';
						colorOponente = 'N';
					break;
					
					case 'Negras':
						color = 'N';
						colorOponente = 'B';
					break;
				}
				socket.oponente = oponente;
				
				
				dbExecute(sqlExec, fnIniciaPartida, [socket, usuario, puntos, saldo, color, tiempo], [arrOpt[4]]);
				
        break;
		case "EM":
            var sqlExec = 'INSERT INTO `movida`(`id`, `id_partida`, `num_movida`, `color_movida`, `movida`, fen) VALUES (null, ?, ?, ?, ?, ?)';
                var movimiento = arrOpt[1]; 
				var idPartida = arrOpt[2]; 
				var tiempo = arrOpt[3]; 
				var idOponente = arrOpt[4]; 
				var color = arrOpt[5]; 
				var nroJugada = arrOpt[6]; 
                console.log('Registrando');
                dbExecute(sqlExec, fnMovida, [socket, movimiento, tiempo, arrOpt], [idPartida, nroJugada, color, movimiento, arrOpt[7]]);
                
                
            //console.log(res);
            //mySocket.write('res', 'utf8');    
			break;
			case "IT":
				var obj = JSON.parse(arrOpt[1]);
				var sqlExec = "SELECT saldo - " + obj.inscripcion + " sld " + 
						" FROM player WHERE id = ?";							
			
				console.log("SELECT saldo - " + obj.inscripcion + " sld " + 
						" FROM player WHERE id = ? " + socket.id);
				dbExecute(queryExec, fnGetTransacciones, [socket], []);
				var res = connection.query(sqlExec, [socket.id],
					function(err, results, fields) {
						confirmandoInscripcion(err, results, fields, socket, arrOpt, obj);
						
					})
			break;
			case "FP":
				var obj = JSON.parse(arrOpt[1]);
				var sqlExec = "UPDATE partida SET resultado = ?, estado = ? WHERE id = ?";
				dbExecute(sqlExec, null, [socket], [obj.resultado, 'T', obj.id]);
				
				console.log(obj);	
				var sqlExec = "UPDATE player SET puntos" + obj.tipo + " = ?, saldo = saldo + ? WHERE id = ?";
				dbExecute(sqlExec, null, [socket], [obj.puntosJ1, obj.gananciaP1, obj.idPlayer1]);
				
				var sqlExec = "UPDATE player SET puntos" + obj.tipo + " = ?, saldo = saldo + ? WHERE id = ?";
				dbExecute(sqlExec, null, [socket], [obj.puntosJ2, obj.gananciaP2, obj.idPlayer2]);
				
				if(obj.resultado.split(':')[1] != 'T'){
					var sqlExec = "UPDATE player SET triunfos = triunfos + 1 WHERE id = ?";
					dbExecute(sqlExec, null, [socket], [socket.oponente]);
					
					var sqlExec = "UPDATE player SET derrotas = derrotas + 1 WHERE id = ?";
					dbExecute(sqlExec, null, [socket], [socket.id]);
					
				} else {
				
					var sqlExec = "UPDATE player SET triunfos = tablas + 1 WHERE id in (?,?)";
					dbExecute(sqlExec, null, [socket], [socket.id, socket.oponente]);
					
				}
				
					
				
				var sqlExec = "SELECT `id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul` FROM `player` WHERE id = " + socket.id;
				dbExecute(sqlExec, fnGetUser, [socket, 0], []);
				
					
				var sqlExec = "SELECT `id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul` FROM `player` WHERE id = " + socket.oponente;
				dbExecute(sqlExec, fnGetUser, [arrSocket['U' + socket.oponente], 1], []);
				
				//arrSocket['U' + socket.oponente].write("RECEP|MSG|OK|Usted a ganado" + '|'+ arrOpt[arrOpt.length - 1], 'utf8');  
				
			break;
			
			case "FP2":
				var obj = JSON.parse(arrOpt[1]);
				var sqlExec = "UPDATE partida SET resultado = ?, estado = ? WHERE id = ?";
				dbExecute(sqlExec, null, [socket], [obj.resultado, 'T', obj.id]);
				console.log(obj);	
				var sqlExec = "UPDATE player SET puntos" + obj.tipo + " = ?, saldo = saldo + ? WHERE id = ?";
				dbExecute(sqlExec, null, [socket], [obj.puntosJ1, obj.gananciaP1, obj.idPlayer1]);
				var sqlExec = "UPDATE player SET puntos" + obj.tipo + " = ?, saldo = saldo + ? WHERE id = ?";
				dbExecute(sqlExec, null, [socket], [obj.puntosJ2, obj.gananciaP2, obj.idPlayer2]);
				if(obj.resultado.split(':')[1] != 'T'){
					var sqlExec = "UPDATE player SET triunfos = triunfos + 1 WHERE id = ?";
					dbExecute(queryExec, null, [socket], [socket.id]);
					var sqlExec = "UPDATE player SET derrotas = derrotas + 1 WHERE id = ?";
					dbExecute(sqlExec, null, [socket], [socket.oponente]);
						
				} else {
				
					var sqlExec = "UPDATE player SET triunfos = tablas + 1 WHERE id in (?,?)";
					dbExecute(sqlExec, null, [socket], [socket.id, socket.oponente]);
					
				}
				
					
				
				var sqlExec = "SELECT `id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul` FROM `player` WHERE id = " + socket.id;
				dbExecute(sqlExec, fnGetUser, [socket], []);
				socket.write("RECEP|MSG|OK|Usted a ganado" + '|'+ arrOpt[arrOpt.length - 1], 'utf8');  
				
			break;
			
			
			case 'RES_TAB_POS':
				obj = arrOpt[1];
				
				console.log('RES_TAB_POS');
				console.log(obj);
				arrSocket['U' + socket.oponente].write("RECEP|RES_TAB_POS|" + obj + '|'+ arrOpt[3] + '|'+ arrOpt[4] + '|' + arrOpt[5] + '|' + arrOpt[arrOpt.length - 1], 'utf8');  
								
			break;
			
			case 'SOL_TAB_POS'://50852914
				obj = arrOpt[1];
				
				console.log("consultando SOL_TAB_POS a usuario: " + socket.oponente);
				//console.log(arrSocket['U' + socket.oponente]);
				console.log("RECEP|SOL_TAB_POS|" + obj + '|'+ arrOpt[arrOpt.length - 1]);
				arrSocket['U' + socket.oponente].write("RECEP|SOL_TAB_POS|" + obj + '|'+ arrOpt[arrOpt.length - 1], 'utf8');  
			break;
			
			case 'RECONEXION':
				obj = arrOpt[1];
				
				
				arrSocket['U' + socket.oponente].write("RECEP|RECONEXION|" + arrOpt[arrOpt.length - 1], 'utf8');  
			break;
			
			case 'CONS_PART':
				sqlExec = "SELECT `id`, `idPlayer1`, `idPlayer2`, `color_p1`, `estado`, `resultado`, `detalle_fin`, `p1_conn`, `p2_conn`, `duracion`, `apuesta`, `minELO`, `maxELO`, `torneo_id`, `tipo`, `puntosJ1`, `puntosJ2`, `ganancia`, `Player1`, `Player2` FROM partida WHERE estado = 'S' AND qdp = 0 AND (idPLayer1 = " + socket.id + " OR idPLayer2 = " + socket.id + ")";
				console.log("SELECT `id`, `idPlayer1`, `idPlayer2`, `color_p1`, `estado`, `resultado`, `detalle_fin`, `p1_conn`, `p2_conn`, `duracion`, `apuesta`, `minELO`, `maxELO`, `torneo_id`, `tipo`, `puntosJ1`, `puntosJ2`, `ganancia`, `Player1`, `Player2` FROM partida WHERE estado = 'S' AND qdp = 0 AND (idPLayer1 = " + socket.id + " OR idPLayer2 = " + socket.id + ")");
				
				dbExecute(sqlExec, fnConsPart, [socket], []);
				
			break;
			case 'nuevoFen':
				try{
					obj = JSON.parse(arrOpt[1]);
					obj['piezaCapturada'] = null;
					obj['piezaMovida'] = null;
					sqlExec = "INSERT INTO `fen`(`fen`) VALUES ('" + obj['fenNuevo'] + "')";
					console.log("INSERT INTO `fen`(`fen`) VALUES ('" + obj['fenNuevo'] + "')");
					dbExecute(sqlExec, null, [], []);
					
					sqlExec = "INSERT INTO `fen_hist`(`fen_act`, `fen_ant`) VALUES ('" + obj['fenNuevo'] + "', '" + obj['arrFen'].pop() + "')";			
					console.log("INSERT INTO `fen_hist`(`fen_act`, `fen_ant`) VALUES ('" + obj['fenNuevo'] + "', '" + obj['arrFen'].pop() + "')");
					dbExecute(sqlExec, null, [], []);
					
					collection.insert(obj); 	
				} catch(e){
					console.log(obj);
					sqlExec = "INSERT INTO `error`(`err`) VALUES ('" + arrOpt[1] + "')";
					console.log("INSERT INTO `error`(`err`) VALUES ('" + arrOpt[1] + "')");
					dbExecute(sqlExec, null, [], []);
					
				}
				
				
			break;
			case 'finFen':
				try{
					obj = JSON.parse(arrOpt[1]);
					obj['piezaCapturada'] = null;
					obj['piezaMovida'] = null;
					sqlExec = "INSERT INTO `fen_hist`(`fen_act`, `fen_ant`) VALUES ('" + obj['fenNuevo'] + "', '" + obj['arrFen'].pop() + "')";			
					console.log("INSERT INTO `fen_hist`(`fen_act`, `fen_ant`) VALUES ('" + obj['fenNuevo'] + "', '" + obj['arrFen'].pop() + "')");
					dbExecute(sqlExec, null, [], []);
					
					collection.update({fen: obj['fenNuevo']}, obj); 	
				} catch (e) {
					console.log(obj);
					sqlExec = "INSERT INTO `error`(`err`) VALUES ('" + arrOpt[1] + "')";
					console.log("INSERT INTO `error`(`err`) VALUES ('" + arrOpt[1] + "')");
					dbExecute(sqlExec, null, [], []);
				
				}
				
			break;
			
			case 'resultadoFen':
				try{
					obj = JSON.parse(arrOpt[1]);
					obj['piezaCapturada'] = null;
					obj['piezaMovida'] = null;
					sqlExec = "UPDATE `fen` SET  resultado = '" + obj['resultado'] + "' WHERE fen = '" + obj['fenNuevo'] + "'";			
					console.log("UPDATE `fen` SET  resultado = '" + obj['resultado'] + "' WHERE fen = '" + obj['fenNuevo'] + "'");
					dbExecute(sqlExec, null, [], []);
					collection.update({fen: obj['fenNuevo']}, {$set: {resultado: obj['resultado']}}, true);	
				} catch (e) {
					console.log(obj);
					sqlExec = "INSERT INTO `error`(`err`) VALUES ('" + arrOpt[1] + "')";
					console.log("INSERT INTO `error`(`err`) VALUES ('" + arrOpt[1] + "')");
					dbExecute(sqlExec, null, [], []);
				
				}
				
			break;
		}
	}
}

function fnMovida(err, results, fields, arrParam) {
	var socket = arrParam[0];
    var movimiento = arrParam[1];
	var tiempo = arrParam[2];
	var arrOpt = arrParam[3];
	console.log("EJECUTANDO");
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('MAL');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//console.log(results['id']);
		
		console.log("----------------" + socket.oponente)
		arrSocket['U' + socket.oponente].write('RECEP|MOV|OK|' + movimiento + '|'  + tiempo + '|' + arrOpt[8] + '|'  + arrOpt[9] + '|'  + arrOpt[7] + '|' + arrOpt[arrOpt.length - 1], 'utf8'); 
		
		
	}
	return results;
}

function fnGetUser(err, results, fields, arrParam){
	var socket = arrParam[0];
	var datos = arrParam[1];
	resultados = JSON.stringify(results[0]);
	socket.write('RECEP|FP|' + resultados + '|' + datos + '|' + socket.fin, 'utf8');
}


function fnDatosPartida(err, results, fields, arrParam) {
	//confirmandoInscripcion(err, results, fields, socket, arrOpt, obj);
	var socket = arrParam[0];
	if(err) { 
		console.log('MAL');
		socket.write('FAIL|' + 0 + '|' + socket.fin, 'utf8');  
	} else {
		resultados = JSON.stringify(results[0]);
		arrSocket['U' + creador].write('RECEP|INI|OK|' + resultados + '|' + socket.fin, 'utf8'); 
	}
	
}

function fnIniciandoPartida(err, results, fields, arrParam){
	var socket = arrParam[0];
	var creador = arrParam[1];
	var partida = arrParam[2];
	var tiempo = arrParam[3];
	var colorPropio = arrParam[4];
	var usuario = arrParam[5];
	var color = arrParam[6];
	var puntos = arrParam[7];
	console.log(fnIniciandoPartida);
	console.log(results);
	if(err) {    
	 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		console.log('MAL');
		console.log(err);
		socket.write('FAIL|' + 0 + '|' + socket.fin, 'utf8');  
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		console.log('OK|' + creador + '|' + partida + '|' +  tiempo + '|' + colorPropio + '|' + socket.fin);
		console.log('RECEP|INI|OK|' + usuario + '|' + socket.fin);
		socket.write('OK|' + creador + '|' + partida + '|' +  tiempo + '|' + color + '|' + socket.fin, 'utf8');
		//console.log(arrSocket['U' + creador]);
		socket.oponente = creador;
		arrSocket['U' + creador].oponente = socket.id;
		sqlExec = "SELECT `id`, `idPlayer1`, `idPlayer2`, `color_p1`, `estado`, `resultado`, `detalle_fin`, `p1_conn`, `p2_conn`, `duracion`, `apuesta`, `minELO`, `maxELO`, `torneo_id`, `tipo`, `puntosJ1`, `puntosJ2`, `ganancia`, `Player1`, `Player2` FROM `partida` WHERE id = " + partida;
		dbExecute(sqlExec, fnDatosPartida, [socket], []);
		
	}
}


function fnPtosJugador2(err, results, fields, arrParam) {
	var socket = arrParam[0];
	
	//confirmandoInscripcion(err, results, fields, socket, arrOpt, obj);
	if(err){
		console.log(err);
	} else {
		resultados = JSON.stringify(results[0]);
		socket.write('RECEP|AU|' + resultados + '|' + socket.fin, 'utf8');
	}
	
}

function fnPtosJugador1(err, results, fields, arrParam) {
	var socket = arrParam[0];
	console.log(socket.oponente);
	//console.log(arrSocket);
	//confirmandoInscripcion(err, results, fields, socket, arrOpt, obj);
	resultados = JSON.stringify(results[0]);
	arrSocket['U' + socket.oponente].write('RECEP|AU|' + resultados + '|' + socket.fin, 'utf8');
	
}

function fnIniciaPartida(err, results, fields, arrParam) {
	var socket = arrParam[0];				
	var usuario = arrParam[1];
	var puntos = arrParam[2];
	var saldo = arrParam[3];
	var color = arrParam[4];
	var tiempo = arrParam[5];
	console.log("EJECUTANDO");
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('MAL Select');
	} else { 
		console.log(results.length);
		if(results.length > 0){
			console.log(results[0]['id'] + '|' + socket.fin);
			creador = results[0]['idPlayer1'];
			socket.partidaAct = results[0]['id'];
			partida = results[0]['id'];
			color = results[0]['color_p1'];
			var colorPropio;
			if(color == 'B'){
				colorPropio = 'N';
			} else {
				colorPropio = 'B';
			}
	//		console.log("CREADOR = " + results[0]);
			var sqlExec = "UPDATE partida SET idPlayer2 = ?, puntosJ2 = ?, estado = 'J' WHERE id = ? AND idPlayer1 <> " + usuario + " AND estado = 'V'";
		//	console.log(creador);
			console.log("UPDATE partida SET idPlayer2 = " + usuario +" WHERE id = " + results[0]['id'] + " AND idPlayer1 <> " + usuario + " AND estado = 'V'");
			console.log('usuario = ' + usuario + ', id = ' + results[0]['id']);
			dbExecute(sqlExec, fnIniciandoPartida, [socket, creador, partida, tiempo, colorPropio, usuario, color, puntos], [usuario, puntos, results[0]['id']]);
			
			
			sqlExec = "UPDATE player SET saldo = saldo - ? WHERE id in (" + socket.id + ", " + creador + ");";
			console.log(sqlExec);
			dbExecute(sqlExec, null, [], [saldo]);
			
			
			sqlExec = "SELECT `id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul` FROM `player` WHERE id = " + creador;
			console.log(sqlExec);
			dbExecute(sqlExec, fnPtosJugador2, [socket], []);
			
				
			sqlExec = "SELECT `id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul` FROM `player` WHERE id = " + socket.id;
			console.log(sqlExec);
			dbExecute(sqlExec, fnPtosJugador1, [socket], []);		
		} else {
			partida = 0
		}
	}
}



function perfilOponente(err, results, fields, arrParam){
	console.log('ingresando en perfilOponente');
	//console.log(arrParam);
	var socket = arrParam[0];
	var usuario = arrParam[1];
	var arrOpt = arrParam[2];
	var resp = '';
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('[ERROR EN CONSULTA]');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//console.log(results['id']);
		console.log(results.length);
	//	console.log(results[0]);
		if(results.length > 0){		
			socket.write(JSON.stringify(results[0]) + '|' + arrOpt[arrOpt.length - 1], 'utf8');					
		} 		
	}
	return results;


}

function registroUser(err, results, fields, arrParam){
	console.log('ingresando en registroUser');
	//console.log(arrParam);
	var socket = arrParam[0];
	var usuario = arrParam[1];
	var arrOpt = arrParam[2];
	var resp = '';
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('[ERROR EN CONSULTA]');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//console.log(results['id']);
		console.log(results.length);
	//	console.log(results[0]);
		if(results.length > 0){
			
			usuario = results[0]['id'];		
			if(results[0]['usuario_id'] == null){
			//	console.log(JSON.stringify(results[0]));
				socket.write(JSON.stringify(results[0]) + '|' + arrOpt[arrOpt.length - 1], 'utf8');
				
				
				
				socket.usuario = JSON.parse(JSON.stringify(results[0]));
				arrSocket['U' + usuario] = socket;
				socket.id = usuario;
				socket.setTimeout(500000, function(){
					datextra(socket);
				})
				
				
				
				
				console.log('[El Nuevo User es : U' + socket.id + ']');
				sqlExec = "INSERT INTO `sesion`(`id`, `usuario_id`, `fecha_conexion`, `fecha_desconexion`, `estado`) VALUES (null," + usuario + ",now(),null,'V')";				
				dbExecute(sqlExec, null, [], [usuario]);
				//res = connection.query(sqlExec, [usuario])
				
				
				
				socket.fin = arrOpt[arrOpt.length - 1];
			} else {
				socket.write("RECEP|MSG|OK|Usuario ya inicio sesion" + '|'+ arrOpt[arrOpt.length - 1], 'utf8'); 
				arrSocket['U' + results[0]['usuario_id']].write("RECEP|NOP|" + arrOpt[arrOpt.length - 1], 'utf8'); 
			/*	console.log(arrSocket['U' + usuario]);
				console.log("/***********************************************************");
				console.log(socket);*/
			}
			
			
		} else {                        
			socket.write(0 + '|' + 0 + '|' + arrOpt[arrOpt.length - 1], 'utf8');
			console.log('[Usuario No existe]');
		}
		
	}
	return results;


}


function crearCuenta(err, results, fields, arrParam){
	console.log('ingresando en crearCuenta');
	//console.log(arrParam);
	var socket = arrParam[0];
	var usuario = arrParam[1];
	var arrOpt = arrParam[2];
	var resp = '';
	console.log(arrParam[1]);
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('[ERROR EN CONSULTA]');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//console.log(results['id']);
		console.log(results.length);
	//	console.log(results[0]);
		if(results.length > 0){
			socket.write("RECEP|MSG|OK|Usuario ya existe" + '|'+ arrOpt[arrOpt.length - 1], 'utf8'); 				
		} else {                        
			sqlExec = "INSERT INTO `player`(`id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul`) VALUES (null,'" + usuario.user + "','" + usuario.pass + "',1400,0,0,0,0,1400,1400,0,0,0)";		
			console.log(sqlExec);
				dbExecute(sqlExec, cuentaNueva, [socket, arrOpt], []);
		}
		
	}
	return results;


}

function cuentaNueva(err, results, fields, arrParam){
	var socket = arrParam[0];
	var arrOpt = arrParam[1];
	if(err){
	
	} else {
		socket.write('RECEP|CUENTA_CREADA|' + arrOpt[arrOpt.length - 1], 'utf8');
		results['insertId']
		
	}
}


function fnConsPart(err, results, fields, arrParam){
	var socket = arrParam[0];
	if(err){
	
	} else {
		if(results.length > 0){
			console.log("EL JUGADOR TIENE PARTIDA EN ESPERA")
			socket.write('RECEP|PARTIDA_RECONEX|' + JSON.stringify(results[0]) + '|' + socket.fin, 'utf8');
			socket.partidaAct = results[0].id;
			if(socket.id == results[0].idPlayer1){
				socket.oponente = results[0].idPlayer2;
				//arrSocket['U' + results[0].idPlayer2].write('RECEP|SOL_TAB_POS|' + arrOpt[arrOpt.length - 1], 'utf8');
			} else {
				socket.oponente = results[0].idPlayer1;
				//arrSocket['U' + results[0].idPlayer1].write('RECEP|SOL_TAB_POS|' + arrOpt[arrOpt.length - 1], 'utf8');
			}
		}
		
	}

}


function fnGetTransacciones(err, results, fields, arrParam) {
	console.log('MERCADO-----------------------');
	var socket = arrParam[0];
//	console.log("EJECUTANDO");
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
//		 console.log('MAL Select');
	} else { 
		console.log(results.length);
		if(results.length > 0){
			console.log(results);
			var resultados = '';
			for(var i = 0; i < results.length; i++){
				resultados += JSON.stringify(results[i]);
				resultados += '|';
			}						
			socket.write('OK|' + resultados + socket.fin, 'utf8');					
		} else {
			socket.write('OK|' + resultados + socket.fin, 'utf8');
			partida = 0
		}
	}
}


function fnGetTorneos(err, results, fields, arrParam) {
	console.log('TORNEO-----------------------');
	var socket = arrParam[0];
//	console.log("EJECUTANDO");
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
//		 console.log('MAL Select');
	} else { 
		console.log(results.length);
		if(results.length > 0){
			console.log(results);
			var resultados = '';
			for(var i = 0; i < results.length; i++){
				resultados += JSON.stringify(results[i]);
				resultados += '|';
			}						
			socket.write('OK|' + resultados + socket.fin, 'utf8');					
		} else {
			socket.write('OK|' + resultados + socket.fin, 'utf8');
			partida = 0
		}
	}
}


function todaLasPartidas(err, results, fields, arrParam) {
	var socket = arrParam[0];
	var arrOpt = arrParam[1];
	console.log('partidas nuevas');
//	console.log("EJECUTANDO");
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
//		 console.log('MAL Select');
	} else { 
		console.log(results.length);
		if(results.length > 0){
			//console.log(results[0]['id'] + '|' + arrOpt[arrOpt.length - 1]);
			var resultados = '';
			for(var i = 0; i < results.length; i++){
				resultados += JSON.stringify(results[i]);
				resultados += '|';
			}						
			socket.write('OK|' + resultados + socket.fin, 'utf8');												
		} else {
			socket.write('NOOK|' + resultados + socket.fin, 'utf8');
			partida = 0
		}
	}
}

function fnActualizaPartidas(err, results, fields, arrParam){
	var socket = arrParam[0];
	//var arrOpt = arrParam[1];
	if(err){
		console.log(err);
	} else {
		//enviaMasivo(arrSocket, arrSocket["U" + socket.oponente], socket.fin, 'TP', false);
		enviaMasivo(arrSocket, socket, socket.fin, 'TP', false);
	}
	
}


function informeResultado(err, results, fields, arrParam) {
	//confirmandoInscripcion(err, results, fields, socket, arrOpt, obj);
	var socket = arrParam[0];
	if(err){
		console.log(err);
	} else {
		resultados = JSON.stringify(results[0]);
		console.log(resultados);
		arrSocket['U' + socket.oponente].write('RECEP|FP|' + resultados + '|' + socket.fin, 'utf8');
		arrSocket['U' + socket.oponente].write("RECEP|MSG|OK|Usted a ganado" + '|' + socket.fin, 'utf8');  
	}
	
}


function fnEnvioReconex(err, results, fields, arrParam) {
	var socket = arrParam[0];	
	if(err){
	
	} else {
		if(results.affectedRows != 0){
			console.log('RECEP|ESPERA_CONEXION|');
			arrSocket['U' + socket.oponente].write("RECEP|ESPERA_CONEXION|" + socket.fin, 'utf8'); 
		} else {
			sqlExec = "UPDATE partida SET estado = 'E' WHERE estado = 'S' AND id = " + socket.partidaAct + " AND qdp = 0";
			dbExecute(sqlExec, null, [], []);	
			
		}
		
	}
}

function fnActualizaPartidas2(err, results, fields, arrParam) {
	var socket = arrParam[0];
				
	if(err){
		
		
	} else {
		console.log(results);
		if(results.affectedRows != 0){
			var sqlExec = "SELECT `id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul` FROM `player` WHERE id = " + socket.oponente;
			console.log("SELECT `id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul` FROM `player` WHERE id = " + socket.oponente);
			
			dbExecute(sqlExec, informeResultado, [socket], []);			
		} else {
		
			sqlExec = "UPDATE partida SET estado = 'S' WHERE estado = 'J' AND id = " + socket.partidaAct + " AND qdp = 0";
			console.log("UPDATE partida SET estado = 'S' WHERE estado = 'J' AND id = " + socket.partidaAct + " AND qdp = 0");
			dbExecute(sqlExec, fnEnvioReconex, [socket], []);				
		}	
	}
}

function closeSocket(socket) {
	console.log('***************************************');
	console.log('ingresando en closeSocket');//53820010
	if(socket.id != undefined){
		console.log('Usuario Desconectando: ' + socket.id);
		var sqlExec = "UPDATE sesion SET estado = 'E' WHERE usuario_id = " + socket.id;
		//var sqlExec = "UPDATE sesion SET estado = 'E'";//pruebas
		console.log("UPDATE sesion SET estado = 'E' WHERE usuario_id = " + socket.id);
		dbExecute(sqlExec, null, [socket], []);
		
		
		sqlExec = "UPDATE partida SET estado = 'E', resultado = 'Anulada', detalle_fin = 'Usuario Creador desconectado'  WHERE estado = 'V' AND idPlayer2 is null AND idPlayer1 = " + socket.id;
		
		dbExecute(sqlExec, fnActualizaPartidas, [socket], []);
		
		
		
		sqlExec = "UPDATE partida SET estado = 'T', resultado = '" + socket.oponente + "', detalle_fin = 'Terminada por desconexion'  WHERE estado = 'J' AND id = " + socket.partidaAct + " AND qdp = 1";
		
		console.log("UPDATE partida SET estado = 'T', resultado = '" + socket.oponente + "', detalle_fin = 'Terminada por desconexion'  WHERE estado = 'J' AND id = " + socket.partidaAct + " AND qdp = 1");
		
		dbExecute(sqlExec, fnActualizaPartidas2, [socket], []);
		
		
		
		
			
			
			
			
			
			
		sqlExec = "UPDATE partida SET estado = 'E', detalle_fin = 'Terminada por desconexion'  WHERE estado = 'S' AND id = " + socket.partidaAct + ";";
		dbExecute(sqlExec, null, [], []);
		
		
		
	}
	
}

function onClose(socket)
{
	console.log("ingresando en onClose");
	//console.log(socket);
	//closeSocket(socket);
	if(socket.id != undefined){
		console.log('Usuario Desconectando: ' + socket.id);
		var sqlExec = "UPDATE sesion SET estado = 'E' WHERE usuario_id = " + socket.id;
		//var sqlExec = "UPDATE sesion SET estado = 'E'";//pruebas
		console.log("UPDATE sesion SET estado = 'E' WHERE usuario_id = " + socket.id);
		dbExecute(sqlExec, null, [socket], []);
		
		
		sqlExec = "UPDATE partida SET estado = 'E', resultado = 'Anulada', detalle_fin = 'Usuario Creador desconectado'  WHERE estado = 'V' AND idPlayer2 is null AND idPlayer1 = " + socket.id;
		
		dbExecute(sqlExec, fnActualizaPartidas, [socket], []);
		
		
		
		sqlExec = "UPDATE partida SET estado = 'T', resultado = '" + socket.oponente + "', detalle_fin = 'Terminada por desconexion'  WHERE estado = 'J' AND id = " + socket.partidaAct + " AND qdp = 1";
		
		console.log("UPDATE partida SET estado = 'T', resultado = '" + socket.oponente + "', detalle_fin = 'Terminada por desconexion'  WHERE estado = 'J' AND id = " + socket.partidaAct + " AND qdp = 1");
		
		dbExecute(sqlExec, fnActualizaPartidas2, [socket], []);
		
		
		
		
			
			
			
			
			
			
		sqlExec = "UPDATE partida SET estado = 'E', detalle_fin = 'Terminada por desconexion'  WHERE estado = 'S' AND id = " + socket.partidaAct + ";";
		dbExecute(sqlExec, null, [], []);
		
		
		
	}
	
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
	
	
	
}


function datextra(socket){
	console.log("ETAEYARYDTSHFDGDSDFHGJFHDYHTDFHFDH");
	socket.write('RECEP|NOP|' + socket.fin, 'utf8');
	socket.setTimeout(500000, function(){
		datextra(socket);
	});
}

function confirmandoPartida(err, results, fields, arrParam){
	var socket = arrParam[0];
	var arrOpt = arrParam[1];
	var obj = arrParam[2];
	console.log('ingresando en confirmandoPartida');
	var resp = '';
	if(err) {    
		console.log('[ERROR EN CONSULTA]');
	}
	else {    
		console.log(results.length);
		//console.log(usuario);
		if(results.length > 0){
			console.log("Saldo: " + results[0]['sld']);
			if(results[0]['sld'] >= 0){
				creaPartida(arrOpt, socket, obj);
			} else {
				console.log("Cliente sin Saldo");
				socket.write("RECEP|MSG|OK|Cliente sin Saldo" + '|'+ arrOpt[arrOpt.length - 1], 'utf8'); 
			}
		}
	}	
}

function confirmandoTorneo(err, results, fields, socket, arrOpt, obj){
	console.log('ingresando en confirmandoTorneo');
	var resp = '';
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('[ERROR EN CONSULTA]');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//console.log(results['id']);
		console.log(results.length);
		
		if(results.length > 0){
			//console.log("Saldo: " + results[0]['sld']);
			if(results[0]['res'] >= 0){
				creaTorneo(arrOpt, socket, obj);
			} else {
				console.log("Cliente sin Saldo");
				socket.write("RECEP|MSG|OK|No está autorizado" + '|'+ arrOpt[arrOpt.length - 1], 'utf8'); 
			}
		}
	}	
}


function confirmandoMercado(err, results, fields, socket, arrOpt, obj){
	console.log('ingresando en confirmandoMercado');
	var resp = '';
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('[ERROR EN CONSULTA]');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//console.log(results['id']);
		console.log(results.length);
		
		if(results.length > 0){
			//console.log("Saldo: " + results[0]['sld']);
			if(results[0]['sld'] >= 0){
				creaTransaccion(arrOpt, socket, obj);
			} else {
				console.log("Cliente sin Saldo");
				socket.write("RECEP|MSG|OK|No está autorizado" + '|'+ arrOpt[arrOpt.length - 1], 'utf8'); 
			}
		}
	}	
}


function confirmandoInscripcion(err, results, fields, socket, arrOpt, obj){
	console.log('ingresando en confirmandoInscripcion');
	var resp = '';
	if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('[ERROR EN CONSULTA]');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//console.log(results['id']);
		console.log(results.length);
		
		if(results.length > 0){
			//console.log("Saldo: " + results[0]['sld']);
			if(results[0]['sld'] >= 0){
				creaInscripcion(arrOpt, socket, obj);
			} else {
				console.log("Cliente sin Saldo");
				socket.write("RECEP|MSG|OK|No está autorizado" + '|'+ arrOpt[arrOpt.length - 1], 'utf8'); 
			}
		}
	}	
}


function creaPartida(arrOpt, sk, obj){
	var partida = 0;
	var sqlExec = "INSERT INTO `partida`(`id`, `idPlayer2`, `estado`, `resultado`, `detalle_fin`, `p1_conn`, `p2_conn`, Player2, `puntosJ2`, `idPlayer1`, `color_p1`, `duracion`, `minELO`, `maxELO`, `apuesta`, `tipo`, `puntosJ1`, `ganancia`, Player1, `qdp`) VALUES (null,null,'V','V','V',1,0,'',null,?,?,?,?,?,?,?,?,?,?,?)";
	
	console.log(obj);
	
	var color;
	switch(arrOpt[2]){
		case 'Aleatorio':                    
			if(Math.random() < 0.5){
				color = 'B';
			} else {
				color = 'N';
			} 
		break;    
		case 'Blancas':
			color = 'B';
		break;
		case 'Negras':
			color = 'N';
		break;
	}
	
	
	
	//var tiempo = arrOpt[3];
	//console.log("EJECUTANDO");
	dbExecute(sqlExec, fnCreandoPartida, [sk, arrOpt, color], [obj.idPlayer1, color, obj.duracion, obj.minELO, obj.maxELO, obj.apuesta, obj.tipo, obj.puntosJ1, obj.ganancia, obj.Player1, obj.qdp]);
	
	
}


function fnCreandoPartida(err, results, fields, arrParam) {
	var sk = arrParam[0];
	var arrOpt = arrParam[1];
	var color = arrParam[2];
	if(err) {    
	 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
	 console.log('MAL');
	 sk.write('FAIL|' + 0 + '|' + sk.fin, 'utf8');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		console.log('OK');
		//console.log(results);
		//OK, id partida, tiempo, color
		
		sk.write('OK|' + results['insertId'] + '|' + color + '|' + sk.fin, 'utf8');
		sk.partidaAct = results['insertId'];
		console.log("PARTIDA::::::::" + partida);
		if(sk.partida != 0){
			var sqlExec = "UPDATE partida SET estado = 'E', resultado = 'Anulada', detalle_fin = 'Usuario Crea otra partida'  WHERE id <> " + results['insertId'] + " AND idPlayer2 is null";							
			console.log("UPDATE partida SET estado = 'E', resultado = 'Anulada', detalle_fin = 'Usuario Crea otra partida'  WHERE id <> " + results['insertId'] + " AND idPlayer2 is null");
			
			dbExecute(sqlExec, fnEliminandoPartidasAntiguas, [sk], []);
			
			
		}
		
		
		enviaMasivo(arrSocket, sk, arrOpt, 'TP', false);
		

		sk.partida = results['insertId'];
		console.log('partida:' + sk.partida);
	}
}


function fnEliminandoPartidasAntiguas(err, results, fields, arrParam) {
	var sk = arrParam[0];
	if(err) {    
	 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
	 console.log('MAL');
	 sk.write('FAIL|' + 0 + '|' + sk.fin, 'utf8');
	}
	else {    
		//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
		//sk.write('Desconectado|' + 0 + '|' + finStream, 'utf8');
		//console.log(results);
		
	}
}


function creaTorneo(arrOpt, socket, obj){
	var partida = 0;
	var sqlExec = "INSERT INTO `torneo`(`id`, `creadorId`, `minELO`, `maxELO`, `inscripcion`, `duracion`, `sistemaJuego`, `rondas`, `maxJugadores`, `ganadorId`, `premio`, `estado`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
              
				console.log('ingresando en creaTorneo');
				
				console.log(obj);
				
                connection.query(sqlExec, [obj.id, obj.creadorId, obj.minELO, obj.maxELO, obj.inscripcion, obj.duracion, obj.sistemaJuego, obj.rondas, obj.maxJugadores, obj.ganadorId, obj.premio, obj.estado], 
					function(err, results, fields) {
						if(err) {    
						 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
						 console.log('MAL');
						 socket.write('FAIL|' + 0 + '|' + arrOpt[arrOpt.length - 1], 'utf8');
						}
						else {    
							//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
							console.log('OK');
							//console.log(results);
							//OK, id partida, tiempo, color
							socket.write('OK|' + results['insertId'] + '|' + arrOpt[arrOpt.length - 1], 'utf8');
	
							
							partida = results['insertId'];
							enviaMasivo(arrSocket, socket, arrOpt, 'TT', false);
							timer = setTimeout(function(){
	console.log('enviaMasivo');
	for (var allSock in arrSocket){
		console.log('todas las partidas para usuario ' + allSock);
		arrSocket[allSock].write('RECEP|MSG|OK|Inicio torneo|' + arrOpt[arrOpt.length - 1], 'utf8');
		
	}
}, 10000);
						}
					})
}

function activarTorneo(arrOpt){
	console.log('enviaMasivo');
	for (var allSock in arrSocket){
		console.log('todas las partidas para usuario ' + allSock);
		arrSocket[allSock].write('RECEP|MSG|OK|Inicio torneo|' + arrOpt[arrOpt.length - 1], 'utf8');
		
	}
}

function creaTransaccion(arrOpt, socket, obj){
	var partida = 0;
	var sqlExec = "INSERT INTO `mercado`(`id`, `creadorId`, `cantidad`, `precio`, `tipo`, `estado`, `fechaHora`, `moneda`) VALUES (?,?,?,?,?,?,?,?)";
              
	console.log('ingresando en creaTorneo');
	
	console.log(obj);
	var d = new Date(); 
	
	obj.fechaHora = d.getDate() + "/" + (d.getMonth() +1) + "/" + d.getFullYear(), ', '+d.getHours(),':'+d.getMinutes(),':'+d.getSeconds();
	connection.query(sqlExec, [null, obj.creadorId, obj.cantidad, obj.precio, obj.tipo, obj.estado, obj.fechaHora, obj.moneda], 
	function(err, results, fields) {
		if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('MAL');
		 socket.write('FAIL|' + 0 + '|' + arrOpt[arrOpt.length - 1], 'utf8');
		}
		else {    
			//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
			console.log('OK');
			//console.log(results);
			//OK, id partida, tiempo, color
			socket.write('OK|' + results['insertId'] + '|' + arrOpt[arrOpt.length - 1], 'utf8');

			
			partida = results['insertId'];
			enviaMasivo(arrSocket, socket, arrOpt, 'TM', false);
		}
	})
}

function creaInscripcion(arrOpt, socket, obj){
	var partida = 0;
	var sqlExec = "INSERT INTO `torneo_jugador`(`id`, `torneo_id`, `player_id`) VALUES (null,?,?)";
              
	console.log('ingresando en creaInscripcion');
	
	console.log(obj);
	
	
	
	connection.query(sqlExec, [obj.id, socket.id], 
	function(err, results, fields) {
		if(err) {    
		 //customEvents.emit('AnimalCRUD:createAnimal', {"result" : "error", "data" : err });
		 console.log('MAL');
		 socket.write('FAIL|' + 0 + '|' + arrOpt[arrOpt.length - 1], 'utf8');
		}
		else {    
			//customEvents.emit('AnimalCRUD:createAnimal', {"result" : "ok"});
			console.log('OK');
			//console.log(results);
			//OK, id partida, tiempo, color
			socket.write('OK|' + results['insertId'] + '|' + arrOpt[arrOpt.length - 1], 'utf8');

			
			partida = results['insertId'];
			enviaMasivo(arrSocket, socket, arrOpt, 'TM', false);
		}
	})
}



function enviaMasivo(arrSocket, socket, arrOpt, opt, me){
	console.log('enviaMasivo');
	//console.log(socket);
	if(socket.hasOwnProperty('id')){
		for (var allSock in arrSocket){
			console.log('todas las partidas para usuario ' + allSock);
			//console.log(socket);
			if(allSock != 'U'+socket.id || me){                
				arrSocket[allSock].write('RECEP|' + opt + '|' + arrOpt, 'utf8');
				console.log('Corresponde para usuario ' + allSock);
			}	
			//break;
		}
	}
	
}	
/******************************************************************************/

var server = net.createServer(newSocket);

server.listen(9003);
