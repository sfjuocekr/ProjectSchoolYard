package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyList;
import ui.MenuClass;
import states.TestState;

/**
 * @author Sjoer van der Ploeg
 */

class MainMenuState extends FlxState
{
	//private var menu:MenuClass = new MenuClass(FlxG.width * 0.5, FlxG.height * 0.5, 160, 32, true);	
	
	private var bgSprite:FlxSprite = new FlxSprite();
	private var buttonSprite:FlxSprite = new FlxSprite();
	private var buttons:FlxSpriteGroup = new FlxSpriteGroup();
	
	/**
	 * Create the main menu.
	 */
	override public function create(): Void
	{
		super.create();
		
		//add(menu);
		//menu.put("test", level.bind("test"), "assets/images/menu/Button.png", "assets/images/menu/Button.png");
		
		add(bgSprite);
		add(buttons);
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
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
		
		if (FlxG.keys.anyPressed(["ESCAPE"])) Sys.exit(0);
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
		
		bgSprite = null;
		buttonSprite = null;
		buttons = null;
	}
}