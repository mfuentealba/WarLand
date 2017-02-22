
console.log("Inicio 0.0.2");


var arrSocket = {};
var usuario = 0;
var net = require('net');
var eventos = require('events');
var EmisorEventos = eventos.EventEmitter; 
var ee = new EmisorEventos(); 

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
			case "CREAR_CUENTA":
				
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
	console.log(socket);
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

server.listen(9003);
