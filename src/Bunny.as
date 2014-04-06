package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Bunny extends Critter
	{
		[Embed(source = "Art/BUNNIES.png")] protected var bunny:Class;
		public function Bunny(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(bunny, true, true, 15, 10);
			addAnimation("moving", [0, 1], 6);
			play("moving");
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

