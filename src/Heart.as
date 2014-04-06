package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Heart extends FlxSprite
	{
		[Embed(source = "Art/heart.png")] protected var heartArt:Class;
		public var red:Boolean;
		public function Heart(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(heartArt, true, false , 15, 13);
			addAnimation("alive", [1, 2], 3);
			addAnimation("dead", [3, 4], 3);
			red = true;
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			super.update();
			
		}
		
		public function heartHurt():void
		{
			red = false;
			play("dead");
		}
		
	}
}

