class dofus.graphics.battlefield.EffectsOverHead extends MovieClip
{
   static var ICON_WIDTH = 20;
   function EffectsOverHead(aEffects)
   {
      super();
      this.initialize(aEffects);
      this.draw();
   }
   function __get__height()
   {
      return 20;
   }
   function initialize(aEffects)
   {
      this.createEmptyMovieClip("_mcEffects",10);
      this._aEffects = aEffects;
   }
   function draw()
   {
      var _loc2_ = this._aEffects.length - 1;
      this._aEffectsQty = new Array();
      while(_loc2_ >= 0)
      {
         var _loc3_ = this._aEffects[_loc2_];
         if(this._aEffectsQty[_loc3_.type])
         {
            this._aEffectsQty[_loc3_.type].qty = this._aEffectsQty[_loc3_.type].qty + 1;
         }
         else
         {
            this._aEffectsQty[_loc3_.type] = {effect:_loc3_,qty:1};
         }
         _loc2_ = _loc2_ - 1;
      }
      var _loc5_ = 0;
      var _loc6_ = 0;
      for(var j in this._aEffectsQty)
      {
         _loc3_ = this._aEffectsQty[j].effect;
         var _loc7_ = new MovieClipLoader();
         _loc7_.addListener(this);
         this._mcEffects.createEmptyMovieClip("_mcEffect" + j,Number(j));
         var _loc4_ = this._mcEffects["_mcEffect" + j];
         _loc4_._x = _loc5_;
         _loc5_ = _loc5_ + dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH;
         _loc4_.effect = _loc3_;
         _loc7_.loadClip(dofus.Constants.EFFECTSICON_FILE,_loc4_);
      }
      this._x = (- _loc5_) / 2;
   }
   function onLoadInit(mc)
   {
      var _loc3_ = mc.getDepth();
      var _loc4_ = this._aEffectsQty[_loc3_].effect;
      var _loc5_ = mc.attachMovie("Icon_" + _loc4_.characteristic,"icon_mc",10);
      _loc5_.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
      var _loc6_ = (dofus.graphics.battlefield.EffectIcon)_loc5_;
      _loc6_.initialize(_loc4_.operator,this._aEffectsQty[_loc3_].qty);
      if(this._aEffectsQty[_loc3_].qty > 1)
      {
         _loc5_ = mc.attachMovie("Icon_" + _loc4_.characteristic,"icon_mc_multiple",5,{_x:3,_y:3});
         _loc5_.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
         _loc6_ = (dofus.graphics.battlefield.EffectIcon)_loc5_;
         _loc6_.initialize(_loc4_.operator,this._aEffectsQty[_loc3_].qty);
      }
   }
}
