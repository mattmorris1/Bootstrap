package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import DragonMain;
	
	public class CassleHassleDoc extends MovieClip {
		public var titlescreen:TitleScreen_mc = new TitleScreen_mc();
		public var howtoplaybtn:HowtoPlay_btn = new HowtoPlay_btn();
		public var howtoplay:howtoplayscreen_mc = new howtoplayscreen_mc();
		public var playbtn:theplay_btn = new theplay_btn();

		public function CassleHassleDoc() {
			// constructor code
			CreateStartMenu();
			
			
		}
		public function CreateStartMenu ():void {
			
			addChild(titlescreen);
			titlescreen.howtoplay.addEventListener(MouseEvent.CLICK, HowToPlayScreen);
			titlescreen.theplay_btn1.addEventListener(MouseEvent.CLICK, startGameHandler);
		}
		public function HowToPlayScreen (evt:MouseEvent):void {
			removeChild(titlescreen);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, HowToPlayScreen);
			addChild(howtoplay);
			howtoplay.playbtn_2.addEventListener(MouseEvent.CLICK, startGameHandler);
		}
		public function startGameHandler(evt: MouseEvent): void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);

			createGame();
		}
		public function createGame(): void {

			var game: DragonMain = new DragonMain();

			addChild (game);
		}
		

	}
	
}

	

