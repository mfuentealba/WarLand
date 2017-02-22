package eventos
{
	import flash.events.Event;
	
	import vo.MercadoVO;
	
	public class MercadoEvent extends Event
	{
		public static const CREA_TRANSACCION:String = 'creaTransaccionEvent';
		public static const BUSCA_TRANSACCIONES_TODOS:String = 'buscaTransaccionesTodosEvent';
		/*public static const BUSCA_PARTIDAS_TODAS:String = 'buscaPartidaTodasEvent';
		public static const GENERA_PARTIDA:String = 'generaPartidaTodasEvent';*/
		
		
		public const clase:String = 'MercadoEvent';
		public var mercadoVO:MercadoVO = new MercadoVO();
		
		public function MercadoEvent(type:String, _mercadoVO:MercadoVO = null)
		{
			super(type);
			this.mercadoVO = _mercadoVO;
		}
	}
}