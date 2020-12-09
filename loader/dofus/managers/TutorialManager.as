class dofus.managers.TutorialManager extends dofus.utils.ApiElement
{
	var _bInTutorialMode = false;
	static var _sSelf = null;
	function TutorialManager(§\x1e\x1a\x16§)
	{
		super();
		dofus.managers.TutorialManager._sSelf = this;
		this.initialize(var3);
	}
	function __get__isTutorialMode()
	{
		return this._bInTutorialMode;
	}
	function __get__vars()
	{
		var var2 = new String();
		for(var k in this._oVars)
		{
			var2 = var2 + (k + ":" + this._oVars[k] + "\n");
		}
		return var2;
	}
	static function getInstance()
	{
		return dofus.managers.TutorialManager._sSelf;
	}
	function initialize(§\x1e\x1a\x16§)
	{
		super.initialize(var3);
		this._oSequencer = new ank.utils.();
	}
	function clear()
	{
		this._bInTutorialMode = false;
		ank.utils.Timer.removeTimer(this,"tutorial");
		this._oVars = new Object();
	}
	function start(§\x1e\x17\x16§)
	{
		this._bInTutorialMode = true;
		this._oVars = new Object();
		this._oTutorial = var2;
		var var3 = var2.getRootBloc();
		this.executeBloc(var3);
		if(this._oTutorial.canCancel)
		{
			this.api.ui.loadUIComponent("Tutorial","Tutorial");
		}
	}
	function cancel()
	{
		var var2 = this._oTutorial.getRootExitBloc();
		if(var2 == undefined)
		{
			this.terminate(0);
		}
		else
		{
			this.executeBloc(var2);
		}
	}
	function terminate(§\t\x0e§)
	{
		this.clear();
		var var3 = this.api.datacenter.Player.data.cellNum;
		var var4 = this.api.datacenter.Player.data.direction;
		this.api.network.Tutorial.end(var2,var3,var4);
		this.api.ui.unloadUIComponent("Tutorial");
	}
	function forceTerminate()
	{
		this.clear();
		var var2 = this.api.datacenter.Player.data.cellNum;
		var var3 = this.api.datacenter.Player.data.direction;
		this.api.ui.unloadUIComponent("Tutorial");
	}
	function executeBloc(§\x1e\x1a\x0f§)
	{
		ank.utils.Timer.removeTimer(this,"tutorial");
		for(var i in var2.params)
		{
			if(typeof var2.params[i] == "string")
			{
				var var3 = String(var2.params[i]);
				if(var3.substr(0,16) == "!LOCALIZEDSTRING" && var3.substr(var3.length - 1,1) == "!")
				{
					var var4 = Number(var3.substring(16,var3.length - 1));
					if(!_global.isNaN(var4))
					{
						var2.params[i] = this.api.lang.getTutorialText(var4);
					}
				}
			}
			else if(typeof var2.params[i] == "object")
			{
				for(var s in var2.params[i])
				{
					if(typeof var2.params[i][s] == "string")
					{
						var var5 = String(var2.params[i][s]);
						if(var5.substr(0,16) == "!LOCALIZEDSTRING" && var5.substr(var5.length - 1,1) == "!")
						{
							var var6 = Number(var5.substring(16,var5.length - 1));
							if(!_global.isNaN(var6))
							{
								var2.params[i][s] = this.api.lang.getTutorialText(var6);
							}
						}
					}
				}
			}
		}
		if((var var0 = var2.type) !== dofus.datacenter.TutorialBloc.TYPE_ACTION)
		{
			if(var0 !== dofus.datacenter.TutorialBloc.TYPE_WAITING)
			{
				if(var0 !== dofus.datacenter.TutorialBloc.TYPE_IF)
				{
					ank.utils.Logger.log("[executeBloc] mauvais type");
				}
				else
				{
					if(!(var2 instanceof dofus.datacenter.TutorialIf))
					{
						ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
						return undefined;
					}
					var var39 = this.extractValue(var2.left);
					var var40 = this.extractValue(var2.right);
					var var41 = false;
					switch(var2.operator)
					{
						case "=":
							var41 = var39 == var40;
							break;
						case "<":
							var41 = var39 < var40;
							break;
						case ">":
							var41 = var39 > var40;
					}
					if(var41)
					{
						this._oSequencer.addAction(170,false,this,this.callNextBloc,[var2.nextBlocTrueID]);
					}
					else
					{
						this._oSequencer.addAction(171,false,this,this.callNextBloc,[var2.nextBlocFalseID]);
					}
					if(!this._oSequencer.isPlaying())
					{
						this._oSequencer.execute(true);
					}
				}
			}
			else
			{
				this._oCurrentWaitingBloc = var2;
				if(!(var2 instanceof dofus.datacenter.TutorialWaiting))
				{
					ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
					return undefined;
				}
				ank.utils.Timer.removeTimer(this,"tutorial");
				if(var2.timeout != 0)
				{
					ank.utils.Timer.setTimer(this,"tutorial",this,this.onWaitingTimeout,var2.timeout,[var2]);
				}
			}
		}
		else
		{
			if(!(var2 instanceof dofus.datacenter.TutorialAction))
			{
				ank.utils.Logger.err("[executeBloc] le type ne correspond pas");
				return undefined;
			}
			if(!var2.keepLastWaitingBloc)
			{
				delete this._oCurrentWaitingBloc;
			}
			loop3:
			switch(var2.actionCode)
			{
				case "VAR_ADD":
					this._oSequencer.addAction(126,false,this,this.addToVariable,var2.params);
					break;
				case "VAR_SET":
					this._oSequencer.addAction(127,false,this,this.setToVariable,var2.params);
					break;
				default:
					switch(null)
					{
						case "CHAT":
							this._oSequencer.addAction(128,false,this.api.kernel,this.api.kernel.showMessage,[undefined,var2.params[0],var2.params[1]]);
							break loop3;
						case "GFX_CLEAN_MAP":
							this._oSequencer.addAction(129,false,this.api.gfx,this.api.gfx.cleanMap,[undefined,true]);
							break loop3;
						case "GFX_SELECT":
							this._oSequencer.addAction(130,false,this.api.gfx,this.api.gfx.select,[var2.params[0],var2.params[1]]);
							break loop3;
						case "GFX_UNSELECT":
							this._oSequencer.addAction(131,false,this.api.gfx,this.api.gfx.unSelect,[var2.params[0],var2.params[1]]);
							break loop3;
						case "GFX_ALPHA":
							this._oSequencer.addAction(132,false,this.api.gfx,this.api.gfx.setSpriteAlpha,[var2.params[0],var2.params[1]]);
							break loop3;
						default:
							switch(null)
							{
								case "GFX_GRID":
									if(var2.params[0] == true)
									{
										this._oSequencer.addAction(133,false,this.api.gfx,this.api.gfx.drawGrid,[false]);
									}
									else
									{
										this._oSequencer.addAction(134,false,this.api.gfx,this.api.gfx.removeGrid,[]);
									}
									break loop3;
								case "GFX_ADD_INDICATOR":
									var var7 = this.api.gfx.mapHandler.getCellData(var2.params[0]).mc;
									if(var7 == undefined)
									{
										ank.utils.Logger.err("[GFX_ADD_INDICATOR] la cellule n\'existe pas");
										break loop3;
									}
									var var8 = {x:var7._x,y:var7._y};
									var7._parent.localToGlobal(var8);
									var var9 = var8.x;
									var var10 = var8.y;
									this._oSequencer.addAction(135,false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
									this._oSequencer.addAction(136,false,this.api.ui,this.api.ui.loadUIComponent,["Indicator","Indicator",{coordinates:[var9,var10],offset:var2.params[1],rotate:false},{bAlwaysOnTop:true}]);
									break loop3;
								case "GFX_ADD_PLAYER_SPRITE":
									var var11 = this.api.datacenter.Player.data;
									this._oSequencer.addAction(137,false,this.api.gfx,this.api.gfx.addSprite,[var11.id,var11]);
									break loop3;
								case "GFX_ADD_SPRITE":
									var var12 = new dofus.datacenter.(var2.params[0],ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var2.params[1] + ".swf",var2.params[2],var2.params[3],var2.params[1]);
									var12.name = var2.params[4] != undefined?var2.params[4]:"";
									var12.color1 = var2.params[5] != undefined?var2.params[5]:-1;
									var12.color2 = var2.params[6] != undefined?var2.params[6]:-1;
									var12.color3 = var2.params[7] != undefined?var2.params[7]:-1;
									this._oSequencer.addAction(138,false,this.api.gfx,this.api.gfx.addSprite,[var12.id,var12]);
									break loop3;
								case "GFX_REMOVE_SPRITE":
									this._oSequencer.addAction(139,false,this.api.gfx,this.api.gfx.removeSprite,[var2.params[0],false]);
									break loop3;
								default:
									switch(null)
									{
										case "GFX_MOVE_SPRITE":
											var var13 = this.getSpriteIDFromData(var2.params[0]);
											var var14 = this.api.datacenter.Sprites.getItemAt(var13);
											var var15 = ank.battlefield.utils.Pathfinding.pathFind(this.api,this.api.gfx.mapHandler,var14.cellNum,var2.params[1],{bAllDirections:false,bIgnoreSprites:true,bCellNumOnly:true,bWithBeginCellNum:true});
											if(var15 != null)
											{
												this.api.gfx.spriteHandler.moveSprite(var14.id,var15,this._oSequencer,false,undefined,false,false);
											}
											break loop3;
										case "GFX_ADD_SPRITE_BUBBLE":
											var var16 = this.getSpriteIDFromData(var2.params[0]);
											this._oSequencer.addAction(140,true,this.api.gfx,this.api.gfx.removeSpriteBubble,[var16],200);
											this._oSequencer.addAction(141,false,this.api.gfx,this.api.gfx.addSpriteBubble,[var16,var2.params[1]]);
											break loop3;
										case "GFX_CLEAR_SPRITE_BUBBLES":
											this._oSequencer.addAction(142,false,this.api.gfx.textHandler,this.api.gfx.textHandler.clear,[]);
											break loop3;
										case "GFX_SPRITE_DIR":
											var var17 = this.getSpriteIDFromData(var2.params[0]);
											this._oSequencer.addAction(143,false,this.api.gfx,this.api.gfx.setSpriteDirection,[var17,var2.params[1]]);
											break loop3;
										default:
											switch(null)
											{
												case "GFX_SPRITE_POS":
													var var18 = this.getSpriteIDFromData(var2.params[0]);
													this._oSequencer.addAction(144,false,this.api.gfx,this.api.gfx.setSpritePosition,[var18,var2.params[1]]);
													break loop3;
												case "GFX_SPRITE_VISUALEFFECT":
													var var19 = this.getSpriteIDFromData(var2.params[0]);
													var var20 = new ank.battlefield.datacenter.
();
													var20.file = dofus.Constants.SPELLS_PATH + var2.params[1] + ".swf";
													var20.level = !_global.isNaN(Number(var2.params[3]))?Number(var2.params[3]):1;
													var20.bInFrontOfSprite = true;
													this._oSequencer.addAction(145,false,this.api.gfx,this.api.gfx.addVisualEffectOnSprite,[var19,var20,var2.params[2],var2.params[4]]);
													break loop3;
												case "GFX_SPRITE_ANIM":
													var var21 = this.getSpriteIDFromData(var2.params[0]);
													this._oSequencer.addAction(146,false,this.api.gfx,this.api.gfx.setSpriteAnim,[var21,var2.params[1]]);
													break loop3;
												case "GFX_SPRITE_EXEC_FUNCTION":
													var var22 = this.getSpriteIDFromData(var2.params[0]);
													var var23 = this.api.datacenter.Sprites.getItemAt(var22);
													var var24 = var23[var2.params[1]];
													if(typeof var24 != "function")
													{
														ank.utils.Logger.err("[GFX_SPRITE_EXEC_FUNCTION] la fonction n\'existe pas");
														break loop3;
													}
													this._oSequencer.addAction(147,false,var23,var24,var2.params[2]);
													break loop3;
												case "GFX_SPRITE_SET_PROPERTY":
													var var25 = this.getSpriteIDFromData(var2.params[0]);
													var var26 = this.api.datacenter.Sprites.getItemAt(var25);
													this._oSequencer.addAction(148,false,this,this.setObjectPropertyValue,[var26,var2.params[1],var2.params[2]]);
													break loop3;
												default:
													switch(null)
													{
														case "GFX_DRAW_ZONE":
															this._oSequencer.addAction(149,false,this.api.gfx,this.api.gfx.drawZone,var2.params);
															break loop3;
														case "GFX_CLEAR_ALL_ZONES":
															this._oSequencer.addAction(150,false,this.api.gfx,this.api.gfx.clearAllZones,[]);
															break loop3;
														case "GFX_ADD_POINTER_SHAPE":
															this._oSequencer.addAction(151,false,this.api.gfx,this.api.gfx.addPointerShape,var2.params);
															break loop3;
														case "GFX_CLEAR_POINTER":
															this._oSequencer.addAction(152,false,this.api.gfx,this.api.gfx.clearPointer,[]);
															break loop3;
														default:
															switch(null)
															{
																case "GFX_HIDE_POINTER":
																	this._oSequencer.addAction(153,false,this.api.gfx,this.api.gfx.hidePointer,[]);
																	break loop3;
																case "GFX_DRAW_POINTER":
																	this._oSequencer.addAction(154,false,this.api.gfx,this.api.gfx.drawPointer,var2.params);
																	break loop3;
																case "GFX_OBJECT2_INTERACTIVE":
																	this._oSequencer.addAction(155,false,this.api.gfx,this.api.gfx.setObject2Interactive,[var2.params[0],var2.params[1],1]);
																	break loop3;
																case "INTERAC_SET":
																	this._oSequencer.addAction(156,false,this.api.gfx,this.api.gfx.setInteraction,[ank.battlefield.Constants[var2.params[0]]]);
																	break loop3;
																default:
																	switch(null)
																	{
																		case "INTERAC_SET_ONCELLS":
																			this._oSequencer.addAction(157,false,this.api.gfx,this.api.gfx.setInteractionOnCells,[var2.params[0],ank.battlefield.Constants[var2.params[1]]]);
																			break loop3;
																		case "UI_ADD_INDICATOR":
																			var var27 = this.api.ui.getUIComponent(var2.params[0]);
																			var var28 = eval(var27 + "." + var2.params[1]);
																			var var29 = var28.getBounds();
																			var var30 = var29.xMax - var29.xMin;
																			var var31 = var29.yMax - var29.yMin;
																			var var32 = var30 / 2 + var28._x + var29.xMin;
																			var var33 = var31 / 2 + var28._y + var29.yMin;
																			var var34 = {x:var32,y:var33};
																			var28._parent.localToGlobal(var34);
																			var32 = var34.x;
																			var33 = var34.y;
																			var var35 = Math.sqrt(Math.pow(var30,2) + Math.pow(var31,2)) / 2;
																			this._oSequencer.addAction(158,false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
																			this._oSequencer.addAction(159,false,this.api.ui,this.api.ui.loadUIComponent,["Indicator","Indicator",{coordinates:[var32,var33],offset:var35},{bAlwaysOnTop:true}]);
																			break loop3;
																		case "UI_REMOVE_INDICATOR":
																			this._oSequencer.addAction(160,false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
																			break loop3;
																		case "UI_OPEN":
																			this._oSequencer.addAction(161,false,this.api.ui,this.api.ui.loadUIComponent,[var2.params[0],var2.params[0],var2.params[1],var2.params[2]]);
																			break loop3;
																		case "UI_OPEN_AUTOHIDE":
																			this._oSequencer.addAction(162,false,this.api.ui,this.api.ui.loadUIAutoHideComponent,[var2.params[0],var2.params[0],var2.params[1],var2.params[2]]);
																			break loop3;
																		default:
																			switch(null)
																			{
																				case "UI_CLOSE":
																					this._oSequencer.addAction(163,false,this.api.ui,this.api.ui.unloadUIComponent,[var2.params[0]]);
																					break loop3;
																				case "UI_EXEC_FUNCTION":
																					var var36 = this.api.ui.getUIComponent(var2.params[0]);
																					var var37 = var36[var2.params[1]];
																					if(typeof var37 != "function")
																					{
																						ank.utils.Logger.err("[UI_EXEC_FUNCTION] la fonction n\'existe pas");
																						break loop3;
																					}
																					this._oSequencer.addAction(164,false,var36,var37,var2.params[2]);
																					break loop3;
																				case "ADD_SPELL":
																					var var38 = new dofus.datacenter.(var2.params[0],var2.params[1],var2.params[2]);
																					this._oSequencer.addAction(165,false,this.api.datacenter.Player,this.api.datacenter.Player.updateSpellPosition,[var38]);
																					break loop3;
																				case "SET_SPELLS":
																					this._oSequencer.addAction(166,false,this.api.network.Spells,this.api.network.Spells.onList,[var2.params.join(";")]);
																					break loop3;
																				case "REMOVE_SPELL":
																					this._oSequencer.addAction(167,false,this.api.datacenter.Player,this.api.datacenter.Player.removeSpell,var2.params);
																					break loop3;
																				default:
																					if(var0 !== "END")
																					{
																						ank.utils.Logger.err("[executeBloc] Code action " + var2.actionCode + " inconnu");
																						return undefined;
																					}
																					this._oSequencer.addAction(168,false,this,this.terminate,var2.params);
																					if(!this._oSequencer.isPlaying())
																					{
																						this._oSequencer.execute(true);
																					}
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
			this._oSequencer.addAction(169,false,this,this.callNextBloc,[var2.nextBlocID]);
			if(!this._oSequencer.isPlaying())
			{
				this._oSequencer.execute(true);
			}
		}
	}
	function callNextBloc(§\n\x0f§)
	{
		ank.utils.Timer.removeTimer(this,"tutorial");
		if(typeof var2 == "object")
		{
			var var3 = var2[random(var2.length)];
		}
		else
		{
			var3 = var2;
		}
		this.addToQueue({object:this,method:this.executeBloc,params:[this._oTutorial.getBloc(var3)]});
	}
	function callCurrentBlocDefaultCase()
	{
		var var2 = this._oCurrentWaitingBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_DEFAULT];
		if(var2 != undefined)
		{
			this.callNextBloc(var2.nextBlocID);
		}
	}
	function setObjectPropertyValue(§\x1e\x18\x1a§, §\x1e\x0e\x18§, §\t\x14§)
	{
		if(var2 == undefined)
		{
			ank.utils.Logger.err("[setObjectPropertyValue] l\'objet n\'existe pas");
			return undefined;
		}
		var2[var3] = var4;
	}
	function getSpriteIDFromData(§\n\x12§)
	{
		if(typeof var2 == "number")
		{
			return var2 != 0?var2:this.api.datacenter.Player.ID;
		}
		if(typeof var2 == "string")
		{
			return this.api.datacenter.Map.data[var2.substr(1)].spriteOnID;
		}
	}
	function setToVariable(§\x1e\f\b§, §\x1e\x1b\x17§)
	{
		var2 = this.extractVarName(var2);
		this._oVars[var2] = var3;
	}
	function addToVariable(§\x1e\f\b§, §\x1e\x1b\x17§)
	{
		var2 = this.extractVarName(var2);
		if(this._oVars[var2] == undefined)
		{
			this._oVars[var2] = var3;
		}
		else
		{
			this._oVars[var2] = this._oVars[var2] + var3;
		}
	}
	function extractVarName(§\x1e\f\b§)
	{
		var var3 = var2.split("|");
		if(var3.length != 0)
		{
			var2 = var3[0];
			var var4 = 1;
			while(var4 < var3.length)
			{
				var2 = var2 + ("_" + this._oVars[var3[var4]]);
				var4 = var4 + 1;
			}
		}
		return var2;
	}
	function extractValue(§\t\x13§)
	{
		if(typeof var2 == "string")
		{
			return this._oVars[this.extractVarName(var2)];
		}
		return var2;
	}
	function onWaitingTimeout(§\x1e\x1a\x0f§)
	{
		this.callNextBloc(var2.cases[dofus.datacenter.TutorialWaitingCase.CASE_TIMEOUT].nextBlocID);
	}
	function onWaitingCase(§\x1e\x19\x18§)
	{
		var var3 = var2.code;
		var var4 = var2.params;
		var var5 = this._oCurrentWaitingBloc.cases[var3];
		if(var5 != undefined)
		{
			loop2:
			switch(var5.code)
			{
				default:
					switch(null)
					{
						case "SPELL_CONTAINER_SELECT":
						case "OBJECT_CONTAINER_SELECT":
							break loop2;
						case "OBJECT_RELEASE":
							var var7 = 0;
							while(var7 < var5.params.length)
							{
								if(var4[0] == var5.params[var7][0] && var4[1] == var5.params[var7][1])
								{
									this.callNextBloc(var5.nextBlocID[var7] != undefined?var5.nextBlocID[var7]:var5.nextBlocID);
									return undefined;
								}
								var7 = var7 + 1;
							}
							this.callCurrentBlocDefaultCase();
						default:
							this.callNextBloc(var5.nextBlocID);
							return undefined;
					}
				case "CELL_RELEASE":
				case "CELL_OVER":
				case "CELL_OUT":
				case "SPRITE_RELEASE":
			}
			var var6 = 0;
			while(var6 < var5.params.length)
			{
				if(var4[0] == var5.params[var6][0])
				{
					this.callNextBloc(var5.nextBlocID[var6] != undefined?var5.nextBlocID[var6]:var5.nextBlocID);
					return undefined;
				}
				var6 = var6 + 1;
			}
			this.callCurrentBlocDefaultCase();
		}
		else
		{
			this.callCurrentBlocDefaultCase();
		}
	}
}
