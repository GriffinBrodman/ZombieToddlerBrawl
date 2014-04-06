package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class ButtonTwo extends FlxSprite
	{
		[Embed(source = "Art/buttons2.png")] protected var buttonArt:Class;
		public function ButtonTwo(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(buttonArt, true, false , 13, 13);
			addAnimation("mute", [3, 0],8, false);
			addAnimation("unmute", [1, 2], 8, false);
			addAnimation("start", [2]);
			play("start");
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

