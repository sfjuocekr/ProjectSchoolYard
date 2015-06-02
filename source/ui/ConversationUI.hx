package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;

/**
 * @author Sjoer van der Ploeg
 */

class ConversationUI extends FlxSpriteGroup
{
	private var scene:FlxSprite = new FlxSprite(0, 0, "assets/images/scenes/home/Street.png");
	private var character:FlxSprite = new FlxSprite(0, 0, "assets/images/characters/SoccerGirl.png");
	private var bgText:FlxSprite = new FlxSprite(0, 0, "assets/images/conversation/bgBig.png");
	
	//add textfields
	
	public function new() 
	{
		super();
		
		add(scene);
		add_character();
		add_textField();
	}
	
	private function add_character()
	{
		character.x = FlxG.width - character.width;
		character.y = FlxG.height - character.height;
		
		add(character);
	}
	
	private function add_textField()
	{
		
	}
}