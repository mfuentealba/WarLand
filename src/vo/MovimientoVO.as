package vo
{
	import componentes.clases.IPieza;

	public class MovimientoVO
	{
		public var mov:String;
		public var piezaMovida:IPieza;
		public var piezaCapturada:IPieza;
		public var piezaMovidaVO:PiezaVO = new PiezaVO();
		public var piezaCapturadaVO:PiezaVO = new PiezaVO();
		public var fenNuevo:String;
		public var arrFen:Array = [];
		public var resultado:String;
		public var codigoEnroque:String;
		public var codigoAlpaso:String;
		public var indexPosibleJugada:int = 0;
		public var indexCuadrado:int = 0;
		
		public function MovimientoVO()
		{
		}
	}
}