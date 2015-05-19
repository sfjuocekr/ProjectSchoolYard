package ui;

import flixel.addons.ui.FlxButtonPlus;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/
class Menu extends FlxSpriteGroup
{
	private var buttons:Array<FlxButtonPlus> = new Array();
	private var buttonWidth:Int = 0;
	private var buttonHeight:Int = 0;
	
	public function new(_x:Float=0, _y:Float=0, _centered:Bool=false, _width:Int=0 ,_height:Int=0) 
	{
		super(_x, _y, 0);
		
		if (_centered) centerOrigin();
		
		buttonWidth = _width;
		buttonHeight = _height;
		
		var bg = new FlxButtonPlus(0, 0, null, null, buttonWidth, buttonHeight);
			bg.loadButtonGraphic(new FlxSprite(0, 0, "assets/images/menu/Background.png"), new FlxSprite(0, 0, "assets/images/menu/Background.png"));
		
		add(bg);
	}
	
}