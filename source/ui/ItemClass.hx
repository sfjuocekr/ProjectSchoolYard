package ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class ItemClass extends FlxSpriteGroup
{
	public var type:String = null;
	public var use:Void->Void;
	
	private var fullGraphic:FlxSprite = new FlxSprite();
	private var iconGraphic:FlxSprite = new FlxSprite();
	
	public function new(_x:Float=0, _y:Float=0, _type:String, ?_icon:Bool=false, ?_func:Void->Void=null)
	{
		super(_x, _y);
		
		type = _type;
		use = _func;
		
			fullGraphic.makeGraphic(128, 128, 0xffffffff);
		add(fullGraphic);
		
			iconGraphic.makeGraphic(32, 32, 0xffffffff);
		add(iconGraphic);
		
		full();
	}
	
	public function icon()
	{
		fullGraphic.visible = false;
		iconGraphic.visible = true;
		
		width = iconGraphic.width;
		height = iconGraphic.height;
	}
	
	public function full()
	{
		fullGraphic.visible = true;
		iconGraphic.visible = false;
		
		width = fullGraphic.width;
		height = fullGraphic.height;
	}
	
	public function swap()
	{
		if (fullGraphic.visible) icon();
		else full();
	}
}