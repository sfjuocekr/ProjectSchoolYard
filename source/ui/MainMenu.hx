package ui;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * @author Sjoer van der Ploeg
 */

class MainMenu extends FlxSpriteGroup
{
	private var bgSprite:FlxSprite = new FlxSprite(0, 0, "assets/images/menu/menubg.png");
	private var buttons:FlxSpriteGroup = new FlxSpriteGroup();
	
	/**
	 * Make a new MainMenu.
	 * 
	 * @param	_func	function to call when clicking a button.
	 */
	public function new(_func:Dynamic->Void)
	{
		super();
		
		add_bgSprite();
		add_buttons(_func);
	}
	
	/**
	 * Add the background for the main menu.
	 */
	private function add_bgSprite()
	{
		bgSprite.x = FlxG.width * 0.5 - (bgSprite.width * 0.5);
		bgSprite.y = FlxG.height * 0.5 - (bgSprite.height * 0.5);
		
		add(bgSprite);
	}
	
	/**
	 * Add the buttons for the main menu.
	 * 
	 * @param	_func	function to call when clicking a button.
	 */
	private function add_buttons(_func:Dynamic->Void)
	{
		buttons.x = bgSprite.x;
		buttons.y = bgSprite.y;
		
		for (_index in 0...4)
		{
			buttons.add(new FlxButtonPlus(128, ((_index == 3) ? 192 : 160) + (_index * 112), _func.bind(_index), null,  256, 96));
			cast(buttons.members[_index], FlxButtonPlus).loadButtonGraphic(new FlxSprite(0, 0, "assets/images/menu/text" + (_index + 1) + ".png"), new FlxSprite(0, 0, "assets/images/menu/text" + (_index + 1) + "highlight.png"));
		}
		
		add(buttons);
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
		
		bgSprite = null;
		buttons = null;
	}
}