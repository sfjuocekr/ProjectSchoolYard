package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxColor;

/**
 * @author Sjoer van der Ploeg
 */

class Gadget extends FlxSpriteGroup
{
	private var screen:FlxSprite = new FlxSprite(0, 0, "assets/images/gadget/Screen.png");
	private var logo:FlxSprite = new FlxSprite(0, 0, "assets/images/gadget/Logo.png");
	private var background:FlxSprite = new FlxSprite(0, 0, "assets/images/gadget/Background.png");
	private var edge:FlxSprite = new FlxSprite(0, 0, "assets/images/gadget/Edge.png");
	private var backside:FlxSprite = new FlxSprite(0, 0, "assets/images/gadget/Backside.png");
	
	private var bg = new FlxSprite(0, 0);
	
	public var gadgetOpen:Bool = false;
	
	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(_x, _y, 0);
		
		width = FlxG.width;
		height = FlxG.height;
		
			bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			bg.visible = false;
		add(bg);
		
			edge.x = FlxG.width * 0.5 - (edge.width * 0.5);
			edge.y = FlxG.height * 0.5 - (edge.height * 0.5);
			edge.visible = false;
		add(edge);
		
			background.x = FlxG.width * 0.5 - (background.width * 0.5);
			background.y = FlxG.height * 0.5 - (background.height * 0.5);
			background.visible = false;
		add(background);
		
			logo.x = FlxG.width * 0.5 - (logo.width * 0.5);
			logo.y = FlxG.height * 0.5 - (logo.height * 0.5);
			logo.visible = false;
		add(logo);
		
			screen.x = FlxG.width * 0.5 - (screen.width * 0.5);
			screen.y = FlxG.height * 0.5 - (screen.height * 0.5);
			screen.visible = false;
		add(screen);
		
			backside.x = FlxG.width - backside.width - 64;
			backside.y = FlxG.height - backside.height - 64;
			backside.visible = true;
		add(backside);
		
		FlxG.plugins.add(new MouseEventManager());
		
		MouseEventManager.add(backside, flip);
		MouseEventManager.add(screen, flip);
	}
	
	private function flip(_sprite:FlxSprite)
	{
		bg.visible = edge.visible = background.visible = logo.visible = screen.visible = (_sprite == backside) ? _sprite.visible : !_sprite.visible;
		backside.visible = !_sprite.visible;
		gadgetOpen = screen.visible;
	}
	
	/**
	 * EXTERMINATE, EXTERMINATE, EXTERMINATE!
	 */
	override public function destroy()
	{
		super.destroy();
		
		screen = null;
		logo = null;
		background = null;
		edge = null;
		backside = null;
	}
}