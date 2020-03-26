class dofus.datacenter.Effect extends Object
{
   var _nPropability = 0;
   var _nModificator = -1;
   function Effect(mType, mParam1, mParam2, mParam3, mParam4, mRemainingTurn, mSpellID, nModificator)
   {
      super();
      this.initialize(mType,mParam1,mParam2,mParam3,mParam4,mRemainingTurn,mSpellID,nModificator);
   }
   function __get__type()
   {
      return this._nType;
   }
   function __set__probability(nProbability)
   {
      this._nPropability = nProbability;
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
   function __set__param1(value)
   {
      this._nParam1 = value;
      return this.__get__param1();
   }
   function __get__param2()
   {
      return this._nParam2;
   }
   function __set__param2(value)
   {
      this._nParam2 = value;
      return this.__get__param2();
   }
   function __get__param3()
   {
      return this._nParam3;
   }
   function __set__param3(value)
   {
      this._nParam3 = value;
      return this.__get__param3();
   }
   function __get__param4()
   {
      return this._sParam4;
   }
   function __set__param4(value)
   {
      this._sParam4 = value;
      return this.__get__param4();
   }
   function __set__remainingTurn(nRremainingTurn)
   {
      this._nRemainingTurn = nRremainingTurn;
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
      var _loc2_ = this.api.lang.getEffectText(this._nType).d;
      var _loc3_ = [this._nParam1,this._nParam2,this._nParam3,this._sParam4];
      switch(this._nType)
      {
         case 10:
            _loc3_[2] = this.api.lang.getEmoteText(this._nParam3).n;
            break;
         case 165:
            _loc3_[0] = this.api.lang.getItemTypeText(this._nParam1).n;
            break;
         case 293:
         case 294:
         case 787:
            _loc3_[0] = this.api.lang.getSpellText(this._nParam1).n;
            break;
         case 601:
            var _loc4_ = this.api.lang.getMapText(this._nParam2);
            _loc3_[0] = this.api.lang.getMapSubAreaText(_loc4_.sa).n;
            _loc3_[1] = _loc4_.x;
            _loc3_[2] = _loc4_.y;
            break;
         case 614:
            _loc3_[0] = this._nParam3;
            _loc3_[1] = this.api.lang.getJobText(this._nParam2).n;
            break;
         case 615:
            _loc3_[2] = this.api.lang.getJobText(this._nParam3).n;
            break;
         case 616:
         case 624:
            _loc3_[2] = this.api.lang.getSpellText(this._nParam3).n;
            break;
         case 699:
            _loc3_[0] = this.api.lang.getJobText(this._nParam1).n;
            break;
         case 628:
         case 623:
            _loc3_[2] = this.api.lang.getMonstersText(this._nParam3).n;
            break;
         case 715:
            _loc3_[0] = this.api.lang.getMonstersSuperRaceText(this._nParam1).n;
            break;
         case 716:
            _loc3_[0] = this.api.lang.getMonstersRaceText(this._nParam1).n;
            break;
         case 717:
            _loc3_[0] = this.api.lang.getMonstersText(this._nParam1).n;
            break;
         case 805:
         case 808:
         case 983:
            this._nParam3 = this._nParam3 != undefined?this._nParam3:0;
            var _loc5_ = String(Math.floor(this._nParam2) / 100).split(".");
            var _loc6_ = Number(_loc5_[0]);
            var _loc7_ = this._nParam2 - _loc6_ * 100;
            var _loc8_ = String(Math.floor(this._nParam3) / 100).split(".");
            var _loc9_ = Number(_loc8_[0]);
            var _loc10_ = this._nParam3 - _loc9_ * 100;
            _loc3_[0] = ank.utils.PatternDecoder.getDescription(this.api.lang.getConfigText("DATE_FORMAT"),[this._nParam1,new ank.utils.ExtendedString(_loc6_ + 1).addLeftChar("0",2),new ank.utils.ExtendedString(_loc7_).addLeftChar("0",2),_loc9_,new ank.utils.ExtendedString(_loc10_).addLeftChar("0",2)]);
            break;
         case 806:
            if(this._nParam2 == undefined && this._nParam3 == undefined)
            {
               _loc3_[0] = this.api.lang.getText("NORMAL");
            }
            else
            {
               _loc3_[0] = this._nParam2 <= 6?this._nParam3 <= 6?this.api.lang.getText("NORMAL"):this.api.lang.getText("LEAN"):this.api.lang.getText("FAT");
            }
            break;
         case 807:
            if(this._nParam3 == undefined)
            {
               _loc3_[0] = this.api.lang.getText("NO_LAST_MEAL");
            }
            else
            {
               _loc3_[0] = this.api.lang.getItemUnicText(this._nParam3).n;
            }
            break;
         case 814:
            _loc3_[0] = this.api.lang.getItemUnicText(this._nParam3).n;
            break;
         case 950:
         case 951:
            _loc3_[2] = this.api.lang.getStateText(this._nParam3);
            break;
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGE:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGEABLE:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_DMG:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_HEAL:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CAST_INTVL:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_SET_INTVL:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CC:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CASTOUTLINE:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_NOLINEOFSIGHT:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTURN:
         case dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTARGET:
            _loc3_[0] = this.api.lang.getSpellText(Number(_loc3_[0])).n;
            break;
         case 939:
         case 940:
            var _loc11_ = new dofus.datacenter.Item(-1,Number(_loc3_[2]),1,0,"",0);
            _loc3_[2] = _loc11_.name;
            break;
         case 960:
            _loc3_[2] = this.api.lang.getAlignment(this._nParam3).n;
            break;
         case 999:
      }
      if(this.api.lang.getEffectText(this._nType).j && this.api.kernel.OptionsManager.getOption("ViewDicesDammages"))
      {
         var _loc12_ = this._sParam4.toLowerCase().split("d");
         _loc12_[1] = _loc12_[1].split("+");
         if(!(_loc12_[0] == undefined || (_loc12_[1] == undefined || (_loc12_[1][0] == undefined || _loc12_[1][0] == undefined))))
         {
            var _loc13_ = "";
            _loc13_ = _loc13_ + (!(_loc12_[0] != "0" && _loc12_[1][0] != "0")?"":_loc12_[0] + "d" + _loc12_[1][0]);
            _loc13_ = _loc13_ + (_loc12_[1][1] == "0"?"":(_loc13_ == ""?"":"+") + _loc12_[1][1]);
            _loc3_[0] = _loc13_;
            _loc3_[4] = _loc0_ = undefined;
            _loc3_[2] = _loc0_;
            _loc3_[1] = _loc0_;
         }
      }
      var _loc14_ = "";
      if(this._nPropability > 0 && this._nPropability != undefined)
      {
         _loc14_ = _loc14_ + (" - " + this.api.lang.getText("IN_CASE_PERCENT",[this._nPropability]) + ": ");
      }
      if(this._nType == 666)
      {
         _loc14_ = _loc14_ + this.api.lang.getText("DO_NOTHING");
      }
      else
      {
         var _loc15_ = ank.utils.PatternDecoder.getDescription(_loc2_,_loc3_);
         if(_loc15_ == null || _loc15_ == "null")
         {
            return new String();
         }
         if(_loc15_ != undefined)
         {
            _loc14_ = _loc14_ + _loc15_;
         }
      }
      if(this._nModificator > 0 && this.api.kernel.SpellsBoostsManager.isBoostedHealingOrDamagingEffect(this._nType))
      {
         _loc14_ = _loc14_ + (" " + this.api.lang.getText("BOOSTED_SPELLS_EFFECT_COMPLEMENT",[this._nModificator]));
      }
      var _loc16_ = this.getTurnCountStr(false);
      if(_loc16_.length == 0)
      {
         return _loc14_;
      }
      return _loc14_ + " (" + _loc16_ + ")";
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
   function initialize(mType, mParam1, mParam2, mParam3, mParam4, mRemainingTurn, mSpellID, nModificator)
   {
      this.api = _global.API;
      this._nType = Number(mType);
      this._nParam1 = !_global.isNaN(Number(mParam1))?Number(mParam1):undefined;
      this._nParam2 = !_global.isNaN(Number(mParam2))?Number(mParam2):undefined;
      this._nParam3 = !_global.isNaN(Number(mParam3))?Number(mParam3):undefined;
      this._sParam4 = mParam4;
      this._nRemainingTurn = mRemainingTurn != undefined?Number(mRemainingTurn):0;
      if(this._nRemainingTurn < 0 || this._nRemainingTurn >= 63)
      {
         this._nRemainingTurn = Number.POSITIVE_INFINITY;
      }
      this._nSpellID = Number(mSpellID);
      this._nModificator = Number(nModificator);
   }
   function getParamWithOperator(nParamID)
   {
      var _loc3_ = this.operator != "-"?1:-1;
      return this["_nParam" + nParamID] * _loc3_;
   }
   function getTurnCountStr(bShowLast)
   {
      var _loc3_ = new String();
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
         if(bShowLast)
         {
            return this.api.lang.getText("LAST_TURN");
         }
         return String(this._nRemainingTurn) + " " + this.api.lang.getText("TURN");
      }
      return this.api.lang.getText("INFINIT");
   }
}
