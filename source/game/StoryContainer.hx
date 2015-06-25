package game;

import game.ConversationLoader;
import game.Database;

/**
 * @author Sjoer van der Ploeg
 * 
 * Static container for conversation states.
 */

class StoryContainer
{
	private var dbConnection:Database;
	//private static var inited:Bool = false;
	
	private var bully:ConversationLoader;
	
	private var callback:Dynamic->Void;
	
	public function new(_callback:Dynamic->Void)
	{
		setup();
		callback = _callback;
		
		dbConnection = new Database("stories");
		
		bully = new ConversationLoader("bullyDutch");
	}
	
	private function setup()
	{
		/*if (!inited)
		{
			dbConnection = new Database("stories");
			
			bully = new ConversationLoader("bullyDutch");
			
			inited = true;
		}*/
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
				bully.current = bully.text(_index);
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