package eventos
{
	import flash.events.Event;
	
	import vo.JugadorVO;
	
	public class JugadorEvent extends Event
	{
		public static const CREAR_CUENTA:String = 'crearCuentaEvent';
		
		public var jugador:JugadorVO;
		public var pass:String;
		public var callback:Function;
		public const clase:String = 'JugadorEvent';
		
		public function JugadorEvent(type:String, _jugador:JugadorVO)
		{
			super(type);
			this.jugador = _jugador;
		}
	}
}