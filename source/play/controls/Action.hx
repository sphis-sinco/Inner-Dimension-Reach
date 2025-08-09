package play.controls;

enum Action
{
	@:inputs([FlxKey.UP, FlxKey.W])
	UP;

	@:inputs([FlxKey.DOWN, FlxKey.S])
	DOWN;

	@:inputs([FlxKey.LEFT, FlxKey.A])
	LEFT;

	@:inputs([FlxKey.RIGHT, FlxKey.D])
	RIGHT;

	@:inputs([FlxKey.ENTER])
	ACCEPT;

	@:inputs([FlxKey.ESCAPE, FlxKey.BACKSPACE])
	BACK;
}
