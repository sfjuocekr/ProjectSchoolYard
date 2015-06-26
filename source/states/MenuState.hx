package states;

import flixel.FlxG;
import flixel.FlxState;
import ui.MainMenu;

/**
 * @author Sjoer van der Ploeg
 * 
 * The default main menu.
 */

class MenuState extends FlxState
{
	private var mainMenu:MainMenu;
	
	/**
	 * Create the main menu.
	 */
	override public function create()
	{
		super.create();
		
			mainMenu = new MainMenu(level);
		add(mainMenu);
	}
	
	/**
	 * Load a new state.
	 * 
	 * @param	_level		the state to load.
	 */
	private function level(_level:String)
	{
		switch (_level)
		{
			case "game":				FlxG.switchState(new PlayState());
			/*case "help":				FlxG.switchState(null);
			case "about":				FlxG.switchState(null);*/
			case "exit":				Sys.exit(0);
			default: trace("This is not supposed to happen!");
		}
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
		
		if (FlxG.keys.justPressed.ESCAPE) Sys.exit(0);
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
		
		mainMenu = null;
	}
}