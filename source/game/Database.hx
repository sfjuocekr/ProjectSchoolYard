package game;

import sys.db.Connection;
import sys.db.ResultSet;
import sys.db.Sqlite;
import sys.FileSystem;

/**
 * @author Sjoer van der Ploeg
 * 
 * A simple singleton database class to retrive conversation parts.
 */

class Database
{
	private static var dbConnection:Connection;
	
	/**
	 * Open a new database.
	 * 
	 * @param _sqlite		database name under assets/data.
	 */
	public function new(?_sqlite:String)
	{
		if (dbConnection == null)
			if (FileSystem.exists("assets/" + _sqlite + "/db.sqlite"))
				dbConnection = Sqlite.open("assets/" + _sqlite + "/db.sqlite");
	}
	
	/**
	 * Reads the specified table from the conversation database.
	 * 
	 * @param	_table		name of the table.
	 * @return				an array containing the requested conversation.
	 */
	public function readStory(_table:String): Array<Array<String>>
	{
		var _request:ResultSet = dbConnection.request("SELECT * FROM " + _table);
		var _result:Array<Array<String>> = new Array<Array<String>>();
		
		for (row in _request)
		{
			var _pointer = null;
			
			if (row.pointer != null)
				_pointer = Std.parseInt(row.pointer) - 1;
			
			_result.push([row.type, Std.string(_pointer), row.text, row.name]);
		}
		
		return _result;
	}
	
	/**
	 * Retreives all the parts of a case.
	 * 
	 * @param	_case		the name of the requested case.
	 * @return				array with the available parts.
	 */
	public function readCaseParts(_case): Array<String>
	{
		var _request:ResultSet = dbConnection.request("SELECT * FROM cases");
		var _result:Array<String> = new Array<String>();
		
		var _tmp = _request.results();
		var _temp = null;
		
		for (_index in _tmp)
			if (_index.case_name == _case)
				_temp = _index;
		
		for (_index in 0 ... _temp.parts)
			switch (_index)
			{
				case 0: _result.push(_temp.part1);
				case 1: _result.push(_temp.part2);
				case 2: _result.push(_temp.part3);
				case 3: _result.push(_temp.part4);
				case 4: _result.push(_temp.part5);
			}
		
		return _result;
	}
	
	/**
	 * Reads the requested conversation part.
	 * 
	 * @param	_casePart	name of the table containing the conversation.
	 * @return				array containing the requested conversation.
	 */
	public function readCase(_casePart:String): Array<Array<String>>
	{
		var _request:ResultSet = dbConnection.request("SELECT * FROM " + _casePart);
		var _result:Array<Array<String>> = new Array<Array<String>>();
		
		for (_row in _request)
			_result.push(_row);
		
		return _result;
	}
}