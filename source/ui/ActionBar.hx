package ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.ui.FlxButtonPlus;

/**
 * @author Sjoer van der Ploeg
 */

class ActionBar extends FlxSpriteGroup
{
	private var bgSprite:FlxSprite = new FlxSprite(0, 0, "assets/images/actionbar/Background.png");
	private var buttons:FlxSpriteGroup = new FlxSpriteGroup();
	
	private var normalButton:FlxSprite = new FlxSprite(0, 0, "assets/images/actionbar/ButtonNormal.png");
	private var highlightButton:FlxSprite = new FlxSprite(0, 0, "assets/images/actionbar/ButtonHighlight.png");
	
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
		bgSprite.y = FlxG.height - bgSprite.height;
		
		add(bgSprite);
	}
	
	/**
	 * Add the buttons for the actionbar.
	 */
	private function add_buttons(_func:Dynamic->Void)
	{
		buttons.x = bgSprite.x;
		buttons.y = bgSprite.y;
		
		buttons.add(new FlxButtonPlus(32,	32,	_func.bind("A"), "Bully", 160, 64));
		buttons.add(new FlxButtonPlus(224,	32,	_func.bind("B"), "B", 160, 64));
		buttons.add(new FlxButtonPlus(416,	32,	_func.bind("C"), "C", 160, 64));
		buttons.add(new FlxButtonPlus(608,	32,	_func.bind("D"), "D", 160, 64));
		buttons.add(new FlxButtonPlus(800,	32,	_func.bind("E"), "E", 160, 64));
		
		for (_button in buttons.members)
		{
			cast(_button, FlxButtonPlus).textNormal.size = 32;
			cast(_button, FlxButtonPlus).textHighlight.size = 32;
			
			cast(_button, FlxButtonPlus).textNormal.y += 8;
			cast(_button, FlxButtonPlus).textHighlight.y += 8;
			
			cast(_button, FlxButtonPlus).loadButtonGraphic(normalButton, highlightButton);
		}
		
		add(buttons);
	}
}