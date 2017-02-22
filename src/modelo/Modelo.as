package modelo
{
	import componentes.clases.ConexionSocket;
	import componentes.clases.Jugador;
	import componentes.graficos.BloqueoEspera;
	import componentes.graficos.PopupMensaje;
	import componentes.graficos.PopupPerfilOponente;
	import componentes.graficos.PopupReloj;
	import componentes.graficos.Reloj;
	import componentes.graficos.Tablero;
	
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Application;
	import spark.components.PopUpAnchor;
	
	import vo.JugadorVO;
	import vo.PartidaVO;
	import vo.SesionVO;
	import vo.TorneoVO;
	

	[Bindable]
	public class Modelo
	{
		private static var modelLocator:Modelo;
		public var block:BloqueoEspera = new BloqueoEspera();
		public var bloqueo:Boolean = false;
		public var timer:Timer = new Timer(10000, 0); 
		public var activeTimer:Boolean = false;
		public var jugador:Jugador = new Jugador();
		public var jugadorOponente:JugadorVO;
		public var sesion:SesionVO;
		public var partida:PartidaVO;
		public var torneoVO:TorneoVO;
		public var arrTiempo:ArrayCollection = new ArrayCollection([{id: 1, duracion: '1:00'}, {id: 2, duracion: '3:00'}, {id: 3, duracion: '5:00'}, {id: 4, duracion: '10:00'}, {id: 5, duracion: '20:00'}]);
		public var arrPiezas:ArrayCollection = new ArrayCollection([{id: 1, duracion: 'Dama'}, {id: 2, duracion: 'Torre'}, {id: 3, duracion: 'Alfil'}, {id: 4, duracion: 'Caballo'}, {id: 5, duracion: '20:00'}]);
		public var arrSistema:ArrayCollection = new ArrayCollection([{id: 1, duracion: 'Todos contra todos'}, {id: 2, duracion: 'Eliminación directa'}]);//new ArrayCollection([{id: 1, sistema: 'Todos contra todos'}, {id: 2, sistema: 'Eliminación directa'}]);
		public var arrMoneda:ArrayCollection = new ArrayCollection([{id: 1, duracion: 'Normal'}, {id: 2, duracion: 'Roja'}, {id: 2, duracion: 'Verde'}, {id: 2, duracion: 'Azul'}]);//new ArrayCollection([{id: 1, sistema: 'Todos contra todos'}, {id: 2, sistema: 'Eliminación directa'}]);
		public var objJugadores:Object = {1: new ArrayCollection([{id: 1, duracion: 4}, {id: 2, duracion: 6}]), 2: new ArrayCollection([{id: 1, duracion: 4}, {id: 2, duracion: 10}])};
		public var objRondas:Object = {1: new ArrayCollection([{id: 1, duracion: 4}, {id: 2, duracion: 6}, {id: 2, duracion: 8}]), 2: new ArrayCollection([{id: 1, duracion: 1}, {id: 2, duracion: 2}, {id: 2, duracion: 3}, {id: 2, duracion: 4}])};
		public var flagInicioPartida:Boolean = false;
		public var arrPartidas:ArrayCollection = new ArrayCollection();
		public var arrTorneos:ArrayCollection = new ArrayCollection();
		public var arrMercados:ArrayCollection = new ArrayCollection();
		public var popMsg:PopupMensaje = new PopupMensaje();
		public var auxPopMsg:int;
		public var sistema:WarLand;
		public var finPartida:int;
		public var fnRendir:Function;
		public var fnTriunfo:Function;
		public var fnTablas:Function;
		public var fnDesconexion:Function;
		public var tablero:Tablero;
		public var chatPublico:String = '';
		public var conexionChat:ConexionSocket = new ConexionSocket();
		public var fotoPerfil:String;
		public var fnPerfil:Function;
		public var msjNuevo:Boolean = false;
		public var msjTablas:int;
		public var chatActivo:Boolean = false;
		public var relojDesconexion:String = '9:00';
		public var popRelojDesconexion:PopupReloj;
		public var peticionFen:Boolean = false;
		public var tiempoOponente:String;
		public var tiempoPropio:String;
		public var fen:String = '';
		public var popPerfilOponente:PopupPerfilOponente;
		public var apli:WarLand;
		public var arrPiezasOponente:ArrayCollection;
		public var arrPiezasPropias:ArrayCollection;
		
		public var desconexion:Boolean = false;
		public var reconFen:String = '';
		
		public var conexion:ConexionSocket = new ConexionSocket();
		public var str:String = '<';
		
		
		public var resultadoPartida:String;
		public var partidoActivo:Boolean;
		
		
		public var tamAlt:Number;
		public var tamAnc:Number;
		public var tamLetraNormal:Number;
		public var tamBtn:Number;
		
/*		arrTipoIngreso.addItem({id: 1, nombre: 'Efectivo'}); 
		arrTipoIngreso.addItem({id: 2, nombre: 'Cheque al Día'}); 
		arrTipoIngreso.addItem({id: 3, nombre: 'Cheque a Fecha'}); 
		arrTipoIngreso.addItem({id: 4, nombre: 'Transferencia'});*/
		
		
		
		public static function getInstance():Modelo
		{
			if ( modelLocator == null ){
				modelLocator = new Modelo();
			}
				
			return modelLocator;
		}
		
		public function Modelo()
		{
			if(modelLocator){
				throw new Error("Singleton... use getInstance()");
			} 
			modelLocator = this;
		}
		
		
	}
}