package lib.DragonDefense {
	
	import flash.display.MovieClip;
	import lib.DragonDefense.Particle;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.plugins.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Knight extends Particle {
		
		public var sinMeter:Number;
		public var bobValue:Number;
		public var status:String;
		public var timer:Timer = new Timer(3000);

		public function Knight() {
			
			status = "Charge!";
			bobValue = .1;
			sinMeter = 0;
			xVel = 0;
			yVel = 0;
			airResistance = 1;
			gravity = 0;
			gotoAndStop(Math.ceil(Math.random()*3));
		}

		public function destroy():void{
			
			gotoAndStop(4);
			gravity = 0;
			xVel = 0;
			yVel = 0;
			status = "Dead";
			TweenPlugin.activate ([TintPlugin]);
			TweenLite.to(this, 3, {alpha:0});
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
		}
		
		public override function update():void {
			
			if (status != "Dead") {
				
				yVel = Math.sin(sinMeter) * bobValue;
				
			}
			
			sinMeter += 0.1;
			super.update();
			
			if (x < 0) {
				dispatchEvent(new Event(Particle.PURGE_EVENT, true, false));
			}
		}
		
		public function onTimer(evt:TimerEvent):void {
				TweenPlugin.activate ([TintPlugin]);
				TweenLite.to(this, 1, {y:1000});
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
			
		}
	}
	
}
