class ank.gapi.controls.ToolTip extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ToolTip";
   static var MAX_WIDTH = 250;
   function ToolTip()
   {
      super();
   }
   function __set__params(oParams)
   {
      this._oParams = oParams;
      return this.__get__params();
   }
   function __set__text(sText)
   {
      this._sText = sText;
      if(this.initialized)
      {
         this.layoutContent();
      }
      return this.__get__text();
   }
   function __set__x(nX)
   {
      this._nX = nX;
      if(this.initialized)
      {
         this.placeToolTip();
      }
      return this.__get__x();
   }
   function __set__y(nY)
   {
      this._nY = nY;
      if(this.initialized)
      {
         this.placeToolTip();
      }
      return this.__get__y();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.ToolTip.CLASS_NAME);
   }
   function createChildren()
   {
      this._visible = false;
      this.createEmptyMovieClip("_mcBackground",10);
      this.createTextField("_tfText",20,0,0,ank.gapi.controls.ToolTip.MAX_WIDTH,100);
      this._tfText.wordWrap = true;
      this._tfText.selectable = false;
      this._tfText.autoSize = "left";
      this._tfText.multiline = true;
      this._tfText.html = true;
      this.addToQueue({object:this,method:this.layoutContent});
      this.addToQueue({object:this,method:this.placeToolTip});
      Key.addListener(this);
   }
   function placeToolTip()
   {
      var _loc2_ = !(this._oParams.bXLimit || this._oParams.bXLimit == undefined)?Number.MAX_VALUE:this.gapi.screenWidth;
      var _loc3_ = !(this._oParams.bYLimit || this._oParams.bYLimit == undefined)?Number.MAX_VALUE:this.gapi.screenHeight;
      var _loc4_ = !(!this._oParams.bRightAlign || this._oParams.bRightAlign == undefined)?this._oParams.bRightAlign:false;
      var _loc5_ = !(!this._oParams.bTopAlign || this._oParams.bTopAlign == undefined)?this._oParams.bTopAlign:false;
      var _loc6_ = !_loc4_?this._nX:this._nX - this.__width;
      var _loc7_ = !_loc5_?this._nY:this._nY - this.__height;
      if(_loc6_ > _loc2_ - this.__width)
      {
         this._x = _loc2_ - this.__width;
      }
      else if(_loc6_ < 0)
      {
         this._x = 0;
      }
      else
      {
         this._x = _loc6_;
      }
      if(_loc7_ > _loc3_ - this.__height)
      {
         this._y = _loc3_ - this.__height;
      }
      else if(_loc7_ < 0)
      {
         this._y = 0;
      }
      else
      {
         this._y = _loc7_;
      }
      this._visible = true;
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this.drawRoundRect(this._mcBackground,0,0,1,1,0,_loc2_.bgcolor);
      this._mcBackground._alpha = _loc2_.bgalpha;
      this._tfTextFormat = new TextFormat();
      this._tfTextFormat.font = _loc2_.font;
      this._tfTextFormat.size = _loc2_.size;
      this._tfTextFormat.color = _loc2_.color;
      this._tfTextFormat.bold = _loc2_.bold;
      this._tfTextFormat.italic = _loc2_.italic;
      this._tfTextFormat.size = _loc2_.size;
      this._tfTextFormat.size = _loc2_.size;
      this._tfText.embedFonts = _loc2_.embedfonts;
      this._tfText.antiAliasType = _loc2_.antialiastype;
   }
   function layoutContent()
   {
      this._tfText.htmlText = this._sText;
      this._tfText.setTextFormat(this._tfTextFormat);
      this.setSize(this._tfText.textWidth + 4,this._tfText.textHeight + 4);
      this._mcBackground._width = this.__width;
      this._mcBackground._height = this.__height;
   }
   function onKeyDown()
   {
      this.removeMovieClip();
   }
   function onMouseDown()
   {
      this.removeMovieClip();
   }
}
