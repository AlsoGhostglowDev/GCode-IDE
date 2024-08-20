package backend;

import objects.WindowHeader;
import flixel.FlxCamera;

class BaseState extends FlxUIState {
    public static var instance:BaseState;
    public var exitFunc:Void->Void = () -> BaseState.instance.switchState(new states.CodeState());

    public var canSwitchState:Bool = false;
    public var canPause:Bool = true;

    public var headerCam:FlxCamera;

    public function new() {
        super();

		instance = this;

        var windowHeader = new WindowHeader();
        add(windowHeader);

        headerCam = new FlxCamera();
        headerCam.bgColor.alpha = 0;
        FlxG.cameras.add(headerCam, false);

        windowHeader.camera = headerCam;

        FlxG.cameras.cameraAdded.add((camera) -> {
            if (camera != headerCam) {
                FlxG.cameras.remove(headerCam, false);
                FlxG.cameras.add(headerCam, false);
            }
        });
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    public function switchState(nextState:BaseState) {
        canSwitchState = false;
    }
}