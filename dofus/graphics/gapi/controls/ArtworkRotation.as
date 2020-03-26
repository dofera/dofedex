class dofus.graphics.gapi.controls.ArtworkRotation extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ArtworkRotationItem";
   function ArtworkRotation()
   {
      super();
   }
   function __set__classID(nClassID)
   {
      this._ariMan.loadArtwork(nClassID);
      this._ariWoman.loadArtwork(nClassID);
      return this.__get__classID();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ArtworkRotation.CLASS_NAME);
   }
   function createChildren()
   {
      this._i = 2.02;
   }
   function setPosition(nSex)
   {
      if(this._nCurrentSex == nSex)
      {
         return undefined;
      }
      this._nCurrentSex = nSex;
      var _loc3_ = nSex == 0;
      this._ariWoman.colorize(_loc3_);
      this._ariMan.colorize(!_loc3_);
      if(!_loc3_)
      {
         this._ariMan.swapDepths(this._ariWoman);
      }
      this._i = !_loc3_?5.13:2;
      var _loc4_ = -30.4 * (!_loc3_?1:-1);
      var _loc5_ = 28.7 * (!_loc3_?1:-1);
      var _loc6_ = -45.6 * (!_loc3_?1:-1);
      this._ariMan._x = _loc5_;
      this._ariMan._y = _loc6_;
      this._ariWoman._x = - _loc5_;
      this._ariWoman._y = - _loc6_;
      this._ariMan._xscale = 100 + _loc4_;
      this._ariMan._yscale = 100 + _loc4_;
      this._ariWoman._xscale = 100 - _loc4_;
      this._ariWoman._yscale = 100 - _loc4_;
   }
   function rotate(nSex)
   {
      if(this._nCurrentSex == nSex)
      {
         return undefined;
      }
      this._nCurrentSex = nSex;
      var piy = 0;
      var px = 0;
      var py = 0;
      var t = 0;
      var bSwaped = false;
      var _loc3_ = nSex == 0;
      this._ariWoman.colorize(_loc3_);
      this._ariMan.colorize(!_loc3_);
      this._di = !_loc3_?2 + Math.PI:2;
      this.onEnterFrame = function()
      {
         if(Math.abs(this._i - this._di) > 0.01)
         {
            this._i = this._i - (this._i - this._di) / 3;
            piy = py;
            px = 70 * Math.cos(this._i);
            py = 50 * Math.sin(this._i);
            if(piy < 0 && py >= 0 || piy >= 0 && py < 0)
            {
               if(!bSwaped)
               {
                  this._ariMan.swapDepths(this._ariWoman);
                  bSwaped = true;
               }
            }
            t = py / 1.5;
            this._ariMan._x = px;
            this._ariMan._y = py;
            this._ariWoman._x = - px;
            this._ariWoman._y = - py;
            this._ariMan._xscale = 100 + t;
            this._ariMan._yscale = 100 + t;
            this._ariWoman._xscale = 100 - t;
            this._ariWoman._yscale = 100 - t;
         }
         else
         {
            delete this.onEnterFrame;
         }
      };
   }
}
