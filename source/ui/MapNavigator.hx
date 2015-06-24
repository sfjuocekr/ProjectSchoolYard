package ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.addons.ui.FlxButtonPlus;

/**
 * @author Sjoer van der Ploeg
 */

class MapNavigation extends FlxSpriteGroup
{
	private var directions:Array<String> = [
												"NW",	"N",	"NE",
												"W",			"E",
												"SW",	"S",	"SE"
											];

	private var directionButtons:Array<FlxButtonPlus> = new Array<FlxButtonPlus>();
	
	public function new()
	{
		super();
		
		for (_direction in directions)
		{
			directionButtons.push(new FlxButtonPlus(0, 0, text, null)
		}
	}
}