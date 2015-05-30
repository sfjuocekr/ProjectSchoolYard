package game;

import flixel.FlxBasic;
import sys.db.Connection;
import sys.db.ResultSet;
import sys.db.Sqlite;
import sys.FileSystem;

/**
 * @author Sjoer van der Ploeg
 */

class Database extends FlxBasic
{
	private static var dbConnection:Connection;
	
	/**
	 * Open a new database.
	 * 
	 * @param _sqlite	database name under assets/data.
	 */
	public function new(_sqlite:String)
	{
		super();
		
		if (dbConnection == null)
			if (FileSystem.exists("assets/data/" + _sqlite + ".sqlite"))
			{
				dbConnection = Sqlite.open("assets/data/" + _sqlite + ".sqlite");
			}
	}
	
	/**
	 * Read the specified table from the story database.
	 * 
	 * @param	_sqlite		name of the table containing the story.
	 * @return				an array containing the requested story.
	 */
	public function readStory(_table:String): Array<Array<String>>
	{
		var _request:ResultSet = dbConnection.request("SELECT * FROM " + _table);
		var _result:Array<Array<String>> = new Array<Array<String>>();
		
		for (row in _request)
		{
			var _pointer = null;
			
			if (row.pointer != null) _pointer = Std.parseInt(row.pointer) - 1;
			
			_result.push([row.type, Std.string(_pointer), row.text]);
		}
		
		return _result;
	}
	
	/**
	 * Retreive all the parts of a case.
	 * 
	 * @param	_case		the name of the requested case.
	 * @return				an array of the available parts.
	 */
	public function readCaseParts(_case:String): Array<String>
	{
		var _request:ResultSet = dbConnection.request("SELECT * FROM cases");
		var _result:Array<String> = new Array<String>();
		
		var _temp = _request.results().pop();
		
		for (_index in 0 ... _temp.parts)
		{
			switch (_index)
			{
				case 0: _result.push(_temp.part1);
				case 1: _result.push(_temp.part2);
				case 2: _result.push(_temp.part3);
				case 3: _result.push(_temp.part4);
				case 4: _result.push(_temp.part5);
			}
		}
		
		return _result;
	}
	
	/**
	 * Read the requested case story.
	 * 
	 * @param	_sqlite		database name under assets/data.
	 * @return				an array containing the requested case.
	 */
	public function readCase(_casePart:String): Array<Array<String>>
	{
		var _request:ResultSet = dbConnection.request("SELECT * FROM " + _casePart);
		var _result:Array<Array<String>> = new Array<Array<String>>();
		
		for (_row in _request)
		{
			_result.push(_row);
		}
		
		return _result;
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
		
		dbConnection = null;
	}
}