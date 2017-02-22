package componentes.clases
{
	import componentes.graficos.Tablero;
	
	import spark.components.TileGroup;
	
	public interface IPieza
	{
		
		function posiblesMov(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array;		
		function posiblesMovExt(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array;
		function cargaColor(_color:String):void;
		function getColor():String;
		function fnIdFen():String;
		function fnCuadroIni():String;
	}
}