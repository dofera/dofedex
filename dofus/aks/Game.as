class dofus.aks.Game extends dofus.aks.Handler
{
	static var TYPE_SOLO = 1;
	static var TYPE_FIGHT = 2;
	var _bIsBusy = false;
	var _aGameSpriteLeftHistory = new Array();
	var nLastMapIdReceived = -1;
	function Game(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function __get__isBusy()
	{
		return this._bIsBusy;
	}
	function create()
	{
		this.aks.send("GC" + dofus.aks.Game.TYPE_SOLO);
	}
	function leave(loc2)
	{
		this.aks.send("GQ" + (loc2 != undefined?loc2:""));
	}
	function setPlayerPosition(loc2)
	{
		this.aks.send("Gp" + loc2,true);
	}
	function ready(loc2)
	{
		this.aks.send("GR" + (!loc2?"0":"1"));
	}
	function getMapData(loc2)
	{
		if(this.api.lang.getConfigText("ENABLE_CLIENT_MAP_REQUEST"))
		{
			this.aks.send("GD" + (loc2 == undefined?"":String(loc2)));
		}
	}
	function getExtraInformations()
	{
		this.aks.send("GI");
	}
	function turnEnd()
	{
		if(this.api.datacenter.Player.isCurrentPlayer)
		{
			this.aks.send("Gt",false);
		}
	}
	function turnOk(loc2)
	{
		this.aks.send("GT" + (loc2 == undefined?"":loc2),false);
	}
	function turnOk2(loc2)
	{
		this.aks.send("GT" + (loc2 == undefined?"":loc2),false);
	}
	function askDisablePVPMode()
	{
		this.aks.send("GP*",false);
	}
	function enabledPVPMode(loc2)
	{
		this.aks.send("GP" + (!loc2?"-":"+"),false);
	}
	function freeMySoul()
	{
		this.aks.send("GF",false);
	}
	function setFlag(loc2)
	{
		this.aks.send("Gf" + loc2,false);
	}
	function showFightChallengeTarget(loc2)
	{
		this.aks.send("Gdi" + loc2,false);
	}
	function onCreate(loc2, loc3)
	{
		if(!loc2)
		{
			ank.utils.Logger.err("[onCreate] Impossible de créer la partie");
			return undefined;
		}
		var loc4 = loc3.split("|");
		var loc5 = Number(loc4[0]);
		if(loc5 != 1)
		{
			ank.utils.Logger.err("[onCreate] Type incorrect");
			return undefined;
		}
		this.api.datacenter.Game = new dofus.datacenter.Game();
		this.api.datacenter.Game.state = loc5;
		this.api.ui.getUIComponent("Banner").showGaugeMode();
		this.api.datacenter.Player.data.initAP(false);
		this.api.datacenter.Player.data.initMP(false);
		this.api.datacenter.Player.SpellsManager.clear();
		this.api.datacenter.Player.data.CharacteristicsManager.initialize();
		this.api.datacenter.Player.data.EffectsManager.initialize();
		this.api.datacenter.Player.clearSummon();
		this.api.gfx.cleanMap(1);
		this.onCreateSolo();
	}
	function onJoin(loc2)
	{
		this.api.ui.getUIComponent("Zoom").callClose();
		this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1] != "0"?true:false;
		var loc6 = loc3[2] != "0"?true:false;
		var loc7 = loc3[3] != "0"?true:false;
		var loc8 = Number(loc3[4]);
		var loc9 = Number(loc3[5]);
		this.api.datacenter.Game = new dofus.datacenter.Game();
		this.api.datacenter.Game.state = loc4;
		this.api.datacenter.Game.fightType = loc9;
		var loc10 = this.api.ui.getUIComponent("Banner");
		loc10.redrawChrono();
		loc10.updateEye();
		this.api.datacenter.Game.isSpectator = loc7;
		if(!loc7)
		{
			this.api.datacenter.Player.data.initAP(false);
			this.api.datacenter.Player.data.initMP(false);
			this.api.datacenter.Player.SpellsManager.clear();
		}
		loc10.shortcuts.setCurrentTab("Spells");
		this.api.gfx.cleanMap(1);
		if(this.api.datacenter.Game.isTacticMode)
		{
			this.api.datacenter.Game.isTacticMode = true;
		}
		if(loc6)
		{
			this.api.ui.loadUIComponent("ChallengeMenu","ChallengeMenu",{labelReady:this.api.lang.getText("READY"),labelCancel:this.api.lang.getText("CANCEL_SMALL"),cancelButton:loc5,ready:false},{bStayIfPresent:true});
		}
		if(!_global.isNaN(loc8))
		{
			loc10.startTimer(loc8 / 1000);
		}
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
		this.api.ui.unloadLastUIAutoHideComponent();
		this.api.ui.unloadUIComponent("FightsInfos");
	}
	function onPositionStart(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1];
		var loc6 = Number(loc3[2]);
		this.api.datacenter.Basics.aks_current_team = loc6;
		this.api.datacenter.Basics.aks_team1_starts = new Array();
		this.api.datacenter.Basics.aks_team2_starts = new Array();
		this.api.kernel.StreamingDisplayManager.onFightStart();
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
		this.api.datacenter.Game.setInteractionType("place");
		if(loc6 == undefined)
		{
			ank.utils.Logger.err("[onPositionStart] Impossible de trouver l\'équipe du joueur local !");
		}
		var loc7 = 0;
		while(loc7 < loc4.length)
		{
			var loc8 = ank.utils.Compressor.decode64(loc4.charAt(loc7)) << 6;
			loc8 = loc8 + ank.utils.Compressor.decode64(loc4.charAt(loc7 + 1));
			this.api.datacenter.Basics.aks_team1_starts.push(loc8);
			if(loc6 == 0)
			{
				this.api.gfx.setInteractionOnCell(loc8,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
			}
			this.api.gfx.select(loc8,dofus.Constants.TEAMS_COLOR[0],"startPosition");
			loc7 = loc7 + 2;
		}
		var loc9 = 0;
		while(loc9 < loc5.length)
		{
			var loc10 = ank.utils.Compressor.decode64(loc5.charAt(loc9)) << 6;
			loc10 = loc10 + ank.utils.Compressor.decode64(loc5.charAt(loc9 + 1));
			this.api.datacenter.Basics.aks_team2_starts.push(loc10);
			if(loc6 == 1)
			{
				this.api.gfx.setInteractionOnCell(loc10,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
			}
			this.api.gfx.select(loc10,dofus.Constants.TEAMS_COLOR[1],"startPosition");
			loc9 = loc9 + 2;
		}
		if(this.api.ui.getUIComponent("FightOptionButtons") == undefined)
		{
			this.api.ui.loadUIComponent("FightOptionButtons","FightOptionButtons");
		}
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_PLACEMENT);
	}
	function onPlayersCoordinates(loc2)
	{
		if(loc2 != "e")
		{
			var loc3 = loc2.split("|");
			var loc4 = 0;
			while(loc4 < loc3.length)
			{
				var loc5 = loc3[loc4].split(";");
				var loc6 = loc5[0];
				var loc7 = Number(loc5[1]);
				this.api.gfx.setSpritePosition(loc6,loc7);
				loc4 = loc4 + 1;
			}
		}
		else
		{
			this.api.sounds.events.onError();
		}
	}
	function onReady(loc2)
	{
		var loc3 = loc2.charAt(0) == "1";
		var loc4 = loc2.substr(1);
		if(loc3)
		{
			this.api.gfx.addSpriteExtraClip(loc4,dofus.Constants.READY_FILE,undefined,true);
		}
		else
		{
			this.api.gfx.removeSpriteExtraClip(loc4,true);
		}
	}
	function onStartToPlay()
	{
		this.api.ui.getUIComponent("Banner").stopTimer();
		this.aks.GameActions.onActionsFinish(this.api.datacenter.Player.ID);
		this.api.sounds.events.onGameStart(this.api.datacenter.Map.musics);
		this.api.kernel.StreamingDisplayManager.onFightStartEnd();
		var loc2 = this.api.ui.getUIComponent("Banner");
		loc2.showGiveUpButton(true);
		if(!this.api.datacenter.Game.isSpectator)
		{
			var loc3 = this.api.datacenter.Player.data;
			loc3.initAP();
			loc3.initMP();
			loc3.initLP();
			loc2.showPoints(true);
			loc2.showNextTurnButton(true);
			this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("GAME_LAUNCH"),background:true,timer:2000},{bForceLoad:true});
			this.api.ui.getUIComponent("FightOptionButtons").onGameRunning();
		}
		else
		{
			this.api.ui.loadUIComponent("FightOptionButtons","FightOptionButtons");
		}
		this.api.ui.loadUIComponent("Timeline","Timeline");
		this.api.ui.unloadUIComponent("ChallengeMenu");
		this.api.gfx.unSelect(true);
		if(!this.api.gfx.gridHandler.bGridVisible)
		{
			this.api.gfx.drawGrid();
		}
		this.api.datacenter.Game.setInteractionType("move");
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
		this.api.kernel.GameManager.signalFightActivity();
		this.api.datacenter.Game.isRunning = true;
		var loc4 = this.api.datacenter.Sprites.getItems();
		for(var k in loc4)
		{
			this.api.gfx.addSpriteExtraClip(k,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[loc4[k].Team]);
		}
		if(this.api.datacenter.Game.isTacticMode)
		{
			this.api.datacenter.Game.isTacticMode = true;
		}
	}
	function onTurnStart(loc2)
	{
		if(this.api.datacenter.Game.isFirstTurn)
		{
			this.api.datacenter.Game.isFirstTurn = false;
			var loc3 = this.api.gfx.spriteHandler.getSprites().getItems();
			for(var sID in loc3)
			{
				this.api.gfx.removeSpriteExtraClip(sID,true);
			}
		}
		var loc4 = loc2.split("|");
		var loc5 = loc4[0];
		var loc6 = Number(loc4[1]) / 1000;
		var loc7 = this.api.datacenter.Sprites.getItemAt(loc5);
		loc7.GameActionsManager.clear();
		this.api.gfx.unSelect(true);
		this.api.datacenter.Game.currentPlayerID = loc5;
		this.api.kernel.GameManager.cleanPlayer(this.api.datacenter.Game.lastPlayerID);
		this.api.ui.getUIComponent("Timeline").nextTurn(loc5);
		if(this.api.datacenter.Player.isCurrentPlayer)
		{
			this.api.electron.makeNotification(this.api.lang.getText("PLAYER_TURN",[this.api.datacenter.Player.Name]));
			if(this.api.kernel.OptionsManager.getOption("StartTurnSound"))
			{
				this.api.sounds.events.onTurnStart();
			}
			if(this.api.kernel.GameManager.autoSkip && this.api.datacenter.Game.isFight)
			{
				this.api.network.Game.turnEnd();
			}
			this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
			this.api.datacenter.Player.SpellsManager.nextTurn();
			this.api.ui.getUIComponent("Banner").startTimer(loc6);
			this.api.kernel.GameManager.startInactivityDetector();
			dofus.DofusCore.getInstance().forceMouseOver();
			this.api.gfx.mapHandler.resetEmptyCells();
		}
		else
		{
			this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
			this.api.ui.getUIComponent("Timeline").startChrono(loc6);
			if(this.api.datacenter.Game.isSpectator && this.api.kernel.OptionsManager.getOption("SpriteInfos"))
			{
				this.api.ui.getUIComponent("Banner").showRightPanel("BannerSpriteInfos",{data:loc7},true);
			}
		}
		if(this.api.kernel.OptionsManager.getOption("StringCourse"))
		{
			var loc8 = new Array();
			loc8[1] = loc7.color1;
			loc8[2] = loc7.color2;
			loc8[3] = loc7.color3;
			this.api.ui.loadUIComponent("StringCourse","StringCourse",{gfx:loc7.artworkFile,name:loc7.name,level:this.api.lang.getText("LEVEL_SMALL") + " " + loc7.Level,colors:loc8},{bForceLoad:true});
		}
		this.api.kernel.GameManager.cleanUpGameArea(true);
		ank.utils.Timer.setTimer(this.api.network.Ping,"GameDecoDetect",this.api.network,this.api.network.quickPing,loc6 * 1000);
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_START);
	}
	function onTurnFinish(loc2)
	{
		var loc3 = loc2;
		var loc4 = this.api.datacenter.Sprites.getItemAt(loc3);
		if(this.api.datacenter.Player.isCurrentPlayer)
		{
			this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
			this.api.kernel.GameManager.stopInactivityDetector();
			this.api.kernel.GameManager.onTurnEnd();
		}
		this.api.datacenter.Game.lastPlayerID = this.api.datacenter.Game.currentPlayerID;
		this.api.datacenter.Game.currentPlayerID = undefined;
		this.api.ui.getUIComponent("Banner").stopTimer();
		this.api.ui.getUIComponent("Timeline").stopChrono();
		this.api.kernel.GameManager.cleanUpGameArea(true);
	}
	function onTurnlist(loc2)
	{
		var loc3 = loc2.split("|");
		this.api.datacenter.Game.turnSequence = loc3;
		this.api.ui.getUIComponent("Timeline").update();
	}
	function onTurnMiddle(loc2)
	{
		if(!this.api.datacenter.Game.isRunning)
		{
			ank.utils.Logger.err("[innerOnTurnMiddle] on est pas en combat");
			return undefined;
		}
		var loc3 = loc2.split("|");
		var loc4 = new Object();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = loc3[loc5].split(";");
			if(loc6.length != 0)
			{
				var loc7 = loc6[0];
				var loc8 = loc6[1] != "1"?false:true;
				var loc9 = Number(loc6[2]);
				var loc10 = Number(loc6[3]);
				var loc11 = Number(loc6[4]);
				var loc12 = Number(loc6[5]);
				var loc13 = Number(loc6[6]);
				var loc14 = Number(loc6[7]);
				loc4[loc7] = true;
				var loc15 = this.api.datacenter.Sprites.getItemAt(loc7);
				if(loc15 != undefined)
				{
					loc15.sequencer.clearAllNextActions();
					if(loc8)
					{
						loc15.mc.clear();
						this.api.gfx.removeSpriteOverHeadLayer(loc7,"text");
					}
					else
					{
						loc15.LP = loc9;
						loc15.LPmax = loc14;
						loc15.AP = loc10;
						loc15.MP = loc11;
						if(!_global.isNaN(loc12) && !loc15.hasCarriedParent())
						{
							this.api.gfx.setSpritePosition(loc7,loc12);
						}
						if(loc15.hasCarriedChild())
						{
							loc15.carriedChild.updateCarriedPosition();
						}
					}
				}
				else
				{
					ank.utils.Logger.err("[onTurnMiddle] le sprite n\'existe pas");
				}
			}
			loc5 = loc5 + 1;
		}
		var loc16 = this.api.datacenter.Sprites.getItems();
		for(var k in loc16)
		{
			if(!loc4[k])
			{
				loc16[k].mc.clear();
				this.api.datacenter.Sprites.removeItemAt(k);
			}
		}
		this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
	}
	function onTurnReady(loc2)
	{
		var loc3 = loc2;
		var loc4 = this.api.datacenter.Sprites.getItemAt(loc3);
		if(loc4 != undefined)
		{
			var loc5 = loc4.sequencer;
			loc5.addAction(false,this,this.turnOk);
			loc5.execute();
		}
		else
		{
			ank.utils.Logger.err("[onTurnReday] le sprite " + loc3 + " n\'existe pas");
			this.turnOk2();
		}
	}
	function onMapData(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1];
		var loc6 = loc3[2];
		if(Number(loc4) == this.api.datacenter.Map.id)
		{
			if(!this.api.datacenter.Map.bOutdoor)
			{
				this.api.kernel.NightManager.noEffects();
			}
			this.api.gfx.onMapLoaded();
			return undefined;
		}
		this.api.gfx.showContainer(false);
		this.nLastMapIdReceived = _global.parseInt(loc4,10);
		this.api.kernel.MapsServersManager.loadMap(loc4,loc5,loc6);
	}
	function onMapLoaded()
	{
		this.api.gfx.showContainer(true);
		this.api.kernel.GameManager.applyCreatureMode();
		if(dofus.Constants.SAVING_THE_WORLD)
		{
			dofus.SaveTheWorld.getInstance().nextAction();
		}
	}
	function onMovement(loc2, loc3)
	{
		var loc4 = loc2.split("|");
		var loc5 = loc4.length - 1;
		for(; loc5 >= 0; loc5 = loc5 - 1)
		{
			var loc6 = loc4[loc5];
			if(loc6.length != 0)
			{
				var loc7 = false;
				var loc8 = false;
				var loc9 = loc6.charAt(0);
				if(loc9 == "+")
				{
					loc8 = true;
				}
				else if(loc9 == "~")
				{
					loc8 = true;
					loc7 = true;
				}
				else if(loc9 != "-")
				{
					continue;
				}
				if(loc8)
				{
					var loc10 = loc6.substr(1).split(";");
					var loc11 = loc10[0];
					if(loc11 == "-1")
					{
						loc11 = String(this.api.datacenter.Player.data.cellNum);
					}
					var loc12 = loc10[1];
					var loc13 = Number(loc10[2]);
					var loc14 = loc10[3];
					var loc15 = loc10[4];
					var loc16 = loc10[5];
					var loc17 = loc10[6];
					var loc18 = false;
					var loc19 = true;
					if(loc17.charAt(loc17.length - 1) == "*")
					{
						loc17 = loc17.substr(0,loc17.length - 1);
						loc18 = true;
					}
					if(loc17.charAt(0) == "*")
					{
						loc19 = false;
						loc17 = loc17.substr(1);
					}
					var loc20 = loc17.split("^");
					var loc21 = loc20.length != 2?loc17:loc20[0];
					var loc22 = loc16.split(",");
					var loc23 = loc22[0];
					var loc24 = loc22[1];
					var loc25 = undefined;
					if(loc24.length)
					{
						var loc26 = loc24.split("*");
						loc25 = new dofus.datacenter.
(_global.parseInt(loc26[0]),loc26[1]);
					}
					var loc27 = 100;
					var loc28 = 100;
					if(loc20.length == 2)
					{
						var loc29 = loc20[1];
						if(_global.isNaN(Number(loc29)))
						{
							var loc30 = loc29.split("x");
							loc27 = loc30.length != 2?100:Number(loc30[0]);
							loc28 = loc30.length != 2?100:Number(loc30[1]);
						}
						else
						{
							loc27 = loc28 = Number(loc29);
						}
					}
					if(loc7)
					{
						var loc31 = this.api.datacenter.Sprites.getItemAt(loc14);
						this.onSpriteMovement(false,loc31);
					}
					loop3:
					switch(loc23)
					{
						case "-1":
						case "-2":
							var loc33 = new Object();
							loc33.spriteType = loc23;
							loc33.gfxID = loc21;
							loc33.scaleX = loc27;
							loc33.scaleY = loc28;
							loc33.noFlip = loc18;
							loc33.cell = loc11;
							loc33.dir = loc12;
							loc33.powerLevel = loc10[7];
							loc33.color1 = loc10[8];
							loc33.color2 = loc10[9];
							loc33.color3 = loc10[10];
							loc33.accessories = loc10[11];
							if(this.api.datacenter.Game.isFight)
							{
								loc33.LP = loc10[12];
								loc33.AP = loc10[13];
								loc33.MP = loc10[14];
								if(loc10.length > 18)
								{
									loc33.resistances = new Array(Number(loc10[15]),Number(loc10[16]),Number(loc10[17]),Number(loc10[18]),Number(loc10[19]),Number(loc10[20]),Number(loc10[21]));
									loc33.team = loc10[22];
								}
								else
								{
									loc33.team = loc10[15];
								}
								loc33.summoned = loc3;
							}
							if(loc23 == -1)
							{
								loc31 = this.api.kernel.CharactersManager.createCreature(loc14,loc15,loc33);
							}
							else
							{
								loc31 = this.api.kernel.CharactersManager.createMonster(loc14,loc15,loc33);
							}
							break;
						case "-3":
							var loc34 = new Object();
							loc34.spriteType = loc23;
							loc34.level = loc10[7];
							loc34.scaleX = loc27;
							loc34.scaleY = loc28;
							loc34.noFlip = loc18;
							loc34.cell = Number(loc11);
							loc34.dir = loc12;
							var loc35 = loc10[8].split(",");
							loc34.color1 = loc35[0];
							loc34.color2 = loc35[1];
							loc34.color3 = loc35[2];
							loc34.accessories = loc10[9];
							loc34.bonusValue = loc13;
							var loc36 = this.sliptGfxData(loc17);
							var loc37 = loc36.gfx;
							this.splitGfxForScale(loc37[0],loc34);
							loc31 = this.api.kernel.CharactersManager.createMonsterGroup(loc14,loc15,loc34);
							if(this.api.kernel.OptionsManager.getOption("ViewAllMonsterInGroup") == true)
							{
								var loc38 = loc14;
								var loc39 = 1;
								while(loc39 < loc37.length)
								{
									if(loc37[loc5] != "")
									{
										this.splitGfxForScale(loc37[loc39],loc34);
										loc35 = loc10[8 + 2 * loc39].split(",");
										loc34.color1 = loc35[0];
										loc34.color2 = loc35[1];
										loc34.color3 = loc35[2];
										loc34.dir = random(4) * 2 + 1;
										loc34.accessories = loc10[9 + 2 * loc39];
										var loc40 = loc14 + "_" + loc39;
										var loc41 = this.api.kernel.CharactersManager.createMonsterGroup(loc40,undefined,loc34);
										var loc42 = loc38;
										if(random(3) != 0 && loc39 != 1)
										{
											loc42 = loc14 + "_" + (random(loc39 - 1) + 1);
										}
										var loc43 = random(8);
										this.api.gfx.addLinkedSprite(loc40,loc42,loc43,loc41);
										if(!_global.isNaN(loc41.scaleX))
										{
											this.api.gfx.setSpriteScale(loc41.id,loc41.scaleX,loc41.scaleY);
										}
										switch(loc36.shape)
										{
											case "circle":
												loc43 = loc39;
												break;
											case "line":
												loc42 = loc40;
												loc43 = 2;
										}
									}
									loc39 = loc39 + 1;
								}
							}
							break;
						default:
							switch(null)
							{
								case "-4":
									var loc44 = new Object();
									loc44.spriteType = loc23;
									loc44.gfxID = loc21;
									loc44.scaleX = loc27;
									loc44.scaleY = loc28;
									loc44.cell = loc11;
									loc44.dir = loc12;
									loc44.sex = loc10[7];
									loc44.color1 = loc10[8];
									loc44.color2 = loc10[9];
									loc44.color3 = loc10[10];
									loc44.accessories = loc10[11];
									loc44.extraClipID = !(loc10[12] != undefined && !_global.isNaN(Number(loc10[12])))?-1:Number(loc10[12]);
									loc44.customArtwork = Number(loc10[13]);
									loc31 = this.api.kernel.CharactersManager.createNonPlayableCharacter(loc14,Number(loc15),loc44);
									break loop3;
								case "-5":
									var loc45 = new Object();
									loc45.spriteType = loc23;
									loc45.gfxID = loc21;
									loc45.scaleX = loc27;
									loc45.scaleY = loc28;
									loc45.cell = loc11;
									loc45.dir = loc12;
									loc45.color1 = loc10[7];
									loc45.color2 = loc10[8];
									loc45.color3 = loc10[9];
									loc45.accessories = loc10[10];
									loc45.guildName = loc10[11];
									loc45.emblem = loc10[12];
									loc45.offlineType = loc10[13];
									loc31 = this.api.kernel.CharactersManager.createOfflineCharacter(loc14,loc15,loc45);
									break loop3;
								case "-6":
									var loc46 = new Object();
									loc46.spriteType = loc23;
									loc46.gfxID = loc21;
									loc46.scaleX = loc27;
									loc46.scaleY = loc28;
									loc46.cell = loc11;
									loc46.dir = loc12;
									loc46.level = loc10[7];
									if(this.api.datacenter.Game.isFight)
									{
										loc46.LP = loc10[8];
										loc46.AP = loc10[9];
										loc46.MP = loc10[10];
										loc46.resistances = new Array(Number(loc10[11]),Number(loc10[12]),Number(loc10[13]),Number(loc10[14]),Number(loc10[15]),Number(loc10[16]),Number(loc10[17]));
										loc46.team = loc10[18];
									}
									else
									{
										loc46.guildName = loc10[8];
										loc46.emblem = loc10[9];
									}
									loc31 = this.api.kernel.CharactersManager.createTaxCollector(loc14,loc15,loc46);
									break loop3;
								case "-7":
								case "-8":
									var loc47 = new Object();
									loc47.spriteType = loc23;
									loc47.gfxID = loc21;
									loc47.scaleX = loc27;
									loc47.scaleY = loc28;
									loc47.cell = loc11;
									loc47.dir = loc12;
									loc47.sex = loc10[7];
									loc47.powerLevel = loc10[8];
									loc47.accessories = loc10[9];
									if(this.api.datacenter.Game.isFight)
									{
										loc47.LP = loc10[10];
										loc47.AP = loc10[11];
										loc47.MP = loc10[12];
										loc47.team = loc10[20];
									}
									else
									{
										loc47.emote = loc10[10];
										loc47.emoteTimer = loc10[11];
										loc47.restrictions = Number(loc10[12]);
									}
									if(loc23 == "-8")
									{
										loc47.showIsPlayer = true;
										var loc48 = loc15.split("~");
										loc47.monsterID = loc48[0];
										loc47.playerName = loc48[1];
									}
									else
									{
										loc47.showIsPlayer = false;
										loc47.monsterID = loc15;
									}
									loc31 = this.api.kernel.CharactersManager.createMutant(loc14,loc47);
									break loop3;
								default:
									switch(null)
									{
										case "-9":
											var loc49 = new Object();
											loc49.spriteType = loc23;
											loc49.gfxID = loc21;
											loc49.scaleX = loc27;
											loc49.scaleY = loc28;
											loc49.cell = loc11;
											loc49.dir = loc12;
											loc49.ownerName = loc10[7];
											loc49.level = loc10[8];
											loc49.modelID = loc10[9];
											loc31 = this.api.kernel.CharactersManager.createParkMount(loc14,loc15 == ""?this.api.lang.getText("NO_NAME"):loc15,loc49);
											break loop3;
										case "-10":
											var loc50 = new Object();
											loc50.spriteType = loc23;
											loc50.gfxID = loc21;
											loc50.scaleX = loc27;
											loc50.scaleY = loc28;
											loc50.cell = loc11;
											loc50.dir = loc12;
											loc50.level = loc10[7];
											loc50.alignment = new dofus.datacenter.(Number(loc10[9]),Number(loc10[8]));
											loc31 = this.api.kernel.CharactersManager.createPrism(loc14,loc15,loc50);
											break loop3;
										default:
											var loc52 = new Object();
											loc52.spriteType = loc23;
											loc52.cell = loc11;
											loc52.scaleX = loc27;
											loc52.scaleY = loc28;
											loc52.dir = loc12;
											loc52.sex = loc10[7];
											if(this.api.datacenter.Game.isFight)
											{
												loc52.level = loc10[8];
												var loc51 = loc10[9];
												loc52.color1 = loc10[10];
												loc52.color2 = loc10[11];
												loc52.color3 = loc10[12];
												loc52.accessories = loc10[13];
												loc52.LP = loc10[14];
												loc52.AP = loc10[15];
												loc52.MP = loc10[16];
												loc52.resistances = new Array(Number(loc10[17]),Number(loc10[18]),Number(loc10[19]),Number(loc10[20]),Number(loc10[21]),Number(loc10[22]),Number(loc10[23]));
												loc52.team = loc10[24];
												if(loc10[25].indexOf(",") != -1)
												{
													var loc53 = loc10[25].split(",");
													var loc54 = Number(loc53[0]);
													var loc55 = _global.parseInt(loc53[1],16);
													var loc56 = _global.parseInt(loc53[2],16);
													var loc57 = _global.parseInt(loc53[3],16);
													if(loc55 == -1 || _global.isNaN(loc55))
													{
														loc55 = this.api.datacenter.Player.color1;
													}
													if(loc56 == -1 || _global.isNaN(loc56))
													{
														loc56 = this.api.datacenter.Player.color2;
													}
													if(loc57 == -1 || _global.isNaN(loc57))
													{
														loc57 = this.api.datacenter.Player.color3;
													}
													if(!_global.isNaN(loc54))
													{
														var loc58 = new dofus.datacenter.Mount(loc54,Number(loc21));
														loc58.customColor1 = loc55;
														loc58.customColor2 = loc56;
														loc58.customColor3 = loc57;
														loc52.mount = loc58;
													}
												}
												else
												{
													var loc59 = Number(loc10[25]);
													if(!_global.isNaN(loc59))
													{
														loc52.mount = new dofus.datacenter.Mount(loc59,Number(loc21));
													}
												}
											}
											else
											{
												loc51 = loc10[8];
												loc52.color1 = loc10[9];
												loc52.color2 = loc10[10];
												loc52.color3 = loc10[11];
												loc52.accessories = loc10[12];
												loc52.aura = loc10[13];
												loc52.emote = loc10[14];
												loc52.emoteTimer = loc10[15];
												loc52.guildName = loc10[16];
												loc52.emblem = loc10[17];
												loc52.restrictions = loc10[18];
												if(loc10[19].indexOf(",") != -1)
												{
													var loc60 = loc10[19].split(",");
													var loc61 = Number(loc60[0]);
													var loc62 = _global.parseInt(loc60[1],16);
													var loc63 = _global.parseInt(loc60[2],16);
													var loc64 = _global.parseInt(loc60[3],16);
													if(loc62 == -1 || _global.isNaN(loc62))
													{
														loc62 = this.api.datacenter.Player.color1;
													}
													if(loc63 == -1 || _global.isNaN(loc63))
													{
														loc63 = this.api.datacenter.Player.color2;
													}
													if(loc64 == -1 || _global.isNaN(loc64))
													{
														loc64 = this.api.datacenter.Player.color3;
													}
													if(!_global.isNaN(loc61))
													{
														var loc65 = new dofus.datacenter.Mount(loc61,Number(loc21));
														loc65.customColor1 = loc62;
														loc65.customColor2 = loc63;
														loc65.customColor3 = loc64;
														loc52.mount = loc65;
													}
												}
												else
												{
													var loc66 = Number(loc10[19]);
													if(!_global.isNaN(loc66))
													{
														loc52.mount = new dofus.datacenter.Mount(loc66,Number(loc21));
													}
												}
											}
											if(loc7)
											{
												var loc32 = [loc14,this.createTransitionEffect(),loc11,10];
											}
											var loc67 = loc51.split(",");
											loc52.alignment = new dofus.datacenter.(Number(loc67[0]),Number(loc67[1]));
											loc52.rank = new dofus.datacenter.Rank(Number(loc67[2]));
											loc52.alignment.fallenAngelDemon = loc67[4] == 1;
											if(loc67.length > 3 && loc14 != this.api.datacenter.Player.ID)
											{
												if(this.api.lang.getAlignmentCanViewPvpGain(this.api.datacenter.Player.alignment.index,Number(loc52.alignment.index)))
												{
													var loc68 = Number(loc67[3]) - _global.parseInt(loc14);
													var loc69 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT");
													var loc70 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT_PRC");
													var loc71 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT");
													var loc72 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT_PRC");
													var loc73 = 0;
													if(this.api.datacenter.Player.Level * (1 - loc70 / 100) > loc68)
													{
														loc73 = -1;
													}
													if(this.api.datacenter.Player.Level - loc68 > loc69)
													{
														loc73 = -1;
													}
													if(this.api.datacenter.Player.Level * (1 + loc72 / 100) < loc68)
													{
														loc73 = 1;
													}
													if(this.api.datacenter.Player.Level - loc68 < loc71)
													{
														loc73 = 1;
													}
													loc52.pvpGain = loc73;
												}
											}
											if(!this.api.datacenter.Game.isFight && (_global.parseInt(loc14,10) != this.api.datacenter.Player.ID && ((this.api.datacenter.Player.alignment.index == 1 || this.api.datacenter.Player.alignment.index == 2) && ((loc52.alignment.index == 1 || loc52.alignment.index == 2) && (loc52.alignment.index != this.api.datacenter.Player.alignment.index && (loc52.rank.value && this.api.datacenter.Map.bCanAttack))))))
											{
												if(this.api.datacenter.Player.rank.value > loc52.rank.value)
												{
													this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
												}
												if(this.api.datacenter.Player.rank.value < loc52.rank.value)
												{
													this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
												}
											}
											var loc74 = this.sliptGfxData(loc17);
											var loc75 = loc74.gfx;
											this.splitGfxForScale(loc75[0],loc52);
											loc52.title = loc25;
											loc31 = this.api.kernel.CharactersManager.createCharacter(loc14,loc15,loc52);
											(dofus.datacenter.Character)loc31.isClear = false;
											loc31.allowGhostMode = loc19;
											var loc76 = loc14;
											var loc77 = loc74.shape != "circle"?2:0;
											var loc78 = 1;
											while(loc78 < loc75.length)
											{
												if(loc75[loc78] != "")
												{
													var loc79 = loc14 + "_" + loc78;
													var loc80 = new Object();
													this.splitGfxForScale(loc75[loc78],loc80);
													var loc81 = new ank.battlefield.datacenter.(loc79,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc80.gfxID + ".swf");
													loc81.allDirections = false;
													this.api.gfx.addLinkedSprite(loc79,loc76,loc77,loc81);
													if(!_global.isNaN(loc80.scaleX))
													{
														this.api.gfx.setSpriteScale(loc81.id,loc80.scaleX,loc80.scaleY);
													}
													switch(loc74.shape)
													{
														case "circle":
															loc77 = loc78;
															break;
														case "line":
															loc76 = loc79;
															loc77 = 2;
													}
												}
												loc78 = loc78 + 1;
											}
									}
							}
					}
					break loop2;
				}
				var loc82 = loc6.substr(1);
				var loc83 = this.api.datacenter.Sprites.getItemAt(loc82);
				if(!this.api.datacenter.Game.isRunning && this.api.datacenter.Game.isLoggingMapDisconnections)
				{
					var loc84 = loc83.name;
					var loc85 = this._aGameSpriteLeftHistory[loc82];
					if(!_global.isNaN(loc85) && getTimer() - loc85 < 300)
					{
						this.api.kernel.showMessage(undefined,this.api.kernel.DebugManager.getTimestamp() + " (Map) " + this.api.kernel.ChatManager.getLinkName(loc84) + " s\'est déconnecté (" + loc82 + ")","ADMIN_CHAT");
					}
					this._aGameSpriteLeftHistory[loc82] = getTimer();
				}
				this.onSpriteMovement(loc8,loc83);
			}
		}
	}
	function onCellData(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4].split(";");
			var loc6 = Number(loc5[0]);
			var loc7 = loc5[1].substring(0,10);
			var loc8 = loc5[1].substr(10);
			var loc9 = loc5[2] != "0"?1:0;
			this.api.gfx.updateCell(loc6,loc7,loc8,loc9);
			loc4 = loc4 + 1;
		}
	}
	function onZoneData(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4];
			var loc6 = loc5.charAt(0) != "+"?false:true;
			var loc7 = loc5.substr(1).split(";");
			var loc8 = Number(loc7[0]);
			var loc9 = Number(loc7[1]);
			var loc10 = loc7[2];
			if(loc6)
			{
				this.api.gfx.drawZone(loc8,0,loc9,loc10,dofus.Constants.ZONE_COLOR[loc10]);
			}
			else
			{
				this.api.gfx.clearZone(loc8,loc9,loc10);
			}
			loc4 = loc4 + 1;
		}
	}
	function onCellObject(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = 0;
		while(loc5 < loc4.length)
		{
			var loc6 = loc4[loc5].split(";");
			var loc7 = Number(loc6[0]);
			var loc8 = _global.parseInt(loc6[1]);
			if(loc3)
			{
				var loc9 = new dofus.datacenter.(0,loc8);
				var loc10 = Number(loc6[2]);
				switch(loc10)
				{
					case 0:
						this.api.gfx.updateCellObjectExternalWithExternalClip(loc7,loc9.iconFile,1,true,true,loc9);
						break;
					case 1:
						if(this.api.gfx.mapHandler.getCellData(loc7).layerObjectExternalData.unicID != loc8)
						{
							this.api.gfx.updateCellObjectExternalWithExternalClip(loc7,loc9.iconFile,1,true,false,loc9);
						}
						else
						{
							loc9 = this.api.gfx.mapHandler.getCellData(loc7).layerObjectExternalData;
						}
						loc9.durability = Number(loc6[3]);
						loc9.durabilityMax = Number(loc6[4]);
				}
			}
			else
			{
				this.api.gfx.initializeCell(loc7,1);
			}
			loc5 = loc5 + 1;
		}
	}
	function onFrameObject2(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4].split(";");
			var loc6 = Number(loc5[0]);
			var loc7 = loc5[1];
			var loc8 = loc5[2] != undefined;
			var loc9 = loc5[2] != "1"?false:true;
			if(loc8)
			{
				this.api.gfx.setObject2Interactive(loc6,loc9,2);
			}
			this.api.gfx.setObject2Frame(loc6,loc7);
			loc4 = loc4 + 1;
		}
	}
	function onFrameObjectExternal(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4].split(";");
			var loc6 = Number(loc5[0]);
			var loc7 = Number(loc5[1]);
			this.api.gfx.setObjectExternalFrame(loc6,loc7);
			loc4 = loc4 + 1;
		}
	}
	function onEffect(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = loc3[0];
		var loc5 = loc3[1].split(",");
		var loc6 = loc3[2];
		var loc7 = loc3[3];
		var loc8 = loc3[4];
		var loc9 = loc3[5];
		var loc10 = Number(loc3[6]);
		var loc11 = loc3[7];
		var loc12 = 0;
		while(loc12 < loc5.length)
		{
			var loc13 = loc5[loc12];
			if(loc13 == this.api.datacenter.Game.currentPlayerID && loc10 != -1)
			{
				loc10 = loc10 + 1;
			}
			var loc14 = new dofus.datacenter.(Number(loc4),Number(loc6),Number(loc7),Number(loc8),loc9,Number(loc10),Number(loc11));
			var loc15 = this.api.datacenter.Sprites.getItemAt(loc13);
			loc15.EffectsManager.addEffect(loc14);
			loc12 = loc12 + 1;
		}
	}
	function onClearAllEffect(loc2)
	{
		var loc3 = this.api.datacenter.Sprites;
		for(var a in loc3)
		{
			loc3[a].EffectsManager.terminateAllEffects();
		}
	}
	function onChallenge(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = loc4.shift().split(";");
		var loc6 = Number(loc5[0]);
		var loc7 = Number(loc5[1]);
		var loc8 = (Math.cos(loc6) + 1) * 8388607;
		if(loc3)
		{
			var loc9 = new dofus.datacenter.Challenge(loc6,loc7);
			this.api.datacenter.Challenges.addItemAt(loc6,loc9);
			var loc10 = 0;
			while(loc10 < loc4.length)
			{
				var loc11 = loc4[loc10].split(";");
				var loc12 = loc11[0];
				var loc13 = Number(loc11[1]);
				var loc14 = Number(loc11[2]);
				var loc15 = Number(loc11[3]);
				var loc16 = dofus.Constants.getTeamFileFromType(loc14,loc15);
				var loc17 = new dofus.datacenter.Team(loc12,ank.battlefield.mc.Sprite,loc16,loc13,loc8,loc14,loc15);
				loc9.addTeam(loc17);
				this.api.gfx.addSprite(loc17.id,loc17);
				loc10 = loc10 + 1;
			}
		}
		else
		{
			var loc18 = this.api.datacenter.Challenges.getItemAt(loc6).teams;
			for(var k in loc18)
			{
				var loc19 = loc18[k];
				this.api.gfx.removeSprite(loc19.id);
			}
			this.api.datacenter.Challenges.removeItemAt(loc6);
		}
	}
	function onTeam(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3.shift());
		var loc5 = this.api.datacenter.Sprites.getItemAt(loc4);
		var loc6 = 0;
		while(loc6 < loc3.length)
		{
			var loc7 = loc3[loc6].split(";");
			var loc8 = loc7[0].charAt(0) == "+";
			var loc9 = loc7[0].substr(1);
			var loc10 = loc7[1];
			var loc11 = loc7[2];
			var loc12 = loc10.split(",");
			var loc13 = Number(loc10);
			if(loc12.length > 1)
			{
				loc10 = this.api.lang.getFullNameText(loc12);
			}
			else if(!_global.isNaN(loc13))
			{
				loc10 = this.api.lang.getMonstersText(loc13).n;
			}
			if(loc8)
			{
				var loc14 = new Object();
				loc14.id = loc9;
				loc14.name = loc10;
				loc14.level = loc11;
				loc5.addPlayer(loc14);
			}
			else
			{
				loc5.removePlayer(loc9);
			}
			loc6 = loc6 + 1;
		}
	}
	function onFightOption(loc2)
	{
		var loc3 = loc2.substr(2);
		var loc4 = this.api.datacenter.Sprites.getItemAt(loc3);
		if(loc4 != undefined)
		{
			var loc5 = loc2.charAt(0) == "+";
			var loc6 = loc2.charAt(1);
			switch(loc6)
			{
				case "H":
					loc4.options[dofus.datacenter.Team.OPT_NEED_HELP] = loc5;
					break;
				case "S":
					loc4.options[dofus.datacenter.Team.OPT_BLOCK_SPECTATOR] = loc5;
					break;
				case "A":
					loc4.options[dofus.datacenter.Team.OPT_BLOCK_JOINER] = loc5;
					break;
				default:
					if(loc0 !== "P")
					{
						break;
					}
					loc4.options[dofus.datacenter.Team.OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER] = loc5;
					break;
			}
			this.api.gfx.addSpriteOverHeadItem(loc3,"FightOptions",dofus.graphics.battlefield.FightOptionsOverHead,[loc4],undefined);
		}
	}
	function onLeave()
	{
		this.api.datacenter.Game.currentPlayerID = undefined;
		this.api.ui.getUIComponent("Banner").hideRightPanel(true);
		this.api.ui.unloadUIComponent("Timeline");
		this.api.ui.unloadUIComponent("StringCourse");
		this.api.ui.unloadUIComponent("PlayerInfos");
		this.api.ui.unloadUIComponent("SpriteInfos");
		this.aks.GameActions.onActionsFinish(String(this.api.datacenter.Player.ID));
		this.api.datacenter.Player.reset();
		var loc2 = (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge");
		loc2.cleanChallenge();
		this.create();
	}
	function onEnd(loc2)
	{
		if(this.api.kernel.MapsServersManager.isBuilding)
		{
			this.addToQueue({object:this,method:this.onEnd,params:[loc2]});
			return undefined;
		}
		this._bIsBusy = true;
		var loc3 = (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge");
		this.api.kernel.StreamingDisplayManager.onFightEnd();
		var loc4 = {winners:[],loosers:[],collectors:[],challenges:loc3.challenges.clone()};
		this.api.datacenter.Game.results = loc4;
		loc3.cleanChallenge();
		var loc5 = loc2.split("|");
		var loc6 = -1;
		if(!_global.isNaN(Number(loc5[0])))
		{
			loc4.duration = Number(loc5[0]);
		}
		else
		{
			var loc7 = loc5[0].split(";");
			loc4.duration = Number(loc7[0]);
			loc6 = Number(loc7[1]);
		}
		this.api.datacenter.Basics.aks_game_end_bonus = loc6;
		var loc8 = Number(loc5[1]);
		var loc9 = Number(loc5[2]);
		loc4.fightType = loc9;
		var loc10 = new ank.utils.();
		var loc11 = 0;
		this.parsePlayerData(loc4,3,loc8,loc5,loc9,loc11,loc10);
	}
	function parsePlayerData(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		var loc9 = loc3;
		var loc10 = loc5[loc9].split(";");
		var loc11 = new Object();
		if(Number(loc10[0]) != 6)
		{
			loc11.id = Number(loc10[1]);
			if(loc11.id == this.api.datacenter.Player.ID)
			{
				if(Number(loc10[0]) == 0)
				{
					this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_LOST);
				}
				else
				{
					this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_WON);
				}
			}
			var loc13 = this.api.kernel.CharactersManager.getNameFromData(loc10[2]);
			loc11.name = loc13.name;
			loc11.type = loc13.type;
			loc11.level = Number(loc10[3]);
			loc11.bDead = loc10[4] != "1"?false:true;
			switch(loc6)
			{
				case 0:
					loc11.minxp = Number(loc10[5]);
					loc11.xp = Number(loc10[6]);
					loc11.maxxp = Number(loc10[7]);
					loc11.winxp = Number(loc10[8]);
					loc11.guildxp = Number(loc10[9]);
					loc11.mountxp = Number(loc10[10]);
					var loc12 = loc10[11].split(",");
					if(loc11.id == this.api.datacenter.Player.ID && loc12.length > 10)
					{
						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
					}
					loc11.kama = loc10[12];
					break;
				case 1:
					loc11.minhonour = Number(loc10[5]);
					loc11.honour = Number(loc10[6]);
					loc11.maxhonour = Number(loc10[7]);
					loc11.winhonour = Number(loc10[8]);
					loc11.rank = Number(loc10[9]);
					loc11.disgrace = Number(loc10[10]);
					loc11.windisgrace = Number(loc10[11]);
					loc11.maxdisgrace = this.api.lang.getMaxDisgracePoints();
					loc11.mindisgrace = 0;
					loc12 = loc10[12].split(",");
					if(loc11.id == this.api.datacenter.Player.ID && loc12.length > 10)
					{
						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
					}
					loc11.kama = loc10[13];
					loc11.minxp = Number(loc10[14]);
					loc11.xp = Number(loc10[15]);
					loc11.maxxp = Number(loc10[16]);
					loc11.winxp = Number(loc10[17]);
			}
		}
		else
		{
			loc12 = loc10[1].split(",");
			loc11.kama = loc10[2];
			loc7 = loc7 + Number(loc11.kama);
		}
		loc11.items = new Array();
		var loc14 = loc12.length;
		while((loc14 = loc14 - 1) >= 0)
		{
			var loc15 = loc12[loc14].split("~");
			var loc16 = Number(loc15[0]);
			var loc17 = Number(loc15[1]);
			if(_global.isNaN(loc16))
			{
				break;
			}
			if(loc16 != 0)
			{
				var loc18 = new dofus.datacenter.(0,loc16,loc17);
				loc11.items.push(loc18);
			}
		}
		switch(Number(loc10[0]))
		{
			case 0:
				loc2.loosers.push(loc11);
				break;
			case 2:
				loc2.winners.push(loc11);
				break;
			case 5:
				loc2.collectors.push(loc11);
				break;
			default:
				if(loc0 !== 6)
				{
					break;
				}
				loc8 = loc8.concat(loc11.items);
				break;
		}
		loc9 = loc9 + 1;
		if(loc9 < loc5.length)
		{
			this.addToQueue({object:this,method:this.parsePlayerData,params:[loc2,loc9,loc4,loc5,loc6,loc7,loc8]});
		}
		else
		{
			this.onParseItemEnd(loc4,loc2,loc8,loc7);
		}
	}
	function onParseItemEnd(loc2, loc3, loc4, loc5)
	{
		if(loc4.length)
		{
			var loc6 = Math.ceil(loc4.length / loc3.winners.length);
			var loc7 = 0;
			while(loc7 < loc3.winners.length)
			{
				var loc8 = loc4.length;
				loc3.winners[loc7].kama = Math.ceil(loc5 / loc6);
				if(loc7 == loc3.winners.length - 1)
				{
					loc6 = loc8;
				}
				var loc9 = loc8 - loc6;
				while(loc9 < loc8)
				{
					loc3.winners[loc7].items.push(loc4.pop());
					loc9 = loc9 + 1;
				}
				loc7 = loc7 + 1;
			}
		}
		if(loc2 == this.api.datacenter.Player.ID)
		{
			this.aks.GameActions.onActionsFinish(String(loc2));
		}
		this.api.datacenter.Game.isRunning = false;
		var loc10 = this.api.datacenter.Sprites.getItemAt(loc2).sequencer;
		this._bIsBusy = false;
		if(loc10 != undefined)
		{
			loc10.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.terminateFight);
			loc10.execute(false);
		}
		else
		{
			ank.utils.Logger.err("[AKS.Game.onEnd] Impossible de trouver le sequencer");
			ank.utils.Timer.setTimer(this,"game",this.api.kernel.GameManager,this.api.kernel.GameManager.terminateFight,500);
		}
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDFIGHT);
	}
	function onExtraClip(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1].split(";");
		var loc6 = dofus.Constants.EXTRA_PATH + loc4 + ".swf";
		var loc7 = loc4 == "-";
		for(var k in loc5)
		{
			var loc8 = loc5[k];
			if(loc7)
			{
				this.api.gfx.removeSpriteExtraClip(loc8,false);
			}
			else
			{
				this.api.gfx.addSpriteExtraClip(loc8,loc6,undefined,false);
			}
		}
	}
	function onPVP(loc2, loc3)
	{
		if(!loc3)
		{
			var loc4 = Number(loc2);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ASK_DISABLE_PVP",[loc4]),"CAUTION_YESNO",{name:"DisabledPVP",listener:this});
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ASK_ENABLED_PVP"),"CAUTION_YESNO",{name:"EnabledPVP",listener:this});
		}
	}
	function onGameOver()
	{
		this.api.network.softDisconnect();
		this.api.ui.loadUIComponent("GameOver","GameOver",undefined,{bAlwaysOnTop:true});
	}
	function onCreateSolo()
	{
		this.api.datacenter.Player.InteractionsManager.setState(false);
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
		this.api.ui.removeCursor();
		this.api.ui.getUIComponent("Banner").shortcuts.setCurrentTab("Items");
		this.api.datacenter.Basics.gfx_isSpritesHidden = false;
		this.api.gfx.spriteHandler.unmaskAllSprites();
		if(this.api.ui.getUIComponent("Banner") == undefined)
		{
			this.api.kernel.OptionsManager.applyAllOptions();
			this.api.ui.loadUIComponent("Banner","Banner",{data:this.api.datacenter.Player},{bAlwaysOnTop:true});
			this.api.ui.setScreenSize(742,432);
		}
		else
		{
			var loc2 = this.api.ui.getUIComponent("Banner");
			loc2.showPoints(false);
			loc2.showNextTurnButton(false);
			loc2.showGiveUpButton(false);
			this.api.ui.unloadUIComponent("FightOptionButtons");
			this.api.ui.unloadUIComponent("ChallengeMenu");
		}
		this.api.gfx.cleanMap(2);
	}
	function onSpriteMovement(loc2, loc3, loc4)
	{
		if(oSprite instanceof dofus.datacenter.Character)
		{
			this.api.datacenter.Game.playerCount = this.api.datacenter.Game.playerCount + (!loc2?-1:1);
		}
		if(loc2)
		{
			if(loc4 != undefined)
			{
				this.api.gfx.spriteLaunchVisualEffect.apply(this.api.gfx,loc4);
			}
			this.api.gfx.addSprite(oSprite.id);
			if(!_global.isNaN(oSprite.scaleX))
			{
				this.api.gfx.setSpriteScale(oSprite.id,oSprite.scaleX,oSprite.scaleY);
			}
			if(oSprite instanceof dofus.datacenter.OfflineCharacter)
			{
				oSprite.mc.addExtraClip(dofus.Constants.EXTRA_PATH + oSprite.offlineType + ".swf",undefined,true);
				return undefined;
			}
			if(oSprite instanceof dofus.datacenter.NonPlayableCharacter)
			{
				if(!_global.isNaN(oSprite.extraClipID))
				{
					this.api.gfx.addSpriteExtraClip(oSprite.id,dofus.Constants.EXTRA_PATH + oSprite.extraClipID + ".swf",undefined,false);
					return undefined;
				}
			}
			if(this.api.datacenter.Game.isRunning)
			{
				this.api.gfx.addSpriteExtraClip(oSprite.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[oSprite.Team]);
			}
			else if(oSprite.Aura != 0 && (oSprite.Aura != undefined && this.api.kernel.OptionsManager.getOption("Aura")))
			{
				this.api.gfx.addSpriteExtraClip(oSprite.id,dofus.Constants.AURA_PATH + oSprite.Aura + ".swf",undefined,true);
			}
			if(oSprite.id == this.api.datacenter.Player.ID)
			{
				this.api.ui.getUIComponent("Banner").updateLocalPlayer();
				if(oSprite instanceof dofus.datacenter.Character)
				{
					if(oSprite.name != this.api.datacenter.Player.Name)
					{
						this.api.datacenter.Player.Name = oSprite.name;
					}
				}
			}
			else if(this.api.gfx.spriteHandler.isPlayerSpritesHidden && (oSprite instanceof dofus.datacenter.Character || (oSprite instanceof dofus.datacenter.PlayerShop || oSprite instanceof dofus.datacenter.MonsterGroup)))
			{
				this.api.gfx.spriteHandler.hidePlayerSprites();
			}
			else if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && oSprite instanceof dofus.datacenter.MonsterGroup)
			{
				oSprite.mc._rollOver();
			}
		}
		else if(!this.api.datacenter.Game.isRunning)
		{
			this.api.gfx.removeSprite(oSprite.id);
		}
		else
		{
			var loc5 = oSprite.sequencer;
			var loc6 = oSprite.mc;
			loc5.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("LEAVE_GAME",[oSprite.name]),"INFO_CHAT"]);
			loc5.addAction(false,this.api.ui.getUIComponent("Timeline"),this.api.ui.getUIComponent("Timeline").hideItem,[oSprite.id]);
			loc5.addAction(true,loc6,loc6.setAnim,["Die"],1500,true);
			if(oSprite.hasCarriedChild())
			{
				this.api.gfx.uncarriedSprite(oSprite.carriedChild.id,oSprite.cellNum,false,loc5);
				loc5.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[oSprite.carriedChild.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[oSprite.carriedChild.Team]]);
			}
			loc5.addAction(false,loc6,loc6.clear);
			loc5.execute();
			if(this.api.datacenter.Game.currentPlayerID == oSprite.id)
			{
				this.api.ui.getUIComponent("Banner").stopTimer();
				this.api.ui.getUIComponent("Timeline").stopChrono();
			}
		}
		this.api.kernel.GameManager.applyCreatureMode();
	}
	function onFlag(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = Number(loc3[1]);
		var loc6 = this.api.datacenter.Sprites.getItemAt(loc4);
		var loc7 = new ank.battlefield.datacenter.
();
		loc7.file = dofus.Constants.CLIPS_PATH + "flag.swf";
		loc7.bInFrontOfSprite = true;
		loc7.bTryToBypassContainerColor = true;
		this.api.kernel.showMessage(undefined,this.api.lang.getText("PLAYER_SET_FLAG",[loc6.name,loc5]),"INFO_CHAT");
		this.api.gfx.spriteLaunchVisualEffect(loc4,loc7,loc5,11,undefined,undefined,undefined,true);
	}
	function onFightChallenge(loc2)
	{
		var loc3 = loc2.split(";");
		if(!this.api.ui.getUIComponent("FightChallenge"))
		{
			this.api.ui.loadUIComponent("FightChallenge","FightChallenge");
		}
		var loc4 = new dofus.datacenter.(_global.parseInt(loc3[0]),loc3[1] == "1",_global.parseInt(loc3[2]),_global.parseInt(loc3[3]),_global.parseInt(loc3[4]),_global.parseInt(loc3[5]),_global.parseInt(loc3[6]));
		(dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge").addChallenge(loc4);
	}
	function onFightChallengeUpdate(loc2, loc3)
	{
		var loc4 = _global.parseInt(loc2);
		(dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge").updateChallenge(loc4,loc3);
		var loc5 = !loc3?this.api.lang.getText("FIGHT_CHALLENGE_FAILED"):this.api.lang.getText("FIGHT_CHALLENGE_DONE");
		loc5 = loc5 + (" : " + this.api.lang.getFightChallenge(loc4).n);
		this.api.kernel.showMessage(undefined,loc5,"INFO_CHAT");
	}
	function sliptGfxData(loc2)
	{
		if(loc2.indexOf(",") != -1)
		{
			var loc3 = loc2.split(",");
			return {shape:"circle",gfx:loc3};
		}
		if(loc2.indexOf(":") != -1)
		{
			var loc4 = loc2.split(":");
			return {shape:"line",gfx:loc4};
		}
		return {shape:"none",gfx:[loc2]};
	}
	function createTransitionEffect()
	{
		var loc2 = new ank.battlefield.datacenter.
();
		loc2.id = 5;
		loc2.file = dofus.Constants.SPELLS_PATH + "transition.swf";
		loc2.level = 5;
		loc2.params = [];
		loc2.bInFrontOfSprite = true;
		loc2.bTryToBypassContainerColor = false;
		return loc2;
	}
	function splitGfxForScale(loc2, loc3)
	{
		var loc4 = loc2.split("^");
		var loc5 = loc4.length != 2?loc2:loc4[0];
		var loc6 = 100;
		var loc7 = 100;
		if(loc4.length == 2)
		{
			var loc8 = loc4[1];
			if(_global.isNaN(Number(loc8)))
			{
				var loc9 = loc8.split("x");
				loc6 = loc9.length != 2?100:Number(loc9[0]);
				loc7 = loc9.length != 2?100:Number(loc9[1]);
			}
			else
			{
				loc6 = loc7 = Number(loc8);
			}
		}
		loc3.gfxID = loc5;
		loc3.scaleX = loc6;
		loc3.scaleY = loc7;
	}
	function cancel(loc2)
	{
		var loc0 = loc2.target._name;
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoEnabledPVP":
				this.api.network.Game.enabledPVPMode(true);
				break;
			case "AskYesNoDisabledPVP":
				this.api.network.Game.enabledPVPMode(false);
		}
	}
	function no(loc2)
	{
		var loc0 = loc2.target._name;
	}
}
