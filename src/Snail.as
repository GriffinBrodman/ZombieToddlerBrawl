package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Snail extends Critter
	{
		[Embed(source = "Art/snaily.png")] protected var snail:Class;
		public function Snail(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(snail, true, true, 29, 14);
			//addAnimation("moving", [0, 1], 6);
			//play("moving");
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

