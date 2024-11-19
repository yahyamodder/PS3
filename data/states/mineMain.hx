import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxTypedGroup;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import flixel.text.FlxTextBorderStyle;
import funkin.menus.MainMenuState;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.backend.scripting.Script;
import flexel.FlxAxes;

var portVer:Int = 0.1;

var optionShit:Array<String> = CoolUtil.coolTextFile(Paths.txt("config/minecraft"));
var menuItems:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();
var confirm, cancel, locked:FlxSound;

var shopTxtTween, shakeTweenX, shakeTweenY, shakeTweenAngle:FlxTween;

var curSelected:Int = 0;

function create(){
	CoolUtil.playMenuSong();
	FlxG.mouse.visible = true;

	// loads sounds in for no lag when selecting something
	confirm = FlxG.sound.load(Paths.sound('mineClick'));
	cancel = FlxG.sound.load(Paths.sound('cancel'));
	locked = FlxG.sound.load(Paths.sound('locked'));

	bg = new FlxBackdrop(Paths.image('mine/bg'), FlxAxes.X);
	bg.y = 288;
	bg.scrollFactor.set();
	bg.antialiasing = true;
	bg.scale.set(5,5);
	bg.velocity.set(-30,0);
	add(bg);
	
	oButton = new FlxSprite(179, 654);
	oButton.frames = Paths.getSparrowAtlas('mine/back');
	oButton.animation.addByPrefix('idle', 'back', 1, true);
	oButton.animation.addByPrefix('select', 'select', 1, false);
	oButton.animation.play('idle');
	oButton.antialiasing = false;
	add(oButton);

	xButton = new FlxSprite(62, 655);
	xButton.frames = Paths.getSparrowAtlas('mine/select');
	xButton.animation.addByPrefix('idle', 'select', 1, true);
	xButton.animation.addByPrefix('select', 'selected', 1, false);
	xButton.animation.play('idle');
	xButton.antialiasing = false;
	add(xButton);

	logo = new FlxSprite(358, 59).loadGraphic(Paths.image('mine/logo'));
	logo.antialiasing = false;
	add(logo);

	tabShit = new FunkinText(5, FlxG.height, 0, 'Work in Progress! | Press TAB to go back to the XMB.');
	tabShit.y -= tabShit.height;
	tabShit.antialiasing = false;
	add(tabShit);

	for (i=>option in optionShit){
		var menuItem:FlxSprite = new FlxSprite(148, 0);
		menuItem.frames = Paths.getSparrowAtlas('mine/butts/' + option);
		menuItem.animation.addByPrefix('idle', "idle", 24, false);
		menuItem.animation.addByPrefix('hover', "hover", 24, true);
		menuItem.screenCenter(FlxAxes.X);
		menuItem.animation.play('idle');
		menuItem.updateHitbox();
		menuItem.antialiasing = false;
		menuItem.y = 250 + (((menuItem.ID = i) * 50));
		if (option == 'misc') menuItem.x += 80;
		menuItems.add(menuItem);
	}
	add(menuItems);	
	//onChangeItem(0);
	updateItems();
}

function onChangeItem(change) {

	curSelected = FlxMath.wrap(curSelected + change, 0, menuItems.length - 1);

	menuItems.forEach(function(spr:FlxSprite){
		FlxTween.cancelTweensOf(spr);

		if (spr.ID == curSelected){
			spr.animation.play('hover', true);
	        FlxG.sound.play(Paths.sound("locked"), 0.7);
		}
		else spr.animation.play('idle');

		spr.updateHitbox();
		spr.centerOffsets();
	});
}

function goToItem() {
	optionsSelectedSomethin = true;
	var optionSelected = menuItems.members[curSelected];
	optionSelected.animation.play('select');


	switch (optionShit[curSelected]){
		case "play":
			//FlxG.sound.play(Paths.sound("locked"), 0.7);
			//gyat
		case "mini":
			FlxG.sound.play(Paths.sound('mineClick'), 0.7);
			xButton.animation.play('select');
			new FlxTimer().start(.1, function(tmr:FlxTimer){
			FlxG.switchState(new FreeplayState());
			});
		case "leaderboard":
			optionSelected.setPosition(40, 289);
			new FlxTimer().start(1, (_) -> FlxG.switchState(new ModState("GraphicsOptions")));
		case "options":
			optionSelected.setPosition(134, 449);
			new FlxTimer().start(1, (_) -> FlxG.switchState(new ModState("MiscOptions")));
		case "store":
			//gyaaatttsssss

		default: optionsSelectedSomethin = false;
	}
}

var selectedSomethin:Bool = false;

function update(elapsed){
	if (FlxG.sound.music.volume < 0.8) FlxG.sound.music.volume += 0.5 * elapsed;

	if (controls.DOWN_P || FlxG.mouse.wheel < 0) onChangeItem(1);
	if (controls.UP_P || FlxG.mouse.wheel > 0) onChangeItem(-1);
	if (controls.ACCEPT || FlxG.mouse.justPressed) {
		goToItem();
		xButton.animation.play('select');
	}
	if (FlxG.keys.justPressed.FIVE) FlxG.switchState(new ModState("ps3")); 

    if (FlxG.keys.justPressed.SEVEN){
		persistentUpdate = !(persistentDraw = true);
		openSubState(new EditorPicker());
	}

	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = !(persistentDraw = true);
	}

	if (controls.BACK || FlxG.mouse.justPressedRight){
		cancel.play();
		oButton.animation.play('select');
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false);
		new FlxTimer().start(.75, function(tmr:FlxTimer){
			FlxG.switchState(new TitleState());
		});
	}
}

function updateItems() {
	menuItems.forEach(function(spr:FunkinSprite) {
		spr.animation.play('idle');
		if (spr.ID == curSelected) spr.animation.play('hover');
	});
}