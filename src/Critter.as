package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Critter extends FlxSprite
	{
		public var moveTimer:int;
		public function Critter(X:int, Y:int) 
		{
			super(X, Y);
			drag.x = 50;
			drag.y = 50;
			moveTimer = -1;
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			super.update();
			moveTimer--;
			if (moveTimer <= -1) 
			{	
				var yvelocityChange:Number = Math.random() * 100 - 50;
				if (y < 64) 
				{
					yvelocityChange = Math.abs(yvelocityChange);
				}
				if (y > 580) 
				{
					yvelocityChange = -Math.abs(yvelocityChange);
				}
				
				var xvelocityChange:Number = Math.random() * 100 - 50;
				if (x < 64) 
				{
					xvelocityChange = Math.abs(xvelocityChange);
				}
				if (x > 580) 
				{
					xvelocityChange = -Math.abs(xvelocityChange);
				}
				if (xvelocityChange >= 0) {
					facing = RIGHT;
				}
				else {
					facing = LEFT;
				}
				velocity.x = xvelocityChange;
				velocity.y = yvelocityChange;
				moveTimer = 180 + Math.random() * 180;
			}
		}
		
	}

}