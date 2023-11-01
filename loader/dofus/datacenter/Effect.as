class dofus.datacenter.Effect extends Object
{
	var _nPropability = 0;
	var _nModificator = -1;
	function Effect(sCasterID, §\t\n§, §\t\x15§, §\t\x14§, §\t\x13§, §\t\x12§, §\t\x0f§, §\t\f§, §\x02\r§)
	{
		super();
		this.initialize(sCasterID,var4,var5,var6,var7,var8,var9,var10,var11);
	}
	function __get__type()
	{
		return this._nType;
	}
	function __set__probability(var2)
	{
		this._nPropability = var2;
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
	function __set__param1(var2)
	{
		this._nParam1 = var2;
		return this.__get__param1();
	}
	function __get__param2()
	{
		return this._nParam2;
	}
	function __set__param2(var2)
	{
		this._nParam2 = var2;
		return this.__get__param2();
	}
	function __get__param3()
	{
		return this._nParam3;
	}
	function __set__param3(var2)
	{
		this._nParam3 = var2;
		return this.__get__param3();
	}
	function __get__param4()
	{
		return this._sParam4;
	}
	function __set__param4(var2)
	{
		this._sParam4 = var2;
		return this.__get__param4();
	}
	function __set__remainingTurn(var2)
	{
		this._nRemainingTurn = var2;
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
		var var2 = this.api.lang.getEffectText(this._nType).d;
		var var3 = [this._nParam1,this._nParam2,this._nParam3,this._sParam4];
		if((var var0 = this._nType) !== 10)
		{
			loop0:
			switch(null)
			{
				case 165:
					var3[0] = this.api.lang.getItemTypeText(this._nParam1).n;
					break;
				case 293:
				case 294:
				case 787:
					var3[0] = this.api.lang.getSpellText(this._nParam1).n;
					break;
				default:
					switch(null)
					{
						case 601:
							var var4 = this.api.lang.getMapText(this._nParam2);
							var3[0] = this.api.lang.getMapSubAreaText(var4.sa).n;
							var3[1] = var4.x;
							var3[2] = var4.y;
							break loop0;
						case 614:
							var3[0] = this._nParam3;
							var3[1] = this.api.lang.getJobText(this._nParam2).n;
							break loop0;
						case 615:
							var3[2] = this.api.lang.getJobText(this._nParam3).n;
							break loop0;
						case 616:
						case 624:
							var3[2] = this.api.lang.getSpellText(this._nParam3).n;
							break loop0;
						default:
							switch(null)
							{
								case 699:
									var3[0] = this.api.lang.getJobText(this._nParam1).n;
									break loop0;
								case 628:
								case 623:
									var3[2] = this.api.lang.getMonstersText(this._nParam3).n;
									break loop0;
								case 715:
									var3[0] = this.api.lang.getMonstersSuperRaceText(this._nParam1).n;
									break loop0;
								default:
									switch(null)
									{
										case 716:
											var3[0] = this.api.lang.getMonstersRaceText(this._nParam1).n;
											break loop0;
										case 717:
											var3[0] = this.api.lang.getMonstersText(this._nParam1).n;
											break loop0;
										default:
											switch(null)
											{
												case 983:
												case 806:
													if(this._nParam2 == undefined && this._nParam3 == undefined)
													{
														var3[0] = this.api.lang.getText("NORMAL");
													}
													else
													{
														var3[0] = this._nParam2 <= 6?this._nParam3 <= 6?this.api.lang.getText("NORMAL"):this.api.lang.getText("LEAN"):this.api.lang.getText("FAT");
													}
													break loop0;
												case 807:
													if(this._nParam3 == undefined)
													{
														var3[0] = this.api.lang.getText("NO_LAST_MEAL");
													}
													else
													{
														var3[0] = this.api.lang.getItemUnicText(this._nParam3).n;
													}
													break loop0;
												case 814:
													var3[0] = this.api.lang.getItemUnicText(this._nParam3).n;
													break loop0;
												default:
													switch(null)
													{
														case 951:
														default:
															if(var0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGE)
															{
																if(var0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGEABLE)
																{
																	switch(null)
																	{
																		default:
																			if(var0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST)
																			{
																				if(var0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CAST_INTVL)
																				{
																					loop7:
																					switch(null)
																					{
																						default:
																							if(var0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CASTOUTLINE)
																							{
																								if(var0 !== dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_NOLINEOFSIGHT)
																								{
																									switch(null)
																									{
																										case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTURN:
																										case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTARGET:
																											break loop7;
																										default:
																											switch(null)
																											{
																												case 940:
																												case 969:
																													break;
																												case 960:
																													var3[2] = this.api.lang.getAlignment(this._nParam3).n;
																													break;
																												case 999:
																											}
																											break loop0;
																										case 939:
																											var var11 = new dofus.datacenter.(-1,Number(var3[2]),1,0,"",0);
																											var3[2] = var11.name;
																									}
																								}
																								break;
																							}
																							break;
																						case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_SET_INTVL:
																						case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CC:
																					}
																					break;
																				}
																				break;
																			}
																			break;
																		case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_DMG:
																		case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_HEAL:
																	}
																}
															}
														case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST:
															var3[0] = this.api.lang.getSpellText(Number(var3[0])).n;
													}
												case 950:
													var3[2] = this.api.lang.getStateText(this._nParam3);
											}
										case 805:
										case 808:
											this._nParam3 = this._nParam3 != undefined?this._nParam3:0;
											var var5 = String(Math.floor(this._nParam2) / 100).split(".");
											var var6 = Number(var5[0]);
											var var7 = this._nParam2 - var6 * 100;
											var var8 = String(Math.floor(this._nParam3) / 100).split(".");
											var var9 = Number(var8[0]);
											var var10 = this._nParam3 - var9 * 100;
											var3[0] = ank.utils.PatternDecoder.getDescription(this.api.lang.getConfigText("DATE_FORMAT"),[this._nParam1,new ank.utils.(var6 + 1).addLeftChar("0",2),new ank.utils.(var7).addLeftChar("0",2),var9,new ank.utils.(var10).addLeftChar("0",2)]);
									}
							}
					}
			}
		}
		else
		{
			var3[2] = this.api.lang.getEmoteText(this._nParam3).n;
		}
		if(this.api.lang.getEffectText(this._nType).j && this.api.kernel.OptionsManager.getOption("ViewDicesDammages"))
		{
			var var12 = this._sParam4.toLowerCase().split("d");
			var12[1] = var12[1].split("+");
			if(!(var12[0] == undefined || (var12[1] == undefined || (var12[1][0] == undefined || var12[1][0] == undefined))))
			{
				var var13 = "";
				var13 = var13 + (!(var12[0] != "0" && var12[1][0] != "0")?"":var12[0] + "d" + var12[1][0]);
				var13 = var13 + (var12[1][1] == "0"?"":(var13 == ""?"":"+") + var12[1][1]);
				var3[0] = var13;
				var3[4] = var0 = undefined;
				var3[2] = var0;
				var3[1] = var0;
			}
		}
		var var14 = "";
		if(this._nPropability > 0 && this._nPropability != undefined)
		{
			var14 = var14 + (" - " + this.api.lang.getText("IN_CASE_PERCENT",[this._nPropability]) + ": ");
		}
		if(this._nType == 666)
		{
			var14 = var14 + this.api.lang.getText("DO_NOTHING");
		}
		else
		{
			var var15 = ank.utils.PatternDecoder.getDescription(var2,var3);
			if(var15 == null || var15 == "null")
			{
				return new String();
			}
			if(var15 != undefined)
			{
				var14 = var14 + var15;
			}
		}
		if(this._nModificator > 0 && this.api.kernel.SpellsBoostsManager.isBoostedHealingOrDamagingEffect(this._nType))
		{
			var14 = var14 + (" " + this.api.lang.getText("BOOSTED_SPELLS_EFFECT_COMPLEMENT",[this._nModificator]));
		}
		var var16 = this.getTurnCountStr(false);
		if(var16.length == 0)
		{
			return var14;
		}
		return var14 + " (" + var16 + ")";
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
	function __get__sCasterID()
	{
		return this._sCasterID;
	}
	function initialize(sCasterID, §\t\n§, §\t\x15§, §\t\x14§, §\t\x13§, §\t\x12§, §\t\x0f§, §\t\f§, §\x02\r§)
	{
		this.api = _global.API;
		this._nType = Number(var3);
		this._sCasterID = sCasterID;
		this._nParam1 = !_global.isNaN(Number(var4))?Number(var4):undefined;
		this._nParam2 = !_global.isNaN(Number(var5))?Number(var5):undefined;
		this._nParam3 = !_global.isNaN(Number(var6))?Number(var6):undefined;
		this._sParam4 = var7;
		this._nRemainingTurn = var8 != undefined?Number(var8):0;
		if(this._nRemainingTurn < 0 || this._nRemainingTurn >= 63)
		{
			this._nRemainingTurn = Number.POSITIVE_INFINITY;
		}
		this._nSpellID = Number(var9);
		this._nModificator = Number(var10);
	}
	function getParamWithOperator(var2)
	{
		var var3 = this.operator != "-"?1:-1;
		return this["_nParam" + var2] * var3;
	}
	function getTurnCountStr(var2)
	{
		var var3 = new String();
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
			if(var2)
			{
				return this.api.lang.getText("LAST_TURN");
			}
			return String(this._nRemainingTurn) + " " + this.api.lang.getText("TURN");
		}
		return this.api.lang.getText("INFINIT");
	}
}
