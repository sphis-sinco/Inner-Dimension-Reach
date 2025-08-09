package play;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import haxe.exceptions.ArgumentException;

class PlayState extends FlxState
{
	public var ui_options:Map<String, Array<Dynamic>> = [
		'main' => [
			{
				name: 'Attacks',
				ui_menu: 'attacks'
			},
			{
				name: 'Skills',
				ui_menu: 'skills'
			},
			{
				name: 'Stats',
				ui_menu: 'stats'
			},
			{
				name: 'Items',
				ui_menu: 'items'
			},
			{
				name: 'Run',
				disabled: true
			}
		]
	];

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

		ui_box = new FlxSprite().makeGraphic(320, FlxG.height);
		ui_box_contents = new FlxTypedGroup<FlxBasic>();

		addObject(ui_box);
		addObject(ui_box_contents);

		load_ui_menu('puzy');

		super.create();
	}

	function load_ui_menu(ui_menu:String)
	{
		for (item in ui_box_contents)
		{
			item.destroy();
			ui_box_contents.remove(item);
		}

		if (!ui_options.exists(ui_menu))
		{
			trace(new ArgumentException('', 'Non-existing ui_menu "$ui_menu"'));
			return;
		}

		for (item in ui_options.get(ui_menu)) {}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
