package {
	import org.flashdevelop.utils.FlashConnect;
	
	public function print(obj:Object):void {
		FlashConnect.trace(obj.toString());
	}
}