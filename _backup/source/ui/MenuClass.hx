package ui;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Frank Wester
 */

class MenuClass extends FlxSpriteGroup
{
	private var buttons:Array<FlxSprite> = new Array<FlxSprite> ();
	private var buttonWidth:Int = 0;
	private var buttonHeight:Int = 0;
	private var centered:Bool = false;
	
	/**
	 * Load a new state.
	 * 
	 * @param	_x			x position on screen.
	 * @param	_y			y position on screen.
	 * @param	_width		width of the buttons.
	 * @param	_height		height of the buttons.
	 * @param	_centered	if the menu is centered.
	 */
	public function new(_x:Float = 0, _y:Float = 0, _width:Int = 0, _height:Int = 0, ?_centered:Bool = false ) 
	{
		if (_centered == true) super(_x - _width * 0.5, _y, 0);
		else super(_x, _y, 0);
		
		width = _width;
		buttonHeight = _height;
		centered = _centered;
	}
	
	/**
	 * Add a new button.
	 * 
	 * @param	_name		name of the button.
	 * @param	_func		function executed by this button.
	 * @param	_mouseOver	mouse over graphic.
	 * @param	_mouseOut	normal graphic.
	 */
	public function put(_name:String, _func:Void->Void, _mouseOver:String, _mouseOut:String )
	{
		var _x = buttons.length * buttonHeight;
		var button = new FlxButtonPlus(0, _x, _func, _name, buttonWidth, buttonHeight);
			button.loadButtonGraphic(new FlxSprite(0, 0, _mouseOut), new FlxSprite(0, 0, _mouseOver));
		
		buttons.push(button);
		
		if (centered == true) y = y - buttonHeight * 0.5; 
		
		add(button); 
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
		
		buttons = null;
		buttonWidth = null;
		buttonHeight = null;
		centered = null;
	}
}