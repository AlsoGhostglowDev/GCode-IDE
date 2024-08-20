package objects;

import lime.app.Application;

class WindowHeader extends FlxSpriteGroup {
	var _minimizeButton:WindowHeaderButton;
	var _maximizeButton:WindowHeaderButton;
    var _exitButton:WindowHeaderButton;

	var _icon:FlxSprite;
    var _title:FlxText;

    public function new() {
        super();

        Theme.theme = DARK;

        _exitButton = new WindowHeaderButton(FlxG.width - 32, 32, 32, new FlxSprite().loadGraphic(Paths.getPathDirectly('images', 'window_header/EXIT')), {
			idle: Theme.themeColors?.header_idle_button ?? 0xFF111921,
			hovered: FlxColor.RED,
			clicked: Theme.themeColors?.header_clicked_button ?? FlxColor.WHITE
        }, () -> Sys.exit(0));
        add(_exitButton);

		_maximizeButton = new WindowHeaderButton(FlxG.width - 64, 32, 32, new FlxSprite().loadGraphic(Paths.getPathDirectly('images', 'window_header/MAXIMIZE')), {
			idle: Theme.themeColors?.header_idle_button ?? 0xFF111921,
			hovered: FlxColor.RED,
			clicked: Theme.themeColors?.header_clicked_button ?? FlxColor.WHITE
			}, () -> Application.current.window.maximized = !Application.current.window.maximized);
		add(_maximizeButton);

		_minimizeButton = new WindowHeaderButton(FlxG.width - 96, 32, 32, new FlxSprite().loadGraphic(Paths.getPathDirectly('images', 'window_header/MINIMIZE')), {
			idle: Theme.themeColors?.header_idle_button ?? 0xFF111921,
			hovered: FlxColor.RED,
			clicked: Theme.themeColors?.header_clicked_button ?? FlxColor.WHITE
		}, () -> Application.current.window.minimized = !Application.current.window.minimized);
		add(_minimizeButton);
    }
}

typedef WindowHeaderColors = {
    idle:FlxColor,
    hovered:FlxColor,
    clicked:FlxColor
}

class WindowHeaderButton extends FlxSpriteGroup {
    public var bg:FlxSprite;
    public var buttonSprite:FlxSprite;
    public var colors:WindowHeaderColors;
    public var onClick:Void->Void;

	public function new(x:Float = 0, width:Int = 32, height:Int = 32, buttonSprite:FlxSprite, colors:WindowHeaderColors, onClick:Void->Void) {
        super();

        bg = new FlxSprite(x, 0).makeGraphic(width, height);
        add(bg);

        this.buttonSprite = buttonSprite;
        buttonSprite.updateHitbox();
		add(buttonSprite);

        this.colors = colors;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        buttonSprite.setPosition(
            bg.x + ((bg.width - buttonSprite.width) / 2),
		    bg.y + ((bg.height - buttonSprite.height) / 2)
        );

        if (FlxG.mouse.overlaps(buttonSprite) && FlxG.mouse.justPressed) {
            buttonSprite.color = colors.clicked;
            onClick();
        }
        
        var targetColor = FlxG.mouse.overlaps(bg) ? colors.hovered : colors.idle;
        bg.color = FlxColor.interpolate(bg.color, targetColor, 0.2 * (elapsed * 60));
    }
}