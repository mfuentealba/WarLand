package skins
{
	import spark.components.Button;
	import spark.components.IconItemRenderer;
	import spark.components.LabelItemRenderer;
	import spark.components.supportClasses.StyleableTextField;
	
	
	/**
	 * 
	 * ASDoc comments for this item renderer class
	 * 
	 */
	public class GastoRenderSkin extends IconItemRenderer// implements IDataRenderer
	{
		public function GastoRenderSkin()
		{
			//TODO: implement function
			super();
		}
		
		/**
		 * @private
		 *
		 * Override this setter to respond to data changes
		 */
		override public function set data(value:Object):void
		{
			super.data = value;
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
		//	super.createChildren();		
			// create any additional children for your item renderer here
			//labelDisplay.width = 30;
			labelDisplay = StyleableTextField(createInFontContext(StyleableTextField));
			labelDisplay.styleName = this;
			labelDisplay.editable = true;
			labelDisplay.selectable = false;
			labelDisplay.multiline = true;
			labelDisplay.wordWrap = true;
			//labelDisplay.width = 0;
			
			
			addChild(labelDisplay);
			//labelDisplay.width = 10;
			setStyle("selectionColor", "0xCCEEFF");
			setStyle("rollOverColor", "0xCCEEFF");
			/*var btn:Button = new Button();
			btn = Button(createInFontContext(Button))
			btn.label = 'hola';
			btn.width= unscaledWidth / 2;
			btn.height=Math.min(btn.height + 4, 60);
			addChild(btn);*/
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
			//super.measure();
			measuredHeight=80;
			
			measuredWidth=400;
			
			// Minimums
			measuredMinWidth=80;
			measuredMinHeight=measuredHeight;
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