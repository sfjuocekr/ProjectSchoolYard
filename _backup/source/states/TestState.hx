package states;

import flixel.FlxState;
import game.Conversation;
import game.Database;

/**
 * @author Sjoer van der Ploeg
 * 
 * This is where I test my shit
 */

class TestState extends FlxState
{
	private static var dbConnection:Database;
	private static var conversation:Conversation;
	
	/**
	 * Progress to the next dialog or set an entry point.
	 */
	override public function create()
	{
		super.create();
		
		conversationText("cyberbully");
		
		trace(conversation.text());
	}
	
	/**
	 * Setup the conversation by case name.
	 * 
	 * @param _case	the current case.
	 */
	private function conversationText(_case:String)
	{
		dbConnection = new Database(_case);
		
		var _caseParts:Array<String> = dbConnection.readCaseParts(_case);
			conversation = new Conversation(_case, _caseParts[0]);
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
		
		dbConnection = null;
		conversation = null;
	}
}