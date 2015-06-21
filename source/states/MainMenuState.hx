package states;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyList;
import ui.MainMenu;
import ui.MenuClass;
import states.TestState;
import states.SchoolYard;
import states.Conversation;

/**
 * @author Sjoer van der Ploeg
 */

class MainMenuState extends FlxState
{
	public static var mainMenuState:FlxState;
	private static var mainMenu:MainMenu;
	
	/**
	 * Create the main menu.
	 */
	override public function create(): Void
	{
		super.create();
		
		if (mainMenuState == null)
		{
			mainMenuState = this;
			
				mainMenu = new MainMenu(level);
			add(mainMenu);
		}
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
			case "test":	FlxG.switchState(new TestState());
			case "help":	FlxG.switchState(new SchoolYard());
			case "about":	FlxG.switchState(new Conversation());
			case "exit":	Sys.exit(0);
			default:		trace("This is not supposed to happen!");
		}
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
		
		if (FlxG.keys.anyJustPressed(["ESCAPE"])) Sys.exit(0);
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
		
		mainMenuState = null;
		mainMenu = null;
	}
}