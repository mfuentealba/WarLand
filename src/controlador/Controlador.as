package controlador
{
	
	import com.adobe.serialization.json.JSON;
	
	import componentes.clases.Jugador;
	import componentes.graficos.Alert;
	import componentes.graficos.PopupMensaje;
	
	import eventos.DataTranferidaEvent;
	import eventos.JugadorEvent;
	import eventos.MensajeEvent;
	import eventos.MercadoEvent;
	import eventos.MovimientoEvent;
	import eventos.MovimientoFenEvent;
	import eventos.PartidaEvent;
	import eventos.SesionEvent;
	import eventos.TorneoEvent;
	
	import flash.data.SQLResult;
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import modelo.Modelo;
	
	import mx.charts.chartClasses.DataTransform;
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	import servicios.DelegadoChat;
	import servicios.DelegadoNode;
	import servicios.DelegadoSQLite;
	
	import spark.components.Application;
	import spark.components.Button;
	
	import vo.JugadorVO;
	import vo.MercadoVO;
	import vo.PartidaVO;
	import vo.SesionVO;
	import vo.TorneoVO;
	
	public class Controlador extends EventDispatcher
	{
		private static var controladorGeneral:Controlador;
		private var delegadoSQLITE:DelegadoSQLite = DelegadoSQLite.getInstance();
		[Bindable] private var modelApp:Modelo = Modelo.getInstance();
		[Bindable] private var dlNode:DelegadoNode = DelegadoNode.getInstance();
		[Bindable] private var dlChat:DelegadoChat = DelegadoChat.getInstance();
		
		
		
		public static function getInstance():Controlador
		{
			if ( controladorGeneral == null ){
				controladorGeneral = new Controlador();
				
			}
			
			return controladorGeneral;
		}
		
		
		public function Controlador(target:IEventDispatcher=null)
		{
			if(controladorGeneral){
				throw new Error("Singleton... use getInstance()");
			} 
			controladorGeneral = this;
			inic();
		}
		
		
		
		public function inic():void{
			addEventListener(SesionEvent.INICIA_SESION, despachar);
			addEventListener(PartidaEvent.CREA_PARTIDA, despachar);
			addEventListener(PartidaEvent.BUSCA_PARTIDA, despachar);
			addEventListener(PartidaEvent.GENERA_PARTIDA, despachar);
			addEventListener(MovimientoEvent.EJECUTA_MOVIMIENTO, despachar);
			addEventListener(PartidaEvent.BUSCA_PARTIDAS_TODAS, despachar);
			addEventListener(TorneoEvent.CREA_TORNEO, despachar);
			addEventListener(TorneoEvent.BUSCA_TORNEOS_TODOS, despachar);
			addEventListener(TorneoEvent.INSCRIPCION_TORNEO, despachar);
			addEventListener(MercadoEvent.CREA_TRANSACCION, despachar);
			addEventListener(MercadoEvent.BUSCA_TRANSACCIONES_TODOS, despachar);	
			addEventListener(PartidaEvent.FIN_PARTIDA, despachar);
			addEventListener(PartidaEvent.FIN_PARTIDA2, despachar);
			addEventListener(PartidaEvent.OFERTA_TABLAS, despachar);
			addEventListener(PartidaEvent.SOL_TAB_POS, despachar);
			addEventListener(PartidaEvent.RES_TAB_POS, despachar);
			addEventListener(PartidaEvent.RECONEXION, despachar);
			addEventListener(PartidaEvent.CONS_PART, despachar);
			addEventListener(PartidaEvent.PERFIL_OPONENTE, despachar);
			addEventListener(MensajeEvent.MENSAJE_PUBLICO, despachar);
			addEventListener(MensajeEvent.MENSAJE_PRIVADO, despachar);
			addEventListener(MensajeEvent.ID_CHAT, despachar);
			addEventListener(MovimientoFenEvent.NUEVO_FEN, despachar);
			addEventListener(MovimientoFenEvent.FIN_FEN, despachar);
			addEventListener(MovimientoFenEvent.RESULTADO_FEN, despachar);
			addEventListener(JugadorEvent.CREAR_CUENTA, despachar);
			
			addEventListener(DataTranferidaEvent.REGISTRA, despachar);
			
			dlNode.callbackRecep = callbackRecep;
			dlChat.callbackRecep = callbackChat;
		}
		
		
		private function despachar(event:*):void{
			switch(event.clase){
				case 'SesionEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case SesionEvent.INICIA_SESION:
							DelegadoNode.getInstance().consultaSesion(event, sesionResponse);
							break;
						//DelegadoSQLite.getInstance().fnDelegado(fn del controller que actualiza vista, fn callback del evento para alguna otra actualizacion mas visual)
					}
					break;
				case 'PartidaEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case PartidaEvent.CREA_PARTIDA:
							DelegadoNode.getInstance().creaPartida(event, creacionResponse);
							break;
						case PartidaEvent.BUSCA_PARTIDA:
							DelegadoNode.getInstance().buscaPartida(event, busquedaResponse);
							break;
						case PartidaEvent.BUSCA_PARTIDAS_TODAS:
							DelegadoNode.getInstance().buscaPartidasTodas(event, busquedaAllResponse);
							break;
						case PartidaEvent.GENERA_PARTIDA:
							DelegadoNode.getInstance().generaPartida(event, busquedaResponse);
							break;
						case PartidaEvent.FIN_PARTIDA:
							DelegadoNode.getInstance().finPartida(event, busquedaResponse);
							break;
						case PartidaEvent.FIN_PARTIDA2:
							DelegadoNode.getInstance().finPartida2(event, busquedaResponse);
							break;
						case PartidaEvent.OFERTA_TABLAS:
							DelegadoNode.getInstance().ofertaTablas(event, busquedaResponse);
							break;
						case PartidaEvent.SOL_TAB_POS:
							DelegadoNode.getInstance().solTabPos(event, null);
							break;
						case PartidaEvent.RES_TAB_POS:
							DelegadoNode.getInstance().resTabPos(event, null);
							break;
						case PartidaEvent.RECONEXION:
							DelegadoNode.getInstance().reconexion(event, null);
							break;
						case PartidaEvent.CONS_PART:
							DelegadoNode.getInstance().consultaPartidaPendiente(event, null);
							break;
						case PartidaEvent.PERFIL_OPONENTE:
							DelegadoNode.getInstance().consultaPerfilOponente(event, perfilOponenteResponse);
							break;
					}
					break;
				case 'MovimientoEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case MovimientoEvent.EJECUTA_MOVIMIENTO:
							DelegadoNode.getInstance().ejecutaMovimiento(event,ejecutaMovimientoResponse);
							break;						
					}
					break;
				case 'TorneoEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case TorneoEvent.CREA_TORNEO:
							DelegadoNode.getInstance().creaTorneo(event, creacionTorneoResponse);
							break;	
						case TorneoEvent.BUSCA_TORNEOS_TODOS:
							DelegadoNode.getInstance().buscaTorneosTodos(event, busquedaTorneosAllResponse);
							break;
						case TorneoEvent.INSCRIPCION_TORNEO:
							DelegadoNode.getInstance().inscripcionTorneo(event, inscripcionTorneoResponse);
							break;
					}
					break;
				case 'MercadoEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case MercadoEvent.CREA_TRANSACCION:
							DelegadoNode.getInstance().creaMercado(event, creacionMercadoResponse);
							break;	
						case MercadoEvent.BUSCA_TRANSACCIONES_TODOS:
							DelegadoNode.getInstance().buscaMercadosTodos(event, busquedaMercadosAllResponse);
							break;
						
					}
					break;
				case 'MensajeEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case MensajeEvent.MENSAJE_PUBLICO:
							DelegadoChat.getInstance().chatPublico(event, null);
							break;
						case MensajeEvent.MENSAJE_PRIVADO:
							DelegadoChat.getInstance().chatPrivado(event, confirmaMensaje);
							break;	
						case MensajeEvent.ID_CHAT:
							DelegadoChat.getInstance().idUsuario(event, null);
							break;	
					}
					break;
				case 'DataTranferidaEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case DataTranferidaEvent.REGISTRA:
							delegadoSQLITE.newEvento(null, event);
							break;
						
					}
					break;
				case 'MovimientoFenEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case MovimientoFenEvent.NUEVO_FEN:
							DelegadoNode.getInstance().nuevoFen(event,null);
							break;
						case MovimientoFenEvent.FIN_FEN:
							DelegadoNode.getInstance().finFen(event,null);
							break;
						
						case MovimientoFenEvent.RESULTADO_FEN:
							DelegadoNode.getInstance().resultadoFen(event,null);
							break;
					}
					break;
				case 'JugadorEvent':
					switch(event.type){
						case JugadorEvent.CREAR_CUENTA:
							DelegadoNode.getInstance().crearCuenta(event,null);
							break;
					}
					
					break;
			}
		}
		
		
		
		/*******Respuestas base de datos********/
		
		
		private function getConfigResultHandler(event:SQLResult):void{
			/****Fn que se ejecuta en respuesta de actualización de la vista ej: en el delegadosqlite getConfigResultHandler.execute(-1, new flash.net.Responder(getEventosResultHandler, onDBError));*****/
		}
		
		/***************NODEJS**************************************/
		
		private function callbackRecep(result:DataEvent):void{
			var arrParam:Array = String(result.data).split('|');
			switch(arrParam[1]){
				case 'INI':
					if(arrParam[2] == 'OK'){
						//modelApp.partida.idPlayer2 = arrParam[3];
						//modelApp.partida.idOponente = arrParam[3];
						part = com.adobe.serialization.json.JSON.decode(arrParam[3]);
						
						for(var str:String in part){
							modelApp.partida[str] = modelApp.partida[str] != null || modelApp.partida[str] != '' || isNaN(modelApp.partida[str]) ? modelApp.partida[str] : part[str];
							
						}
						modelApp.partida.idPlayer2 = part['idPlayer2'];
						modelApp.partida.idOponente = part['idPlayer2'];
						modelApp.partida.Player2 = part['Player2'];
						modelApp.partida.puntosJ2 = part['puntosJ2'];
						modelApp.tiempoOponente = modelApp.partida.duracion;
						modelApp.tiempoPropio = modelApp.partida.duracion;
						modelApp.flagInicioPartida = false;
						modelApp.flagInicioPartida = true;
					}
					break;
				case 'MOV':
					if(arrParam[2] == 'OK'){
						modelApp.partida.arrMovimientos.push(arrParam[3]);
						modelApp.partida.tiempoOponente = arrParam[4];
						modelApp.partida.turno = true;
						modelApp.tablero.codigoSMovPeonCambio = arrParam[5];
						modelApp.tablero.codigoEnroque = arrParam[6];
						modelApp.fen = arrParam[7];
						modelApp.partida.nuevaMovida++;	
					}
					
					break;
				
				case 'MSG':
					if(arrParam[2] == 'OK'){
						modelApp.popMsg = new PopupMensaje()
						modelApp.popMsg.msg = arrParam[3]; 
						modelApp.auxPopMsg++;
					}
					
					break;
				case 'TP':
					var eve:PartidaEvent = new PartidaEvent(PartidaEvent.BUSCA_PARTIDAS_TODAS, modelApp.jugador.sesion.id, '', '');
					this.despachar(eve);
					break;
				case 'TT':
					var ev:TorneoEvent = new TorneoEvent(TorneoEvent.BUSCA_TORNEOS_TODOS);
					this.despachar(ev);
					break;
				case 'TM':
					var evM:MercadoEvent = new MercadoEvent(MercadoEvent.BUSCA_TRANSACCIONES_TODOS);
					this.despachar(evM);
					break;
				case 'FP':
					var part:Object = {};
					
					part = com.adobe.serialization.json.JSON.decode(arrParam[2]);
					modelApp.resultadoPartida = arrParam[3];
					modelApp.finPartida++;
					for(str in part){
						modelApp.jugador.jugadorVO[str] = part[str];
						
					}
					break;
				case 'AU':
					part = {};
					part = com.adobe.serialization.json.JSON.decode(arrParam[2]);
					
					for(str in part){
						modelApp.jugador.jugadorVO[str] = part[str];
						
					}
					break;
				case 'OFERTA_TABLAS':
					modelApp.msjTablas++;
					break;
				case 'ESPERA_CONEXION':
					modelApp.tablero.relojOponente.timer.stop();
					modelApp.tablero.relojUsuario.timer.stop();
					modelApp.desconexion = false;
					modelApp.desconexion = true;
					break;
				case 'PARTIDA_RECONEX':
					part = {};
					part = com.adobe.serialization.json.JSON.decode(arrParam[2]);
					modelApp.partida = new PartidaVO();
					for(str in part){
						modelApp.partida[str] = part[str];
						
					}
					modelApp.partida.idOponente = (modelApp.partida.idPlayer1 == modelApp.jugador.sesion.id ? modelApp.partida.idPlayer2 : modelApp.partida.idPlayer1) + '';
					modelApp.partida.colorUsuario = modelApp.partida.idPlayer1 == modelApp.jugador.sesion.id ? modelApp.partida.color_p1 : (modelApp.partida.color_p1 == 'N' ? 'B' : 'N')
					modelApp.peticionFen = true;
					evP = new PartidaEvent(PartidaEvent.SOL_TAB_POS, 0, '', '');
					Controlador.getInstance().dispatchEvent(evP);
					
					break;
				case 'SOL_TAB_POS':
					
					var evP:PartidaEvent = new PartidaEvent(PartidaEvent.RES_TAB_POS, 0, '', '');
					Controlador.getInstance().dispatchEvent(evP);
					break;
				case 'RES_TAB_POS':
					modelApp.reconFen = arrParam[2];
					modelApp.flagInicioPartida = false;
					modelApp.flagInicioPartida = true;
					modelApp.tiempoOponente = arrParam[3];
					modelApp.tiempoPropio = arrParam[4];
					modelApp.partida.enJaque = String(arrParam[5]).indexOf('+') == -1 ? false : true;
					break;
				case 'RECONEXION':
					if(modelApp.partida.turno){
						modelApp.tablero.relojUsuario.timer.start();
					} else {
						modelApp.tablero.relojOponente.timer.start();
					}
					PopUpManager.removePopUp(modelApp.popRelojDesconexion);
					break;
				case 'CUENTA_CREADA':
					modelApp.bloqueo = false;
					var pop:PopupMensaje = new PopupMensaje();
					pop.msg = 'Cuenta creada con éxito';
					pop.width = modelApp.apli.width;
					pop.height = modelApp.apli.height;
					PopUpManager.addPopUp(pop, modelApp.apli);
					PopUpManager.centerPopUp(pop);
					break;
			}
		}
		
		
		private function callbackChat(result:DataEvent):void{
			var arrParam:Array = String(result.data).split('|');
			switch(arrParam[1]){
				case 'MP':
					
					if(arrParam[2] == 'OK'){
						modelApp.chatPublico = arrParam[3] + '\n' + modelApp.chatPublico;
						
					}
					break;
				case 'MENSAJE_PRIVADO':
					
					if(arrParam[2] == 'OK'){
						modelApp.msjNuevo = true;
						modelApp.chatPublico = arrParam[3] + '\n' + modelApp.chatPublico;
						
					}
					break;
				
				case 'ID_CHAT':
					
					if(arrParam[2] == 'OK'){
						modelApp.chatActivo = true;
						
						
					}
					break;
				
			}
		}
		
		
		private function confirmaMensaje(aEvent : *):void{
			
		}
		
		
		private function sesionResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			/*modelApp.sesion = new SesionVO();
			modelApp.sesion.id = arrSesion[0];
			modelApp.sesion.user = arrSesion[1];*/
			modelApp.bloqueo = false;
			var part:Object = {};
			modelApp.jugador = new Jugador();
			part = com.adobe.serialization.json.JSON.decode(arrSesion[0]);
			for(var str:String in part){
				modelApp.jugador.jugadorVO[str] = part[str];
			}
			
			
			modelApp.jugador.sesion.id = int(modelApp.jugador.jugadorVO.id);
			modelApp.jugador.sesion.user =  modelApp.jugador.jugadorVO.user;
			
			modelApp.conexionChat.ini();
			
		}
		
		private function perfilOponenteResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			/*modelApp.sesion = new SesionVO();
			modelApp.sesion.id = arrSesion[0];
			modelApp.sesion.user = arrSesion[1];*/
			var part:Object = {};
			modelApp.jugadorOponente = new JugadorVO();
			part = com.adobe.serialization.json.JSON.decode(arrSesion[0]);
			for(var str:String in part){
				modelApp.jugadorOponente[str] = part[str];
			}
			
			
			
		}
		
		private function creacionResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			
			if(arrSesion[0] == 'OK'){
				modelApp.partida.id = arrSesion[1];	
				modelApp.partida.color_p1 = arrSesion[2];
				modelApp.partida.colorUsuario = arrSesion[2];
				modelApp.partida.turno = modelApp.partida.color_p1 == 'B' ? true : false;
				
			}
			
			
		}
		
		
		
		private function creacionTorneoResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			
			if(arrSesion[0] == 'OK'){
				modelApp.torneoVO.id = arrSesion[1];			
			}
			
		}
		
		
		private function creacionMercadoResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			
						
		}
		
		
		private function busquedaResponse(aEvent : DataEvent):void{
			var arrPartida:Array = String(aEvent.data).split('|');
			
			if(arrPartida[0] == 'OK'){
				//modelApp.partida = new PartidaVO();
				
				var part:Object = {};
				
				//modelApp.partida.idPlayer1 = arrPartida[1];
				modelApp.partida.id = arrPartida[2];	
				modelApp.partida.duracion = arrPartida[3];	
				modelApp.partida.color_p1 = arrPartida[4];
				modelApp.partida.idOponente = '' + modelApp.partida.idPlayer1;
				modelApp.partida.colorUsuario = modelApp.partida.color_p1 == 'B' ? 'N' : 'B';
				modelApp.tiempoOponente = modelApp.partida.duracion;
				modelApp.tiempoPropio = modelApp.partida.duracion;
				modelApp.flagInicioPartida = false;
				modelApp.flagInicioPartida = true;
				
				modelApp.partida.turno = modelApp.partida.colorUsuario == 'B' ? true : false;
			}
			
			
		}
		
		private function ejecutaMovimientoResponse(aEvent : DataEvent):void{
			var arrConfirmacion:Array = String(aEvent.data).split('|');
			
			if(arrConfirmacion[0] == 'OK'){
				modelApp.partida.turno = false;
			}
		}
		
		private function busquedaAllResponse(aEvent : DataEvent):void{
			var arrPartidas:Array = String(aEvent.data).split('|');
			modelApp.arrPartidas.source = null;
			if(arrPartidas[0] == 'OK'){
				
				for(var i:int = 1; i < arrPartidas.length - 1; i++){
					var part:Object = {};
					part = com.adobe.serialization.json.JSON.decode(arrPartidas[i]);
					var partidaVO:PartidaVO = new PartidaVO();
					for(var str:String in part){
						partidaVO[str] = part[str];
						
					}
					if(int(partidaVO.apuesta) == 0){
						partidaVO.icono = "assets/iconPart.jpeg";	
					} else {
						partidaVO.icono = "assets/images/hdpi/moneda/images.png";
					}
					partidaVO.rangoELO = 'Rango: ' + part.minELO + '-' + part.maxELO + '. Apuesta: ' + part.apuesta + '. Tiempo: ' + part.duracion;
					
					modelApp.arrPartidas.addItem(partidaVO);
					
					
					
					
				}
				
				
				
				
			}
			var evP:PartidaEvent = new PartidaEvent(PartidaEvent.CONS_PART, 0, '', '');
			Controlador.getInstance().dispatchEvent(evP);
		}
		
		
		private function busquedaTorneosAllResponse(aEvent : DataEvent):void{
			var arrTorneos:Array = String(aEvent.data).split('|');
			modelApp.arrTorneos.source = null;
			if(arrTorneos[0] == 'OK'){
				
				for(var i:int = 1; i < arrTorneos.length - 1; i++){
					var part:Object = {};
					part = com.adobe.serialization.json.JSON.decode(arrTorneos[i]);
					var torneoVO:TorneoVO = new TorneoVO();
					for(var str:String in part){
						torneoVO[str] = part[str];
					}
					modelApp.arrTorneos.addItem(torneoVO);
				}
				
				
				
				
			}
		}
		
		
		private function inscripcionTorneoResponse(aEvent : DataEvent):void{
			var arrTorneos:Array = String(aEvent.data).split('|');
			
		}
		
		
		private function busquedaMercadosAllResponse(aEvent : DataEvent):void{
			var arrMercados:Array = String(aEvent.data).split('|');
			modelApp.arrMercados.source = null;
			if(arrMercados[0] == 'OK'){
				
				for(var i:int = 1; i < arrMercados.length - 1; i++){
					var part:Object = {};
					part = com.adobe.serialization.json.JSON.decode(arrMercados[i]);
					var mercadoVO:MercadoVO = new MercadoVO();
					for(var str:String in part){
						mercadoVO[str] = part[str];
					}
					modelApp.arrMercados.addItem(mercadoVO);
				}
				
				
				
				
			}
		}
		
	}
}