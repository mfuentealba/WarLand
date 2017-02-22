package eventos
{
	import flash.events.Event;
	
	public class MovimientoEvent extends Event
	{
		public static const EJECUTA_MOVIMIENTO:String = 'ejecutaMovimientoEvent';
		public var movimiento:String;
		public var idPartida:String;
		public var tiempo:String;
		public var idOponente:String;
		public var color:String;
		public var nroJugada:String;
		public var fen:String;
		
		public const clase:String = 'MovimientoEvent';
		
		public function MovimientoEvent(type:String, _movimiento:String, _idPartida:String, _tiempo:String, _idOponente:String, _color:String, _nroJugada:String, _fen:String)
		{
			super(type);
			this.movimiento = _movimiento;
			this.idPartida = _idPartida;
			this.tiempo = _tiempo;
			this.idOponente = _idOponente;
			this.color = _color;
			this.nroJugada = _nroJugada;
			this.fen = _fen;
		}
	}
}