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
	private var scene:FlxSprite = new FlxSprite(0, 0, "assets/images/scenes/home/Street.png");
	private var character:FlxSprite = new FlxSprite(0, 0, "assets/images/characters/SoccerGirl.png");
	private var bgText:FlxSprite = new FlxSprite(0, 0, "assets/images/conversation/bgBig.png");
	private var bgNameText:FlxSprite = new FlxSprite(0, 0, "assets/images/conversation/bgName.png");
	private var nameText:FlxText;
	private var options:Array<FlxButtonPlus> = new Array<FlxButtonPlus>();
	
	private var optionCallback:Dynamic->Void;
	
	public function new(_callback:Dynamic->Void)
	{
		super();
		
		optionCallback = _callback;
		
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
			options[_index] = new FlxButtonPlus(bgText.x + 32, bgText.y + 20 + (_index * 56), optionCallback.bind(_index), Std.string(_index), Std.int(bgText.width - 64), 40);
			
			options[_index].alpha = 0;
			
			options[_index].textNormal = new FlxText(bgText.x + 32, bgText.y + 16 + (_index * 56), bgText.width - 64, null, 20, true);
			options[_index].textNormal.color = 0xCACACA;
			
			options[_index].textHighlight = new FlxText(bgText.x + 32, bgText.y + 16 + (_index * 56), bgText.width - 64, null, 20, true);
			options[_index].textHighlight.color = 0xFFFFFF;
			
			add(options[_index]);
		}
	}
	
	public function set(_options:Array<Array<String>>, ?_lastBtn:Int = null)
	{
		trace(_options);
		
		nameText.text = _options[0].pop();
		
		for (_index in 0 ... 3)
		{
			if (_index < _options.length)
			{
				options[_index].text = _options[_index][2];
				options[_index].onClickCallback = optionCallback.bind([Std.parseInt(_options[_index][0]), _index]);
				options[_index].visible = true;
			}
			
			else
			{
				options[_index].text = null;
				options[_index].visible = false;
			}
			
			options[_index].textHighlight.visible = (_index == _lastBtn) ? true : false;
			options[_index].textNormal.visible = (_index == _lastBtn) ? false : true;
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
		options = null;
		optionCallback = null;
	}
}