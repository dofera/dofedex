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
	function getText(_loc2_, _loc3_)
	{
		if(_loc3_ == undefined)
		{
			_loc3_ = new Array();
		}
		var _loc4_ = new Array();
		var _loc5_ = new Array();
		var _loc6_ = 0;
		while(_loc6_ < _loc3_.length)
		{
			_loc4_.push("%" + (_loc6_ + 1));
			_loc5_.push(_loc3_[_loc6_]);
			_loc6_ = _loc6_ + 1;
		}
		var _loc7_ = this.getValueFromSOLang(_loc2_);
		if(_loc7_ == "" || _loc7_ == undefined)
		{
			return "!" + _loc2_ + "!";
		}
		return new ank.utils.(_loc7_).replace(_loc4_,_loc5_);
	}
	function getConfigText(_loc2_)
	{
		var _loc3_ = this.getValueFromSOLang("C")[_loc2_];
		if(typeof _loc3_ == "string")
		{
			var _loc4_ = _loc3_;
			var _loc5_ = new ank.utils.(_loc4_);
			return _loc5_.replace(["%CMNT%","%CMNTT%"],[this.api.datacenter.Basics.aks_community_id,this.api.datacenter.Basics.aks_detected_country.toLowerCase()]);
		}
		return _loc3_;
	}
	function getAllMapsInfos()
	{
		return this.getValueFromSOXtra("MA").m;
	}
	function getMapMaxChallenge(_loc2_)
	{
		var _loc3_ = this.getValueFromSOXtra("MA").m[_loc2_].c;
		if(_loc3_ == undefined || _global.isNaN(_loc3_))
		{
			return dofus.Constants.MAX_PLAYERS_IN_CHALLENGE;
		}
		return _loc3_;
	}
	function getMapMaxTeam(_loc2_)
	{
		var _loc3_ = this.getValueFromSOXtra("MA").m[_loc2_].t;
		if(_loc3_ == undefined || _global.isNaN(_loc3_))
		{
			return dofus.Constants.MAX_PLAYERS_IN_TEAM;
		}
		return _loc3_;
	}
	function getMapText(_loc2_)
	{
		return this.getValueFromSOXtra("MA").m[_loc2_];
	}
	function getMapAreas()
	{
		return this.getValueFromSOXtra("MA").a;
	}
	function getMapSuperAreaText(_loc2_)
	{
		return this.getValueFromSOXtra("MA").sua[_loc2_];
	}
	function getMapAreaText(_loc2_)
	{
		return this.getValueFromSOXtra("MA").a[_loc2_];
	}
	function getMapSubAreas()
	{
		return this.getValueFromSOXtra("MA").sa;
	}
	function getMapSubAreaText(_loc2_)
	{
		return this.getValueFromSOXtra("MA").sa[_loc2_];
	}
	function getMapAreaInfos(_loc2_)
	{
		var _loc3_ = this.getValueFromSOXtra("MA").sa[_loc2_];
		var _loc4_ = this.getValueFromSOXtra("MA").a[_loc3_.a];
		var _loc5_ = this.getValueFromSOXtra("MA").a[_loc4_.sua];
		return {superareaID:_loc4_.sua,superarea:_loc5_,areaID:_loc3_.a,area:_loc4_,subArea:_loc3_};
	}
	function getItemSetText(_loc2_)
	{
		return this.getValueFromSOXtra("IS")[_loc2_];
	}
	function getItemStats(_loc2_)
	{
		return this.getValueFromSOXtra("ISTA")[_loc2_];
	}
	function getItemUnicText(_loc2_)
	{
		return this.getValueFromSOXtra("I").u[_loc2_];
	}
	function getItemUnics()
	{
		return this.getValueFromSOXtra("I").u;
	}
	function getItemUnicStringText()
	{
		return this.getValueFromSOXtra("I").us;
	}
	function getItemTypeText(_loc2_)
	{
		return this.getValueFromSOXtra("I").t[_loc2_];
	}
	function getItemSuperTypeText(_loc2_)
	{
		return this.getValueFromSOXtra("I").st[_loc2_];
	}
	function getAllItemTypes()
	{
		return this.getValueFromSOXtra("I").t;
	}
	function getSlotsFromSuperType(_loc2_)
	{
		return this.getValueFromSOXtra("I").ss[_loc2_];
	}
	function getInteractiveObjectDataByGfxText(_loc2_)
	{
		return this.getInteractiveObjectDataText(this.getValueFromSOXtra("IO").g[_loc2_]);
	}
	function getInteractiveObjectDataText(_loc2_)
	{
		return this.getValueFromSOXtra("IO").d[_loc2_];
	}
	function getHouseText(_loc2_)
	{
		return this.getValueFromSOXtra("H").h[_loc2_];
	}
	function getHousesMapText(_loc2_)
	{
		return this.getValueFromSOXtra("H").m[_loc2_];
	}
	function getHousesDoorText(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("H").d[_loc2_]["c" + _loc3_];
	}
	function getHousesIndoorSkillsText()
	{
		return this.getValueFromSOXtra("H").ids;
	}
	function getDungeonText(_loc2_)
	{
		return this.getValueFromSOXtra("DU")[_loc2_];
	}
	function getSpellText(_loc2_)
	{
		return this.getValueFromSOXtra("S")[_loc2_];
	}
	function getSpells()
	{
		return this.getValueFromSOXtra("S");
	}
	function getEffectText(_loc2_)
	{
		return this.getValueFromSOXtra("E")[_loc2_];
	}
	function getBoostedDamagingEffects()
	{
		return this.getValueFromSOXtra("EDMG");
	}
	function getBoostedHealingEffects()
	{
		return this.getValueFromSOXtra("EHEL");
	}
	function getJobText(_loc2_)
	{
		return this.getValueFromSOXtra("J")[_loc2_];
	}
	function getCraftText(_loc2_)
	{
		return this.getValueFromSOXtra("CR")[_loc2_];
	}
	function getAllCrafts()
	{
		return this.getValueFromSOXtra("CR");
	}
	function getSkillText(_loc2_)
	{
		return this.getValueFromSOXtra("SK")[_loc2_];
	}
	function getSkillForgemagus(_loc2_)
	{
		return Number(this.getValueFromSOXtra("SK")[_loc2_].f);
	}
	function getDialogQuestionText(_loc2_)
	{
		return this.getValueFromSOXtra("D").q[_loc2_];
	}
	function getDialogResponseText(_loc2_)
	{
		return this.getValueFromSOXtra("D").a[_loc2_];
	}
	function getNonPlayableCharactersText(_loc2_)
	{
		return this.getValueFromSOXtra("N").d[_loc2_];
	}
	function getNonPlayableCharactersActionText(_loc2_)
	{
		return this.getValueFromSOXtra("N").a[_loc2_];
	}
	function getMonstersText(_loc2_)
	{
		return this.getValueFromSOXtra("M")[_loc2_];
	}
	function getMonsters()
	{
		return this.getValueFromSOXtra("M");
	}
	function getMonstersRaceText(_loc2_)
	{
		return this.getValueFromSOXtra("MR")[_loc2_];
	}
	function getMonstersRace()
	{
		return this.getValueFromSOXtra("MR");
	}
	function getMonstersSuperRaceText(_loc2_)
	{
		return this.getValueFromSOXtra("MSR")[_loc2_];
	}
	function getMonstersSuperRace()
	{
		return this.getValueFromSOXtra("MSR");
	}
	function getTimeZoneText()
	{
		return this.getValueFromSOXtra("T");
	}
	function getClassText(_loc2_)
	{
		return this.getValueFromSOXtra("G")[_loc2_];
	}
	function getEmoteText(_loc2_)
	{
		return this.getValueFromSOXtra("EM")[_loc2_];
	}
	function getEmoteID(_loc2_)
	{
		var _loc3_ = this.getValueFromSOXtra("EM");
		§§enumerate(_loc3_);
		while((var _loc0_ = §§enumeration()) != null)
		{
			if(_loc3_[k].s == _loc2_)
			{
				return Number(k);
			}
		}
		return null;
	}
	function getGuildBoosts(_loc2_)
	{
		return this.getValueFromSOXtra("GU").b[_loc2_];
	}
	function getGuildBoostsMax(_loc2_)
	{
		return this.getValueFromSOXtra("GU").b[_loc2_ + "m"];
	}
	function getNameText(_loc2_)
	{
		return this.getValueFromSOXtra("NF").n[_loc2_];
	}
	function getFirstnameText(_loc2_)
	{
		return this.getValueFromSOXtra("NF").f[_loc2_];
	}
	function getFullNameText(_loc2_)
	{
		_loc2_[0] = _global.parseInt(_loc2_[0],36);
		_loc2_[1] = _global.parseInt(_loc2_[1],36);
		return this.getFirstnameText(_loc2_[0]) + " " + this.getNameText(_loc2_[1]);
	}
	function getRankInfos(_loc2_)
	{
		return this.getValueFromSOXtra("R")[_loc2_];
	}
	function getRanks(_loc2_)
	{
		return this.getValueFromSOXtra("R");
	}
	function getAlignments()
	{
		return this.getValueFromSOXtra("A").a;
	}
	function getAlignment(_loc2_)
	{
		return this.getValueFromSOXtra("A").a[_loc2_];
	}
	function getAlignmentCanJoin(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("A").jo[_loc2_][_loc3_];
	}
	function getAlignmentCanAttack(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("A").at[_loc2_][_loc3_];
	}
	function getAlignmentSpecializations()
	{
		return this.getValueFromSOXtra("A").s;
	}
	function getAlignmentSpecialization(_loc2_)
	{
		return this.getValueFromSOXtra("A").s[_loc2_];
	}
	function getAlignmentOrder(_loc2_)
	{
		return this.getValueFromSOXtra("A").o[_loc2_];
	}
	function getAlignmentFeat(_loc2_)
	{
		return this.getValueFromSOXtra("A").f[_loc2_];
	}
	function getAlignmentFeatEffect(_loc2_)
	{
		return this.getValueFromSOXtra("A").fe[_loc2_];
	}
	function getAlignmentBalance()
	{
		return this.getValueFromSOXtra("A").b;
	}
	function getAlignmentCanViewPvpGain(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("A").g[_loc2_][_loc3_];
	}
	function getTips()
	{
		return this.getValueFromSOXtra("TI");
	}
	function getTip(_loc2_)
	{
		return this.getValueFromSOXtra("TI")[_loc2_];
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
	function getKeyboardShortcutsKeys(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("SSK")[String(_loc2_) + "|" + _loc3_];
	}
	function getControlKeyString(_loc2_)
	{
		switch(_loc2_)
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
	function getKeyStringFromKeyCode(_loc2_)
	{
		switch(_loc2_)
		{
			case 112:
				return this.getText("KEY_F1");
			case 113:
				return this.getText("KEY_F2");
			case 114:
				return this.getText("KEY_F3");
			default:
				switch(null)
				{
					case 115:
						return this.getText("KEY_F4");
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
							case 145:
								return this.getText("KEY_SCROLL_LOCK");
							default:
								switch(null)
								{
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
											default:
												switch(null)
												{
													case 39:
														return this.getText("KEY_RIGHT");
													case 40:
														return this.getText("KEY_DOWN");
													case 27:
														return this.getText("KEY_ESCAPE");
													case 8:
														return this.getText("KEY_BACKSPACE");
													case 20:
														return this.getText("KEY_CAPS_LOCK");
													default:
														switch(null)
														{
															case 13:
																return this.getText("KEY_ENTER");
															case 32:
																return this.getText("KEY_SPACE");
															case 46:
																return this.getText("KEY_DELETE");
															case 144:
																return this.getText("KEY_NUM_LOCK");
															case -1:
																return this.getText("KEY_UNDEFINED");
															default:
																return "(#" + String(_loc2_) + ")";
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
	function getServerInfos(_loc2_)
	{
		return this.getValueFromSOXtra("SR")[_loc2_];
	}
	function getServerPopulation(_loc2_)
	{
		return this.getValueFromSOXtra("SRP")[_loc2_];
	}
	function getServerPopulationWeight(_loc2_)
	{
		return Number(this.getValueFromSOXtra("SRPW")[_loc2_]);
	}
	function getServerCommunities()
	{
		return this.getValueFromSOLang("COM");
	}
	function getServerCommunity(_loc2_)
	{
		return this.getValueFromSOXtra("SRC")[_loc2_].n;
	}
	function getServerCommunityDisplayed(_loc2_)
	{
		return this.getValueFromSOXtra("SRC")[_loc2_].d;
	}
	function getServerSpecificTexts()
	{
		return this.getValueFromSOXtra("SRVT");
	}
	function getServerSpecificText(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("SRVC")[_loc2_ + "|" + _loc3_];
	}
	function getQuestText(_loc2_)
	{
		return this.getValueFromSOXtra("Q").q[_loc2_];
	}
	function getQuestStepText(_loc2_)
	{
		return this.getValueFromSOXtra("Q").s[_loc2_];
	}
	function getQuestObjectiveText(_loc2_)
	{
		return this.getValueFromSOXtra("Q").o[_loc2_];
	}
	function getQuestObjectiveTypeText(_loc2_)
	{
		return this.getValueFromSOXtra("Q").t[_loc2_];
	}
	function getState(_loc2_)
	{
		return this.getValueFromSOXtra("ST")[_loc2_];
	}
	function getStateText(_loc2_)
	{
		return this.getValueFromSOXtra("ST")[_loc2_].n;
	}
	function getGradeHonourPointsBounds(_loc2_)
	{
		var _loc3_ = this.getValueFromSOXtra("PP").hp;
		return {min:_loc3_[_loc2_ - 1],max:_loc3_[_loc2_]};
	}
	function getMaxDisgracePoints()
	{
		return this.getValueFromSOXtra("PP").maxdp;
	}
	function getRankLongName(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("PP").grds[_loc2_][_loc3_].nl;
	}
	function getRankShortName(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("PP").grds[_loc2_][_loc3_].nc;
	}
	function getHintsByMapID(_loc2_)
	{
		return this.getHintsBy("m",_loc2_);
	}
	function getHintsByCategory(categoryID)
	{
		return this.getHintsBy("c",categoryID);
	}
	function getHintsBy(_loc2_, _loc3_)
	{
		var _loc4_ = this.getValueFromSOXtra("HI");
		var _loc5_ = new Array();
		var _loc6_ = 0;
		while(_loc6_ < _loc4_.length)
		{
			var _loc7_ = _loc4_[_loc6_];
			if(_loc7_[_loc2_] == _loc3_)
			{
				_loc5_.push(_loc7_);
			}
			_loc6_ = _loc6_ + 1;
		}
		return _loc5_;
	}
	function getHintsCategory(_loc2_)
	{
		return this.getValueFromSOXtra("HIC")[_loc2_];
	}
	function getHintsCategories()
	{
		return this.getValueFromSOXtra("HIC");
	}
	function getMountText(_loc2_)
	{
		return this.getValueFromSOXtra("RI")[_loc2_];
	}
	function getMountCapacity(_loc2_)
	{
		return this.getValueFromSOXtra("RIA")[_loc2_];
	}
	function getKnownledgeBaseCategories()
	{
		return this.getValueFromSOXtra("KBC");
	}
	function getKnownledgeBaseCategory(_loc2_)
	{
		return this.getValueFromSOXtra("KBC")[_loc2_];
	}
	function getKnownledgeBaseArticles()
	{
		return this.getValueFromSOXtra("KBA");
	}
	function getKnownledgeBaseArticle(_loc2_)
	{
		return this.getValueFromSOXtra("KBA")[_loc2_];
	}
	function getKnownledgeBaseTriggers()
	{
		return this.getValueFromSOXtra("KBD");
	}
	function getKnownledgeBaseTip(_loc2_)
	{
		return this.getValueFromSOXtra("KBT")[_loc2_];
	}
	function getMusicFromKeyname(_loc2_)
	{
		return Number(this.getValueFromSOXtra("AUMC")[_loc2_]);
	}
	function getEffectFromKeyname(_loc2_)
	{
		return Number(this.getValueFromSOXtra("AUEC")[_loc2_]);
	}
	function getEnvironmentFromKeyname(_loc2_)
	{
		return Number(this.getValueFromSOXtra("AUAC")[_loc2_]);
	}
	function getMusic(_loc2_)
	{
		return this.getValueFromSOXtra("AUM")[_loc2_];
	}
	function getEffect(_loc2_)
	{
		return this.getValueFromSOXtra("AUE")[_loc2_];
	}
	function getEnvironment(_loc2_)
	{
		return this.getValueFromSOXtra("AUA")[_loc2_];
	}
	function getSubtitle(_loc2_, _loc3_)
	{
		return this.getValueFromSOXtra("SUB")[_loc2_][_loc3_];
	}
	function getTutorialText(_loc2_)
	{
		return this.getValueFromSOXtra("SCR")[_loc2_];
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
	function getSpeakingItemsText(_loc2_)
	{
		return this.getValueFromSOXtra("SIM")[_loc2_];
	}
	function getSpeakingItemsTriggers()
	{
		return this.getValueFromSOXtra("SIT");
	}
	function getSpeakingItemsTrigger(_loc2_)
	{
		return this.getValueFromSOXtra("SIT")[_loc2_];
	}
	function getFightChallenge(_loc2_)
	{
		return this.getValueFromSOXtra("FC")[_loc2_];
	}
	function getTitle(_loc2_)
	{
		return this.getValueFromSOXtra("PT")[_loc2_];
	}
	function getLangFileSize(_loc2_)
	{
		var _loc3_ = new String();
		if(_loc2_.toUpperCase() == "LANG")
		{
			_loc3_ = dofus.Constants.GLOBAL_SO_LANG_NAME;
		}
		else
		{
			if(_loc2_.toUpperCase() == "TOTAL")
			{
				var _loc4_ = this.getLangFileSize("lang");
				var _loc5_ = _global.API.lang.getConfigText("XTRA_FILE");
				var _loc6_ = 0;
				while(_loc6_ < _loc5_.length)
				{
					_loc4_ = _loc4_ + this.getLangFileSize(_loc5_[_loc6_]);
					_loc6_ = _loc6_ + 1;
				}
				return _loc4_;
			}
			_loc3_ = dofus.Constants.GLOBAL_SO_XTRA_NAME;
		}
		var _loc7_ = _global[_loc3_].data.WEIGHTS[_loc2_.toUpperCase()];
		if(_loc7_ == undefined || _global.isNaN(_loc7_))
		{
			return 0;
		}
		return _loc7_;
	}
	function fetchString(_loc2_)
	{
		var _loc3_ = new ank.utils.(_loc2_);
		if(this.fetchIn == undefined || (this.fetchOut == undefined || this._nLastServerID != this.api.datacenter.Basics.aks_current_server.id))
		{
			this.fetchIn = new Array();
			this.fetchOut = new Array();
			var _loc4_ = this.getServerSpecificTexts();
			this._nLastServerID = this.api.datacenter.Basics.aks_current_server.id;
			for(var i in _loc4_)
			{
				var _loc5_ = this.getServerSpecificText(Number(i),this._nLastServerID);
				if(_loc5_ == undefined)
				{
					_loc5_ = _loc4_[i].d;
				}
				this.fetchIn.push("`SRVT:" + _loc4_[i].l + "`");
				this.fetchOut.push(_loc5_);
			}
		}
		return _loc3_.replace(this.fetchIn,this.fetchOut);
	}
	function clearSOXtraCache()
	{
		this._aSOXtraCache = new Array();
	}
	function getValueFromSOLang(_loc2_)
	{
		return _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[_loc2_];
	}
	function getValueFromSOXtra(_loc2_)
	{
		var _loc3_ = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + _loc2_];
		if(_loc3_ == undefined)
		{
			_global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + _loc2_] = ank.utils.Sequencer.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + _loc2_);
			_loc3_ = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + _loc2_];
		}
		var _loc4_ = _loc3_.data[_loc2_];
		if(_loc4_ instanceof Array)
		{
			if(this._aSOXtraCache[_loc2_] == undefined)
			{
				this._aSOXtraCache[_loc2_] = _loc4_.slice();
			}
			return this._aSOXtraCache[_loc2_];
		}
		return _loc4_;
	}
}
