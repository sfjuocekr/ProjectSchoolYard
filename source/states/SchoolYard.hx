package states;

import openfl.tiled.FlxTiledMap;
import flixel.FlxState;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class SchoolYard extends FlxState
{
	private var level:FlxTiledMap;
	
	/**
	 * Create this state.
	 */
	override public function create()
	{
		super.create();
		
		var map = FlxTiledMap.fromAssets("assets/maps/SchoolYard/map.tmx");
		
		trace(map._map.imageLayers);
	}
	
	/**
	 * Update whatever floats your boat.
	 */
	override public function update()
	{
		super.update();
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
	}
}