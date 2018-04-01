package agent 
{
	import DragonMain;
	import agent.states.FleeStateV;
	import agent.states.IAgentStateV;
	import agent.states.panicStateV;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class VillagerAgent extends Sprite
	{
		public static const PANIC:IAgentStateV = new panicStateV();
		public static const FLEE:IAgentStateV = new FleeStateV();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IAgentStateV; //The previous executing state
		private var _currentState:IAgentStateV; //The currently executing state
		public var velocity:Point = new Point();
		public var speed:Number = 0;
		
		public var D:Number;
		public var E:Number;
		
		public var fleeRadius:Number = 75; //If the mouse is "seen" within this radius, we want to flee
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public var VArt:MovieClip;
		public var Vtimer:Timer = new Timer(1000);

		public function VillagerAgent() 
		{
			VArt = new villagers_mc;
			addChild(VArt);
			VArt.gotoAndStop(Math.ceil(Math.random()*4));
			
			_currentState = FLEE; //Set the initial state
		}
		public function get canSeeMouse():Boolean {
			var dot:Number = D * velocity.x + E * velocity.y;
			return dot > 0;
		}
		public function get distanceToMouse():Number {
			var dx:Number = x - D;
			var dy:Number = y - E;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function randomDirection():void {
			var a:Number = Math.random() * 6.28;
			velocity.x = Math.cos(a);
			velocity.y = Math.sin(a);
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = D - x;
			var dy:Number = E - y;
			var rad:Number = Math.atan2(dy, dx);
			velocity.x = multiplier*Math.cos(rad);
			velocity.y = multiplier*Math.sin(rad);
		}
		
		public function update(dragon):void {
			if (!_currentState) return; //If there's no behavior, we do nothing
			numCycles++; 
			_currentState.update(this);
			x += velocity.x*speed;
			y += velocity.y*speed;
			if (x + velocity.x > stage.stageWidth || x + velocity.x < 0) {
				x = Math.max(0, Math.min(stage.stageWidth, x));
				velocity.x *= -1;
			}
			if (y + velocity.y > stage.stageHeight || y + velocity.y < 0) {
				y = Math.max(0, Math.min(stage.stageHeight, y));
				velocity.y *= -1;
			}
			VArt.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
			
			D = dragon.x;
			E = dragon.y;
		}
		public function setState(newState:IAgentStateV):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IAgentStateV { return _previousState; }
		
		public function get currentState():IAgentStateV { return _currentState; }
		
		public function killtimer() {
			Vtimer.start();
		}
		
	}

}