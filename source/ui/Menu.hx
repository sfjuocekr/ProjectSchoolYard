package ui;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Frank Wester
 */

class Menu extends FlxSpriteGroup
{
	private var buttons:Array<FlxSprite> = new Array<FlxSprite> ();
	private var buttonWidth:Int = 0;
	private var buttonHeight:Int = 0;
	private var centered:Bool = false;
	
	public function new(_x:Float = 0, _y:Float = 0, _width:Int = 0, _height:Int = 0, ?_centered:Bool = false ) 
	{
		if (_centered == true) super(_x - _width * 0.5, _y, 0);
		else super(_x, _y, 0);
		
		width = _width;
		buttonHeight = _height;
		centered = _centered;
	}

	public function put (name:String, functie:Void->Void, mouseOver:String, mouseOut:String )
	{
		var _x = buttons.length * buttonHeight;
		var button = new FlxButtonPlus(0, _x, functie, name, buttonWidth, buttonHeight);
			button.loadButtonGraphic(new FlxSprite(0, 0, mouseOut), new FlxSprite(0, 0, mouseOver));
		
		buttons.push(button);
		
		if (centered == true) y = y - buttonHeight * 0.5; 
		
		add(button); 
	}
}