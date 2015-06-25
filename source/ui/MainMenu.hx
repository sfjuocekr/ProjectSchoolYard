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
	
	//private var normalButton:FlxSprite = new FlxSprite(0, 0, "assets/images/menu/ButtonNormal.png");
	//private var highlightButton:FlxSprite = new FlxSprite(0, 0, "assets/images/menu/ButtonHighlight.png");
	
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
		
		buttons.add(new FlxButtonPlus(96,  32 + 96 + (buttons.length * 64), _func.bind("game" ), null,  256, 128));
		buttons.add(new FlxButtonPlus(96,  96 + 96 + (buttons.length * 72), _func.bind("help" ), null,  256, 128));
		buttons.add(new FlxButtonPlus(96, 160 + 96 + (buttons.length * 56), _func.bind("about"), null,  256, 128));
		buttons.add(new FlxButtonPlus(96, 256 + 32 + (buttons.length * 64), _func.bind("exit" ), null,  256, 128));
		
		/*for (_button in buttons.members)
		{
			cast(_button, FlxButtonPlus).textNormal.size = 32;
			cast(_button, FlxButtonPlus).textHighlight.size = 32;
			
			cast(_button, FlxButtonPlus).textNormal.y += 8;
			cast(_button, FlxButtonPlus).textHighlight.y += 8;
			
			cast(_button, FlxButtonPlus).loadButtonGraphic(normalButton, highlightButton);
		}*/
		
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
		//normalButton = null;
		//highlightButton = null;
		buttons = null;
	}
}