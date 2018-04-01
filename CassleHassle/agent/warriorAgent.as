package agent 
{
	import agent.states.AttackState;
	import agent.states.SearchState;
	import agent.states.IWarriorAgentState;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	public class warriorAgent extends Sprite {
		public static const ATTACK:IWarriorAgentState = new AttackState();
		public static const SEARCH:IWarriorAgentState = new SearchState();

		public var wArt:warriors_mc = new warriors_mc();
		public var WSound: WarriorSound_MC = new WarriorSound_MC();
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _currentState:IWarriorAgentState; //The currently executing state
		private var _pointer:Shape;
		private var _tf:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0;
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public var C:Number;
		public var D:Number;
		
		public var E:Number;
		public var F:Number;
		public var chaseRadius:Number = 5000;
		public function warriorAgent() 
		{
			addChild(wArt);
			wArt.gotoAndStop(Math.ceil(Math.random()*8));
			WSound.gotoAndStop(1);
			_currentState = SEARCH; //search
			
		}

		public function get canSeeMouse():Boolean {
			var dot:Number = C * velocity.x + D * velocity.y;
			return dot > 0;
		}
		public function get distanceToMouse():Number {
			var dx:Number = x - C;
			var dy:Number = y - D;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function randomDirection():void {
			var a:Number = Math.random() * 6.28;
			velocity.x = Math.cos(a);
			velocity.y = Math.sin(a);
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = C - x;
			var dy:Number = D - y;
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
			wArt.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
			
			C = dragon.x;
			D = dragon.y;
			
			E = this.x;
			F = this.y;
			
		}
		public function setState(newState:IWarriorAgentState):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		
		public function get currentState():IWarriorAgentState { return _currentState; }
		
	}

}