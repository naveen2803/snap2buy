package dto
{
	public class CacheData
	{
		private var _itemName:String;
		private var _itemId:Number;
		private var _lat:String;
		private var _lng:String;
		private var _timeStamp:String;
		private var _userId:String;
		private var _imagePath:String;
		private var _macAddress:String;
		
		public function CacheData()
		{
		}

		public function get macAddress():String
		{
			return _macAddress;
		}

		public function set macAddress(value:String):void
		{
			_macAddress = value;
		}

		public function get imagePath():String
		{
			return _imagePath;
		}

		public function set imagePath(value:String):void
		{
			_imagePath = value;
		}

		public function get userId():String
		{
			return _userId;
		}

		public function set userId(value:String):void
		{
			_userId = value;
		}

		public function get timeStamp():String
		{
			return _timeStamp;
		}

		public function set timeStamp(value:String):void
		{
			_timeStamp = value;
		}

		public function get lng():String
		{
			return _lng;
		}

		public function set lng(value:String):void
		{
			_lng = value;
		}

		public function get lat():String
		{
			return _lat;
		}

		public function set lat(value:String):void
		{
			_lat = value;
		}

		public function get itemId():Number
		{
			return _itemId;
		}

		public function set itemId(value:Number):void
		{
			_itemId = value;
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