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
	private var notificationSprite:FlxSprite = new FlxSprite(0, 0, "assets/images/gadget/Notification.png");
	private var bg:FlxSprite = new FlxSprite(0, 0);
	
	private var text:FlxText = new FlxText();
	
	private var defaultText:String = "Er zijn op het moment geen berichten om te tonen!";
	
	private var timer:Timer = new Timer(1000, 1);
	private var blinker:Timer = new Timer(250, 0);
	
	private var textRead:Bool = false;
	public var gadgetOpen:Bool = false;
	private var notification:Bool = false;
	
	private var callback:Dynamic->Void;
	private var callbackOptions:Array<String>;
	
	public function new(_x:Float = 0, _y:Float = 0)
	{
		super(_x, _y, 0);
		
		width = FlxG.width;
		height = FlxG.height;
		
			bg.x = FlxG.width * 0.5 - (screen.width * 0.5);
			bg.y = FlxG.height * 0.5 - (screen.height * 0.5);
			bg.makeGraphic(screen.frameWidth, screen.frameHeight, FlxColor.BLACK);
			//bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			//bg.visible = false;
		//add(bg);
		
			edge.x = FlxG.width * 0.5 - (edge.width * 0.5);
			edge.y = FlxG.height * 0.5 - (edge.height * 0.5);
			//edge.visible = false;
		//add(edge);
		
			background.x = FlxG.width * 0.5 - (background.width * 0.5);
			background.y = FlxG.height * 0.5 - (background.height * 0.5);
			background.alpha = 0.5;
			//background.visible = false;
		//add(background);
		
			logo.x = FlxG.width * 0.5 - (logo.width * 0.5);
			logo.y = FlxG.height * 0.5 - (logo.height * 0.5);
			//logo.visible = false;
		//add(logo);
		
			screen.x = FlxG.width * 0.5 - (screen.width * 0.5);
			screen.y = FlxG.height * 0.5 - (screen.height * 0.5);
			screen.alpha = 0.5;
			//screen.visible = false;
		//add(screen);
		
			text.x = screen.x + 32;
			text.y = screen.y + 32;
			text.fieldWidth = screen.width - 64;
			text.wordWrap = true;
			text.size = 32;
			//text.visible = false;
		//add(text);

			backside.x = FlxG.width - backside.width - 64;
			backside.y = FlxG.height - backside.height - 64;
			//backside.visible = true;
		add(backside);
		
			notificationSprite.x = FlxG.width - notificationSprite.width - 64;
			notificationSprite.y = FlxG.height - notificationSprite.height - 64;
			//notificationSprite.visible = false;
		//add(notificationSprite);
		
		FlxG.plugins.add(new MouseEventManager());
		
		MouseEventManager.add(backside, flip);
		MouseEventManager.add(screen, flip);
		
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
		blinker.addEventListener(TimerEvent.TIMER, blink);
	}
	
	private function flip(_sprite:FlxSprite)
	{
		if (_sprite == backside)
		{
			remove(backside);
			remove(notificationSprite);
			
			add(bg);
			add(edge);
			add(background);
			add(logo);
			add(screen);
			add(text);
			
			logo.visible = true;
			text.visible = false;
			
			timer.start();
			
			gadgetOpen = true;
		}
		
		else
		{
			add(backside);
			
			if (notification) add(notificationSprite);
			
			remove(bg);
			remove(edge);
			remove(background);
			remove(logo);
			remove(screen);
			remove(text);
			
			gadgetOpen = false;
		}
		
		if (textRead)
		{
			text.text = "";
			textRead = false;
			callback(callbackOptions);
		}
		
		else if (text.text == defaultText) text.text = "";
	}
	
	private function onTimer(_event:TimerEvent)
	{
		if (gadgetOpen && text.text != "")
		{
			notification = false;
			textRead = true; //hack
			
			logo.visible = false;
			text.visible = true;
		}
		
		else if (gadgetOpen)
		{
			text.text = defaultText;
			
			logo.visible = false;
			text.visible = true;
		}
	}
	
	private function blink(_event:TimerEvent)
	{
		if (!notification)
		{
			blinker.reset();
			remove(notificationSprite);
			notificationSprite.visible = false;
		}
		
		else if (notification && !gadgetOpen)
		{
			notificationSprite.visible = !notificationSprite.visible;
		}
	}
	
	public function addNotification(_text:String, _callback:Dynamic->Void, _options:Array<String>)
	{
		trace(_options);
		
		text.text = _text;
		callback = _callback;
		callbackOptions = _options;
		
		//if (callbackOptions[0] == null) callbackOptions[0] = "1";
		//else callbackOptions[0] = Std.string(Std.parseInt(callbackOptions[0]) + 1);
		
		add(notificationSprite);
		
		notification = true;
		
		blinker.start();
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