package dto
{
	public class Rewards
	{
		private var _itemName:String;
		private var _rewards:int;
		
		public function Rewards()
		{
		}

		public function get rewards():int
		{
			return _rewards;
		}

		public function set rewards(value:int):void
		{
			_rewards = value;
		}

		public function get itemName():String
		{
			return _itemName;
		}

		public function set itemName(value:String):void
		{
			_itemName = value;
		}

	}
}