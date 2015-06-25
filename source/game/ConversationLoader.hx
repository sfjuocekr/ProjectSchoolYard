package game;

import flixel.FlxBasic;

/**
 * @author Sjoer van der Ploeg
 */

class ConversationLoader extends FlxBasic
{
	private var dbConnection:Database;
	
	private var conversation:Array<Array<String>> = new Array<Array<String>>();
	private var parts:Array<String> = new Array<String>();
	
	private var part:Int = 0;
	private var index:Int = 0;
	
	public var current:Array<Array<String>>;
	
	/**
	 * Creates a new conversation.
	 * 
	 * @param _story	the story to retreive.
	 * @param _part		the part to start from.
	 */
	public function new(_story:String, ?_part:Int = 0)
	{
		super();
		
		dbConnection = new Database();
		
		part = _part;
		
		parts = dbConnection.readCaseParts(_story);
		conversation = dbConnection.readStory(parts[part]);
	}
	
	public function nextPart(_part:String)
	{
		part = parts.indexOf(_part);
		trace(part);
		index = 0;
		
		conversation = dbConnection.readStory(parts[part]);
	}
	
	/**
	 * Returns the text for the current or entry point dialog.
	 * 
	 * @param	_index	story entry point.
	 * @return			the text to be shown in the dialog.
	 */
	public function text(?_index:Int = null): Array<Array<String>>
	{
		//trace(_index);
		var _return:Array<Array<String>> = new Array<Array<String>>();
		
		if (_index == 0)
		{
			_return.push(["exit"]);
			
			return _return;
		}
		
		else if (_index != null)
		{
			index = _index - 1;
		}
		
		if (conversation[index][1] == "-1")
		{
			next(_return);
			
			_return[0][0] = "exit";
			trace("HALP");
			return _return;
		}
		
		if (conversation[index][1] != "null") while (conversation[index][1] != "null") next(_return);
		else next(_return);
		
		return _return;
	}
	
	/**
	 * Progress to the next dialog or set an entry point.
	 * 
	 * @param _index	story entry point.
	 */
	private function next(_text:Array<Dynamic> , ?_index:Int)
	{
		_text.push(parse(conversation[index]));
		
		if (_index != null) index = _index;
		else index++;
	}
	
	/**
	 * Translate the database to something "readable".
	 * 
	 * @param	_array	the conversation array as retreived from the database.
	 * @return			the modfied array.
	 */
	private function parse(_array:Array<String>): Array<String>
	{
		var _arrayFill:Array<String> = new Array<String>();
			_arrayFill.push(_array[1] == "null" ? null : Std.string(Std.parseInt(_array[1]) + 1));
			_arrayFill.push(_array[0]);
			_arrayFill.push(_array[2]);
			_arrayFill.push(_array[3]);
		
		return _arrayFill;
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
		
		dbConnection = null;
		conversation = null;
		index = null;
	}
}