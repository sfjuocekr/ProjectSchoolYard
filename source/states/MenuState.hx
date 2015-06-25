package states;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyList;
import neko.vm.Ui;
import ui.Gadget;
import ui.MainMenu;

/**
 * @author Sjoer van der Ploeg
 */

class MenuState extends FlxState
{
	private var mainMenu:MainMenu;
	
	/**
	 * Create the main menu.
	 */
	override public function create(): Void
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
			case "about":				FlxG.switchState(null);
			case "exit":				Sys.exit(0);*/
			default: trace("This is not supposed to happen!");
		}
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
		
		//if (FlxG.keys.anyJustPressed(["ESCAPE"])) Sys.exit(0);
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