import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;


var background:FlxSprite;
var playButton:FlxButton;

function create(){
    // Create background
    background = new FlxSprite(0, 0).loadGraphic("assets/background.png");
    //add(background);

    // Create play button
    playButton = new FlxButton(100, 100, "Play", onClick);
    add(playButton);
}

function onClick() FlxG.log.add("Play button clicked!");

// Add some animations and transitions
function create(){ 
    // Create animation for play button
    //playButton.animation.add("idle", [0, 1], 4);
    //playButton.animation.add("hover", [2, 3], 4);
    //playButton.animation.play("idle");
    
    // Create animation for settings button
    //settingsButton.animation.add("idle", [4, 5], 4);
    //settingsButton.animation.add("hover", [6, 7], 4);
    //settingsButton.animation.play("idle");
    
    // Create animation for credits button
    //creditsButton.animation.add("idle", [8, 9], 4);
    //creditsButton.animation.add("hover", [10, 11], 4);
    //creditsButton.animation.play("idle");
    
    // Add some flair with a fade-in effect
    FlxTween.tween(background, { alpha: 1 }, 1, { ease: FlxEase.circInOut });
    FlxTween.tween(menuGroup, { alpha: 1 }, 1, { ease: FlxEase.circInOut });
}
    
function onClickPlay(){
    // Handle play button click
    FlxG.log.add("Play button clicked!");
    
    // Add some animation to the play button click
    playButton.animation.play("hover");
    FlxTween.tween(playButton, { x: playButton.x - 10 }, 0.5, { ease: FlxEase.backInOut });
    FlxTween.tween(playButton, { x: playButton.x + 10 }, 0.5, { startDelay: 0.5, ease: FlxEase.backInOut });
}
    
    function onClickSettings(){
        // Handle settings button click
        FlxG.log.add("Settings button clicked!");
    
        // Add some animation to the settings button click
        settingsButton.animation.play("hover");
        FlxTween.tween(settingsButton, { x: settingsButton.x - 10 }, 0.5, { ease: FlxEase.backInOut });
        FlxTween.tween(settingsButton, { x: settingsButton.x + 10 }, 0.5, { startDelay: 0.5, ease: FlxEase.backInOut });
    }
    
function onClickCredits(){
    // Handle credits button click
    FlxG.log.add("Credits button clicked!");
    
    // Add some animation to the credits button click
    creditsButton.animation.play("hover");
    FlxTween.tween(creditsButton, { x: creditsButton.x - 10 }, 0.5, { ease: FlxEase.backInOut });
    FlxTween.tween(creditsButton, { x: creditsButton.x + 10 }, 0.5, { startDelay: 0.5, ease: FlxEase.backInOut });
}

function update() if (controls.BACK) FlxG.switchState(new ModState('mineMain'));