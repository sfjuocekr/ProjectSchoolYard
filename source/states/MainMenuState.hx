package states;

import flixel.FlxG;
import flixel.FlxState;
import game.Inventory;
import ui.MenuClass;

/**
 * @author Sjoer van der Ploeg
 */

class MainMenuState extends FlxState
{
	private var menu:MenuClass = new MenuClass(FlxG.width * 0.5, FlxG.height * 0.5, 160, 32, true);
	private var inventory:Inventory = new Inventory();
	
	/**
	 * Create the main menu.
	 */
	override public function create(): Void
	{
		super.create();
		
		add(menu);
		
		menu.put("test", level.bind("test"), "assets/images/menu/Button.png", "assets/images/menu/Button.png");
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
			case "test": FlxG.switchState(new TestState());
			default: trace("yoloswag");
		}
	}
}