package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Griffin
	 */
	public class PlayState extends FlxState 
	{
		// Grass Tileset
		[Embed(source = 'Art/grass.png')]private static var grass:Class;
		[Embed(source = 'Art/border.png')]private static var borderArt:Class;
		[Embed(source = 'Art/fireBorder.png')]private static var fireBorderArt:Class;
		[Embed(source = 'Art/fireBorderBottom.png')]private static var fireBorderBottom:Class;
		private var terrainMap:FlxTilemap;
		private var player:Player;
		private var badguy:Enemy;
		private var bunbun:Bunny;
		private var debug:FlxText;
		private var score:FlxText;
		private var points:Number;
		private var enemies:FlxGroup;
		private var chain:FlxSprite;
		private var border:FlxSprite;
		private var heart1:Heart;
		private var heart2:Heart;
		private var heart3:Heart;
		private var spawnTimer:Number;
		private var fireBar:FlxSprite;
		private var fireBorder:FlxSprite;
		private var fireBorderBot:FlxSprite;
		private var fire:Fire;
		private var button:ButtonOne;
		private var button2:ButtonTwo;
		private var pauseCounter:int;
		private var pauseDelay:int;
		private var mutePauseCounter:int;
		private var mutePauseDelay:int;
		

		override public function create():void 
		{
			
			makeMap();
			makePlayer();
			makeEnemies();
			makeTopBar();
			makeFireBar();
		}
		
		private function makePlayer():void
		{
			chain = new FlxSprite();
			chain.makeGraphic(100, 100, 0x00000000, true);
			add(chain);
			
			
			player = new Player(130, 130);
			player.elasticity = 10;
			add(player);
			add(player.flaily);
			
			
			var cam:FlxCamera = new FlxCamera(0, 44, FlxG.width, FlxG.height);
			cam.follow(player,0);//An alternative to this is using dead zones, but it's working okay for this size
			cam.setBounds(0,0, 700, 700);
			FlxG.addCamera(cam);
		}
		
		private function makeEnemies():void
		{
			enemies = new FlxGroup(100);
			spawnTimer = 0;
		}
		
		private function makeMap():void
		{
			FlxG.worldBounds.height = 750;
			FlxG.worldBounds.width = 750;
			
			
			//Array done by hand of noncollideable terrain
			var terrain:Array = new Array(
			6, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 12,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13,
			3, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 9
			);
			
			terrainMap = new FlxTilemap();
			terrainMap.loadMap(FlxTilemap.arrayToCSV(terrain, 40), grass, 16, 16, FlxTilemap.OFF);
			terrainMap.solid = false;
			add(terrainMap);
		}
		
		private function makeTopBar():void 
		{
			border = new FlxSprite(1000, 1000);
			border.loadGraphic(borderArt, false, false, 320, 21);
			add(border);
			
			var cam:FlxCamera = new FlxCamera(0, 0, FlxG.width, 22, 2);
			cam.follow(border);
			FlxG.addCamera(cam);
			
			button = new ButtonOne(1058, 1004);
			pauseCounter = 0;
			pauseDelay = 0;
			add(button);
			
			button2 = new ButtonTwo(1075, 1004);
			mutePauseCounter = 0;
			mutePauseDelay = 0;
			add(button2);
			
			
			score = new FlxText(1160, 1005, 100);
			score.text = "0";
			score.color = FlxG.BLACK;
			points = 0;
			add(score);
			
			heart1 = new Heart(1004, 1004);
			heart1.play("alive");
			add(heart1);
			heart2 = new Heart(1020, 1004);
			heart2.play("alive");
			add(heart2);
			heart3 = new Heart(1036, 1004);
			heart3.play("alive");
			add(heart3);
		}
		
		private function makeFireBar():void
		{
			
			fireBorder = new FlxSprite(7000, 7000);
			fireBorder.loadGraphic(fireBorderArt, false, false, 16, 103);
			add(fireBorder);
			
			fireBar = new FlxSprite(2000,2000);
			fireBar.makeGraphic(10, 1, FlxG.WHITE, true);
			add(fireBar);
			
			//FireTimer
			var cam:FlxCamera = new FlxCamera(0, 48, 16, 103, 2);
			cam.follow(fireBorder);
			FlxG.addCamera(cam);
			
			fireBorderBot = new FlxSprite(8000, 8000);
			fireBorderBot.loadGraphic(fireBorderBottom, false, false, 16, 3);
			add(fireBorderBot);
			
			cam = new FlxCamera(0, 251, 16, 3, 2);
			cam.follow(fireBorderBot);
			FlxG.addCamera(cam);
			fireBar.x = fireBorder.x + 3;
			fireBar.y = fireBorder.y + fireBorder.height - 1 * player.fireTimer;
			fireBar.color = FlxG.BLUE;
		}
		
		
		override public function update():void
		{
			pauseLogic();
			if (FlxG.paused && pauseDelay == 0) return;
			mutePauseLogic();
			
			score.text = points.toString();
			
			fireBarLogic();
			if (FlxG.keys.ENTER) FlxG.switchState(new PlayState());

			enemySpawner();
			FlxG.collide(player.flaily, enemies, enemyHit);
			FlxG.collide(enemies, enemies);
			if(!player.isImmortal)FlxG.collide(player, enemies, playerHit);
			super.update();
			for each(var zombie:Enemy in enemies.members) 
			{
				zombie.enemyMove(player);
			}
			moveChain();
		}
		
		
		private function pauseLogic():void
		{
			if (FlxG.keys.P && pauseCounter==0)
			{
				pauseCounter = 45;
				pauseDelay = 10;
				if (FlxG.paused)
				{
					FlxG.paused = false;
					button.play("pause");
				}
				else 
				{
					FlxG.paused = true;	
					button.play("play");
				}
			}
			pauseCounter--;
			pauseDelay--;
			if (pauseCounter < 0) pauseCounter = 0;
			if (pauseDelay < 0) pauseDelay = 0;
		}
		
		private function mutePauseLogic():void
		{
			if (FlxG.keys.M && mutePauseCounter==0)
			{
				mutePauseCounter = 45;
				mutePauseDelay = 10;
				if (FlxG.mute)
				{
					FlxG.mute = false;
					button2.play("unmute");
				}
				else 
				{
					FlxG.mute = true;	
					button2.play("mute");
				}
			}
			mutePauseCounter--;
			mutePauseDelay--;
			if (mutePauseCounter < 0) mutePauseCounter = 0;
			if (mutePauseDelay < 0) mutePauseDelay = 0;
		}
		
		private function enemySpawner():void
		{
			spawnTimer++;
			
			if (spawnTimer > 45)
			{
				spawnTimer = 0;
				var x:int = 0;
				if (Math.random() < .5) x = FlxG.width *2;
				var y:int = Math.random() * FlxG.height * 2;
				if (Math.random() < .5)	badguy = new Enemy(x, y);
				else badguy = new Enemy(y, x);
				add(badguy);
				enemies.add(badguy);
			}
		}
		
		
		private function fireBarLogic():void
		{
			fireBar.scale.y = player.fireTimer * 2;
			if (FlxG.keys.Q) player.fireTimer++;
			if (player.fireTimer <= -1) player.fireTimer = 0;
			if (player.fireTimer >= 100) player.fireTimer = 100;
			if (player.fireTimer == 0 && player.isOnFire)
			{
				player.isOnFire = false;
				fire.on = false;
				fireBar.color = FlxG.BLUE;
				player.flaily.play("nofire");
			}
			if (player.fireTimer == 100 && !player.isOnFire) 
			{
				player.isOnFire = true;
				fire = new Fire(fireBorder.x + fireBorder.width / 2, fireBorder.y + 3 + (100 -  player.fireTimer));
				add(fire);
				fireBar.color = FlxG.RED;
				player.flaily.play("fire");
			}

			if (player.isOnFire)
			{
				fire.y = fireBorder.y + 3 + (100 -  player.fireTimer);
				player.fireTimer -= .5;
				
			}
			else 
			{

			}
			
		}
		
		private function enemyHit(flaily:Flail, enemy:Enemy):void
		{
			if (Math.abs(flaily.angVel) < .08 && !player.throwing) return;
			if(!player.isOnFire) player.fireTimer -= 20;
			for each(var zombie:Enemy in enemies.members)
			{
				if (zombie.alive)
				{
					var xdis:Number = (zombie.x + zombie.width / 2) - (player.flaily.x + player.flaily.width / 2);
					var ydis:Number = (zombie.y + zombie.height / 2) - (player.flaily.y + player.flaily.height / 2);
					var hypo:Number = Math.sqrt(xdis * xdis + ydis * ydis);
					if (hypo < 25)
					{
						zombie.kill();
						points++;
						var bloody:Blood = new Blood(zombie.x, zombie.y);
						add(bloody);
					}
				}
			}
			if (!player.hasJustCollided && !player.isOnFire) {
				flaily.angVel = -flaily.angVel / 1.75;
				player.justCollidedTimer = 20;//This may need to be lower or higher
				player.hasJustCollided = true;
			}

		}
		
		private function moveChain():void
		{
			chain.x = Math.min(player.flaily.x + player.flaily.width/2 , player.x + player.width/2);
			chain.y = Math.min(player.flaily.y + player.flaily.height/2, player.y + player.height/2);
			chain.fill(0x00000000);
			var startChainy:Number = 0;
			var endChainy:Number = 0;
			if (player.flaily.flailAngle > 0 && player.flaily.flailAngle < Math.PI/2) {
				endChainy = Math.abs(player.flaily.y - player.y);
			}
			if (player.flaily.flailAngle > Math.PI && player.flaily.flailAngle < 3*Math.PI/2) {
				endChainy = Math.abs(player.flaily.y - player.y);
			}
			if (player.flaily.flailAngle > Math.PI/2 && player.flaily.flailAngle <Math.PI) {
				startChainy = Math.abs(player.flaily.y - player.y);
			}
			if (player.flaily.flailAngle > 3*Math.PI/2 && player.flaily.flailAngle < 2 * Math.PI) {
				startChainy = Math.abs(player.flaily.y - player.y);
			}
			if (!player.isOnFire)	chain.drawLine(0, startChainy, Math.abs(player.flaily.x - player.x), endChainy, 0xff999999, 2);
			else chain.drawLine(0, startChainy, Math.abs(player.flaily.x - player.x), endChainy, 0xff990000, 2);
		}
		
		private function dying():void
		{
			player.flaily.kill();
			chain.kill();
			player.kill();
			
		}
		
		private function playerHit(player:Player, enemy:Enemy):void 
		{
			player.isImmortal = true;
			player.isImmortalTimer = 100;
			if (heart3.red) 
			{
				heart3.heartHurt();
				heart2.play("dead");
				heart2.play("alive");
				heart1.play("dead");
				heart1.play("alive");
			}
			else if (heart2.red)
			{
				heart2.heartHurt();
				heart3.play("alive");
				heart3.play("dead");
				heart1.play("dead");
				heart1.play("alive");
			}
			else if (heart1.red)
			{
				heart1.heartHurt();
				heart3.play("alive");
				heart3.play("dead");
				heart2.play("alive");
				heart2.play("dead");
				dying();
			}
		}
	}

}