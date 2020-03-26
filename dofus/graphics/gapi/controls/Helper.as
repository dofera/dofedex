class dofus.graphics.gapi.controls.Helper extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Helper";
   static var SINGLETON_INSTANCE = null;
   static var MAX_STARS_DISPLAYED = 5;
   function Helper()
   {
      super();
   }
   static function getCurrentHelper()
   {
      if(dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE == null || !(dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE instanceof dofus.graphics.gapi.controls.Helper))
      {
         var _loc2_ = _global.API.ui.getUIComponent("Banner");
         if(_loc2_ == undefined)
         {
            return null;
         }
         var _loc3_ = _loc2_.showCircleXtra("helper",true);
         return _loc3_.content;
      }
      return dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.Helper.CLASS_NAME);
      dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE = this;
      this._aAnimationQueue = new Array();
      this.addAnimationToQueue("show");
   }
   function createChildren()
   {
      this.hideAllStars();
   }
   function hideAllStars()
   {
      this.showStars(0);
   }
   function showStars(nCount)
   {
      var _loc3_ = 0;
      while(_loc3_ < dofus.graphics.gapi.controls.Helper.MAX_STARS_DISPLAYED)
      {
         this.getStar(_loc3_ + 1)._visible = nCount > _loc3_;
         _loc3_ = _loc3_ + 1;
      }
      this._nStarsDisplayed = nCount;
   }
   function getStar(nID)
   {
      return this["_mcStar" + nID];
   }
   function addStar()
   {
      if(this._nStarsDisplayed < dofus.graphics.gapi.controls.Helper.MAX_STARS_DISPLAYED)
      {
         this.showStars(this._nStarsDisplayed + 1);
      }
   }
   function removeStar()
   {
      if(this._nStarsDisplayed > 0)
      {
         this.showStars(this._nStarsDisplayed - 1);
      }
   }
   function addAnimationToQueue(sAnimation)
   {
      this._aAnimationQueue.push(sAnimation);
      if(!this._bIsPlaying)
      {
         this.playNextAnimation();
      }
   }
   function playNextAnimation()
   {
      if(this._aAnimationQueue.length > 0)
      {
         var _loc2_ = String(this._aAnimationQueue.shift());
         this._sLastAnimation = _loc2_;
         this._mcBoon.gotoAndPlay(_loc2_);
      }
      else
      {
         if((var _loc0_ = this._sLastAnimation) === "hide")
         {
            var _loc3_ = _global.API.ui.getUIComponent("Banner");
            _loc3_.showCircleXtra("artwork",true,{bMask:true});
         }
         this._mcBoon.gotoAndStop("static");
      }
   }
   function onNewTip()
   {
      this.addStar();
      this.addAnimationToQueue("wave");
   }
   function onRemoveTip()
   {
      this.removeStar();
      if(this._nStarsDisplayed <= 0)
      {
         this._nStarsDisplayed = 0;
         this.addAnimationToQueue("hide");
      }
   }
   function onAnimationEnd()
   {
      this.playNextAnimation();
   }
}
