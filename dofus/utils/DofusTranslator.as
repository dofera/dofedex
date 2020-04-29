class dofus.utils.DofusTranslator extends dofus.utils.ApiElement
{
	var _aSOXtraCache = new Array();
	function DofusTranslator()
	{
		super();
	}
	function getLangVersion()
	{
		return Number(this.getValueFromSOLang("VERSION"));
	}
	function getXtraVersion()
	{
		return Number(this.getValueFromSOXtra("VERSION"));
	}
	function getText(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = new Array();
		}
		var var4 = new Array();
		var var5 = new Array();
		var var6 = 0;
		while(var6 < var3.length)
		{
			var4.push("%" + (var6 + 1));
			var5.push(var3[var6]);
			var6 = var6 + 1;
		}
		var var7 = this.getValueFromSOLang(var2);
		if(var7 == "" || var7 == undefined)
		{
			return "!" + var2 + "!";
		}
		return new ank.utils.(var7).replace(var4,var5);
	}
	function getConfigText(var2)
	{
		var var3 = this.getValueFromSOLang("C")[var2];
		if(typeof var3 == "string")
		{
			var var4 = var3;
			var var5 = new ank.utils.(var4);
			return var5.replace(["%CMNT%","%CMNTT%"],[this.api.datacenter.Basics.aks_community_id,this.api.datacenter.Basics.aks_detected_country.toLowerCase()]);
		}
		return var3;
	}
	function getAllMapsInfos()
	{
		return this.getValueFromSOXtra("MA").m;
	}
	function getMapMaxChallenge(var2)
	{
		var var3 = this.getValueFromSOXtra("MA").m[var2].c;
		if(var3 == undefined || _global.isNaN(var3))
		{
			return dofus.Constants.MAX_PLAYERS_IN_CHALLENGE;
		}
		return var3;
	}
	function getMapMaxTeam(var2)
	{
		var var3 = this.getValueFromSOXtra("MA").m[var2].t;
		if(var3 == undefined || _global.isNaN(var3))
		{
			return dofus.Constants.MAX_PLAYERS_IN_TEAM;
		}
		return var3;
	}
	function getMapText(var2)
	{
		return this.getValueFromSOXtra("MA").m[var2];
	}
	function getMapAreas()
	{
		return this.getValueFromSOXtra("MA").a;
	}
	function getMapSuperAreaText(var2)
	{
		return this.getValueFromSOXtra("MA").sua[var2];
	}
	function getMapAreaText(var2)
	{
		return this.getValueFromSOXtra("MA").a[var2];
	}
	function getMapSubAreas()
	{
		return this.getValueFromSOXtra("MA").sa;
	}
	function getMapSubAreaText(var2)
	{
		return this.getValueFromSOXtra("MA").sa[var2];
	}
	function getMapAreaInfos(var2)
	{
		var var3 = this.getValueFromSOXtra("MA").sa[var2];
		var var4 = this.getValueFromSOXtra("MA").a[var3.a];
		var var5 = this.getValueFromSOXtra("MA").a[var4.sua];
		return {superareaID:var4.sua,superarea:var5,areaID:var3.a,area:var4,subArea:var3};
	}
	function getItemSetText(var2)
	{
		return this.getValueFromSOXtra("IS")[var2];
	}
	function getItemStats(var2)
	{
		return this.getValueFromSOXtra("ISTA")[var2];
	}
	function getItemUnicText(var2)
	{
		return this.getValueFromSOXtra("I").u[var2];
	}
	function getItemUnics()
	{
		return this.getValueFromSOXtra("I").u;
	}
	function getItemUnicStringText()
	{
		return this.getValueFromSOXtra("I").us;
	}
	function getItemTypeText(var2)
	{
		return this.getValueFromSOXtra("I").t[var2];
	}
	function getItemSuperTypeText(var2)
	{
		return this.getValueFromSOXtra("I").st[var2];
	}
	function getAllItemTypes()
	{
		return this.getValueFromSOXtra("I").t;
	}
	function getSlotsFromSuperType(var2)
	{
		return this.getValueFromSOXtra("I").ss[var2];
	}
	function getInteractiveObjectDataByGfxText(var2)
	{
		return this.getInteractiveObjectDataText(this.getValueFromSOXtra("IO").g[var2]);
	}
	function getInteractiveObjectDataText(var2)
	{
		return this.getValueFromSOXtra("IO").d[var2];
	}
	function getHouseText(var2)
	{
		return this.getValueFromSOXtra("H").h[var2];
	}
	function getHousesMapText(var2)
	{
		return this.getValueFromSOXtra("H").m[var2];
	}
	function getHousesDoorText(var2, var3)
	{
		return this.getValueFromSOXtra("H").d[var2]["c" + var3];
	}
	function getHousesIndoorSkillsText()
	{
		return this.getValueFromSOXtra("H").ids;
	}
	function getDungeonText(var2)
	{
		return this.getValueFromSOXtra("DU")[var2];
	}
	function getSpellText(var2)
	{
		return this.getValueFromSOXtra("S")[var2];
	}
	function getSpells()
	{
		return this.getValueFromSOXtra("S");
	}
	function getEffectText(var2)
	{
		return this.getValueFromSOXtra("E")[var2];
	}
	function getBoostedDamagingEffects()
	{
		return this.getValueFromSOXtra("EDMG");
	}
	function getBoostedHealingEffects()
	{
		return this.getValueFromSOXtra("EHEL");
	}
	function getJobText(var2)
	{
		return this.getValueFromSOXtra("J")[var2];
	}
	function getCraftText(var2)
	{
		return this.getValueFromSOXtra("CR")[var2];
	}
	function getAllCrafts()
	{
		return this.getValueFromSOXtra("CR");
	}
	function getSkillText(var2)
	{
		return this.getValueFromSOXtra("SK")[var2];
	}
	function getSkillForgemagus(var2)
	{
		return Number(this.getValueFromSOXtra("SK")[var2].f);
	}
	function getDialogQuestionText(var2)
	{
		return this.getValueFromSOXtra("D").q[var2];
	}
	function getDialogResponseText(var2)
	{
		return this.getValueFromSOXtra("D").a[var2];
	}
	function getNonPlayableCharactersText(var2)
	{
		return this.getValueFromSOXtra("N").d[var2];
	}
	function getNonPlayableCharactersActionText(var2)
	{
		return this.getValueFromSOXtra("N").a[var2];
	}
	function getMonstersText(var2)
	{
		return this.getValueFromSOXtra("M")[var2];
	}
	function getMonsters()
	{
		return this.getValueFromSOXtra("M");
	}
	function getMonstersRaceText(var2)
	{
		return this.getValueFromSOXtra("MR")[var2];
	}
	function getMonstersRace()
	{
		return this.getValueFromSOXtra("MR");
	}
	function getMonstersSuperRaceText(var2)
	{
		return this.getValueFromSOXtra("MSR")[var2];
	}
	function getMonstersSuperRace()
	{
		return this.getValueFromSOXtra("MSR");
	}
	function getTimeZoneText()
	{
		return this.getValueFromSOXtra("T");
	}
	function getClassText(var2)
	{
		return this.getValueFromSOXtra("G")[var2];
	}
	function getEmoteText(var2)
	{
		return this.getValueFromSOXtra("EM")[var2];
	}
	function getEmoteID(var2)
	{
		var var3 = this.getValueFromSOXtra("EM");
		§§enumerate(var3);
		while((var var0 = §§enumeration()) != null)
		{
			if(var3[k].s == var2)
			{
				return Number(k);
			}
		}
		return null;
	}
	function getGuildBoosts(var2)
	{
		return this.getValueFromSOXtra("GU").b[var2];
	}
	function getGuildBoostsMax(var2)
	{
		return this.getValueFromSOXtra("GU").b[var2 + "m"];
	}
	function getNameText(var2)
	{
		return this.getValueFromSOXtra("NF").n[var2];
	}
	function getFirstnameText(var2)
	{
		return this.getValueFromSOXtra("NF").f[var2];
	}
	function getFullNameText(var2)
	{
		var2[0] = _global.parseInt(var2[0],36);
		var2[1] = _global.parseInt(var2[1],36);
		return this.getFirstnameText(var2[0]) + " " + this.getNameText(var2[1]);
	}
	function getRankInfos(var2)
	{
		return this.getValueFromSOXtra("R")[var2];
	}
	function getRanks(var2)
	{
		return this.getValueFromSOXtra("R");
	}
	function getAlignments()
	{
		return this.getValueFromSOXtra("A").a;
	}
	function getAlignment(var2)
	{
		return this.getValueFromSOXtra("A").a[var2];
	}
	function getAlignmentCanJoin(var2, var3)
	{
		return this.getValueFromSOXtra("A").jo[var2][var3];
	}
	function getAlignmentCanAttack(var2, var3)
	{
		return this.getValueFromSOXtra("A").at[var2][var3];
	}
	function getAlignmentSpecializations()
	{
		return this.getValueFromSOXtra("A").s;
	}
	function getAlignmentSpecialization(var2)
	{
		return this.getValueFromSOXtra("A").s[var2];
	}
	function getAlignmentOrder(var2)
	{
		return this.getValueFromSOXtra("A").o[var2];
	}
	function getAlignmentFeat(var2)
	{
		return this.getValueFromSOXtra("A").f[var2];
	}
	function getAlignmentFeatEffect(var2)
	{
		return this.getValueFromSOXtra("A").fe[var2];
	}
	function getAlignmentBalance()
	{
		return this.getValueFromSOXtra("A").b;
	}
	function getAlignmentCanViewPvpGain(var2, var3)
	{
		return this.getValueFromSOXtra("A").g[var2][var3];
	}
	function getTips()
	{
		return this.getValueFromSOXtra("TI");
	}
	function getTip(var2)
	{
		return this.getValueFromSOXtra("TI")[var2];
	}
	function getKeyboardShortcutsCategories()
	{
		return this.getValueFromSOXtra("SSC");
	}
	function getKeyboardShortcuts()
	{
		return this.getValueFromSOXtra("SH");
	}
	function getKeyboardShortcutsSets()
	{
		return this.getValueFromSOXtra("SST");
	}
	function getKeyboardShortcutsKeys(var2, var3)
	{
		return this.getValueFromSOXtra("SSK")[String(var2) + "|" + var3];
	}
	function getControlKeyString(var2)
	{
		switch(var2)
		{
			case 1:
				return this.getText("KEY_CONTROL") + "+";
			case 2:
				return this.getText("KEY_SHIFT") + "+";
			case 3:
				return this.getText("KEY_CONTROL") + "+" + this.getText("KEY_SHIFT") + "+";
			default:
				return "";
		}
	}
	function getKeyStringFromKeyCode(var2)
	{
		switch(var2)
		{
			case 112:
				return this.getText("KEY_F1");
			case 113:
				return this.getText("KEY_F2");
			case 114:
				return this.getText("KEY_F3");
			case 115:
				return this.getText("KEY_F4");
			default:
				switch(null)
				{
					case 116:
						return this.getText("KEY_F5");
					case 117:
						return this.getText("KEY_F6");
					case 118:
						return this.getText("KEY_F7");
					case 119:
						return this.getText("KEY_F8");
					default:
						switch(null)
						{
							case 120:
								return this.getText("KEY_F9");
							case 121:
								return this.getText("KEY_F10");
							case 122:
								return this.getText("KEY_F11");
							case 123:
								return this.getText("KEY_F12");
							default:
								switch(null)
								{
									case 145:
										return this.getText("KEY_SCROLL_LOCK");
									case 19:
										return this.getText("KEY_PAUSE");
									case 45:
										return this.getText("KEY_INSERT");
									case 36:
										return this.getText("KEY_HOME");
									case 33:
										return this.getText("KEY_PAGE_UP");
									default:
										switch(null)
										{
											case 34:
												return this.getText("KEY_PAGE_DOWN");
											case 35:
												return this.getText("KEY_END");
											case 37:
												return this.getText("KEY_LEFT");
											case 38:
												return this.getText("KEY_UP");
											case 39:
												return this.getText("KEY_RIGHT");
											default:
												switch(null)
												{
													case 40:
														return this.getText("KEY_DOWN");
													case 27:
														return this.getText("KEY_ESCAPE");
													case 8:
														return this.getText("KEY_BACKSPACE");
													case 20:
														return this.getText("KEY_CAPS_LOCK");
													case 13:
														return this.getText("KEY_ENTER");
													default:
														switch(null)
														{
															case 32:
																return this.getText("KEY_SPACE");
															case 46:
																return this.getText("KEY_DELETE");
															case 144:
																return this.getText("KEY_NUM_LOCK");
															case -1:
																return this.getText("KEY_UNDEFINED");
															default:
																return "(#" + String(var2) + ")";
														}
												}
										}
								}
						}
				}
		}
	}
	function getDefaultConsoleShortcuts()
	{
		return this.getValueFromSOLang("CNS");
	}
	function getServerInfos(var2)
	{
		return this.getValueFromSOXtra("SR")[var2];
	}
	function getServerPopulation(var2)
	{
		return this.getValueFromSOXtra("SRP")[var2];
	}
	function getServerPopulationWeight(var2)
	{
		return Number(this.getValueFromSOXtra("SRPW")[var2]);
	}
	function getServerCommunities()
	{
		return this.getValueFromSOLang("COM");
	}
	function getServerCommunity(var2)
	{
		return this.getValueFromSOXtra("SRC")[var2].n;
	}
	function getServerCommunityDisplayed(var2)
	{
		return this.getValueFromSOXtra("SRC")[var2].d;
	}
	function getServerSpecificTexts()
	{
		return this.getValueFromSOXtra("SRVT");
	}
	function getServerSpecificText(var2, var3)
	{
		return this.getValueFromSOXtra("SRVC")[var2 + "|" + var3];
	}
	function getQuests()
	{
		return this.getValueFromSOXtra("Q").q;
	}
	function getQuestText(var2)
	{
		return this.getQuests()[var2];
	}
	function getQuestStepText(var2)
	{
		return this.getValueFromSOXtra("Q").s[var2];
	}
	function getQuestObjectiveText(var2)
	{
		return this.getValueFromSOXtra("Q").o[var2];
	}
	function getQuestObjectiveTypeText(var2)
	{
		return this.getValueFromSOXtra("Q").t[var2];
	}
	function getState(var2)
	{
		return this.getValueFromSOXtra("ST")[var2];
	}
	function getStateText(var2)
	{
		return this.getValueFromSOXtra("ST")[var2].n;
	}
	function getGradeHonourPointsBounds(var2)
	{
		var var3 = this.getValueFromSOXtra("PP").hp;
		return {min:var3[var2 - 1],max:var3[var2]};
	}
	function getMaxDisgracePoints()
	{
		return this.getValueFromSOXtra("PP").maxdp;
	}
	function getRankLongName(var2, var3)
	{
		return this.getValueFromSOXtra("PP").grds[var2][var3].nl;
	}
	function getRankShortName(var2, var3)
	{
		return this.getValueFromSOXtra("PP").grds[var2][var3].nc;
	}
	function getHintsByMapID(var2)
	{
		return this.getHintsBy("m",var2);
	}
	function getHintsByCategory(categoryID)
	{
		return this.getHintsBy("c",categoryID);
	}
	function getHintsBy(var2, var3)
	{
		var var4 = this.getValueFromSOXtra("HI");
		var var5 = new Array();
		var var6 = 0;
		while(var6 < var4.length)
		{
			var var7 = var4[var6];
			if(var7[var2] == var3)
			{
				var5.push(var7);
			}
			var6 = var6 + 1;
		}
		return var5;
	}
	function getHintsCategory(var2)
	{
		return this.getValueFromSOXtra("HIC")[var2];
	}
	function getHintsCategories()
	{
		return this.getValueFromSOXtra("HIC");
	}
	function getMountText(var2)
	{
		return this.getValueFromSOXtra("RI")[var2];
	}
	function getMountCapacity(var2)
	{
		return this.getValueFromSOXtra("RIA")[var2];
	}
	function getKnownledgeBaseCategories()
	{
		return this.getValueFromSOXtra("KBC");
	}
	function getKnownledgeBaseCategory(var2)
	{
		return this.getValueFromSOXtra("KBC")[var2];
	}
	function getKnownledgeBaseArticles()
	{
		return this.getValueFromSOXtra("KBA");
	}
	function getKnownledgeBaseArticle(var2)
	{
		return this.getValueFromSOXtra("KBA")[var2];
	}
	function getKnownledgeBaseTriggers()
	{
		return this.getValueFromSOXtra("KBD");
	}
	function getKnownledgeBaseTip(var2)
	{
		return this.getValueFromSOXtra("KBT")[var2];
	}
	function getMusicFromKeyname(var2)
	{
		return Number(this.getValueFromSOXtra("AUMC")[var2]);
	}
	function getEffectFromKeyname(var2)
	{
		return Number(this.getValueFromSOXtra("AUEC")[var2]);
	}
	function getEnvironmentFromKeyname(var2)
	{
		return Number(this.getValueFromSOXtra("AUAC")[var2]);
	}
	function getMusic(var2)
	{
		return this.getValueFromSOXtra("AUM")[var2];
	}
	function getEffect(var2)
	{
		return this.getValueFromSOXtra("AUE")[var2];
	}
	function getEnvironment(var2)
	{
		return this.getValueFromSOXtra("AUA")[var2];
	}
	function getSubtitle(var2, var3)
	{
		return this.getValueFromSOXtra("SUB")[var2][var3];
	}
	function getTutorialText(var2)
	{
		return this.getValueFromSOXtra("SCR")[var2];
	}
	function getCensoredWords()
	{
		return this.getValueFromSOLang("CSR");
	}
	function getAbuseReasons()
	{
		return this.getValueFromSOLang("ABR");
	}
	function getSpeakingItemsTexts()
	{
		return this.getValueFromSOXtra("SIM");
	}
	function getSpeakingItemsText(var2)
	{
		return this.getValueFromSOXtra("SIM")[var2];
	}
	function getSpeakingItemsTriggers()
	{
		return this.getValueFromSOXtra("SIT");
	}
	function getSpeakingItemsTrigger(var2)
	{
		return this.getValueFromSOXtra("SIT")[var2];
	}
	function getFightChallenge(var2)
	{
		return this.getValueFromSOXtra("FC")[var2];
	}
	function getTitle(var2)
	{
		return this.getValueFromSOXtra("PT")[var2];
	}
	function getLangFileSize(var2)
	{
		var var3 = new String();
		if(var2.toUpperCase() == "LANG")
		{
			var3 = dofus.Constants.GLOBAL_SO_LANG_NAME;
		}
		else
		{
			if(var2.toUpperCase() == "TOTAL")
			{
				var var4 = this.getLangFileSize("lang");
				var var5 = _global.API.lang.getConfigText("XTRA_FILE");
				var var6 = 0;
				while(var6 < var5.length)
				{
					var4 = var4 + this.getLangFileSize(var5[var6]);
					var6 = var6 + 1;
				}
				return var4;
			}
			var3 = dofus.Constants.GLOBAL_SO_XTRA_NAME;
		}
		var var7 = _global[var3].data.WEIGHTS[var2.toUpperCase()];
		if(var7 == undefined || _global.isNaN(var7))
		{
			return 0;
		}
		return var7;
	}
	function fetchString(var2)
	{
		var var3 = new ank.utils.(var2);
		if(this.fetchIn == undefined || (this.fetchOut == undefined || this._nLastServerID != this.api.datacenter.Basics.aks_current_server.id))
		{
			this.fetchIn = new Array();
			this.fetchOut = new Array();
			var var4 = this.getServerSpecificTexts();
			this._nLastServerID = this.api.datacenter.Basics.aks_current_server.id;
			for(var var5 in var4)
			{
				if(var5 == undefined)
				{
					var5 = var4[i].d;
				}
				this.fetchIn.push("`SRVT:" + var4[i].l + "`");
				this.fetchOut.push(var5);
			}
		}
		return var3.replace(this.fetchIn,this.fetchOut);
	}
	function clearSOXtraCache()
	{
		this._aSOXtraCache = new Array();
	}
	function getValueFromSOLang(var2)
	{
		return _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[var2];
	}
	function getValueFromSOXtra(var2)
	{
		var var3 = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + var2];
		if(var3 == undefined)
		{
			_global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + var2] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + var2);
			var3 = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + var2];
		}
		var var4 = var3.data[var2];
		if(var4 instanceof Array)
		{
			if(this._aSOXtraCache[var2] == undefined)
			{
				this._aSOXtraCache[var2] = var4.slice();
			}
			return this._aSOXtraCache[var2];
		}
		return var4;
	}
}
