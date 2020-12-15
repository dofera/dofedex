class dofus.aks.Game extends dofus.aks.Handler
{
	static var TYPE_SOLO = 1;
	static var TYPE_FIGHT = 2;
	var _bIsBusy = false;
	var _aGameSpriteLeftHistory = new Array();
	var nLastMapIdReceived = -1;
	function Game(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}
	function __get__isBusy()
	{
		return this._bIsBusy;
	}
	function create()
	{
		this.aks.send("GC" + dofus.aks.Game.TYPE_SOLO);
	}
	function leave(var2)
	{
		this.aks.send("GQ" + (var2 != undefined?var2:""));
	}
	function setPlayerPosition(var2)
	{
		this.aks.send("Gp" + var2,true);
	}
	function ready(var2)
	{
		this.aks.send("GR" + (!var2?"0":"1"));
	}
	function getMapData(var2)
	{
		if(this.api.lang.getConfigText("ENABLE_CLIENT_MAP_REQUEST"))
		{
			this.aks.send("GD" + (var2 == undefined?"":String(var2)));
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
	function turnOk(var2)
	{
		this.aks.send("GT" + (var2 == undefined?"":var2),false);
	}
	function turnOk2(var2)
	{
		this.aks.send("GT" + (var2 == undefined?"":var2),false);
	}
	function askDisablePVPMode()
	{
		this.aks.send("GP*",false);
	}
	function enabledPVPMode(var2)
	{
		this.aks.send("GP" + (!var2?"-":"+"),false);
	}
	function freeMySoul()
	{
		this.aks.send("GF",false);
	}
	function setFlag(var2)
	{
		this.aks.send("Gf" + var2,false);
	}
	function showFightChallengeTarget(var2)
	{
		this.aks.send("Gdi" + var2,false);
	}
	function onCreate(var2, var3)
	{
		if(!var2)
		{
			ank.utils.Logger.err("[onCreate] Impossible de créer la partie");
			return undefined;
		}
		var var4 = var3.split("|");
		var var5 = Number(var4[0]);
		if(var5 != 1)
		{
			ank.utils.Logger.err("[onCreate] Type incorrect");
			return undefined;
		}
		this.api.datacenter.Game = new dofus.datacenter.Game();
		this.api.datacenter.Game.state = var5;
		var var6 = (dofus.graphics.gapi.ui.Banner)this.api.ui.getUIComponent("Banner");
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(var6);
		this.api.datacenter.Player.data.initAP(false);
		this.api.datacenter.Player.data.initMP(false);
		this.api.datacenter.Player.SpellsManager.clear();
		this.api.datacenter.Player.data.CharacteristicsManager.initialize();
		this.api.datacenter.Player.data.EffectsManager.initialize();
		this.api.datacenter.Player.clearSummon();
		this.api.gfx.cleanMap(1);
		this.onCreateSolo();
	}
	function onJoin(var2)
	{
		this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1] != "0"?true:false;
		var var6 = var3[2] != "0"?true:false;
		var var7 = var3[3] != "0"?true:false;
		var var8 = Number(var3[4]);
		var var9 = Number(var3[5]);
		this.api.datacenter.Game = new dofus.datacenter.Game();
		this.api.datacenter.Game.state = var4;
		this.api.datacenter.Game.fightType = var9;
		var var10 = this.api.ui.getUIComponent("Banner");
		var10.redrawChrono();
		var10.updateEye();
		this.api.datacenter.Game.isSpectator = var7;
		if(!var7)
		{
			this.api.datacenter.Player.data.initAP(false);
			this.api.datacenter.Player.data.initMP(false);
			this.api.datacenter.Player.SpellsManager.clear();
		}
		var10.shortcuts.setCurrentTab("Spells");
		this.api.gfx.cleanMap(1);
		if(this.api.datacenter.Game.isTacticMode)
		{
			this.api.datacenter.Game.isTacticMode = true;
		}
		if(var6)
		{
			this.api.ui.loadUIComponent("ChallengeMenu","ChallengeMenu",{labelReady:this.api.lang.getText("READY"),labelCancel:this.api.lang.getText("CANCEL_SMALL"),cancelButton:var5,ready:false},{bStayIfPresent:true});
		}
		if(!_global.isNaN(var8))
		{
			var10.startTimer(var8 / 1000);
		}
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
		this.api.ui.unloadLastUIAutoHideComponent();
		this.api.ui.unloadUIComponent("FightsInfos");
	}
	function onPositionStart(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1];
		var var6 = Number(var3[2]);
		this.api.datacenter.Basics.aks_current_team = var6;
		this.api.datacenter.Basics.aks_team1_starts = new Array();
		this.api.datacenter.Basics.aks_team2_starts = new Array();
		this.api.kernel.StreamingDisplayManager.onFightStart();
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
		this.api.datacenter.Game.setInteractionType("place");
		if(var6 == undefined)
		{
			ank.utils.Logger.err("[onPositionStart] Impossible de trouver l\'équipe du joueur local !");
		}
		this.api.gfx.mapHandler.showFightCells(var4,var5);
		var var7 = 0;
		while(var7 < var4.length)
		{
			var var8 = ank.utils.Compressor.decode64(var4.charAt(var7)) << 6;
			var8 = var8 + ank.utils.Compressor.decode64(var4.charAt(var7 + 1));
			this.api.datacenter.Basics.aks_team1_starts.push(var8);
			if(var6 == 0)
			{
				this.api.gfx.setInteractionOnCell(var8,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
			}
			var7 = var7 + 2;
		}
		var var9 = 0;
		while(var9 < var5.length)
		{
			var var10 = ank.utils.Compressor.decode64(var5.charAt(var9)) << 6;
			var10 = var10 + ank.utils.Compressor.decode64(var5.charAt(var9 + 1));
			this.api.datacenter.Basics.aks_team2_starts.push(var10);
			if(var6 == 1)
			{
				this.api.gfx.setInteractionOnCell(var10,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
			}
			var9 = var9 + 2;
		}
		if(this.api.ui.getUIComponent("FightOptionButtons") == undefined)
		{
			this.api.ui.loadUIComponent("FightOptionButtons","FightOptionButtons");
		}
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_PLACEMENT);
	}
	function onPlayersCoordinates(var2)
	{
		if(var2 != "e")
		{
			var var3 = var2.split("|");
			var var4 = 0;
			while(var4 < var3.length)
			{
				var var5 = var3[var4].split(";");
				var var6 = var5[0];
				var var7 = Number(var5[1]);
				this.api.gfx.setSpritePosition(var6,var7);
				var4 = var4 + 1;
			}
		}
		else
		{
			this.api.sounds.events.onError();
		}
	}
	function onReady(var2)
	{
		var var3 = var2.charAt(0) == "1";
		var var4 = var2.substr(1);
		if(var3)
		{
			this.api.gfx.addSpriteExtraClip(var4,dofus.Constants.READY_FILE,undefined,true);
		}
		else
		{
			this.api.gfx.removeSpriteExtraClip(var4,true);
		}
	}
	function onStartToPlay()
	{
		this.api.ui.getUIComponent("Banner").stopTimer();
		this.aks.GameActions.onActionsFinish(this.api.datacenter.Player.ID);
		this.api.sounds.events.onGameStart(this.api.datacenter.Map.musics);
		this.api.kernel.StreamingDisplayManager.onFightStartEnd();
		var var2 = this.api.ui.getUIComponent("Banner");
		var2.showGiveUpButton(true);
		if(!this.api.datacenter.Game.isSpectator)
		{
			var var3 = this.api.datacenter.Player.data;
			var3.initAP();
			var3.initMP();
			var3.initLP();
			var2.showPoints(true);
			var2.showNextTurnButton(true);
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
		this.api.gfx.mapHandler.showingFightCells = false;
		if(!this.api.gfx.gridHandler.bGridVisible)
		{
			this.api.gfx.drawGrid();
		}
		this.api.datacenter.Game.setInteractionType("move");
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
		this.api.kernel.GameManager.signalFightActivity();
		this.api.datacenter.Game.isRunning = true;
		var var4 = this.api.datacenter.Sprites.getItems();
		for(var k in var4)
		{
			this.api.gfx.addSpriteExtraClip(k,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var4[k].Team]);
		}
		if(this.api.datacenter.Game.isTacticMode)
		{
			this.api.datacenter.Game.isTacticMode = true;
		}
	}
	function onTurnStart(var2)
	{
		if(this.api.datacenter.Game.isFirstTurn)
		{
			this.api.datacenter.Game.isFirstTurn = false;
			var var3 = this.api.gfx.spriteHandler.getSprites().getItems();
			for(var sID in var3)
			{
				this.api.gfx.removeSpriteExtraClip(sID,true);
			}
		}
		var var4 = var2.split("|");
		var var5 = var4[0];
		var var6 = Number(var4[1]) / 1000;
		var var7 = Number(var4[2]);
		this.api.datacenter.Game.currentTableTurn = var7;
		var var8 = this.api.datacenter.Sprites.getItemAt(var5);
		var8.GameActionsManager.clear();
		this.api.gfx.unSelect(true);
		this.api.datacenter.Game.currentPlayerID = var5;
		this.api.kernel.GameManager.cleanPlayer(this.api.datacenter.Game.lastPlayerID);
		this.api.ui.getUIComponent("Timeline").nextTurn(var5);
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
			this.api.ui.getUIComponent("Banner").startTimer(var6);
			this.api.kernel.GameManager.startInactivityDetector();
			dofus.DofusCore.getInstance().forceMouseOver();
			this.api.gfx.mapHandler.resetEmptyCells();
		}
		else
		{
			this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
			this.api.ui.getUIComponent("Timeline").startChrono(var6);
			if(this.api.datacenter.Game.isSpectator && this.api.kernel.OptionsManager.getOption("SpriteInfos"))
			{
				this.api.ui.getUIComponent("Banner").showRightPanel("BannerSpriteInfos",{data:var8},true);
			}
		}
		if(this.api.kernel.OptionsManager.getOption("StringCourse"))
		{
			var var9 = new Array();
			var9[1] = var8.color1;
			var9[2] = var8.color2;
			var9[3] = var8.color3;
			this.api.ui.loadUIComponent("StringCourse","StringCourse",{gfx:var8.artworkFile,name:var8.name,level:this.api.lang.getText("LEVEL_SMALL") + " " + var8.Level,colors:var9},{bForceLoad:true});
		}
		this.api.kernel.GameManager.cleanUpGameArea(true);
		ank.utils.Timer.setTimer(this.api.network.Ping,"GameDecoDetect",this.api.network,this.api.network.quickPing,var6 * 1000);
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_START);
	}
	function onTurnFinish(var2)
	{
		var var3 = var2;
		var var4 = this.api.datacenter.Sprites.getItemAt(var3);
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
	function onTurnlist(var2)
	{
		var var3 = var2.split("|");
		this.api.datacenter.Game.turnSequence = var3;
		this.api.ui.getUIComponent("Timeline").update();
	}
	function onTurnMiddle(var2)
	{
		if(!this.api.datacenter.Game.isRunning)
		{
			ank.utils.Logger.err("[innerOnTurnMiddle] on est pas en combat");
			return undefined;
		}
		var var3 = var2.split("|");
		var var4 = new Object();
		var var5 = 0;
		for(; var5 < var3.length; var5 = var5 + 1)
		{
			var var6 = var3[var5].split(";");
			if(var6.length != 0)
			{
				var var7 = var6[0];
				var var8 = var6[1] != "1"?false:true;
				var var9 = Number(var6[2]);
				var var10 = Number(var6[3]);
				var var11 = Number(var6[4]);
				var var12 = Number(var6[5]);
				var var13 = Number(var6[6]);
				var var14 = Number(var6[7]);
				var4[var7] = true;
				var var15 = this.api.datacenter.Sprites.getItemAt(var7);
				if(var15 != undefined)
				{
					var var16 = var15.sequencer;
					if(var8)
					{
						if(var16.isPlaying())
						{
							continue;
						}
						var15.mc.clear();
						this.api.gfx.removeSpriteOverHeadLayer(var7,"text");
					}
					else
					{
						var15.LP = var9;
						var15.LPmax = var14;
						var15.AP = var10;
						var15.MP = var11;
						if(var16.isPlaying())
						{
							continue;
						}
						if(!_global.isNaN(var12) && !var15.hasCarriedParent())
						{
							this.api.gfx.setSpritePosition(var7,var12);
						}
						if(var15.hasCarriedChild())
						{
							var15.carriedChild.updateCarriedPosition();
						}
					}
				}
				else
				{
					ank.utils.Logger.err("[onTurnMiddle] le sprite n\'existe pas");
				}
			}
		}
		var var17 = this.api.datacenter.Sprites.getItems();
		for(var k in var17)
		{
			if(!var4[k])
			{
				var17[k].mc.clear();
				this.api.datacenter.Sprites.removeItemAt(k);
			}
		}
		this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
	}
	function prepareTurnEnd()
	{
		if(!this.api.datacenter.Game.isRunning || (!this.api.datacenter.Game.isFight || !this.api.datacenter.Player.isCurrentPlayer))
		{
			return undefined;
		}
		var var2 = this.api.datacenter.Player.data.sequencer;
		if(var2.containsAction(this,this.turnEnd))
		{
			return undefined;
		}
		var2.addAction(24,false,this,this.turnEnd,[]);
		var2.execute();
	}
	function onTurnReady(var2)
	{
		var var3 = var2;
		var var4 = this.api.datacenter.Sprites.getItemAt(var3);
		if(var4 != undefined)
		{
			var var5 = var4.sequencer;
			var5.addAction(25,false,this,this.turnOk);
			var5.execute();
		}
		else
		{
			ank.utils.Logger.err("[onTurnReday] le sprite " + var3 + " n\'existe pas");
			this.turnOk2();
		}
	}
	function onMapData(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1];
		var var6 = var3[2];
		if(Number(var4) == this.api.datacenter.Map.id)
		{
			this.api.gfx.onMapLoaded();
			return undefined;
		}
		this.api.gfx.showContainer(false);
		this.nLastMapIdReceived = _global.parseInt(var4,10);
		this.api.kernel.MapsServersManager.loadMap(var4,var5,var6);
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
	function onMovement(var2, var3)
	{
		var var4 = var2.split("|");
		var var5 = var4.length - 1;
		for(; var5 >= 0; var5 = var5 - 1)
		{
			var var6 = var4[var5];
			if(var6.length != 0)
			{
				var var7 = false;
				var var8 = false;
				var var9 = var6.charAt(0);
				if(var9 == "+")
				{
					var8 = true;
				}
				else if(var9 == "~")
				{
					var8 = true;
					var7 = true;
				}
				else if(var9 != "-")
				{
					continue;
				}
				if(var8)
				{
					var var10 = var6.substr(1).split(";");
					var var11 = var10[0];
					if(var11 == "-1")
					{
						var11 = String(this.api.datacenter.Player.data.cellNum);
					}
					var var12 = var10[1];
					var var13 = Number(var10[2]);
					var var14 = var10[3];
					var var15 = var10[4];
					var var16 = var10[5];
					var var17 = var10[6];
					var var18 = false;
					var var19 = true;
					if(var17.charAt(var17.length - 1) == "*")
					{
						var17 = var17.substr(0,var17.length - 1);
						var18 = true;
					}
					if(var17.charAt(0) == "*")
					{
						var19 = false;
						var17 = var17.substr(1);
					}
					var var20 = var17.split("^");
					var var21 = var20.length != 2?var17:var20[0];
					var var22 = var16.split(",");
					var var23 = var22[0];
					var var24 = var22[1];
					var var25 = undefined;
					if(var24.length)
					{
						var var26 = var24.split("*");
						var25 = new dofus.datacenter.(_global.parseInt(var26[0]),var26[1]);
					}
					var var27 = 100;
					var var28 = 100;
					if(var20.length == 2)
					{
						var var29 = var20[1];
						if(_global.isNaN(Number(var29)))
						{
							var var30 = var29.split("x");
							var27 = var30.length != 2?100:Number(var30[0]);
							var28 = var30.length != 2?100:Number(var30[1]);
						}
						else
						{
							var27 = var28 = Number(var29);
						}
					}
					if(var7)
					{
						var var31 = this.api.datacenter.Sprites.getItemAt(var14);
						this.onSpriteMovement(false,var31);
					}
					loop3:
					switch(var23)
					{
						case "-1":
						case "-2":
							var var33 = new Object();
							var33.spriteType = var23;
							var33.gfxID = var21;
							var33.scaleX = var27;
							var33.scaleY = var28;
							var33.noFlip = var18;
							var33.cell = var11;
							var33.dir = var12;
							var33.powerLevel = var10[7];
							var33.color1 = var10[8];
							var33.color2 = var10[9];
							var33.color3 = var10[10];
							var33.accessories = var10[11];
							if(this.api.datacenter.Game.isFight)
							{
								var33.LP = var10[12];
								var33.AP = var10[13];
								var33.MP = var10[14];
								if(var10.length > 18)
								{
									var33.resistances = new Array(Number(var10[15]),Number(var10[16]),Number(var10[17]),Number(var10[18]),Number(var10[19]),Number(var10[20]),Number(var10[21]));
									var33.team = var10[22];
								}
								else
								{
									var33.team = var10[15];
								}
								var33.summoned = var3;
							}
							if(var23 == -1)
							{
								var31 = this.api.kernel.CharactersManager.createCreature(var14,var15,var33);
							}
							else
							{
								var31 = this.api.kernel.CharactersManager.createMonster(var14,var15,var33);
							}
							break;
						case "-3":
							var var34 = new Object();
							var34.spriteType = var23;
							var34.level = var10[7];
							var34.scaleX = var27;
							var34.scaleY = var28;
							var34.noFlip = var18;
							var34.cell = Number(var11);
							var34.dir = var12;
							var var35 = var10[8].split(",");
							var34.color1 = var35[0];
							var34.color2 = var35[1];
							var34.color3 = var35[2];
							var34.accessories = var10[9];
							var34.bonusValue = var13;
							var var36 = this.sliptGfxData(var17);
							var var37 = var36.gfx;
							this.splitGfxForScale(var37[0],var34);
							var31 = this.api.kernel.CharactersManager.createMonsterGroup(var14,var15,var34);
							if(this.api.kernel.OptionsManager.getOption("ViewAllMonsterInGroup") == true)
							{
								var var38 = var14;
								var var39 = 1;
								while(var39 < var37.length)
								{
									if(var37[var5] != "")
									{
										this.splitGfxForScale(var37[var39],var34);
										var35 = var10[8 + 2 * var39].split(",");
										var34.color1 = var35[0];
										var34.color2 = var35[1];
										var34.color3 = var35[2];
										var34.dir = random(4) * 2 + 1;
										var34.accessories = var10[9 + 2 * var39];
										var var40 = var14 + "_" + var39;
										var var41 = this.api.kernel.CharactersManager.createMonsterGroup(var40,undefined,var34);
										var var42 = var38;
										if(random(3) != 0 && var39 != 1)
										{
											var42 = var14 + "_" + (random(var39 - 1) + 1);
										}
										var var43 = random(8);
										this.api.gfx.addLinkedSprite(var40,var42,var43,var41);
										if(!_global.isNaN(var41.scaleX))
										{
											this.api.gfx.setSpriteScale(var41.id,var41.scaleX,var41.scaleY);
										}
										switch(var36.shape)
										{
											case "circle":
												var43 = var39;
												break;
											case "line":
												var42 = var40;
												var43 = 2;
										}
									}
									var39 = var39 + 1;
								}
							}
							break;
						case "-4":
							var var44 = new Object();
							var44.spriteType = var23;
							var44.gfxID = var21;
							var44.scaleX = var27;
							var44.scaleY = var28;
							var44.cell = var11;
							var44.dir = var12;
							var44.sex = var10[7];
							var44.color1 = var10[8];
							var44.color2 = var10[9];
							var44.color3 = var10[10];
							var44.accessories = var10[11];
							var44.extraClipID = !(var10[12] != undefined && !_global.isNaN(Number(var10[12])))?-1:Number(var10[12]);
							var44.customArtwork = Number(var10[13]);
							var31 = this.api.kernel.CharactersManager.createNonPlayableCharacter(var14,Number(var15),var44);
							break;
						case "-5":
							var var45 = new Object();
							var45.spriteType = var23;
							var45.gfxID = var21;
							var45.scaleX = var27;
							var45.scaleY = var28;
							var45.cell = var11;
							var45.dir = var12;
							var45.color1 = var10[7];
							var45.color2 = var10[8];
							var45.color3 = var10[9];
							var45.accessories = var10[10];
							var45.guildName = var10[11];
							var45.emblem = var10[12];
							var45.offlineType = var10[13];
							var31 = this.api.kernel.CharactersManager.createOfflineCharacter(var14,var15,var45);
							break;
						default:
							switch(null)
							{
								case "-6":
									var var46 = new Object();
									var46.spriteType = var23;
									var46.gfxID = var21;
									var46.scaleX = var27;
									var46.scaleY = var28;
									var46.cell = var11;
									var46.dir = var12;
									var46.level = var10[7];
									if(this.api.datacenter.Game.isFight)
									{
										var46.LP = var10[8];
										var46.AP = var10[9];
										var46.MP = var10[10];
										var46.resistances = new Array(Number(var10[11]),Number(var10[12]),Number(var10[13]),Number(var10[14]),Number(var10[15]),Number(var10[16]),Number(var10[17]));
										var46.team = var10[18];
									}
									else
									{
										var46.guildName = var10[8];
										var46.emblem = var10[9];
									}
									var31 = this.api.kernel.CharactersManager.createTaxCollector(var14,var15,var46);
									break loop3;
								case "-7":
								case "-8":
									var var47 = new Object();
									var47.spriteType = var23;
									var47.gfxID = var21;
									var47.scaleX = var27;
									var47.scaleY = var28;
									var47.cell = var11;
									var47.dir = var12;
									var47.sex = var10[7];
									var47.powerLevel = var10[8];
									var47.accessories = var10[9];
									if(this.api.datacenter.Game.isFight)
									{
										var47.LP = var10[10];
										var47.AP = var10[11];
										var47.MP = var10[12];
										var47.team = var10[20];
									}
									else
									{
										var47.emote = var10[10];
										var47.emoteTimer = var10[11];
										var47.restrictions = Number(var10[12]);
									}
									if(var23 == "-8")
									{
										var47.showIsPlayer = true;
										var var48 = var15.split("~");
										var47.monsterID = var48[0];
										var47.playerName = var48[1];
									}
									else
									{
										var47.showIsPlayer = false;
										var47.monsterID = var15;
									}
									var31 = this.api.kernel.CharactersManager.createMutant(var14,var47);
									break loop3;
								case "-9":
									var var49 = new Object();
									var49.spriteType = var23;
									var49.gfxID = var21;
									var49.scaleX = var27;
									var49.scaleY = var28;
									var49.cell = var11;
									var49.dir = var12;
									var49.ownerName = var10[7];
									var49.level = var10[8];
									var49.modelID = var10[9];
									var31 = this.api.kernel.CharactersManager.createParkMount(var14,var15 == ""?this.api.lang.getText("NO_NAME"):var15,var49);
									break loop3;
								default:
									if(var0 !== "-10")
									{
										var var52 = new Object();
										var52.spriteType = var23;
										var52.cell = var11;
										var52.scaleX = var27;
										var52.scaleY = var28;
										var52.dir = var12;
										var52.sex = var10[7];
										if(this.api.datacenter.Game.isFight)
										{
											var52.level = var10[8];
											var var51 = var10[9];
											var52.color1 = var10[10];
											var52.color2 = var10[11];
											var52.color3 = var10[12];
											var52.accessories = var10[13];
											var52.LP = var10[14];
											var52.AP = var10[15];
											var52.MP = var10[16];
											var52.resistances = new Array(Number(var10[17]),Number(var10[18]),Number(var10[19]),Number(var10[20]),Number(var10[21]),Number(var10[22]),Number(var10[23]));
											var52.team = var10[24];
											if(var10[25].indexOf(",") != -1)
											{
												var var53 = var10[25].split(",");
												var var54 = Number(var53[0]);
												var var55 = _global.parseInt(var53[1],16);
												var var56 = _global.parseInt(var53[2],16);
												var var57 = _global.parseInt(var53[3],16);
												if(var55 == -1 || _global.isNaN(var55))
												{
													var55 = this.api.datacenter.Player.color1;
												}
												if(var56 == -1 || _global.isNaN(var56))
												{
													var56 = this.api.datacenter.Player.color2;
												}
												if(var57 == -1 || _global.isNaN(var57))
												{
													var57 = this.api.datacenter.Player.color3;
												}
												if(!_global.isNaN(var54))
												{
													var var58 = new dofus.datacenter.Mount(var54,Number(var21));
													var58.customColor1 = var55;
													var58.customColor2 = var56;
													var58.customColor3 = var57;
													var52.mount = var58;
												}
											}
											else
											{
												var var59 = Number(var10[25]);
												if(!_global.isNaN(var59))
												{
													var52.mount = new dofus.datacenter.Mount(var59,Number(var21));
												}
											}
										}
										else
										{
											var51 = var10[8];
											var52.color1 = var10[9];
											var52.color2 = var10[10];
											var52.color3 = var10[11];
											var52.accessories = var10[12];
											var52.aura = var10[13];
											var52.emote = var10[14];
											var52.emoteTimer = var10[15];
											var52.guildName = var10[16];
											var52.emblem = var10[17];
											var52.restrictions = var10[18];
											if(var10[19].indexOf(",") != -1)
											{
												var var60 = var10[19].split(",");
												var var61 = Number(var60[0]);
												var var62 = _global.parseInt(var60[1],16);
												var var63 = _global.parseInt(var60[2],16);
												var var64 = _global.parseInt(var60[3],16);
												if(var62 == -1 || _global.isNaN(var62))
												{
													var62 = this.api.datacenter.Player.color1;
												}
												if(var63 == -1 || _global.isNaN(var63))
												{
													var63 = this.api.datacenter.Player.color2;
												}
												if(var64 == -1 || _global.isNaN(var64))
												{
													var64 = this.api.datacenter.Player.color3;
												}
												if(!_global.isNaN(var61))
												{
													var var65 = new dofus.datacenter.Mount(var61,Number(var21));
													var65.customColor1 = var62;
													var65.customColor2 = var63;
													var65.customColor3 = var64;
													var52.mount = var65;
												}
											}
											else
											{
												var var66 = Number(var10[19]);
												if(!_global.isNaN(var66))
												{
													var52.mount = new dofus.datacenter.Mount(var66,Number(var21));
												}
											}
										}
										if(var7)
										{
											var var32 = [var14,this.createTransitionEffect(),var11,10];
										}
										var var67 = var51.split(",");
										var52.alignment = new dofus.datacenter.(Number(var67[0]),Number(var67[1]));
										var52.rank = new dofus.datacenter.Rank(Number(var67[2]));
										var52.alignment.fallenAngelDemon = var67[4] == 1;
										if(var67.length > 3 && var14 != this.api.datacenter.Player.ID)
										{
											if(this.api.lang.getAlignmentCanViewPvpGain(this.api.datacenter.Player.alignment.index,Number(var52.alignment.index)))
											{
												var var68 = Number(var67[3]) - _global.parseInt(var14);
												var var69 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT");
												var var70 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT_PRC");
												var var71 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT");
												var var72 = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT_PRC");
												var var73 = 0;
												if(this.api.datacenter.Player.Level * (1 - var70 / 100) > var68)
												{
													var73 = -1;
												}
												if(this.api.datacenter.Player.Level - var68 > var69)
												{
													var73 = -1;
												}
												if(this.api.datacenter.Player.Level * (1 + var72 / 100) < var68)
												{
													var73 = 1;
												}
												if(this.api.datacenter.Player.Level - var68 < var71)
												{
													var73 = 1;
												}
												var52.pvpGain = var73;
											}
										}
										if(!this.api.datacenter.Game.isFight && (_global.parseInt(var14,10) != this.api.datacenter.Player.ID && ((this.api.datacenter.Player.alignment.index == 1 || this.api.datacenter.Player.alignment.index == 2) && ((var52.alignment.index == 1 || var52.alignment.index == 2) && (var52.alignment.index != this.api.datacenter.Player.alignment.index && (var52.rank.value && this.api.datacenter.Map.bCanAttack))))))
										{
											if(this.api.datacenter.Player.rank.value > var52.rank.value)
											{
												this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
											}
											if(this.api.datacenter.Player.rank.value < var52.rank.value)
											{
												this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
											}
										}
										var var74 = this.sliptGfxData(var17);
										var var75 = var74.gfx;
										this.splitGfxForScale(var75[0],var52);
										var52.title = var25;
										var31 = this.api.kernel.CharactersManager.createCharacter(var14,var15,var52);
										(dofus.datacenter.Character)var31.isClear = false;
										var31.allowGhostMode = var19;
										var var76 = var14;
										var var77 = var74.shape != "circle"?2:0;
										var var78 = 1;
										while(var78 < var75.length)
										{
											if(var75[var78] != "")
											{
												var var79 = var14 + "_" + var78;
												var var80 = new Object();
												this.splitGfxForScale(var75[var78],var80);
												var var81 = new ank.battlefield.datacenter.(var79,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var80.gfxID + ".swf");
												var81.allDirections = false;
												this.api.gfx.addLinkedSprite(var79,var76,var77,var81);
												if(!_global.isNaN(var80.scaleX))
												{
													this.api.gfx.setSpriteScale(var81.id,var80.scaleX,var80.scaleY);
												}
												switch(var74.shape)
												{
													case "circle":
														var77 = var78;
														break;
													case "line":
														var76 = var79;
														var77 = 2;
												}
											}
											var78 = var78 + 1;
										}
										break loop3;
										break loop3;
									}
									var var50 = new Object();
									var50.spriteType = var23;
									var50.gfxID = var21;
									var50.scaleX = var27;
									var50.scaleY = var28;
									var50.cell = var11;
									var50.dir = var12;
									var50.level = var10[7];
									var50.alignment = new dofus.datacenter.(Number(var10[9]),Number(var10[8]));
									var31 = this.api.kernel.CharactersManager.createPrism(var14,var15,var50);
									break loop3;
							}
					}
					break loop2;
				}
				var var82 = var6.substr(1);
				var var83 = this.api.datacenter.Sprites.getItemAt(var82);
				if(!this.api.datacenter.Game.isRunning && this.api.datacenter.Game.isLoggingMapDisconnections)
				{
					var var84 = var83.name;
					var var85 = this._aGameSpriteLeftHistory[var82];
					if(!_global.isNaN(var85) && getTimer() - var85 < 300)
					{
						this.api.kernel.showMessage(undefined,this.api.kernel.DebugManager.getTimestamp() + " (Map) " + this.api.kernel.ChatManager.getLinkName(var84) + " s\'est déconnecté (" + var82 + ")","ADMIN_CHAT");
					}
					this._aGameSpriteLeftHistory[var82] = getTimer();
				}
				this.onSpriteMovement(var8,var83);
			}
		}
	}
	function onCellData(var2)
	{
		var var3 = var2.split("|");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4].split(";");
			var var6 = Number(var5[0]);
			var var7 = var5[1].substring(0,10);
			var var8 = var5[1].substr(10);
			var var9 = var5[2] != "0"?1:0;
			this.api.gfx.updateCell(var6,var7,var8,var9);
			var4 = var4 + 1;
		}
	}
	function onZoneData(var2)
	{
		var var3 = var2.split("|");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4];
			var var6 = var5.charAt(0) != "+"?false:true;
			var var7 = var5.substr(1).split(";");
			var var8 = Number(var7[0]);
			var var9 = Number(var7[1]);
			var var10 = var7[2];
			if(var6)
			{
				this.api.gfx.drawZone(var8,0,var9,var10,dofus.Constants.ZONE_COLOR[var10]);
			}
			else
			{
				this.api.gfx.clearZone(var8,var9,var10);
			}
			var4 = var4 + 1;
		}
	}
	function onCellObject(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = 0;
		while(var5 < var4.length)
		{
			var var6 = var4[var5].split(";");
			var var7 = Number(var6[0]);
			var var8 = _global.parseInt(var6[1]);
			if(var3)
			{
				var var9 = new dofus.datacenter.(0,var8);
				var var10 = Number(var6[2]);
				if((var var0 = var10) !== 0)
				{
					if(var0 === 1)
					{
						if(this.api.gfx.mapHandler.getCellData(var7).layerObjectExternalData.unicID != var8)
						{
							this.api.gfx.updateCellObjectExternalWithExternalClip(var7,var9.iconFile,1,true,false,var9);
						}
						else
						{
							var9 = this.api.gfx.mapHandler.getCellData(var7).layerObjectExternalData;
						}
						var9.durability = Number(var6[3]);
						var9.durabilityMax = Number(var6[4]);
					}
				}
				else
				{
					this.api.gfx.updateCellObjectExternalWithExternalClip(var7,var9.iconFile,1,true,true,var9);
				}
			}
			else
			{
				var var11 = this.api.gfx.mapHandler.getCellData(var7);
				if(var11 != undefined && (var11.mcObjectExternal != undefined && var11.mcObjectExternal == this.api.gfx.rollOverMcObject))
				{
					this.api.gfx.onObjectRollOut(var11.mcObjectExternal);
				}
				this.api.gfx.initializeCell(var7,1);
			}
			var5 = var5 + 1;
		}
	}
	function onFrameObject2(var2)
	{
		var var3 = var2.split("|");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4].split(";");
			var var6 = Number(var5[0]);
			var var7 = var5[1];
			var var8 = var5[2] != undefined;
			var var9 = var5[2] != "1"?false:true;
			if(var8)
			{
				this.api.gfx.setObject2Interactive(var6,var9,2);
			}
			this.api.gfx.setObject2Frame(var6,var7);
			var4 = var4 + 1;
		}
	}
	function onFrameObjectExternal(var2)
	{
		var var3 = var2.split("|");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4].split(";");
			var var6 = Number(var5[0]);
			var var7 = Number(var5[1]);
			this.api.gfx.setObjectExternalFrame(var6,var7);
			var4 = var4 + 1;
		}
	}
	function onEffect(var2)
	{
		var var3 = var2.split(";");
		var var4 = var3[0];
		var var5 = var3[1].split(",");
		var var6 = var3[2];
		var var7 = var3[3];
		var var8 = var3[4];
		var var9 = var3[5];
		var var10 = Number(var3[6]);
		var var11 = var3[7];
		var var12 = var3[8];
		var var13 = 0;
		while(var13 < var5.length)
		{
			var var14 = var5[var13];
			if(var14 == this.api.datacenter.Game.currentPlayerID && var10 != -1)
			{
				var10 = var10 + 1;
			}
			var var15 = new dofus.datacenter.(var12,Number(var4),Number(var6),Number(var7),Number(var8),var9,Number(var10),Number(var11));
			var var16 = this.api.datacenter.Sprites.getItemAt(var14);
			var16.EffectsManager.addEffect(var15);
			var13 = var13 + 1;
		}
	}
	function onClearAllEffect(var2)
	{
		var var3 = this.api.datacenter.Sprites;
		for(var a in var3)
		{
			var3[a].EffectsManager.terminateAllEffects();
		}
	}
	function onChallenge(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = var4.shift().split(";");
		var var6 = Number(var5[0]);
		var var7 = Number(var5[1]);
		var var8 = (Math.cos(var6) + 1) * 8388607;
		if(var3)
		{
			var var9 = new dofus.datacenter.Challenge(var6,var7);
			this.api.datacenter.Challenges.addItemAt(var6,var9);
			var var10 = 0;
			while(var10 < var4.length)
			{
				var var11 = var4[var10].split(";");
				var var12 = var11[0];
				var var13 = Number(var11[1]);
				var var14 = Number(var11[2]);
				var var15 = Number(var11[3]);
				var var16 = dofus.Constants.getTeamFileFromType(var14,var15);
				var var17 = new dofus.datacenter.Team(var12,ank.battlefield.mc.Sprite,var16,var13,var8,var14,var15);
				var9.addTeam(var17);
				this.api.gfx.addSprite(var17.id,var17);
				var10 = var10 + 1;
			}
		}
		else
		{
			var var18 = this.api.datacenter.Challenges.getItemAt(var6).teams;
			for(var k in var18)
			{
				var var19 = var18[k];
				this.api.gfx.removeSprite(var19.id);
			}
			this.api.datacenter.Challenges.removeItemAt(var6);
		}
	}
	function onTeam(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3.shift());
		var var5 = this.api.datacenter.Sprites.getItemAt(var4);
		var var6 = 0;
		while(var6 < var3.length)
		{
			var var7 = var3[var6].split(";");
			var var8 = var7[0].charAt(0) == "+";
			var var9 = var7[0].substr(1);
			var var10 = var7[1];
			var var11 = var7[2];
			var var12 = var10.split(",");
			var var13 = Number(var10);
			if(var12.length > 1)
			{
				var10 = this.api.lang.getFullNameText(var12);
			}
			else if(!_global.isNaN(var13))
			{
				var10 = this.api.lang.getMonstersText(var13).n;
			}
			if(var8)
			{
				var var14 = new Object();
				var14.id = var9;
				var14.name = var10;
				var14.level = var11;
				var5.addPlayer(var14);
			}
			else
			{
				var5.removePlayer(var9);
			}
			var6 = var6 + 1;
		}
	}
	function onFightOption(var2)
	{
		var var3 = var2.substr(2);
		var var4 = this.api.datacenter.Sprites.getItemAt(var3);
		if(var4 != undefined)
		{
			var var5 = var2.charAt(0) == "+";
			var var6 = var2.charAt(1);
			switch(var6)
			{
				case "H":
					var4.options[dofus.datacenter.Team.OPT_NEED_HELP] = var5;
					break;
				case "S":
					var4.options[dofus.datacenter.Team.OPT_BLOCK_SPECTATOR] = var5;
					break;
				default:
					switch(null)
					{
						case "A":
							var4.options[dofus.datacenter.Team.OPT_BLOCK_JOINER] = var5;
							break;
						case "P":
							var4.options[dofus.datacenter.Team.OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER] = var5;
					}
			}
			this.api.gfx.addSpriteOverHeadItem(var3,"FightOptions",dofus.graphics.battlefield.FightOptionsOverHead,[var4],undefined);
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
		var var2 = (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge");
		var2.cleanChallenge();
		this.create();
	}
	function onEnd(var2)
	{
		if(this.api.kernel.MapsServersManager.isBuilding)
		{
			this.addToQueue({object:this,method:this.onEnd,params:[var2]});
			return undefined;
		}
		this._bIsBusy = true;
		var var3 = (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge");
		this.api.kernel.StreamingDisplayManager.onFightEnd();
		var var4 = {winners:[],loosers:[],collectors:[],challenges:var3.challenges.clone(),currentTableTurn:this.api.datacenter.Game.currentTableTurn};
		this.api.datacenter.Game.results = var4;
		var3.cleanChallenge();
		var var5 = var2.split("|");
		var var6 = -1;
		if(!_global.isNaN(Number(var5[0])))
		{
			var4.duration = Number(var5[0]);
		}
		else
		{
			var var7 = var5[0].split(";");
			var4.duration = Number(var7[0]);
			var6 = Number(var7[1]);
		}
		this.api.datacenter.Basics.aks_game_end_bonus = var6;
		var var8 = Number(var5[1]);
		var var9 = Number(var5[2]);
		var4.fightType = var9;
		var var10 = new ank.utils.();
		var var11 = 0;
		this.parsePlayerData(var4,3,var8,var5,var9,var11,var10);
	}
	function parsePlayerData(var2, var3, var4, var5, var6, var7, var8)
	{
		var var9 = var3;
		var var10 = var5[var9].split(";");
		var var11 = new Object();
		if(Number(var10[0]) != 6)
		{
			var11.id = Number(var10[1]);
			if(var11.id == this.api.datacenter.Player.ID)
			{
				if(Number(var10[0]) == 0)
				{
					this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_LOST);
				}
				else
				{
					this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_WON);
				}
			}
			var var13 = this.api.kernel.CharactersManager.getNameFromData(var10[2]);
			var11.name = var13.name;
			var11.type = var13.type;
			var11.level = Number(var10[3]);
			var11.bDead = var10[4] != "1"?false:true;
			if((var var0 = var6) !== 0)
			{
				if(var0 === 1)
				{
					var11.minhonour = Number(var10[5]);
					var11.honour = Number(var10[6]);
					var11.maxhonour = Number(var10[7]);
					var11.winhonour = Number(var10[8]);
					var11.rank = Number(var10[9]);
					var11.disgrace = Number(var10[10]);
					var11.windisgrace = Number(var10[11]);
					var11.maxdisgrace = this.api.lang.getMaxDisgracePoints();
					var11.mindisgrace = 0;
					var var12 = var10[12].split(",");
					if(var11.id == this.api.datacenter.Player.ID && var12.length > 10)
					{
						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
					}
					var11.kama = var10[13];
					var11.minxp = Number(var10[14]);
					var11.xp = Number(var10[15]);
					var11.maxxp = Number(var10[16]);
					var11.winxp = Number(var10[17]);
				}
			}
			else
			{
				var11.minxp = Number(var10[5]);
				var11.xp = Number(var10[6]);
				var11.maxxp = Number(var10[7]);
				var11.winxp = Number(var10[8]);
				var11.guildxp = Number(var10[9]);
				var11.mountxp = Number(var10[10]);
				var12 = var10[11].split(",");
				if(var11.id == this.api.datacenter.Player.ID && var12.length > 10)
				{
					this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
				}
				var11.kama = var10[12];
			}
		}
		else
		{
			var12 = var10[1].split(",");
			var11.kama = var10[2];
			var7 = var7 + Number(var11.kama);
		}
		var11.items = new Array();
		var var14 = var12.length;
		while((var14 = var14 - 1) >= 0)
		{
			var var15 = var12[var14].split("~");
			var var16 = Number(var15[0]);
			var var17 = Number(var15[1]);
			if(_global.isNaN(var16))
			{
				break;
			}
			if(var16 != 0)
			{
				var var18 = new dofus.datacenter.(0,var16,var17);
				var11.items.push(var18);
			}
		}
		switch(Number(var10[0]))
		{
			case 0:
				var2.loosers.push(var11);
				break;
			case 2:
				var2.winners.push(var11);
				break;
			default:
				switch(null)
				{
					case 5:
						var2.collectors.push(var11);
						break;
					case 6:
						var8 = var8.concat(var11.items);
				}
		}
		var9 = var9 + 1;
		if(var9 < var5.length)
		{
			this.addToQueue({object:this,method:this.parsePlayerData,params:[var2,var9,var4,var5,var6,var7,var8]});
		}
		else
		{
			this.onParseItemEnd(var4,var2,var8,var7);
		}
	}
	function onParseItemEnd(var2, var3, var4, var5)
	{
		if(var4.length)
		{
			var var6 = Math.ceil(var4.length / var3.winners.length);
			var var7 = 0;
			while(var7 < var3.winners.length)
			{
				var var8 = var4.length;
				var3.winners[var7].kama = Math.ceil(var5 / var6);
				if(var7 == var3.winners.length - 1)
				{
					var6 = var8;
				}
				var var9 = var8 - var6;
				while(var9 < var8)
				{
					var3.winners[var7].items.push(var4.pop());
					var9 = var9 + 1;
				}
				var7 = var7 + 1;
			}
		}
		if(var2 == this.api.datacenter.Player.ID)
		{
			this.aks.GameActions.onActionsFinish(String(var2));
		}
		this.api.datacenter.Game.isRunning = false;
		var var10 = this.api.datacenter.Sprites.getItemAt(var2).sequencer;
		this._bIsBusy = false;
		if(var10 != undefined)
		{
			var10.addAction(26,false,this.api.kernel.GameManager,this.api.kernel.GameManager.terminateFight);
			var10.execute(false);
		}
		else
		{
			ank.utils.Logger.err("[AKS.Game.onEnd] Impossible de trouver le sequencer");
			ank.utils.Timer.setTimer(this,"game",this.api.kernel.GameManager,this.api.kernel.GameManager.terminateFight,500);
		}
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDFIGHT);
	}
	function onExtraClip(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1].split(";");
		var var6 = dofus.Constants.EXTRA_PATH + var4 + ".swf";
		var var7 = var4 == "-";
		for(var k in var5)
		{
			var var8 = var5[k];
			if(var7)
			{
				this.api.gfx.removeSpriteExtraClip(var8,false);
			}
			else
			{
				this.api.gfx.addSpriteExtraClip(var8,var6,undefined,false);
			}
		}
	}
	function onPVP(var2, var3)
	{
		if(!var3)
		{
			var var4 = Number(var2);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ASK_DISABLE_PVP",[var4]),"CAUTION_YESNO",{name:"DisabledPVP",listener:this});
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
			var var2 = this.api.ui.getUIComponent("Banner");
			var2.showPoints(false);
			var2.showNextTurnButton(false);
			var2.showGiveUpButton(false);
			this.api.ui.unloadUIComponent("FightOptionButtons");
			this.api.ui.unloadUIComponent("ChallengeMenu");
		}
		this.api.gfx.cleanMap(2);
	}
	function onSpriteMovement(var2, var3, var4)
	{
		if(oSprite instanceof dofus.datacenter.Character)
		{
			this.api.datacenter.Game.playerCount = this.api.datacenter.Game.playerCount + (!var2?-1:1);
		}
		if(var2)
		{
			if(var4 != undefined)
			{
				this.api.gfx.spriteLaunchVisualEffect.apply(this.api.gfx,var4);
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
			}
			else if(this.api.gfx.spriteHandler.isPlayerSpritesHidden && (oSprite instanceof dofus.datacenter.Character || (oSprite instanceof dofus.datacenter.PlayerShop || oSprite instanceof dofus.datacenter.MonsterGroup)))
			{
				this.api.gfx.spriteHandler.hidePlayerSprites();
			}
			else if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && oSprite instanceof dofus.datacenter.MonsterGroup)
			{
				oSprite.mc._rollOver(true);
			}
		}
		else if(!this.api.datacenter.Game.isRunning)
		{
			this.api.gfx.removeSprite(oSprite.id);
		}
		else
		{
			var var5 = oSprite.sequencer;
			var var6 = oSprite.mc;
			var5.addAction(27,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("LEAVE_GAME",[oSprite.name]),"INFO_CHAT"]);
			var5.addAction(28,false,this.api.ui.getUIComponent("Timeline"),this.api.ui.getUIComponent("Timeline").hideItem,[oSprite.id]);
			var5.addAction(29,true,var6,var6.setAnim,["Die"],1500,true);
			if(oSprite.hasCarriedChild())
			{
				this.api.gfx.uncarriedSprite(oSprite.carriedChild.id,oSprite.cellNum,false,var5);
				var5.addAction(30,false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[oSprite.carriedChild.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[oSprite.carriedChild.Team]]);
			}
			var5.addAction(31,false,var6,var6.clear);
			var5.execute();
			if(this.api.datacenter.Game.currentPlayerID == oSprite.id)
			{
				this.api.ui.getUIComponent("Banner").stopTimer();
				this.api.ui.getUIComponent("Timeline").stopChrono();
			}
		}
		this.api.kernel.GameManager.applyCreatureMode();
	}
	function onFlag(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = Number(var3[1]);
		var var6 = this.api.datacenter.Sprites.getItemAt(var4);
		var var7 = new ank.battlefield.datacenter.
();
		var7.file = dofus.Constants.CLIPS_PATH + "flag.swf";
		var7.bInFrontOfSprite = true;
		var7.bTryToBypassContainerColor = true;
		this.api.kernel.showMessage(undefined,this.api.lang.getText("PLAYER_SET_FLAG",[var6.name,var5]),"INFO_CHAT");
		this.api.gfx.spriteLaunchVisualEffect(var4,var7,var5,11,undefined,undefined,undefined,true);
	}
	function onFightChallenge(var2)
	{
		var var3 = var2.split(";");
		if(!this.api.ui.getUIComponent("FightChallenge"))
		{
			this.api.ui.loadUIComponent("FightChallenge","FightChallenge");
		}
		var var4 = new dofus.datacenter.(_global.parseInt(var3[0]),var3[1] == "1",_global.parseInt(var3[2]),_global.parseInt(var3[3]),_global.parseInt(var3[4]),_global.parseInt(var3[5]),_global.parseInt(var3[6]));
		(dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge").addChallenge(var4);
	}
	function onFightChallengeUpdate(var2, var3)
	{
		var var4 = _global.parseInt(var2);
		(dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge").updateChallenge(var4,var3);
		var var5 = !var3?this.api.lang.getText("FIGHT_CHALLENGE_FAILED"):this.api.lang.getText("FIGHT_CHALLENGE_DONE");
		var5 = var5 + (" : " + this.api.lang.getFightChallenge(var4).n);
		this.api.kernel.showMessage(undefined,var5,"INFO_CHAT");
	}
	function sliptGfxData(var2)
	{
		if(var2.indexOf(",") != -1)
		{
			var var3 = var2.split(",");
			return {shape:"circle",gfx:var3};
		}
		if(var2.indexOf(":") != -1)
		{
			var var4 = var2.split(":");
			return {shape:"line",gfx:var4};
		}
		return {shape:"none",gfx:[var2]};
	}
	function createTransitionEffect()
	{
		var var2 = new ank.battlefield.datacenter.
();
		var2.id = 5;
		var2.file = dofus.Constants.SPELLS_PATH + "transition.swf";
		var2.level = 5;
		var2.params = [];
		var2.bInFrontOfSprite = true;
		var2.bTryToBypassContainerColor = false;
		return var2;
	}
	function splitGfxForScale(var2, var3)
	{
		var var4 = var2.split("^");
		var var5 = var4.length != 2?var2:var4[0];
		var var6 = 100;
		var var7 = 100;
		if(var4.length == 2)
		{
			var var8 = var4[1];
			if(_global.isNaN(Number(var8)))
			{
				var var9 = var8.split("x");
				var6 = var9.length != 2?100:Number(var9[0]);
				var7 = var9.length != 2?100:Number(var9[1]);
			}
			else
			{
				var6 = var7 = Number(var8);
			}
		}
		var3.gfxID = var5;
		var3.scaleX = var6;
		var3.scaleY = var7;
	}
	function cancel(var2)
	{
		var var0 = var2.target._name;
	}
	function yes(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoEnabledPVP":
				this.api.network.Game.enabledPVPMode(true);
				break;
			case "AskYesNoDisabledPVP":
				this.api.network.Game.enabledPVPMode(false);
		}
	}
	function no(var2)
	{
		var var0 = var2.target._name;
	}
}
