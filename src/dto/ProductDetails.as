package dto
{
	[Bindable]
	public class ProductDetails
	{
		private var _upc:String = "";
		private var _brandName:String = "";
		private var _shortName:String = "";
		private var _longName:String = "";
		private var _packageSize:String = "";
		private var _attribute_1:String = "";
		private var _attribute_2:String = "";
		private var _attribute_3:String = "";
		private var _attribute_4:String = "";
		private var _attribute_5:String = "";
		private var _price:String = "";
		private var _priceLabel:String = "";
		private var _thumbnailName:String = "";
		private var _rating:Number = 1;
		private var _why_buy_1:String = "";
		private var _why_buy_2:String = "";
		private var _why_buy_3:String = "";
		private var _why_buy_4:String = "";
		
		
		public function ProductDetails()
		{
		}
		
		public function get attribute_5():String
		{
			return _attribute_5;
		}

		public function set attribute_5(value:String):void
		{
			_attribute_5 = value;
		}

		public function get attribute_4():String
		{
			return _attribute_4;
		}

		public function set attribute_4(value:String):void
		{
			_attribute_4 = value;
		}

		public function get brandName():String
		{
			return _brandName;
		}
		
		public function set brandName(value:String):void
		{
			_brandName = value;
		}
		
		public function get why_buy_4():String
		{
			return _why_buy_4;
		}
		
		public function set why_buy_4(value:String):void
		{
			_why_buy_4 = value;
		}
		
		public function get why_buy_3():String
		{
			return _why_buy_3;
		}
		
		public function set why_buy_3(value:String):void
		{
			_why_buy_3 = value;
		}
		
		public function get why_buy_2():String
		{
			return _why_buy_2;
		}
		
		public function set why_buy_2(value:String):void
		{
			_why_buy_2 = value;
		}
		
		public function get why_buy_1():String
		{
			return _why_buy_1;
		}
		
		public function set why_buy_1(value:String):void
		{
			_why_buy_1 = value;
		}
		
		public function get rating():Number
		{
			return _rating;
		}
		
		public function set rating(value:Number):void
		{
			_rating = value;
		}
		
		public function get thumbnailName():String
		{
			return _thumbnailName;
		}
		
		public function set thumbnailName(value:String):void
		{
			_thumbnailName = value;
		}
		
		public function get priceLabel():String
		{
			return _priceLabel;
		}
		
		public function set priceLabel(value:String):void
		{
			_priceLabel = value;
		}
		
		public function get price():String
		{
			return _price;
		}
		
		public function set price(value:String):void
		{
			_price = value;
		}
		
		public function get attribute_3():String
		{
			return _attribute_3;
		}
		
		public function set attribute_3(value:String):void
		{
			_attribute_3 = value;
		}
		
		public function get attribute_2():String
		{
			return _attribute_2;
		}
		
		public function set attribute_2(value:String):void
		{
			_attribute_2 = value;
		}
		
		public function get attribute_1():String
		{
			return _attribute_1;
		}
		
		public function set attribute_1(value:String):void
		{
			_attribute_1 = value;
		}
		
		public function get packageSize():String
		{
			return _packageSize;
		}
		
		public function set packageSize(value:String):void
		{
			_packageSize = value;
		}
		
		public function get longName():String
		{
			return _longName;
		}
		
		public function set longName(value:String):void
		{
			_longName = value;
		}
		
		public function get shortName():String
		{
			return _shortName;
		}
		
		public function set shortName(value:String):void
		{
			_shortName = value;
		}
		
		public function get upc():String
		{
			return _upc;
		}
		
		public function set upc(value:String):void
		{
			_upc = value;
		}
	}
}