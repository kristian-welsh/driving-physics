package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class Car extends Bitmap {
		private const TURN_INCREMENT:Number = 0.05;
		private const ACCELERATION:Number = 0.05;
		private const DRAG:Number = ACCELERATION / 2;
		private const MAX_SPEED:Number = 30;
		private const MAX_REV_SPEED:Number = MAX_SPEED / 10;
		
		private var data:BitmapData;
		private var velocity:Number = 0;
		private var angle:Number = 0;
		
		public function Car(width:Number, height:Number) {
			data = new BitmapData(width, height, false, 0x555555);
			drawDot(width / 2, height*(3/4));
			super(data);
		}
		
		private function drawDot(x:Number, y:Number):void {
			var dot:Sprite = new Sprite();
			dot.graphics.beginFill(0x000000);
			dot.graphics.drawCircle(x, y, 2);
			dot.graphics.endFill();
			data.draw(dot);
		}
		
		public function accelerate():void {
			if(velocity > -MAX_SPEED)
				velocity -= ACCELERATION;
			else
				velocity = -MAX_SPEED;
		}
		
		public function decelerate():void {
			if(velocity < MAX_REV_SPEED)
				velocity += ACCELERATION;
			else
				velocity = MAX_REV_SPEED;
		}
		
		public function turnLeft():void {
			if (!colliding())
				rotate( -TURN_INCREMENT*-(velocity/10));
		}
		
		public function turnRight():void {
			if (!colliding())
				rotate(TURN_INCREMENT*-(velocity/10));
		}
		
		private function rotate(angle:Number):void {
			var rect:Rectangle = this.getBounds(this.parent);
			
			var matrix:Matrix = this.transform.matrix;
			matrix.translate( -(rect.left + (rect.width*(1/2))), -(rect.top + (rect.height*(3/4))));
			matrix.rotate(angle);
			matrix.translate( rect.left + (rect.width*(1/2)), rect.top + (rect.height*(3/4)));
			this.transform.matrix = matrix;
			
			this.angle += angle
			this.angle %= Math.PI*2;
		}
		
		private function top():Number {
			return this.getBounds(this.parent).top;
		}
		
		private function left():Number {
			return this.getBounds(this.parent).left;
		}
		
		private function bottom():Number {
			return this.getBounds(this.parent).bottom;
		}
		
		private function right():Number {
			return this.getBounds(this.parent).right;
		}
		
		public function tick():void {
			//ooh! i could handle bounces by having an array of forces being applied to the car. instead of just velocity
			updateVelocity();
			collide();
			updateposition();
		}
		
		private function collide():void {
			if (colliding()) {
				resolveCollision();
			}
		}
		
		private function resolveCollision():void {
			velocity = -velocity;
			
			if (-top() > 0)
				y = Math.abs(top()) + Math.abs(y) + 1
			if (-left() > 0)
				x = Math.abs(left()) + Math.abs(x) + 1
			if (bottom() > stage.stageHeight)
				y = stage.stageHeight - bottom() + y - 1
			if (right() > stage.stageWidth)
				x = stage.stageWidth - right() + x - 1
		}
		
		private function updateposition():void {
			x += Math.sin(-angle) * velocity;
			y += Math.cos(angle) * velocity;
		}
		
		private function updateVelocity():void {
			if (velocity < 0)
				velocity += DRAG;
			else if (velocity > 0)
				velocity -= DRAG;
			
			if ((velocity < 0 && velocity > -DRAG) || (velocity > 0 && velocity < DRAG))
				velocity = 0;
		}
		
		private function colliding():Boolean {
			if (-top() > 0)
				return true;
			if (-left() > 0)
				return true;
			if (bottom() > stage.stageHeight)
				return true;
			if (right() > stage.stageWidth)
				return true;
			return false;
		}
	}
}













































