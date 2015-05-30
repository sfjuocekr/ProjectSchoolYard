package game;

import flixel.group.FlxSpriteGroup;
import game.ItemClass;

/**
 * @author Sjoer van der Ploeg
 */

class Inventory extends FlxSpriteGroup
{
	private static var itemObjects:Map<String, ItemClass>;
	private static var itemAmounts:Map<String, Int>;
	private static var itemSlots:Array<String>;
	
	/**
	 * Create an inventory to handle items.
	 */
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
	
	/**
	 * Store an item in the inventory.
	 * 
	 * @param	_name	name of the item.
	 * @param	_item	the actual item object.
	 */
	public function put(_name:String, _item:ItemClass)
	{
		var _amount:Int = itemAmounts.get(_name);
		
		if (_amount != null) _amount++;
		else _amount = 1;
		
		itemObjects.set(_name, _item);
		itemAmounts.set(_name, _amount);
		
		_item.icon();
		
		add(_item);
	}
	
	/**
	 * Test if the item is available, call this before trying to get an item!
	 * 
	 * @param	_name	name of the item.
	 * @return			true if the item is available.
	 */
	public function test(_name:String): Bool
	{
		var _amount:Int = itemAmounts.get(_name);
			
		if ((_amount == null) || (_amount == 0)) return false;
		else return true;
	}
	
	/**
	 * Retreive an item from the inventory.
	 * 
	 * @param	_name	name of the item.
	 * @return			the actual item object.
	 */
	public function get(_name:String): ItemClass
	{
		var _amount:Int = itemAmounts.get(_name);
		
		if ((_amount == null) || (_amount == 0)) return null;
		else
		{
			_amount--;
			
			itemAmounts.set(_name, _amount);
			
			return itemObjects.get(_name);
		}
	}
	
	/**
	 * Call the use() function on an item.
	 * 
	 * @param	_name	name of the item.
	 */
	public function use(_name:String)
	{
		itemObjects.get(_name).use();
	}
	
	/**
	 * EXTERMINATE!!!
	 */
	override public function destroy()
	{
		super.destroy();
		
		itemObjects = null;
		itemAmounts = null;
		itemSlots = null;
	}
}