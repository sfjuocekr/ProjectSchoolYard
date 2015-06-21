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
		
		current = conversation.text();
		
			conversationUI = new ConversationUI(conversationCallback);
			conversationUI.set(current);
		add(conversationUI);
	}
	
	private function conversationCallback(_option:Array<Int>)
	{
		current = conversation.text(_option[0]);
		
		if (current[0][0] == "exit")
		{
			conversationUI.visible = false;
			
			current[0].shift();
			current[0].pop();
			
			if (current[0].length > 0) evaluate(current[0], _option[1]);
			
			return;
		}
		
		if (current[0][1] == "gadget")
		{
			current[0].shift();
			current[0].pop();
			
			if (current[0].length > 0) evaluate(current[0], _option[1]);
			
			conversationCallback([_option[0] + 1, _option[1]]);
			
			return;
		}
		
		if (current[0][1] == "inventory")
		{
			current[0].shift();
			current[0].pop();
			
			if (current[0].length > 0) evaluate(current[0], _option[1]);
			
			conversationCallback([_option[0] + 1, _option[1]]);
			
			return;
		}
		
		conversationUI.set(current, _option[1]);
	}
	
	private function evaluate(_commands:Array<String>, _lastBtn:Int)
	{
		switch (_commands[0])
		{
			case "conversation":
				{
					conversation = new ConversationLoader(_commands[1]);
					
					conversationCallback([1, _lastBtn]);
					
					conversationUI.visible = true; // this should happen when the player talks to the npc again
				}
			
			case "gadget":
				{
					trace("Gadget says: " + _commands[1]);
					
					//make fancy stuffs
					
					conversationUI.visible = false;
				}
			
			case "inventory":
				{
					trace("Adding item to inventory: " + _commands[1]);
					
					//make fancy stuffs
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