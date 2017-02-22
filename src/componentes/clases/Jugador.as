package componentes.clases
{
	import vo.JugadorVO;
	import vo.SesionVO;

	[Bindable]
	public class Jugador
	{
		public var colorPiezas:String = 'blancas';
		public var sesion:SesionVO = new SesionVO();
		public var jugadorVO:JugadorVO = new JugadorVO();
		
		public function Jugador()
		{
		}
	}
}