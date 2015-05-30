package game;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * @author Sjoer van der Ploeg
 */

class ItemClass extends FlxSpriteGroup
{
	public var type:String = null;
	public var use:Void->Void = null;
	
	private var fullGraphic:FlxSprite = new FlxSprite();
	private var iconGraphic:FlxSprite = new FlxSprite();
	
	/**
	 * Create a new item.
	 * 
	 * @param	_x		x position on screen.
	 * @param	_y		y position on screen.
	 * @param	_type	the item type or name.
	 * @param	_func	the use function attached to the item.
	 */
	public function new(_x:Float=0, _y:Float=0, _type:String, ?_func:Void->Void=null)
	{
		super(_x, _y);
		
		type = _type;
		use = _func;
		
			fullGraphic.makeGraphic(128, 128, 0xffffffff);
		add(fullGraphic);
		
			iconGraphic.makeGraphic(32, 32, 0xffffffff);
		add(iconGraphic);
		
		icon();
	}
	
	/**
	 * Show the icon graphic.
	 */
	public function icon()
	{
		fullGraphic.visible = false;
		iconGraphic.visible = true;
		
		width = iconGraphic.width;
		height = iconGraphic.height;
	}
	
	/**
	 * Show the full item graphic.
	 */

	public function full()
	{
		fullGraphic.visible = true;
		iconGraphic.visible = false;
		
		width = fullGraphic.width;
		height = fullGraphic.height;
	}
	
	/**
	 * Swap between full and icon graphics.
	 */
	public function swap()
	{
		if (fullGraphic.visible) icon();
		else full();
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
		
		type = null;
		use = null;
		
		fullGraphic = null;
		iconGraphic = null;
	}
}