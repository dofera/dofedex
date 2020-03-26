class dofus.graphics.gapi.ui.MovableContainerBar extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "MovableContainerBar";
   function MovableContainerBar()
   {
      super();
   }
   function __get__containers()
   {
      return this._aContainers;
   }
   function __get__size()
   {
      return this._nContainerNumber;
   }
   function __set__size(n)
   {
      if(n < 0)
      {
         n = 0;
      }
      if(n > this._nMaxContainer)
      {
         n = this._nMaxContainer;
      }
      if(n != this._nContainerNumber)
      {
         this._nContainerNumber = n;
         this.move(this._x,this._y,true);
      }
      return this.__get__size();
   }
   function __get__maxContainer()
   {
      return this._nMaxContainer;
   }
   function __set__maxContainer(n)
   {
      this._nMaxContainer = n;
      if(this._nContainerNumber > n)
      {
         this.size = n;
      }
      return this.__get__maxContainer();
   }
   function __get__bounds()
   {
      return this._oBounds;
   }
   function __set__bounds(o)
   {
      this._oBounds = o;
      return this.__get__bounds();
   }
   function __get__snap()
   {
      return this._nSnap;
   }
   function __set__snap(n)
   {
      this._nSnap = n;
      return this.__get__snap();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.MovableContainerBar.CLASS_NAME);
      this._nContainerNumber = 1;
      this._nMaxContainer = 5;
      this._bVertical = false;
      this._oBounds = {left:0,top:0,right:800,bottom:600};
      this._nSnap = 20;
      this._nOffsetX = 0;
      this._nOffsetY = 0;
   }
   function createChildren()
   {
      Mouse.addListener(this);
      this._mcDragOne.onPress = this._mcDragTwo.onPress = function()
      {
         if(this._parent._bTimerEnable != true)
         {
            this._parent.onMouseMove = this._parent._onMouseMove;
            this._parent._nOffsetX = _root._xmouse - this._parent._x;
            this._parent._nOffsetY = _root._ymouse - this._parent._y;
         }
      };
      this._mcDragOne.onRelease = this._mcDragOne.onReleaseOutside = this._mcDragTwo.onRelease = this._mcDragTwo.onReleaseOutside = function()
      {
         if(this._parent._bTimerEnable != true)
         {
            this._parent.onMouseMove = undefined;
            this._parent._nOffsetX = 0;
            this._parent._nOffsetY = 0;
            this._parent.dispatchEvent({type:"drop"});
            this._parent._bTimerEnable = true;
            ank.utils.Timer.setTimer(this._parent,"movablecontainerbar",this._parent,this._parent.onClickTimer,ank.gapi.Gapi.DBLCLICK_DELAY);
         }
         else
         {
            this._parent.onClickTimer();
            this._parent.dispatchEvent({type:"dblClick"});
         }
      };
      this._mcBackground.onRelease = function()
      {
      };
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function drawBar()
   {
      this._aContainers = new Array();
      this._mcContainers = this.createEmptyMovieClip("_mcContainers",1);
      var _loc2_ = new Object();
      _loc2_.backgroundRenderer = "UI_BannerContainerBackground";
      _loc2_.borderRenderer = "UI_BannerContainerBorder";
      _loc2_.dragAndDrop = true;
      _loc2_.enabled = true;
      _loc2_.highlightFront = true;
      _loc2_.highlightRenderer = "UI_BannerContainerHighLight";
      _loc2_.margin = 1;
      _loc2_.showLabel = false;
      _loc2_.styleName = "InventoryGridContainer";
      switch(this._bVertical)
      {
         case true:
            this._mcDragOne._x = 3;
            this._mcDragOne._y = 3;
            this._mcDragTwo._x = 3;
            this._mcDragTwo._y = 18 + this._nContainerNumber * (25 + 3);
            this._mcDragTwo._width = _loc0_ = 25;
            this._mcDragOne._width = _loc0_;
            this._mcDragTwo._height = _loc0_ = 12;
            this._mcDragOne._height = _loc0_;
            this._mcDragOne.styleName = "VerticalDragOneMovableBarStylizedRectangle";
            this._mcDragTwo.styleName = "VerticalDragTwoMovableBarStylizedRectangle";
            this._mcContainers._x = 3;
            this._mcContainers._y = 18;
            var _loc3_ = 0;
            while(_loc3_ < this._nContainerNumber)
            {
               _loc2_._y = (25 + 3) * _loc3_;
               var _loc4_ = this._mcContainers.attachMovie("Container","_ctr" + _loc3_,_loc3_,_loc2_);
               _loc4_.setSize(25,25);
               this._aContainers.push(_loc4_);
               _loc3_ = _loc3_ + 1;
            }
            this._mcBackground.setSize(31,33 + this._nContainerNumber * (25 + 3));
            break;
         case false:
            this._mcDragOne._x = 3;
            this._mcDragOne._y = 3;
            this._mcDragTwo._x = 18 + this._nContainerNumber * (25 + 3);
            this._mcDragTwo._y = 3;
            this._mcDragTwo._width = _loc0_ = 12;
            this._mcDragOne._width = _loc0_;
            this._mcDragTwo._height = _loc0_ = 25;
            this._mcDragOne._height = _loc0_;
            this._mcDragOne.styleName = "HorizontalDragOneMovableBarStylizedRectangle";
            this._mcDragTwo.styleName = "HorizontalDragTwoMovableBarStylizedRectangle";
            this._mcContainers._x = 18;
            this._mcContainers._y = 3;
            var _loc5_ = 0;
            while(_loc5_ < this._nContainerNumber)
            {
               _loc2_._x = (25 + 3) * _loc5_;
               var _loc6_ = this._mcContainers.attachMovie("Container","_ctr" + _loc5_,_loc5_,_loc2_);
               _loc6_.setSize(25,25);
               this._aContainers.push(_loc6_);
               _loc5_ = _loc5_ + 1;
            }
            this._mcBackground.setSize(33 + this._nContainerNumber * (25 + 3),31);
      }
      this.dispatchEvent({type:"drawBar"});
   }
   function autoDetectBarOrientation(x, y)
   {
      var _loc4_ = y - this._oBounds.top;
      var _loc5_ = this._oBounds.bottom - y;
      var _loc6_ = x - this._oBounds.left;
      var _loc7_ = this._oBounds.right - x;
      var _loc8_ = this._bVertical;
      var _loc9_ = 1000000;
      if(_loc4_ < this._nSnap)
      {
         if(_loc4_ < _loc9_)
         {
            _loc9_ = _loc4_;
            _loc8_ = false;
         }
      }
      if(_loc5_ < this._nSnap)
      {
         if(_loc5_ < _loc9_)
         {
            _loc9_ = _loc5_;
            _loc8_ = false;
         }
      }
      if(_loc6_ < this._nSnap)
      {
         if(_loc6_ < _loc9_)
         {
            _loc9_ = _loc6_;
            _loc8_ = true;
         }
      }
      if(_loc7_ < this._nSnap)
      {
         if(_loc7_ < _loc9_)
         {
            _loc9_ = _loc7_;
            _loc8_ = true;
         }
      }
      if(_loc8_ != undefined && this._bVertical != _loc8_)
      {
         this._bVertical = _loc8_;
         return true;
      }
      return false;
   }
   function snapBar()
   {
      var _loc2_ = this._x;
      var _loc3_ = this._y;
      var _loc4_ = this.getBounds();
      var _loc5_ = _loc3_ + _loc4_.yMin - this._oBounds.top;
      var _loc6_ = this._oBounds.bottom - _loc3_ - _loc4_.yMax;
      var _loc7_ = _loc2_ + _loc4_.xMin - this._oBounds.left;
      var _loc8_ = this._oBounds.right - _loc2_ - _loc4_.xMax;
      if(_loc5_ < this._nSnap)
      {
         _loc3_ = this._oBounds.top - _loc4_.yMin;
      }
      if(_loc6_ < this._nSnap)
      {
         _loc3_ = this._oBounds.bottom - _loc4_.yMax;
      }
      if(_loc7_ < this._nSnap)
      {
         _loc2_ = this._oBounds.left - _loc4_.xMin;
      }
      if(_loc8_ < this._nSnap)
      {
         _loc2_ = this._oBounds.right - _loc4_.xMax;
      }
      this._y = _loc3_;
      this._x = _loc2_;
   }
   function destroy()
   {
      Mouse.removeListener(this);
   }
   function move(x, y, bForceDraw)
   {
      if(this.autoDetectBarOrientation(x,y) || bForceDraw)
      {
         this.drawBar();
      }
      this._x = x;
      this._y = y;
      this.snapBar();
   }
   function setOptions(m, s, b, si, c)
   {
      this._nMaxContainer = m;
      this._nSnap = s;
      this._oBounds = b;
      this._nContainerNumber = si;
      this.move(c.x,c.y,true);
   }
   function _onMouseMove()
   {
      this.move(_root._xmouse - this._nOffsetX,_root._ymouse - this._nOffsetY);
   }
   function onClickTimer()
   {
      ank.utils.Timer.removeTimer(this,"movablecontainerbar");
      this._bTimerEnable = false;
   }
   function onShortcut(shortcut)
   {
      var _loc3_ = 0;
      while(_loc3_ < this._nContainerNumber)
      {
         if(shortcut == "MOVABLEBAR_SH" + _loc3_)
         {
            this._aContainers[_loc3_].notInChat = true;
            this._aContainers[_loc3_].emulateClick();
            return false;
         }
         _loc3_ = _loc3_ + 1;
      }
      return true;
   }
}
