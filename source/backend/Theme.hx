package backend;

enum Themes {
    BLACKOUT;
    DARK;
    LIGHT;
}

typedef ThemeColors = {
    header_idle_button:FlxColor,
	header_hovered_button:FlxColor,
	header_clicked_button:FlxColor,

    sidebar:FlxColor,
    background:FlxColor
}

class Theme {
    public var defaultTheme:Themes = DARK;
    public static var theme:Themes = DARK;

    public static var themeColors:ThemeColors;
    private function set_theme(newTheme:Themes) {
        themeColors = switch(newTheme) {
            case BLACKOUT:
                {
					header_idle_button: FlxColor.BLACK,
					header_hovered_button: 0xFF303030,
					header_clicked_button: FlxColor.WHITE,

					sidebar: FlxColor.BLACK,
					background: 0xFF171717
                }
            case DARK:
				{
					header_idle_button: 0xFF111921,
					header_hovered_button: 0xFF455668,
					header_clicked_button: 0xFF97B2CD,

					sidebar: 0xFF111921,
					background: 0xFF213142
				}
            case LIGHT:
				{
					header_idle_button: FlxColor.WHITE,
					header_hovered_button: 0xFF8AFFDA,
					header_clicked_button: 0xFF00FFC3,

					sidebar: FlxColor.WHITE,
					background: 0xFFB0FFE9
				}
        }

        return theme = newTheme;
    }
}