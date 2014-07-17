package
{
	import flash.display.MovieClip;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.media.*;
	import flash.filesystem.*;
	import flash.system.*;
	
	public class Main extends MovieClip
	{
		public var webView:StageWebView = new StageWebView();

		//
		// コンストラクタ
		//
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE , handleLoad);
		}
		
		//
		// nend広告を表示する
		//
		public function handleLoad(e:Event):void
		{
			var os:String = flash.system.Capabilities.os;
			var path:String;
			var filePath:String = "/assets/nend.html";

			// 広告サイズ
			var width:Number = 360;
			var height:Number = 50;

			// WebView設定
			webView.stage = this.stage;
			webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChanging);
			webView.viewPort = new Rectangle(0, 0, width, height);
			
			if (os.indexOf("iPhone") != -1) {
				// iPhone
				path = new File(new File("app:"+filePath).nativePath).url;
			}else {
				// Android
				path = "file:///android_asset"+filePath;
			}
			webView.loadURL(path);
		}

		//
		// 広告がクリックされた
		//
		public function onLocationChanging(e:LocationChangeEvent):void
		{
			// アドレス変更をキャンセル
			e.preventDefault();

			// ブラウザ起動
			navigateToURL(new URLRequest(e.location));
		}
	}
}
