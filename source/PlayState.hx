package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.display.FlxTiledSprite;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	public var box = new FlxSprite(200, 200);
	public var rectDisplay = new FlxSprite(69, 420); // le funni numbers!
	public var item = new FlxSprite(0, 0);
	public var mag = 3;
	public var grid:FlxTiledSprite;
	public var UI_radio:FlxUIRadioGroup;
	public var rectString:FlxInputText;
	public var rectBox:FlxUIInputText;
	public var hexBox:FlxUIInputText;
	public var rectButton:FlxUIButton;
	public var hexButton:FlxUIButton;
	public var UI_box:FlxUITabMenu;

	override public function create()
	{
		super.create();
		
		var back = new FlxSprite();
		back.makeGraphic(FlxG.width, FlxG.height, 0xFF404040);
		add(back);

		item.loadGraphic('assets/images/ItemImage.png');
		item.setGraphicSize(item.frameWidth * mag, item.frameHeight * mag);
		item.x = 0;
		item.y = 0;
		item.updateHitbox();
		add(item);

		grid = new FlxTiledSprite("assets/images/3xGrid.png", item.width, item.height, true, true);
		grid.x = 0;
		grid.y = 0;
		add(grid);

		rectDisplay.makeGraphic(1, 1, FlxColor.ORANGE);
		rectDisplay.alpha = 0; // This makes it invisible
		rectDisplay.origin.set(0,0);
		add(rectDisplay);

		box.makeGraphic(1, 1, FlxColor.BLUE);
		box.alpha = 0.5;
		box.origin.set(0,0);
		add(box);

		UI_box = new FlxUITabMenu(null, [], true);
		UI_box.resize(300, 400);
		UI_box.x = FlxG.width - 8 - UI_box.width;
		UI_box.y = 8;
		add(UI_box);

		var zoomtext = new FlxText(UI_box.x + 16, UI_box.y + 16, -1, "Zoom");
		add(zoomtext);

		UI_radio = new FlxUIRadioGroup(UI_box.x + 24, UI_box.y + 32, ['3x', '4x', '5x'], ['3x', '4x', '5x'], null, 16);
		UI_radio.selectedId = '5x';
		add(UI_radio);

		rectBox = new FlxUIInputText(UI_box.x + 24, UI_box.y + 128, 256, "", 16, FlxColor.BLACK, FlxColor.WHITE);
		add(rectBox);

		hexBox = new FlxUIInputText(UI_box.x + 24, rectBox.y + 48, 256, "", 16, FlxColor.BLACK, FlxColor.WHITE);
		add(hexBox);

		var recttext = new FlxText(UI_box.x + 16, rectBox.y - 16, -1, "Rect");
		add(recttext);

		var hextext = new FlxText(UI_box.x + 16, hexBox.y - 16, -1, "Hexidecimal Rect");
		add(hextext);

		rectButton = new FlxUIButton(UI_box.x + 16, rectBox.y + 80, "Display Rect", displayRect);
		add(rectButton);

		hexButton = new FlxUIButton(UI_box.x + 16, rectBox.y + 104, "Display Hex Rect", displayHexRect);
		add(hexButton);
	}
	function displayRect():Void
	{
		var daList:Array<String> = rectBox.text.split(', ');

		var x1 = Std.parseInt(daList[0]);
		var y1 = Std.parseInt(daList[1]);
		var x2 = Std.parseInt(daList[2]);
		var y2 = Std.parseInt(daList[3]);

		rectDisplay.alpha = 0.5;
		rectDisplay.x = x1 * mag;
		rectDisplay.y = y1 * mag;
		rectDisplay.scale.set(mag, mag); // Reset scale
		rectDisplay.scale.set(x2 * mag - rectDisplay.x, y2 * mag - rectDisplay.y);
	}
	function displayHexRect():Void
	{
		var hexList:Array<String> = hexBox.text.split(', ');

		var x1 = Std.parseInt("0x" + hexList[0]);
		var y1 = Std.parseInt("0x" + hexList[1]);
		var x2 = Std.parseInt("0x" + hexList[2]);
		var y2 = Std.parseInt("0x" + hexList[3]);
	
		rectDisplay.alpha = 0.5;
		rectDisplay.x = x1 * mag;
		rectDisplay.y = y1 * mag;
		rectDisplay.scale.set(mag, mag); // Reset scale
		rectDisplay.scale.set(x2 * mag - rectDisplay.x, y2 * mag - rectDisplay.y);
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.mouse.pressed && FlxG.mouse.x < UI_box.x) 
		{
			rectDisplay.alpha = 0;
			box.scale.set(FlxMath.roundDecimal(FlxG.mouse.x / mag, 0) * mag - box.x + 1, FlxMath.roundDecimal(FlxG.mouse.y / mag, 0) * mag - box.y + 1);
			rectBox.text = box.x / mag + ", " + box.y / mag + ", " + FlxMath.roundDecimal(FlxG.mouse.x / mag, 0) + ", " + FlxMath.roundDecimal(FlxG.mouse.y / mag, 0);
			hexBox.text = StringTools.hex(Std.int(box.x / mag)) + ", " + StringTools.hex(Std.int(box.y / mag)) + ", " + StringTools.hex(Std.int(FlxMath.roundDecimal(FlxG.mouse.x / mag, 0))) + ", " + StringTools.hex(Std.int(FlxMath.roundDecimal(FlxG.mouse.y / mag, 0)));
		}
		else
		{
			box.x = FlxMath.roundDecimal(FlxG.mouse.x / mag, 0) * mag;
			box.y = FlxMath.roundDecimal(FlxG.mouse.y / mag, 0) * mag;
			box.scale.set(mag, mag);
		}
		switch (UI_radio.selectedId) // There's got to be a better way to do this, the grid's getting replaced every frame (?)
		{
			case '3x':
				remove(grid);
				grid = new FlxTiledSprite("assets/images/3xGrid.png", item.width, item.height, true, true);
				add(grid);
				mag = 3;
				item.setGraphicSize(item.frameWidth * mag, item.frameHeight * mag);
				item.x = 0;
				item.y = 0;
				item.updateHitbox();
			case '4x':
				remove(grid);
				grid = new FlxTiledSprite("assets/images/4xGrid.png", item.width, item.height, true, true);
				add(grid);
				mag = 4;
				item.setGraphicSize(item.frameWidth * mag, item.frameHeight * mag);
				item.x = 0;
				item.y = 0;
				item.updateHitbox();
			case '5x':
				remove(grid);
				grid = new FlxTiledSprite("assets/images/5xGrid.png", item.width, item.height, true, true);
				add(grid);
				mag = 5;
				item.setGraphicSize(item.frameWidth * mag, item.frameHeight * mag);
				item.x = 0;
				item.y = 0;
				item.updateHitbox();
		}
	}
}