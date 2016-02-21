package utils
{
	import flash.geom.Point;

	public class Polygon
	{
		private var _upc:String;
		private var _price:String;
		/*private var _brandName:String;
		private var _shortName:String;
		private var _longName:String;
		private var _packageSize:String;
		private var _lowFat:String;
		private var _fatFree:String;
		private var _glutenFree:String;
		private var _price:String;
		private var _priceLabel:String;
		private var _thumbnailName:String;
		private var _why1:String;
		private var _why2:String;
		private var _why3:String;
		private var _why4:String;
		*/
		private var _pointSetList:PointSet;
		
		public function Polygon()
		{
		}
/*
		public function get brandName():String
		{
			return _brandName;
		}

		public function set brandName(value:String):void
		{
			_brandName = value;
		}

		public function get why4():String
		{
			return _why4;
		}

		public function set why4(value:String):void
		{
			_why4 = value;
		}

		public function get why3():String
		{
			return _why3;
		}

		public function set why3(value:String):void
		{
			_why3 = value;
		}

		public function get why2():String
		{
			return _why2;
		}

		public function set why2(value:String):void
		{
			_why2 = value;
		}

		public function get why1():String
		{
			return _why1;
		}

		public function set why1(value:String):void
		{
			_why1 = value;
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

		public function get glutenFree():String
		{
			return _glutenFree;
		}

		public function set glutenFree(value:String):void
		{
			_glutenFree = value;
		}

		public function get fatFree():String
		{
			return _fatFree;
		}

		public function set fatFree(value:String):void
		{
			_fatFree = value;
		}

		public function get lowFat():String
		{
			return _lowFat;
		}

		public function set lowFat(value:String):void
		{
			_lowFat = value;
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
*/
		public function get price():String
		{
			return _price;
		}
		
		public function set price(value:String):void
		{
			_price = value;
		}
		
		
		public function get upc():String
		{
			return _upc;
		}

		public function set upc(value:String):void
		{
			_upc = value;
		}

		public function get pointSetList():PointSet
		{
			return _pointSetList;
		}

		public function set pointSetList(value:PointSet):void
		{
			_pointSetList = value;
		}

		public static function pointInPolygon(pointSet:PointSet, point:Point):Boolean
		{
			var counter:int = 0;
			var i:int;
			var xinters:Number;
			var p1:Point, p2: Point;
			
			p1 = pointSet[0];
			for (i = 1; i <= pointSet.length; i++) 
			{
				p2 = pointSet[i % pointSet.length];
				if (point.y > Math.min(p1.y, p2.y)) 
				{ 
					if (point.y <= Math.max(p1.y, p2.y)) 
					{ 
						if (point.x <= Math.max(p1.x, p2.x)) 
						{ 
							if (p1.y != p2.y) 
							{ 
								xinters = (point.y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y) + p1.x;
								if (p1.x == p2.x || point.x <= xinters)	counter++;
							}
						}
					}
				}
				p1 = p2;
			}
			return (counter % 2 != 0);			
		}
	}
}