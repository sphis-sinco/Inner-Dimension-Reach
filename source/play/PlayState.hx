package play;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var ui_box:FlxSprite;
	public var ui_box_contents:FlxTypedGroup<FlxBasic>;

	public var opponent:FlxSprite;
	public var player:FlxSprite;

	public var addObject = function(object:FlxBasic) {};

	override public function create()
	{
		addObject = object ->
		{
			if (object == null)
			{
				trace('NULL OBJECT, SHOULDNT BE DOIN THAT BRO');
				return;
			}

			add(object);
		}

		opponent = new FlxSprite().makeGraphic(256, 512, FlxColor.GRAY);
		player = new FlxSprite().makeGraphic(256, 256, FlxColor.PURPLE);

		opponent.y = FlxG.height - opponent.height;
		player.y = FlxG.height - player.height;

		opponent.screenCenter(X);
		opponent.x += opponent.width * 1.75;
		player.screenCenter(X);

		addObject(opponent);
		addObject(player);

		ui_box = new FlxSprite().makeGraphic(480, FlxG.height);
		ui_box_contents = new FlxTypedGroup<FlxBasic>();

		addObject(ui_box);
		addObject(ui_box_contents);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
