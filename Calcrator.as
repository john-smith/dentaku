package {
	
	//主に数値が入力されたときや計算するときの処理が書いてある
	public class Calcrator {
		//数式
		private static var date:String = "";
		
		//以前に入力した文字列
		private static var old_value:String = "";
		
		public static function reset() {
			date = "";
			old_value = "";
		}
		
		//数式の設定
		public static function setDate(str:String) {
			//演算子を二回押した場合か、演算子直後の 0 は無視する
			if(isOperator(old_value) && (isOperator(str) || str == "0")) {
				return;	
			}
			
			//数式に何も無い常態で 0 や 演算子を入力した場合は無視
			if(date == "" && (isOperator(str) || str == "0")) {
				return;
			}
			
			//AC が押された場合は数式をクリア、　=　が押された場合は計算する
			if(str == "AC") {
				Calcrator.reset();
				Init.setDentaku("");
				return;
			} else if(str == "=") {
				trace(date);
				clac();
				return;
			}
			
			//数式は最大２５文字まで
			if(date.split(" ").join("").length >= 25) {
				return;
			}
			
			//最後の文字に演算子は入らない
			if(date.split(" ").join("").length == 24 && isOperator(str)) {
				return;
			}

			//演算子の前後は空白入れとく(配列にするとき用)
			if(isOperator(str) || isOperator(old_value)) {
				date += " ";
			}
			
			//入力された文字を数式に追加し、以前の文字の入力を更新
			date += str;
			old_value = str;

			//計算を行う
			Init.setDentaku(date.split(" ").join(""));
			
		}
		
		//数式を逆ポーランド形式に変換する
		public static function clac():void {
			//変換する数式
			var expension:Array = date.split(" ");
			
			//逆ポーランド化した数式
			var porland:Array = new Array();
			
			//変換時に一時的に演算子を格納
			var operator:Array = new Array();
			
			//各種ループ変数及びインデックス
			var i:int, j:int, n:int = 0, m:int = 0;

			//数式の変換
			for(i = 0;i < expension.length;i++) {
				/*より優先度の高い演算子を追加する場合
				
					for(j = operator.length-1; operatpr[j] != (優先度の低い演算子);j--) {
						porland[n++] = operator[j];
						m--;
					}
					operator[m++] = operator[i];
				
				を
				
					else if(expoension[i] == (優先度の高い演算子))
					
				の中に追加する
				ただし優先度の高い演算子ほど先に記述しなければならない
				と、思う。やってみて上手くいかなくてもおいら保障しないよ
				*/

				/*
				優先度の設定
				高
				↑	× ÷

				↓	+ -
				低
				*/
				
				if(!isOperator(expension[i])) {		//数値の場合はそのまま
					porland[n++] = expension[i];
				} else if(operator.length == 0) {	//スタックが空の場合はそのまま
					operator[m++] = expension[i];
				} else if(expension[i] == "×" || expension[i] == "÷") {
					operator[m++] = expension[i];
				} else {
					for(j = operator.length - 1;j>= 0;j--) {
						porland[n++] = operator[j];
						m--;
					}
					operator[m++] = expension[i];
				}
			}

			//残った演算子を末尾に追加して逆ポーランドの数式を完成させる
			for(i = operator.length - 1;i >= 0;i--) {
				porland[n++] = operator[i];
			}
			
			trace(porland.join(" "));
			
			//計算のための一時変数
			var stack:Stack = new Stack();
			
			//逆ポーランド化した数式を計算する
			//計算する際にオペランドの位置が関係ある場合は一度変数に入れてから計算する
			for(i = 0;i < porland.length;i++) {
				switch(porland[i]) {
					case "+" : 
						stack.push((parseFloat(stack.pop()) + parseFloat(stack.pop())).toString());
						break;
					case "-" :
						var wakai2:Number = parseFloat(stack.pop());
						var wakai1:Number = parseFloat(stack.pop());
						
						stack.push((wakai1 - wakai2).toString());
						break;
					case "×" :
						stack.push((parseFloat(stack.pop()) * parseFloat(stack.pop())).toString());
						break;
					case "÷" : 
						var wakai4:Number = parseFloat(stack.pop());
						var wakai3:Number = parseFloat(stack.pop());
						var wakai5:String = (wakai3 / wakai4).toString();
						
						//有効桁数を設定 小数点以下は５桁まで　ここはいじらないほうが身のためかも
						var wakai6:String = "";
						if(wakai5.indexOf(".") != -1) {
							wakai6 = wakai5.substr(wakai5.indexOf(".") + 1);
						}
						if(wakai6.length >= 6) {
							if(parseInt(wakai6.substr(6, 1)) >= 5) {
								var wakai7:Number = parseInt(wakai6.substr(5, 1)) + 1;
								wakai6 = wakai6.substr(0, 4) + wakai7;
							} else {
								wakai6 = wakai6.substr(0, 5);
							}
							wakai5 = wakai5.substr(0, wakai5.indexOf(".") + 1) + wakai6;
						}
						
						stack.push(wakai5);
						break;
					default :
						stack.push(porland[i]);
						break;
				}
			}
			
			//演算結果を格納		
			var ans:String = stack.pop();
			
			//桁が多すぎたらエラー
			if(ans.indexOf("e") != -1) {
				ans = "桁数多すぎ＼(^o^)／ｵﾜﾀ";
			}
			trace(ans);
			
			//結果を表示
			Init.setDentaku(ans);
			reset();
		}
		
		//演算子かを判断
		private static function isOperator(str:String):Boolean {
			if(str == "+" || str == "-" || str == "×" || str == "÷" || str == "=") {
				return true;
			}
			
			return false;
		}
	}
}