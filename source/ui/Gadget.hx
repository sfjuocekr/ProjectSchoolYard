package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

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
	private var bg:FlxSprite = new FlxSprite(0, 0);
	
	private var text:FlxText = new FlxText();
	private var textRead:Bool = false;
	
	private var timer:Timer = new Timer(1000, 1);
	
	public var gadgetOpen:Bool = false;
	
	private var callback:Dynamic->Void;
	private var callbackOptions:Array<Int>;
	
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
			background.alpha = 0.5;
			background.visible = false;
		add(background);
		
			logo.x = FlxG.width * 0.5 - (logo.width * 0.5);
			logo.y = FlxG.height * 0.5 - (logo.height * 0.5);
			logo.visible = false;
		add(logo);
		
			screen.x = FlxG.width * 0.5 - (screen.width * 0.5);
			screen.y = FlxG.height * 0.5 - (screen.height * 0.5);
			screen.alpha = 0.5;
			screen.visible = false;
		add(screen);
		
			text.x = screen.x + 32;
			text.y = screen.y + 32;
			text.fieldWidth = screen.width - 64;
			text.wordWrap = true;
			text.size = 32;
			text.visible = false;
		add(text);

			backside.x = FlxG.width - backside.width - 64;
			backside.y = FlxG.height - backside.height - 64;
			backside.visible = true;
		add(backside);
		
		FlxG.plugins.add(new MouseEventManager());
		
		MouseEventManager.add(backside, flip);
		MouseEventManager.add(screen, flip);
		
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
	}
	
	private function flip(_sprite:FlxSprite)
	{
		if (backside.visible) timer.start();
		else text.visible = false;
		
		if (textRead)
		{
			text.text = "";
			textRead = false;
			callback(callbackOptions);
			
		}
		
		gadgetOpen = bg.visible = edge.visible = background.visible = logo.visible = screen.visible = (_sprite == backside);
		backside.visible = !_sprite.visible;
	}
	
	private function onTimer(_event:TimerEvent)
	{
		trace(text.text);
		if (gadgetOpen && text.text != "")
		{
			logo.visible = false;
			text.visible = true;
			
			textRead = true; //hack
		}
	}
	
	public function addNotification(_text:String, _callback:Dynamic->Void, _options:Array<Int>)
	{
		text.text = _text;
		
		callback = _callback;
		callbackOptions = _options;
		
		//ugly hack, needs an array and some routine to switch notifications etc etc etc
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