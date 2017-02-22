package eventos
{
	import flash.events.Event;
	
	import vo.PartidaVO;
	import vo.TorneoVO;
	
	public class TorneoEvent extends Event
	{
		public static const CREA_TORNEO:String = 'creaPartidaEvent';
		public static const BUSCA_TORNEOS_TODOS:String = 'buscaTorneosTodosEvent';
		public static const INSCRIPCION_TORNEO:String = 'InscripcionTorneoEvent';
		/*public static const BUSCA_PARTIDAS_TODAS:String = 'buscaPartidaTodasEvent';
		public static const GENERA_PARTIDA:String = 'generaPartidaTodasEvent';*/
		
		
		public const clase:String = 'TorneoEvent';
		public var torneoVO:TorneoVO = new TorneoVO();
		
		public function TorneoEvent(type:String, _torneoVO:TorneoVO = null)
		{
			super(type);
			this.torneoVO = _torneoVO;
		}
	}
}