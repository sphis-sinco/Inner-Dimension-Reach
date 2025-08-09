package play;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.exceptions.ArgumentException;

typedef UI_Option =
{
	var name:String;
	var ?script_event:ScriptEvent;
	var ?ui_menu:String;
	var ?disabled:Bool;
}

class PlayState extends FlxState
{
	public var ui_options:Map<String, Array<UI_Option>> = [
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
		],
		'attacks' => [
			{
				name: 'Gay beam',
				script_event: {name: 'playerAttack_gayBeam'}
			},
			{
				name: 'Makankōsappō',
				script_event: {name: 'playerAttack_makankosappo'}
			},
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

		load_ui_menu('main');

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

		for (i in 0...ui_options.get(ui_menu).length)
		{
			var item = ui_options.get(ui_menu)[i];
			var text = new FlxText(0, 64 + ((128 * (ui_options.get(ui_menu).length / 5)) * i), ui_box.width, item.name, 16);
			text.color = FlxColor.BLACK;
			text.alignment = 'center';

			ui_box_contents.add(text);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
