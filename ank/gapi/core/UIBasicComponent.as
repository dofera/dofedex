class ank.gapi.core.UIBasicComponent extends ank.utils.QueueEmbedMovieClip
{
   static var BORDER_TICKNESS = 1;
   static var BORDER_ALPHA = 50;
   var _bInitialized = false;
   var _sStyleName = "default";
   var _bEnabled = true;
   function UIBasicComponent()
   {
      super();
      this.init();
      this.createChildren();
      this.draw();
      this.arrange();
      this.size();
      this._bInitialized = true;
   }
   function __set__gapi(mcGAPI)
   {
      this._mcGAPI = mcGAPI;
      return this.__get__gapi();
   }
   function __get__gapi()
   {
      if(this._mcGAPI == undefined)
      {
         return this._parent.gapi;
      }
      return this._mcGAPI;
   }
   function __get__className()
   {
      return this._sClassName;
   }
   function __set__enabled(bEnabled)
   {
      this._bEnabled = bEnabled;
      this.addToQueue({object:this,method:this.setEnabled});
      return this.__get__enabled();
   }
   function __get__enabled()
   {
      return this._bEnabled;
   }
   function __set__styleName(sStyleName)
   {
      this._sStyleName = sStyleName;
      if(this._bInitialized && (sStyleName != "none" && sStyleName != undefined))
      {
         this.draw();
      }
      return this.__get__styleName();
   }
   function __get__styleName()
   {
      var _loc2_ = this._sStyleName;
      if(_loc2_.length == 0 || (_loc2_ == undefined || _loc2_ == "default"))
      {
         var _loc3_ = this._parent;
         while(!(_loc3_ instanceof ank.gapi.core.UIBasicComponent) && _loc3_ != undefined)
         {
            _loc3_ = _loc3_._parent;
         }
         _loc2_ = _loc3_.styleName;
      }
      if(_loc2_ == undefined)
      {
         _loc2_ = this._sClassName;
      }
      return _loc2_;
   }
   function __set__width(nWidth)
   {
      this.setSize(nWidth,null);
      return this.__get__width();
   }
   function __get__width()
   {
      return this.__width;
   }
   function __set__height(nHeight)
   {
      this.setSize(null,nHeight);
      return this.__get__height();
   }
   function __get__height()
   {
      return this.__height;
   }
   function __set__params(oParams)
   {
      this._oParams = oParams;
      return this.__get__params();
   }
   function __get__params()
   {
      return this._oParams;
   }
   function __get__initialized()
   {
      return this._bInitialized;
   }
   function setSize(w, h)
   {
      if(Math.abs(this._rotation) == 90)
      {
         var _loc4_ = w;
         w = h;
         h = _loc4_;
      }
      if(w != undefined && w != null)
      {
         this.__width = w;
      }
      if(h != undefined && h != null)
      {
         this.__height = h;
      }
      this.size();
   }
   function move(x, y)
   {
      if(x != undefined)
      {
         this._x = x;
      }
      if(x != undefined)
      {
         this._y = y;
      }
   }
   function init(bDontHideBoundingBox, sClassName)
   {
      this._sClassName = sClassName;
      if(Math.ceil(this._rotation % 180) > 45)
      {
         this.__width = this._height;
         this.__height = this._width;
      }
      else
      {
         this.__width = this._width;
         this.__height = this._height;
      }
      if(!bDontHideBoundingBox)
      {
         this.boundingBox_mc._visible = false;
         this.boundingBox_mc._width = this.boundingBox_mc._height = 0;
      }
      mx.events.EventDispatcher.initialize(this);
   }
   function getStyle()
   {
      return ank.gapi.styles.StylesManager.getStyle(this.styleName);
   }
   function size()
   {
      this.initScale();
   }
   function initScale()
   {
      this._xscale = this._yscale = 100;
   }
   function drawBorder()
   {
      if(this.border_mc == undefined)
      {
         this.createEmptyMovieClip("border_mc",0);
      }
      this.border_mc.clear();
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,7305079,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(this.__width,0);
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,9542041,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(this.__width,this.__height);
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,14015965,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(0,this.__height);
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,9542041,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(0,0);
      this.border_mc.moveTo(1,1);
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,13290700,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(this.__width - 1,1);
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,14015965,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(this.__width - 1,this.__height - 1);
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,15658734,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(1,this.__height - 1);
      this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,14015965,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
      this.border_mc.lineTo(1,1);
   }
   function drawRoundRect(mc, x, y, w, h, r, c, alpha, rot, gradient, ratios)
   {
      if(typeof r == "object")
      {
         var _loc13_ = r.br;
         var _loc14_ = r.bl;
         var _loc15_ = r.tl;
         var _loc16_ = r.tr;
      }
      else
      {
         _loc13_ = _loc14_ = _loc15_ = _loc16_ = r;
      }
      if(alpha == undefined)
      {
         alpha = 100;
      }
      if(typeof c == "object")
      {
         if(typeof alpha != "object")
         {
            var _loc17_ = [alpha,alpha];
         }
         else
         {
            _loc17_ = alpha;
         }
         if(ratios == undefined)
         {
            ratios = [0,255];
         }
         var _loc18_ = h * 0.7;
         if(typeof rot != "object")
         {
            var _loc19_ = {matrixType:"box",x:- _loc18_,y:_loc18_,w:w * 2,h:h * 4,r:rot * 0.0174532925199433};
         }
         else
         {
            _loc19_ = rot;
            if(_loc19_.w == undefined)
            {
               _loc19_.w = w;
            }
            if(_loc19_.h == undefined)
            {
               _loc19_.h = h;
            }
         }
         if(gradient == "radial")
         {
            mc.beginGradientFill("radial",c,_loc17_,ratios,_loc19_);
         }
         else
         {
            mc.beginGradientFill("linear",c,_loc17_,ratios,_loc19_);
         }
      }
      else if(c != undefined)
      {
         mc.beginFill(c,alpha);
      }
      r = _loc13_;
      if(r != 0)
      {
         var _loc20_ = r - r * 0.707106781186547;
         var _loc21_ = r - r * 0.414213562373095;
         mc.moveTo(x + w,y + h - r);
         mc.lineTo(x + w,y + h - r);
         mc.curveTo(x + w,y + h - _loc21_,x + w - _loc20_,y + h - _loc20_);
         mc.curveTo(x + w - _loc21_,y + h,x + w - r,y + h);
      }
      else
      {
         mc.moveTo(x + w,y + h);
      }
      r = _loc14_;
      if(r != 0)
      {
         var _loc22_ = r - r * 0.707106781186547;
         var _loc23_ = r - r * 0.414213562373095;
         mc.lineTo(x + r,y + h);
         mc.curveTo(x + _loc23_,y + h,x + _loc22_,y + h - _loc22_);
         mc.curveTo(x,y + h - _loc23_,x,y + h - r);
      }
      else
      {
         mc.lineTo(x,y + h);
      }
      r = _loc15_;
      if(r != 0)
      {
         var _loc24_ = r - r * 0.707106781186547;
         var _loc25_ = r - r * 0.414213562373095;
         mc.lineTo(x,y + r);
         mc.curveTo(x,y + _loc25_,x + _loc24_,y + _loc24_);
         mc.curveTo(x + _loc25_,y,x + r,y);
      }
      else
      {
         mc.lineTo(x,y);
      }
      r = _loc16_;
      if(r != 0)
      {
         var _loc26_ = r - r * 0.707106781186547;
         var _loc27_ = r - r * 0.414213562373095;
         mc.lineTo(x + w - r,y);
         mc.curveTo(x + w - _loc27_,y,x + w - _loc26_,y + _loc26_);
         mc.curveTo(x + w,y + _loc27_,x + w,y + r);
         mc.lineTo(x + w,y + h - r);
      }
      else
      {
         mc.lineTo(x + w,y);
         mc.lineTo(x + w,y + h);
      }
      if(c != undefined)
      {
         mc.endFill();
      }
   }
   function setMovieClipColor(mc, nColor)
   {
      var _loc4_ = new Color(mc);
      _loc4_.setRGB(nColor);
      if(nColor == -1)
      {
         mc._alpha = 0;
      }
   }
   function setMovieClipTransform(mc, oTransformation)
   {
      var _loc4_ = new Color(mc);
      _loc4_.setTransform(oTransformation);
   }
}
