package game;

import flixel.FlxBasic;

/**
 * @author Sjoer van der Ploeg
 */

class ConversationLoader extends FlxBasic
{
	private var dbConnection:Database;
	private var conversation:Array<Array<String>> = new Array<Array<String>>();
	private var index:Int = 0;
	
	/**
	 * Creates a new conversation.
	 * 
	 * @param _sqlite	the database to connect to.
	 * @param _story	the story table to retreive.
	 */
	public function new(_story:String)
	{
		super();
		
		dbConnection = new Database();
		conversation = dbConnection.readStory(_story);
	}
	
	/**
	 * Returns the text for the current or entry point dialog.
	 * 
	 * @param	_index	story entry point.
	 * @return			the text to be shown in the dialog.
	 */
	public function text(?_index:Int): Array<Array<String>>
	{
		var _return:Array<Array<String>> = new Array<Array<String>>();
		
		if (_index == -1)
		{
			_return.push(["exit"]);
			
			return _return;
		}
		else if (_index != null)
		{
			index = _index - 1;
		}
		
		if (conversation[index][1] != "null")
		{
			while (conversation[index][1] != "null")
			{
				_return.push(parse(conversation[index]));
				
				next();
			}
		}
		else
		{
			_return.push(parse(conversation[index]));
			
			next();
		}
		
		if (parse(conversation[index - 1])[2] == "END") index--;
		
		return _return;
	}
	
	/**
	 * Progress to the next dialog or set an entry point.
	 * 
	 * @param _index	story entry point.
	 */
	public function next(?_index:Int)
	{
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
			_arrayFill.push(_array[1] == "null" ? null : _array[1] == "-1" ? "exit": Std.string(Std.parseInt(_array[1]) + 1));
			_arrayFill.push(_array[0]);
			_arrayFill.push(_array[2]);
		
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