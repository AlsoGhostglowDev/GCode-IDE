package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, states.CodeState));

		lime.app.Application.current.window.borderless = true;
		lime.app.Application.current.window.width += 32;
	}
}
