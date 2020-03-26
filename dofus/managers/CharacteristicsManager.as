class dofus.managers.CharacteristicsManager extends dofus.utils.ApiElement
{
   static var LIFE_POINTS = 0;
   static var ACTION_POINTS = 1;
   static var GOLD = 2;
   static var STATS_POINTS = 3;
   static var SPELL_POINTS = 4;
   static var LEVEL = 5;
   static var STRENGTH = 10;
   static var VITALITY = 11;
   static var WISDOM = 12;
   static var CHANCE = 13;
   static var AGILITY = 14;
   static var INTELLIGENCE = 15;
   static var DAMAGES = 16;
   static var DAMAGES_FACTOR = 17;
   static var DAMAGES_PERCENT = 25;
   static var CRITICAL_HIT = 18;
   static var RANGE = 19;
   static var DAMAGES_MAGICAL_REDUCTION = 20;
   static var DAMAGES_PHYSICAL_REDUCTION = 21;
   static var EXPERIENCE_BOOST = 22;
   static var MOVEMENT_POINTS = 23;
   static var INVISIBILITY = 24;
   static var MAX_SUMMONED_CREATURES_BOOST = 26;
   static var DODGE_PA_LOST_PROBABILITY = 27;
   static var DODGE_PM_LOST_PROBABILITY = 28;
   static var ENERGY_POINTS = 29;
   static var ALIGNMENT = 30;
   static var WEAPON_DAMAGES_PERCENT = 31;
   static var PHYSICAL_DAMAGES = 32;
   static var EARTH_ELEMENT_PERCENT = 33;
   static var FIRE_ELEMENT_PERCENT = 34;
   static var WATER_ELEMENT_PERCENT = 35;
   static var AIR_ELEMENT_PERCENT = 36;
   static var NEUTRAL_ELEMENT_PERCENT = 37;
   static var GFX = 38;
   static var CRITICAL_MISS = 39;
   static var INITIATIVE = 44;
   static var PROSPECTION = 48;
   static var STATE = 71;
   function CharacteristicsManager(oSprite, oAPI)
   {
      super();
      this.initialize(oSprite,oAPI);
   }
   function initialize(oSprite, oAPI)
   {
      super.initialize(oAPI);
      this._oSprite = oSprite;
      this._aEffects = new Array();
      this._aModerators = new Array(20);
      var _loc5_ = 0;
      while(_loc5_ < this._aModerators.length)
      {
         this._aModerators[_loc5_] = 0;
         _loc5_ = _loc5_ + 1;
      }
   }
   function getEffects()
   {
      return this._aEffects;
   }
   function getModeratorValue(nType)
   {
      nType = Number(nType);
      var _loc3_ = Number(this._aModerators[nType]);
      if(_global.isNaN(_loc3_))
      {
         return 0;
      }
      return _loc3_;
   }
   function addEffect(oEffect)
   {
      this._aEffects.push(oEffect);
      this.onEffectStart(oEffect);
   }
   function terminateAllEffects()
   {
      var _loc2_ = this._aEffects.length;
      while((_loc2_ = _loc2_ - 1) >= 0)
      {
         var _loc3_ = this._aEffects[_loc2_];
         this.onEffectEnd(_loc3_);
         this._aEffects.splice(_loc2_,_loc2_ + 1);
      }
   }
   function nextTurn()
   {
      var _loc2_ = this._aEffects.length;
      while((_loc2_ = _loc2_ - 1) >= 0)
      {
         var _loc3_ = this._aEffects[_loc2_];
         _loc3_.remainingTurn = _loc3_.remainingTurn - 1;
         if(_loc3_.remainingTurn <= 0)
         {
            this.onEffectEnd(_loc3_);
            this._aEffects.splice(_loc2_,1);
         }
      }
   }
   function onEffectStart(oEffect)
   {
      var _loc3_ = oEffect.characteristic;
      switch(_loc3_)
      {
         case dofus.managers.CharacteristicsManager.GFX:
            if(this._oSprite.mount != undefined)
            {
               this._oSprite.mount.chevauchorGfxID = oEffect.param2;
            }
            else
            {
               this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + oEffect.param2 + ".swf";
            }
            this._oSprite.mc.draw();
            break;
         case dofus.managers.CharacteristicsManager.INVISIBILITY:
            if(this._oSprite.id == this.api.datacenter.Player.ID)
            {
               this._oSprite.mc.setAlpha(40);
            }
            else
            {
               this._oSprite.mc.setVisible(false);
            }
            break;
         default:
            if(this._aModerators[_loc3_] == undefined)
            {
               this._aModerators[_loc3_] = 0;
            }
            this._aModerators[_loc3_] = this._aModerators[_loc3_] + Number(oEffect.getParamWithOperator(1));
      }
   }
   function onEffectEnd(oEffect)
   {
      switch(oEffect.characteristic)
      {
         case dofus.managers.CharacteristicsManager.GFX:
            if(this._oSprite.mount != undefined)
            {
               this._oSprite.mount.chevauchorGfxID = oEffect.param1;
            }
            else
            {
               this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + oEffect.param1 + ".swf";
            }
            this._oSprite.mc.draw();
            break;
         case dofus.managers.CharacteristicsManager.INVISIBILITY:
            if(this._oSprite.id == this.api.datacenter.Player.ID)
            {
               this._oSprite.mc.setAlpha(100);
            }
            else
            {
               this._oSprite.mc.setVisible(true);
            }
            break;
         default:
            this._aModerators[Number(oEffect.characteristic)] = this._aModerators[Number(oEffect.characteristic)] - Number(oEffect.getParamWithOperator(1));
      }
   }
}
