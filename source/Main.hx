package;

import openfl.display.Sprite;

class Main extends Sprite
{
	public static var RELEASE_NUMBER:Int = 0;

	public function new()
	{
		super();

		FlxModding.init();

		@:privateAccess {
			ScriptsManager.loadScripts();
		}

		addChild(new FlxGame(0, 0, PlayState));
	}
}
