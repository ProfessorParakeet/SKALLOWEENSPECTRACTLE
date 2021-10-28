package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;
	public var nextDialogueThing:Void->Void = null;
	public var skipDialogueThing:Void->Void = null;

	var portraitLeft:FlxSprite;
	var portraitLeftA:FlxSprite;
	var portraitLeftN:FlxSprite;
	var portraitAlfieH:FlxSprite;
	var portraitAlfieN:FlxSprite;
	var portraitAlfieA:FlxSprite;
	var portraitBF:FlxSprite;
	var portraitGF:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 380);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear instance 1', [4], "", 24);
				
			case 'eleventh-hour':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/dialogbox');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false); trace("ha");
				box.animation.addByIndices('normal', 'Text Box Appear instance 1', [4], "", 24); trace("haaa");

			case 'superduperstitious':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/dialogbox');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false); trace("ha");
				box.animation.addByIndices('normal', 'Text Box Appear instance 1', [4], "", 24); trace("haaa");


			case 'all-saints-scramble':
				hasDialog = true; trace ("tesat has dialog");
				box.frames = Paths.getSparrowAtlas('weeb/dialogbox');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false); trace("ha");
				box.animation.addByIndices('normal', 'Text Box Appear instance 1', [4], "", 24); trace("haaa"); 


			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH instance 1', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn instance 1', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(110, 80);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/FilipH');
		portraitLeft.animation.addByPrefix('enter', 'Filip Happy', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.1));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftA = new FlxSprite(125, 80);
		portraitLeftA.frames = Paths.getSparrowAtlas('weeb/FilipA');
		portraitLeftA.animation.addByPrefix('enter', 'Filip Angry', 24, false);
		portraitLeftA.setGraphicSize(Std.int(portraitLeftA.width * PlayState.daPixelZoom * 0.1));
		portraitLeftA.updateHitbox();
		portraitLeftA.scrollFactor.set();
		add(portraitLeftA);
		portraitLeftA.visible = false;

		portraitLeftN = new FlxSprite(110, 80);
		portraitLeftN.frames = Paths.getSparrowAtlas('weeb/FilipN');
		portraitLeftN.animation.addByPrefix('enter', 'Filip Nervous', 24, false);
		portraitLeftN.setGraphicSize(Std.int(portraitLeftN.width * PlayState.daPixelZoom * 0.1));
		portraitLeftN.updateHitbox();
		portraitLeftN.scrollFactor.set();
		add(portraitLeftN);
		portraitLeftN.visible = false;

		portraitAlfieH = new FlxSprite(900, 80);
		portraitAlfieH.frames = Paths.getSparrowAtlas('weeb/AlfieH');
		portraitAlfieH.animation.addByPrefix('enter', 'Alfie Happy', 24, false);
		portraitAlfieH.setGraphicSize(Std.int(portraitAlfieH.width * PlayState.daPixelZoom * 0.1));
		portraitAlfieH.updateHitbox();
		portraitAlfieH.scrollFactor.set();
		add(portraitAlfieH);
		portraitAlfieH.visible = false;


		portraitBF = new FlxSprite(800, 150);
		portraitBF.frames = Paths.getSparrowAtlas('weeb/BF');
		portraitBF.animation.addByPrefix('enter', 'bfp', 24, false);
		portraitBF.setGraphicSize(Std.int(portraitBF.width * PlayState.daPixelZoom * 0.135));
		portraitBF.updateHitbox();
		portraitBF.scrollFactor.set();
		add(portraitBF);
		portraitBF.visible = false;

		portraitGF = new FlxSprite(800, 150);
		portraitGF.frames = Paths.getSparrowAtlas('weeb/GF');
		portraitGF.animation.addByPrefix('enter', 'gfp', 24, false);
		portraitGF.setGraphicSize(Std.int(portraitGF.width * PlayState.daPixelZoom * 0.135));
		portraitGF.updateHitbox();
		portraitGF.scrollFactor.set();
		add(portraitGF);
		portraitGF.visible = false;

		portraitAlfieA = new FlxSprite(900, 80);
		portraitAlfieA.frames = Paths.getSparrowAtlas('weeb/AlfieA');
		portraitAlfieA.animation.addByPrefix('enter', 'Alfie Angry', 24, false);
		portraitAlfieA.setGraphicSize(Std.int(portraitAlfieA.width * PlayState.daPixelZoom * 0.1));
		portraitAlfieA.updateHitbox();
		portraitAlfieA.scrollFactor.set();
		add(portraitAlfieA);
		portraitAlfieA.visible = false;
		
		portraitAlfieN = new FlxSprite(900, 80);
		portraitAlfieN.frames = Paths.getSparrowAtlas('weeb/AlfieN');
		portraitAlfieN.animation.addByPrefix('enter', 'Alfie Neutral', 24, false);
		portraitAlfieN.setGraphicSize(Std.int(portraitAlfieN.width * PlayState.daPixelZoom * 0.1));
		portraitAlfieN.updateHitbox();
		portraitAlfieN.scrollFactor.set();
		add(portraitAlfieN);
		portraitAlfieN.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.125));
		box.updateHitbox();
		add(box);
		trace("it works");
		box.screenCenter(X);
		

		handSelect = new FlxSprite(1042, 590).loadGraphic(Paths.getPath('images/weeb/pixelUI/hand_textbox.png', IMAGE));
		handSelect.setGraphicSize(Std.int(handSelect.width * PlayState.daPixelZoom * 0.9));
		handSelect.updateHitbox();
		handSelect.visible = false;
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	var dialogueEnded:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal'); trace("haaaaaaaaaa");
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if(PlayerSettings.player1.controls.ACCEPT)
		{
			if (dialogueEnded)
			{
				remove(dialogue);
				if (dialogueList[1] == null && dialogueList[0] != null)
				{
					if (!isEnding)
					{
						isEnding = true;
						FlxG.sound.play(Paths.sound('clickText'), 0.8);	

						if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns'  || PlayState.SONG.song.toLowerCase() == 'eleventh-hour'  ||  PlayState.SONG.song.toLowerCase() == 'superduperstitious'  || PlayState.SONG.song.toLowerCase() == 'all-saints-scramble') trace ("tesat fade");
							FlxG.sound.music.fadeOut(1.5, 0);

						new FlxTimer().start(0.2, function(tmr:FlxTimer)
						{
							box.alpha -= 1 / 5;
							bgFade.alpha -= 1 / 5 * 0.7;
							portraitLeft.visible = false;
							portraitAlfieH.visible = false;
							portraitLeftA.visible = false;
							portraitLeftN.visible = false;
							portraitBF.visible = false;
							portraitGF.visible = false;
							portraitAlfieN.visible = false;
							portraitAlfieA.visible = false;
							swagDialogue.alpha -= 1 / 5;
							handSelect.alpha -= 1 / 5;
							dropText.alpha = swagDialogue.alpha;
						}, 5);

						new FlxTimer().start(1.5, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
				}
				else
				{
					dialogueList.remove(dialogueList[0]);
					startDialogue();
					FlxG.sound.play(Paths.sound('clickText'), 0.8);
				}
			}
			else if (dialogueStarted)
			{
				FlxG.sound.play(Paths.sound('clickText'), 0.8);
				swagDialogue.skip();
				
				if(skipDialogueThing != null) {
					skipDialogueThing();
				}
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		swagDialogue.completeCallback = function() {
			handSelect.visible = true;
			dialogueEnded = true;
		};

		handSelect.visible = false;
		dialogueEnded = false;
		switch (curCharacter)
		{
			case 'filiph':
				portraitAlfieH.visible = false;
				portraitLeftA.visible = false;
				portraitLeftN.visible = false;
				portraitBF.visible = false;
				portraitGF.visible = false;
				portraitAlfieN.visible = false;
				portraitAlfieA.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'filipa':
				portraitAlfieH.visible = false;
				portraitLeft.visible = false;
				portraitLeftN.visible = false;
				portraitBF.visible = false;
				portraitGF.visible = false;
				portraitAlfieN.visible = false;
				portraitAlfieA.visible = false;
				if (!portraitLeftA.visible)
				{
					portraitLeftA.visible = true;
					portraitLeftA.animation.play('enter');
				}

			case 'filipn':
				portraitAlfieH.visible = false;
				portraitLeftA.visible = false;
				portraitLeft.visible = false;
				portraitBF.visible = false;
				portraitGF.visible = false;
				portraitAlfieN.visible = false;
				portraitAlfieA.visible = false;
				if (!portraitLeftN.visible)
				{
					portraitLeftN.visible = true;
					portraitLeftN.animation.play('enter');
				}
				
			case 'alfieh':
				portraitLeft.visible = false;
				portraitLeftA.visible = false;
				portraitLeftN.visible = false;
				portraitBF.visible = false;
				portraitGF.visible = false;
				portraitAlfieN.visible = false;
				portraitAlfieA.visible = false;
				if (!portraitAlfieH.visible)
				{
					portraitAlfieH.visible = true;
					portraitAlfieH.animation.play('enter');
				}
			case 'alfiea':
				portraitLeft.visible = false;
				portraitLeftA.visible = false;
				portraitLeftN.visible = false;
				portraitBF.visible = false;
				portraitGF.visible = false;
				portraitAlfieN.visible = false;
				portraitAlfieH.visible = false;
				if (!portraitAlfieA.visible)
				{
					portraitAlfieA.visible = true;
					portraitAlfieA.animation.play('enter');
					
				}

			case 'alfien':
				portraitLeft.visible = false;
				portraitLeftA.visible = false;
				portraitLeftN.visible = false;
				portraitBF.visible = false;
				portraitGF.visible = false;
				portraitAlfieA.visible = false;
				portraitAlfieH.visible = false;
				if (!portraitAlfieN.visible)
				{
					portraitAlfieN.visible = true;
					portraitAlfieN.animation.play('enter');
					
				}

			case 'bf':
				portraitLeft.visible = false;
				portraitLeftA.visible = false;
				portraitLeftN.visible = false;
				portraitAlfieN.visible = false;
				portraitGF.visible = false;
				portraitAlfieA.visible = false;
				portraitAlfieH.visible = false;
				if (!portraitBF.visible)
				{
					portraitBF.visible = true;
					portraitBF.animation.play('enter');
					
				}

			case 'gf':
				portraitLeft.visible = false;
				portraitLeftA.visible = false;
				portraitLeftN.visible = false;
				portraitAlfieN.visible = false;
				portraitBF.visible = false;
				portraitAlfieA.visible = false;
				portraitAlfieH.visible = false;
				if (!portraitGF.visible)
				{
					portraitGF.visible = true;
					portraitGF.animation.play('enter');
					
				}
		}
		if(nextDialogueThing != null) {
			nextDialogueThing();
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
