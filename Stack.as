package {
	//スタックです　スタックって何な人はアルゴリズムの本読んでね
	public class Stack {
		//格納する値
		private var values:Array;
		//保持している値の数
		private var index:int;
		
		public function Stack() {
			values = new Array();
			index = 0;
		}
		
		public function push(val:String):void {
			values[index++] = val;
		}
		
		public function pop():String {
			return values[--index];
		}
		
		public function size():int {
			return index;
		}
	}
}