class dofus.graphics.gapi.controls.DeathCounter extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "DeathCounter";
   static var MAX_HEAD = 11;
   function DeathCounter()
   {
      super();
   }
   function __set__death(nDeath)
   {
      this._nDeath = nDeath;
      this.draw();
      return this.__get__death();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.DeathCounter.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.draw});
   }
   function draw()
   {
      if(this._nDeath == undefined || this._nDeath == 0)
      {
         return undefined;
      }
      var _loc2_ = this._nDeath <= dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD?this._nDeath:dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD;
      var _loc3_ = Math.PI / _loc2_;
      var _loc4_ = (- _loc3_) / 2;
      var _loc5_ = this._mcPlacer._width / 2;
      var _loc6_ = this._mcPlacer._height;
      var _loc7_ = this._mcPlacer._width / 2;
      var _loc8_ = this._mcPlacer._height;
      var _loc9_ = this.createEmptyMovieClip("_mcHeads",100);
      _loc9_._x = this._mcPlacer._x;
      _loc9_._y = this._mcPlacer._y;
      var _loc10_ = 0;
      while(_loc10_ < _loc2_)
      {
         var _loc11_ = _loc4_ - _loc10_ * _loc3_;
         var _loc12_ = Math.cos(_loc11_) * _loc5_ + _loc7_;
         var _loc13_ = Math.sin(_loc11_) * _loc6_ + _loc8_;
         if(_loc10_ == 0 && this._nDeath > dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD)
         {
            var _loc14_ = "_mcDeathCounterHeadMore";
         }
         else
         {
            _loc14_ = "_mcDeathCounterHead";
         }
         _loc9_.attachMovie(_loc14_,"head" + _loc10_,_loc10_,{_x:_loc12_,_y:_loc13_,_rotation:_loc11_ * 180 / Math.PI});
         _loc10_ = _loc10_ + 1;
      }
   }
}
