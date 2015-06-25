package ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import sys.FileSystem;
import flixel.addons.ui.FlxButtonPlus;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class MapDisplay extends FlxSpriteGroup
{
	private var tiles:Array<FlxSprite> = new Array<FlxSprite>();
	
												/*
													0,			1,									2,
													3,			4,									5,
													6,			7,									8,
													9,			10,									11,
													12,			13,									14,
													15,			16,									17
												*/
	
	private var directions:Array<Array<Int>> = [
													[],			[2, 4],								[1],
													[],			[1, 7],								[],
													[10],		[10],								[10],
													[10],		[6, 7, 8, 9, 11, 13],				[10],
													[13],		[10, 12, 14, 15, 16, 17],			[13],
													[13],		[13],								[13]
												];
	
	private var direction:Array<Array<String>> = [
													[],			["E", "S"],							["W"],
													[],			["N", "S"],							[],
													["SE"],		["S"],								["SW"],
													["E"],		["NW", "N", "NE", "W", "E", "S"],	["W"],
													["E"],		["N", "W", "E", "SW", "S", "SE"],	["W"],
													["NE"],		["N"],								["NW"]
												];
	
	private var navDirections:Array<Array<String>> = [
														["NW",		"N",		"NE"],
														["W",		null,		"E"],
														["SW",		"S",		"SE"]
													];
	
	public var navButtons:Array<FlxButtonPlus> = new Array<FlxButtonPlus>();
	
	private var location:Int = 10;
	
	public function new()
	{
		super();
		
		var _images:Array<Int> = new Array<Int>();
		
		for (_y in directions)
			for (_x in _y)
				_images.push(_x);
		
		for (_index in 0 ... directions.length)
			if (_images.indexOf(_index) != -1)
				if (FileSystem.exists("assets/images/map/" + _index + "/background.png"))
				{	
						tiles[_index] = new FlxSprite(0, 0, "assets/images/map/" + _index + "/background.png");
						tiles[_index].visible = false;
					add(tiles[_index]);
				}
		
		for (_y in 0...navDirections.length)
			for (_x in 0...navDirections[_y].length)
				if (navDirections[_y][_x] != null)
				{
					navButtons.push(new FlxButtonPlus(_x * 64, _y * 64, setLocation.bind(navDirections[_y][_x]), navDirections[_y][_x], 64, 64));
					navButtons[navButtons.length - 1].textNormal.size = 32;
					navButtons[navButtons.length - 1].textHighlight.size = 32;
					add(navButtons[navButtons.length - 1]);
				}
		
		tiles[location].visible = true;
		setDirections();
	}
	
	private function setLocation(_location:String)
	{
		//trace(_location);
		var _direction = directions[location][direction[location].indexOf(_location)];		// Yup it does what it says it does ;)
		//trace(_direction);
		
		tiles[location].visible = false;
		tiles[_direction].visible = true;
		
		location = _direction;
		
		setDirections();
	}
	
	private function getDirections(): Array<String>
	{
		return direction[location];
	}
	
	private function setDirections()
	{
		//trace(direction[location]);
		
		for (_button in navButtons)
		{
			if (direction[location].indexOf(_button.textNormal.text) != -1)
			{
				_button.visible = true;
			}
			else
			{
				_button.visible = false;
			}
		}
	}
}