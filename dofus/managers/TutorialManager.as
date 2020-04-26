class dofus.managers.TutorialManager extends dofus.utils.ApiElement
{
	var _bInTutorialMode = false;
	static var _sSelf = null;
	function TutorialManager(loc3)
	{
		super();
		dofus.managers.TutorialManager._sSelf = this;
		this.initialize(loc3);
	}
	function __get__isTutorialMode()
	{
		return this._bInTutorialMode;
	}
	function __get__vars()
	{
		var loc2 = new String();
		for(var k in this._oVars)
		{
			loc2 = loc2 + (k + ":" + this._oVars[k] + "\n");
		}
		return loc2;
	}
	static function getInstance()
	{
		return dofus.managers.TutorialManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		this._oSequencer = new ank.utils.();
	}
	function clear()
	{
		this._bInTutorialMode = false;
		ank.utils.Timer.removeTimer(this,"tutorial");
		this._oVars = new Object();
	}
	function start(loc2)
	{
		this._bInTutorialMode = true;
		this._oVars = new Object();
		this._oTutorial = loc2;
		var loc3 = loc2.getRootBloc();
		this.executeBloc(loc3);
		if(this._oTutorial.canCancel)
		{
			this.api.ui.loadUIComponent("Tutorial","Tutorial");
		}
	}
	function cancel()
	{
		var loc2 = this._oTutorial.getRootExitBloc();
		if(loc2 == undefined)
		{
			this.terminate(0);
		}
		else
		{
			this.executeBloc(loc2);
		}
	}
	function terminate(loc2)
	{
		this.clear();
		var loc3 = this.api.datacenter.Player.data.cellNum;
		var loc4 = this.api.datacenter.Player.data.direction;
		this.api.network.Tutorial.end(loc2,loc3,loc4);
		this.api.ui.unloadUIComponent("Tutorial");
	}
	function executeBloc(loc2)
	{
		ank.utils.Timer.removeTimer(this,"tutorial");
		for(var i in loc2.params)
		{
			if(typeof loc2.params[i] == "string")
			{
				var loc3 = String(loc2.params[i]);
				if(loc3.substr(0,16) == "!LOCALIZEDSTRING" && loc3.substr(loc3.length - 1,1) == "!")
				{
					var loc4 = Number(loc3.substring(16,loc3.length - 1));
					if(!_global.isNaN(loc4))
					{
						loc2.params[i] = this.api.lang.getTutorialText(loc4);
					}
				}
			}
			else if(typeof loc2.params[i] == "object")
			{
				for(var s in loc2.params[i])
				{
					if(typeof loc2.params[i][s] == "string")
					{
						var loc5 = String(loc2.params[i][s]);
						if(loc5.substr(0,16) == "!LOCALIZEDSTRING" && loc5.substr(loc5.length - 1,1) == "!")
						{
							var loc6 = Number(loc5.substring(16,loc5.length - 1));
							if(!_global.isNaN(loc6))
							{
								loc2.params[i][s] = this.api.lang.getTutorialText(loc6);
							}
						}
					}
				}
			}
		}
		if((var loc0 = loc2.type) !== dofus.datacenter.TutorialBloc.TYPE_ACTION)
		{
			if(loc0 !== dofus.datacenter.TutorialBloc.TYPE_WAITING)
			{
				if(loc0 !== dofus.datacenter.TutorialBloc.TYPE_IF)
				{
					ank.utils.Logger.log("[executeBloc] mauvais type");
				}
				else
				{
					if(!(loc2 instanceof dofus.datacenter.TutorialIf))
					{
						ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
						return undefined;
					}
					var loc39 = this.extractValue(loc2.left);
					var loc40 = this.extractValue(loc2.right);
					var loc41 = false;
					switch(loc2.operator)
					{
						case "=":
							loc41 = loc39 == loc40;
							break;
						case "<":
							loc41 = loc39 < loc40;
							break;
						case ">":
							loc41 = loc39 > loc40;
					}
					if(loc41)
					{
						this._oSequencer.addAction(false,this,this.callNextBloc,[loc2.nextBlocTrueID]);
					}
					else
					{
						this._oSequencer.addAction(false,this,this.callNextBloc,[loc2.nextBlocFalseID]);
					}
					if(!this._oSequencer.isPlaying())
					{
						this._oSequencer.execute(true);
					}
				}
			}
			else
			{
				this._oCurrentWaitingBloc = loc2;
				if(!(loc2 instanceof dofus.datacenter.TutorialWaiting))
				{
					ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
					return undefined;
				}
				ank.utils.Timer.removeTimer(this,"tutorial");
				if(loc2.timeout != 0)
				{
					ank.utils.Timer.setTimer(this,"tutorial",this,this.onWaitingTimeout,loc2.timeout,[loc2]);
				}
			}
		}
		else
		{
			if(!(loc2 instanceof dofus.datacenter.TutorialAction))
			{
				ank.utils.Logger.err("[executeBloc] le type ne correspond pas");
				return undefined;
			}
			if(!loc2.keepLastWaitingBloc)
			{
				delete this._oCurrentWaitingBloc;
			}
			if((loc0 = loc2.actionCode) !== "VAR_ADD")
			{
				loop3:
				switch(null)
				{
					case "VAR_SET":
						this._oSequencer.addAction(false,this,this.setToVariable,loc2.params);
						break;
					case "CHAT":
						this._oSequencer.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,loc2.params[0],loc2.params[1]]);
						break;
					case "GFX_CLEAN_MAP":
						this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.cleanMap,[undefined,true]);
						break;
					case "GFX_SELECT":
						this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.select,[loc2.params[0],loc2.params[1]]);
						break;
					case "GFX_UNSELECT":
						this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.unSelect,[loc2.params[0],loc2.params[1]]);
						break;
					default:
						switch(null)
						{
							case "GFX_ALPHA":
								this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpriteAlpha,[loc2.params[0],loc2.params[1]]);
								break loop3;
							case "GFX_GRID":
								if(loc2.params[0] == true)
								{
									this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.drawGrid,[false]);
								}
								else
								{
									this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.removeGrid,[]);
								}
								break loop3;
							case "GFX_ADD_INDICATOR":
								var loc7 = this.api.gfx.mapHandler.getCellData(loc2.params[0]).mc;
								if(loc7 == undefined)
								{
									ank.utils.Logger.err("[GFX_ADD_INDICATOR] la cellule n\'existe pas");
									break loop3;
								}
								var loc8 = {x:loc7._x,y:loc7._y};
								loc7._parent.localToGlobal(loc8);
								var loc9 = loc8.x;
								var loc10 = loc8.y;
								this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
								this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIComponent,["Indicator","Indicator",{coordinates:[loc9,loc10],offset:loc2.params[1],rotate:false},{bAlwaysOnTop:true}]);
								break loop3;
							case "GFX_ADD_PLAYER_SPRITE":
								var loc11 = this.api.datacenter.Player.data;
								this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addSprite,[loc11.id,loc11]);
								break loop3;
							default:
								switch(null)
								{
									case "GFX_ADD_SPRITE":
										var loc12 = new dofus.datacenter.	(loc2.params[0],ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc2.params[1] + ".swf",loc2.params[2],loc2.params[3],loc2.params[1]);
										loc12.name = loc2.params[4] != undefined?loc2.params[4]:"";
										loc12.color1 = loc2.params[5] != undefined?loc2.params[5]:-1;
										loc12.color2 = loc2.params[6] != undefined?loc2.params[6]:-1;
										loc12.color3 = loc2.params[7] != undefined?loc2.params[7]:-1;
										this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addSprite,[loc12.id,loc12]);
										break loop3;
									case "GFX_REMOVE_SPRITE":
										this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.removeSprite,[loc2.params[0],false]);
										break loop3;
									case "GFX_MOVE_SPRITE":
										var loc13 = this.getSpriteIDFromData(loc2.params[0]);
										var loc14 = this.api.datacenter.Sprites.getItemAt(loc13);
										var loc15 = ank.battlefield.utils.Pathfinding.pathFind(this.api.gfx.mapHandler,loc14.cellNum,loc2.params[1],{bAllDirections:false,bIgnoreSprites:true,bCellNumOnly:true,bWithBeginCellNum:true});
										if(loc15 != null)
										{
											this.api.gfx.spriteHandler.moveSprite(loc14.id,loc15,this._oSequencer,false,undefined,false,false);
										}
										break loop3;
									case "GFX_ADD_SPRITE_BUBBLE":
										var loc16 = this.getSpriteIDFromData(loc2.params[0]);
										this._oSequencer.addAction(true,this.api.gfx,this.api.gfx.removeSpriteBubble,[loc16],200);
										this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[loc16,loc2.params[1]]);
										break loop3;
									case "GFX_CLEAR_SPRITE_BUBBLES":
										this._oSequencer.addAction(false,this.api.gfx.textHandler,this.api.gfx.textHandler.clear,[]);
										break loop3;
									default:
										switch(null)
										{
											case "GFX_SPRITE_DIR":
												var loc17 = this.getSpriteIDFromData(loc2.params[0]);
												this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpriteDirection,[loc17,loc2.params[1]]);
												break loop3;
											case "GFX_SPRITE_POS":
												var loc18 = this.getSpriteIDFromData(loc2.params[0]);
												this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpritePosition,[loc18,loc2.params[1]]);
												break loop3;
											case "GFX_SPRITE_VISUALEFFECT":
												var loc19 = this.getSpriteIDFromData(loc2.params[0]);
												var loc20 = new ank.battlefield.datacenter.
();
												loc20.file = dofus.Constants.SPELLS_PATH + loc2.params[1] + ".swf";
												loc20.level = !_global.isNaN(Number(loc2.params[3]))?Number(loc2.params[3]):1;
												loc20.bInFrontOfSprite = true;
												this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addVisualEffectOnSprite,[loc19,loc20,loc2.params[2],loc2.params[4]]);
												break loop3;
											case "GFX_SPRITE_ANIM":
												var loc21 = this.getSpriteIDFromData(loc2.params[0]);
												this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpriteAnim,[loc21,loc2.params[1]]);
												break loop3;
											default:
												switch(null)
												{
													case "GFX_SPRITE_EXEC_FUNCTION":
														var loc22 = this.getSpriteIDFromData(loc2.params[0]);
														var loc23 = this.api.datacenter.Sprites.getItemAt(loc22);
														var loc24 = loc23[loc2.params[1]];
														if(typeof loc24 != "function")
														{
															ank.utils.Logger.err("[GFX_SPRITE_EXEC_FUNCTION] la fonction n\'existe pas");
															break loop3;
														}
														this._oSequencer.addAction(false,loc23,loc24,loc2.params[2]);
														break loop3;
													case "GFX_SPRITE_SET_PROPERTY":
														var loc25 = this.getSpriteIDFromData(loc2.params[0]);
														var loc26 = this.api.datacenter.Sprites.getItemAt(loc25);
														this._oSequencer.addAction(false,this,this.setObjectPropertyValue,[loc26,loc2.params[1],loc2.params[2]]);
														break loop3;
													case "GFX_DRAW_ZONE":
														this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.drawZone,loc2.params);
														break loop3;
													case "GFX_CLEAR_ALL_ZONES":
														this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.clearAllZones,[]);
														break loop3;
													case "GFX_ADD_POINTER_SHAPE":
														this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addPointerShape,loc2.params);
														break loop3;
													default:
														switch(null)
														{
															case "GFX_CLEAR_POINTER":
																this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.clearPointer,[]);
																break loop3;
															case "GFX_HIDE_POINTER":
																this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.hidePointer,[]);
																break loop3;
															case "GFX_DRAW_POINTER":
																this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.drawPointer,loc2.params);
																break loop3;
															case "GFX_OBJECT2_INTERACTIVE":
																this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setObject2Interactive,[loc2.params[0],loc2.params[1],1]);
																break loop3;
															default:
																switch(null)
																{
																	case "INTERAC_SET":
																		this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setInteraction,[ank.battlefield.Constants[loc2.params[0]]]);
																		break loop3;
																	case "INTERAC_SET_ONCELLS":
																		this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setInteractionOnCells,[loc2.params[0],ank.battlefield.Constants[loc2.params[1]]]);
																		break loop3;
																	case "UI_ADD_INDICATOR":
																		var loc27 = this.api.ui.getUIComponent(loc2.params[0]);
																		var loc28 = eval(loc27 + "." + loc2.params[1]);
																		var loc29 = loc28.getBounds();
																		var loc30 = loc29.xMax - loc29.xMin;
																		var loc31 = loc29.yMax - loc29.yMin;
																		var loc32 = loc30 / 2 + loc28._x + loc29.xMin;
																		var loc33 = loc31 / 2 + loc28._y + loc29.yMin;
																		var loc34 = {x:loc32,y:loc33};
																		loc28._parent.localToGlobal(loc34);
																		loc32 = loc34.x;
																		loc33 = loc34.y;
																		var loc35 = Math.sqrt(Math.pow(loc30,2) + Math.pow(loc31,2)) / 2;
																		this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
																		this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIComponent,["Indicator","Indicator",{coordinates:[loc32,loc33],offset:loc35},{bAlwaysOnTop:true}]);
																		break loop3;
																	case "UI_REMOVE_INDICATOR":
																		this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
																		break loop3;
																	default:
																		switch(null)
																		{
																			case "UI_OPEN":
																				this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIComponent,[loc2.params[0],loc2.params[0],loc2.params[1],loc2.params[2]]);
																				break loop3;
																			case "UI_OPEN_AUTOHIDE":
																				this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIAutoHideComponent,[loc2.params[0],loc2.params[0],loc2.params[1],loc2.params[2]]);
																				break loop3;
																			case "UI_CLOSE":
																				this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,[loc2.params[0]]);
																				break loop3;
																			case "UI_EXEC_FUNCTION":
																				var loc36 = this.api.ui.getUIComponent(loc2.params[0]);
																				var loc37 = loc36[loc2.params[1]];
																				if(typeof loc37 != "function")
																				{
																					ank.utils.Logger.err("[UI_EXEC_FUNCTION] la fonction n\'existe pas");
																					break loop3;
																				}
																				this._oSequencer.addAction(false,loc36,loc37,loc2.params[2]);
																				break loop3;
																			default:
																				switch(null)
																				{
																					case "ADD_SPELL":
																						var loc38 = new dofus.datacenter.(loc2.params[0],loc2.params[1],loc2.params[2]);
																						this._oSequencer.addAction(false,this.api.datacenter.Player,this.api.datacenter.Player.updateSpellPosition,[loc38]);
																						break loop3;
																					case "SET_SPELLS":
																						this._oSequencer.addAction(false,this.api.network.Spells,this.api.network.Spells.onList,[loc2.params.join(";")]);
																						break loop3;
																					case "REMOVE_SPELL":
																						this._oSequencer.addAction(false,this.api.datacenter.Player,this.api.datacenter.Player.removeSpell,loc2.params);
																						break loop3;
																					case "END":
																						this._oSequencer.addAction(false,this,this.terminate,loc2.params);
																						if(!this._oSequencer.isPlaying())
																						{
																							this._oSequencer.execute(true);
																						}
																						return undefined;
																					default:
																						ank.utils.Logger.err("[executeBloc] Code action " + loc2.actionCode + " inconnu");
																						return undefined;
																				}
																		}
																}
														}
												}
										}
								}
						}
				}
			}
			else
			{
				this._oSequencer.addAction(false,this,this.addToVariable,loc2.params);
			}
			this._oSequencer.addAction(false,this,this.callNextBloc,[loc2.nextBlocID]);
			if(!this._oSequencer.isPlaying())
			{
				this._oSequencer.execute(true);
			}
		}
	}
	function callNextBloc(loc2)
	{
		ank.utils.Timer.removeTimer(this,"tutorial");
		if(typeof loc2 == "object")
		{
			var loc3 = loc2[random(loc2.length)];
		}
		else
		{
			loc3 = loc2;
		}
		this.addToQueue({object:this,method:this.executeBloc,params:[this._oTutorial.getBloc(loc3)]});
	}
	function callCurrentBlocDefaultCase()
	{
		var loc2 = this._oCurrentWaitingBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_DEFAULT];
		if(loc2 != undefined)
		{
			this.callNextBloc(loc2.nextBlocID);
		}
	}
	function setObjectPropertyValue(loc2, loc3, loc4)
	{
		if(loc2 == undefined)
		{
			ank.utils.Logger.err("[setObjectPropertyValue] l\'objet n\'existe pas");
			return undefined;
		}
		loc2[loc3] = loc4;
	}
	function getSpriteIDFromData(loc2)
	{
		if(typeof loc2 == "number")
		{
			return loc2 != 0?loc2:this.api.datacenter.Player.ID;
		}
		if(typeof loc2 == "string")
		{
			return this.api.datacenter.Map.data[loc2.substr(1)].spriteOnID;
		}
	}
	function setToVariable(loc2, loc3)
	{
		loc2 = this.extractVarName(loc2);
		this._oVars[loc2] = loc3;
	}
	function addToVariable(loc2, loc3)
	{
		loc2 = this.extractVarName(loc2);
		if(this._oVars[loc2] == undefined)
		{
			this._oVars[loc2] = loc3;
		}
		else
		{
			this._oVars[loc2] = this._oVars[loc2] + loc3;
		}
	}
	function extractVarName(loc2)
	{
		var loc3 = loc2.split("|");
		if(loc3.length != 0)
		{
			loc2 = loc3[0];
			var loc4 = 1;
			while(loc4 < loc3.length)
			{
				loc2 = loc2 + ("_" + this._oVars[loc3[loc4]]);
				loc4 = loc4 + 1;
			}
		}
		return loc2;
	}
	function extractValue(loc2)
	{
		if(typeof loc2 == "string")
		{
			return this._oVars[this.extractVarName(loc2)];
		}
		return loc2;
	}
	function onWaitingTimeout(loc2)
	{
		this.callNextBloc(loc2.cases[dofus.datacenter.TutorialWaitingCase.CASE_TIMEOUT].nextBlocID);
	}
	function onWaitingCase(loc2)
	{
		var loc3 = loc2.code;
		var loc4 = loc2.params;
		var loc5 = this._oCurrentWaitingBloc.cases[loc3];
		if(loc5 != undefined)
		{
			if((var loc0 = loc5.code) !== "CELL_RELEASE")
			{
				switch(null)
				{
					case "CELL_OVER":
					case "CELL_OUT":
					case "SPRITE_RELEASE":
					case "SPELL_CONTAINER_SELECT":
					case "OBJECT_CONTAINER_SELECT":
						break;
					default:
						if(loc0 !== "OBJECT_RELEASE")
						{
							this.callNextBloc(loc5.nextBlocID);
							return undefined;
						}
						var loc7 = 0;
						while(loc7 < loc5.params.length)
						{
							if(loc4[0] == loc5.params[loc7][0] && loc4[1] == loc5.params[loc7][1])
							{
								this.callNextBloc(loc5.nextBlocID[loc7] != undefined?loc5.nextBlocID[loc7]:loc5.nextBlocID);
								return undefined;
							}
							loc7 = loc7 + 1;
						}
						break;
				}
				this.callCurrentBlocDefaultCase();
			}
			var loc6 = 0;
			while(loc6 < loc5.params.length)
			{
				if(loc4[0] == loc5.params[loc6][0])
				{
					this.callNextBloc(loc5.nextBlocID[loc6] != undefined?loc5.nextBlocID[loc6]:loc5.nextBlocID);
					return undefined;
				}
				loc6 = loc6 + 1;
			}
			this.callCurrentBlocDefaultCase();
		}
		else
		{
			this.callCurrentBlocDefaultCase();
		}
	}
}
