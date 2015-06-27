package states;

import flixel.FlxG;
import flixel.FlxState;
import game.StoryContainer;
import ui.ConversationUI;
import ui.Gadget;
import ui.MapDisplay;
#if !FLX_NO_DEBUG
import ui.ActionBar;
#end

/**
 * @author Sjoer van der Ploeg
 * 
 * PlayState for the game presentation.
 */

class PlayState extends FlxState
{
	private var map:MapDisplay;
	private var gadget:Gadget;
	
	#if !FLX_NO_DEBUG
	private var actionBar:ActionBar;
	#end

	private var conversation:ConversationUI;
	private var stories:StoryContainer;
	
	/**
	 * Start the game.
	 */
	override public function create()
	{
		super.create();
		
		map = new MapDisplay(actions);
		
		#if !FLX_NO_DEBUG
		actionBar = new ActionBar(actions);
		#end
		
		gadget = new Gadget();
		stories = new StoryContainer();
		
		add(map);
		
		#if !FLX_NO_DEBUG
		add(actionBar);
		#end
		
		add(gadget);
	}
	
	/**
	 * Callback function for the conversation to influence the gameworld.
	 * 
	 * @param	_options	array containing the goto index for the conversation and the name of the story.
	 */
	public function conversationCallback(_options:Array<String>)
	{
		switch (_options[0])
		{
			case "0":
				fml();
				stories.nextText(_options[1], 1);
			
			default:
				stories.nextText(_options[1], Std.parseInt(_options[0]));
		}
		
		evaluate(stories.currentText(_options[1]), _options);
	}
	
	/**
	 * Evaluation function to perform actions based on the storyline.
	 * 
	 * @param	_command	array with the current conversation options.
	 * @param	_options	array containing the goto index for the conversation and the name of the story.
	 */
	private function evaluate(_command:Array<Array<String>>, _options:Array<String>)
	{
		switch (_command[0][1].toLowerCase())
		{
			case "conversation":
				fml();
				stories.nextPart(_options[1], _command[0][2]);
				evaluate(stories.nextText(_options[1], 1), [null, _options[1]]);
			
			case "gadget":
				gadget.addNotification(_command[0][2], conversationCallback, [_command[0][0], _options[1]]);
			
			default: conversation.set(_command, _options[1], map.getLocation());
		}
	}
	
	/**
	 * As it seems call backs stay on objects after removing them, it drove me nuts.
	 */
	private function fml()
	{
		conversation.removeButtons();
		remove(conversation);
		conversation.destroy();
		conversation = new ConversationUI(conversationCallback);
	}
	
	/**
	 * The function containing the actions to perform, also used for debugging.
	 * 
	 * @param	_action		The action to perform.
	 */
	private function actions(_action:String)
	{
		switch(_action)
		{
			case "A":
				if (conversation == null)
					conversation = new ConversationUI(conversationCallback);
				
				if (stories.currentText("bully") == null)
					conversation.set(stories.nextText("bully", 1), "bully", map.getLocation());
				else if (stories.currentText("bully")[0][1] != "player")
					conversation.set([["0", "player", "Ik heb nu niets te melden...", "player"]], "bully", map.getLocation());
				
				add(conversation);
			
			case "B":
				stories.nextPart("bully", "phone_bullyDutch");
				evaluate(stories.nextText("bully", 1), [null, "bully"]);
			
			case "C":
				
			
			case "D":
				
			
			case "E":
				
		}
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
				
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
		
		#if !FLX_NO_DEBUG
		actionBar = null;
		#end
		
		conversation = null;
		stories = null;
	}
}