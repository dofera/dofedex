class dofus.graphics.gapi.controls.StarsDisplayer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "StarsDisplayer";
   static var STARS_COUNT = 5;
   static var STARS_COLORS = [-1,16777011,16750848,39168,39372,6697728,2236962,16711680,65280,16777215,16711935];
   function StarsDisplayer()
   {
      super();
   }
   function __get__value()
   {
      return this._nValue;
   }
   function __set__value(value)
   {
      this._nValue = value;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__value();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.StarsDisplayer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function initData()
   {
      this.updateData();
   }
   function addListeners()
   {
      var ref = this;
      this._mcMask.onRollOut = function()
      {
         ref.dispatchEvent({type:"out"});
      };
      this._mcMask.onRollOver = function()
      {
         ref.dispatchEvent({type:"over"});
      };
      this._mcMask.onRelease = function()
      {
         ref.dispatchEvent({type:"click"});
      };
   }
   function updateData()
   {
      if(this._nValue != undefined && (this._nValue > 0 && !_global.isNaN(this._nValue)))
      {
         var _loc2_ = this.getStarsColor();
         var _loc3_ = 0;
         while(_loc3_ < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
         {
            var _loc4_ = this["_mcStar" + _loc3_].fill;
            if(_loc2_[_loc3_] > -1)
            {
               var _loc5_ = new Color(_loc4_);
               _loc5_.setRGB(_loc2_[_loc3_]);
            }
            else
            {
               _loc4_._alpha = 0;
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      else
      {
         var _loc6_ = 0;
         while(_loc6_ < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
         {
            this["_mcStar" + _loc6_].fill._alpha = 0;
            _loc6_ = _loc6_ + 1;
         }
      }
   }
   function getStarsColor()
   {
      var _loc2_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
      {
         var _loc4_ = Math.floor(this._nValue / 100) + (this._nValue - Math.floor(this._nValue / 100) * 100 <= _loc3_ * (100 / dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)?0:1);
         _loc2_[_loc3_] = dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS[Math.min(_loc4_,dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS.length - 1)];
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
}
