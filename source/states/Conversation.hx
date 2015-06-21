package states;

import flixel.FlxState;
import game.ConversationLoader;
import ui.ConversationUI;
import game.Database;

/**
 * @author Sjoer van der Ploeg
 * 
 * Default playstate
 */

class Conversation extends FlxState
{
	private static var dbConnection:Database;
	private static var conversation:ConversationLoader;
	private static var conversationUI:ConversationUI;
	private static var current:Array<Array<String>>;
	
	/**
	 * Create this state.
	 */
	override public function create()
	{
		super.create();
		
		loadConversation();
		
			conversationUI = new ConversationUI(conversationCallback);
			conversationUI.set(conversation.text());
		add(conversationUI);
	}
	
	private function conversationCallback(_option:Int)
	{
		if (_option == 0) Sys.exit(0); // DIRTY HACK
		
		conversationUI.set(conversation.text(_option));
	}
	
	/**
	 * Setup the conversation.
	 */
	private function loadConversation()
	{
		dbConnection = new Database("stories");
		
		var _caseParts:Array<String> = dbConnection.readCaseParts("bully");
			conversation = new ConversationLoader(_caseParts[0]);
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
	}
}