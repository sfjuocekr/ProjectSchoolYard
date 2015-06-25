package states;

import flixel.FlxG;
import flixel.FlxState;
import game.ConversationLoader;
import game.StoryContainer;
import ui.MapDisplay;
import ui.ActionBar;
import ui.ConversationUI;
import ui.Gadget;

/**
 * @author Sjoer van der Ploeg
 * 
 * PlayState for the presentation
 */

class PlayState extends FlxState
{
	private var map:MapDisplay;
	private var gadget:Gadget;
	//private var actionBar:ActionBar;
	private var conversation:ConversationUI;
	
	private var stories:StoryContainer;
	
	/**
	 * Create this state.
	 */
	override public function create()
	{
		super.create();
		
		map = new MapDisplay(actions);
		//actionBar = new ActionBar(actions);
		gadget = new Gadget();
		
		stories = new StoryContainer(storyCallback);
		conversation = new ConversationUI(conversationCallback);
		
		add(map);
		//add(actionBar);
		add(gadget);
		
		// hacks
		conversation.set(stories.nextText("bully", 1), "bully");
	}
	
	public function storyCallback(_options:Array<String>)
	{
		//trace(_options);
	}
	
	public function conversationCallback(_options:Array<String>)
	{
		//trace(stories.currentText(_options[1])[0][1]);
		if (stories.currentText(_options[1])[0][1] != "player" || stories.currentText(_options[1])[0][1] != "npc")
			evaluate(stories.currentText(_options[1]), _options);
			
		switch (_options[0])
		{
			case "0":
				FUCKMYLIFE();
				conversation.set(stories.nextText(_options[1], 1), _options[1]);
				
			default:
				conversation.set(stories.nextText(_options[1], Std.parseInt(_options[0])), _options[1]);
				evaluate(stories.currentText(_options[1]), _options);
		}
	}
	
	private function evaluate(_command:Array<Array<String>>, _options:Array<String>)
	{
		//trace(_command + " " + _options);
		
		switch (_command[0][1].toLowerCase())
		{
			default: trace(_command);
			
			case "conversation":
				FUCKMYLIFE();
				//trace(_command[0][2]);
				stories.nextPart(_options[1], _command[0][2]);
				evaluate(stories.nextText(_options[1], 1), [null, _options[1]]);
			
			case "gadget":
				//trace(_command + " " + _options);
				gadget.addNotification(_command[0][2], conversationCallback, [_command[0][0], _options[1]]);
		}
	}
	
	private function FUCKMYLIFE()
	{
		remove(conversation);
		conversation.destroy();
		conversation = new ConversationUI(conversationCallback);
	}
	
	private function actions(_action:String)
	{
		switch(_action)
		{
			case "A":
				trace(stories.currentText("bully")[0][1]);
				if (stories.currentText("bully")[0][1] != "player" || stories.currentText("bully")[0][1] == "npc")
					conversation.set([["0", "player", "Ik heb niets te vertellen", "player"]], "bully");
				add(conversation);
				
			case "B": trace("B");
			case "C": trace("C");
			case "D": trace("D");
			case "E": trace("E");
		}
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
		
		//if (gadget.gadgetOpen && members.indexOf(actionBar) != -1) remove(actionBar);
		//else if (!gadget.gadgetOpen && members.indexOf(actionBar) == -1) add(actionBar);
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MenuState());
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
		
		map = null;
		gadget = null;
		conversation = null;
		stories = null;
	}
}