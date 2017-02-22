package componentes.clases
{
	import componentes.graficos.Cuadro;
	import componentes.graficos.Tablero;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	import spark.components.TileGroup;
	
	import vo.ReyesVO;

	public class Rey extends Pieza
	{
		[Embed(source="assets/ReyBlanco1.png")]
		public var Blanco:Class;
		[Embed(source="assets/ReyNegro1.png")]
		public var Negro:Class;
		
		public var enroque:Boolean = true;
		public var mov:ArrayCollection = new ArrayCollection();
		
		public function Rey()
		{
			idFen = 'k';
			
			
			mov.addEventListener(CollectionEvent.COLLECTION_CHANGE, fnReyMovido);
		}
		
		
		
		public function fnReyMovido(event:CollectionEvent):void{
			var modelApp:Modelo = Modelo.getInstance();
			mov.removeEventListener(CollectionEvent.COLLECTION_CHANGE, fnReyMovido);
			this.enroque = false;
			if(event.items[0]['color'] != 'b'){
				modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('q', '');
				modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('k', '');
			} else {
				modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('Q', '');
				modelApp.tablero.codigoEnroque = modelApp.tablero.codigoEnroque.replace('K', '');
			}
			
			if(modelApp.tablero.codigoEnroque.length == 0){
				modelApp.tablero.codigoEnroque = '-';
			}
			
			if(event.items[0]['color'] != 'w' && event.items[0]['idAnt'] == 'e1'){
				if(event.items[0]['idPos'] == 'g1'){
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['f1'])).pieza = Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['h1'])).pieza;
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['h1'])).currentState = 'vacio';
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['h1'])).pieza = null;
					
				}
				if(event.items[0]['idPos'] == 'c1'){
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['d1'])).pieza = Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['a1'])).pieza;
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['a1'])).currentState = 'vacio';
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['a1'])).pieza = null;
				}
			} else if(event.items[0]['color'] != 'b' && event.items[0]['idAnt'] == 'e8'){
				if(event.items[0]['idPos'] == 'g8'){
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['f8'])).pieza = Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['h8'])).pieza;
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['h8'])).currentState = 'vacio';
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['h8'])).pieza = null;
					
				}
				if(event.items[0]['idPos'] == 'c8'){
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['d8'])).pieza = Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['a8'])).pieza;
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['a8'])).currentState = 'vacio';
					Cuadro(modelApp.tablero.tgTablero.getElementAt(modelApp.tablero.tableroLogico['a8'])).pieza = null;
				}
			}	
			fnNuevaPosicion(event);
			mov.addEventListener(CollectionEvent.COLLECTION_CHANGE, fnNuevaPosicion);			
			
		}
		
		
		public function fnNuevaPosicion(event:CollectionEvent):void{
			var modelApp:Modelo = Modelo.getInstance();
			modelApp.tablero.reyes[color == 'blancas' ? 'w' : 'b'] = event.items[0]['idPos'];
		}
		
		
		override public function posiblesMov(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			
			if(indiceLetra >= 0 && indiceNumero >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}
						
				}				
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			
			if(indiceLetra < 8 && indiceNumero < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}	
				}
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			
			if(indiceLetra >= 0 && indiceNumero < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}	
				}
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			
			if(indiceLetra < 8 && indiceNumero >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}	
				}
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) - 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			
			if(indiceNumero >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}	
				}				
				
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1))) + 1;
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			
			if(indiceNumero < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}	
				}
				
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) - 1;
			
			if(indiceLetra >= 0){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}	
				}
				
				
			}
			
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0)) + 1;
			
			if(indiceLetra < 8){ 
				if((Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza == null) || 				
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
						&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))){
					if(tablero.tableroPosicionOp[arrLetras[indiceLetra] + arrNumeros[indiceNumero]].length == 0){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);	
					}	
				}
				
				
			}
			var modelApp:Modelo = Modelo.getInstance();
			if(color == 'B'){
				if(modelApp.tablero.codigoEnroque.indexOf('Q') > -1
					&& Cuadro(tgTablero.getElementAt(57)).pieza == null && Cuadro(tgTablero.getElementAt(58)).pieza == null && Cuadro(tgTablero.getElementAt(59)).pieza == null
					&& tablero.tableroPosicionOp['d1'].length == 0 && tablero.tableroPosicionOp['c1'].length == 0
					&& modelApp.partida.enJaque == false
				){
					arrPosiblesMov.push('c1');
				}
				if(modelApp.tablero.codigoEnroque.indexOf('K') > -1
					&& Cuadro(tgTablero.getElementAt(61)).pieza == null && Cuadro(tgTablero.getElementAt(62)).pieza == null 
					&& tablero.tableroPosicionOp['f1'].length == 0 && tablero.tableroPosicionOp['g1'].length == 0
					&& modelApp.partida.enJaque == false
				){
					arrPosiblesMov.push('g1');
				}
			} else {
				if(modelApp.tablero.codigoEnroque.indexOf('q') > -1
					&& Cuadro(tgTablero.getElementAt(1)).pieza == null && Cuadro(tgTablero.getElementAt(2)).pieza == null && Cuadro(tgTablero.getElementAt(3)).pieza == null
					&& tablero.tableroPosicionOp['d8'].length == 0 && tablero.tableroPosicionOp['c8'].length == 0
					&& modelApp.partida.enJaque == false
				){
					arrPosiblesMov.push('c8');
				}
				if(modelApp.tablero.codigoEnroque.indexOf('k') > -1
					&& Cuadro(tgTablero.getElementAt(5)).pieza == null && Cuadro(tgTablero.getElementAt(6)).pieza == null 
					&& tablero.tableroPosicionOp['f8'].length == 0 && tablero.tableroPosicionOp['g8'].length == 0
					&& modelApp.partida.enJaque == false
				){
					arrPosiblesMov.push('g8');
				}
			}
			
			
			
			
			return arrPosiblesMov;
		}
		
		override public function posiblesMovExt(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			return posiblesMov(pos, tablero, color, tgTablero);
		}
		
	}
}