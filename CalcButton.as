package {
	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	
	//数値や演算子が書いてあるボタン
	public class CalcButton extends MovieClip {
		//表示される数値
		private var numText:TextField;

		public function numButton(num:String):void {
			//文字の書式設定
			var numFormat:TextFormat = new TextFormat();
			numFormat.size = 25
			numText = new TextField();
			numText.text = num;
			numText.x = 5;
			numText.y = 3;
			numText.width = 30;
			numText.height = 30;
			numText.border = true;
			numText.autoSize = TextFieldAutoSize.CENTER;
			numText.textColor = 0xffffff;
			numText.background = false;
			numText.selectable = false;
			numText.border = false;
			
			numText.setTextFormat(numFormat);
			addChild(numText);
			addEventListener(MouseEvent.MOUSE_DOWN, mouse_down);
		}
		
		//ボタンが押されたときの処理
		private function mouse_down(event:MouseEvent):void {
			Calcrator.setDate(numText.text);
		}
		
	}
}