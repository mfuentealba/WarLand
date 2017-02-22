package eventos
{
	import flash.events.Event;
	
	import vo.PartidaVO;
	
	public class PartidaEvent extends Event
	{
		public static const CREA_PARTIDA:String = 'creaPartidaEvent';
		public static const BUSCA_PARTIDA:String = 'buscaPartidaEvent';
		public static const BUSCA_PARTIDAS_TODAS:String = 'buscaPartidaTodasEvent';
		public static const GENERA_PARTIDA:String = 'generaPartidaTodasEvent';
		public static const FIN_PARTIDA:String = 'finPartidaTodasEvent';
		public static const FIN_PARTIDA2:String = 'finPartida2Event';
		public static const OFERTA_TABLAS:String = 'ofertaTablasEvent';
		public static const SOL_TAB_POS:String = 'solicitaTableroPosicionEvent';
		public static const RES_TAB_POS:String = 'respuestaTableroPosicionEvent';
		public static const RECONEXION:String = 'reconexionPosicionEvent';
		public static const CONS_PART:String = 'consultaPartidaPendienteEvent';
		public static const PERFIL_OPONENTE:String = 'consultaPerfilOponenteEvent';
		
		public var opcion:String;
		public var idJugador:Number;
		public var tiempo:String;
		
		public const clase:String = 'PartidaEvent';
		public var partida:PartidaVO;
		public var extra:*;
		
		public function PartidaEvent(type:String, _id:Number, _opt:String, _tiempo:String, _partida:PartidaVO = null, _extra:* = null)
		{
			super(type);
			this.idJugador = _id;
			this.opcion = _opt;
			this.tiempo = _tiempo;
			this.partida = _partida;
			this.extra = _extra;
		}
	}
}