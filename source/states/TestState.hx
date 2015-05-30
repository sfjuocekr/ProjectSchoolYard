package states;

import flixel.FlxState;
import game.ConversationLoader;
import game.Database;
import ui.ActionBar;
import ui.ConversationUI;
import ui.Gadget;

/**
 * @author Sjoer van der Ploeg
 * 
 * This is where I test my shit
 */

class TestState extends FlxState
{
	private static var dbConnection:Database;
	private static var conversation:ConversationLoader;
	private static var gadget:Gadget;
	private static var actionBar:ActionBar;
	
	/**
	 * Progress to the next dialog or set an entry point.
	 */
	override public function create()
	{
		super.create();
		
		loadConversation();
		//trace(conversation.text());
		
			gadget = new Gadget();
		add(gadget);
		
			actionBar = new ActionBar(actions);
		add(actionBar);
		
		//add(new ConversationUI());
	}
	
	private function actions(_action:String)
	{
		trace(_action);
	}
	
	/**
	 * Setup the conversation.
	 */
	private function loadConversation()
	{
		dbConnection = new Database("stories");
		
		var _caseParts:Array<String> = dbConnection.readCaseParts();
			conversation = new ConversationLoader(_caseParts[0]);
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
		
		actionBar.visible = !gadget.gadgetOpen;
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