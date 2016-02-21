/**
 *	FILE		: Commands.as
 *	AUTHOR		: Naveen Malhotra
 *	CREATED ON	: Jun 12, 2015
 *	DESCRIPTION	:
 *
 */

package database
{
	public class Commands
	{
		public function Commands()
		{
		}
		
		public static const CREATE_TABLE_DEVICEDATA:String = "CREATE TABLE IF NOT EXISTS devicedata(" +
			"udid TEXT)";
		
		public static const CREATE_TABLE_REWARDS:String = "CREATE TABLE IF NOT EXISTS rewards(" +
			"itemName TEXT," +
			"rewards INTEGER)";
		
		public static const CREATE_TABLE_CACHEDATA:String = "CREATE TABLE IF NOT EXISTS cachedata(" +
			"itemName TEXT," +
			"itemId Number," +
			"lat TEXT," +
			"lng TEXT," +
			"timeStamp TEXT," +
			"imagePath TEXT," +
			"macAddress TEXT," +
			"userId TEXT)";
		
		
		/* SELECT STATEMENTS */
		public static const GET_REWARDS:String = "SELECT * FROM rewards";
		public static const GET_CACHEDATA:String = "SELECT * FROM cachedata";
		public static const GET_DEVICEDATA:String = "SELECT * FROM devicedata";
		
		
		/* UPDATE STATEMENTS */
		public static const UPDATE_REWARDS:String = "UPDATE rewards SET rewards = :rewards WHERE itemName = :itemName";
		
		/* INSERT STATEMENTS */
		public static const INSERT_INITIAL_REWARDS:String = "INSERT INTO rewards SELECT 'Shampoo' as 'itemName',  0 as 'rewards' UNION SELECT 'Breakfast', 0";
		public static const INSERT_CACHEDATA:String = "INSERT INTO cachedata (itemName, itemId, lat, lng, timeStamp, userId, macAddress, imagePath) VALUES(:itemName, :itemId, :lat, :lng, :timeStamp, :userId, :macAddress, :imagePath)";
		public static const INSERT_DEVICEDATA:String = "INSERT INTO devicedata (udid) VALUES(:udid)";
		
		/* DELETE STATEMENTS */
		public static const DELETE_FROM_REWARDS:String = "DELETE FROM rewards";
		public static const DELETE_FROM_CACHEDATA:String = "DELETE FROM cachedata";
		public static const DELETE_FROM_CACHEDATA_WHERE:String = "DELETE FROM cachedata WHERE imagePath = :imagePath";
		
	}
}