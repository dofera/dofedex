class dofus.datacenter.Spell extends Object
{
   function Spell(nID, nLevel, sCompressedPosition)
   {
      super();
      this.initialize(nID,nLevel,sCompressedPosition);
   }
   function __get__ID()
   {
      return this._nID;
   }
   function __get__isValid()
   {
      return this._oSpellText["l" + this._nLevel] != undefined;
   }
   function __get__maxLevel()
   {
      return this._nMaxLevel;
   }
   function __set__level(nLevel)
   {
      this._nLevel = nLevel;
      return this.__get__level();
   }
   function __get__level()
   {
      return this._nLevel;
   }
   function __set__position(nPosition)
   {
      this._nPosition = nPosition;
      return this.__get__position();
   }
   function __get__position()
   {
      return this._nPosition;
   }
   function __set__animID(nAnimID)
   {
      this._nAnimID = nAnimID;
      return this.__get__animID();
   }
   function __get__animID()
   {
      return this._nAnimID;
   }
   function __get__summonSpell()
   {
      return this._bSummonSpell;
   }
   function __get__glyphSpell()
   {
      return this.searchIfGlyph(this.getSpellLevelText(0));
   }
   function __get__trapSpell()
   {
      return this.searchIfTrap(this.getSpellLevelText(0));
   }
   function __set__inFrontOfSprite(bInFrontOfSprite)
   {
      this._bInFrontOfSprite = bInFrontOfSprite;
      return this.__get__inFrontOfSprite();
   }
   function __get__inFrontOfSprite()
   {
      return this._bInFrontOfSprite;
   }
   function __get__iconFile()
   {
      return dofus.Constants.SPELLS_ICONS_PATH + this._nID + ".swf";
   }
   function __get__file()
   {
      return dofus.Constants.SPELLS_PATH + this._nAnimID + ".swf";
   }
   function __get__name()
   {
      return this._oSpellText.n;
   }
   function __get__description()
   {
      return this._oSpellText.d;
   }
   function __get__apCost()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST,this._nID);
      var _loc3_ = this.getSpellLevelText(2);
      if(_loc2_ > -1)
      {
         return _loc3_ - _loc2_;
      }
      return _loc3_;
   }
   function __get__rangeMin()
   {
      return this.getSpellLevelText(3);
   }
   function __get__rangeMax()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGE,this._nID);
      var _loc3_ = this.getSpellLevelText(4);
      if(_loc2_ > -1)
      {
         return _loc3_ + _loc2_;
      }
      return _loc3_;
   }
   function __get__rangeStr()
   {
      return (this.rangeMin == 0?"":this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") + this.rangeMax;
   }
   function __get__criticalHit()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CC,this._nID);
      var _loc3_ = this.getSpellLevelText(5);
      if(_loc2_ > -1)
      {
         return _loc3_ <= 0?0:Math.max(_loc3_ - _loc2_,2);
      }
      return _loc3_;
   }
   function __get__actualCriticalHit()
   {
      return this.api.kernel.GameManager.getCriticalHitChance(this.criticalHit);
   }
   function __get__criticalFailure()
   {
      return this.getSpellLevelText(6);
   }
   function __get__lineOnly()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CASTOUTLINE,this._nID);
      var _loc3_ = this.getSpellLevelText(7);
      if(_loc2_ > 0)
      {
         return false;
      }
      return _loc3_;
   }
   function __get__lineOfSight()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_NOLINEOFSIGHT,this._nID);
      var _loc3_ = this.getSpellLevelText(8);
      if(_loc2_ > 0)
      {
         return false;
      }
      return _loc3_;
   }
   function __get__freeCell()
   {
      return this.getSpellLevelText(9);
   }
   function __get__canBoostRange()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGEABLE,this._nID);
      var _loc3_ = this.getSpellLevelText(10);
      if(_loc2_ > 0)
      {
         return true;
      }
      return _loc3_;
   }
   function __get__classID()
   {
      return this.getSpellLevelText(11);
   }
   function __get__launchCountByTurn()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTURN,this._nID);
      var _loc3_ = this.getSpellLevelText(12);
      if(_loc2_ > -1)
      {
         return _loc3_ + _loc2_;
      }
      return _loc3_;
   }
   function __get__launchCountByPlayerTurn()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTARGET,this._nID);
      var _loc3_ = this.getSpellLevelText(13);
      if(_loc2_ > -1)
      {
         return _loc3_ + _loc2_;
      }
      return _loc3_;
   }
   function __get__delayBetweenLaunch()
   {
      var _loc2_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CAST_INTVL,this._nID);
      var _loc3_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_SET_INTVL,this._nID);
      var _loc4_ = _loc3_ <= -1?this.getSpellLevelText(14):_loc3_;
      if(_loc2_ > -1)
      {
         return _loc4_ - _loc2_;
      }
      return _loc4_;
   }
   function __get__descriptionNormalHit()
   {
      return this.api.kernel.GameManager.getSpellDescriptionWithEffects(this.getSpellLevelText(0),false,this._nID);
   }
   function __get__descriptionCriticalHit()
   {
      return this.api.kernel.GameManager.getSpellDescriptionWithEffects(this.getSpellLevelText(1),false,this._nID);
   }
   function __get__effectsNormalHit()
   {
      return this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(0),this._nID);
   }
   function __get__effectsCriticalHit()
   {
      return this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(1),this._nID);
   }
   function __get__effectsNormalHitWithArea()
   {
      var _loc2_ = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(0),this._nID);
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = 0;
      var _loc5_ = 0;
      while(_loc5_ < _loc2_.length)
      {
         var _loc6_ = new Object();
         _loc6_.fx = _loc2_[_loc5_];
         _loc6_.at = this._aEffectZones[_loc4_ + _loc5_].shape;
         _loc6_.ar = this._aEffectZones[_loc4_ + _loc5_].size;
         _loc3_.push(_loc6_);
         _loc5_ = _loc5_ + 1;
      }
      return _loc3_;
   }
   function __get__effectsCriticalHitWithArea()
   {
      var _loc2_ = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(1),this._nID);
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = this.effectsNormalHit.length;
      var _loc5_ = 0;
      while(_loc5_ < _loc2_.length)
      {
         var _loc6_ = new Object();
         _loc6_.fx = _loc2_[_loc5_];
         _loc6_.at = this._aEffectZones[_loc4_ + _loc5_].shape;
         _loc6_.ar = this._aEffectZones[_loc4_ + _loc5_].size;
         _loc3_.push(_loc6_);
         _loc5_ = _loc5_ + 1;
      }
      return _loc3_;
   }
   function __get__requiredStates()
   {
      return this._aRequiredStates;
   }
   function __get__forbiddenStates()
   {
      return this._aForbiddenStates;
   }
   function __get__needStates()
   {
      return this._aRequiredStates.length > 0 || this._aForbiddenStates.length > 0;
   }
   function __get__minPlayerLevel()
   {
      return Number(this.getSpellLevelText(18));
   }
   function __get__normalMinPlayerLevel()
   {
      return Number(this.getSpellLevelText(18,1));
   }
   function __get__criticalFailureEndsTheTurn()
   {
      return this.getSpellLevelText(19);
   }
   function __get__elements()
   {
      var _loc2_ = {none:false,neutral:false,earth:false,fire:false,water:false,air:false};
      var _loc3_ = this.effectsNormalHit;
      for(var k in _loc3_)
      {
         var _loc4_ = _loc3_[k].element;
         switch(_loc4_)
         {
            case "N":
               _loc2_.neutral = true;
               break;
            case "E":
               _loc2_.earth = true;
               break;
            case "F":
               _loc2_.fire = true;
               break;
            case "W":
               _loc2_.water = true;
               break;
            case "A":
               _loc2_.air = true;
               break;
            default:
               _loc2_.none = true;
         }
      }
      return _loc2_;
   }
   function __get__effectZones()
   {
      return this._aEffectZones;
   }
   function initialize(nID, nLevel, sCompressedPosition)
   {
      this.api = _global.API;
      this._nID = nID;
      this._nLevel = nLevel;
      this._nPosition = ank.utils.Compressor.decode64(sCompressedPosition);
      if(this._nPosition > 24 || this._nPosition < 1)
      {
         this._nPosition = null;
      }
      this._oSpellText = this.api.lang.getSpellText(nID);
      var _loc5_ = this.getSpellLevelText(15);
      var _loc6_ = _loc5_.split("");
      this._aEffectZones = new Array();
      var _loc7_ = 0;
      while(_loc7_ < _loc6_.length)
      {
         this._aEffectZones.push({shape:_loc6_[_loc7_],size:ank.utils.Compressor.decode64(_loc6_[_loc7_ + 1])});
         _loc7_ = _loc7_ + 2;
      }
      this._bSummonSpell = this.searchIfSummon(this.getSpellLevelText(0)) || this.searchIfSummon(this.getSpellLevelText(1));
      this._nMaxLevel = 1;
      var _loc8_ = 1;
      while(_loc8_ <= dofus.Constants.SPELL_BOOST_MAX_LEVEL)
      {
         if(this._oSpellText["l" + _loc8_] == undefined)
         {
            break;
         }
         this._nMaxLevel = _loc8_;
         _loc8_ = _loc8_ + 1;
      }
      this._aRequiredStates = this.getSpellLevelText(16);
      this._aForbiddenStates = this.getSpellLevelText(17);
      this._minPlayerLevel = this.normalMinPlayerLevel;
   }
   function getSpellLevelText(nPropertyIndex, nLevel)
   {
      if(nLevel == undefined)
      {
         nLevel = this._nLevel;
      }
      return this._oSpellText["l" + nLevel][nPropertyIndex];
   }
   function searchIfSummon(aEffects)
   {
      var _loc3_ = aEffects.length;
      if(typeof aEffects == "object")
      {
         var _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc5_ = aEffects[_loc4_][0];
            if(_loc5_ == 180 || _loc5_ == 181)
            {
               return true;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return false;
   }
   function searchIfGlyph(aEffects)
   {
      var _loc3_ = aEffects.length;
      if(typeof aEffects == "object")
      {
         var _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc5_ = aEffects[_loc4_][0];
            if(_loc5_ == 401)
            {
               return true;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return false;
   }
   function searchIfTrap(aEffects)
   {
      var _loc3_ = aEffects.length;
      if(typeof aEffects == "object")
      {
         var _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc5_ = aEffects[_loc4_][0];
            if(_loc5_ == 400)
            {
               return true;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return false;
   }
}
