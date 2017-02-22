package renderers
{
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	import spark.primitives.BitmapImage;
	import spark.primitives.Graphic;
	
	import utils.TextUtil;
	
	public class TweetRenderer extends BaseRenderer
	{
		//--------------------------------------------------------------------------
		//  Protected properties
		//--------------------------------------------------------------------------
		
		protected var userField:TextField;
		protected var nameField:TextField;
		protected var contentField:TextField;
		protected var avatar:BitmapImage;
		protected var avatarHolder:Graphic;
		protected var background:DisplayObject;
		protected var backgroundClass:Class;
		protected var separator:DisplayObject;
		
		protected var paddingLeft:int;
		protected var paddingRight:int;
		protected var paddingBottom:int;
		protected var paddingTop:int;
		protected var horizontalGap:int;
		protected var verticalGap:int;
		
		
		
		//--------------------------------------------------------------------------
		//  Contructor
		//--------------------------------------------------------------------------
		
		public function TweetRenderer()
		{
			percentWidth = 100;
		}
		
		//--------------------------------------------------------------------------
		//  Override Protected Methods
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			readStyles();
			
			setBackground();
			
			var separatorAsset:Class = getStyle( "separator" );
			if( separatorAsset )
			{
				separator = new separatorAsset();
				addChild( separator );
			}
			
			userField  = TextUtil.createSimpleTextField( getStyle( "userStyle" ) );
			addChild( userField );
			
			nameField  = TextUtil.createSimpleTextField( getStyle( "nameStyle" ) )
			addChild( nameField );
			
			contentField  = TextUtil.createSimpleTextField( getStyle( "contentStyle" ) , false, "none" );
			contentField.wordWrap = true;
			contentField.multiline = true;
			addChild( contentField );
			
			avatarHolder = new Graphic();
			avatar = new BitmapImage();
			avatar.fillMode = "clip";
			avatarHolder.width = 48;
			avatarHolder.height = 48;
			avatarHolder.addElement( avatar );
			addChild( avatarHolder );
			
			// if the data is not null, set the text
			if( data )
				setValues();
			
		}
		
		protected function setBackground():void
		{
			var backgroundAsset:Class = getStyle( "background" );
			if( backgroundAsset && backgroundClass != backgroundAsset )
			{
				if( background && contains( background ) )
					removeChild( background );
				
				backgroundClass = backgroundAsset;
				background = new backgroundAsset();
				addChildAt( background, 0 );
				if( layoutHeight && layoutWidth )
				{
					background.width = layoutWidth;
					background.height = layoutHeight;
				}
			}
		}
		
		//--------------------------------------------------------------------------
		
		override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
		{
			avatarHolder.x = paddingLeft;
			avatarHolder.y = paddingTop;
			avatarHolder.setLayoutBoundsSize( avatarHolder.getPreferredBoundsWidth(), avatarHolder.getPreferredBoundsHeight() );
			
				
			userField.x = avatarHolder.x + avatarHolder.width + horizontalGap;
			userField.y = paddingTop;
			
			nameField.x = userField.x + userField.textWidth + horizontalGap;
			nameField.y = paddingTop + ( userField.textHeight - nameField.textHeight ) / 2;
			
			contentField.x = avatarHolder.x + avatarHolder.width + horizontalGap;
			contentField.y = paddingTop + userField.textHeight + verticalGap;
			contentField.width = unscaledWidth - paddingLeft - paddingRight - avatarHolder.getLayoutBoundsWidth() - horizontalGap;
			
			
			layoutHeight = Math.max( contentField.y + paddingBottom + contentField.textHeight, avatarHolder.height + paddingBottom + paddingTop );
			
			background.width = unscaledWidth;
			background.height = layoutHeight;
			
			separator.width = unscaledWidth;
			separator.y = layoutHeight - separator.height;
		}
		
		override public function getLayoutBoundsHeight(postLayoutTransform:Boolean=true):Number
		{
			return layoutHeight;
		}
		override protected function setValues():void
		{
			var arr:Array = String( data.author.name ).split("(");
			var user:String = String( data.author.name )
			userField.text = arr[0];
			nameField.text =  String( arr[ 1 ] ).replace( ")", "" );
			contentField.htmlText = data.content.value;
			
			if( data.link.length > 1)
				avatar.source = data.link[ 1 ].href;
		}
		
		override protected function updateSkin():void
		{
			currentCSSState = ( selected ) ? "selected" : "up";
			setBackground();
		}
		
		protected function readStyles():void
		{
			paddingTop = getStyle( "paddingTop" );
			paddingLeft = getStyle( "paddingLeft" );
			paddingRight = getStyle( "paddingRight" );
			paddingBottom = getStyle( "paddingBottom" );
			horizontalGap = getStyle( "horizontalGap" );
		}
	}
}