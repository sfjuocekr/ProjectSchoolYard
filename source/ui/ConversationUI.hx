package ui;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.addons.ui.FlxUIText;

/**
 * @author Sjoer van der Ploeg
 */

class ConversationUI extends FlxSpriteGroup
{
	//private var scene:FlxSprite = new FlxSprite(0, 0, "assets/images/scenes/home/Street.png");
	private var scene:FlxSprite = new FlxSprite(0, 0, "assets/images/map/15/background.png");
	//private var character:FlxSprite = new FlxSprite(0, 0, "assets/images/characters/SoccerGirl.png");
	private var character:FlxSprite;
	private var bgText:FlxSprite = new FlxSprite(0, 0, "assets/images/conversation/bgBig.png");
	private var bgNameText:FlxSprite = new FlxSprite(0, 0, "assets/images/conversation/bgName.png");
	private var nameText:FlxText;
	private var options:Array<FlxButtonPlus> = new Array<FlxButtonPlus>();
	
	private var callback:Dynamic->Void;
	
	public function new(_callback:Dynamic->Void)
	{
		super();
		
		callback = _callback;
		
		if (Std.random(2) == 1) character = new FlxSprite(0, 0, "assets/images/characters/char2_1.png");
		else character = new FlxSprite(0, 0, "assets/images/characters/char2_2.png");
		
		add(scene);
		add_character();
		add_textFields();
	}
	
	private function add_character()
	{
			character.x = FlxG.width - character.width;
			character.y = FlxG.height - character.height;
		add(character);
	}
	
	private function add_textFields()
	{
			bgText.x = 96;
			bgText.y = FlxG.height - bgText.height - 96;		
			bgText.alpha = 0.5;
		add(bgText);
		
			bgNameText.x = 96;
			bgNameText.y = FlxG.height - bgText.height - 96 - 56;		
			bgNameText.alpha = 0.5;
		add(bgNameText);
		
			nameText = new FlxText(bgNameText.x + 8, bgNameText.y + 8, bgNameText.width - 16, null, 24, true);
			nameText.alignment = "center";
		add(nameText);
		
		for (_index in 0 ... 3)
		{
			options[_index] = new FlxButtonPlus(bgText.x + 32, bgText.y + 20 + (_index * 56), null, Std.string(_index), Std.int(bgText.width - 64), 40);
			
			options[_index].alpha = 0;
			
			options[_index].textNormal = new FlxText(bgText.x + 32, bgText.y + 16 + (_index * 56), bgText.width - 64, null, 20, true);
			options[_index].textNormal.color = 0xCACACA;
			
			options[_index].textHighlight = new FlxText(bgText.x + 32, bgText.y + 16 + (_index * 56), bgText.width - 64, null, 20, true);
			options[_index].textHighlight.color = 0xFFFFFF;
		}
	}
	
	public function set(_text:Array<Array<String>>, _story:String)
	{
		nameText.text = _text[0][3];
		for (_option in options)
			remove(_option);
		
		for (_index in 0 ... 3)
		{
			if (_index < _text.length)
			{
					options[_index].text = _text[_index][2];
					options[_index].onClickCallback = callback.bind([_text[_index][0], _story]);
				add(options[_index]);
			}
		}
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
		
		scene = null;
		character = null;
		bgText = null;
		bgNameText = null;
		nameText = null;
		options = null;
		callback = null;
	}
}