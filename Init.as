package {
	import flash.display.MovieClip;
	import flash.text.TextField;

	//ボタン配置などの初期化処理と数式や計算結果を格納するテキストフィールドの値を設定する
	public class Init extends MovieClip{
		//配置するボタン
		private var buttons:Array;
		//数式や計算結果を格納するテキストフィールド
		private static var dentaku:TextField;

		public function Init() {
			//数式や計算結果を格納するテキストフィールドの配置			
			dentaku = new TextField();
			dentaku.x = 13;
			dentaku.y = 50;
			dentaku.width = 193;
			dentaku.height = 30;
			dentaku.background = true;
			dentaku.backgroundColor = 0xffffff;
			dentaku.border = true;
			dentaku.borderColor = 0xff0000;
			
			stage.addChild(dentaku);
			
			//ボタンの配置
			buttons = new Array();
			var i:int, n:int;
			for(i = 1, n = 0; i < 10;i++) {
				buttons[i] = new CalcButton();
				buttons[i].numButton(i.toString(10));
				buttons[i].x = 50 * (i - n * 3) - (50 - 13);
				buttons[i].y = 200 + 50 * -n;
				stage.addChild(buttons[i]);
				if(i % 3 == 0) {
					n++;
				}
			}
			
			buttons[0] = new CalcButton();
			buttons[0].numButton("0");
			buttons[0].x = 13;
			buttons[0].y = 250;
			stage.addChild(buttons[0]);
			
			buttons[10] = new CalcButton();
			buttons[10].numButton("+");
			buttons[10].x = 163;
			buttons[10].y = 100;
			stage.addChild(buttons[10]);
			
			buttons[11] = new CalcButton();
			buttons[11].numButton("-");
			buttons[11].x = 163;
			buttons[11].y = 150;
			stage.addChild(buttons[11]);
			
			buttons[12] = new CalcButton();
			buttons[12].numButton("×");
			buttons[12].x = 163;
			buttons[12].y = 200;
			stage.addChild(buttons[12]);
			
			buttons[13] = new CalcButton();
			buttons[13].numButton("÷");
			buttons[13].x = 163;
			buttons[13].y = 250;
			stage.addChild(buttons[13]);
			
			buttons[14] = new CalcButton();
			buttons[14].numButton("=");
			buttons[14].x = 113;
			buttons[14].y = 250;
			stage.addChild(buttons[14]);
			
			buttons[15] = new CalcButton();
			buttons[15].numButton("AC");
			buttons[15].x = 63;
			buttons[15].y = 250;
			stage.addChild(buttons[15]);
		}
		
		//数式や計算結果を格納するテキストフィールドの値設定
		public static function setDentaku(str:String) {
			dentaku.text = str;
		}
			
	}
}