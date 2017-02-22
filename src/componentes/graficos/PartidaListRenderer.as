package componentes.graficos
{
	import spark.components.IconItemRenderer;
	import spark.components.LabelItemRenderer;
	
	import vo.PartidaVO;
	
	
	/**
	 * 
	 * ASDoc comments for this item renderer class
	 * 
	 */
	
	//[Style(name="sectionFontSize", type="Number", format="Length", inherit="no")]
	[Style(name="titleStyleName", type="String", inherit="no")]
	[Style(name="statusStyleName", type="String", inherit="no")]
	[Style(name="totalStyleName", type="String", inherit="no")]
	[Style(name="dateStyleName", type="String", inherit="no")]
	
	public class PartidaListRenderer extends IconItemRenderer
	{
		
		
		public function PartidaListRenderer()
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
			this.label = PartidaVO(value).Player1;
			
			
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
			this.labelDisplay.setStyle('fontSize', 20);
			this.labelDisplay.setStyle('fontFamily', 'ArsleGothic');
			this.messageDisplay.setStyle('fontSize', 10);
			this.messageDisplay.setStyle('fontFamily', 'ArsleGothic');
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