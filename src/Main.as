package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flashdevelop.utils.FlashConnect;
	
	public class Main extends Sprite {
		private const FPS:int = 60;
		
		private var timer:Timer = new Timer(1000/FPS);
		private var keys:Object = { };
		private var car:Car;
		
		private var keyFunctions:Array;
		
		public function Main() {
			if (stage) init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			timer.addEventListener(TimerEvent.TIMER, tick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			var obstacles:Vector.<Collidable> = new Vector.<Collidable>();
			obstacles.push(new Obstacle(stage, 300, 200));
			
			car = new Car(obstacles);
			centre(car);
			car.y = 750;
			stage.addChild(car);
			
			assignKeyFunctions();
			
			timer.start();
		}
		
		private function assignKeyFunctions():void {
			keyFunctions = [
				[KeyCodes.LEFT, car.turnLeft],
				[KeyCodes.UP, car.accelerate],
				[KeyCodes.RIGHT, car.turnRight],
				[KeyCodes.DOWN, car.decelerate]
			];
		}
		
		private function keyDown(e:KeyboardEvent):void {
			keys[e.keyCode] = true;
		}
		
		private function keyUp(e:KeyboardEvent):void {
			keys[e.keyCode] = false;
		}
		
		private function tick(e:TimerEvent):void {
			applyKeyFunctions();
			car.tick();
		}
		
		private function applyKeyFunctions():void {
			for each (var elem:Array in keyFunctions) {
				if (keys[elem[0]])
					elem[1]();
			}
		}
		
		private function centre(obj:DisplayObject):void {
			obj.x = stage.stageWidth / 2 - obj.width/2;
			obj.y = stage.stageHeight / 2 - obj.height/2;
		}
	}
}