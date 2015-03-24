package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.globalization.Collator;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Dany
	 */
	public class Main extends Sprite 
	{
		private var right:Boolean;
		private var left:Boolean;
		private var monster:Sprite;
		private var speed:Number = 0;
		private var aceleracion:Number = 0.3
		private var maxSpeed:Number = 2;
		private var friccion: Number = 0.92;
		private var _monster:Monster;
		private var current:int;
		private var elapsed:Number=0;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
	
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Downloader.load("assets.swf",goGame);
		}
		
		private function goGame():void {
			_monster = new Monster();
			current = getTimer();
			addChild(_monster);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, down);
			stage.addEventListener(KeyboardEvent.KEY_UP, up);
			stage.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function onTimer():void
		{
			var m:Monster2 = new Monster2();
			addChild(m);
			m.x = Math.random() * stage.stageWidth;
		}
		
		private function loop(e:Event):void 
		{
			var dt:Number = (getTimer() -current)*0.001;
			current = getTimer();
			elapsed += dt;
			trace(elapsed);
			if (elapsed >= 1) {
				onTimer();
				elapsed = 0;
				
			}
			if (left) {
				speed -= aceleracion;
				if (speed < -maxSpeed) {
					speed = -maxSpeed;
				}
			}
			
			if (right) {
				speed += aceleracion;
				if(speed>maxSpeed){
				speed = maxSpeed;
				}
			}
			
			speed *= friccion;
			_monster.x += speed;
			
			if (_monster.x < 0) {
				_monster.x=0
			}
			if (_monster.x > stage.stageWidth - _monster.width) {
				_monster.x = stage.stageWidth - _monster.width;
			}
			
			
		}
		
		private function down(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.LEFT:
					left = true;
				break;
			case Keyboard.RIGHT:
				right = true;
				break;
			}
		}
		
		private function up(e:KeyboardEvent):void
		{
			switch(e.keyCode) 
			{
				case Keyboard.LEFT:
					left = false;
				break;
			case Keyboard.RIGHT:
				right = false;
				break;
			}
		}
	}
}