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
	private var bgSprite:FlxSprite = new FlxSprite(0, 0, "assets/images/menu/Background.png");
	private var buttons:FlxSpriteGroup = new FlxSpriteGroup();
	
	private var normalButton:FlxSprite = new FlxSprite(0, 0, "assets/images/menu/ButtonNormal.png");
	private var highlightButton:FlxSprite = new FlxSprite(0, 0, "assets/images/menu/ButtonHighlight.png");
	
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
	 */
	private function add_buttons(_func:Dynamic->Void)
	{
		buttons.x = bgSprite.x;
		buttons.y = bgSprite.y;
		
		buttons.add(new FlxButtonPlus(32,  32 + (buttons.length * 32),  _func.bind("test"),  "test", 256, 64));
		buttons.add(new FlxButtonPlus(32,  96 + (buttons.length * 32),  _func.bind("help"),  "help", 256, 64));
		buttons.add(new FlxButtonPlus(32, 160 + (buttons.length * 32),  _func.bind("about"), "about", 256, 64));
		
		buttons.add(new FlxButtonPlus(32,  256 + (buttons.length * 32), _func.bind("exit"),  "exit", 256, 64));
		
		for (_button in buttons.members)
		{
			cast(_button, FlxButtonPlus).loadButtonGraphic(normalButton, highlightButton);
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
		normalButton = null;
		highlightButton = null;
		buttons = null;
	}
}