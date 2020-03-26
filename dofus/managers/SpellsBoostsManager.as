class dofus.managers.SpellsBoostsManager extends dofus.utils.ApiElement
{
   static var ACTION_BOOST_SPELL_RANGE = 281;
   static var ACTION_BOOST_SPELL_RANGEABLE = 282;
   static var ACTION_BOOST_SPELL_DMG = 283;
   static var ACTION_BOOST_SPELL_HEAL = 284;
   static var ACTION_BOOST_SPELL_AP_COST = 285;
   static var ACTION_BOOST_SPELL_CAST_INTVL = 286;
   static var ACTION_BOOST_SPELL_CC = 287;
   static var ACTION_BOOST_SPELL_CASTOUTLINE = 288;
   static var ACTION_BOOST_SPELL_NOLINEOFSIGHT = 289;
   static var ACTION_BOOST_SPELL_MAXPERTURN = 290;
   static var ACTION_BOOST_SPELL_MAXPERTARGET = 291;
   static var ACTION_BOOST_SPELL_SET_INTVL = 292;
   static var _sSelf = null;
   function SpellsBoostsManager(oAPI)
   {
      super();
      dofus.managers.SpellsBoostsManager._sSelf = this;
      this.initialize(oAPI);
   }
   static function getInstance()
   {
      return dofus.managers.SpellsBoostsManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      this.clear();
   }
   function clear()
   {
      this._oSpellsModificators = new Object();
      delete dofus.managers.SpellsBoostsManager._aBoostedEffects;
      delete dofus.managers.SpellsBoostsManager._aDamagingEffects;
      delete dofus.managers.SpellsBoostsManager._aHealingEffects;
   }
   function getSpellModificator(actionId, spellId)
   {
      if(_global.isNaN(this._oSpellsModificators[actionId][spellId]) || this._oSpellsModificators[actionId][spellId] == undefined)
      {
         return -1;
      }
      return Number(this._oSpellsModificators[actionId][spellId]);
   }
   function setSpellModificator(actionId, spellId, modificator)
   {
      if(typeof this._oSpellsModificators[actionId] != "object" && this._oSpellsModificators[actionId] == undefined)
      {
         this._oSpellsModificators[actionId] = new Object();
      }
      this._oSpellsModificators[actionId][spellId] = modificator;
   }
   function isBoostedDamagingEffect(effectId)
   {
      if(dofus.managers.SpellsBoostsManager._aDamagingEffects == undefined)
      {
         this.computeBoostedEffectsLists();
      }
      var _loc3_ = 0;
      while(_loc3_ < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
      {
         if(dofus.managers.SpellsBoostsManager._aDamagingEffects[_loc3_] == effectId)
         {
            return true;
         }
         _loc3_ = _loc3_ + 1;
      }
      return false;
   }
   function isBoostedHealingEffect(effectId)
   {
      if(dofus.managers.SpellsBoostsManager._aHealingEffects == undefined)
      {
         this.computeBoostedEffectsLists();
      }
      var _loc3_ = 0;
      while(_loc3_ < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
      {
         if(dofus.managers.SpellsBoostsManager._aHealingEffects[_loc3_] == effectId)
         {
            return true;
         }
         _loc3_ = _loc3_ + 1;
      }
      return false;
   }
   function isBoostedHealingOrDamagingEffect(effectId)
   {
      if(dofus.managers.SpellsBoostsManager._aBoostedEffects == undefined)
      {
         this.computeBoostedEffectsLists();
      }
      var _loc3_ = 0;
      while(_loc3_ < dofus.managers.SpellsBoostsManager._aBoostedEffects.length)
      {
         if(dofus.managers.SpellsBoostsManager._aBoostedEffects[_loc3_] == effectId)
         {
            return true;
         }
         _loc3_ = _loc3_ + 1;
      }
      return false;
   }
   function computeBoostedEffectsLists()
   {
      dofus.managers.SpellsBoostsManager._aBoostedEffects = new Array();
      dofus.managers.SpellsBoostsManager._aDamagingEffects = this.api.lang.getBoostedDamagingEffects();
      dofus.managers.SpellsBoostsManager._aHealingEffects = this.api.lang.getBoostedHealingEffects();
      var _loc2_ = 0;
      while(_loc2_ < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
      {
         dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aDamagingEffects[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      var _loc3_ = 0;
      while(_loc3_ < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
      {
         dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aHealingEffects[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
   }
}
