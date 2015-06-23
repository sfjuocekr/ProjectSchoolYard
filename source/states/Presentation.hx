package states;

import flixel.FlxG;
import flixel.FlxState;
import game.ConversationLoader;
import ui.ActionBar;
import ui.ConversationUI;
import ui.Gadget;

/**
 * @author Sjoer van der Ploeg
 * 
 * PlayState for the presentation
 */

class Presentation extends FlxState
{
	//private var map:			// add the map
	private static var gadget:Gadget;
	private static var actionBar:ActionBar;
	private static var conversation:ConversationUI;
	
	//private var activeElement:String = "conversation";	// HACK should be map
	private var activeElement:String = "map";
	
	private static var current:Array<Array<Array<String>>>;	//ugly hack
	
	/**
	 * Create this state.
	 */
	override public function create()
	{
		super.create();
		
		StoryContainer.setup();
		
			actionBar = new ActionBar(actions);
		add(actionBar);
		
			gadget = new Gadget();
		add(gadget);
		
			conversation = new ConversationUI(conversationCallback);
		add(conversation);
		
		//hacks
		current = new Array<Array<Array<String>>>();
		
		for (_index in 0 ... StoryContainer.stories.length)
		{
			current[_index] = StoryContainer.stories[_index].text(1);
		}
		
		conversation.visible = false;
		conversation.set(current[0], 0);
		//end of hacks
	}
	
	private function actions(_action:String)
	{
		trace(_action);
		switch(_action)
		{
			case "A": activeElement = "conversation";
		}
	}
	
	private function conversationCallback(_options:Array<Int>)	// HACK [line number, story, button] should be [line number, story, button]
	{
		current[_options[1]] = StoryContainer.stories[_options[1]].text(_options[0]);
		
		if (current[_options[1]][0][1] == "player" || current[_options[1]][0][1] == "npc")
		{
			conversation.set(current[_options[1]], _options[1]);
		}
		
		else
		{
			var _result:Array<String> = new Array<String>();
			
			for (_element in current[_options[1]][0])
			{
				if (_element != null) _result.push(_element);
			}
			
			if (_result.length > 0) evaluate(_result, _options);
			else trace("YOU FAIL!");		// this should never happen!
		}
	}
	
	private function evaluate(_commands:Array<String>, _options:Array<Int>)
	{
		trace(_commands + " " + _options);
		switch (_commands[0])
		{
			case "conversation":
			{
				StoryContainer.next(_options[1], _commands[1]);
				
				conversationCallback([1, _options[1], null]);
				
				activeElement = "map";
			}
			
			case "gadget":
			{
				trace("Gadget says: " + _commands[1]);
				
				gadget.addNotification(_commands[1], conversationCallback, [_options[0] + 1, _options[1], _options[2]]);
				
				//conversationCallback([_options[0] + 1, _options[1], _options[2]]);
				
				activeElement = "map";
			}
			
			case "phone":
			{
				trace("Phone says: " + _commands[1]);
				
				conversationCallback([_options[0] + 1, _options[1], _options[2]]);
			}
			
			case "inventory":
			{
				trace("Adding item to inventory: " + _commands[1]);
				
				conversationCallback([_options[0] + 1, _options[1], _options[2]]);
			}
			
			case "exit":
			{
				conversationCallback([1, _options[1], null]);
				
				activeElement = "map";
			}
		}
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
		
		actionBar.active = !gadget.gadgetOpen;
		
		switch (activeElement)
		{
			case "map":
			{
				conversation.visible = false;
			}
			
			case "conversation":
			{
				conversation.visible = true;
			}
		}
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenuState());
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
	}
}