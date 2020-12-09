class dofus.aks.GameActions extends dofus.aks.Handler
{
	function GameActions(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function warning(§\x1e\f\x06§)
	{
		this.infoImportanteDecompilo("Hello, we would like to tell you that modifying your Dofus client or sharing a modified client is strictly FORBIDDEN.");
		this.infoImportanteDecompilo("Modifying your client in any way will also flag you as a bot by our security systems.");
		this.infoImportanteDecompilo("Bonjour, nous souhaitons vous avertir que toute modification du client ou partage d\'un client modifié est strictement INTERDIT.");
		this.infoImportanteDecompilo("Modifier votre client (et ce quelque soit le type de modification) aura également pour conséquence de vous identifier comme un BOT par nos systèmes de sécurité.");
	}
	function infoImportanteDecompilo(§\x1e\x11\x18§)
	{
	}
	function sendActions(§\t\r§, §\x1e\x02§)
	{
		var var4 = new String();
		this.aks.send("GA" + new ank.utils.(var2).addLeftChar("0",3) + var3.join(";"));
	}
	function actionAck(§\t\x0f§)
	{
		this.aks.send("GKK" + var2,false);
	}
	function actionCancel(§\t\x0f§, §\x1e\x17\f§)
	{
		this.aks.send("GKE" + var2 + "|" + var3,false);
	}
	function challenge(§\x1e\r\x1b§)
	{
		this.sendActions(900,[var2]);
	}
	function acceptChallenge(§\x1e\r\x1b§)
	{
		this.sendActions(901,[var2]);
	}
	function refuseChallenge(§\x1e\r\x1b§)
	{
		this.sendActions(902,[var2]);
	}
	function joinChallenge(§\x07\x1b§, §\x1e\r\x1b§)
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
	function attack(§\x1e\r\x1b§)
	{
		this.sendActions(906,[var2]);
	}
	function attackTaxCollector(§\x1e\r\x1b§)
	{
		this.sendActions(909,[var2]);
	}
	function mutantAttack(§\x1e\r\x1b§)
	{
		this.sendActions(910,[var2]);
	}
	function attackPrism(§\x1e\r\x1b§)
	{
		this.sendActions(912,[var2]);
	}
	function usePrism(§\x1e\r\x1b§)
	{
		this.sendActions(512,[var2]);
	}
	function acceptMarriage(§\x1e\r\x1b§)
	{
		this.sendActions(618,[var2]);
	}
	function refuseMarriage(§\x1e\r\x1b§)
	{
		this.sendActions(619,[var2]);
	}
	function onActionsStart(§\x1e\x12\x1a§)
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
	function onActionsFinish(§\x1e\x12\x1a§)
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
			var7.addAction(32,false,this.api.kernel.GameManager,this.api.kernel.GameManager.setEnabledInteractionIfICan,[ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT]);
			if(var4 != undefined)
			{
				var7.addAction(33,false,this,this.actionAck,[var4]);
			}
			var7.addAction(34,false,this.api.kernel.GameManager,this.api.kernel.GameManager.cleanPlayer,[var5]);
			this.api.gfx.mapHandler.resetEmptyCells();
			var7.execute();
			if(var4 == 2)
			{
				this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDMOVE);
			}
		}
	}
	function onActions(§\x1e\x12\x1a§)
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
		if((var var0 = var5) !== 0)
		{
			loop0:
			switch(null)
			{
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
						var11.addAction(35,false,this.api.gfx,this.api.gfx.setInteraction,[ank.battlefield.Constants.INTERACTION_CELL_NONE]);
					}
					var var15 = ank.battlefield.utils.Compressor.extractFullPath(this.api.gfx.mapHandler,var7);
					if(var14.hasCarriedParent() && !var14.uncarryingSprite)
					{
						var14.uncarryingSprite = true;
						var15.shift();
						var11.addAction(174,false,this.api.gfx,this.api.gfx.uncarriedSprite,[var6,var15[0],true,var11]);
						var11.addAction(36,false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var6,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var14.Team]]);
					}
					var var16 = var14.forceRun;
					var var17 = var14.forceWalk;
					var var18 = !this.api.datacenter.Game.isFight?!(var14 instanceof dofus.datacenter.Character)?6:3:!(var14 instanceof dofus.datacenter.Character)?4:3;
					if(this.api.datacenter.Game.isRunning)
					{
						var11.addAction(37,false,this.api.gfx,this.api.gfx.unSelect,[true]);
						var11.addAction(175,false,this.api.gfx,this.api.gfx.moveSpriteWithUncompressedPath,[var6,var15,var11,false,var16,var17,var18]);
					}
					else
					{
						this.api.gfx.moveSpriteWithUncompressedPath(var6,var15,var11,true,var16,var17,var18);
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
						var11.addAction(38,false,this.api.gfx,this.api.gfx.clear);
						var11.addAction(39,false,this.api.datacenter,this.api.datacenter.clearGame);
						if(var7.length == 0)
						{
							var11.addAction(40,true,this.api.ui,this.api.ui.loadUIComponent,["CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true}]);
						}
						else
						{
							var11.addAction(41,true,this.api.ui,this.api.ui.loadUIComponent,["Cinematic","Cinematic",{file:dofus.Constants.CINEMATICS_PATH + var7 + ".swf",sequencer:var11}]);
						}
					}
					break;
				case 4:
					var var19 = var7.split(",");
					var var20 = var19[0];
					var var21 = Number(var19[1]);
					var var22 = this.api.datacenter.Sprites.getItemAt(var20);
					var var23 = var22.mc;
					var11.addAction(42,false,var23,var23.setPosition,[var21]);
					break;
				case 5:
					var var24 = var7.split(",");
					var var25 = var24[0];
					var var26 = Number(var24[1]);
					this.api.gfx.slideSprite(var25,var26,var11);
					break;
				case 11:
					var var27 = var7.split(",");
					var var28 = var27[0];
					var var29 = Number(var27[1]);
					var11.addAction(43,false,this.api.gfx,this.api.gfx.setSpriteDirection,[var28,var29]);
					break;
				case 50:
					var var30 = var7;
					var11.addAction(44,false,this.api.gfx,this.api.gfx.carriedSprite,[var30,var6]);
					var11.addAction(45,false,this.api.gfx,this.api.gfx.removeSpriteExtraClip,[var30]);
					break;
				default:
					switch(null)
					{
						case 51:
							var var31 = Number(var7);
							var var32 = this.api.datacenter.Sprites.getItemAt(var6);
							var var33 = var32.carriedChild;
							var var34 = new ank.battlefield.datacenter.
();
							var34.file = dofus.Constants.SPELLS_PATH + "1200.swf";
							var34.level = 1;
							var34.bInFrontOfSprite = true;
							var34.bTryToBypassContainerColor = false;
							this.api.gfx.spriteLaunchCarriedSprite(var6,var34,var31,31,10);
							var11.addAction(46,false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var33.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var33.Team]]);
							break loop0;
						case 52:
							var var35 = var7.split(",");
							var var36 = var35[0];
							var var37 = this.api.datacenter.Sprites.getItemAt(var36);
							var var38 = Number(var35[1]);
							if(var37.hasCarriedParent() && !var37.uncarryingSprite)
							{
								var37.uncarryingSprite = true;
								var11.addAction(47,false,this.api.gfx,this.api.gfx.uncarriedSprite,[var36,var38,true,var11]);
								var11.addAction(48,false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var36,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var37.Team]]);
							}
							break loop0;
						case 100:
						case 108:
						case 110:
							var var39 = var7.split(",");
							var var40 = var39[0];
							var var41 = this.api.datacenter.Sprites.getItemAt(var40);
							var var42 = Number(var39[1]);
							if(var42 != 0)
							{
								var var43 = Number(var39[2]);
								var var44 = dofus.Constants.getElementColorById(var43);
								var var45 = var42 >= 0?"WIN_LP":"LOST_LP";
								if(var44 != undefined && this.api.kernel.OptionsManager.getOption("SeeDamagesColor"))
								{
									var var46 = this.api.lang.getText(var45,[var41.name,"<font color=\"#" + var44 + "\">" + Math.abs(var42) + "</font>"]);
								}
								else
								{
									var46 = this.api.lang.getText(var45,[var41.name,Math.abs(var42)]);
								}
								var11.addAction(49,false,this.api.kernel,this.api.kernel.showMessage,[undefined,var46,"INFO_FIGHT_CHAT"]);
								var11.addAction(50,false,var41,var41.updateLP,[var42]);
								var11.addAction(51,false,this.api.ui.getUIComponent("Timeline").timelineControl,this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters);
							}
							else
							{
								var11.addAction(52,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("NOCHANGE_LP",[var41.name]),"INFO_FIGHT_CHAT"]);
							}
							break loop0;
						default:
							switch(null)
							{
								case 101:
								case 102:
								case 111:
								case 120:
								case 168:
									var var47 = var7.split(",");
									var var48 = this.api.datacenter.Sprites.getItemAt(var47[0]);
									var var49 = Number(var47[1]);
									if(var49 == 0)
									{
										break loop0;
									}
									if(var5 == 101 || (var5 == 111 || (var5 == 120 || var5 == 168)))
									{
										var var50 = var49 >= 0?"WIN_AP":"LOST_AP";
										var11.addAction(53,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(var50,[var48.name,Math.abs(var49)]),"INFO_FIGHT_CHAT"]);
									}
									var11.addAction(54,false,var48,var48.updateAP,[var49,var5 == 102]);
									break loop0;
								default:
									switch(null)
									{
										case 127:
										case 129:
										case 128:
										case 78:
										case 169:
											var var51 = var7.split(",");
											var var52 = var51[0];
											var var53 = Number(var51[1]);
											var var54 = this.api.datacenter.Sprites.getItemAt(var52);
											if(var53 == 0)
											{
												break loop0;
											}
											if(var5 == 127 || (var5 == 128 || (var5 == 169 || var5 == 78)))
											{
												var var55 = var53 >= 0?"WIN_MP":"LOST_MP";
												var11.addAction(55,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(var55,[var54.name,Math.abs(var53)]),"INFO_FIGHT_CHAT"]);
											}
											var11.addAction(56,false,var54,var54.updateMP,[var53,var5 == 129]);
											break loop0;
										default:
											switch(null)
											{
												case 103:
													var var56 = var7;
													var var57 = this.api.datacenter.Sprites.getItemAt(var56);
													var var58 = var57.mc;
													org.flashdevelop.utils.FlashConnect.mtrace("[mort] idSprite : " + var56 + "  mc :" + var58,"dofus.aks.GameActions::onActions","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/GameActions.as",589);
													if(var58 == undefined)
													{
														return undefined;
													}
													var57.isPendingClearing = true;
													var var59 = var57.sex != 1?"m":"f";
													var11.addAction(57,false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("DIE",[var57.name]),var59,true),"INFO_FIGHT_CHAT"]);
													var var60 = this.api.ui.getUIComponent("Timeline");
													var11.addAction(58,false,var60,var60.hideItem,[var56]);
													var11.addAction(176,false,this.api.gfx,this.api.gfx.removeEffectsByCasterID,[var56]);
													this.warning("You\'re not allowed to change the behaviour of the game animations. Please play legit !");
													this.warning("Toute modification du comportement des animations est détectée et sanctionnée car c\'est considéré comme de la triche, merci de jouer legit !");
													if(!this.api.datacenter.Player.isSkippingFightAnimations)
													{
														var11.addAction(59,true,var58,var58.setAnim,["Die"],1500,true);
													}
													this.warning("Vous n\'êtes même pas sensé pouvoir lire ce message, mais un rappel de plus n\'est pas de trop pour certains : modification du client = ban ;)");
													var11.addAction(61,false,var58,var58.clear);
													if(var57.hasCarriedChild() && !var57.uncarryingSprite)
													{
														var57.uncarryingSprite = true;
														var11.addAction(172,false,this.api.gfx,this.api.gfx.uncarriedSprite,[var57.carriedSprite.id,var57.cellNum,false,var11]);
														var11.addAction(60,false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var57.carriedChild.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var57.carriedChild.Team]]);
													}
													if(this.api.datacenter.Player.summonedCreaturesID[var56])
													{
														this.api.datacenter.Player.SummonedCreatures--;
														delete this.api.datacenter.Player.summonedCreaturesID.register56;
														this.api.ui.getUIComponent("Banner").shortcuts.setSpellStateOnAllContainers();
													}
													if(var56 == this.api.datacenter.Player.ID)
													{
														if(var6 == this.api.datacenter.Player.ID)
														{
															this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_HIMSELF);
														}
														else
														{
															var var61 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
															var var62 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
															if(var61 == var62)
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
														var var63 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
														var var64 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var56)).Team;
														if(var63 == var64)
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
													var var65 = this.api.datacenter.Sprites.getItemAt(var6);
													var var66 = var65.mc;
													var11.addAction(62,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("CANT_MOVEOUT"),"INFO_FIGHT_CHAT"]);
													if(!this.api.datacenter.Player.isSkippingFightAnimations && this.api.electron.isWindowFocused)
													{
														var11.addAction(63,false,var66,var66.setAnim,["Hit"]);
													}
													break loop0;
												case 105:
												case 164:
													var var67 = var7.split(",");
													var var68 = var67[0];
													var var69 = var5 != 164?var67[1]:var67[1] + "%";
													var var70 = this.api.datacenter.Sprites.getItemAt(var68);
													var11.addAction(64,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_DAMAGES",[var70.name,var69]),"INFO_FIGHT_CHAT"]);
													break loop0;
												default:
													switch(null)
													{
														case 106:
															var var71 = var7.split(",");
															var var72 = var71[0];
															var var73 = var71[1] == "1";
															var var74 = this.api.datacenter.Sprites.getItemAt(var72);
															var var75 = !var73?this.api.lang.getText("RETURN_SPELL_NO",[var74.name]):this.api.lang.getText("RETURN_SPELL_OK",[var74.name]);
															var11.addAction(65,false,this.api.kernel,this.api.kernel.showMessage,[undefined,var75,"INFO_FIGHT_CHAT"]);
															break loop0;
														case 107:
															var var76 = var7.split(",");
															var var77 = var76[0];
															var var78 = var76[1];
															var var79 = this.api.datacenter.Sprites.getItemAt(var77);
															var11.addAction(66,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_DAMAGES",[var79.name,var78]),"INFO_FIGHT_CHAT"]);
															break loop0;
														case 130:
															var var80 = Number(var7);
															var var81 = this.api.datacenter.Sprites.getItemAt(var6);
															var11.addAction(67,false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("STEAL_GOLD",[var81.name,var80]),"m",var80 < 2),"INFO_FIGHT_CHAT"]);
															break loop0;
														case 132:
															var var82 = this.api.datacenter.Sprites.getItemAt(var6);
															var var83 = this.api.datacenter.Sprites.getItemAt(var7);
															var11.addAction(68,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REMOVE_ALL_EFFECTS",[var82.name,var83.name]),"INFO_FIGHT_CHAT"]);
															var11.addAction(69,false,var83.CharacteristicsManager,var83.CharacteristicsManager.terminateAllEffects);
															var11.addAction(70,false,var83.EffectsManager,var83.EffectsManager.terminateAllEffects);
															break loop0;
														default:
															switch(null)
															{
																case 140:
																	var var84 = Number(var7);
																	var var85 = this.api.datacenter.Sprites.getItemAt(var6);
																	var var86 = this.api.datacenter.Sprites.getItemAt(var7);
																	var11.addAction(71,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("A_PASS_NEXT_TURN",[var86.name]),"INFO_FIGHT_CHAT"]);
																	break loop0;
																case 151:
																	var var87 = Number(var7);
																	var var88 = this.api.datacenter.Sprites.getItemAt(var6);
																	var var89 = var87 != -1?this.api.lang.getText("INVISIBLE_OBSTACLE",[var88.name,this.api.lang.getSpellText(var87).n]):this.api.lang.getText("CANT_DO_INVISIBLE_OBSTACLE");
																	var11.addAction(72,false,this.api.kernel,this.api.kernel.showMessage,[undefined,var89,"ERROR_CHAT"]);
																	break loop0;
																case 166:
																	var var90 = var7.split(",");
																	var var91 = Number(var90[0]);
																	var var92 = this.api.datacenter.Sprites.getItemAt(var6);
																	var var93 = Number(var90[1]);
																	var11.addAction(73,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_AP",[var92.name,var93]),"INFO_FIGHT_CHAT"]);
																	break loop0;
																case 164:
																	var var94 = var7.split(",");
																	var var95 = Number(var94[0]);
																	var var96 = this.api.datacenter.Sprites.getItemAt(var6);
																	var var97 = Number(var94[1]);
																	var11.addAction(74,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_LP_DAMAGES",[var96.name,var97]),"INFO_FIGHT_CHAT"]);
																	break loop0;
																case 780:
																	if(var6 == this.api.datacenter.Player.ID)
																	{
																		this.api.datacenter.Player.SummonedCreatures++;
																		var var98 = _global.parseInt(var7.split(";")[3]);
																		this.api.datacenter.Player.summonedCreaturesID[var98] = true;
																	}
																case 147:
																	var var99 = var7.split(";")[3];
																	var var100 = this.api.ui.getUIComponent("Timeline");
																	var11.addAction(75,false,var100,var100.showItem,[var99]);
																	var11.addAction(76,false,this.aks.Game,this.aks.Game.onMovement,[var7,true]);
																	break loop0;
																default:
																	switch(null)
																	{
																		case 180:
																		case 181:
																			var var101 = var7.split(";")[3];
																			if(var6 == this.api.datacenter.Player.ID)
																			{
																				this.api.datacenter.Player.SummonedCreatures++;
																				this.api.datacenter.Player.summonedCreaturesID[var101] = true;
																			}
																			var11.addAction(77,false,this.aks.Game,this.aks.Game.onMovement,[var7,true]);
																			break loop0;
																		case 185:
																			var11.addAction(78,false,this.aks.Game,this.aks.Game.onMovement,[var7]);
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
																																default:
																																	switch(null)
																																	{
																																		case 149:
																																			var var109 = var7.split(",");
																																			var var110 = var109[0];
																																			var var111 = this.api.datacenter.Sprites.getItemAt(var110);
																																			var var112 = Number(var109[1]);
																																			var var113 = Number(var109[2]);
																																			var var114 = Number(var109[3]);
																																			var11.addAction(81,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("GFX",[var111.name]),"INFO_FIGHT_CHAT"]);
																																			var var115 = var111.CharacteristicsManager;
																																			var var116 = new dofus.datacenter.(undefined,var5,var112,var113,undefined,undefined,var114);
																																			var11.addAction(82,false,var115,var115.addEffect,[var116]);
																																			break loop0;
																																		case 150:
																																			var var117 = var7.split(",");
																																			var var118 = var117[0];
																																			var var119 = this.api.datacenter.Sprites.getItemAt(var118);
																																			var var120 = Number(var117[1]);
																																			if(var120 > 0)
																																			{
																																				var11.addAction(83,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("INVISIBILITY",[var119.name]),"INFO_FIGHT_CHAT"]);
																																				if(var118 == this.api.datacenter.Player.ID)
																																				{
																																					var11.addAction(84,false,var119.mc,var119.mc.setAlpha,[40]);
																																				}
																																				else
																																				{
																																					var11.addAction(85,false,var119.mc,var119.mc.setVisible,[false]);
																																				}
																																			}
																																			else
																																			{
																																				var11.addAction(86,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("VISIBILITY",[var119.name]),"INFO_FIGHT_CHAT"]);
																																				this.api.gfx.hideSprite(var118,false);
																																				if(var119.allowGhostMode && this.api.gfx.bGhostView)
																																				{
																																					this.api.gfx.setSpriteAlpha(var118,ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
																																				}
																																				else
																																				{
																																					this.api.gfx.setSpriteAlpha(var118,100);
																																				}
																																			}
																																			break loop0;
																																		case 165:
																																			var var121 = var7.split(",");
																																			var var122 = var121[0];
																																			var var123 = Number(var121[1]);
																																			var var124 = Number(var121[2]);
																																			var var125 = Number(var121[3]);
																																			break loop0;
																																		case 200:
																																			var var126 = var7.split(",");
																																			var var127 = Number(var126[0]);
																																			var var128 = Number(var126[1]);
																																			var11.addAction(87,false,this.api.gfx,this.api.gfx.setObject2Frame,[var127,var128]);
																																			break loop0;
																																		case 208:
																																			org.flashdevelop.utils.FlashConnect.mtrace("effect 208","dofus.aks.GameActions::onActions","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/GameActions.as",1060);
																																			var var129 = var7.split(",");
																																			var var130 = this.api.datacenter.Sprites.getItemAt(var6);
																																			var var131 = Number(var129[0]);
																																			var var132 = var129[1];
																																			var var133 = Number(var129[2]);
																																			var var134 = !_global.isNaN(Number(var129[3]))?"anim" + var129[3]:String(var129[3]).split("~");
																																			var var135 = var129[4] == undefined?1:Number(var129[4]);
																																			var var136 = new ank.battlefield.datacenter.
();
																																			var136.file = dofus.Constants.SPELLS_PATH + var132 + ".swf";
																																			var136.level = var135;
																																			var136.bInFrontOfSprite = true;
																																			var136.bTryToBypassContainerColor = true;
																																			this.api.gfx.spriteLaunchVisualEffect(var6,var136,var131,var133,var134);
																																			break loop0;
																																		default:
																																			switch(null)
																																			{
																																				case 228:
																																					var var137 = var7.split(",");
																																					var var138 = this.api.datacenter.Sprites.getItemAt(var6);
																																					var var139 = Number(var137[0]);
																																					var var140 = var137[1];
																																					var var141 = Number(var137[2]);
																																					var var142 = !_global.isNaN(Number(var137[3]))?"anim" + var137[3]:String(var137[3]).split("~");
																																					var var143 = var137[4] == undefined?1:Number(var137[4]);
																																					var var144 = new ank.battlefield.datacenter.
();
																																					var144.file = dofus.Constants.SPELLS_PATH + var140 + ".swf";
																																					var144.level = var143;
																																					var144.bInFrontOfSprite = true;
																																					var144.bTryToBypassContainerColor = false;
																																					this.api.gfx.spriteLaunchVisualEffect(var6,var144,var139,var141,var142);
																																					break loop0;
																																				case 300:
																																					var var145 = var7.split(",");
																																					var var146 = this.api.datacenter.Sprites.getItemAt(var6);
																																					var var147 = Number(var145[0]);
																																					var var148 = Number(var145[1]);
																																					var var149 = var145[2];
																																					var var150 = Number(var145[3]);
																																					var var151 = Number(var145[4]);
																																					var var152 = !_global.isNaN(Number(var145[5]))?!(var145[5] == "-1" || var145[5] == "-2")?"anim" + var145[5]:undefined:String(var145[5]).split("~");
																																					var var153 = false;
																																					if(Number(var145[5]) == -2)
																																					{
																																						var153 = true;
																																					}
																																					var var154 = var145[6] != "1"?false:true;
																																					var var155 = new ank.battlefield.datacenter.
();
																																					var155.file = dofus.Constants.SPELLS_PATH + var149 + ".swf";
																																					var155.level = var150;
																																					var155.bInFrontOfSprite = var154;
																																					var155.params = new dofus.datacenter.(var147,var150).elements;
																																					var11.addAction(88,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[var146.name,this.api.lang.getSpellText(var147).n]),"INFO_FIGHT_CHAT"]);
																																					if(var152 != undefined || var153)
																																					{
																																						if(!this.api.datacenter.Player.isSkippingFightAnimations)
																																						{
																																							this.api.gfx.spriteLaunchVisualEffect(var6,var155,var148,var151,var152);
																																						}
																																					}
																																					if(var6 == this.api.datacenter.Player.ID)
																																					{
																																						var var156 = this.api.datacenter.Player.SpellsManager;
																																						var var157 = this.api.gfx.mapHandler.getCellData(var148).spriteOnID;
																																						var var158 = new dofus.datacenter.(var147,var157);
																																						var156.addLaunchedSpell(var158);
																																					}
																																					break loop0;
																																				case 301:
																																					var var159 = Number(var7);
																																					var11.addAction(89,false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
																																					var11.addAction(90,false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
																																					if(!this.api.datacenter.Player.isSkippingFightAnimations && this.api.electron.isWindowFocused)
																																					{
																																						var11.addAction(91,false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[var6,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
																																					}
																																					if(var6 == this.api.datacenter.Player.ID)
																																					{
																																						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
																																					}
																																					else
																																					{
																																						var var160 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																						var var161 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																						if(var160 == var161)
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
																																					var var162 = Number(var7);
																																					var var163 = this.api.datacenter.Sprites.getItemAt(var6);
																																					var11.addAction(92,false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
																																					var11.addAction(93,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[var163.name,this.api.lang.getSpellText(var162).n]),"INFO_FIGHT_CHAT"]);
																																					var11.addAction(94,false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
																																					var11.addAction(95,false,this.api.gfx,this.api.gfx.addSpriteBubble,[var6,this.api.lang.getText("CRITICAL_MISS")]);
																																					if(var6 == this.api.datacenter.Player.ID)
																																					{
																																						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
																																					}
																																					else
																																					{
																																						var var164 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																						var var165 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																						if(var164 == var165)
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
																																					var var166 = var7.split(",");
																																					var var167 = Number(var166[0]);
																																					var var168 = var166[1];
																																					var var169 = Number(var166[2]);
																																					var var170 = var166[3] != "1"?false:true;
																																					var var171 = this.api.datacenter.Sprites.getItemAt(var6);
																																					var var172 = var171.mc;
																																					var var173 = var171.ToolAnimation;
																																					var11.addAction(96,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[var171.name]),"INFO_FIGHT_CHAT"]);
																																					if(var168 == undefined)
																																					{
																																						var11.addAction(97,false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[var6,var167]);
																																						var11.addAction(98,true,this.api.gfx,this.api.gfx.setSpriteAnim,[var6,var173]);
																																					}
																																					else
																																					{
																																						var var174 = var171.accessories[0].unicID;
																																						var var175 = var171.Guild;
																																						var var176 = new ank.battlefield.datacenter.
();
																																						var176.file = dofus.Constants.SPELLS_PATH + var168 + ".swf";
																																						var176.level = 1;
																																						var176.bInFrontOfSprite = var170;
																																						var176.params = new dofus.datacenter.(new dofus.datacenter.(undefined,var174),var175).elements;
																																						this.api.gfx.spriteLaunchVisualEffect(var6,var176,var167,var169,var173);
																																					}
																																					break loop0;
																																				default:
																																					switch(null)
																																					{
																																						case 304:
																																							var var177 = this.api.datacenter.Sprites.getItemAt(var6);
																																							var var178 = var177.mc;
																																							var11.addAction(99,false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
																																							var11.addAction(100,false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
																																							if(!this.api.datacenter.Player.isSkippingFightAnimations && this.api.electron.isWindowFocused)
																																							{
																																								var11.addAction(101,false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[var6,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
																																							}
																																							if(var6 == this.api.datacenter.Player.ID)
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
																																							}
																																							else
																																							{
																																								var var179 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																								var var180 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																								if(var179 == var180)
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
																																							var var181 = this.api.datacenter.Sprites.getItemAt(var6);
																																							var11.addAction(102,false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
																																							var11.addAction(103,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[var181.name]),"INFO_FIGHT_CHAT"]);
																																							var11.addAction(104,false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
																																							var11.addAction(105,false,this.api.gfx,this.api.gfx.addSpriteBubble,[var6,this.api.lang.getText("CRITICAL_MISS")]);
																																							if(var6 == this.api.datacenter.Player.ID)
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
																																							}
																																							else
																																							{
																																								var var182 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																								var var183 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(var6)).Team;
																																								if(var182 == var183)
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
																																							var var184 = var7.split(",");
																																							var var185 = Number(var184[0]);
																																							var var186 = Number(var184[1]);
																																							var var187 = var184[2];
																																							var var188 = Number(var184[3]);
																																							var var189 = var184[4] != "1"?false:true;
																																							var var190 = Number(var184[5]);
																																							var var191 = this.api.datacenter.Sprites.getItemAt(var6);
																																							var var192 = this.api.datacenter.Sprites.getItemAt(var190);
																																							var var193 = new ank.battlefield.datacenter.
();
																																							var193.id = var185;
																																							var193.file = dofus.Constants.SPELLS_PATH + var187 + ".swf";
																																							var193.level = var188;
																																							var193.bInFrontOfSprite = var189;
																																							var11.addAction(106,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_TRAP",[var191.name,this.api.lang.getSpellText(var193.id).n,var192.name]),"INFO_FIGHT_CHAT"]);
																																							var11.addAction(107,false,this.api.gfx,this.api.gfx.addVisualEffectOnSprite,[var190,var193,var186,11],1000);
																																							break loop0;
																																						case 307:
																																							var var194 = var7.split(",");
																																							var var195 = Number(var194[0]);
																																							var var196 = Number(var194[1]);
																																							var var197 = Number(var194[3]);
																																							var var198 = Number(var194[5]);
																																							var var199 = this.api.datacenter.Sprites.getItemAt(var6);
																																							var var200 = this.api.datacenter.Sprites.getItemAt(var198);
																																							var var201 = new dofus.datacenter.(var195,var197);
																																							var11.addAction(108,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_GLIPH",[var199.name,var201.name,var200.name]),"INFO_FIGHT_CHAT"]);
																																							break loop0;
																																						default:
																																							switch(null)
																																							{
																																								case 308:
																																									var var202 = var7.split(",");
																																									var var203 = this.api.datacenter.Sprites.getItemAt(Number(var202[0]));
																																									var var204 = Number(var202[1]);
																																									var11.addAction(109,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_AP",[var203.name,var204]),"INFO_FIGHT_CHAT"]);
																																									break loop0;
																																								case 309:
																																									var var205 = var7.split(",");
																																									var var206 = this.api.datacenter.Sprites.getItemAt(Number(var205[0]));
																																									var var207 = Number(var205[1]);
																																									var11.addAction(110,false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_MP",[var206.name,var207]),"INFO_FIGHT_CHAT"]);
																																									break loop0;
																																								case 501:
																																									var var208 = var7.split(",");
																																									var var209 = var208[0];
																																									var var210 = Number(var208[1]);
																																									var var211 = this.api.datacenter.Sprites.getItemAt(var6);
																																									var var212 = var208[2] != undefined?"anim" + var208[2]:var211.ToolAnimation;
																																									var11.addAction(111,false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[var6,var209]);
																																									var11.addAction(112,var6 == this.api.datacenter.Player.ID,this.api.gfx,this.api.gfx.setSpriteLoopAnim,[var6,var212,var210],var210,true);
																																									break loop0;
																																								case 617:
																																									var13 = false;
																																									var var213 = var7.split(",");
																																									var var214 = this.api.datacenter.Sprites.getItemAt(Number(var213[0]));
																																									var var215 = this.api.datacenter.Sprites.getItemAt(Number(var213[1]));
																																									var var216 = var213[2];
																																									this.api.gfx.addSpriteBubble(var216,this.api.lang.getText("A_ASK_MARRIAGE_B",[var214.name,var215.name]));
																																									if(var214.id == this.api.datacenter.Player.ID)
																																									{
																																										this.api.kernel.showMessage(this.api.lang.getText("MARRIAGE"),this.api.lang.getText("A_ASK_MARRIAGE_B",[var214.name,var215.name]),"CAUTION_YESNO",{name:"Marriage",listener:this,params:{spriteID:var214.id,refID:var6}});
																																									}
																																									break loop0;
																																								default:
																																									switch(null)
																																									{
																																										case 619:
																																										case 900:
																																											var13 = false;
																																											var var222 = this.api.datacenter.Sprites.getItemAt(var6);
																																											var var223 = this.api.datacenter.Sprites.getItemAt(Number(var7));
																																											if(var222 == undefined || (var223 == undefined || (this.api.ui.getUIComponent("AskCancelChallenge") != undefined || this.api.ui.getUIComponent("AskYesNoIgnoreChallenge") != undefined)))
																																											{
																																												this.refuseChallenge(var6);
																																												return undefined;
																																											}
																																											this.api.kernel.showMessage(undefined,this.api.lang.getText("A_CHALENGE_B",[this.api.kernel.ChatManager.getLinkName(var222.name),this.api.kernel.ChatManager.getLinkName(var223.name)]),"INFO_CHAT");
																																											if(var222.id == this.api.datacenter.Player.ID)
																																											{
																																												this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("YOU_CHALENGE_B",[var223.name]),"INFO_CANCEL",{name:"Challenge",listener:this,params:{spriteID:var222.id}});
																																											}
																																											if(var223.id == this.api.datacenter.Player.ID)
																																											{
																																												if(this.api.kernel.ChatManager.isBlacklisted(var222.name))
																																												{
																																													this.refuseChallenge(var222.id);
																																													return undefined;
																																												}
																																												this.api.electron.makeNotification(this.api.lang.getText("A_CHALENGE_YOU",[var222.name]));
																																												this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("A_CHALENGE_YOU",[var222.name]),"CAUTION_YESNOIGNORE",{name:"Challenge",player:var222.name,listener:this,params:{spriteID:var222.id,player:var222.name}});
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
																																										case 903:
																																											var13 = false;
																																											loop20:
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
																																															break loop20;
																																														case "l":
																																															this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_TOO_LATE"),"ERROR_CHAT");
																																															break loop20;
																																														case "m":
																																															this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
																																															break loop20;
																																														case "p":
																																															this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BECAUSE_MAP"),"ERROR_CHAT");
																																															break loop20;
																																														case "r":
																																															this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BECAUSE_ON_RESPAWN"),"ERROR_CHAT");
																																															break loop20;
																																														default:
																																															switch(null)
																																															{
																																																case "o":
																																																	this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_YOU_R_OCCUPED"),"ERROR_CHAT");
																																																	break loop20;
																																																case "z":
																																																	this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_YOU_OPPONENT_OCCUPED"),"ERROR_CHAT");
																																																	break loop20;
																																																case "h":
																																																	this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIGHT"),"ERROR_CHAT");
																																																	break loop20;
																																																case "i":
																																																	this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIGHT_NO_RIGHTS"),"ERROR_CHAT");
																																																	break loop20;
																																																case "s":
																																																	this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_21"),"ERROR_CHAT");
																																																	break loop20;
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
																																										default:
																																											switch(null)
																																											{
																																												case 906:
																																													var var224 = var7;
																																													var var225 = this.api.datacenter.Sprites.getItemAt(var6);
																																													var var226 = this.api.datacenter.Sprites.getItemAt(var224);
																																													var var227 = var225.name;
																																													var var228 = var226.name;
																																													if(var227 == undefined || var228 == undefined)
																																													{
																																														break;
																																													}
																																													this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[this.api.kernel.ChatManager.getLinkName(var227),this.api.kernel.ChatManager.getLinkName(var228)]),"INFO_CHAT");
																																													if(var224 == this.api.datacenter.Player.ID)
																																													{
																																														this.api.electron.makeNotification(this.api.lang.getText("A_ATTACK_B",[var227,var228]));
																																														this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("YOU_ARE_ATTAC"),background:true,timer:2000},{bForceLoad:true});
																																														this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESSED);
																																													}
																																													else
																																													{
																																														this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESS);
																																													}
																																													break;
																																												case 909:
																																													var var229 = var7;
																																													var var230 = this.api.datacenter.Sprites.getItemAt(var6);
																																													var var231 = this.api.datacenter.Sprites.getItemAt(var229);
																																													this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[var230.name,var231.name]),"INFO_CHAT");
																																													break;
																																												case 950:
																																													var var232 = var7.split(",");
																																													var var233 = var232[0];
																																													var var234 = this.api.datacenter.Sprites.getItemAt(var233);
																																													var var235 = Number(var232[1]);
																																													var var236 = Number(var232[2]) != 1?false:true;
																																													if(var235 == 8 && (!var236 && (var234.hasCarriedParent() && !var234.uncarryingSprite)))
																																													{
																																														var234.uncarryingSprite = true;
																																														var11.addAction(173,false,this.api.gfx,this.api.gfx.uncarriedSprite,[var6,var234.cellNum,false,var11]);
																																														var11.addAction(113,false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[var233,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[var234.Team]]);
																																													}
																																													var11.addAction(114,false,var234,var234.setState,[var235,var236]);
																																													var var237 = this.api.lang.getText(!var236?"EXIT_STATE":"ENTER_STATE",[var234.name,this.api.lang.getStateText(var235)]);
																																													var11.addAction(115,false,this.api.kernel,this.api.kernel.showMessage,[undefined,var237,"INFO_FIGHT_CHAT"]);
																																													break;
																																												case 998:
																																													var var238 = var2.split(",");
																																													var var239 = var238[0];
																																													var var240 = var238[0];
																																													var var241 = var238[2];
																																													var var242 = var238[3];
																																													var var243 = var238[4];
																																													var var244 = var238[6];
																																													var var245 = var238[7];
																																													var var246 = new dofus.datacenter.(undefined,Number(var240),Number(var241),Number(var242),Number(var243),"",Number(var244),Number(var245));
																																													var var247 = this.api.datacenter.Sprites.getItemAt(var239);
																																													var247.EffectsManager.addEffect(var246);
																																													break;
																																												case 999:
																																													var11.addAction(116,false,this.aks,this.aks.processCommand,[var7]);
																																											}
																																									}
																																								case 618:
																																									var13 = false;
																																									var var217 = var7.split(",");
																																									var var218 = this.api.datacenter.Sprites.getItemAt(Number(var217[0]));
																																									var var219 = this.api.datacenter.Sprites.getItemAt(Number(var217[1]));
																																									var var220 = var217[2];
																																									var var221 = var5 != 618?"A_NOT_MARRIED_B":"A_MARRIED_B";
																																									this.api.gfx.addSpriteBubble(var220,this.api.lang.getText(var221,[var218.name,var219.name]));
																																							}
																																					}
																																			}
																																	}
																															}
																														case 160:
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
																											}
																											break;
																										case 123:
																										case 152:
																										case 126:
																										case 155:
																										case 119:
																										case 154:
																									}
																									break;
																								case 114:
																								case 182:
																								case 118:
																								case 157:
																							}
																							break;
																						case 145:
																						case 138:
																						case 160:
																						case 161:
																					}
																					break;
																				case 116:
																				case 115:
																				case 122:
																				case 112:
																				case 142:
																			}
																		case 117:
																			var var102 = var7.split(",");
																			var var103 = var102[0];
																			var var104 = this.api.datacenter.Sprites.getItemAt(var103);
																			var var105 = Number(var102[1]);
																			var var106 = Number(var102[2]);
																			var var107 = var104.CharacteristicsManager;
																			var var108 = new dofus.datacenter.(undefined,var5,var105,undefined,undefined,undefined,var106);
																			var11.addAction(79,false,var107,var107.addEffect,[var108]);
																			var11.addAction(80,false,this.api.kernel,this.api.kernel.showMessage,[undefined,"<b>" + var104.name + "</b> : " + var108.description,"INFO_FIGHT_CHAT"]);
																	}
															}
													}
											}
									}
							}
					}
			}
			if(!_global.isNaN(var4) && var6 == this.api.datacenter.Player.ID)
			{
				var11.addAction(117,false,var12,var12.ack,[var4]);
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
		return undefined;
	}
	function cancel(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "AskCancelChallenge")
		{
			this.refuseChallenge(var2.params.spriteID);
		}
	}
	function yes(§\x1e\x19\x18§)
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
	function no(§\x1e\x19\x18§)
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
	function ignore(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreChallenge")
		{
			this.api.kernel.ChatManager.addToBlacklist(var2.params.player);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[var2.params.player]),"INFO_CHAT");
			this.refuseChallenge(var2.params.spriteID);
		}
	}
}
