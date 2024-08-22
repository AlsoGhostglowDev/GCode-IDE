package objects;

import hl.UI;
import lime.app.Application;

typedef HeaderSize = {
    width:Int,
	height:Int
}

class WindowHeader extends FlxSpriteGroup {
	var _minimizeButton:WindowHeaderButton;
	var _maximizeButton:WindowHeaderButton;
    var _exitButton:WindowHeaderButton;

    var _headerBG:FlxSprite;
	var _icon:FlxSprite;
    var _title:FlxText;

    var _headerSize:HeaderSize;

    public function new() {
        super();

        _headerSize = {width: FlxG.width, height: 45};
        Theme.theme = DARK;

		_headerBG = new FlxSprite().makeGraphic(FlxG.width, _headerSize.height, Theme.themeColors?.header_idle_button ?? 0xFF111921);
        add(_headerBG);

        _icon = new FlxSprite().loadGraphic(Paths.getPathDirectly('images', 'window_header/APP_ICON'));
        add(_icon);

        _title = new FlxText(50, 6, 0, Application.current.window.title);
        _title.setFormat(Paths.font('firacode.ttf'), 22, Theme.theme == DARK ? FlxColor.WHITE : FlxColor.BLACK);
        add(_title);

        for (i in 0...3) {
            var button = [_exitButton, _maximizeButton, _minimizeButton][i];
            final graphic = ['EXIT', 'UNMAXIMIZE', 'MINIMIZE'][i];
			final onClick = [
                () -> Sys.exit(0), 
				() -> { 
                    Application.current.window.maximized = !Application.current.window.maximized;
					_maximizeButton?.buttonSprite.loadGraphic(Application.current.window.maximized ? Paths.getPathDirectly('images','window_header/UNMAXIMIZE') : Paths.getPathDirectly('images', 'window_header/MAXIMIZE')); 
                }, 
				() -> Application.current.window.minimized = !Application.current.window.minimized
            ][i];

			button = new WindowHeaderButton(FlxG.width - (_headerSize.height * (i + 1)), _headerSize.height, _headerSize.height, new FlxSprite().loadGraphic(Paths.getPathDirectly('images', 'window_header/$graphic')), {
				idle: Theme.themeColors?.header_idle_button ?? 0xFF111921,
				hovered: (i == 0) ? FlxColor.RED : Theme.themeColors?.header_hovered_button ?? 0xFF888888,
				clicked: Theme.themeColors?.header_clicked_button ?? FlxColor.WHITE
            }, onClick);
            add(button);
        }
    }


    override function update(dt:Float) {
        super.update(dt);

        if (FlxG.mouse.pressed && FlxG.mouse.overlaps(_headerBG)) {
			final window = Application.current.window;
			window.x += Std.int(FlxG.mouse.deltaScreenX * 1.2);
			window.y += Std.int(FlxG.mouse.deltaScreenY * 1.2);
        }
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

    public var buttonOffsets:{x:Float, y:Float};

	public function new(x:Float = 0, width:Int = 32, height:Int = 32, buttonSprite:FlxSprite, colors:WindowHeaderColors, onClick:Void->Void) {
        super();

        bg = new FlxSprite(x).makeGraphic(width, height);
        add(bg);

        this.buttonSprite = buttonSprite;
        buttonSprite.updateHitbox();
		buttonOffsets = {x: buttonSprite.x, y: buttonSprite.y};
		add(buttonSprite);

        this.colors = colors;
        this.onClick = onClick;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        buttonSprite.setPosition(
            buttonOffsets.x + (bg.x + ((bg.width - buttonSprite.width) / 2)),
			buttonOffsets.y + (bg.y + ((bg.height - buttonSprite.height) / 2))
        );

        if (FlxG.mouse.overlaps(bg) && FlxG.mouse.justPressed) {
            buttonSprite.color = colors.clicked;
            onClick();
        }
        
        var targetColor = FlxG.mouse.overlaps(bg) ? colors.hovered : colors.idle;
        bg.color = FlxColor.interpolate(bg.color, targetColor, 0.2 * (elapsed * 60));
    }
}