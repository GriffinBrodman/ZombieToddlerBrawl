package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Fire extends FlxEmitter
	{

		public function Fire(X:int, Y:int) 
		{
			super(X, Y);
			lifespan = 3000;
			gravity = 0;
			setXSpeed( -8, 8);
			setYSpeed( -20, 0);
			for (var i:Number = 0; i < 50; i++)
			{
				
				var drop:FlxParticle = new FlxParticle();
				drop.makeGraphic(3, 3, FlxG.RED);
				drop.alpha = 1;
				drop.lifespan = 1;
				drop.exists = false;
				add(drop);
			}
			start(false, 1 , .3, 0);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			super.update();
			for each(var drop:FlxParticle in this)
			{
				drop.alpha -= .1;
				if (drop.alpha <= 0) 
				{
					remove(drop);
				}
			}

			
		}
		
	}

}