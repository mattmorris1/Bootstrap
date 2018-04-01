package lib.DragonDefense
{
	import flash.display.MovieClip
	import lib.DragonDefense.Particle;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	
	public class DragonDefense extends MovieClip
	{
		private var dragon:MovieClip;
		//upper and lower arms are combined into single movie clip dragon
		private var fireballs:Array;
		private var knights:Array;
		private var FireBall:Particle;
		private var dragonLocation:Point;
		private var dragonAngle:Number;
		private var fireballsLayer:Sprite;
		private var knightsLayer:Sprite;
		private var touchLayer:Sprite;
		private var knightSpawnDelay:Number;
		private var knightSpawnCounter:Number;
		private var difficulty:Number;
		private var difficultyRate:Number;
		private var barrageCount:Number;
		private var barrageSpacing:Number;
		
		private var background:MovieClip;
		private var GoldPile:MovieClip;
		
		private var health:uint;
		private var healthfield:TextField;
		private var score:uint;
		private var scorefield:TextField;
		
		private var endscreen:MovieClip;

		
		
		public function DragonDefense()
		{
			
			barrageCount = 0;
			barrageSpacing = 1;
			
			difficultyRate = 0.3;
			difficulty = 1;
			knightSpawnDelay = knightSpawnCounter = 100;
			
			fireballs = new Array();
			knights = new Array();
			
			dragon = new Character();
			FireBall = new Fireball();
			background = new Background();
			GoldPile = new Gold();
			endscreen = new End();
			
			dragonLocation = new Point(250, 350);
			dragonAngle = 0;
			FireBall.x = dragonLocation.x;
			FireBall.y = dragonLocation.y;
			dragon.x = dragonLocation.x;
			dragon.y = dragonLocation.y;
			GoldPile.x = 10;
			GoldPile.y = 150;
			
			health = 100;
			healthfield = new TextField;
			healthfield.text = health.toString();
			healthfield.width = 200;
			healthfield.x = 47;
			healthfield.y = 8;
			score = 0;
			scorefield = new TextField;
			scorefield.text = score.toString();
			scorefield.x = 115;
			scorefield.y = 8;
			scorefield.width = 200;
			
			dragon.rotation = FireBall.rotation = dragonAngle;
			
			addChild(background);
			addChild(GoldPile);
			addChild(healthfield);
			addChild(scorefield);
			addChild(FireBall);
			addChild(dragon);
			
			addEventListener(Event.ENTER_FRAME, update);
			
			fireballsLayer = new Sprite();
			knightsLayer = new Sprite();
			touchLayer = new Sprite();
			
			addChild(fireballsLayer);
			addChild(knightsLayer);
			addChild(touchLayer);
			addEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);
		}
		
		private function setupTouchLayer(evt:Event):void
		{
			touchLayer.graphics.beginFill(0x000000, 0);
			touchLayer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			touchLayer.graphics.endFill();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, shootfireball);
		}
		
		private function shootfireball(evt:KeyboardEvent):void
		{
			if (evt.keyCode == Keyboard.SPACE) {
			makefireball(dragonAngle);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, shootfireball);
			stage.addEventListener(KeyboardEvent.KEY_UP, reset);
			}
		}
		
		private function reset(evt:KeyboardEvent):void {
			stage.removeEventListener(KeyboardEvent.KEY_UP, reset);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, shootfireball);
		}
		
		private function makefireball(angle:Number):void
		{
			var newfireball:Particle = new Fireball();
			
			newfireball.x = dragonLocation.x;
			newfireball.y = dragonLocation.y;
			newfireball.rotation = angle;
			
			var xDiff:Number = dragonLocation.x - touchLayer.mouseX;
			var yDiff:Number = dragonLocation.y - touchLayer.mouseY;
			
			var distance:Number = Math.sqrt(Math.pow(300, 2) + Math.pow(300, 2));
			
			var power:Number = distance / 15;
			
			newfireball.xVel = power * Math.cos(newfireball.rotation / 180 * Math.PI);
			newfireball.yVel = power * Math.sin(newfireball.rotation / 180 * Math.PI);
			
			newfireball.addEventListener(Particle.PURGE_EVENT, purgefireballHandler);
			
			fireballsLayer.addChild(newfireball);
			fireballs.push(newfireball);
		}
		
		private function makeknights():void
		{
			knightSpawnCounter++;
			
			if (knightSpawnCounter > knightSpawnDelay)
			{
				knightSpawnCounter = 0;
				knightSpawnDelay -= difficultyRate;
				difficulty += difficultyRate;
				makeknight();
			}
		}
		
		private function makeknight():void
		{
			var i:int;
			for (i = 0; i < Math.floor(difficulty); i++)
			{
				var newknight:Knight = new Enemy();
				
				newknight.x = 1050;
				newknight.y = Math.random() * 300 + 250;
				
				newknight.xVel = (-Math.random() * difficulty) - 10;
				newknight.sinMeter = Math.random() * 10;
				newknight.bobValue = Math.random() * difficulty;
				
				newknight.addEventListener(Particle.PURGE_EVENT, purgeknightHandler);
				
				knightsLayer.addChild(newknight);
				knights.push(newknight);
			}
		}
		
		private function purgefireballHandler(evt:Event):void
		{
			var targetfireball:Particle = Particle(evt.target);
			purgefireball(targetfireball);
		}
		private function purgeknightHandler(evt:Event):void
		{
			var targetknight:Particle = Particle(evt.target);
			purgeknight(targetknight);
		}
		
		private function purgeknight(targetknight:Particle):void
		{
			targetknight.removeEventListener(Particle.PURGE_EVENT, purgeknightHandler);
			try
			{
				var i:int;
				for (i = 0; i < knights.length; i++)
				{
					if (knights[i].name == targetknight.name)
					{
						knights.splice(i, 1);
						knightsLayer.removeChild(targetknight);
						i = knights.length;
					}
				}
			}
			catch(e:Error)
			{
				trace("Failed to delete knight!", e);
			}
		}

		private function purgefireball(targetfireball:Particle):void
		{
			targetfireball.removeEventListener(Particle.PURGE_EVENT, purgefireballHandler);
			try
			{
				var i:int;
				for (i = 0; i < fireballs.length; i++)
				{
					if (fireballs[i].name == targetfireball.name)
					{
						fireballs.splice(i, 1);
						fireballsLayer.removeChild(targetfireball);
						i = fireballs.length;
					}
				}
			}
			catch(e:Error)
			{
				trace("Failed to delete fireball!", e);
			}
		}
		
		private function hitTest(fireball:Particle):void
		{
			for each (var knight:Knight in knights)
			{
				if (knight.status != "Dead" && knight.hitTestPoint(fireball.x, fireball.y))
				{
					knight.destroy();
					purgefireball(fireball);
					score += 10;
					scorefield.text = score.toString();
				}
			}
		}
		
		private function update(evt:Event):void
		{
			var target:Point = new Point(mouseX, mouseY);
			trace ("target")
			var angleRad:Number = Math.atan2(target.y - dragonLocation.y, target.x - dragonLocation.x);
			
			dragonAngle = angleRad * 180 / Math.PI;
			
			dragon.rotation = FireBall.rotation = dragonAngle;
			
			trace(knights.length, fireballs.length);
			for each (var knight:Particle in knights)
			{
				if (knight.x < GoldPile.x) {
					health -= 10;
					healthfield.text = health.toString();
					knight.update();
					
				} else {
					
				knight.update(); }			
				}
			
			for each (var fireball:Particle in fireballs)
			{
				fireball.update();
				hitTest(fireball);
			}
			if (health == 0) {
				
				endgame();
				
			} else {
				
			makeknights();
			}
			
			
		}
		private function endgame():void {
			
			removeChild(background);
			removeChild(GoldPile);
			removeChild(healthfield);
			removeChild(scorefield);
			removeChild(FireBall);
			removeChild(dragon);
	
		
			removeEventListener(Event.ENTER_FRAME, update); 
			
			removeChild(fireballsLayer);
			removeChild(knightsLayer);
			removeChild(touchLayer);
			removeEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);
			
			
			
			addChild(endscreen);
			endscreen.PlayAgain.addEventListener(MouseEvent.CLICK, startOver);
		}
		
		private function startOver(evt:MouseEvent):void {
			
			var game:DragonDefense = new DragonDefense;
			endscreen.PlayAgain.removeEventListener(MouseEvent.CLICK, startOver);
			removeChild(endscreen);
			
			addChild(game);
			
		}

	}
}