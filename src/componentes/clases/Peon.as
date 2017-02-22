package componentes.clases
{
	import componentes.graficos.Cuadro;
	import componentes.graficos.PopupPromocion;
	import componentes.graficos.Tablero;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.TileGroup;
	
	public class Peon extends Pieza
	{
		[Embed(source="assets/PeonBlanco1.png")]
		public var Blanco:Class;
		[Embed(source="assets/PeonNegro1.png")]
		public var Negro:Class;
		
		public var alPasoDer:Boolean = false;
		public var alPasoIzq:Boolean = false;
		public var habAlPaso:Boolean = false;
		
		public var arrPosiblesMovPeon:Array;
		public var mov:ArrayCollection = new ArrayCollection();
		public function Peon()
		{
			idFen = 'p';
			mov.addEventListener(CollectionEvent.COLLECTION_CHANGE, fnPeonMovido);
		}
		
		public function fnPeonMovido(event:CollectionEvent):void{
			/*var modelApp:Modelo = Modelo.getInstance();
			if(event.items[0]['idAnt'].charAt(0) != event.items[0]['idPos'].charAt(0) && Cuadro(modelApp.tgTablero.getElementAt(modelApp.tablero.tableroLogico[event.items[0]['idPos'].charAt(0) + event.items[0]['idAnt'].charAt(1)])).pieza is Peon){
				if((modelApp.partida.colorUsuario == 'B' && event.items[0]['idPos'].charAt(1) == '6') || (modelApp.partida.colorUsuario == 'N' && event.items[0]['idPos'].charAt(1) == '3')){
					Cuadro(modelApp.tgTablero.getElementAt(modelApp.tablero.tableroLogico[event.items[0]['idPos'].charAt(0) + event.items[0]['idAnt'].charAt(1)])).pieza = null;
					Cuadro(modelApp.tgTablero.getElementAt(modelApp.tablero.tableroLogico[event.items[0]['idPos'].charAt(0) + event.items[0]['idAnt'].charAt(1)])).currentState = 'vacio';
				}	
			} else {
				if(event.items[0]['idPos'].charAt(1) == '8' || event.items[0]['idPos'].charAt(1) == '1'){
					var popPromo:PopupPromocion = new PopupPromocion();
					popPromo.width = modelApp.tablero.parentApplication.width;
					popPromo.height = modelApp.tablero.parentApplication.height;
					PopUpManager.addPopUp(popPromo, modelApp.tablero, true);
					PopUpManager.centerPopUp(popPromo);
					popPromo.fnPos = modelApp.tablero.fnPromocion;
					
					popPromo.movimiento = movimiento;
					popPromo.cuadroId = event.items[0]['idPos'];
				}
			}
			*/
			
		}
		
		override public function posiblesMov(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			var modelApp:Modelo = Modelo.getInstance();
			var arrPosiblesMov:Array = [];
			arrPosiblesMovPeon = [];
			var indiceLetra:int;
			var indiceNumero:int;
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			
			if(color == 'B'){
				if(
					pos.charAt(1) == '2' &&
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + (arrNumeros[indiceNumero] + 1)])).pieza == null) &&
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + (arrNumeros[indiceNumero] + 2)])).pieza == null)
				){
					arrPosiblesMov.push(pos.charAt(0) + '4');
				}
				if(
					int(pos.charAt(1)) < 8 &&
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + (arrNumeros[indiceNumero] + 1)])).pieza == null)
				){
					arrPosiblesMov.push(pos.charAt(0) + (int(pos.charAt(1)) + 1));
				}
				
				
				
				indiceLetra--;
				
				
				
				indiceNumero++;
				
				if(indiceLetra >= 0 && indiceNumero >= 0){
					if((String(modelApp.fen.split(' ')[3]) == String(arrLetras[indiceLetra] + arrNumeros[indiceNumero]))
						|| (Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
							&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))
					){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
					}
				}
				
				
				indiceLetra += 2;
				
				
				if(indiceLetra < 8 && indiceNumero < 8){
					if((String(modelApp.fen.split(' ')[3]) == String(arrLetras[indiceLetra] + arrNumeros[indiceNumero]))
						|| (Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
							&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))
					){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
					}
				}
			} else {
				if(
					pos.charAt(1) == '7' &&
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + (arrNumeros[indiceNumero] - 1)])).pieza == null) &&
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + (arrNumeros[indiceNumero] - 2)])).pieza == null)
				){
					arrPosiblesMov.push(pos.charAt(0) + '5');
				}
				if(
					int(pos.charAt(1)) > 0 &&
					(Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + (arrNumeros[indiceNumero] - 1)])).pieza == null)
				){
					arrPosiblesMov.push(pos.charAt(0) + (int(pos.charAt(1)) - 1));
				}
				
				
				indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
				indiceLetra--;
				
				
				indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
				indiceNumero--;
				
				if(indiceLetra >= 0 && indiceNumero >= 0){
					if((String(modelApp.fen.split(' ')[3]) == String(arrLetras[indiceLetra] + arrNumeros[indiceNumero]))
						|| (Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
							&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))
					){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
					}
				}
					
					
					
					
					
					
				
				
				
				indiceLetra += 2;
				
				
				if(indiceLetra < 8 && indiceNumero < 8){
					if((String(modelApp.fen.split(' ')[3]) == String(arrLetras[indiceLetra] + arrNumeros[indiceNumero]))
						|| (Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza != null
							&& Cuadro(tgTablero.getElementAt(tablero.tableroLogico[arrLetras[indiceLetra] + arrNumeros[indiceNumero]])).pieza['color'] != (color == 'B' ? 'blancas' : 'negras'))
					){
						arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
					}
				}
			}
			
			
			return arrPosiblesMov;
		}
		
		public function amenaza(pos:String, tablero:Tablero, color:String):Array{
			var arrPosiblesMov:Array = [];
			var indiceLetra:int;
			var indiceNumero:int;
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			
			if(color == 'B'){
				
				indiceLetra--;			
				indiceNumero++;
				
				if(indiceLetra >= 0 && indiceNumero >= 0){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				}
				
				
				indiceLetra += 2;
				
				
				if(indiceLetra < 8 && indiceNumero < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				}	
			} else {
				
				
				
				indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
				indiceLetra--;
				
				
				indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
				indiceNumero--;
				
				if(indiceLetra >= 0 && indiceNumero >= 0){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				}
				
				
				indiceLetra += 2;
				
				
				if(indiceLetra < 8 && indiceNumero < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				}
			}
			
			
			return arrPosiblesMov;
		}
		
		override public function posiblesMovExt(pos:String, tablero:Tablero, color:String, tgTablero:TileGroup):Array{
			
			var arrPosiblesMov:Array = [];
			arrPosiblesMovPeon = [];
			var indiceLetra:int;
			var indiceNumero:int;
			indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
			indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
			
			if(color == 'B'){
				
				
				
				
				
				indiceLetra--;
				
				
				
				indiceNumero++;
				
				if(indiceLetra >= 0 && indiceNumero >= 0){ 
					
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				}
				
				
				indiceLetra += 2;
				
				
				if(indiceLetra < 8 && indiceNumero < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
					arrPosiblesMovPeon.push(arrLetras[indiceLetra]);
				}	
			} else {
			
				
				indiceLetra = this.arrLetras.indexOf(pos.charAt(0));
				indiceLetra--;
				
				
				indiceNumero = this.arrNumeros.indexOf(int(pos.charAt(1)));
				indiceNumero--;
				
				if(indiceLetra >= 0 && indiceNumero >= 0){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				}
				
				
				indiceLetra += 2;
				
				
				if(indiceLetra < 8 && indiceNumero < 8){
					arrPosiblesMov.push(arrLetras[indiceLetra] + arrNumeros[indiceNumero]);
				}
			}
			
			
			return arrPosiblesMov;
		}
		
	}
}