package vo
{
	[Bindable]
	public dynamic class PartidaVO
	{
		public var id:Number;
		public var idPlayer1:Number;
		public var idPlayer2:Number;
		public var color_p1:String;
		public var estado:String;
		public var resultado:String;
		
		/*******************************************/
		public var Player1:String;
		public var Player2:String;
		public var rankingPlayer1:Number;
		public var rankingPlayer2:Number;
		public var apuesta:String;
		public var turnoJuego:Number;
		public var minELO:String;
		public var maxELO:String;
		public var rangoELO:String;
		public var icono:String;
		public var puntosJ1:String;
		public var puntosJ2:String;
		public var tipo:String;
		public var ganancia:String;
		public var gananciaP1:String;
		public var gananciaP2:String;
		public var qdp:Boolean;
		
		/*******************************************/
		
		public var detalle_fin:String;
		public var p1_conn:Boolean;
		public var p2_conn:Boolean;
		public var duracion:String;
		public var colorUsuario:String;
		public var turno:Boolean;
		public var arrMovimientos:Array = [];
		public var nuevaMovida:int;
		public var nroJugada:int = 1;
		public var idOponente:String;
		public var tiempoOponente:String;
		public var posReyPropio:String;
		public var posReyOponente:String;
		public var enJaque:Boolean = false;
		public var arrPiezaJaque:Array = [];
		
		public function PartidaVO()
		{
		}
	}
}