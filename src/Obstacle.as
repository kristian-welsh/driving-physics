package {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class Obstacle extends Collidable {
		public function Obstacle(context:DisplayObjectContainer, x:Number, y:Number, width:Number = 100, height:Number = 100) {
			context.addChild(this);
			this.x = x;
			this.y = y;
			graphics.beginFill(0xFFCCCC);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
	}
}