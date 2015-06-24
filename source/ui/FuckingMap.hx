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

class FuckingMap extends FlxSpriteGroup
{
	private var scene:FlxSprite = new FlxSprite(0, 0, "assets/images/scenes/home/Street.png");
	
	public function new()
	{
		super();
		
		add(scene);
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
	}
}