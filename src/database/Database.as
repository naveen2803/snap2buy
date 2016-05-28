package database
{
	import flash.data.SQLConnection;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.utils.UIDUtil;
	
	import dto.CacheData;
	import dto.Rewards;

	public class Database extends EventDispatcher
	{
		private var dbFile:File;
		public var aConn:SQLConnection;		
		private var sqlStatementFactory:SQLStatementFactory;
		
		public static const TABLES_CREATED:String = "TABLES_CREATED";
		
		public function Database()
		{
			
		}
		
		public function getCreationDateOfDatabase():Date
		{
			var d:Date;
			if ( this.dbFile && this.dbFile.exists )
			{
				d = dbFile.creationDate;
			}
			return d;
		}
		
		public function deleteDatabase():Boolean
		{
			var success:Boolean = false;
			if ( this.dbFile ) 
			{				
				if ( this.aConn && this.aConn.connected )
				{
					this.aConn.close(null);	
				}
					
				var fs:FileStream = new FileStream();
				try 
				{
					fs.open(this.dbFile,FileMode.UPDATE);
					while ( fs.bytesAvailable )	
					{
						fs.writeByte(Math.random() * Math.pow(2,32));						
					}
					fs.close();
					this.dbFile.deleteFile();
					success = true;
				}
				catch (e:Error)
				{
					//trace(e.name + ", " + e.message );
					fs.close();
				}				
			}
			return success;
		}
		
		/**
		 * Create the asynchronous connection to the database, then create the tables
		 * 
		 * @param responder:DatabaseResponder Will dispatch result or error events when the tables are created. Dispatches an event with data TABLES_CREATED 
		 *  when all tables have been successfully created. 
		 **/
		public function init(responder:DatabaseResponder):void
		{
			var internalResponder:DatabaseResponder = new DatabaseResponder();
			internalResponder.addEventListener(DatabaseEvent.RESULT_EVENT, onResult);
			internalResponder.addEventListener(DatabaseEvent.ERROR_EVENT, onError);						
			openConnection(internalResponder);	
			
			function onResult(de:DatabaseEvent):void
			{
				internalResponder.removeEventListener(DatabaseEvent.ERROR_EVENT, onError);
				internalResponder.removeEventListener(DatabaseEvent.RESULT_EVENT, onResult);				
				createTables(responder);				
			}
			
			function onError(de:DatabaseEvent):void
			{				
				internalResponder.removeEventListener(DatabaseEvent.ERROR_EVENT, onError);
				internalResponder.removeEventListener(DatabaseEvent.RESULT_EVENT, onResult);
			}
		}
		
		private function openConnection(responder:DatabaseResponder):void
		{
			this.dbFile = File.applicationStorageDirectory.resolvePath("snap2buy.db");
			if ( !this.dbFile.exists )
			{

			}		
			
			this.aConn = new SQLConnection();
			this.aConn.addEventListener(SQLEvent.OPEN, onConnOpen);
			this.aConn.addEventListener(SQLErrorEvent.ERROR, onConnError);
			//this.aConn.openAsync(dbFile, SQLMode.CREATE, null, false, 1024, storedKey);
			this.aConn.openAsync(dbFile);
			
			function onConnOpen(se:SQLEvent):void
			{
				//trace("SQL Connection successfully opened");
				aConn.removeEventListener(SQLEvent.OPEN, onConnOpen);
				aConn.removeEventListener(SQLErrorEvent.ERROR, onConnError);					
				sqlStatementFactory = new SQLStatementFactory(aConn);					
				var de:DatabaseEvent = new DatabaseEvent(DatabaseEvent.RESULT_EVENT);
				responder.dispatchEvent(de);				
			}
			
			function onConnError(see:SQLErrorEvent):void
			{
				//trace("SQL Error while attempting to open database");
				aConn.removeEventListener(SQLEvent.OPEN, onConnOpen);
				aConn.removeEventListener(SQLErrorEvent.ERROR, onConnError);
				
				var de:DatabaseEvent = new DatabaseEvent(DatabaseEvent.ERROR_EVENT);
				responder.dispatchEvent(de);
			}
		}
		
		/**
		 * Will execute SQL that will either create the tables in a fresh database or return, if they're already creatd.
		 * TODO: Pulbic schema link
		 * Schema defined internally at https://zerowing.corp.adobe.com/display/flexmobile/SurveyApe+database+schema+and+notes
		 **/
		public function createTables(responder:DatabaseResponder):void
		{						
			createRewardsTable([responder]);				
		}

		/**
		 * Creates the tables
		 * 
		 * @param args Expects element 0 to be a DatabaseResponder.
		 **/
		private function createRewardsTable(args:Array):void
		{
			if ( args[0] is DatabaseResponder )
			{						
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.CREATE_TABLE_REWARDS, createCacheDataTable);
				sqlWrapper.statement.execute();
			}
		}
		private function createCacheDataTable(args:Array):void
		{
			if ( args[0] is DatabaseResponder )
			{						
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.CREATE_TABLE_CACHEDATA, createDeviceDataTable);
				sqlWrapper.statement.execute();
			}
		}
		private function createDeviceDataTable(args:Array):void
		{
			if ( args[0] is DatabaseResponder )
			{						
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.CREATE_TABLE_DEVICEDATA, finishedCreatingTables);
				sqlWrapper.statement.execute();
			}
		}
		
		/**
		 * Dispatches a complete event
		 * 
		 * @param args Expects element 0 to be a DatabaseResponder
		 **/
		private function finishedCreatingTables(args:Array):void
		{
			if ( args[0] is DatabaseResponder )
			{
				var de:DatabaseEvent = new DatabaseEvent(DatabaseEvent.RESULT_EVENT);
				de.data = Database.TABLES_CREATED;
				args[0].dispatchEvent(de);
			}
		}
		
		
		/**
		 * Gets Queries
		 * 
		 * @param args Expects element 0 to be a DatabaseResponder.
		 **/
		public function insertDeviceData(args:Array):void
		{
			if ( args[0] is DatabaseResponder && args[1])
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.INSERT_DEVICEDATA);
				sqlWrapper.statement.parameters[":udid"] = args[1];
				sqlWrapper.statement.execute();
			}
		}
		
		public function insertInitialData(args:Array):void
		{
			if ( args[0] is DatabaseResponder )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.INSERT_INITIAL_REWARDS);
				sqlWrapper.statement.execute();
			}
		}
		public function insertCacheData(args:Array):void
		{
			if ( args[0] is DatabaseResponder && args[1] )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.INSERT_CACHEDATA);
				var cacheData:CacheData = args[1];
				sqlWrapper.statement.parameters[":itemName"] = cacheData.itemName;
				sqlWrapper.statement.parameters[":itemId"] = cacheData.itemId;
				sqlWrapper.statement.parameters[":lat"] = cacheData.lat;
				sqlWrapper.statement.parameters[":lng"] = cacheData.lng;
				sqlWrapper.statement.parameters[":timeStamp"] = cacheData.timeStamp;
				sqlWrapper.statement.parameters[":userId"] = cacheData.userId;
				sqlWrapper.statement.parameters[":macAddress"] = cacheData.macAddress;
				sqlWrapper.statement.parameters[":imagePath"] = cacheData.imagePath;
				
				sqlWrapper.statement.execute();
			}
		}
		
		
		/**
		 * Gets Queries
		 * 
		 * @param args Expects element 0 to be a DatabaseResponder.
		 **/
		public function getDeviceData(args:Array):void
		{					
			if ( args[0] is DatabaseResponder )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.GET_DEVICEDATA);
				sqlWrapper.statement.execute();
			}
		}
		public function getRewards(args:Array):void
		{					
			if ( args[0] is DatabaseResponder )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.GET_REWARDS);
				sqlWrapper.statement.execute();
			}
		}
		public function getCacheData(args:Array):void
		{					
			if ( args[0] is DatabaseResponder )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.GET_CACHEDATA);
				sqlWrapper.statement.execute();
			}
		}

		
		/**
		 *  Insert Queries 
		 *
		 *  @param args Expects element 0 to be a DatabaseResponder.
		 * 
		 **/
		public function updateRewards(args:Array):void
		{			
			if ( args[0] is DatabaseResponder && args[1] )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.UPDATE_REWARDS);
				var objRewards:Rewards = args[1];
				sqlWrapper.statement.parameters[":itemName"] = objRewards.itemName;
				sqlWrapper.statement.parameters[":rewards"] = objRewards.rewards;
				
				sqlWrapper.statement.execute();
			}
		}
		
		
		
		
		/**
		 * DELETE OPERATIONS
		 */
		
		public function deleteFromRewards(args:Array):void
		{					
			if ( args[0] is DatabaseResponder )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.DELETE_FROM_REWARDS);
				sqlWrapper.statement.execute();
			}
		}
		public function deleteFromCacheData(args:Array):void
		{					
			if ( args[0] is DatabaseResponder )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.DELETE_FROM_CACHEDATA);
				sqlWrapper.statement.execute();
			}
		}
		
		public function deleteCachedDataWhere(args:Array):void
		{			
			if ( args[0] is DatabaseResponder && args[1] )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], Commands.DELETE_FROM_CACHEDATA_WHERE);
				var imagePath:String = args[1];
				sqlWrapper.statement.parameters[":imagePath"] = imagePath;
				
				sqlWrapper.statement.execute();
			}
		}	
		
	}
}