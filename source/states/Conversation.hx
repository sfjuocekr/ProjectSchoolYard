package states;

import flixel.FlxState;
import game.ConversationLoader;
import ui.ConversationUI;
import game.Database;

/**
 * @author Sjoer van der Ploeg
 * 
 * Conversation test
 */

class Conversation extends FlxState
{
	private static var dbConnection:Database;
	private static var conversation:ConversationLoader;
	private static var conversationUI:ConversationUI;
	private static var current:Array<Array<String>>;
	
	override public function create()
	{
		super.create();
		
		loadConversation();
		
		current = conversation.text();
		
			conversationUI = new ConversationUI(conversationCallback);
			conversationUI.set(current);
		add(conversationUI);
	}
	
	private function conversationCallback(_options:Array<Int>)
	{
		current = conversation.text(_options[0]);
		
		if (current[0][1] == "player" || current[0][1] == "npc")
		{
			conversationUI.set(current, _options[1]);
		}
		
		else
		{
			var _result:Array<String> = new Array<String>();
			
			for (_element in current[0])
			{
				if (_element != null) _result.push(_element);
			}
			
			if (_result.length > 0) evaluate(_result, _options);
			else trace("YOU FAIL!");		// this should never happen!
		}
	}
	
	private function evaluate(_commands:Array<String>, _options:Array<Int>)
	{
		trace(_commands);
		switch (_commands[0])
		{
			case "conversation":
			{
				conversation = new ConversationLoader(_commands[1]);
				
				conversationCallback([1, null]);
				
				conversationUI.visible = false;
			}
			
			case "gadget":
			{
				trace("Gadget says: " + _commands[1]);
				
				conversationCallback([_options[0] + 1, _options[1]]);
				
				conversationUI.visible = false;
			}
			
			case "phone":
			{
				trace("Phone says: " + _commands[1]);
				
				conversationCallback([_options[0] + 1, _options[1]]);
				
				conversationUI.visible = false;
			}
			
			case "inventory":
			{
				trace("Adding item to inventory: " + _commands[1]);
				
				conversationCallback([_options[0] + 1, _options[1]]);
			}
			
			case "exit":
			{
				conversationCallback([1, null]);
				
				conversationUI.visible = false;
			}
		}
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