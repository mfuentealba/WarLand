package componentes.clases
{
	import com.adobe.utils.StringUtil;
	
	import componentes.graficos.Cuadro;
	import componentes.graficos.Tablero;
	
	import spark.components.TileGroup;
	
	import vo.PiezaVO;
	
	public class Pieza implements IPieza
	{
		public var color:String;
		public var enabled:Boolean;
		protected var arrLetras:Array = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
		protected var arrNumeros:Array = [1, 2, 3, 4, 5, 6, 7, 8];
		public var enabledMov:Boolean = true;
		public var idFen:String;
		public var idCuadro:String;
		public var clavado:Boolean;
		public var cuadro:Cuadro;
		public var arrMovRestric:Array = [];
		
		public var piezaVO:PiezaVO = new PiezaVO();
		
		//public var fnSetColor:Function;
		
		public function Pieza()
		{
		}
		public function posiblesMov(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			return [];
		}
		
		public function posiblesMovExt(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			return [];
		}
		
		public function cargaColor(_color:String):void{
			this.color = _color;	
			/*if(fnSetColor != null){
				fnSetColor.call(this, _color);
			}*/
		}
		public function getColor():String{
			return this.color;
		}
		
		public function fnIdFen():String{
			return this.idFen;
		}
		
		public function fnCuadroIni():String{
			return this.piezaVO.idCuadroOrigen;
		}
	}
}