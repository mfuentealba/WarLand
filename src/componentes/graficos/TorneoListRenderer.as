package componentes.graficos
{
	import spark.components.IconItemRenderer;
	import spark.components.LabelItemRenderer;
	
	import vo.PartidaVO;
	import vo.TorneoVO;
	
	
	/**
	 * 
	 * ASDoc comments for this item renderer class
	 * 
	 */
	
	//[Style(name="sectionFontSize", type="Number", format="Length", inherit="no")]
	
	public class TorneoListRenderer extends IconItemRenderer
	{
		
		
		public function TorneoListRenderer()
		{
			//TODO: implement function
			
			super();
			this.iconField = 'icono';
			this.messageField = 'rangoELO';
			this.iconWidth = 40;
			this.iconHeight = 40;
		}
		
		/**
		 * @private
		 *
		 * Override this setter to respond to data changes
		 */
		override public function set data(value:Object):void
		{
			super.data = value;
			this.label = TorneoVO(value).duracion;
			
			
			// the data has changed.  push these changes down in to the 
			// subcomponents here    		
		} 
		
		/**
		 * @private
		 * 
		 * Override this method to create children for your item renderer 
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			// create any additional children for your item renderer here
		}
		
		/**
		 * @private
		 * 
		 * Override this method to change how the item renderer 
		 * sizes itself. For performance reasons, do not call 
		 * super.measure() unless you need to.
		 */ 
		override protected function measure():void
		{
			super.measure();
			this.labelDisplay.setStyle('fontSize', 40);
			// measure all the subcomponents here and set measuredWidth, measuredHeight, 
			// measuredMinWidth, and measuredMinHeight      		
		}
		
		/**
		 * @private
		 * 
		 * Override this method to change how the background is drawn for 
		 * item renderer.  For performance reasons, do not call 
		 * super.drawBackground() if you do not need to.
		 */
		override protected function drawBackground(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			// do any drawing for the background of the item renderer here      		
		}
		
		/**
		 * @private
		 *  
		 * Override this method to change how the background is drawn for this 
		 * item renderer. For performance reasons, do not call 
		 * super.layoutContents() if you do not need to.
		 */
		override protected function layoutContents(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			// layout all the subcomponents here      		
		}
		
	}
}