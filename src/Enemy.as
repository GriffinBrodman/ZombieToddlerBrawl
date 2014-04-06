package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Enemy extends FlxSprite
	{
		[Embed(source = "Art/zombie1.png")] protected var generic:Class;//Update this and the load graphic
		private var runSpeed:uint;
		public function Enemy(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(generic, true, true, 14, 16);
			runSpeed = 1;
			//The below isn't used right now, but I may want it to be
			drag.x = runSpeed*8;
			drag.y = runSpeed *8;
			maxVelocity.x = runSpeed;
			maxVelocity.y = runSpeed;
			
			//initializes values for movement
			addAnimation("walking", [0, 1, 2, 3], 8);
			play("walking");
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			acceleration.x = 0;
			acceleration.y = 0;
			super.update();
		}
		public function enemyMove(target:Player):void
		{
			//May want the enemy to pause sometimes
				moveToward(target);

		}
		
		
		public function moveToward(target:FlxSprite):void{
			//Only call or do moveToward if it isn't "status affected"
			
			
			var delx:Number = x - target.x;
			var dely:Number = y - target.y;
			var angle:Number = 	Math.atan2(dely, delx);
			var xunits:Number = Math.cos(angle) * runSpeed;
			var yunits:Number = Math.sin(angle) * runSpeed;
			//Change these to some combination of y>x for facing
			if (yunits > 0)
			{
				facing = UP;
				y -= yunits
			}
			if (yunits < 0)
			{
				facing = DOWN;
				y -= yunits
			}
			if (xunits > 0)
			{
				facing = RIGHT;
				x -= xunits
			}
			if (xunits < 0)
			{
				facing = LEFT;
				x -= xunits
			}
		
		}
		
		public function die():void
		{
			destroy();
		}
		
	}

}