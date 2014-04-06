package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Flail extends FlxSprite
	{
		protected var heavyness:Number;
		protected var accelFlag:Boolean;
		public var flailAngle:Number;
		public var angVel:Number;
		public var ropeLength:Number;
		public var maxAngVel:Number;
		[Embed(source = "Art/enemy.png")] protected var image:Class;
		public function Flail(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(image, true, true, 14, 14);
			heavyness = 2;
			flailAngle = 0;
			angVel = 0;
			accelFlag = false;
			ropeLength = 40;
			maxAngVel = .2;
			addAnimation("nofire", [0]);
			addAnimation("fire", [1]);
			play("nofire");

		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			if (flailAngle < 0) {
				flailAngle += 2 * Math.PI;
			}
			flailAngle = flailAngle % (2 * Math.PI);
			super.update();	

		}
		
		public function applyForce(angVelChange:Number):void
		{
			angVel += angVelChange;
		}
		
	}
}
