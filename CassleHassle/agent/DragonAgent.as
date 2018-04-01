package agent
{
	import DragonMain;
	import agent.VillagerAgent;
	import agent.states.DragonChaseState;
	//import agent.states.DragonConfusionState;
	//import agent.states.DragonFleeState;
	import agent.states.IDragonAgentState;
	import agent.states.DragonIdleState;
	import agent.states.DragonWanderState;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;

	public class DragonAgent extends Sprite
	{
		public var G:Number;
		public var H:Number;
		public var DArt:Dragontail = new Dragontail();
		private var dragontailWidth: Number = 76.35;
		private var cycle: Number = 0;
		public static const IDLE:IDragonAgentState = new DragonIdleState(); //Define possible states as static constants
		public static const CHASE:IDragonAgentState = new DragonChaseState();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IDragonAgentState; //The previous executing state
		private var _currentState:IDragonAgentState; //The currently executing state
		private var _pointer:Shape;
		public var velocity:Point = new Point();
		public var speed:Number = 0;
		
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public function DragonAgent() 
		{
			addChild(DArt);
			_currentState = IDLE; 
		}
			
		public function get canSeeA():Boolean {
			var dot:Number = G * velocity.x + H * velocity.y;
			return dot > 0;
		}
		public function get distanceToA():Number {
			var dx:Number = x - G;
			var dy:Number = y - H;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function randomDirection():void {
			var dragon:Number = Math.random() * 6.28;
			velocity.x = Math.cos(dragon);
			velocity.y = Math.sin(dragon);
		}
		public function faceA():void {
			var dx:Number = G - x;
			var dy:Number = H - y;
			var rad:Number = Math.atan2(dy, dx);
			var multiplier:Number = 1;
			velocity.x = multiplier*Math.cos(rad);
			velocity.y = multiplier*Math.sin(rad);
		}
		
		public function update(E, F):void {
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
			DArt.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
			G = E;
			H = F;
			
		}
		public function setState(newState:IDragonAgentState):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IDragonAgentState { return _previousState; }
		
		public function get currentState():IDragonAgentState { return _currentState; }
		
	}

}