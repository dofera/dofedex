class dofus.aks.GameActions extends dofus.aks.Handler
{
	function GameActions(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function warning(var2)
	{
		this.infoImportanteDecompilo("Hello, we would like to tell you that modifying your Dofus client or sharing a modified client is strictly FORBIDDEN.");
		this.infoImportanteDecompilo("Modifying your client in any way will also flag you as a bot by our security systems.");
		this.infoImportanteDecompilo("Bonjour, nous souhaitons vous avertir que toute modification du client ou partage d\'un client modifié est strictement INTERDIT.");
		this.infoImportanteDecompilo("Modifier votre client (et ce quelque soit le type de modification) aura également pour conséquence de vous identifier comme un BOT par nos systèmes de sécurité.");
	}
	function infoImportanteDecompilo(var2)
	{
	}
	function sendActions(var2, var3)
	{
		var var4 = new String();
		this.aks.send("GA" + new ank.utils.(var2).addLeftChar("0",3) + var3.join(";"));
	}
	function actionAck(var2)
	{
		this.aks.send("GKK" + var2,false);
	}
	function actionCancel(var2, var3)
	{
		this.aks.send("GKE" + var2 + "|" + var3,false);
	}
	function challenge(var2)
	{
		this.sendActions(900,[var2]);
	}
	function acceptChallenge(var2)
	{
		this.sendActions(901,[var2]);
	}
	function refuseChallenge(var2)
	{
		this.sendActions(902,[var2]);
	}
	function joinChallenge(var2, var3)
	{
		if(var3 == undefined)
		{
			this.sendActions(903,[var2]);
		}
		else
		{
			this.sendActions(903,[var2,var3]);
		}
	}
	function attack(var2)
	{
		this.sendActions(906,[var2]);
	}
	function attackTaxCollector(var2)
	{
		this.sendActions(909,[var2]);
	}
	function mutantAttack(var2)
	{
		this.sendActions(910,[var2]);
	}
	function attackPrism(var2)
	{
		this.sendActions(912,[var2]);
	}
	function usePrism(var2)
	{
		this.sendActions(512,[var2]);
	}
	function acceptMarriage(var2)
	{
		this.sendActions(618,[var2]);
	}
	function refuseMarriage(var2)
	{
		this.sendActions(619,[var2]);
	}
	function onActionsStart(var2)
	{
		var var3 = var2;
		if(var3 != this.api.datacenter.Player.ID)
		{
			return undefined;
		}
		var var4 = this.api.datacenter.Player.data;
		var4.GameActionsManager.m_bNextAction = true;
		if(this.api.datacenter.Game.isFight)
		{
			var var5 = var4.sequencer;
			var5.execute();
		}
	}
	function onActionsFinish(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1];
		if(var5 != this.api.datacenter.Player.ID)
		{
			return undefined;
		}
		var var6 = this.api.datacenter.Player.data;
		var var7 = var6.sequencer;
		var6.GameActionsManager.m_bNextAction = false;
		if(this.api.datacenter.Game.isFight)
		{
			var7.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.setEnabledInteractionIfICan,[ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT]);
			if(var4 != undefined)
			{
				var7.addAction(false,this,this.actionAck,[var4]);
			}
			var7.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.cleanPlayer,[var5]);
			this.api.gfx.mapHandler.resetEmptyCells();
			var7.execute();
			if(var4 == 2)
			{
				this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDMOVE);
			}
		}
	}
	function onActions(var2)
	{
		var var3 = var2.indexOf(";");
		var var4 = Number(var2.substring(0,var3));
		if(dofus.Constants.SAVING_THE_WORLD)
		{
			if(var2 == ";0")
			{
				dofus.SaveTheWorld.getInstance().nextActionIfOnSafe();
			}
		}
		var2 = var2.substring(var3 + 1);
		var3 = var2.indexOf(";");
		var var5 = Number(var2.substring(0,var3));
		var2 = var2.substring(var3 + 1);
		var3 = var2.indexOf(";");
		var var6 = var2.substring(0,var3);
		var var7 = var2.substring(var3 + 1);
		if(var6.length == 0)
		{
			var6 = this.api.datacenter.Player.ID;
		}
		var var9 = this.api.datacenter.Game.currentPlayerID;
		if(this.api.datacenter.Game.isFight && var9 != undefined)
		{
			var var8 = var9;
		}
		else
		{
			var8 = var6;
		}
		var var10 = this.api.datacenter.Sprites.getItemAt(var8);
		var var11 = var10.sequencer;
		var var12 = var10.GameActionsManager;
		var var13 = true;
		var12.onServerResponse(var4);
		loop0:
		switch(var5)
		{
			case 0:
				return undefined;
				break;
			case 1:
				var var14 = this.api.datacenter.Sprites.getItemAt(var6);
				if(!this.api.gfx.isMapBuild)
				{
					return undefined;
				}
				if(dofus.Constants.USE_JS_LOG && (_global.CONFIG.isNewAccount && !this.api.datacenter.Basics.first_movement))
				{
					getURL("JavaScript:WriteLog(\'Mouvement\')","_self");
					this.api.datacenter.Basics.first_movement = true;
				}
				if(var6 == this.api.datacenter.Player.ID && (this.api.datacenter.Game.isFight && this.api.datacenter.Game.isRunning))
				{
					var11.addAction(false,this.api.gfx,this.api.gfx.setInteraction,[ank.battlefield.Constants.INTERACTION_CELL_NONE]);
				}
				var var15 = ank.battlefield.utils.Compressor.extractFullPath(this.api.gfx.mapHandler,var7);
				if(var14.hasCarriedParent())
				{
					var15.shift();
					this.api.gfx.uncarriedSprite(var6,var15[0],true,var11);
					var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var6,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var14.Team]]);
				}
				var var16 = var14.forceRun;
				var var17 = var14.forceWalk;
				var var18 = !this.api.datacenter.Game.isFight?!(var14 instanceof dofus.datacenter.Character)?6:3:!(var14 instanceof dofus.datacenter.Character)?4:3;
				this.api.gfx.moveSpriteWithUncompressedPath(var6,var15,var11,!this.api.datacenter.Game.isFight,var16,var17,var18);
				if(this.api.datacenter.Game.isRunning)
				{
					var11.addAction(false,this.api.gfx,this.api.gfx.unSelect,[true]);
				}
				break;
			case 2:
				if(var11 == undefined)
				{
					this.api.gfx.clear();
					this.api.datacenter.clearGame();
					if(!this.api.kernel.TutorialManager.isTutorialMode)
					{
						this.api.ui.loadUIComponent("CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true});
					}
				}
				else
				{
					var11.addAction(false,this.api.gfx,this.api.gfx.clear);
					var11.addAction(false,this.api.datacenter,this.api.datacenter.clearGame);
					if(var7.length == 0)
					{
						var11.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true}]);
					}
					else
					{
						var11.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["Cinematic","Cinematic",{file:dofus.Constants.CINEMATICS_PATH + var7 + ".swf",sequencer:var11}]);
					}
				}
				break;
			case 4:
				var var19 = var7.split(",");
				var var20 = var19[0];
				var var21 = Number(var19[1]);
				var var22 = this.api.datacenter.Sprites.getItemAt(var20).mc;
				var11.addAction(false,var22,var22.setPosition,[var21]);
				break;
			case 5:
				var var23 = var7.split(",");
				var var24 = var23[0];
				var var25 = Number(var23[1]);
				this.api.gfx.slideSprite(var24,var25,var11);
				break;
			default:
				switch(null)
				{
					case 11:
						var var26 = var7.split(",");
						var var27 = var26[0];
						var var28 = Number(var26[1]);
						var11.addAction(false,this.api.gfx,this.api.gfx.setSpriteDirection,[var27,var28]);
						break loop0;
					case 50:
						var var29 = var7;
						var11.addAction(false,this.api.gfx,this.api.gfx.carriedSprite,[var29,var6]);
						var11.addAction(false,this.api.gfx,this.api.gfx.removeSpriteExtraClip,[var29]);
						break loop0;
					case 51:
						var var30 = Number(var7);
						var var31 = this.api.datacenter.Sprites.getItemAt(var6);
						var var32 = var31.carriedChild;
						var var33 = new ank.battlefield.datacenter.();
						var33.file = dofus.Constants.SPELLS_PATH + "1200.swf";
						var33.level = 1;
						var33.bInFrontOfSprite = true;
						var33.bTryToBypassContainerColor = false;
						this.api.gfx.spriteLaunchCarriedSprite(var6,var33,var30,31,10);
						var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var32.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var32.Team]]);
						break loop0;
					case 52:
						var var34 = var7.split(",");
						var var35 = var34[0];
						var var36 = this.api.datacenter.Sprites.getItemAt(var35);
						var var37 = Number(var34[1]);
						var11.addAction(false,this.api.gfx,this.api.gfx.uncarriedSprite,[var35,var37,false]);
						var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var35,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var36.Team]]);
						break loop0;
					default:
						switch(null)
						{
							case 108:
							case 110:
							default:
								switch(null)
								{
									case 120:
									case 168:
									default:
										switch(null)
										{
											case 78:
											case 169:
											case 103:
												var var52 = var7;
												var var53 = this.api.datacenter.Sprites.getItemAt(var52);
												var var54 = var53.mc;
												if(var54 == undefined)
												{
													return undefined;
												}
												var var55 = var53.sex != 1?"m":"f";
												var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("DIE",[var53.name]),var55,true),"INFO_FIGHT_CHAT"]);
												var var56 = this.api.ui.getUIComponent("Timeline");
												var11.addAction(false,var56,var56.hideItem,[var52]);
												this.warning("You\'re not allowed to change the behaviour of the game animations. Please play legit !");
												this.warning("Toute modification du comportement des animations est détectée et sanctionnée car c\'est considéré comme de la triche, merci de jouer legit !");
												if(!this.api.datacenter.Player.isSkippingFightAnimations)
												{
													var11.addAction(true,var54,var54.setAnim,["Die"],1500,true);
												}
												this.warning("Vous n\'êtes même pas sensé pouvoir lire ce message, mais un rappel de plus n\'est pas de trop pour certains : modification du client = ban ;)");
												if(var53.hasCarriedChild())
												{
													this.api.gfx.uncarriedSprite(var53.carriedSprite.id,var53.cellNum,false,var11);
													var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var53.carriedChild.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var53.carriedChild.Team]]);
												}
												var11.addAction(false,var54,var54.clear);
												if(this.api.datacenter.Player.summonedCreaturesID[var52])
												{
													this.api.datacenter.Player.SummonedCreatures--;
													delete this.api.datacenter.Player.summonedCreaturesID.register52;
													this.api.ui.getUIComponent("Banner").shortcuts.setSpellStateOnAllContainers();
												}
												if(var52 == this.api.datacenter.Player.ID)
												{
													if(var6 == this.api.datacenter.Player.ID)
													{
														this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_HIMSELF);
													}
													else
													{
														var var57 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
														var var58 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
														if(var57 == var58)
														{
															this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_BY_ALLY);
														}
														else
														{
															this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
														}
													}
												}
												else if(var6 == this.api.datacenter.Player.ID)
												{
													var var59 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
													var var60 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var52)).Team;
													if(var59 == var60)
													{
														this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILL_ALLY);
													}
													else
													{
														this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILL_ENEMY);
													}
												}
												break loop0;
											case 104:
												var var61 = this.api.datacenter.Sprites.getItemAt(var6);
												var var62 = var61.mc;
												var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("CANT_MOVEOUT"),"INFO_FIGHT_CHAT"]);
												var11.addAction(false,var62,var62.setAnim,["Hit"]);
												break loop0;
											default:
												switch(null)
												{
													case 164:
													case 106:
														var var67 = var7.split(",");
														var var68 = var67[0];
														var var69 = var67[1] == "1";
														var var70 = this.api.datacenter.Sprites.getItemAt(var68);
														var var71 = !var69?this.api.lang.getText("RETURN_SPELL_NO",[var70.name]):this.api.lang.getText("RETURN_SPELL_OK",[var70.name]);
														var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,var71,"INFO_FIGHT_CHAT"]);
														break loop0;
													case 107:
														var var72 = var7.split(",");
														var var73 = var72[0];
														var var74 = var72[1];
														var var75 = this.api.datacenter.Sprites.getItemAt(var73);
														var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_DAMAGES",[var75.name,var74]),"INFO_FIGHT_CHAT"]);
														break loop0;
													case 130:
														var var76 = Number(var7);
														var var77 = this.api.datacenter.Sprites.getItemAt(var6);
														var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("STEAL_GOLD",[var77.name,var76]),"m",var76 < 2),"INFO_FIGHT_CHAT"]);
														break loop0;
													default:
														loop6:
														switch(null)
														{
															case 132:
																var var78 = this.api.datacenter.Sprites.getItemAt(var6);
																var var79 = this.api.datacenter.Sprites.getItemAt(var7);
																var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REMOVE_ALL_EFFECTS",[var78.name,var79.name]),"INFO_FIGHT_CHAT"]);
																var11.addAction(false,var79.CharacteristicsManager,var79.CharacteristicsManager.terminateAllEffects);
																var11.addAction(false,var79.EffectsManager,var79.EffectsManager.terminateAllEffects);
																break loop0;
															case 140:
																var var80 = Number(var7);
																var var81 = this.api.datacenter.Sprites.getItemAt(var6);
																var var82 = this.api.datacenter.Sprites.getItemAt(var7);
																var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("A_PASS_NEXT_TURN",[var82.name]),"INFO_FIGHT_CHAT"]);
																break loop0;
															case 151:
																var var83 = Number(var7);
																var var84 = this.api.datacenter.Sprites.getItemAt(var6);
																var var85 = var83 != -1?this.api.lang.getText("INVISIBLE_OBSTACLE",[var84.name,this.api.lang.getSpellText(var83).n]):this.api.lang.getText("CANT_DO_INVISIBLE_OBSTACLE");
																var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,var85,"ERROR_CHAT"]);
																break loop0;
															case 166:
																var var86 = var7.split(",");
																var var87 = Number(var86[0]);
																var var88 = this.api.datacenter.Sprites.getItemAt(var6);
																var var89 = Number(var86[1]);
																var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_AP",[var88.name,var89]),"INFO_FIGHT_CHAT"]);
																break loop0;
															case 164:
																var var90 = var7.split(",");
																var var91 = Number(var90[0]);
																var var92 = this.api.datacenter.Sprites.getItemAt(var6);
																var var93 = Number(var90[1]);
																var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_LP_DAMAGES",[var92.name,var93]),"INFO_FIGHT_CHAT"]);
																break loop0;
															case 780:
																if(var6 == this.api.datacenter.Player.ID)
																{
																	this.api.datacenter.Player.SummonedCreatures++;
																	var var94 = _global.parseInt(var7.split(";")[3]);
																	this.api.datacenter.Player.summonedCreaturesID[var94] = true;
																	break;
																}
																break;
															default:
																switch(null)
																{
																	case 147:
																		break loop6;
																	case 180:
																	case 181:
																		var var97 = var7.split(";")[3];
																		if(var6 == this.api.datacenter.Player.ID)
																		{
																			this.api.datacenter.Player.SummonedCreatures++;
																			this.api.datacenter.Player.summonedCreaturesID[var97] = true;
																		}
																		var11.addAction(false,this.aks.Game,this.aks.Game.onMovement,[var7,true]);
																		break loop0;
																	case 185:
																		var11.addAction(false,this.aks.Game,this.aks.Game.onMovement,[var7]);
																		break loop0;
																	default:
																		switch(null)
																		{
																			default:
																				switch(null)
																				{
																					default:
																						switch(null)
																						{
																							default:
																								switch(null)
																								{
																									default:
																										switch(null)
																										{
																											default:
																												loop13:
																												switch(null)
																												{
																													default:
																														switch(null)
																														{
																															case 607:
																															case 608:
																															case 609:
																															case 610:
																															case 611:
																																break loop13;
																															case 149:
																																var var105 = var7.split(",");
																																var var106 = var105[0];
																																var var107 = this.api.datacenter.Sprites.getItemAt(var106);
																																var var108 = Number(var105[1]);
																																var var109 = Number(var105[2]);
																																var var110 = Number(var105[3]);
																																var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("GFX",[var107.name]),"INFO_FIGHT_CHAT"]);
																																var var111 = var107.CharacteristicsManager;
																																var var112 = new dofus.datacenter.(var5,var108,var109,undefined,undefined,var110);
																																var11.addAction(false,var111,var111.addEffect,[var112]);
																																break loop0;
																															default:
																																switch(null)
																																{
																																	case 150:
																																		var var113 = var7.split(",");
																																		var var114 = var113[0];
																																		var var115 = this.api.datacenter.Sprites.getItemAt(var114);
																																		var var116 = Number(var113[1]);
																																		if(var116 > 0)
																																		{
																																			var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("INVISIBILITY",[var115.name]),"INFO_FIGHT_CHAT"]);
																																			if(var114 == this.api.datacenter.Player.ID)
																																			{
																																				var11.addAction(false,var115.mc,var115.mc.setAlpha,[40]);
																																			}
																																			else
																																			{
																																				var11.addAction(false,var115.mc,var115.mc.setVisible,[false]);
																																			}
																																		}
																																		else
																																		{
																																			var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("VISIBILITY",[var115.name]),"INFO_FIGHT_CHAT"]);
																																			this.api.gfx.hideSprite(var114,false);
																																			if(var115.allowGhostMode && this.api.gfx.bGhostView)
																																			{
																																				this.api.gfx.setSpriteAlpha(var114,ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
																																			}
																																			else
																																			{
																																				this.api.gfx.setSpriteAlpha(var114,100);
																																			}
																																		}
																																		break loop0;
																																	case 165:
																																		var var117 = var7.split(",");
																																		var var118 = var117[0];
																																		var var119 = Number(var117[1]);
																																		var var120 = Number(var117[2]);
																																		var var121 = Number(var117[3]);
																																		break loop0;
																																	case 200:
																																		var var122 = var7.split(",");
																																		var var123 = Number(var122[0]);
																																		var var124 = Number(var122[1]);
																																		var11.addAction(false,this.api.gfx,this.api.gfx.setObject2Frame,[var123,var124]);
																																		break loop0;
																																	case 208:
																																		var var125 = var7.split(",");
																																		var var126 = this.api.datacenter.Sprites.getItemAt(var6);
																																		var var127 = Number(var125[0]);
																																		var var128 = var125[1];
																																		var var129 = Number(var125[2]);
																																		var var130 = !_global.isNaN(Number(var125[3]))?"anim" + var125[3]:String(var125[3]).split("~");
																																		var var131 = var125[4] == undefined?1:Number(var125[4]);
																																		var var132 = new ank.battlefield.datacenter.();
																																		var132.file = dofus.Constants.SPELLS_PATH + var128 + ".swf";
																																		var132.level = var131;
																																		var132.bInFrontOfSprite = true;
																																		var132.bTryToBypassContainerColor = true;
																																		this.api.gfx.spriteLaunchVisualEffect(var6,var132,var127,var129,var130);
																																		break loop0;
																																	default:
																																		switch(null)
																																		{
																																			case 228:
																																				var var133 = var7.split(",");
																																				var var134 = this.api.datacenter.Sprites.getItemAt(var6);
																																				var var135 = Number(var133[0]);
																																				var var136 = var133[1];
																																				var var137 = Number(var133[2]);
																																				var var138 = !_global.isNaN(Number(var133[3]))?"anim" + var133[3]:String(var133[3]).split("~");
																																				var var139 = var133[4] == undefined?1:Number(var133[4]);
																																				var var140 = new ank.battlefield.datacenter.();
																																				var140.file = dofus.Constants.SPELLS_PATH + var136 + ".swf";
																																				var140.level = var139;
																																				var140.bInFrontOfSprite = true;
																																				var140.bTryToBypassContainerColor = false;
																																				this.api.gfx.spriteLaunchVisualEffect(var6,var140,var135,var137,var138);
																																				break loop0;
																																			case 300:
																																				var var141 = var7.split(",");
																																				var var142 = this.api.datacenter.Sprites.getItemAt(var6);
																																				var var143 = Number(var141[0]);
																																				var var144 = Number(var141[1]);
																																				var var145 = var141[2];
																																				var var146 = Number(var141[3]);
																																				var var147 = Number(var141[4]);
																																				var var148 = !_global.isNaN(Number(var141[5]))?!(var141[5] == "-1" || var141[5] == "-2")?"anim" + var141[5]:undefined:String(var141[5]).split("~");
																																				var var149 = false;
																																				if(Number(var141[5]) == -2)
																																				{
																																					var149 = true;
																																				}
																																				var var150 = var141[6] != "1"?false:true;
																																				var var151 = new ank.battlefield.datacenter.();
																																				var151.file = dofus.Constants.SPELLS_PATH + var145 + ".swf";
																																				var151.level = var146;
																																				var151.bInFrontOfSprite = var150;
																																				var151.params = new dofus.datacenter.(var143,var146).elements;
																																				var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[var142.name,this.api.lang.getSpellText(var143).n]),"INFO_FIGHT_CHAT"]);
																																				if(var148 != undefined || var149)
																																				{
																																					if(!this.api.datacenter.Player.isSkippingFightAnimations)
																																					{
																																						this.api.gfx.spriteLaunchVisualEffect(var6,var151,var144,var147,var148);
																																					}
																																				}
																																				if(var6 == this.api.datacenter.Player.ID)
																																				{
																																					var var152 = this.api.datacenter.Player.SpellsManager;
																																					var var153 = this.api.gfx.mapHandler.getCellData(var144).spriteOnID;
																																					var var154 = new dofus.datacenter.(var143,var153);
																																					var152.addLaunchedSpell(var154);
																																				}
																																				break loop0;
																																			case 301:
																																				var var155 = Number(var7);
																																				var11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
																																				var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
																																				var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[var6,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
																																				if(var6 == this.api.datacenter.Player.ID)
																																				{
																																					this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
																																				}
																																				else
																																				{
																																					var var156 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																					var var157 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																					if(var156 == var157)
																																					{
																																						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ALLIED);
																																					}
																																					else
																																					{
																																						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ENEMY);
																																					}
																																				}
																																				break loop0;
																																			case 302:
																																				var var158 = Number(var7);
																																				var var159 = this.api.datacenter.Sprites.getItemAt(var6);
																																				var11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
																																				var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[var159.name,this.api.lang.getSpellText(var158).n]),"INFO_FIGHT_CHAT"]);
																																				var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
																																				var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[var6,this.api.lang.getText("CRITICAL_MISS")]);
																																				if(var6 == this.api.datacenter.Player.ID)
																																				{
																																					this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
																																				}
																																				else
																																				{
																																					var var160 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																					var var161 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																					if(var160 == var161)
																																					{
																																						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ALLIED);
																																					}
																																					else
																																					{
																																						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ENEMY);
																																					}
																																				}
																																				break loop0;
																																			case 303:
																																				var var162 = var7.split(",");
																																				var var163 = Number(var162[0]);
																																				var var164 = var162[1];
																																				var var165 = Number(var162[2]);
																																				var var166 = var162[3] != "1"?false:true;
																																				var var167 = this.api.datacenter.Sprites.getItemAt(var6);
																																				var var168 = var167.mc;
																																				var var169 = var167.ToolAnimation;
																																				var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[var167.name]),"INFO_FIGHT_CHAT"]);
																																				if(var164 == undefined)
																																				{
																																					var11.addAction(false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[var6,var163]);
																																					var11.addAction(true,this.api.gfx,this.api.gfx.setSpriteAnim,[var6,var169]);
																																				}
																																				else
																																				{
																																					var var170 = var167.accessories[0].unicID;
																																					var var171 = var167.Guild;
																																					var var172 = new ank.battlefield.datacenter.();
																																					var172.file = dofus.Constants.SPELLS_PATH + var164 + ".swf";
																																					var172.level = 1;
																																					var172.bInFrontOfSprite = var166;
																																					var172.params = new dofus.datacenter.(new dofus.datacenter.(undefined,var170),var171).elements;
																																					this.api.gfx.spriteLaunchVisualEffect(var6,var172,var163,var165,var169);
																																				}
																																				break loop0;
																																			default:
																																				switch(null)
																																				{
																																					case 304:
																																						var var173 = this.api.datacenter.Sprites.getItemAt(var6);
																																						var var174 = var173.mc;
																																						var11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
																																						var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
																																						var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[var6,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
																																						if(var6 == this.api.datacenter.Player.ID)
																																						{
																																							this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
																																						}
																																						else
																																						{
																																							var var175 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																							var var176 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																							if(var175 == var176)
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ALLIED);
																																							}
																																							else
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ENEMY);
																																							}
																																						}
																																						break loop0;
																																					case 305:
																																						var var177 = this.api.datacenter.Sprites.getItemAt(var6);
																																						var11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
																																						var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[var177.name]),"INFO_FIGHT_CHAT"]);
																																						var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
																																						var11.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[var6,this.api.lang.getText("CRITICAL_MISS")]);
																																						if(var6 == this.api.datacenter.Player.ID)
																																						{
																																							this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
																																						}
																																						else
																																						{
																																							var var178 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																							var var179 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																							if(var178 == var179)
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ALLIED);
																																							}
																																							else
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ENEMY);
																																							}
																																						}
																																						break loop0;
																																					case 306:
																																						var var180 = var7.split(",");
																																						var var181 = Number(var180[0]);
																																						var var182 = Number(var180[1]);
																																						var var183 = var180[2];
																																						var var184 = Number(var180[3]);
																																						var var185 = var180[4] != "1"?false:true;
																																						var var186 = Number(var180[5]);
																																						var var187 = this.api.datacenter.Sprites.getItemAt(var6);
																																						var var188 = this.api.datacenter.Sprites.getItemAt(var186);
																																						var var189 = new ank.battlefield.datacenter.();
																																						var189.id = var181;
																																						var189.file = dofus.Constants.SPELLS_PATH + var183 + ".swf";
																																						var189.level = var184;
																																						var189.bInFrontOfSprite = var185;
																																						var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_TRAP",[var187.name,this.api.lang.getSpellText(var189.id).n,var188.name]),"INFO_FIGHT_CHAT"]);
																																						var11.addAction(false,this.api.gfx,this.api.gfx.addVisualEffectOnSprite,[var186,var189,var182,11],1000);
																																						break loop0;
																																					case 307:
																																						var var190 = var7.split(",");
																																						var var191 = Number(var190[0]);
																																						var var192 = Number(var190[1]);
																																						var var193 = Number(var190[3]);
																																						var var194 = Number(var190[5]);
																																						var var195 = this.api.datacenter.Sprites.getItemAt(var6);
																																						var var196 = this.api.datacenter.Sprites.getItemAt(var194);
																																						var var197 = new dofus.datacenter.(var191,var193);
																																						var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_GLIPH",[var195.name,var197.name,var196.name]),"INFO_FIGHT_CHAT"]);
																																						break loop0;
																																					default:
																																						switch(null)
																																						{
																																							case 308:
																																								var var198 = var7.split(",");
																																								var var199 = this.api.datacenter.Sprites.getItemAt(Number(var198[0]));
																																								var var200 = Number(var198[1]);
																																								var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_AP",[var199.name,var200]),"INFO_FIGHT_CHAT"]);
																																								break loop0;
																																							case 309:
																																								var var201 = var7.split(",");
																																								var var202 = this.api.datacenter.Sprites.getItemAt(Number(var201[0]));
																																								var var203 = Number(var201[1]);
																																								var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_MP",[var202.name,var203]),"INFO_FIGHT_CHAT"]);
																																								break loop0;
																																							case 501:
																																								var var204 = var7.split(",");
																																								var var205 = var204[0];
																																								var var206 = Number(var204[1]);
																																								var var207 = this.api.datacenter.Sprites.getItemAt(var6);
																																								var var208 = var204[2] != undefined?"anim" + var204[2]:var207.ToolAnimation;
																																								var11.addAction(false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[var6,var205]);
																																								var11.addAction(var6 == this.api.datacenter.Player.ID,this.api.gfx,this.api.gfx.setSpriteLoopAnim,[var6,var208,var206],var206,true);
																																								break loop0;
																																							case 617:
																																								var13 = false;
																																								var var209 = var7.split(",");
																																								var var210 = this.api.datacenter.Sprites.getItemAt(Number(var209[0]));
																																								var var211 = this.api.datacenter.Sprites.getItemAt(Number(var209[1]));
																																								var var212 = var209[2];
																																								this.api.gfx.addSpriteBubble(var212,this.api.lang.getText("A_ASK_MARRIAGE_B",[var210.name,var211.name]));
																																								if(var210.id == this.api.datacenter.Player.ID)
																																								{
																																									this.api.kernel.showMessage(this.api.lang.getText("MARRIAGE"),this.api.lang.getText("A_ASK_MARRIAGE_B",[var210.name,var211.name]),"CAUTION_YESNO",{name:"Marriage",listener:this,params:{spriteID:var210.id,refID:var6}});
																																								}
																																								break loop0;
																																							default:
																																								switch(null)
																																								{
																																									case 619:
																																									case 900:
																																										var13 = false;
																																										var var218 = this.api.datacenter.Sprites.getItemAt(var6);
																																										var var219 = this.api.datacenter.Sprites.getItemAt(Number(var7));
																																										if(var218 == undefined || (var219 == undefined || (this.api.ui.getUIComponent("AskCancelChallenge") != undefined || this.api.ui.getUIComponent("AskYesNoIgnoreChallenge") != undefined)))
																																										{
																																											this.refuseChallenge(var6);
																																											return undefined;
																																										}
																																										this.api.kernel.showMessage(undefined,this.api.lang.getText("A_CHALENGE_B",[this.api.kernel.ChatManager.getLinkName(var218.name),this.api.kernel.ChatManager.getLinkName(var219.name)]),"INFO_CHAT");
																																										if(var218.id == this.api.datacenter.Player.ID)
																																										{
																																											this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("YOU_CHALENGE_B",[var219.name]),"INFO_CANCEL",{name:"Challenge",listener:this,params:{spriteID:var218.id}});
																																										}
																																										if(var219.id == this.api.datacenter.Player.ID)
																																										{
																																											if(this.api.kernel.ChatManager.isBlacklisted(var218.name))
																																											{
																																												this.refuseChallenge(var218.id);
																																												return undefined;
																																											}
																																											this.api.electron.makeNotification(this.api.lang.getText("A_CHALENGE_YOU",[var218.name]));
																																											this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("A_CHALENGE_YOU",[var218.name]),"CAUTION_YESNOIGNORE",{name:"Challenge",player:var218.name,listener:this,params:{spriteID:var218.id,player:var218.name}});
																																											this.api.sounds.events.onGameInvitation();
																																										}
																																										break loop0;
																																									case 901:
																																										var13 = false;
																																										if(var6 == this.api.datacenter.Player.ID || Number(var7) == this.api.datacenter.Player.ID)
																																										{
																																											this.api.ui.unloadUIComponent("AskCancelChallenge");
																																										}
																																										break loop0;
																																									case 902:
																																										var13 = false;
																																										this.api.ui.unloadUIComponent("AskYesNoIgnoreChallenge");
																																										this.api.ui.unloadUIComponent("AskCancelChallenge");
																																										break loop0;
																																									default:
																																										switch(null)
																																										{
																																											case 903:
																																												var13 = false;
																																												loop21:
																																												switch(var7)
																																												{
																																													case "c":
																																														this.api.kernel.showMessage(undefined,this.api.lang.getText("CHALENGE_FULL"),"ERROR_CHAT");
																																														break;
																																													case "t":
																																														this.api.kernel.showMessage(undefined,this.api.lang.getText("TEAM_FULL"),"ERROR_CHAT");
																																														break;
																																													case "a":
																																														this.api.kernel.showMessage(undefined,this.api.lang.getText("TEAM_DIFFERENT_ALIGNMENT"),"ERROR_CHAT");
																																														break;
																																													default:
																																														switch(null)
																																														{
																																															case "g":
																																																this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_BECAUSE_GUILD"),"ERROR_CHAT");
																																																break loop21;
																																															case "l":
																																																this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_TOO_LATE"),"ERROR_CHAT");
																																																break loop21;
																																															case "m":
																																																this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
																																																break loop21;
																																															case "p":
																																																this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BECAUSE_MAP"),"ERROR_CHAT");
																																																break loop21;
																																															case "r":
																																																this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BECAUSE_ON_RESPAWN"),"ERROR_CHAT");
																																																break loop21;
																																															default:
																																																switch(null)
																																																{
																																																	case "o":
																																																		this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_YOU_R_OCCUPED"),"ERROR_CHAT");
																																																		break loop21;
																																																	case "z":
																																																		this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_YOU_OPPONENT_OCCUPED"),"ERROR_CHAT");
																																																		break loop21;
																																																	case "h":
																																																		this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIGHT"),"ERROR_CHAT");
																																																		break loop21;
																																																	case "i":
																																																		this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIGHT_NO_RIGHTS"),"ERROR_CHAT");
																																																		break loop21;
																																																	case "s":
																																																		this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_21"),"ERROR_CHAT");
																																																		break loop21;
																																																	default:
																																																		switch(null)
																																																		{
																																																			case "n":
																																																				this.api.kernel.showMessage(undefined,this.api.lang.getText("SUBSCRIPTION_OUT"),"ERROR_CHAT");
																																																				break;
																																																			case "b":
																																																				this.api.kernel.showMessage(undefined,this.api.lang.getText("A_NOT_SUBSCRIB"),"ERROR_CHAT");
																																																				break;
																																																			case "f":
																																																				this.api.kernel.showMessage(undefined,this.api.lang.getText("TEAM_CLOSED"),"ERROR_CHAT");
																																																				break;
																																																			case "d":
																																																				this.api.kernel.showMessage(undefined,this.api.lang.getText("NO_ZOMBIE_ALLOWED"),"ERROR_CHAT");
																																																		}
																																																}
																																														}
																																												}
																																												break loop0;
																																											case 905:
																																												this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("YOU_ARE_ATTAC"),background:true,timer:2000},{bForceLoad:true});
																																												break loop0;
																																											case 906:
																																												var var220 = var7;
																																												var var221 = this.api.datacenter.Sprites.getItemAt(var6);
																																												var var222 = this.api.datacenter.Sprites.getItemAt(var220);
																																												this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[var221.name,var222.name]),"INFO_CHAT");
																																												if(var220 == this.api.datacenter.Player.ID)
																																												{
																																													this.api.electron.makeNotification(this.api.lang.getText("A_ATTACK_B",[var221.name,var222.name]));
																																													this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("YOU_ARE_ATTAC"),background:true,timer:2000},{bForceLoad:true});
																																													this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESSED);
																																												}
																																												else
																																												{
																																													this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESS);
																																												}
																																												break loop0;
																																											case 909:
																																												var var223 = var7;
																																												var var224 = this.api.datacenter.Sprites.getItemAt(var6);
																																												var var225 = this.api.datacenter.Sprites.getItemAt(var223);
																																												this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[var224.name,var225.name]),"INFO_CHAT");
																																												break loop0;
																																											case 950:
																																												var var226 = var7.split(",");
																																												var var227 = var226[0];
																																												var var228 = this.api.datacenter.Sprites.getItemAt(var227);
																																												var var229 = Number(var226[1]);
																																												var var230 = Number(var226[2]) != 1?false:true;
																																												if(var229 == 8 && !var230)
																																												{
																																													this.api.gfx.uncarriedSprite(var6,var228._oData.cellNum,true,var11);
																																												}
																																												var11.addAction(false,var228,var228.setState,[var229,var230]);
																																												var var231 = this.api.lang.getText(!var230?"EXIT_STATE":"ENTER_STATE",[var228.name,this.api.lang.getStateText(var229)]);
																																												var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,var231,"INFO_FIGHT_CHAT"]);
																																												break loop0;
																																											default:
																																												switch(null)
																																												{
																																													case 998:
																																														var var232 = var2.split(",");
																																														var var233 = var232[0];
																																														var var234 = var232[0];
																																														var var235 = var232[2];
																																														var var236 = var232[3];
																																														var var237 = var232[4];
																																														var var238 = var232[6];
																																														var var239 = var232[7];
																																														var var240 = new dofus.datacenter.(Number(var234),Number(var235),Number(var236),Number(var237),"",Number(var238),Number(var239));
																																														var var241 = this.api.datacenter.Sprites.getItemAt(var233);
																																														var241.EffectsManager.addEffect(var240);
																																														break;
																																													case 999:
																																														var11.addAction(false,this.aks,this.aks.processCommand,[var7]);
																																												}
																																										}
																																								}
																																							case 618:
																																								var13 = false;
																																								var var213 = var7.split(",");
																																								var var214 = this.api.datacenter.Sprites.getItemAt(Number(var213[0]));
																																								var var215 = this.api.datacenter.Sprites.getItemAt(Number(var213[1]));
																																								var var216 = var213[2];
																																								var var217 = var5 != 618?"A_NOT_MARRIED_B":"A_MARRIED_B";
																																								this.api.gfx.addSpriteBubble(var216,this.api.lang.getText(var217,[var214.name,var215.name]));
																																						}
																																				}
																																		}
																																}
																														}
																													case 161:
																													case 162:
																													case 163:
																													case 606:
																												}
																												break;
																											case 124:
																											case 156:
																											case 125:
																											case 153:
																											case 160:
																										}
																										break;
																									case 152:
																									case 126:
																									case 155:
																									case 119:
																									case 154:
																								}
																								break;
																							case 182:
																							case 118:
																							case 157:
																							case 123:
																						}
																						break;
																					case 145:
																					case 138:
																					case 160:
																					case 161:
																					case 114:
																				}
																				break;
																			case 116:
																			case 115:
																			case 122:
																			case 112:
																			case 142:
																		}
																	case 117:
																		var var98 = var7.split(",");
																		var var99 = var98[0];
																		var var100 = this.api.datacenter.Sprites.getItemAt(var99);
																		var var101 = Number(var98[1]);
																		var var102 = Number(var98[2]);
																		var var103 = var100.CharacteristicsManager;
																		var var104 = new dofus.datacenter.(var5,var101,undefined,undefined,undefined,var102);
																		var11.addAction(false,var103,var103.addEffect,[var104]);
																		var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"<b>" + var100.name + "</b> : " + var104.description,"INFO_FIGHT_CHAT"]);
																}
														}
														var var95 = var7.split(";")[3];
														var var96 = this.api.ui.getUIComponent("Timeline");
														var11.addAction(false,var96,var96.showItem,[var95]);
														var11.addAction(false,this.aks.Game,this.aks.Game.onMovement,[var7,true]);
												}
											case 105:
												var var63 = var7.split(",");
												var var64 = var63[0];
												var var65 = var5 != 164?var63[1]:var63[1] + "%";
												var var66 = this.api.datacenter.Sprites.getItemAt(var64);
												var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_DAMAGES",[var66.name,var65]),"INFO_FIGHT_CHAT"]);
										}
									case 127:
									case 129:
									case 128:
										var var47 = var7.split(",");
										var var48 = var47[0];
										var var49 = Number(var47[1]);
										var var50 = this.api.datacenter.Sprites.getItemAt(var48);
										if(var49 == 0)
										{
											break loop0;
										}
										if(var5 == 127 || (var5 == 128 || (var5 == 169 || var5 == 78)))
										{
											var var51 = var49 >= 0?"WIN_MP":"LOST_MP";
											var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(var51,[var50.name,Math.abs(var49)]),"INFO_FIGHT_CHAT"]);
										}
										var11.addAction(false,var50,var50.updateMP,[var49,var5 == 129]);
										break loop0;
								}
							case 101:
							case 102:
							case 111:
								var var43 = var7.split(",");
								var var44 = this.api.datacenter.Sprites.getItemAt(var43[0]);
								var var45 = Number(var43[1]);
								if(var45 == 0)
								{
									break loop0;
								}
								if(var5 == 101 || (var5 == 111 || (var5 == 120 || var5 == 168)))
								{
									var var46 = var45 >= 0?"WIN_AP":"LOST_AP";
									var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(var46,[var44.name,Math.abs(var45)]),"INFO_FIGHT_CHAT"]);
								}
								var11.addAction(false,var44,var44.updateAP,[var45,var5 == 102]);
								break loop0;
						}
					case 100:
						var var38 = var7.split(",");
						var var39 = var38[0];
						var var40 = this.api.datacenter.Sprites.getItemAt(var39);
						var var41 = Number(var38[1]);
						if(var41 != 0)
						{
							var var42 = var41 >= 0?"WIN_LP":"LOST_LP";
							var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(var42,[var40.name,Math.abs(var41)]),"INFO_FIGHT_CHAT"]);
							var11.addAction(false,var40,var40.updateLP,[var41]);
							var11.addAction(false,this.api.ui.getUIComponent("Timeline").timelineControl,this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters);
						}
						else
						{
							var11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("NOCHANGE_LP",[var40.name]),"INFO_FIGHT_CHAT"]);
						}
				}
		}
		if(!_global.isNaN(var4) && var6 == this.api.datacenter.Player.ID)
		{
			var11.addAction(false,var12,var12.ack,[var4]);
		}
		else
		{
			var12.end(var8 == this.api.datacenter.Player.ID);
		}
		if(!var11.isPlaying() && var13)
		{
			var11.execute(true);
		}
	}
	function cancel(var2)
	{
		if((var var0 = var2.target._name) === "AskCancelChallenge")
		{
			this.refuseChallenge(var2.params.spriteID);
		}
	}
	function yes(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoIgnoreChallenge":
				this.acceptChallenge(var2.params.spriteID);
				break;
			case "AskYesNoMarriage":
				this.acceptMarriage(var2.params.refID);
				this.api.gfx.addSpriteBubble(var2.params.spriteID,this.api.lang.getText("YES"));
		}
	}
	function no(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoIgnoreChallenge":
				this.refuseChallenge(var2.params.spriteID);
				break;
			case "AskYesNoMarriage":
				this.refuseMarriage(var2.params.refID);
				this.api.gfx.addSpriteBubble(var2.params.spriteID,this.api.lang.getText("NO"));
		}
	}
	function ignore(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreChallenge")
		{
			this.api.kernel.ChatManager.addToBlacklist(var2.params.player);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[var2.params.player]),"INFO_CHAT");
			this.refuseChallenge(var2.params.spriteID);
		}
	}
}
