package 
{
	import agent.DragonAgent;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import agent.VillagerAgent;
	import agent.warriorAgent;
	import flash.text.TextField;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.media.SoundChannel;
	
	public class DragonMain extends Sprite 
	{
		public var S: scenes_mc = new scenes_mc();
		public var M: BackMusic = new BackMusic();
		public var E:Number;
		public var F:Number;
		public var agents:Vector.<warriorAgent>;
		public var VTar:VillagerAgent = new VillagerAgent();
		
		public var villagers:Vector.<VillagerAgent>;
		
		public var dragon:DragonAgent = new DragonAgent();
		
		private var timer:Timer = new Timer(5000);
		private var timer2:Timer = new Timer(2000);
		private var timer3:Timer = new Timer(1000);
		private var timer4:Timer = new Timer(1000);
		private var timer5:Timer = new Timer(900);
		private var t: Timer = new Timer(30000);
		private var t2: Timer = new Timer(30000);
		
		private var indicator:MovieClip;
		
		private var draghealth:uint;
		private var healthfield:TextField;
		
		private var deadVill:uint;
		private var deadfield:TextField;
		private var FailScreen:FailScreen_mc = new FailScreen_mc();
		private var WinScreen:WinScreen_mc = new WinScreen_mc();
		
		public function DragonMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void 
		{
			
			addChild(S);
			addChild(M);
			S.gotoAndStop(1);
			t.start();
			t.addEventListener(TimerEvent.TIMER, switchscene1);
			
			
			indicator = new Timer_mc();
			
			draghealth = 100;
			healthfield = new TextField;
			healthfield.text = draghealth.toString();
			healthfield.width = 200;
			healthfield.x = 50;
			healthfield.y = 20;
			
			deadVill = 0;
			deadfield = new TextField;
			deadfield.text = deadVill.toString();
			deadfield.width = 200;
			deadfield.x = 100;
			deadfield.y = 20;
			
			indicator.x = 40;
			indicator.y = 40;
			addChild(indicator);
			addChild(healthfield);
			addChild(deadfield);
			VTar.x = Math.random() * stage.stageWidth;
			VTar.y = Math.random() * stage.stageHeight;
			addChild(VTar);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			agents = new Vector.<warriorAgent>();
			villagers = new Vector.<VillagerAgent>();
			addEventListener(Event.ENTER_FRAME, gameloop);
			addChild(dragon);
			dragon.x = stage.stageWidth/2
			dragon.y = stage.stageHeight/2
			timer2.start();
			timer2.addEventListener(TimerEvent.TIMER, createVillager);
			stage.addEventListener(MouseEvent.CLICK, createAgent);
		}
		
		public function createAgent(e:MouseEvent):void 
		{
			var a:warriorAgent = new warriorAgent();
			a.x = mouseX;
			a.y = mouseY;
			addChild(a);
			agents.push(a);
			stage.removeEventListener(MouseEvent.CLICK, createAgent);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			indicator.alpha = 0.5;
		}
		
		public function createVillager(evt:TimerEvent):void 
		{
			var b:VillagerAgent = new VillagerAgent();
			addChild(b);
			villagers.push(b);
			b.x = Math.random() * stage.stageWidth;
			b.y = Math.random() * stage.stageHeight;
			
		}
		
		private function gameloop(e:Event):void 
		{
			for (var i:int = 0; i < agents.length; i++) 
			{if(dragon.hitTestObject(agents[i])) {
				agents[i].wArt.gotoAndStop(9);
				this.timer5.start();
				if(this.timer5.currentCount){
				this.timer5.stop();
				this.timer5.reset();
				removeChild(agents[i]);
				agents.splice(i, 1);
				draghealth -=10;
				healthfield.text = draghealth.toString();}
			}
			else
				agents[i].update(dragon);
			}
			for (var j:int = 0; j < villagers.length; j++) 
			{
				trace (villagers.length);
				if(dragon.hitTestObject(villagers[j])) {
						villagers[j].VArt.gotoAndStop(5);
						this.timer4.start();
					if(this.timer4.currentCount){
						this.timer4.stop();
						this.timer4.reset();
						removeChild(villagers[j]);
						villagers.splice(j, 1);
						deadVill += 10;
						deadfield.text = deadVill.toString();
				}
			}
			else if (villagers[j].hitTestPoint(stage.stageWidth, stage.stageHeight)){
				removeChild(villagers[j]);
				villagers.splice(j, 1);
			}
			else if (villagers[j].hitTestPoint(0, 0)){
				removeChild(villagers[j]);
				villagers.splice(j, 1);
			}
			else if (villagers[j].hitTestPoint(stage.stageWidth, 0)){
				removeChild(villagers[j]);
				villagers.splice(j, 1);
			}
			else if (villagers[j].hitTestPoint(0, stage.stageHeight)){
				removeChild(villagers[j]);
				villagers.splice(j, 1);
			}
			else {
				villagers[j].update(dragon);}
			}
			dragon.update(E, F);
			VTar.update(dragon);
			E = VTar.x;
			F = VTar.y;
			if(dragon.hitTestObject(VTar)) {
				VTar.VArt.gotoAndStop(5);
				timer3.addEventListener(TimerEvent.TIMER, KillVTAR);
				timer3.start();
			}
			else if(VTar.hitTestPoint(stage.stageWidth, stage.stageHeight)){
				switchVTAR();
			}
			else if(VTar.hitTestPoint(0, 0)){
				switchVTAR();
			}
			else if(VTar.hitTestPoint(stage.stageWidth, 0)){
				switchVTAR();
			}
			else if(VTar.hitTestPoint(0, stage.stageHeight)){
				switchVTAR();
			}
			if(draghealth == 0){
				YouWin();
			}
			if(deadVill == 200){
				YouFail();
			}
		}
		
		private function KillVTAR(evt:TimerEvent):void {
			removeChild(VTar);
			timer3.removeEventListener(TimerEvent.TIMER, KillVTAR);
			VTar.x = Math.random() * stage.stageWidth;
			VTar.y = Math.random() * stage.stageHeight;
			addChild(VTar);
			VTar.VArt.gotoAndStop(Math.ceil(Math.random()*4));
			deadVill += 10;
			deadfield.text = deadVill.toString();
		}
		private function switchVTAR():void {
			removeChild(VTar);
			VTar.x = Math.random() * stage.stageWidth;
			VTar.y = Math.random() * stage.stageHeight;
			addChild(VTar);
			VTar.VArt.gotoAndStop(Math.ceil(Math.random()*4));
		}
		private function onTimer(evt:TimerEvent):void {
			
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			stage.addEventListener(MouseEvent.CLICK, createAgent);
			indicator.alpha = 1;
			
		}
		public function switchscene1(evt: TimerEvent): void {
			S.gotoAndStop(2);
			t2.start();
			t2.addEventListener(TimerEvent.TIMER, switchscene2);
		}
		public function switchscene2(evt: TimerEvent): void {
			S.gotoAndStop(3);
		}
		private function YouWin ():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			stage.removeEventListener(MouseEvent.CLICK, createAgent);
			timer2.removeEventListener(TimerEvent.TIMER, createVillager);
			M.gotoAndStop(164);
			addChild(WinScreen);
		}
		private function YouFail():void {
			while(numChildren > 0) {
				removeChildAt(0);
			}
			stage.removeEventListener(MouseEvent.CLICK, createAgent);
			timer2.removeEventListener(TimerEvent.TIMER, createVillager);
			addChild(FailScreen);
		}
		
	}
}