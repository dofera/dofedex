class ank.gapi.controls.Label extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "Label";
   var _sTextfiledType = "dynamic";
   var _bMultiline = false;
   var _bWordWrap = false;
   var bDisplayDebug = false;
   function Label()
   {
      super();
   }
   function __set__html(bHTML)
   {
      this._bHTML = bHTML;
      this.setTextFieldProperties();
      return this.__get__html();
   }
   function __get__html()
   {
      return this._bHTML;
   }
   function __set__multiline(bMultiline)
   {
      this._bMultiline = bMultiline;
      this.setTextFieldProperties();
      return this.__get__multiline();
   }
   function __get__multiline()
   {
      return this._bMultiline;
   }
   function __set__wordWrap(bWordWrap)
   {
      this._bWordWrap = bWordWrap;
      this.setTextFieldProperties();
      return this.__get__wordWrap();
   }
   function __get__wordWrap()
   {
      return this._bWordWrap;
   }
   function __set__text(sText)
   {
      this._sText = sText;
      this._bSettingNewText = true;
      this.setTextFieldProperties();
      return this.__get__text();
   }
   function __get__text()
   {
      return this._tText.text != undefined?this._tText.text:this._sText;
   }
   function __get__textHeight()
   {
      return this._tText.textHeight;
   }
   function __get__textWidth()
   {
      return this._tText.textWidth;
   }
   function __set__textColor(nColor)
   {
      this._tText.textColor = nColor;
      return this.__get__textColor();
   }
   function setPreferedSize(sAutoSizeAlign)
   {
      this._tText.autoSize = sAutoSizeAlign;
      this.setSize(this.textWidth + 5,this.textHeight);
   }
   function init()
   {
      super.init(false,ank.gapi.controls.Label.CLASS_NAME);
      this._tfFormatter = new TextFormat();
   }
   function createChildren()
   {
      this.createTextField("_tText",10,0,1,this.__width,this.__height - 1);
      this._tText.addListener(this);
      this._tText.onKillFocus = function()
      {
         this._parent.onKillFocus();
      };
      this._tText.onSetFocus = function()
      {
         this._parent.onSetFocus();
      };
      this.setTextFieldProperties();
   }
   function size()
   {
      super.size();
      this._tText._height = this.__height - 1;
      this._tDotText.removeTextField();
      this._mcDot.removeMovieClip();
      if(this._tText.textWidth > this.__width && this._sTextfiledType == "dynamic")
      {
         this.createTextField("_tDotText",20,0,1,this.__width,this.__height - 1);
         this._tDotText.selectable = false;
         this._tDotText.autoSize = "right";
         this._tDotText.embedFonts = this.getStyle().labelembedfonts;
         this._tDotText.text = "...";
         this._tDotText.setNewTextFormat(this._tfFormatter);
         this._tDotText.setTextFormat(this._tfFormatter);
         this._tText._width = this.__width - this._tDotText.textWidth;
         this.createEmptyMovieClip("_mcDot",30);
         this.drawRoundRect(this._mcDot,this.__width - this._tDotText.textWidth,0,this._tDotText.textWidth + 5,this.__height,0,0,0);
         this._mcDot.onRollOver = function()
         {
            this._parent.gapi.showTooltip(this._parent._sText,this._parent,0);
         };
         this._mcDot.onRollOut = function()
         {
            this._parent.gapi.hideTooltip();
         };
      }
      else
      {
         this._tText._width = this.__width;
      }
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this._tfFormatter = this._tText.getTextFormat();
      this._tfFormatter.font = _loc2_.labelfont;
      this._tfFormatter.align = _loc2_.labelalign;
      this._tfFormatter.size = _loc2_.labelsize;
      if(!this._bHTML)
      {
         this._tfFormatter.color = _loc2_.labelcolor;
      }
      this._tfFormatter.bold = _loc2_.labelbold;
      this._tfFormatter.italic = _loc2_.labelitalic;
      this._tText.embedFonts = _loc2_.labelembedfonts;
      this._tText.antiAliasType = _loc2_.antialiastype;
      this.setTextFieldProperties();
   }
   function setTextFieldProperties()
   {
      if(this._tText != undefined)
      {
         this._tText.wordWrap = this._bWordWrap;
         this._tText.multiline = this._bMultiline;
         this._tText.selectable = this._sTextfiledType == "input";
         this._tText.type = this._sTextfiledType;
         this._tText.html = !this._bHTML?false:true;
         if(this._tfFormatter.font != undefined)
         {
            if(this._sText != undefined)
            {
               if(this._bHTML)
               {
                  this._tText.htmlText = this._sText;
               }
               else
               {
                  this._tText.text = this._sText;
               }
            }
            this._tText.setNewTextFormat(this._tfFormatter);
            this._tText.setTextFormat(this._tfFormatter);
         }
         if(this._tText.textWidth > this.__width && this._sTextfiledType == "dynamic")
         {
            this.size();
         }
         else
         {
            this._tDotText.removeTextField();
            this._mcDot.removeMovieClip();
         }
         this.onChanged();
      }
   }
   function onChanged()
   {
      this.dispatchEvent({type:"change"});
   }
   function onSetFocus()
   {
      getURL("FSCommand:" add "trapallkeys","false");
   }
   function onKillFocus()
   {
      getURL("FSCommand:" add "trapallkeys","true");
   }
}
