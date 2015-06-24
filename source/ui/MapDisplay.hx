package ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import sys.FileSystem;

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
													[10],		[4, 10],							[10],
													[10],		[6, 7, 8, 9, 11, 13],				[10],
													[13],		[12, 14, 15, 16, 17],				[13],
													[13],		[13],								[13]
												];
	
												/*
														NW	N	NE	
														W		E
														SW	S	SE
												*/
	
	private var direction:Array<Array<String>> = [
													[],			["E", "S"],							["W"],
													[],			["N", "S"],							[],
													["SE"],		["N", "S"],							["SW"],
													["E"],		["NW", "N", "NE", "W", "E", "S"],	["W"],
													["E"],		["W", "E", "SW", "S", "SE"],		["W"],
													["NE"],		["N"],								["NW"]
												];
	
	private var location:Int = 13;
	
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
		
		setLocation("S");
	}
	
	public function setLocation(_location:String)
	{
		var _direction = directions[location][direction[location].indexOf(_location)];
		
		tiles[location].visible = false;
		tiles[_direction].visible = true;
		
		location = _direction;
	}
	
	public function getDirections(): Array<String>
	{
		return direction[location];
	}
}