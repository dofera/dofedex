class dofus.datacenter.Effect extends Object
{
	var _nPropability = 0;
	var _nModificator = -1;
	function Effect(loc3, loc4, loc5, loc6, loc7, loc8, loc9, loc10)
	{
		super();
		this.initialize(loc3,loc4,loc5,loc6,loc7,loc8,loc9,loc10);
	}
	function __get__type()
	{
		return this._nType;
	}
	function __set__probability(loc2)
	{
		this._nPropability = loc2;
		return this.__get__probability();
	}
	function __get__probability()
	{
		return this._nPropability;
	}
	function __get__param1()
	{
		return this._nParam1;
	}
	function __set__param1(loc2)
	{
		this._nParam1 = loc2;
		return this.__get__param1();
	}
	function __get__param2()
	{
		return this._nParam2;
	}
	function __set__param2(loc2)
	{
		this._nParam2 = loc2;
		return this.__get__param2();
	}
	function __get__param3()
	{
		return this._nParam3;
	}
	function __set__param3(loc2)
	{
		this._nParam3 = loc2;
		return this.__get__param3();
	}
	function __get__param4()
	{
		return this._sParam4;
	}
	function __set__param4(loc2)
	{
		this._sParam4 = loc2;
		return this.__get__param4();
	}
	function __set__remainingTurn(loc2)
	{
		this._nRemainingTurn = loc2;
		return this.__get__remainingTurn();
	}
	function __get__remainingTurn()
	{
		return this._nRemainingTurn;
	}
	function __get__remainingTurnStr()
	{
		return this.getTurnCountStr(true);
	}
	function __get__spellID()
	{
		return this._nSpellID;
	}
	function __get__isNothing()
	{
		return this.api.lang.getEffectText(this._nType).d == "NOTHING";
	}
	function __get__description()
	{
		var loc2 = this.api.lang.getEffectText(this._nType).d;
		var loc3 = [this._nParam1,this._nParam2,this._nParam3,this._sParam4];
		loop0:
		switch(this._nType)
		{
			case 10:
				loc3[2] = this.api.lang.getEmoteText(this._nParam3).n;
				break;
			case 165:
				loc3[0] = this.api.lang.getItemTypeText(this._nParam1).n;
				break;
			case 293:
			case 294:
			case 787:
				loc3[0] = this.api.lang.getSpellText(this._nParam1).n;
				break;
			default:
				switch(null)
				{
					case 601:
						var loc4 = this.api.lang.getMapText(this._nParam2);
						loc3[0] = this.api.lang.getMapSubAreaText(loc4.sa).n;
						loc3[1] = loc4.x;
						loc3[2] = loc4.y;
						break loop0;
					case 614:
						loc3[0] = this._nParam3;
						loc3[1] = this.api.lang.getJobText(this._nParam2).n;
						break loop0;
					case 615:
						loc3[2] = this.api.lang.getJobText(this._nParam3).n;
						break loop0;
					case 616:
					case 624:
						loc3[2] = this.api.lang.getSpellText(this._nParam3).n;
						break loop0;
					default:
						switch(null)
						{
							case 699:
								loc3[0] = this.api.lang.getJobText(this._nParam1).n;
								break loop0;
							case 628:
							case 623:
								loc3[2] = this.api.lang.getMonstersText(this._nParam3).n;
								break loop0;
							case 715:
								loc3[0] = this.api.lang.getMonstersSuperRaceText(this._nParam1).n;
								break loop0;
							case 716:
								loc3[0] = this.api.lang.getMonstersRaceText(this._nParam1).n;
								break loop0;
							default:
								switch(null)
								{
									case 717:
										loc3[0] = this.api.lang.getMonstersText(this._nParam1).n;
										break loop0;
									case 805:
									case 808:
									case 983:
										this._nParam3 = this._nParam3 != undefined?this._nParam3:0;
										var loc5 = String(Math.floor(this._nParam2) / 100).split(".");
										var loc6 = Number(loc5[0]);
										var loc7 = this._nParam2 - loc6 * 100;
										var loc8 = String(Math.floor(this._nParam3) / 100).split(".");
										var loc9 = Number(loc8[0]);
										var loc10 = this._nParam3 - loc9 * 100;
										loc3[0] = ank.utils.PatternDecoder.getDescription(this.api.lang.getConfigText("DATE_FORMAT"),[this._nParam1,new ank.utils.(loc6 + 1).addLeftChar("0",2),new ank.utils.(loc7).addLeftChar("0",2),loc9,new ank.utils.(loc10).addLeftChar("0",2)]);
										break loop0;
									case 806:
										if(this._nParam2 == undefined && this._nParam3 == undefined)
										{
											loc3[0] = this.api.lang.getText("NORMAL");
										}
										else
										{
											loc3[0] = this._nParam2 <= 6?this._nParam3 <= 6?this.api.lang.getText("NORMAL"):this.api.lang.getText("LEAN"):this.api.lang.getText("FAT");
										}
										break loop0;
									default:
										switch(null)
										{
											case 807:
												if(this._nParam3 == undefined)
												{
													loc3[0] = this.api.lang.getText("NO_LAST_MEAL");
												}
												else
												{
													loc3[0] = this.api.lang.getItemUnicText(this._nParam3).n;
												}
												break loop0;
											case 814:
												loc3[0] = this.api.lang.getItemUnicText(this._nParam3).n;
												break loop0;
											case 950:
											case 951:
												loc3[2] = this.api.lang.getStateText(this._nParam3);
												break loop0;
											default:
												if(loc0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST)
												{
													if(loc0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGE)
													{
														switch(null)
														{
															default:
																if(loc0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_HEAL)
																{
																	switch(null)
																	{
																		default:
																			if(loc0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_SET_INTVL)
																			{
																				if(loc0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CC)
																				{
																					loop7:
																					switch(null)
																					{
																						default:
																							if(loc0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTURN)
																							{
																								switch(null)
																								{
																									case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTARGET:
																										break loop7;
																									case 939:
																									case 940:
																										var loc11 = new dofus.datacenter.(-1,Number(loc3[2]),1,0,"",0);
																										loc3[2] = loc11.name;
																										break loop0;
																									default:
																										switch(null)
																										{
																											case 960:
																												loc3[2] = this.api.lang.getAlignment(this._nParam3).n;
																												break;
																											case 999:
																										}
																								}
																							}
																							break;
																						case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CASTOUTLINE:
																						case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_NOLINEOFSIGHT:
																					}
																					break;
																				}
																				break;
																			}
																			break;
																		case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST:
																		case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CAST_INTVL:
																	}
																	break;
																}
																break;
															case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGEABLE:
															case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_DMG:
														}
													}
												}
												loc3[0] = this.api.lang.getSpellText(Number(loc3[0])).n;
										}
								}
						}
				}
		}
		if(this.api.lang.getEffectText(this._nType).j && this.api.kernel.OptionsManager.getOption("ViewDicesDammages"))
		{
			var loc12 = this._sParam4.toLowerCase().split("d");
			loc12[1] = loc12[1].split("+");
			if(!(loc12[0] == undefined || (loc12[1] == undefined || (loc12[1][0] == undefined || loc12[1][0] == undefined))))
			{
				var loc13 = "";
				loc13 = loc13 + (!(loc12[0] != "0" && loc12[1][0] != "0")?"":loc12[0] + "d" + loc12[1][0]);
				loc13 = loc13 + (loc12[1][1] == "0"?"":(loc13 == ""?"":"+") + loc12[1][1]);
				loc3[0] = loc13;
				loc3[4] = loc0 = undefined;
				loc3[2] = loc0;
				loc3[1] = loc0;
			}
		}
		var loc14 = "";
		if(this._nPropability > 0 && this._nPropability != undefined)
		{
			loc14 = loc14 + (" - " + this.api.lang.getText("IN_CASE_PERCENT",[this._nPropability]) + ": ");
		}
		if(this._nType == 666)
		{
			loc14 = loc14 + this.api.lang.getText("DO_NOTHING");
		}
		else
		{
			var loc15 = ank.utils.PatternDecoder.getDescription(loc2,loc3);
			if(loc15 == null || loc15 == "null")
			{
				return new String();
			}
			if(loc15 != undefined)
			{
				loc14 = loc14 + loc15;
			}
		}
		if(this._nModificator > 0 && this.api.kernel.SpellsBoostsManager.isBoostedHealingOrDamagingEffect(this._nType))
		{
			loc14 = loc14 + (" " + this.api.lang.getText("BOOSTED_SPELLS_EFFECT_COMPLEMENT",[this._nModificator]));
		}
		var loc16 = this.getTurnCountStr(false);
		if(loc16.length == 0)
		{
			return loc14;
		}
		return loc14 + " (" + loc16 + ")";
	}
	function __get__characteristic()
	{
		return this.api.lang.getEffectText(this._nType).c;
	}
	function __get__operator()
	{
		return this.api.lang.getEffectText(this._nType).o;
	}
	function __get__element()
	{
		return this.api.lang.getEffectText(this._nType).e;
	}
	function __get__spellName()
	{
		return this.api.lang.getSpellText(this._nSpellID).n;
	}
	function __get__spellDescription()
	{
		return this.api.lang.getSpellText(this._nSpellID).d;
	}
	function __get__showInTooltip()
	{
		return this.api.lang.getEffectText(this._nType).t;
	}
	function initialize(loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9)
	{
		this.api = _global.API;
		this._nType = Number(loc2);
		this._nParam1 = !_global.isNaN(Number(loc3))?Number(loc3):undefined;
		this._nParam2 = !_global.isNaN(Number(loc4))?Number(loc4):undefined;
		this._nParam3 = !_global.isNaN(Number(loc5))?Number(loc5):undefined;
		this._sParam4 = loc6;
		this._nRemainingTurn = loc7 != undefined?Number(loc7):0;
		if(this._nRemainingTurn < 0 || this._nRemainingTurn >= 63)
		{
			this._nRemainingTurn = Number.POSITIVE_INFINITY;
		}
		this._nSpellID = Number(loc8);
		this._nModificator = Number(loc9);
	}
	function getParamWithOperator(loc2)
	{
		var loc3 = this.operator != "-"?1:-1;
		return this["_nParam" + loc2] * loc3;
	}
	function getTurnCountStr(loc2)
	{
		var loc3 = new String();
		if(this._nRemainingTurn == undefined)
		{
			return "";
		}
		if(_global.isFinite(this._nRemainingTurn))
		{
			if(this._nRemainingTurn > 1)
			{
				return String(this._nRemainingTurn) + " " + this.api.lang.getText("TURNS");
			}
			if(this._nRemainingTurn == 0)
			{
				return "";
			}
			if(loc2)
			{
				return this.api.lang.getText("LAST_TURN");
			}
			return String(this._nRemainingTurn) + " " + this.api.lang.getText("TURN");
		}
		return this.api.lang.getText("INFINIT");
	}
}
