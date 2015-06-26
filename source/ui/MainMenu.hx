package ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.ui.FlxButtonPlus;

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
		
		buttons.add(new FlxButtonPlus(96,  32 + 96 + (buttons.length * 64), _func.bind("game" ), null,  256, 128));
		buttons.add(new FlxButtonPlus(96,  96 + 96 + (buttons.length * 72), _func.bind("help" ), null,  256, 128));
		buttons.add(new FlxButtonPlus(96, 160 + 96 + (buttons.length * 56), _func.bind("about"), null,  256, 128));
		buttons.add(new FlxButtonPlus(96, 256 + 32 + (buttons.length * 64), _func.bind("exit" ), null,  256, 128));
		
		cast(buttons.members[0], FlxButtonPlus).loadButtonGraphic(new FlxSprite(0, 0, "assets/images/menu/text1.png"), new FlxSprite(0, 0, "assets/images/menu/text1highlight.png"));
		cast(buttons.members[1], FlxButtonPlus).loadButtonGraphic(new FlxSprite(0, 0, "assets/images/menu/text2.png"), new FlxSprite(0, 0, "assets/images/menu/text2highlight.png"));
		cast(buttons.members[2], FlxButtonPlus).loadButtonGraphic(new FlxSprite(0, 0, "assets/images/menu/text3.png"), new FlxSprite(0, 0, "assets/images/menu/text3highlight.png"));
		cast(buttons.members[3], FlxButtonPlus).loadButtonGraphic(new FlxSprite(0, 0, "assets/images/menu/text4.png"), new FlxSprite(0, 0, "assets/images/menu/text4highlight.png"));
		
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