package servicios
{
	
	
	
	import com.adobe.serialization.json.JSON;
	
	import componentes.clases.ConexionSocket;
	import componentes.graficos.Tablero;
	
	import eventos.JugadorEvent;
	import eventos.MercadoEvent;
	import eventos.MovimientoEvent;
	import eventos.MovimientoFenEvent;
	import eventos.PartidaEvent;
	import eventos.SesionEvent;
	import eventos.TorneoEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	
	import flashx.textLayout.events.ModelChange;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;

	public class DelegadoNode extends EventDispatcher
	{
		
		
		protected var dbAsyncToken:AsyncToken;
		
		private var cache:ArrayCollection;
		
		public static const MOCK_ASYNC_TIME:int = 100;
		
		private var lastId:int;
		
		private static var delegado:DelegadoNode;
		private var connNode:ConexionSocket = Modelo.getInstance().conexion;
		private var _callbackRecep:Function;
		
		public static function getInstance():DelegadoNode
		{
			if ( delegado== null ){
				delegado = new DelegadoNode();
				
			}			
			return delegado;
		}
		
		public function DelegadoNode()
		{
			if(delegado){
				throw new Error("Singleton... use getInstance()");
				
			} 
			
			delegado = this;
			init();
		}
		
		private function init():void
		{
			
			/*****CREA EL DIRECTORIO QUE NECESITO PARA LA BASE****/
			connNode.callbackRecep = this.callbackRecep;

		}
		
		public function consultaSesion(data:SesionEvent, callback:Function):void{
			connNode.envia('LR|' + data.user + '|' + data.pass + '|' + com.adobe.serialization.json.JSON.encode({hola: 'hola', chao: 'chao'}) +'|', callback);
		}
		
		public function generaPartida(data:PartidaEvent, callback:Function):void{
			connNode.envia('GP|' + data.partida.id + '|' + data.partida.idPlayer1, callback);
		}
		
		public function finPartida(data:PartidaEvent, callback:Function):void{
			connNode.envia('FP|' + com.adobe.serialization.json.JSON.encode(data.partida) + '|', callback);
		}
		
		public function finPartida2(data:PartidaEvent, callback:Function):void{
			connNode.envia('FP2|' + com.adobe.serialization.json.JSON.encode(data.partida) + '|', callback);
		}
		
		public function ofertaTablas(data:PartidaEvent, callback:Function):void{
			connNode.envia('OFERTA_TABLAS|', callback);
		}
		
		public function solTabPos(data:PartidaEvent, callback:Function):void{
			connNode.envia('SOL_TAB_POS|' + com.adobe.serialization.json.JSON.encode(Modelo.getInstance().tablero) + '|' + (Modelo.getInstance().partida.idOponente) + '|', callback);
		}
		
		public function resTabPos(data:PartidaEvent, callback:Function):void{
			var tablero:Tablero = Modelo.getInstance().tablero;
			connNode.envia('RES_TAB_POS|' + tablero.generaFEN() + '|' + (Modelo.getInstance().partida.idOponente) + '|' + (Modelo.getInstance().tablero.relojUsuario.min + ':' + Modelo.getInstance().tablero.relojUsuario.seg) + '|' + (Modelo.getInstance().tablero.relojOponente.min + ':' + Modelo.getInstance().tablero.relojOponente.seg) + '|' + Modelo.getInstance().partida.arrMovimientos[Modelo.getInstance().partida.arrMovimientos.length - 1] + '|', callback);
		}
		
		
		public function reconexion(data:PartidaEvent, callback:Function):void{
			connNode.envia('RECONEXION|', callback);
		}
		
		public function consultaPartidaPendiente(data:PartidaEvent, callback:Function):void{
			connNode.envia('CONS_PART|', callback);
		}
		
		
		public function consultaPerfilOponente(data:PartidaEvent, callback:Function):void{
			connNode.envia('PO|' + data.partida.idPlayer1 + '|', callback);
		}
		
		public function creaPartida(data:PartidaEvent, callback:Function):void{
			connNode.envia('CP|' + com.adobe.serialization.json.JSON.encode(data.partida) + '|' + data.opcion + '|' + data.tiempo + '|' + data.partida.minELO + '|' + data.partida.maxELO + '|' + data.partida.apuesta + '|' + data.partida.tipo + '|' + data.partida.puntosJ1 + '|' + data.partida.ganancia + '|', callback);
		}
		
		
		public function creaTorneo(data:TorneoEvent, callback:Function):void{
			connNode.envia('CT|' + com.adobe.serialization.json.JSON.encode(data.torneoVO) + '|', callback);
		}
		
		public function creaMercado(data:MercadoEvent, callback:Function):void{
			connNode.envia('CM|' + com.adobe.serialization.json.JSON.encode(data.mercadoVO) + '|', callback);
		}
		
		public function nuevoFen(data:MovimientoFenEvent, callback:Function):void{
			connNode.envia('nuevoFen|' + com.adobe.serialization.json.JSON.encode(data.movimiento) + '|', callback);
		}
		
		public function finFen(data:MovimientoFenEvent, callback:Function):void{
			connNode.envia('finFen|' + com.adobe.serialization.json.JSON.encode(data.movimiento) + '|', callback);
		}
		
		public function resultadoFen(data:MovimientoFenEvent, callback:Function):void{
			connNode.envia('resultadoFen|' + com.adobe.serialization.json.JSON.encode(data.movimiento) + '|', callback);
		}
		
		public function crearCuenta(data:JugadorEvent, callback:Function):void{
			connNode.envia('CREAR_CUENTA|' + com.adobe.serialization.json.JSON.encode(data.jugador) + '|', callback);
		}
		
		
		public function buscaPartida(data:PartidaEvent, callback:Function):void{
			connNode.envia('BP|' + Modelo.getInstance().jugador.sesion.id + '|' + data.partida.colorUsuario + '|' + data.partida.duracion + '|' + data.partida.id + '|' + data.partida.puntosJ2 + '|' + data.partida.apuesta + '|', callback);
		}
		
		public function ejecutaMovimiento(data:MovimientoEvent, callback:Function):void{
			connNode.envia('EM|' + data.movimiento + '|' + data.idPartida + '|' + data.tiempo + '|' + data.idOponente + '|' + data.color + '|' + data.nroJugada + '|' + data.fen + '|' + Modelo.getInstance().tablero.codigoSMovPeonCambio + '|' + Modelo.getInstance().tablero.codigoEnroque + '|', callback);
		}
		
		public function buscaPartidasTodas(data:PartidaEvent, callback:Function):void{
			connNode.envia('TP|' + data.idJugador + '|' + data.opcion + '|' + data.tiempo + '|', callback);
		}
		
		public function buscaTorneosTodos(data:TorneoEvent, callback:Function):void{
			connNode.envia('TT|' + com.adobe.serialization.json.JSON.encode(data.torneoVO) + '|', callback);
		}
		
		public function inscripcionTorneo(data:TorneoEvent, callback:Function):void{
			connNode.envia('IT|' + com.adobe.serialization.json.JSON.encode(data.torneoVO) + '|', callback);
		}
		
		public function buscaMercadosTodos(data:MercadoEvent, callback:Function):void{
			connNode.envia('TM|' + com.adobe.serialization.json.JSON.encode(data.mercadoVO) + '|', callback);
		}

		public function get callbackRecep():Function
		{
			return _callbackRecep;
		}

		public function set callbackRecep(value:Function):void
		{
			_callbackRecep = value;
			this.connNode.callbackRecep = value;
		}
		
		
	}
}