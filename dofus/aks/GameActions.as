class dofus.aks.GameActions extends dofus.aks.Handler
{
	function GameActions(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function warning(loc2)
	{
		this.infoImportanteDecompilo("Hello, we would like to tell you that modifying your Dofus client or sharing a modified client is strictly FORBIDDEN.");
		this.infoImportanteDecompilo("Modifying your client in any way will also flag you as a bot by our security systems.");
		this.infoImportanteDecompilo("Bonjour, nous souhaitons vous avertir que toute modification du client ou partage d\'un client modifié est strictement INTERDIT.");
		this.infoImportanteDecompilo("Modifier votre client (et ce quelque soit le type de modification) aura également pour conséquence de vous identifier comme un BOT par nos systèmes de sécurité.");
	}
	function infoImportanteDecompilo(loc2)
	{
	}
	function sendActions(loc2, loc3)
	{
		var loc4 = new String();
		this.aks.send("GA" + new ank.utils.(loc2).addLeftChar("0",3) + loc3.join(";"));
	}
	function actionAck(loc2)
	{
		this.aks.send("GKK" + loc2,false);
	}
	function actionCancel(loc2, loc3)
	{
		this.aks.send("GKE" + loc2 + "|" + loc3,false);
	}
	function challenge(loc2)
	{
		this.sendActions(900,[loc2]);
	}
	function acceptChallenge(loc2)
	{
		this.sendActions(901,[loc2]);
	}
	function refuseChallenge(loc2)
	{
		this.sendActions(902,[loc2]);
	}
	function joinChallenge(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			this.sendActions(903,[loc2]);
		}
		else
		{
			this.sendActions(903,[loc2,loc3]);
		}
	}
	function attack(loc2)
	{
		this.sendActions(906,[loc2]);
	}
	function attackTaxCollector(loc2)
	{
		this.sendActions(909,[loc2]);
	}
	function mutantAttack(loc2)
	{
		this.sendActions(910,[loc2]);
	}
	function attackPrism(loc2)
	{
		this.sendActions(912,[loc2]);
	}
	function usePrism(loc2)
	{
		this.sendActions(512,[loc2]);
	}
	function acceptMarriage(loc2)
	{
		this.sendActions(618,[loc2]);
	}
	function refuseMarriage(loc2)
	{
		this.sendActions(619,[loc2]);
	}
	function onActionsStart(loc2)
	{
		var loc3 = loc2;
		if(loc3 != this.api.datacenter.Player.ID)
		{
			return undefined;
		}
		var loc4 = this.api.datacenter.Player.data;
		loc4.GameActionsManager.m_bNextAction = true;
		if(this.api.datacenter.Game.isFight)
		{
			var loc5 = loc4.sequencer;
			loc5.addAction(false,this.api.gfx,this.api.gfx.setInteraction,[ank.battlefield.Constants.INTERACTION_CELL_NONE]);
			loc5.execute();
		}
	}
	function onActionsFinish(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1];
		if(loc5 != this.api.datacenter.Player.ID)
		{
			return undefined;
		}
		var loc6 = this.api.datacenter.Player.data;
		var loc7 = loc6.sequencer;
		loc6.GameActionsManager.m_bNextAction = false;
		if(this.api.datacenter.Game.isFight)
		{
			loc7.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.setEnabledInteractionIfICan,[ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT]);
			if(loc4 != undefined)
			{
				loc7.addAction(false,this,this.actionAck,[loc4]);
			}
			loc7.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.cleanPlayer,[loc5]);
			this.api.gfx.mapHandler.resetEmptyCells();
			loc7.execute();
			if(loc4 == 2)
			{
				this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDMOVE);
			}
		}
	}
	function onActions(loc2)
	{
		var loc3 = loc2.indexOf(";");
		var loc4 = Number(loc2.substring(0,loc3));
		if(dofus.Constants.SAVING_THE_WORLD)
		{
			if(loc2 == ";0")
			{
				dofus.SaveTheWorld.getInstance().nextActionIfOnSafe();
			}
		}
		loc2 = loc2.substring(loc3 + 1);
		loc3 = loc2.indexOf(";");
		var loc5 = Number(loc2.substring(0,loc3));
		loc2 = loc2.substring(loc3 + 1);
		loc3 = loc2.indexOf(";");
		var loc6 = loc2.substring(0,loc3);
		var loc7 = loc2.substring(loc3 + 1);
		if(loc6.length == 0)
		{
			loc6 = this.api.datacenter.Player.ID;
		}
		var loc9 = this.api.datacenter.Game.currentPlayerID;
		if(this.api.datacenter.Game.isFight && loc9 != undefined)
		{
			var loc8 = loc9;
		}
		else
		{
			loc8 = loc6;
		}
		var loc10 = this.api.datacenter.Sprites.getItemAt(loc8);
		var loc11 = loc10.sequencer;
		var loc12 = loc10.GameActionsManager;
		var loc13 = true;
		loc12.onServerResponse(loc4);
		loop0:
		switch(loc5)
		{
			case 0:
				return undefined;
				break;
			case 1:
				var loc14 = this.api.datacenter.Sprites.getItemAt(loc6);
				if(!this.api.gfx.isMapBuild)
				{
					return undefined;
				}
				if(dofus.Constants.USE_JS_LOG && (_global.CONFIG.isNewAccount && !this.api.datacenter.Basics.first_movement))
				{
					getURL("JavaScript:WriteLog(\'Mouvement\')","_self");
					this.api.datacenter.Basics.first_movement = true;
				}
				var loc15 = ank.battlefield.utils.Compressor.extractFullPath(this.api.gfx.mapHandler,loc7);
				if(loc14.hasCarriedParent())
				{
					loc15.shift();
					this.api.gfx.uncarriedSprite(loc6,loc15[0],true,loc11);
					loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[loc6,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[loc14.Team]]);
				}
				var loc16 = loc14.forceRun;
				var loc17 = loc14.forceWalk;
				var loc18 = !this.api.datacenter.Game.isFight?!(loc14 instanceof dofus.datacenter.Character)?6:3:!(loc14 instanceof dofus.datacenter.Character)?4:3;
				this.api.gfx.moveSpriteWithUncompressedPath(loc6,loc15,loc11,!this.api.datacenter.Game.isFight,loc16,loc17,loc18);
				if(this.api.datacenter.Game.isRunning)
				{
					loc11.addAction(false,this.api.gfx,this.api.gfx.unSelect,[true]);
				}
				break;
			case 2:
				if(loc11 == undefined)
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
					loc11.addAction(false,this.api.gfx,this.api.gfx.clear);
					loc11.addAction(false,this.api.datacenter,this.api.datacenter.clearGame);
					if(loc7.length == 0)
					{
						loc11.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true}]);
					}
					else
					{
						loc11.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["Cinematic","Cinematic",{file:dofus.Constants.CINEMATICS_PATH + loc7 + ".swf",sequencer:loc11}]);
					}
				}
				break;
			default:
				switch(null)
				{
					case 4:
						var loc19 = loc7.split(",");
						var loc20 = loc19[0];
						var loc21 = Number(loc19[1]);
						var loc22 = this.api.datacenter.Sprites.getItemAt(loc20).mc;
						loc11.addAction(false,loc22,loc22.setPosition,[loc21]);
						break loop0;
					case 5:
						var loc23 = loc7.split(",");
						var loc24 = loc23[0];
						var loc25 = Number(loc23[1]);
						this.api.gfx.slideSprite(loc24,loc25,loc11);
						break loop0;
					case 11:
						var loc26 = loc7.split(",");
						var loc27 = loc26[0];
						var loc28 = Number(loc26[1]);
						loc11.addAction(false,this.api.gfx,this.api.gfx.setSpriteDirection,[loc27,loc28]);
						break loop0;
					case 50:
						var loc29 = loc7;
						loc11.addAction(false,this.api.gfx,this.api.gfx.carriedSprite,[loc29,loc6]);
						loc11.addAction(false,this.api.gfx,this.api.gfx.removeSpriteExtraClip,[loc29]);
						break loop0;
					case 51:
						var loc30 = Number(loc7);
						var loc31 = this.api.datacenter.Sprites.getItemAt(loc6);
						var loc32 = loc31.carriedChild;
						var loc33 = new ank.battlefield.datacenter.
();
						loc33.file = dofus.Constants.SPELLS_PATH + "1200.swf";
						loc33.level = 1;
						loc33.bInFrontOfSprite = true;
						loc33.bTryToBypassContainerColor = false;
						this.api.gfx.spriteLaunchCarriedSprite(loc6,loc33,loc30,31,10);
						loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[loc32.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[loc32.Team]]);
						break loop0;
					default:
						switch(null)
						{
							case 52:
								var loc34 = loc7.split(",");
								var loc35 = loc34[0];
								var loc36 = this.api.datacenter.Sprites.getItemAt(loc35);
								var loc37 = Number(loc34[1]);
								loc11.addAction(false,this.api.gfx,this.api.gfx.uncarriedSprite,[loc35,loc37,false]);
								loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[loc35,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[loc36.Team]]);
								break loop0;
							case 100:
							case 108:
							case 110:
								var loc38 = loc7.split(",");
								var loc39 = loc38[0];
								var loc40 = this.api.datacenter.Sprites.getItemAt(loc39);
								var loc41 = Number(loc38[1]);
								if(loc41 != 0)
								{
									var loc42 = loc41 >= 0?"WIN_LP":"LOST_LP";
									loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(loc42,[loc40.name,Math.abs(loc41)]),"INFO_FIGHT_CHAT"]);
									loc11.addAction(false,loc40,loc40.updateLP,[loc41]);
									loc11.addAction(false,this.api.ui.getUIComponent("Timeline").timelineControl,this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters);
								}
								else
								{
									loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("NOCHANGE_LP",[loc40.name]),"INFO_FIGHT_CHAT"]);
								}
								break loop0;
							default:
								switch(null)
								{
									case 102:
									case 111:
									case 120:
									case 168:
									default:
										switch(null)
										{
											case 127:
											case 129:
											case 128:
											case 78:
											case 169:
												var loc47 = loc7.split(",");
												var loc48 = loc47[0];
												var loc49 = Number(loc47[1]);
												var loc50 = this.api.datacenter.Sprites.getItemAt(loc48);
												if(loc49 == 0)
												{
													break loop0;
												}
												if(loc5 == 127 || (loc5 == 128 || (loc5 == 169 || loc5 == 78)))
												{
													var loc51 = loc49 >= 0?"WIN_MP":"LOST_MP";
													loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(loc51,[loc50.name,Math.abs(loc49)]),"INFO_FIGHT_CHAT"]);
												}
												loc11.addAction(false,loc50,loc50.updateMP,[loc49,loc5 == 129]);
												break loop0;
											default:
												switch(null)
												{
													case 103:
														var loc52 = loc7;
														var loc53 = this.api.datacenter.Sprites.getItemAt(loc52);
														var loc54 = loc53.mc;
														if(loc54 == undefined)
														{
															return undefined;
														}
														var loc55 = loc53.sex != 1?"m":"f";
														loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("DIE",[loc53.name]),loc55,true),"INFO_FIGHT_CHAT"]);
														var loc56 = this.api.ui.getUIComponent("Timeline");
														loc11.addAction(false,loc56,loc56.hideItem,[loc52]);
														this.warning("You\'re not allowed to change the behaviour of the game animations. Please play legit !");
														this.warning("Toute modification du comportement des animations est détectée et sanctionnée car c\'est considéré comme de la triche, merci de jouer legit !");
														if(!this.api.datacenter.Player.isSkippingFightAnimations)
														{
															loc11.addAction(true,loc54,loc54.setAnim,["Die"],1500,true);
														}
														this.warning("Vous n\'êtes même pas sensé pouvoir lire ce message, mais un rappel de plus n\'est pas de trop pour certains : modification du client = ban ;)");
														if(loc53.hasCarriedChild())
														{
															this.api.gfx.uncarriedSprite(loc53.carriedSprite.id,loc53.cellNum,false,loc11);
															loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[loc53.carriedChild.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[loc53.carriedChild.Team]]);
														}
														loc11.addAction(false,loc54,loc54.clear);
														if(this.api.datacenter.Player.summonedCreaturesID[loc52])
														{
															this.api.datacenter.Player.SummonedCreatures--;
															delete this.api.datacenter.Player.summonedCreaturesID.register52;
															this.api.ui.getUIComponent("Banner").shortcuts.setSpellStateOnAllContainers();
														}
														if(loc52 == this.api.datacenter.Player.ID)
														{
															if(loc6 == this.api.datacenter.Player.ID)
															{
																this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_HIMSELF);
															}
															else
															{
																var loc57 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																var loc58 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(loc6)).Team;
																if(loc57 == loc58)
																{
																	this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_BY_ALLY);
																}
																else
																{
																	this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
																}
															}
														}
														else if(loc6 == this.api.datacenter.Player.ID)
														{
															var loc59 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
															var loc60 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(loc52)).Team;
															if(loc59 == loc60)
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
														var loc61 = this.api.datacenter.Sprites.getItemAt(loc6);
														var loc62 = loc61.mc;
														loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("CANT_MOVEOUT"),"INFO_FIGHT_CHAT"]);
														loc11.addAction(false,loc62,loc62.setAnim,["Hit"]);
														break loop0;
													case 105:
													case 164:
														var loc63 = loc7.split(",");
														var loc64 = loc63[0];
														var loc65 = loc5 != 164?loc63[1]:loc63[1] + "%";
														var loc66 = this.api.datacenter.Sprites.getItemAt(loc64);
														loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_DAMAGES",[loc66.name,loc65]),"INFO_FIGHT_CHAT"]);
														break loop0;
													default:
														switch(null)
														{
															case 106:
																var loc67 = loc7.split(",");
																var loc68 = loc67[0];
																var loc69 = loc67[1] == "1";
																var loc70 = this.api.datacenter.Sprites.getItemAt(loc68);
																var loc71 = !loc69?this.api.lang.getText("RETURN_SPELL_NO",[loc70.name]):this.api.lang.getText("RETURN_SPELL_OK",[loc70.name]);
																loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,loc71,"INFO_FIGHT_CHAT"]);
																break loop0;
															case 107:
																var loc72 = loc7.split(",");
																var loc73 = loc72[0];
																var loc74 = loc72[1];
																var loc75 = this.api.datacenter.Sprites.getItemAt(loc73);
																loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_DAMAGES",[loc75.name,loc74]),"INFO_FIGHT_CHAT"]);
																break loop0;
															case 130:
																var loc76 = Number(loc7);
																var loc77 = this.api.datacenter.Sprites.getItemAt(loc6);
																loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("STEAL_GOLD",[loc77.name,loc76]),"m",loc76 < 2),"INFO_FIGHT_CHAT"]);
																break loop0;
															case 132:
																var loc78 = this.api.datacenter.Sprites.getItemAt(loc6);
																var loc79 = this.api.datacenter.Sprites.getItemAt(loc7);
																loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REMOVE_ALL_EFFECTS",[loc78.name,loc79.name]),"INFO_FIGHT_CHAT"]);
																loc11.addAction(false,loc79.CharacteristicsManager,loc79.CharacteristicsManager.terminateAllEffects);
																loc11.addAction(false,loc79.EffectsManager,loc79.EffectsManager.terminateAllEffects);
																break loop0;
															case 140:
																var loc80 = Number(loc7);
																var loc81 = this.api.datacenter.Sprites.getItemAt(loc6);
																var loc82 = this.api.datacenter.Sprites.getItemAt(loc7);
																loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("A_PASS_NEXT_TURN",[loc82.name]),"INFO_FIGHT_CHAT"]);
																break loop0;
															default:
																switch(null)
																{
																	case 151:
																		var loc83 = Number(loc7);
																		var loc84 = this.api.datacenter.Sprites.getItemAt(loc6);
																		var loc85 = loc83 != -1?this.api.lang.getText("INVISIBLE_OBSTACLE",[loc84.name,this.api.lang.getSpellText(loc83).n]):this.api.lang.getText("CANT_DO_INVISIBLE_OBSTACLE");
																		loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,loc85,"ERROR_CHAT"]);
																		break loop0;
																	case 166:
																		var loc86 = loc7.split(",");
																		var loc87 = Number(loc86[0]);
																		var loc88 = this.api.datacenter.Sprites.getItemAt(loc6);
																		var loc89 = Number(loc86[1]);
																		loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_AP",[loc88.name,loc89]),"INFO_FIGHT_CHAT"]);
																		break loop0;
																	case 164:
																		var loc90 = loc7.split(",");
																		var loc91 = Number(loc90[0]);
																		var loc92 = this.api.datacenter.Sprites.getItemAt(loc6);
																		var loc93 = Number(loc90[1]);
																		loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_LP_DAMAGES",[loc92.name,loc93]),"INFO_FIGHT_CHAT"]);
																		break loop0;
																	case 780:
																		if(loc6 == this.api.datacenter.Player.ID)
																		{
																			this.api.datacenter.Player.SummonedCreatures++;
																			var loc94 = _global.parseInt(loc7.split(";")[3]);
																			this.api.datacenter.Player.summonedCreaturesID[loc94] = true;
																		}
																	case 147:
																		var loc95 = loc7.split(";")[3];
																		var loc96 = this.api.ui.getUIComponent("Timeline");
																		loc11.addAction(false,loc96,loc96.showItem,[loc95]);
																		loc11.addAction(false,this.aks.Game,this.aks.Game.onMovement,[loc7,true]);
																		break loop0;
																	default:
																		switch(null)
																		{
																			case 181:
																			case 185:
																				loc11.addAction(false,this.aks.Game,this.aks.Game.onMovement,[loc7]);
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
																														loop14:
																														switch(null)
																														{
																															default:
																																switch(null)
																																{
																																	case 608:
																																	case 609:
																																	case 610:
																																	case 611:
																																		break loop14;
																																	case 149:
																																		var loc105 = loc7.split(",");
																																		var loc106 = loc105[0];
																																		var loc107 = this.api.datacenter.Sprites.getItemAt(loc106);
																																		var loc108 = Number(loc105[1]);
																																		var loc109 = Number(loc105[2]);
																																		var loc110 = Number(loc105[3]);
																																		loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("GFX",[loc107.name]),"INFO_FIGHT_CHAT"]);
																																		var loc111 = loc107.CharacteristicsManager;
																																		var loc112 = new dofus.datacenter.(loc5,loc108,loc109,undefined,undefined,loc110);
																																		loc11.addAction(false,loc111,loc111.addEffect,[loc112]);
																																		break loop0;
																																	default:
																																		switch(null)
																																		{
																																			case 150:
																																				var loc113 = loc7.split(",");
																																				var loc114 = loc113[0];
																																				var loc115 = this.api.datacenter.Sprites.getItemAt(loc114);
																																				var loc116 = Number(loc113[1]);
																																				if(loc116 > 0)
																																				{
																																					loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("INVISIBILITY",[loc115.name]),"INFO_FIGHT_CHAT"]);
																																					if(loc114 == this.api.datacenter.Player.ID)
																																					{
																																						loc11.addAction(false,loc115.mc,loc115.mc.setAlpha,[40]);
																																					}
																																					else
																																					{
																																						loc11.addAction(false,loc115.mc,loc115.mc.setVisible,[false]);
																																					}
																																				}
																																				else
																																				{
																																					loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("VISIBILITY",[loc115.name]),"INFO_FIGHT_CHAT"]);
																																					this.api.gfx.hideSprite(loc114,false);
																																					if(loc115.allowGhostMode && this.api.gfx.bGhostView)
																																					{
																																						this.api.gfx.setSpriteAlpha(loc114,ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
																																					}
																																					else
																																					{
																																						this.api.gfx.setSpriteAlpha(loc114,100);
																																					}
																																				}
																																				break loop0;
																																			case 165:
																																				var loc117 = loc7.split(",");
																																				var loc118 = loc117[0];
																																				var loc119 = Number(loc117[1]);
																																				var loc120 = Number(loc117[2]);
																																				var loc121 = Number(loc117[3]);
																																				break loop0;
																																			case 200:
																																				var loc122 = loc7.split(",");
																																				var loc123 = Number(loc122[0]);
																																				var loc124 = Number(loc122[1]);
																																				loc11.addAction(false,this.api.gfx,this.api.gfx.setObject2Frame,[loc123,loc124]);
																																				break loop0;
																																			case 208:
																																				var loc125 = loc7.split(",");
																																				var loc126 = this.api.datacenter.Sprites.getItemAt(loc6);
																																				var loc127 = Number(loc125[0]);
																																				var loc128 = loc125[1];
																																				var loc129 = Number(loc125[2]);
																																				var loc130 = !_global.isNaN(Number(loc125[3]))?"anim" + loc125[3]:String(loc125[3]).split("~");
																																				var loc131 = loc125[4] == undefined?1:Number(loc125[4]);
																																				var loc132 = new ank.battlefield.datacenter.
();
																																				loc132.file = dofus.Constants.SPELLS_PATH + loc128 + ".swf";
																																				loc132.level = loc131;
																																				loc132.bInFrontOfSprite = true;
																																				loc132.bTryToBypassContainerColor = true;
																																				this.api.gfx.spriteLaunchVisualEffect(loc6,loc132,loc127,loc129,loc130);
																																				break loop0;
																																			case 228:
																																				var loc133 = loc7.split(",");
																																				var loc134 = this.api.datacenter.Sprites.getItemAt(loc6);
																																				var loc135 = Number(loc133[0]);
																																				var loc136 = loc133[1];
																																				var loc137 = Number(loc133[2]);
																																				var loc138 = !_global.isNaN(Number(loc133[3]))?"anim" + loc133[3]:String(loc133[3]).split("~");
																																				var loc139 = loc133[4] == undefined?1:Number(loc133[4]);
																																				var loc140 = new ank.battlefield.datacenter.
();
																																				loc140.file = dofus.Constants.SPELLS_PATH + loc136 + ".swf";
																																				loc140.level = loc139;
																																				loc140.bInFrontOfSprite = true;
																																				loc140.bTryToBypassContainerColor = false;
																																				this.api.gfx.spriteLaunchVisualEffect(loc6,loc140,loc135,loc137,loc138);
																																				break loop0;
																																			default:
																																				switch(null)
																																				{
																																					case 300:
																																						var loc141 = loc7.split(",");
																																						var loc142 = this.api.datacenter.Sprites.getItemAt(loc6);
																																						var loc143 = Number(loc141[0]);
																																						var loc144 = Number(loc141[1]);
																																						var loc145 = loc141[2];
																																						var loc146 = Number(loc141[3]);
																																						var loc147 = Number(loc141[4]);
																																						var loc148 = !_global.isNaN(Number(loc141[5]))?!(loc141[5] == "-1" || loc141[5] == "-2")?"anim" + loc141[5]:undefined:String(loc141[5]).split("~");
																																						var loc149 = false;
																																						if(Number(loc141[5]) == -2)
																																						{
																																							loc149 = true;
																																						}
																																						var loc150 = loc141[6] != "1"?false:true;
																																						var loc151 = new ank.battlefield.datacenter.
();
																																						loc151.file = dofus.Constants.SPELLS_PATH + loc145 + ".swf";
																																						loc151.level = loc146;
																																						loc151.bInFrontOfSprite = loc150;
																																						loc151.params = new dofus.datacenter.(loc143,loc146).elements;
																																						loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[loc142.name,this.api.lang.getSpellText(loc143).n]),"INFO_FIGHT_CHAT"]);
																																						if(loc148 != undefined || loc149)
																																						{
																																							if(!this.api.datacenter.Player.isSkippingFightAnimations)
																																							{
																																								this.api.gfx.spriteLaunchVisualEffect(loc6,loc151,loc144,loc147,loc148);
																																							}
																																						}
																																						if(loc6 == this.api.datacenter.Player.ID)
																																						{
																																							var loc152 = this.api.datacenter.Player.SpellsManager;
																																							var loc153 = this.api.gfx.mapHandler.getCellData(loc144).spriteOnID;
																																							var loc154 = new dofus.datacenter.(loc143,loc153);
																																							loc152.addLaunchedSpell(loc154);
																																						}
																																						break loop0;
																																					case 301:
																																						var loc155 = Number(loc7);
																																						loc11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
																																						loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
																																						loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[loc6,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
																																						if(loc6 == this.api.datacenter.Player.ID)
																																						{
																																							this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
																																						}
																																						else
																																						{
																																							var loc156 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																							var loc157 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(loc6)).Team;
																																							if(loc156 == loc157)
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
																																						var loc158 = Number(loc7);
																																						var loc159 = this.api.datacenter.Sprites.getItemAt(loc6);
																																						loc11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
																																						loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[loc159.name,this.api.lang.getSpellText(loc158).n]),"INFO_FIGHT_CHAT"]);
																																						loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
																																						loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[loc6,this.api.lang.getText("CRITICAL_MISS")]);
																																						if(loc6 == this.api.datacenter.Player.ID)
																																						{
																																							this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
																																						}
																																						else
																																						{
																																							var loc160 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																							var loc161 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(loc6)).Team;
																																							if(loc160 == loc161)
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
																																						var loc162 = loc7.split(",");
																																						var loc163 = Number(loc162[0]);
																																						var loc164 = loc162[1];
																																						var loc165 = Number(loc162[2]);
																																						var loc166 = loc162[3] != "1"?false:true;
																																						var loc167 = this.api.datacenter.Sprites.getItemAt(loc6);
																																						var loc168 = loc167.mc;
																																						var loc169 = loc167.ToolAnimation;
																																						loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[loc167.name]),"INFO_FIGHT_CHAT"]);
																																						if(loc164 == undefined)
																																						{
																																							loc11.addAction(false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[loc6,loc163]);
																																							loc11.addAction(true,this.api.gfx,this.api.gfx.setSpriteAnim,[loc6,loc169]);
																																						}
																																						else
																																						{
																																							var loc170 = loc167.accessories[0].unicID;
																																							var loc171 = loc167.Guild;
																																							var loc172 = new ank.battlefield.datacenter.
();
																																							loc172.file = dofus.Constants.SPELLS_PATH + loc164 + ".swf";
																																							loc172.level = 1;
																																							loc172.bInFrontOfSprite = loc166;
																																							loc172.params = new dofus.datacenter.(new dofus.datacenter.(undefined,loc170),loc171).elements;
																																							this.api.gfx.spriteLaunchVisualEffect(loc6,loc172,loc163,loc165,loc169);
																																						}
																																						break loop0;
																																					case 304:
																																						var loc173 = this.api.datacenter.Sprites.getItemAt(loc6);
																																						var loc174 = loc173.mc;
																																						loc11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
																																						loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
																																						loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[loc6,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
																																						if(loc6 == this.api.datacenter.Player.ID)
																																						{
																																							this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
																																						}
																																						else
																																						{
																																							var loc175 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																							var loc176 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(loc6)).Team;
																																							if(loc175 == loc176)
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ALLIED);
																																							}
																																							else
																																							{
																																								this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ENEMY);
																																							}
																																						}
																																						break loop0;
																																					default:
																																						switch(null)
																																						{
																																							case 305:
																																								var loc177 = this.api.datacenter.Sprites.getItemAt(loc6);
																																								loc11.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
																																								loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[loc177.name]),"INFO_FIGHT_CHAT"]);
																																								loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
																																								loc11.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[loc6,this.api.lang.getText("CRITICAL_MISS")]);
																																								if(loc6 == this.api.datacenter.Player.ID)
																																								{
																																									this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
																																								}
																																								else
																																								{
																																									var loc178 = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
																																									var loc179 = this.api.datacenter.Sprites.getItemAt(_global.parseInt(loc6)).Team;
																																									if(loc178 == loc179)
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
																																								var loc180 = loc7.split(",");
																																								var loc181 = Number(loc180[0]);
																																								var loc182 = Number(loc180[1]);
																																								var loc183 = loc180[2];
																																								var loc184 = Number(loc180[3]);
																																								var loc185 = loc180[4] != "1"?false:true;
																																								var loc186 = Number(loc180[5]);
																																								var loc187 = this.api.datacenter.Sprites.getItemAt(loc6);
																																								var loc188 = this.api.datacenter.Sprites.getItemAt(loc186);
																																								var loc189 = new ank.battlefield.datacenter.
();
																																								loc189.id = loc181;
																																								loc189.file = dofus.Constants.SPELLS_PATH + loc183 + ".swf";
																																								loc189.level = loc184;
																																								loc189.bInFrontOfSprite = loc185;
																																								loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_TRAP",[loc187.name,this.api.lang.getSpellText(loc189.id).n,loc188.name]),"INFO_FIGHT_CHAT"]);
																																								loc11.addAction(false,this.api.gfx,this.api.gfx.addVisualEffectOnSprite,[loc186,loc189,loc182,11],1000);
																																								break loop0;
																																							case 307:
																																								var loc190 = loc7.split(",");
																																								var loc191 = Number(loc190[0]);
																																								var loc192 = Number(loc190[1]);
																																								var loc193 = Number(loc190[3]);
																																								var loc194 = Number(loc190[5]);
																																								var loc195 = this.api.datacenter.Sprites.getItemAt(loc6);
																																								var loc196 = this.api.datacenter.Sprites.getItemAt(loc194);
																																								var loc197 = new dofus.datacenter.(loc191,loc193);
																																								loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_GLIPH",[loc195.name,loc197.name,loc196.name]),"INFO_FIGHT_CHAT"]);
																																								break loop0;
																																							case 308:
																																								var loc198 = loc7.split(",");
																																								var loc199 = this.api.datacenter.Sprites.getItemAt(Number(loc198[0]));
																																								var loc200 = Number(loc198[1]);
																																								loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_AP",[loc199.name,loc200]),"INFO_FIGHT_CHAT"]);
																																								break loop0;
																																							case 309:
																																								var loc201 = loc7.split(",");
																																								var loc202 = this.api.datacenter.Sprites.getItemAt(Number(loc201[0]));
																																								var loc203 = Number(loc201[1]);
																																								loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_MP",[loc202.name,loc203]),"INFO_FIGHT_CHAT"]);
																																								break loop0;
																																							default:
																																								switch(null)
																																								{
																																									case 501:
																																										var loc204 = loc7.split(",");
																																										var loc205 = loc204[0];
																																										var loc206 = Number(loc204[1]);
																																										var loc207 = this.api.datacenter.Sprites.getItemAt(loc6);
																																										var loc208 = loc204[2] != undefined?"anim" + loc204[2]:loc207.ToolAnimation;
																																										loc11.addAction(false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[loc6,loc205]);
																																										loc11.addAction(loc6 == this.api.datacenter.Player.ID,this.api.gfx,this.api.gfx.setSpriteLoopAnim,[loc6,loc208,loc206],loc206,true);
																																										break loop0;
																																									case 617:
																																										loc13 = false;
																																										var loc209 = loc7.split(",");
																																										var loc210 = this.api.datacenter.Sprites.getItemAt(Number(loc209[0]));
																																										var loc211 = this.api.datacenter.Sprites.getItemAt(Number(loc209[1]));
																																										var loc212 = loc209[2];
																																										this.api.gfx.addSpriteBubble(loc212,this.api.lang.getText("A_ASK_MARRIAGE_B",[loc210.name,loc211.name]));
																																										if(loc210.id == this.api.datacenter.Player.ID)
																																										{
																																											this.api.kernel.showMessage(this.api.lang.getText("MARRIAGE"),this.api.lang.getText("A_ASK_MARRIAGE_B",[loc210.name,loc211.name]),"CAUTION_YESNO",{name:"Marriage",listener:this,params:{spriteID:loc210.id,refID:loc6}});
																																										}
																																										break loop0;
																																									case 618:
																																									case 619:
																																										loc13 = false;
																																										var loc213 = loc7.split(",");
																																										var loc214 = this.api.datacenter.Sprites.getItemAt(Number(loc213[0]));
																																										var loc215 = this.api.datacenter.Sprites.getItemAt(Number(loc213[1]));
																																										var loc216 = loc213[2];
																																										var loc217 = loc5 != 618?"A_NOT_MARRIED_B":"A_MARRIED_B";
																																										this.api.gfx.addSpriteBubble(loc216,this.api.lang.getText(loc217,[loc214.name,loc215.name]));
																																										break loop0;
																																									default:
																																										switch(null)
																																										{
																																											case 900:
																																												loc13 = false;
																																												var loc218 = this.api.datacenter.Sprites.getItemAt(loc6);
																																												var loc219 = this.api.datacenter.Sprites.getItemAt(Number(loc7));
																																												if(loc218 == undefined || (loc219 == undefined || (this.api.ui.getUIComponent("AskCancelChallenge") != undefined || this.api.ui.getUIComponent("AskYesNoIgnoreChallenge") != undefined)))
																																												{
																																													this.refuseChallenge(loc6);
																																													return undefined;
																																												}
																																												this.api.kernel.showMessage(undefined,this.api.lang.getText("A_CHALENGE_B",[this.api.kernel.ChatManager.getLinkName(loc218.name),this.api.kernel.ChatManager.getLinkName(loc219.name)]),"INFO_CHAT");
																																												if(loc218.id == this.api.datacenter.Player.ID)
																																												{
																																													this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("YOU_CHALENGE_B",[loc219.name]),"INFO_CANCEL",{name:"Challenge",listener:this,params:{spriteID:loc218.id}});
																																												}
																																												if(loc219.id == this.api.datacenter.Player.ID)
																																												{
																																													if(this.api.kernel.ChatManager.isBlacklisted(loc218.name))
																																													{
																																														this.refuseChallenge(loc218.id);
																																														return undefined;
																																													}
																																													this.api.electron.makeNotification(this.api.lang.getText("A_CHALENGE_YOU",[loc218.name]));
																																													this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("A_CHALENGE_YOU",[loc218.name]),"CAUTION_YESNOIGNORE",{name:"Challenge",player:loc218.name,listener:this,params:{spriteID:loc218.id,player:loc218.name}});
																																													this.api.sounds.events.onGameInvitation();
																																												}
																																												break loop0;
																																											case 901:
																																												loc13 = false;
																																												if(loc6 == this.api.datacenter.Player.ID || Number(loc7) == this.api.datacenter.Player.ID)
																																												{
																																													this.api.ui.unloadUIComponent("AskCancelChallenge");
																																												}
																																												break loop0;
																																											case 902:
																																												loc13 = false;
																																												this.api.ui.unloadUIComponent("AskYesNoIgnoreChallenge");
																																												this.api.ui.unloadUIComponent("AskCancelChallenge");
																																												break loop0;
																																											case 903:
																																												loc13 = false;
																																												loop21:
																																												switch(loc7)
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
																																													case "g":
																																														this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_BECAUSE_GUILD"),"ERROR_CHAT");
																																														break;
																																													default:
																																														switch(null)
																																														{
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
																																											default:
																																												switch(null)
																																												{
																																													case 905:
																																														this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("YOU_ARE_ATTAC"),background:true,timer:2000},{bForceLoad:true});
																																														break loop0;
																																													case 906:
																																														var loc220 = loc7;
																																														var loc221 = this.api.datacenter.Sprites.getItemAt(loc6);
																																														var loc222 = this.api.datacenter.Sprites.getItemAt(loc220);
																																														this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[loc221.name,loc222.name]),"INFO_CHAT");
																																														if(loc220 == this.api.datacenter.Player.ID)
																																														{
																																															this.api.electron.makeNotification(this.api.lang.getText("A_ATTACK_B",[loc221.name,loc222.name]));
																																															this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("YOU_ARE_ATTAC"),background:true,timer:2000},{bForceLoad:true});
																																															this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESSED);
																																														}
																																														else
																																														{
																																															this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESS);
																																														}
																																														break loop0;
																																													case 909:
																																														var loc223 = loc7;
																																														var loc224 = this.api.datacenter.Sprites.getItemAt(loc6);
																																														var loc225 = this.api.datacenter.Sprites.getItemAt(loc223);
																																														this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[loc224.name,loc225.name]),"INFO_CHAT");
																																														break loop0;
																																													case 950:
																																														var loc226 = loc7.split(",");
																																														var loc227 = loc226[0];
																																														var loc228 = this.api.datacenter.Sprites.getItemAt(loc227);
																																														var loc229 = Number(loc226[1]);
																																														var loc230 = Number(loc226[2]) != 1?false:true;
																																														if(loc229 == 8 && !loc230)
																																														{
																																															this.api.gfx.uncarriedSprite(loc6,loc228._oData.cellNum,true,loc11);
																																														}
																																														loc11.addAction(false,loc228,loc228.setState,[loc229,loc230]);
																																														var loc231 = this.api.lang.getText(!loc230?"EXIT_STATE":"ENTER_STATE",[loc228.name,this.api.lang.getStateText(loc229)]);
																																														loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,loc231,"INFO_FIGHT_CHAT"]);
																																														break loop0;
																																													default:
																																														switch(null)
																																														{
																																															case 998:
																																																var loc232 = loc2.split(",");
																																																var loc233 = loc232[0];
																																																var loc234 = loc232[0];
																																																var loc235 = loc232[2];
																																																var loc236 = loc232[3];
																																																var loc237 = loc232[4];
																																																var loc238 = loc232[6];
																																																var loc239 = loc232[7];
																																																var loc240 = new dofus.datacenter.(Number(loc234),Number(loc235),Number(loc236),Number(loc237),"",Number(loc238),Number(loc239));
																																																var loc241 = this.api.datacenter.Sprites.getItemAt(loc233);
																																																loc241.EffectsManager.addEffect(loc240);
																																																break;
																																															case 999:
																																																loc11.addAction(false,this.aks,this.aks.processCommand,[loc7]);
																																														}
																																												}
																																										}
																																								}
																																						}
																																				}
																																		}
																																}
																															case 162:
																															case 163:
																															case 606:
																															case 607:
																														}
																														break;
																													case 125:
																													case 153:
																													case 160:
																													case 161:
																												}
																												break;
																											case 155:
																											case 119:
																											case 154:
																											case 124:
																											case 156:
																										}
																										break;
																									case 157:
																									case 123:
																									case 152:
																									case 126:
																								}
																								break;
																							case 160:
																							case 161:
																							case 114:
																							case 182:
																							case 118:
																						}
																						break;
																					case 122:
																					case 112:
																					case 142:
																					case 145:
																					case 138:
																				}
																			case 117:
																			case 116:
																			case 115:
																				var loc98 = loc7.split(",");
																				var loc99 = loc98[0];
																				var loc100 = this.api.datacenter.Sprites.getItemAt(loc99);
																				var loc101 = Number(loc98[1]);
																				var loc102 = Number(loc98[2]);
																				var loc103 = loc100.CharacteristicsManager;
																				var loc104 = new dofus.datacenter.(loc5,loc101,undefined,undefined,undefined,loc102);
																				loc11.addAction(false,loc103,loc103.addEffect,[loc104]);
																				loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"<b>" + loc100.name + "</b> : " + loc104.description,"INFO_FIGHT_CHAT"]);
																		}
																	case 180:
																		var loc97 = loc7.split(";")[3];
																		if(loc6 == this.api.datacenter.Player.ID)
																		{
																			this.api.datacenter.Player.SummonedCreatures++;
																			this.api.datacenter.Player.summonedCreaturesID[loc97] = true;
																		}
																		loc11.addAction(false,this.aks.Game,this.aks.Game.onMovement,[loc7,true]);
																}
														}
												}
										}
								}
							case 101:
								var loc43 = loc7.split(",");
								var loc44 = this.api.datacenter.Sprites.getItemAt(loc43[0]);
								var loc45 = Number(loc43[1]);
								if(loc45 == 0)
								{
									break loop0;
								}
								if(loc5 == 101 || (loc5 == 111 || (loc5 == 120 || loc5 == 168)))
								{
									var loc46 = loc45 >= 0?"WIN_AP":"LOST_AP";
									loc11.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(loc46,[loc44.name,Math.abs(loc45)]),"INFO_FIGHT_CHAT"]);
								}
								loc11.addAction(false,loc44,loc44.updateAP,[loc45,loc5 == 102]);
								break loop0;
						}
				}
		}
		if(!_global.isNaN(loc4) && loc6 == this.api.datacenter.Player.ID)
		{
			loc11.addAction(false,loc12,loc12.ack,[loc4]);
		}
		else
		{
			loc12.end(loc8 == this.api.datacenter.Player.ID);
		}
		if(!loc11.isPlaying() && loc13)
		{
			loc11.execute(true);
		}
	}
	function cancel(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskCancelChallenge")
		{
			this.refuseChallenge(loc2.params.spriteID);
		}
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoIgnoreChallenge":
				this.acceptChallenge(loc2.params.spriteID);
				break;
			case "AskYesNoMarriage":
				this.acceptMarriage(loc2.params.refID);
				this.api.gfx.addSpriteBubble(loc2.params.spriteID,this.api.lang.getText("YES"));
		}
	}
	function no(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoIgnoreChallenge":
				this.refuseChallenge(loc2.params.spriteID);
				break;
			case "AskYesNoMarriage":
				this.refuseMarriage(loc2.params.refID);
				this.api.gfx.addSpriteBubble(loc2.params.spriteID,this.api.lang.getText("NO"));
		}
	}
	function ignore(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoIgnoreChallenge")
		{
			this.api.kernel.ChatManager.addToBlacklist(loc2.params.player);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[loc2.params.player]),"INFO_CHAT");
			this.refuseChallenge(loc2.params.spriteID);
		}
	}
}
