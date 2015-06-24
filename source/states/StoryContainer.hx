package states;

import game.ConversationLoader;
import game.Database;

/**
 * @author Sjoer van der Ploeg
 * 
 * Static container for conversation states.
 */

class StoryContainer
{
	private static var dbConnection:Database;
	
	private static var inited:Bool = false;
	
	private static var bully_story:ConversationLoader;
	private static var bully_parts:Array<String>;
	private static var bully_index:Int;
	private static var bully_current:Array<Array<String>>;
	
	public static var stories:Array<ConversationLoader>;
	
	private function new()
	{
		setup();
	}
	
	public static function setup()
	{
		if (!inited)
		{
			dbConnection = new Database("stories");
			
			stories = new Array<ConversationLoader>();
			
			bully_parts = dbConnection.readCaseParts("bully");
			
			bully_index = 0;		// hack no savegame support yet
			
			stories.push(new ConversationLoader(bully_parts[bully_index]));
			
			inited = true;
		}
	}
	
	public static function next(_story:Int, _part:String)
	{
		if (!inited) setup();
		
		stories[_story] = new ConversationLoader(_part);
	}
	
	public function text(_story:String, ?_index:Int = null): Array<Array<String>>		// hack make stories private and use this function to get text
	{
		if (!inited) setup();
		
		switch (_story)
		{
			case "bully":
			{
				return bully_story.text(_index);
			}
		}
		
		return null;
	}
}