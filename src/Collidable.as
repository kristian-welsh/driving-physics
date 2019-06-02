package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Collidable extends Sprite {
		public function top():Number {
			return getBounds(this.parent).top;
		}
		
		public function left():Number {
			return getBounds(this.parent).left;
		}
		
		public function bottom():Number {
			return getBounds(this.parent).bottom;
		}
		
		public function right():Number {
			return getBounds(this.parent).right;
		}
	}
}