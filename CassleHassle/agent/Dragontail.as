package agent
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;

	public class Dragontail extends MovieClip {


		public var dragontail: Dragontail_mc = new Dragontail_mc();
		public var dragon: Dragon_mc = new Dragon_mc();
		private var dragontailWidth: Number = 76.35;
		var cycle: Number = 0;

		public function Dragontail() {
			init();
		}

		private function init(): void {
			addChild(dragon);
			addChild(dragontail);
			dragontail.x = getPin(dragon).x;
			dragontail.y = getPin(dragon).y;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);


		}

		private function onEnterFrame(event: Event): void {
			moveBody();
			cycle += .5;
		}

		public function moveBody(): void {
			var angleB: Number = Math.sin(cycle) * 15;
			dragon.rotation = angleB;
			moveTail(dragontail, cycle);
			//trace("Move body");
		}

		public function getPin(dragon): Point {

			var xPos: Number = dragon.x;
			var yPos: Number = dragon.y;
			//trace (xPos, yPos);
			return new Point(xPos, yPos);

		}

		public function moveTail(dragontail, cycle): void {
			var angleA: Number = Math.sin(cycle) * 5;
			dragontail.x = getPin(dragon).x;
			dragontail.y = getPin(dragon).y;
			dragontail.rotation = angleA;
			//trace("moveTail");
		}

	}

}