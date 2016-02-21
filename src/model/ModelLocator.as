/**
 *	FILE		: ModelLocator.as
 *	AUTHOR		: Naveen Malhotra
 *	CREATED ON	: Oct 22, 2014
 *	DESCRIPTION	:
 *
 */

package model
{
	import database.Database;

	public class ModelLocator
	{
		public static var inst:ModelLocator;		
		
		public var db:Database; 		
		
		public function ModelLocator()
		{			
		}
		
		public static function getInstance():ModelLocator
		{
			if ( !inst )
			{
				inst = new ModelLocator();
			}
			return inst;
		}
	}
}