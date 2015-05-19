package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import ui.Menu;
import ui.ItemClass;
import ui.Inventory;

/**
 * A FlxState which can be used for the game's menu.
 */

class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	private var menu:Menu = new ui.Menu(FlxG.width * 0.5, FlxG.height * 0.5, 160, 32, true);
	private var inventory:Inventory = new Inventory();
	
	override public function create(): Void
	{
		super.create();
		
		add(menu);
		add(inventory);
		
		inventory.put("test0", new ItemClass(32, 32, "button", false, null));
		inventory.put("test1", new ItemClass(32, 32, "button", false, null));
		inventory.put("test2", new ItemClass(32, 32, "button", false, null));
		inventory.put("test3", new ItemClass(32, 32, "button", false, null));
		
		if (inventory.test("test0")) trace(add(inventory.get("test0")));
		
		//menu.put("hoi", null, "assets/images/menu/Button.png", "assets/images/menu/Button.png");
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy(): Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}