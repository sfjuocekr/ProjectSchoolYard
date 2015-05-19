package ui;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import ui.ItemClass;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Inventory extends FlxSpriteGroup
{
	private static var itemObjects:Map<String, ItemClass>;
	private static var itemAmounts:Map<String, Int>;
	private static var itemSlots:Array<String>;
	
	public function new() 
	{
		super();
		
		if (itemObjects == null)
		{
			itemObjects = new Map<String, ItemClass>();
			itemAmounts = new Map<String, Int>();
			itemSlots = new Array<String>();
		}
		
		// load save data if available
	}
	
	public function put(name:String, item:ItemClass)
	{
		var amount:Int = itemAmounts.get(name);
		
		if (amount != null) amount++;
		else amount = 1;
		
		itemObjects.set(name, item);
		itemAmounts.set(name, amount);
		
		item.icon();
		
		add(item);
	}
	
	public function test(name:String): Bool
	{
		var amount:Int = itemAmounts.get(name);
			
		if ((amount == null) || (amount == 0)) return false;
		else return true;
	}
	
	public function get(name:String): ItemClass
	{
		var amount:Int = itemAmounts.get(name);
		
		if ((amount == null) || (amount == 0)) return null;
		else
		{
			amount--;
			
			itemAmounts.set(name, amount);
			
			return itemObjects.get(name);
		}
	}
	
	public function use(name:String)
	{
		itemObjects.get(name).use();
	}
	
	override public function update()
	{
		super.update();
	}
}