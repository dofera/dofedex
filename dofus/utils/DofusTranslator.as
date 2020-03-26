class dofus.utils.DofusTranslator extends dofus.utils.ApiElement
{
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
   function getText(sKey, aParams)
   {
      if(aParams == undefined)
      {
         aParams = new Array();
      }
      var _loc4_ = new Array();
      var _loc5_ = new Array();
      var _loc6_ = 0;
      while(_loc6_ < aParams.length)
      {
         _loc4_.push("%" + (_loc6_ + 1));
         _loc5_.push(aParams[_loc6_]);
         _loc6_ = _loc6_ + 1;
      }
      var _loc7_ = this.getValueFromSOLang(sKey);
      if(_loc7_ == "" || _loc7_ == undefined)
      {
         return "!" + sKey + "!";
      }
      return new ank.utils.ExtendedString(_loc7_).replace(_loc4_,_loc5_);
   }
   function getConfigText(sKey)
   {
      var _loc3_ = this.getValueFromSOLang("C")[sKey];
      if(typeof _loc3_ == "string")
      {
         var _loc4_ = _loc3_;
         var _loc5_ = new ank.utils.ExtendedString(_loc4_);
         return _loc5_.replace(["%CMNT%","%CMNTT%"],[this.api.datacenter.Basics.aks_community_id,this.api.datacenter.Basics.aks_detected_country.toLowerCase()]);
      }
      return _loc3_;
   }
   function getAllMapsInfos()
   {
      return this.getValueFromSOXtra("MA").m;
   }
   function getMapMaxChallenge(nMapID)
   {
      var _loc3_ = this.getValueFromSOXtra("MA").m[nMapID].c;
      if(_loc3_ == undefined || _global.isNaN(_loc3_))
      {
         return dofus.Constants.MAX_PLAYERS_IN_CHALLENGE;
      }
      return _loc3_;
   }
   function getMapMaxTeam(nMapID)
   {
      var _loc3_ = this.getValueFromSOXtra("MA").m[nMapID].t;
      if(_loc3_ == undefined || _global.isNaN(_loc3_))
      {
         return dofus.Constants.MAX_PLAYERS_IN_TEAM;
      }
      return _loc3_;
   }
   function getMapText(sKey)
   {
      return this.getValueFromSOXtra("MA").m[sKey];
   }
   function getMapAreas()
   {
      return this.getValueFromSOXtra("MA").a;
   }
   function getMapSuperAreaText(sKey)
   {
      return this.getValueFromSOXtra("MA").sua[sKey];
   }
   function getMapAreaText(sKey)
   {
      return this.getValueFromSOXtra("MA").a[sKey];
   }
   function getMapSubAreaText(sKey)
   {
      return this.getValueFromSOXtra("MA").sa[sKey];
   }
   function getMapAreaInfos(nSubAreaID)
   {
      var _loc3_ = this.getValueFromSOXtra("MA").sa[nSubAreaID];
      var _loc4_ = this.getValueFromSOXtra("MA").a[_loc3_.a];
      var _loc5_ = this.getValueFromSOXtra("MA").a[_loc4_.sua];
      return {superareaID:_loc4_.sua,superarea:_loc5_,areaID:_loc3_.a,area:_loc4_,subArea:_loc3_};
   }
   function getItemSetText(nKey)
   {
      return this.getValueFromSOXtra("IS")[nKey];
   }
   function getItemStats(nKey)
   {
      return this.getValueFromSOXtra("ISTA")[nKey];
   }
   function getItemUnicText(nKey)
   {
      return this.getValueFromSOXtra("I").u[nKey];
   }
   function getItemUnics()
   {
      return this.getValueFromSOXtra("I").u;
   }
   function getItemUnicStringText()
   {
      return this.getValueFromSOXtra("I").us;
   }
   function getItemTypeText(nTypeID)
   {
      return this.getValueFromSOXtra("I").t[nTypeID];
   }
   function getItemSuperTypeText(nSuperTypeID)
   {
      return this.getValueFromSOXtra("I").st[nSuperTypeID];
   }
   function getAllItemTypes()
   {
      return this.getValueFromSOXtra("I").t;
   }
   function getSlotsFromSuperType(nSuperTypeID)
   {
      return this.getValueFromSOXtra("I").ss[nSuperTypeID];
   }
   function getInteractiveObjectDataByGfxText(nKey)
   {
      return this.getInteractiveObjectDataText(this.getValueFromSOXtra("IO").g[nKey]);
   }
   function getInteractiveObjectDataText(nKey)
   {
      return this.getValueFromSOXtra("IO").d[nKey];
   }
   function getHouseText(nID)
   {
      return this.getValueFromSOXtra("H").h[nID];
   }
   function getHousesMapText(nMapID)
   {
      return this.getValueFromSOXtra("H").m[nMapID];
   }
   function getHousesDoorText(nMapID, nCellNum)
   {
      return this.getValueFromSOXtra("H").d[nMapID]["c" + nCellNum];
   }
   function getHousesIndoorSkillsText()
   {
      return this.getValueFromSOXtra("H").ids;
   }
   function getDungeonText(nID)
   {
      return this.getValueFromSOXtra("DU")[nID];
   }
   function getSpellText(nSpellID)
   {
      return this.getValueFromSOXtra("S")[nSpellID];
   }
   function getEffectText(nEffectID)
   {
      return this.getValueFromSOXtra("E")[nEffectID];
   }
   function getBoostedDamagingEffects()
   {
      return this.getValueFromSOXtra("EDMG");
   }
   function getBoostedHealingEffects()
   {
      return this.getValueFromSOXtra("EHEL");
   }
   function getJobText(nJobID)
   {
      return this.getValueFromSOXtra("J")[nJobID];
   }
   function getCraftText(nID)
   {
      return this.getValueFromSOXtra("CR")[nID];
   }
   function getAllCrafts()
   {
      return this.getValueFromSOXtra("CR");
   }
   function getSkillText(nID)
   {
      return this.getValueFromSOXtra("SK")[nID];
   }
   function getSkillForgemagus(nID)
   {
      return Number(this.getValueFromSOXtra("SK")[nID].f);
   }
   function getDialogQuestionText(nQuestionID)
   {
      return this.getValueFromSOXtra("D").q[nQuestionID];
   }
   function getDialogResponseText(nAnswerID)
   {
      return this.getValueFromSOXtra("D").a[nAnswerID];
   }
   function getNonPlayableCharactersText(nNpcID)
   {
      return this.getValueFromSOXtra("N").d[nNpcID];
   }
   function getNonPlayableCharactersActionText(nActionID)
   {
      return this.getValueFromSOXtra("N").a[nActionID];
   }
   function getMonstersText(nMonsterID)
   {
      return this.getValueFromSOXtra("M")[nMonsterID];
   }
   function getMonsters()
   {
      return this.getValueFromSOXtra("M");
   }
   function getMonstersRaceText(nRaceMonsterID)
   {
      return this.getValueFromSOXtra("MR")[nRaceMonsterID];
   }
   function getMonstersRace()
   {
      return this.getValueFromSOXtra("MR");
   }
   function getMonstersSuperRaceText(nSuperRaceMonsterID)
   {
      return this.getValueFromSOXtra("MSR")[nSuperRaceMonsterID];
   }
   function getMonstersSuperRace()
   {
      return this.getValueFromSOXtra("MSR");
   }
   function getTimeZoneText()
   {
      return this.getValueFromSOXtra("T");
   }
   function getClassText(nClassID)
   {
      return this.getValueFromSOXtra("G")[nClassID];
   }
   function getEmoteText(nEmoteID)
   {
      return this.getValueFromSOXtra("EM")[nEmoteID];
   }
   function getEmoteID(sEmoteShortcut)
   {
      var _loc3_ = this.getValueFromSOXtra("EM");
      for(var k in _loc3_)
      {
         if(_loc3_[k].s == sEmoteShortcut)
         {
            return Number(k);
         }
      }
      return null;
   }
   function getGuildBoosts(sCharacteristics)
   {
      return this.getValueFromSOXtra("GU").b[sCharacteristics];
   }
   function getGuildBoostsMax(sCharacteristics)
   {
      return this.getValueFromSOXtra("GU").b[sCharacteristics + "m"];
   }
   function getNameText(nID)
   {
      return this.getValueFromSOXtra("NF").n[nID];
   }
   function getFirstnameText(nID)
   {
      return this.getValueFromSOXtra("NF").f[nID];
   }
   function getFullNameText(aIDs)
   {
      aIDs[0] = _global.parseInt(aIDs[0],36);
      aIDs[1] = _global.parseInt(aIDs[1],36);
      return this.getFirstnameText(aIDs[0]) + " " + this.getNameText(aIDs[1]);
   }
   function getRankInfos(nID)
   {
      return this.getValueFromSOXtra("R")[nID];
   }
   function getRanks(nID)
   {
      return this.getValueFromSOXtra("R");
   }
   function getAlignments()
   {
      return this.getValueFromSOXtra("A").a;
   }
   function getAlignment(nID)
   {
      return this.getValueFromSOXtra("A").a[nID];
   }
   function getAlignmentCanJoin(nIDa, nIDb)
   {
      return this.getValueFromSOXtra("A").jo[nIDa][nIDb];
   }
   function getAlignmentCanAttack(nIDa, nIDb)
   {
      return this.getValueFromSOXtra("A").at[nIDa][nIDb];
   }
   function getAlignmentSpecializations()
   {
      return this.getValueFromSOXtra("A").s;
   }
   function getAlignmentSpecialization(nID)
   {
      return this.getValueFromSOXtra("A").s[nID];
   }
   function getAlignmentOrder(nID)
   {
      return this.getValueFromSOXtra("A").o[nID];
   }
   function getAlignmentFeat(nID)
   {
      return this.getValueFromSOXtra("A").f[nID];
   }
   function getAlignmentFeatEffect(nID)
   {
      return this.getValueFromSOXtra("A").fe[nID];
   }
   function getAlignmentBalance()
   {
      return this.getValueFromSOXtra("A").b;
   }
   function getAlignmentCanViewPvpGain(nIDa, nIDb)
   {
      return this.getValueFromSOXtra("A").g[nIDa][nIDb];
   }
   function getTips()
   {
      return this.getValueFromSOXtra("TI");
   }
   function getTip(nID)
   {
      return this.getValueFromSOXtra("TI")[nID];
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
   function getKeyboardShortcutsKeys(nSetID, sShortCut)
   {
      return this.getValueFromSOXtra("SSK")[String(nSetID) + "|" + sShortCut];
   }
   function getControlKeyString(nCtrlKeyCode)
   {
      switch(nCtrlKeyCode)
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
   function getKeyStringFromKeyCode(nKeyCode)
   {
      switch(nKeyCode)
      {
         case 112:
            return this.getText("KEY_F1");
         case 113:
            return this.getText("KEY_F2");
         case 114:
            return this.getText("KEY_F3");
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
         case 19:
            return this.getText("KEY_PAUSE");
         case 45:
            return this.getText("KEY_INSERT");
         case 36:
            return this.getText("KEY_HOME");
         case 33:
            return this.getText("KEY_PAGE_UP");
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
         case 32:
            return this.getText("KEY_SPACE");
         case 46:
            return this.getText("KEY_DELETE");
         case 144:
            return this.getText("KEY_NUM_LOCK");
         case -1:
            return this.getText("KEY_UNDEFINED");
         default:
            return "(#" + String(nKeyCode) + ")";
      }
   }
   function getDefaultConsoleShortcuts()
   {
      return this.getValueFromSOLang("CNS");
   }
   function getServerInfos(nID)
   {
      return this.getValueFromSOXtra("SR")[nID];
   }
   function getServerPopulation(nID)
   {
      return this.getValueFromSOXtra("SRP")[nID];
   }
   function getServerPopulationWeight(nID)
   {
      return Number(this.getValueFromSOXtra("SRPW")[nID]);
   }
   function getServerCommunities()
   {
      return this.getValueFromSOLang("COM");
   }
   function getServerCommunity(nID)
   {
      return this.getValueFromSOXtra("SRC")[nID].n;
   }
   function getServerCommunityDisplayed(nID)
   {
      return this.getValueFromSOXtra("SRC")[nID].d;
   }
   function getServerSpecificTexts()
   {
      return this.getValueFromSOXtra("SRVT");
   }
   function getServerSpecificText(nTextID, nServerID)
   {
      return this.getValueFromSOXtra("SRVC")[nTextID + "|" + nServerID];
   }
   function getQuestText(nID)
   {
      return this.getValueFromSOXtra("Q").q[nID];
   }
   function getQuestStepText(nID)
   {
      return this.getValueFromSOXtra("Q").s[nID];
   }
   function getQuestObjectiveText(nID)
   {
      return this.getValueFromSOXtra("Q").o[nID];
   }
   function getQuestObjectiveTypeText(nID)
   {
      return this.getValueFromSOXtra("Q").t[nID];
   }
   function getState(nID)
   {
      return this.getValueFromSOXtra("ST")[nID];
   }
   function getStateText(nID)
   {
      return this.getValueFromSOXtra("ST")[nID].n;
   }
   function getGradeHonourPointsBounds(g)
   {
      var _loc3_ = this.getValueFromSOXtra("PP").hp;
      return {min:_loc3_[g - 1],max:_loc3_[g]};
   }
   function getMaxDisgracePoints()
   {
      return this.getValueFromSOXtra("PP").maxdp;
   }
   function getRankLongName(nSide, nRank)
   {
      return this.getValueFromSOXtra("PP").grds[nSide][nRank].nl;
   }
   function getRankShortName(nSide, nRank)
   {
      return this.getValueFromSOXtra("PP").grds[nSide][nRank].nc;
   }
   function getHintsByMapID(mapID)
   {
      return this.getHintsBy("m",mapID);
   }
   function getHintsByCategory(categoryID)
   {
      return this.getHintsBy("c",categoryID);
   }
   function getHintsBy(prop, value)
   {
      var _loc4_ = this.getValueFromSOXtra("HI");
      var _loc5_ = new Array();
      var _loc6_ = 0;
      while(_loc6_ < _loc4_.length)
      {
         var _loc7_ = _loc4_[_loc6_];
         if(_loc7_[prop] == value)
         {
            _loc5_.push(_loc7_);
         }
         _loc6_ = _loc6_ + 1;
      }
      return _loc5_;
   }
   function getHintsCategory(nID)
   {
      return this.getValueFromSOXtra("HIC")[nID];
   }
   function getHintsCategories()
   {
      return this.getValueFromSOXtra("HIC");
   }
   function getMountText(nID)
   {
      return this.getValueFromSOXtra("RI")[nID];
   }
   function getMountCapacity(nID)
   {
      return this.getValueFromSOXtra("RIA")[nID];
   }
   function getKnownledgeBaseCategories()
   {
      return this.getValueFromSOXtra("KBC");
   }
   function getKnownledgeBaseCategory(nID)
   {
      return this.getValueFromSOXtra("KBC")[nID];
   }
   function getKnownledgeBaseArticles()
   {
      return this.getValueFromSOXtra("KBA");
   }
   function getKnownledgeBaseArticle(nID)
   {
      return this.getValueFromSOXtra("KBA")[nID];
   }
   function getKnownledgeBaseTriggers()
   {
      return this.getValueFromSOXtra("KBD");
   }
   function getKnownledgeBaseTip(nTipID)
   {
      return this.getValueFromSOXtra("KBT")[nTipID];
   }
   function getMusicFromKeyname(sKeyName)
   {
      return Number(this.getValueFromSOXtra("AUMC")[sKeyName]);
   }
   function getEffectFromKeyname(sKeyName)
   {
      return Number(this.getValueFromSOXtra("AUEC")[sKeyName]);
   }
   function getEnvironmentFromKeyname(sKeyName)
   {
      return Number(this.getValueFromSOXtra("AUAC")[sKeyName]);
   }
   function getMusic(nMusic)
   {
      return this.getValueFromSOXtra("AUM")[nMusic];
   }
   function getEffect(nEffect)
   {
      return this.getValueFromSOXtra("AUE")[nEffect];
   }
   function getEnvironment(nEnvironment)
   {
      return this.getValueFromSOXtra("AUA")[nEnvironment];
   }
   function getSubtitle(nTrailer, nIndex)
   {
      return this.getValueFromSOXtra("SUB")[nTrailer][nIndex];
   }
   function getTutorialText(nTextID)
   {
      return this.getValueFromSOXtra("SCR")[nTextID];
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
   function getSpeakingItemsText(nID)
   {
      return this.getValueFromSOXtra("SIM")[nID];
   }
   function getSpeakingItemsTriggers()
   {
      return this.getValueFromSOXtra("SIT");
   }
   function getSpeakingItemsTrigger(nID)
   {
      return this.getValueFromSOXtra("SIT")[nID];
   }
   function getFightChallenge(nID)
   {
      return this.getValueFromSOXtra("FC")[nID];
   }
   function getTitle(nID)
   {
      return this.getValueFromSOXtra("PT")[nID];
   }
   function getLangFileSize(sLangFile)
   {
      var _loc3_ = new String();
      if(sLangFile.toUpperCase() == "LANG")
      {
         _loc3_ = dofus.Constants.GLOBAL_SO_LANG_NAME;
      }
      else
      {
         if(sLangFile.toUpperCase() == "TOTAL")
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
      var _loc7_ = _global[_loc3_].data.WEIGHTS[sLangFile.toUpperCase()];
      if(_loc7_ == undefined || _global.isNaN(_loc7_))
      {
         return 0;
      }
      return _loc7_;
   }
   function fetchString(s)
   {
      var _loc3_ = new ank.utils.ExtendedString(s);
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
   function getValueFromSOLang(sKey)
   {
      var _loc3_ = _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[sKey];
      var _loc4_ = _loc3_.slice();
      if(_loc4_ != undefined)
      {
         return _loc4_;
      }
      return _loc3_;
   }
   function getValueFromSOXtra(sKey)
   {
      var _loc3_ = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey];
      if(_loc3_ == undefined)
      {
         _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey);
         _loc3_ = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey];
      }
      var _loc4_ = _loc3_.data[sKey];
      var _loc5_ = _loc4_.slice();
      if(_loc5_ != undefined)
      {
         return _loc5_;
      }
      return _loc4_;
   }
}
