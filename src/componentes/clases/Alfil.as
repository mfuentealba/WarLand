package componentes.clases
{
	import componentes.graficos.Cuadro;
	import componentes.graficos.Tablero;
	
	import spark.components.TileGroup;

	public class Alfil extends Pieza
	{
		[Embed(source="assets/AlfilBlanco1.png")]
		public var Blanco:Class;
		[Embed(source="assets/AlfilNegro1.png")]
		public var Negro:Class;
		
		
		public function Alfil()
		{
			idFen = 'b';
		}
		
		override public function posiblesMov(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			
			while(indiceLetra >= 0 && indiceNumero >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}				
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				indiceNumero--;
				indiceLetra--;
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			
			while(indiceLetra < 8 && indiceNumero < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				indiceNumero++;
				indiceLetra++;
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			
			while(indiceLetra >= 0 && indiceNumero < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				indiceNumero++;
				indiceLetra--;
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			
			while(indiceLetra < 8 && indiceNumero >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				indiceNumero--;
				indiceLetra++;
			}
			
			return arrPosiblesMov;
		}
		
		override public function posiblesMovExt(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			
			var arrOpClavada:Array = [pos];
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			var clavada:IPieza;
			while(indiceLetra >= 0 && indiceNumero >= 0){ 
				arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				arrOpClavada.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza.getColor() == this.getColor()){
						break;
					} else {
						if(clavada == null){
							clavada = Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza;
							arrOpClavada.pop();
						} else {
							if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza is Rey){
								clavada['clavado'] = true;
								arrOpClavada.pop();
								break;
							} else {
								clavada = null;	
							}
							
						}
							
					}
				}
				indiceNumero--;
				indiceLetra--;
			}
			
			if(clavada){
				if(clavada is Alfil || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				 
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			arrOpClavada = [pos];
			while(indiceLetra < 8 && indiceNumero < 8){ 
				arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza.getColor() == this.getColor()){
						break;
					} else {
						if(clavada == null){
							clavada = Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza;	
						} else {
							if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza is Rey){
								clavada['clavado'] = true;
								arrOpClavada.pop();
								break;
							} else {
								clavada = null;	
							}
							
						}
						
					}
				}
				indiceNumero++;
				indiceLetra++;
			}
			
			if(clavada){
				if(clavada is Alfil || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			arrOpClavada = [pos];
			while(indiceLetra >= 0 && indiceNumero < 8){ 
				arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza.getColor() == this.getColor()){
						break;
					} else {
						if(clavada == null){
							clavada = Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza;	
						} else {
							if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza is Rey){
								clavada['clavado'] = true;
								arrOpClavada.pop();
								break;
							} else {
								clavada = null;	
							}
							
						}
						
					}
				}
				indiceNumero++;
				indiceLetra--;
			}
			
			if(clavada){
				if(clavada is Alfil || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			arrOpClavada = [pos];
			while(indiceLetra < 8 && indiceNumero >= 0){ 
				arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza.getColor() == this.getColor()){
						break;
					} else {
						if(clavada == null){
							clavada = Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza;	
						} else {
							if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza is Rey){
								clavada['clavado'] = true;
								arrOpClavada.pop();
								break;
							} else {
								clavada = null;	
							}
							
						}
						
					}
				}
				indiceNumero--;
				indiceLetra++;
			}
			if(clavada){
				if(clavada is Alfil || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				
			}
			return arrPosiblesMov;
		}
		
	}
}