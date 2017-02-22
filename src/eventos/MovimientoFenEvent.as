package eventos
{
	import flash.events.Event;
	
	import vo.MovimientoVO;
	
	public class MovimientoFenEvent extends Event
	{
		public static const NUEVO_FEN:String = 'nuevoFenEvent';
		public static const FIN_FEN:String = 'finFenEvent';
		public static const RESULTADO_FEN:String = 'resultadoFenEvent';
		public var movimiento:MovimientoVO;
		
		public const clase:String = 'MovimientoFenEvent';
		
		public function MovimientoFenEvent(type:String, _movimiento:MovimientoVO)
		{
			super(type);
			this.movimiento = _movimiento;
		}
	}
}