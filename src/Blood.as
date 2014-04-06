package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Blood extends FlxEmitter
	{

		public function Blood(X:int, Y:int) 
		{
			super(X, Y);
			gravity = 0;
			setXSpeed( -30, 30);
			setYSpeed( -30, 30);
			for (var i:Number = 0; i < 50; i++)
			{
				
				var drop:FlxParticle = new FlxParticle();
				drop.makeGraphic(3, 3, FlxG.RED);
				drop.alpha = .6;
				drop.exists = false;
				add(drop);
				
			}
			start(true, 1, 1, 0);
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
				drop.alpha -= 1;
				if (drop.alpha <= 0) 
				{
					remove(drop);
				}
			}

			
		}
		
	}

}