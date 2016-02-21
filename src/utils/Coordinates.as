/**
 *	FILE		: Coordinates.as
 *	AUTHOR		: Naveen Malhotra
 *	CREATED ON	: May 26, 2015
 *	DESCRIPTION	:
 *
 */

package utils
{
	public class Coordinates
	{
		private var _xCoordinate:int;
		private var _yCoordinate:int;
		private var _locationName:String;
		
		public function Coordinates()
		{
		}

		public function get locationName():String
		{
			return _locationName;
		}

		public function set locationName(value:String):void
		{
			_locationName = value;
		}

		public function get yCoordinate():int
		{
			return _yCoordinate;
		}

		public function set yCoordinate(value:int):void
		{
			_yCoordinate = value;
		}

		public function get xCoordinate():int
		{
			return _xCoordinate;
		}

		public function set xCoordinate(value:int):void
		{
			_xCoordinate = value;
		}

	}
}