package game;

import flixel.FlxBasic;

/**
 * @author Sjoer van der Ploeg
 * 
 * A simple conversation loader, it will read the conversation parts from the database and load them when requested.
 */

class ConversationLoader extends FlxBasic
{
	private var dbConnection:Database;
	
	private var conversation:Array<Array<String>> = new Array<Array<String>>();
	private var index:Int = 0;
	
	private var parts:Array<String> = new Array<String>();
	private var part:Int = 0;
	
	public var current:Array<Array<String>>;
	
	/**
	 * Creates a new conversation.
	 * 
	 * @param _story	the story to retreive.
	 * @param _part		the part of the conversation to start from.
	 */
	public function new(_story:String, ?_part:String = null)
	{
		super();
		
		dbConnection = new Database();
		
		parts = dbConnection.readCaseParts(_story);
		
		part = (_part == null) ? 0 : parts.indexOf(_part);
		
		conversation = dbConnection.readStory(parts[part]);
	}
	
	/**
	 * Selects the requested part of the story to load.
	 * 
	 * @param	_part	the part of the conversation to load.
	 */
	public function nextPart(_part:String)
	{
		part = parts.indexOf(_part);
		
		index = 0;
		
		conversation = dbConnection.readStory(parts[part]);
	}
	
	/**
	 * Sets the text for the requested dialog.
	 * 
	 * @param	_index	story entry point.
	 * @return			the text to be shown in the dialog.
	 */
	public function text(?_index:Int = null)
	{
		current = new Array<Array<String>>();
		
		if (_index == 0)
			current.push(["exit"]);
		else if (_index != null)
			index = _index - 1;
		
		// makes an array with options
		if (conversation[index][1] != "null")
			while (conversation[index][1] != "null")
				next(current);
		else
			next(current);
	}
	
	/**
	 * Progress to the next dialog in the conversation.
	 * 
	 * @param	_text		the array to put the conversation into.
	 */
	private function next(_text:Array<Dynamic>)
	{
		_text.push(parse(conversation[index]));
		
		index++;
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
		parts = null;
		part = null;
		current = null;
	}
}