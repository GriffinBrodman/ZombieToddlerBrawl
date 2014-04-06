package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Griffin
	 */
	public class Player extends FlxSprite
	{
		private var levelHeight:Number;
		private var levelWidth:Number;
		private var runSpeed:Number;
		public var flaily:Flail;
		public var throwing:Boolean;
		public var throwCounter:Number;
		public var waitCounter:Number;
		public var hasJustCollided:Boolean;
		public var justCollidedTimer:uint;
		public var velAngle:Number;
		public var isImmortal:Boolean;
		public var isImmortalTimer:int;
		public var fireTimer:Number;
		public var isOnFire:Boolean;
		
		[Embed(source = "Art/man.png")] protected var playerArt:Class;
		public function Player(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(playerArt, true, true, 14, 16);
			runSpeed = 150;
			drag.x = runSpeed*8;
			drag.y = runSpeed *8;
			maxVelocity.x = runSpeed;
			maxVelocity.y = runSpeed;
			addAnimation("walkingdown", [0, 1, 2, 3], 8, true);
			addAnimation("still", [0]);
			levelHeight = 640;
			levelWidth = 640;
			throwing = false;
			throwCounter = 1;
			waitCounter = 0;
			velAngle = 0;
			hasJustCollided = false;
			justCollidedTimer = 0;
			isImmortal = false;
			isImmortalTimer = -1;
			fireTimer = 0;
			play("walkingdown");
			flaily = new Flail(-10, -10);
			
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			//Movement controls
			super.update();
			playerMovement();
			justCollidedLogic();
			if (!flailThrow()) return;
			flailMovement();
			flailFollow();		
			
		}
		
		
		private function playerMovement():void
		{
			acceleration.x = 0;
			acceleration.y = 0;
			if (isImmortalTimer == 0)
			{
				isImmortalTimer = -1;
				isImmortal = false;
			}
			else if(isImmortalTimer > 0)
			{
				isImmortalTimer--;
				if (isImmortalTimer % 20 <10) alpha = 1;
				else alpha = 0;
			}
			
			if (isImmortal)
			{
			maxVelocity.x = runSpeed * 1.5;
			maxVelocity.y = runSpeed * 1.5;
			}
			else
			{
			maxVelocity.x = runSpeed;
			maxVelocity.y = runSpeed;
			}
			if(FlxG.keys.A)
			{
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			if(FlxG.keys.D)
			{
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			if(FlxG.keys.S)
			{
				acceleration.y += drag.y;
			}
			if(FlxG.keys.W)
			{
				acceleration.y -= drag.y;
			}
			//Boundary enforcement
			if (x < 0)
			{
				x = 0;
			}
			if (y < 0)
			{
				y = 0;
			}
			if (y > levelHeight - height)
			{
				y = levelHeight - height;
			}
			if (x > levelWidth - width)
			{
				x = levelWidth - width;
			}
		}
		
		private function flailMovement():void
		{
			if (FlxG.keys.RIGHT)
			{
				flaily.applyForce(.002);
				if (flaily.angVel > .1 && !isOnFire) fireTimer += .5;
			}
			else if (FlxG.keys.LEFT)
			{
				flaily.applyForce( -.002);	
				if (flaily.angVel < -.1 && !isOnFire) fireTimer += .5;
			}
			else 
			{
				if (!isOnFire)
				{
					if (flaily.angVel > .1 || flaily.angVel < -.1) fireTimer += .3
					else fireTimer += .1;
				}
				flaily.angVel = flaily.angVel * .94
			}
			if (!isOnFire && flaily.angVel < .05 && flaily.angVel > -.05) fireTimer -= .4;
			if (flaily.angVel > flaily.maxAngVel) {
				flaily.angVel = flaily.maxAngVel;
			}
			if (flaily.angVel < -flaily.maxAngVel) {
				flaily.angVel = -flaily.maxAngVel;
			}
			
			
			
			flaily.flailAngle += flaily.angVel;
			if (Math.abs(flaily.angVel) < .001) flaily.angVel = 0;
			flaily.x = -(flaily.ropeLength * Math.cos(-flaily.flailAngle) + flaily.width/2) + x + width/2;
			flaily.y = -(flaily.ropeLength * Math.sin(flaily.flailAngle) + flaily.height / 2) + y + height / 2;
		}
	
		private function flailFollow():void
		{
			velAngle =  (Math.atan2( velocity.y, velocity.x) + 2 * Math.PI) % (2 * Math.PI);
			if (!FlxG.keys.LEFT && !FlxG.keys.RIGHT && (velocity.x != 0 || velocity.y != 0) && flaily.angVel ==0)
			{
				if (((velAngle - flaily.flailAngle) + 2 * Math.PI) % (2 * Math.PI) <= Math.PI)
				{
					if (Math.abs(velAngle - flaily.flailAngle) >= 1 / 18)
					{
						flaily.flailAngle += .05;	
					}
				}
				else 
				{
					if (Math.abs(velAngle - flaily.flailAngle) >= 1 / 18)
					{
						flaily.flailAngle -= .05;	
					}
				}
			}
		}
		
		private function justCollidedLogic():void
		{
			if (justCollidedTimer > 0) 
			{
				justCollidedTimer--;
			}
			else
			{
				hasJustCollided = false;
			}
		}
	
		private function flailThrow():Boolean
		{
			if (throwing)
			{
				if (throwCounter < 11)
				{
					throwCounter++;
					flaily.x = -(flaily.ropeLength * Math.cos(flaily.flailAngle) * (10-throwCounter)/10 + flaily.width/2) + x + width/2;
					flaily.y = -(flaily.ropeLength * Math.sin(flaily.flailAngle) * (10-throwCounter)/10 + flaily.height/2) + y + height / 2;
				}
				else if(throwCounter < 21)
				{
					throwCounter++;//Fix this part
					flaily.x = -(flaily.ropeLength * Math.cos(flaily.flailAngle + Math.PI) * (throwCounter-10)/10 + flaily.width/2) + x + width/2;
					flaily.y = -(flaily.ropeLength * Math.sin(flaily.flailAngle + Math.PI) * (throwCounter-10)/10 + flaily.height/2) + y + height / 2;
				}
				else 
				{
					throwCounter = 1;
					waitCounter = 60;
					throwing = false;
					flaily.flailAngle += Math.PI;
				}
				return false;
				
			}
			
			if (waitCounter > 0) waitCounter--;
			
			if (FlxG.keys.SPACE && waitCounter ==0)
			{
				throwing = true;
				flaily.angVel = 0;
			}
			return true;
		}
		
	}

}