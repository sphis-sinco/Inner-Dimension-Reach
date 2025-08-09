package play;

import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	public var ui_box:FlxSprite;
	public var ui_box_contents:FlxTypedGroup<FlxBasic>;

	override public function create()
	{
		ui_box = new FlxSprite().makeGraphic(480, FlxG.height);
		ui_box_contents = new FlxTypedGroup<FlxBasic>();

		add(ui_box);
		add(ui_box_contents);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
