package lib.DragonDefense {
	
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import lib.DragonDefense.DragonDefense;
	
	public class DragonStart extends MovieClip {

		public function DragonStart() {
			// constructor code
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			createStartScreen();
		}
		private function createStartScreen():void {
			var startScreen:StartMenu = new StartMenu();
			
			addChild(startScreen);
			
			startScreen.StartButton.addEventListener(MouseEvent.CLICK, playIntro);
		}
		
		
		private function playIntro(evt:MouseEvent):void {
			
			var Story:Intro = new Intro();
			
			removeChild(evt.currentTarget.parent);
			
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, playIntro);
			
			addChild(Story);
			
			Story.gotoAndPlay(2);
			
			Story.PlayButton.addEventListener(MouseEvent.CLICK, startGameHandler);
		}
		
		private function startGameHandler(evt:MouseEvent):void {
			
			removeChild(evt.currentTarget.parent);
			
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);
			
			createGame();
			
		}
		
		private function createGame():void {

			var game:DragonDefense = new DragonDefense();
			
			addChild(game);
		}
		

	}
	
}
