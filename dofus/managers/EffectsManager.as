class dofus.managers.EffectsManager extends dofus.utils.ApiElement
{
   function EffectsManager(oSprite, oAPI)
   {
      super();
      var _loc5_ = new flash.display.BitmapData();
      this.initialize(oSprite,oAPI);
   }
   function initialize(oSprite, oAPI)
   {
      super.initialize(oAPI);
      this._oSprite = oSprite;
      this._aEffects = new Array();
   }
   function getEffects()
   {
      return this._aEffects;
   }
   function addEffect(oEffect)
   {
      var _loc3_ = 0;
      while(_loc3_ < this._aEffects.length)
      {
         var _loc4_ = this._aEffects[_loc3_];
         if(_loc4_.spellID == oEffect.spellID && (_loc4_.type == oEffect.type && _loc4_.remainingTurn == oEffect.remainingTurn))
         {
            _loc4_.param1 = _loc4_.param1 + oEffect.param1;
            return undefined;
         }
         _loc3_ = _loc3_ + 1;
      }
      this._aEffects.push(oEffect);
   }
   function terminateAllEffects()
   {
      var _loc2_ = this._aEffects.length;
      while((_loc2_ = _loc2_ - 1) >= 0)
      {
         var _loc3_ = this._aEffects[_loc2_];
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
            this._aEffects.splice(_loc2_,1);
         }
      }
   }
}
