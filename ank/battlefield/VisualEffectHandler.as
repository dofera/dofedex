class ank.battlefield.VisualEffectHandler
{
   static var MAX_INDEX = 21;
   function VisualEffectHandler(b, c)
   {
      this.initialize(b,c);
   }
   function initialize(b, c)
   {
      this._mcBattlefield = b;
      this._mcContainer = c;
      this.clear();
   }
   function clear(Void)
   {
      this._incIndex = 0;
   }
   function addEffect(sprite, oVisualEffect, nCellNum, displayType, targetSprite, bVisible)
   {
      if(displayType < 10)
      {
         return undefined;
      }
      var _loc8_ = !oVisualEffect.bInFrontOfSprite?-1:1;
      var _loc9_ = this.getNextIndex() + ank.battlefield.Constants.MAX_SPRITES_ON_CELL / 2 + 1;
      this._mcContainer["eff" + _loc9_].removeMovieClip();
      this._mcContainer.createEmptyMovieClip("eff" + _loc9_,nCellNum * 100 + 50 + _loc8_ * _loc9_);
      var _loc10_ = this._mcContainer["eff" + _loc9_];
      _loc10_.createEmptyMovieClip("mc",10);
      _loc10_._visible = bVisible != undefined?bVisible:true;
      var _loc11_ = new MovieClipLoader();
      _loc11_.addListener(this);
      _loc10_.sprite = sprite;
      _loc10_.targetSprite = targetSprite;
      _loc10_.cellNum = nCellNum;
      _loc10_.displayType = displayType;
      _loc10_.level = oVisualEffect.level;
      _loc10_.params = oVisualEffect.params;
      if(oVisualEffect.bTryToBypassContainerColor == true)
      {
         var _loc12_ = new Color(_loc10_);
         _loc12_.setTransform({ra:200,rb:0,ga:200,gb:0,ba:200,bb:0});
      }
      _loc11_.loadClip(oVisualEffect.file,_loc10_.mc);
      ank.utils.Timer.setTimer(_loc10_,"battlefield",_loc10_,_loc10_.removeMovieClip,ank.battlefield.Constants.VISUAL_EFFECT_MAX_TIMER);
   }
   function onLoadInit(mc)
   {
      var _loc3_ = mc._parent.sprite;
      var _loc4_ = mc._parent.targetSprite;
      var _loc5_ = mc._parent.cellNum;
      var displayType = mc._parent.displayType;
      var _loc6_ = mc._parent.level;
      var _loc7_ = mc._parent.params;
      var _loc8_ = mc._parent.ignoreTargetInHeight;
      var _loc9_ = _loc3_.cellNum;
      var _loc10_ = this._mcBattlefield.mapHandler.getCellData(_loc9_);
      var _loc11_ = this._mcBattlefield.mapHandler.getCellData(_loc5_);
      var _loc12_ = !!_loc3_?{x:_loc3_.mc._x,y:_loc3_.mc._y}:{x:_loc10_.x,y:_loc10_.y};
      var _loc13_ = !!_loc4_?{x:_loc4_.mc._x,y:_loc4_.mc._y}:{x:_loc11_.x,y:_loc11_.y};
      mc._ACTION = _loc3_;
      mc.level = _loc6_;
      mc.angle = Math.atan2(_loc13_.y - _loc12_.y,_loc13_.x - _loc12_.x) * 180 / Math.PI;
      mc.params = _loc7_;
      switch(displayType)
      {
         case 10:
         case 12:
            mc._x = _loc12_.x;
            mc._y = _loc12_.y;
            break;
         case 11:
            mc._x = _loc13_.x;
            mc._y = _loc13_.y;
            break;
         case 20:
         case 21:
            mc._x = _loc12_.x;
            mc._y = _loc12_.y;
            var _loc14_ = Math.PI / 2;
            var _loc15_ = _loc13_.x - _loc12_.x;
            var _loc16_ = _loc13_.y - _loc12_.y;
            mc.rotate._rotation = mc.angle;
            var _loc17_ = mc.attachMovie("shoot","shoot",10);
            _loc17_._x = _loc15_;
            _loc17_._y = _loc16_;
            break;
         case 30:
         case 31:
            mc._x = _loc12_.x;
            mc._y = _loc12_.y - 10;
            mc.level = _loc6_;
            var _loc18_ = !(displayType == 31 || displayType == 33)?0.5:0.9;
            var speed = !(displayType == 31 || displayType == 33)?0.5:0.4;
            if(_global.doubleFramerate)
            {
               speed = speed / 2;
            }
            var _loc19_ = Math.PI / 2;
            var _loc20_ = _loc13_.x - _loc12_.x;
            var _loc21_ = _loc13_.y - _loc12_.y;
            var _loc22_ = (Math.atan2(_loc21_,Math.abs(_loc20_)) + _loc19_) * _loc18_;
            var _loc23_ = _loc22_ - _loc19_;
            var xDest = Math.abs(_loc20_);
            var yDest = _loc21_;
            mc.startangle = _loc23_;
            if(_loc20_ <= 0)
            {
               if(_loc20_ == 0 && _loc21_ < 0)
               {
                  mc._yscale = - mc._yscale;
                  yDest = - yDest;
               }
               mc._xscale = - mc._xscale;
            }
            mc.attachMovie("move","move",2);
            var vyi;
            var x;
            var y;
            var g = 9.81;
            var halfg = g / 2;
            var t = 0;
            var vx = Math.sqrt(Math.abs(halfg * Math.pow(xDest,2) / Math.abs(yDest - Math.tan(_loc23_) * xDest)));
            var vy = Math.tan(_loc23_) * vx;
            mc.onEnterFrame = function()
            {
               vyi = vy + g * t;
               x = t * vx;
               y = halfg * Math.pow(t,2) + vy * t;
               t = t + speed;
               if(Math.abs(y) >= Math.abs(yDest) && x >= xDest || x > xDest)
               {
                  this.attachMovie("shoot","shoot",2);
                  this.shoot._x = xDest;
                  this.shoot._y = yDest;
                  this.shoot._rotation = Math.atan(vyi / vx) * 180 / Math.PI;
                  this.end();
                  delete this.onEnterFrame;
               }
               else
               {
                  this.move._x = x;
                  this.move._y = y;
                  this.move._rotation = Math.atan(vyi / vx) * 180 / Math.PI;
               }
            };
            break;
         case 40:
         case 41:
            mc._x = _loc12_.x;
            mc._y = _loc12_.y;
            var _loc24_ = 20;
            var xStart = _loc12_.x;
            var yStart = _loc12_.y;
            var xDest = _loc13_.x;
            var yDest = _loc13_.y;
            var rot = Math.atan2(yDest - yStart,xDest - xStart);
            var fullDist = Math.sqrt(Math.pow(xStart - xDest,2) + Math.pow(yStart - yDest,2));
            var interval = fullDist / Math.floor(fullDist / _loc24_);
            var dist = 0;
            var inc = 1;
            mc.onEnterFrame = function()
            {
               dist = dist + interval;
               if(dist > fullDist)
               {
                  this.end();
                  if(displayType == 41)
                  {
                     this.attachMovie("shoot","shoot",10);
                     this.shoot._x = xDest - xStart;
                     this.shoot._y = yDest - yStart;
                  }
                  delete this.onEnterFrame;
               }
               else
               {
                  var _loc2_ = this.attachMovie("duplicate","duplicate" + inc,inc);
                  _loc2_._x = dist * Math.cos(rot);
                  _loc2_._y = dist * Math.sin(rot);
                  inc++;
               }
            };
            break;
         case 50:
         case 51:
            mc.cellFrom = _loc12_;
            mc.cellTo = _loc13_;
      }
   }
   function getNextIndex(Void)
   {
      this._incIndex = this._incIndex + 1;
      if(this._incIndex > ank.battlefield.VisualEffectHandler.MAX_INDEX)
      {
         this._incIndex = 0;
      }
      return this._incIndex;
   }
}
