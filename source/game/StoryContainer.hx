package game;

import game.ConversationLoader;
import game.Database;

/**
 * @author Sjoer van der Ploeg
 * 
 * Static container for conversations.
 */

class StoryContainer
{
	private static var dbConnection:Database;
	private static var bully:ConversationLoader;
	
	private static var inited:Bool = false;
	
	/**
	 * Setup the singleton.
	 */
	public function new()
	{
		if (!inited)
		{
			dbConnection = new Database("stories");
			
			bully = new ConversationLoader("bullyDutch");
			
			inited = true;
		}
	}
	
	public function nextPart(_story:String, _part:String)
	{	
		switch (_story)
		{
			case "bully": bully.nextPart(_part);
		}
	}
	
	public function nextText(_story:String, ?_index:Int = null): Array<Array<String>>
	{
		switch (_story)
		{
			case "bully":
				bully.text(_index);
				
				return bully.current;
			
			default: return null;
		}
	}
	
	public function currentText(_story:String): Array<Array<String>>
	{
		switch (_story)
		{
			case "bully":
				return bully.current;
			
			default: return null;
		}
	}
}