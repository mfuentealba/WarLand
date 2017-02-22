package componentes.clases
{
	import componentes.graficos.Cuadro;
	import componentes.graficos.Tablero;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	import spark.components.TileGroup;

	public class Torre extends Pieza
	{
		[Embed(source="assets/torreBlanca1.png")]
		public var Blanco:Class;
		[Embed(source="assets/torreNegra1.png")]
		public var Negro:Class;
		public var enroque:Boolean = true;
		public var mov:ArrayCollection = new ArrayCollection();
		
		public function Torre()
		{
			idFen = 'r';
			mov.addEventListener(CollectionEvent.COLLECTION_CHANGE, fnTorreMovida);
		}
		
		public function fnTorreMovida(event:CollectionEvent):void{
			var modelApp:Modelo = Modelo.getInstance();
			mov.removeEventListener(CollectionEvent.COLLECTION_CHANGE, fnTorreMovida);
			this.enroque = false;
			if(event.items[0]['color'] != 'b'){
				if(event.items[0]['idAnt'] == 'a8'){
					modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('q', '');	
				} else if(event.items[0]['idAnt'] == 'h8'){
					modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('k', '');	
				}
				
				
			} else {
				if(event.items[0]['idAnt'] == 'a1'){
					modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('Q', '');	
				} else if(event.items[0]['idAnt'] == 'h1'){
					modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('K', '');	
				}
			}
			
			if(modelApp.tablero.codigoEnroque.length == 0){
				modelApp.tablero.codigoEnroque = '-'; 
			}			
		}
		
		override public function posiblesMov(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			
			while(indiceNumero >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}				
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				indiceNumero--;
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			
			while(indiceNumero < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				indiceNumero++;
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			
			while(indiceLetra >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				
				indiceLetra--;
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			
			while(indiceLetra < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
				}
				if(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null){
					break;
				}
				
				indiceLetra++;
			}
			
			return arrPosiblesMov;
		}
		
		override public function posiblesMovExt(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			var clavada:IPieza;
			var arrOpClavada:Array = [pos];
			while(indiceNumero >= 0){ 
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
				
			}
			if(clavada){
				if(clavada is Torre || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				
			}
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			arrOpClavada = [pos];
			while(indiceNumero < 8){ 
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
				indiceNumero++;
				
			}
			if(clavada){
				if(clavada is Torre || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				
			}
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			arrOpClavada = [pos];
			while(indiceLetra >= 0){ 
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
				indiceLetra--;
			}
			if(clavada){
				if(clavada is Torre || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				
			}
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			arrOpClavada = [pos];
			while(indiceLetra < 8){ 
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
				indiceLetra++;
			}
			if(clavada){
				if(clavada is Torre || clavada is Dama){
					clavada['arrMovRestric'] = arrOpClavada;	
				}
				
			}
			return arrPosiblesMov;
		}
	}
}