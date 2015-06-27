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
	private function level(_level:Int)
	{
		switch (_level)
		{
			case 0:				FlxG.switchState(new PlayState());
			/*case 1:				FlxG.switchState(null);
			case 2:				FlxG.switchState(null);*/
			case 3:				Sys.exit(0);
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