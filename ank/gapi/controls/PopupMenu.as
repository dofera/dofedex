class ank.gapi.controls.PopupMenu extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "PopupMenu";
   static var MAX_ITEM_WIDTH = 150;
   static var ITEM_HEIGHT = 18;
   var _bOver = false;
   var _bCloseOnMouseUp = true;
   function PopupMenu()
   {
      super();
   }
   function addStaticItem(text)
   {
      var _loc3_ = new Object();
      _loc3_.text = text;
      _loc3_.bStatic = true;
      _loc3_.bEnabled = false;
      this._aItems.push(_loc3_);
   }
   function addItem(text, obj, fn, args, bEnabled)
   {
      if(bEnabled == undefined)
      {
         bEnabled = true;
      }
      var _loc7_ = new Object();
      _loc7_.text = text;
      _loc7_.bStatic = false;
      _loc7_.bEnabled = bEnabled;
      _loc7_.obj = obj;
      _loc7_.fn = fn;
      _loc7_.args = args;
      this._aItems.push(_loc7_);
   }
   function __get__items()
   {
      return this._aItems;
   }
   function show(nX, nY, bMaximize, bUseRightCorner, nTimer)
   {
      ank.utils.Timer.removeTimer(this._name);
      if(nX == undefined)
      {
         nX = _root._xmouse;
      }
      if(nY == undefined)
      {
         nY = _root._ymouse;
      }
      this.layoutContent(nX,nY,bMaximize,bUseRightCorner);
      if(!_global.isNaN(Number(nTimer)))
      {
         ank.utils.Timer.setTimer(this,this._name,this,this.remove,nTimer);
         this._bCloseOnMouseUp = false;
      }
      this.addToQueue({object:Mouse,method:Mouse.addListener,params:[this]});
   }
   function init()
   {
      super.init(false,ank.gapi.controls.PopupMenu.CLASS_NAME);
      this._aItems = new Array();
   }
   function createChildren()
   {
      this.createEmptyMovieClip("_mcBorder",10);
      this.createEmptyMovieClip("_mcBackground",20);
      this.createEmptyMovieClip("_mcForeground",30);
      this.createEmptyMovieClip("_mcItems",40);
   }
   function size()
   {
      this.arrange();
   }
   function arrange()
   {
      if(this._bInitialized && (this.__width != undefined && this.__height != undefined))
      {
         this._mcItems._x = this._mcItems._y = 2;
         this._mcBorder._width = this.__width;
         this._mcBorder._height = this.__height;
         this._mcBackground._x = this._mcBackground._y = 1;
         this._mcBackground._width = this.__width - 2;
         this._mcBackground._height = this.__height - 2;
         this._mcForeground._x = this._mcForeground._y = 2;
         this._mcForeground._width = this.__width - 4;
         this._mcForeground._height = this.__height - 4;
         var _loc2_ = this._aItems.length;
         while(true)
         {
            _loc2_;
            if(_loc2_-- > 0)
            {
               this.arrangeItem(_loc2_,this.__width - 4);
               continue;
            }
            break;
         }
      }
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this._mcBorder.clear();
      this._mcBackground.clear();
      this._mcForeground.clear();
      this.drawRoundRect(this._mcBorder,0,0,1,1,0,_loc2_.bordercolor);
      this.drawRoundRect(this._mcBackground,0,0,1,1,0,_loc2_.backgroundcolor);
      this.drawRoundRect(this._mcForeground,0,0,1,1,0,_loc2_.foregroundcolor);
   }
   function drawItem(i, index, nY)
   {
      var _loc4_ = this._mcItems.createEmptyMovieClip("item" + index,index);
      var _loc5_ = (ank.gapi.controls.Label)_loc4_.attachMovie("Label","_lbl",20,{_width:ank.gapi.controls.PopupMenu.MAX_ITEM_WIDTH,styleName:this.getStyle().labelenabledstyle,wordWrap:true,text:i.text});
      _loc5_.setPreferedSize("left");
      var _loc6_ = Math.max(ank.gapi.controls.PopupMenu.ITEM_HEIGHT,_loc5_.textHeight + 6);
      if(i.bStatic)
      {
         _loc5_.styleName = this.getStyle().labelstaticstyle;
      }
      else if(!i.bEnabled)
      {
         _loc5_.styleName = this.getStyle().labeldisabledstyle;
      }
      _loc4_.createEmptyMovieClip("bg",10);
      this.drawRoundRect(_loc4_.bg,0,0,1,_loc6_,0,this.getStyle().itembgcolor);
      _loc4_._y = nY;
      if(i.bEnabled)
      {
         _loc4_.bg.onRelease = function()
         {
            i.fn.apply(i.obj,i.args);
            this._parent._parent._parent.remove(true);
         };
         _loc4_.bg.onRollOver = function()
         {
            var _loc2_ = new Color(this);
            _loc2_.setRGB(this._parent._parent._parent.getStyle().itemovercolor);
            this._parent._parent._parent.onItemOver();
         };
         _loc4_.bg.onRollOut = _loc4_.bg.onReleaseOutside = function()
         {
            var _loc2_ = new Color(this);
            _loc2_.setRGB(this._parent._parent._parent.getStyle().itembgcolor);
            this._parent._parent._parent.onItemOut();
         };
      }
      else
      {
         _loc4_.bg.onPress = function()
         {
         };
         _loc4_.bg.useHandCursor = false;
         var _loc7_ = new Color(_loc4_.bg);
         if(i.bStatic)
         {
            _loc7_.setRGB(this.getStyle().itemstaticbgcolor);
         }
         else
         {
            _loc7_.setRGB(this.getStyle().itembgcolor);
         }
      }
      return {w:_loc5_.textWidth,h:_loc6_};
   }
   function arrangeItem(nIndex, nWidth)
   {
      var _loc4_ = this._mcItems["item" + nIndex];
      _loc4_._lbl.setSize(nWidth,ank.gapi.controls.PopupMenu.ITEM_HEIGHT);
      _loc4_.bg._width = nWidth;
   }
   function layoutContent(x, y, bMaximize, bUseRightCorner)
   {
      var _loc6_ = this._aItems.length;
      var _loc7_ = 0;
      var _loc8_ = 0;
      var _loc9_ = 0;
      while(_loc9_ < this._aItems.length)
      {
         var _loc10_ = this.drawItem(this._aItems[_loc9_],_loc9_,_loc8_);
         _loc8_ = _loc8_ + _loc10_.h;
         _loc7_ = Math.max(_loc7_,_loc10_.w);
         _loc9_ = _loc9_ + 1;
      }
      this.setSize(_loc7_ + 16,_loc8_ + 4);
      var _loc11_ = !bMaximize?this.gapi.screenWidth:Stage.width;
      var _loc12_ = !bMaximize?this.gapi.screenHeight:Stage.height;
      if(bUseRightCorner == true)
      {
         x = x - this.__width;
      }
      if(x > _loc11_ - this.__width)
      {
         this._x = _loc11_ - this.__width;
      }
      else if(x < 0)
      {
         this._x = 0;
      }
      else
      {
         this._x = x;
      }
      if(y > _loc12_ - this.__height)
      {
         this._y = _loc12_ - this.__height;
      }
      else if(y < 0)
      {
         this._y = 0;
      }
      else
      {
         this._y = y;
      }
   }
   function remove()
   {
      Mouse.removeListener(this);
      this.removeMovieClip();
   }
   function onItemOver()
   {
      this._bOver = true;
   }
   function onItemOut()
   {
      this._bOver = false;
   }
   function onMouseUp()
   {
      if(!this._bOver && this._bCloseOnMouseUp)
      {
         this.remove();
      }
   }
}
