package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class ButtonOne extends FlxSprite
	{
		[Embed(source = "Art/button.png")] protected var buttonArt:Class;
		public function ButtonOne(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(buttonArt, true, false , 13, 13);
			addAnimation("pause", [3, 0],8, false);
			addAnimation("play", [1,2],8,false);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			super.update();	
		}
		
		
	}
}

