package play;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.exceptions.ArgumentException;
import play.controls.Controls;

typedef UI_Option =
{
	var name:String;
	var ?script_event:ScriptEvent;
	var ?ui_menu:String;
	var ?original_ui_menu:String;
	var ?disabled:Bool;
}

class PlayState extends FlxState
{
	public static var instance:PlayState;

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
				script_event: {name: 'playerAttack_gayBeam'},
				ui_menu: 'main'
			},
			{
				name: 'Makankosappo',
				script_event: {name: 'playerAttack_makankosappo'},
				ui_menu: 'main'
			},
		]
	];

	public var ui_option_menu:String = '';
	public var ui_option_selection:Int = 0;

	public var ui_box:FlxSprite;
	public var ui_box_text_contents:FlxTypedGroup<FlxText>;

	public var opponent:FlxSprite;
	public var player:FlxSprite;
	public var player_turn:Bool = true;

	public var controls:Controls;

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

		if (instance != null)
			instance = null;
		instance = this;

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
		ui_box_text_contents = new FlxTypedGroup<FlxText>();

		addObject(ui_box);
		addObject(ui_box_text_contents);

		load_ui_menu('main');

		controls = new Controls('main');
		FlxG.inputs.addInput(controls);

		super.create();
	}

	public function load_ui_menu(ui_menu:String)
	{
		if (!ui_options.exists(ui_menu))
		{
			trace(new ArgumentException('', 'Non-existing ui_menu "$ui_menu"'));
			return;
		}

		ui_option_menu = ui_menu;

		for (item in ui_box_text_contents)
		{
			item.destroy();
			ui_box_text_contents.remove(item);
		}

		for (i in 0...ui_options.get(ui_menu).length)
		{
			var item = ui_options.get(ui_menu)[i];
			var text = new FlxText(0, 64 + ((128 * (ui_options.get(ui_menu).length / 5)) * i), ui_box.width, item.name, 16);
			text.color = FlxColor.BLACK;
			text.alignment = 'center';
			text.ID = i;

			ui_box_text_contents.add(text);
		}

		ui_option_selection = 0;
		ui_box_text_contents_update();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (player_turn)
		{
			ui_box_text_contents_update();
			ui_controls_check();
		}
	}

	public function ui_controls_check():Void
	{
		if (controls.justReleased.DOWN)
		{
			ui_option_selection++;
		}
		else if (controls.justReleased.UP)
		{
			ui_option_selection--;
		}
		else if (controls.justReleased.ACCEPT)
		{
			final ui_menu = ui_options.get(ui_option_menu);
			final ui_opt = ui_menu[ui_option_selection];
			final script_event = ui_opt.script_event;

			if (ui_opt.ui_menu != null)
				load_ui_menu(ui_opt.ui_menu);
			if (script_event != null)
				ScriptsManager.callScript(script_event.name ?? '', script_event.args ?? []);

			if (ui_option_menu == 'attacks')
			{
				player_turn = false;
				switch_turn();
				op_turn();
			}
		}
		else if (controls.justReleased.BACK)
		{
			load_ui_menu(ui_options.get(ui_option_menu)[ui_option_selection].original_ui_menu ?? 'main');
		}

		if (ui_option_selection < 0)
			ui_option_selection = 0;
		if (ui_option_selection >= ui_box_text_contents.members.length)
			ui_option_selection = ui_box_text_contents.members.length - 1;
	}

	function switch_turn()
	{
		trace(new haxe.exceptions.NotImplementedException());
	}

	public function ui_box_text_contents_update()
	{
		for (item in ui_box_text_contents.members)
		{
			if (item != null)
			{
				final selected = item.ID == ui_option_selection;

				item.color = (selected) ? FlxColor.YELLOW : FlxColor.BLACK;
			}
		}
	}

	public function op_turn() {}
}
