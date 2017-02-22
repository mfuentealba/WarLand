package componentes.clases
{
	import componentes.graficos.Cuadro;
	import componentes.graficos.Tablero;
	
	import spark.components.TileGroup;

	public class Caballo extends Pieza
	{
		[Embed(source="assets/CaballoBlanco1.png")]
		public var Blanco:Class;
		[Embed(source="assets/CaballoNegro1.png")]
		public var Negro:Class;
		
		
		public function Caballo()
		{
			idFen = 'n';
		}
		
		override public function posiblesMov(pos:String, tablero:Tablero, _color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			
			if(indiceLetra - 2 >= 0){
				if(indiceNumero + 1 < 8){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 2] + arrNumeros[indiceNumero + 1]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 2] + arrNumeros[indiceNumero + 1]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 2] + arrNumeros[indiceNumero + 1]])).pieza == null					
					){
						arrPosiblesMov.push(arrLetras[indiceLetra - 2] + '' + arrNumeros[indiceNumero + 1]);	
					}
					 
				}
				if(indiceNumero - 1 >= 0){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 2] + arrNumeros[indiceNumero - 1]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 2] + arrNumeros[indiceNumero - 1]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 2] + arrNumeros[indiceNumero - 1]])).pieza == null
					){
						arrPosiblesMov.push(arrLetras[indiceLetra - 2] + '' + arrNumeros[indiceNumero - 1]);	
					}
					
				}
			}
			
			if(indiceLetra + 2 < 8){
				if(indiceNumero + 1 < 8){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 2] + arrNumeros[indiceNumero + 1]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 2] + arrNumeros[indiceNumero + 1]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 2] + arrNumeros[indiceNumero + 1]])).pieza == null
					){
						arrPosiblesMov.push(arrLetras[indiceLetra + 2] + '' + arrNumeros[indiceNumero + 1]);
					}
					
				}
				if(indiceNumero - 1 >= 0){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 2] + arrNumeros[indiceNumero - 1]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 2] + arrNumeros[indiceNumero - 1]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 2] + arrNumeros[indiceNumero - 1]])).pieza == null
					){
						arrPosiblesMov.push(arrLetras[indiceLetra + 2] + '' + arrNumeros[indiceNumero - 1]);
					}
					
				}
			}
			
			if(indiceNumero - 2 >= 0){
				if(indiceLetra + 1 < 8){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 1] + arrNumeros[indiceNumero - 2]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 1] + arrNumeros[indiceNumero - 2]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 1] + arrNumeros[indiceNumero - 2]])).pieza == null
					){
						arrPosiblesMov.push(arrLetras[indiceLetra + 1] + '' + arrNumeros[indiceNumero - 2]);
					}
					
				}
				if(indiceLetra - 1 >= 0){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 1] + arrNumeros[indiceNumero - 2]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 1] + arrNumeros[indiceNumero - 2]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 1] + arrNumeros[indiceNumero - 2]])).pieza == null
					){
						arrPosiblesMov.push(arrLetras[indiceLetra - 1] + '' + arrNumeros[indiceNumero - 2]);		
					}
					
				}
			}
			
			if(indiceNumero + 2 < 8){
				if(indiceLetra + 1 < 8){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 1] + arrNumeros[indiceNumero + 2]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 1] + arrNumeros[indiceNumero + 2]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra + 1] + arrNumeros[indiceNumero + 2]])).pieza == null
					){
						arrPosiblesMov.push(arrLetras[indiceLetra + 1] + '' + arrNumeros[indiceNumero + 2]);
					}
					
				}
				if(indiceLetra - 1 >= 0){
					if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 1] + arrNumeros[indiceNumero + 2]])).pieza != null &&
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 1] + arrNumeros[indiceNumero + 2]])).pieza['color'] != color) ||
						Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra - 1] + arrNumeros[indiceNumero + 2]])).pieza == null
					){
						arrPosiblesMov.push(arrLetras[indiceLetra - 1] + '' + arrNumeros[indiceNumero + 2]);	
					}
					
				}
			}
			
			return arrPosiblesMov;
		}
		
		override public function posiblesMovExt(pos:String, tablero:Tablero, _color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			
			if(indiceLetra - 2 >= 0){
				if(indiceNumero + 1 < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra - 2] + '' + arrNumeros[indiceNumero + 1]);
					
				}
				if(indiceNumero - 1 >= 0){
					arrPosiblesMov.push(arrLetras[indiceLetra - 2] + '' + arrNumeros[indiceNumero - 1]);
					
				}
			}
			
			if(indiceLetra + 2 < 8){
				if(indiceNumero + 1 < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra + 2] + '' + arrNumeros[indiceNumero + 1]);
					
				}
				if(indiceNumero - 1 >= 0){
					arrPosiblesMov.push(arrLetras[indiceLetra + 2] + '' + arrNumeros[indiceNumero - 1]);
					
				}
			}
			
			if(indiceNumero - 2 >= 0){
				if(indiceLetra + 1 < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra + 1] + '' + arrNumeros[indiceNumero - 2]);
					
				}
				if(indiceLetra - 1 >= 0){
					
					arrPosiblesMov.push(arrLetras[indiceLetra - 1] + '' + arrNumeros[indiceNumero - 2]);
				}
			}
			
			if(indiceNumero + 2 < 8){
				if(indiceLetra + 1 < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra + 1] + '' + arrNumeros[indiceNumero + 2]);
					
				}
				if(indiceLetra - 1 >= 0){
					arrPosiblesMov.push(arrLetras[indiceLetra - 1] + '' + arrNumeros[indiceNumero + 2]);
					
				}
			}
			
			return arrPosiblesMov;
		}
		
		
		
	}
}