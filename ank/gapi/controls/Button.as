class ank.gapi.controls.Button extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "Button";
   var _bToggle = false;
   var _bRadio = false;
   var _sLabel = "";
   var _sBackgroundUp = "ButtonNormalUp";
   var _sBackgroundDown = "ButtonNormalDown";
   var _nLabelPadding = 0;
   function Button()
   {
      super();
   }
   function __set__label(sLabel)
   {
      this._sLabel = sLabel;
      this.displayLabel();
      return this.__get__label();
   }
   function __set__selected(bSelected)
   {
      if(this._bSelected != bSelected)
      {
         this._lblLabel._x = this._lblLabel._x + (!bSelected?-0.5:0.5);
         this._lblLabel._y = this._lblLabel._y + (!bSelected?-0.5:0.5);
         this._mcIcon._x = this._mcIcon._x + (!bSelected?-0.5:0.5);
         this._mcIcon._y = this._mcIcon._y + (!bSelected?-0.5:0.5);
         this.dispatchEvent({type:"stateChanged",target:this,value:bSelected});
      }
      this._bSelected = bSelected;
      this._mcDown._visible = this._bSelected;
      this._mcUp._visible = !this._bSelected;
      this.setLabelStyle();
      return this.__get__selected();
   }
   function __get__selected()
   {
      return this._bSelected;
   }
   function __set__toggle(bToggle)
   {
      this._bToggle = bToggle;
      return this.__get__toggle();
   }
   function __get__toggle()
   {
      return this._bToggle;
   }
   function __set__radio(bRadio)
   {
      this._bRadio = bRadio;
      return this.__get__radio();
   }
   function __get__radio()
   {
      return this._bRadio;
   }
   function __set__icon(sIcon)
   {
      this._sIcon = sIcon;
      if(this.initialized)
      {
         this.displayIcon();
      }
      return this.__get__icon();
   }
   function __get__icon()
   {
      return this._sIcon;
   }
   function __get__iconClip()
   {
      return this._mcIcon;
   }
   function __set__backgroundUp(sBackgroundUp)
   {
      this._sBackgroundUp = sBackgroundUp;
      if(this.initialized)
      {
         this.drawBackgrounds();
      }
      return this.__get__backgroundUp();
   }
   function __get__backgroundUp()
   {
      return this._sBackgroundUp;
   }
   function __set__backgroundDown(sBackgroundDown)
   {
      this._sBackgroundDown = sBackgroundDown;
      if(this.initialized)
      {
         this.drawBackgrounds();
      }
      return this.__get__backgroundDown();
   }
   function __get__backgroundDown()
   {
      return this._sBackgroundDown;
   }
   function setPreferedSize(nLabelPadding)
   {
      if(this._sLabel != "")
      {
         if(_global.isNaN(Number(nLabelPadding)))
         {
            this._nLabelPadding = 0;
         }
         else
         {
            this._nLabelPadding = Number(nLabelPadding);
         }
         this._lblLabel.setPreferedSize("left");
         this.setSize(this._lblLabel.width + this._nLabelPadding * 2);
      }
   }
   function init()
   {
      super.init(false,ank.gapi.controls.Button.CLASS_NAME);
   }
   function createChildren()
   {
      super.createChildren();
      this.drawBackgrounds();
      this.selected = this._bSelected && this._bToggle;
      this.attachMovie("Label","_lblLabel",30,{styleName:this.getStyle().labelupstyle});
      this._lblLabel.addEventListener("change",this);
      if(this._sLabel == undefined)
      {
         this._sLabel = "Label";
      }
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this.setLabelStyle();
      this.displayLabel();
      this._mcUp.setStyleColor(_loc2_,"color");
      this._mcDown.setStyleColor(_loc2_,"downcolor");
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      var _loc2_ = this._mcUp;
      var _loc3_ = this._mcDown;
      _loc2_.setSize(this.__width,this.__height,true);
      _loc3_.setSize(this.__width,this.__height,true);
      this.displayLabel();
      this.displayIcon();
   }
   function setEnabled()
   {
      if(!this._bEnabled)
      {
         this.setMovieClipTransform(this,this.getStyle().disabledtransform);
      }
      else
      {
         this.setMovieClipTransform(this,{ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      }
   }
   function drawBackgrounds()
   {
      if(this._sBackgroundDown != "none")
      {
         this.attachMovie(this._sBackgroundDown,"_mcDown",10);
      }
      if(this._sBackgroundUp != "none")
      {
         this.attachMovie(this._sBackgroundUp,"_mcUp",20);
      }
   }
   function displayIcon()
   {
      if(this._mcIcon != undefined)
      {
         this._mcIcon.removeMovieClip();
      }
      if(this._sIcon.length == 0)
      {
         return undefined;
      }
      this.attachMovie(this._sIcon,"_mcIcon",40);
      var _loc2_ = this._mcIcon.getBounds(this);
      this._mcIcon._x = (this.__width - this._mcIcon._width) / 2 - _loc2_.xMin;
      this._mcIcon._y = (this.__height - this._mcIcon._height) / 2 - _loc2_.yMin;
   }
   function setLabelStyle(bOver)
   {
      if(this._bSelected)
      {
         this._lblLabel.styleName = this.getStyle().labeldownstyle;
      }
      else if(bOver == true && this.getStyle().labeloverstyle != undefined)
      {
         this._lblLabel.styleName = this.getStyle().labeloverstyle;
      }
      else
      {
         this._lblLabel.styleName = this.getStyle().labelupstyle;
      }
   }
   function displayLabel()
   {
      this._lblLabel.text = this._sLabel;
      if(this._bInitialized)
      {
         this.placeLabel();
      }
   }
   function placeLabel()
   {
      this._lblLabel.setSize(this.__width - 2 * this._nLabelPadding,this._lblLabel.textHeight + 4);
      if(this._sLabel.length == 0)
      {
         this._lblLabel._visible = false;
      }
      else
      {
         this._lblLabel._visible = true;
         this._lblLabel._x = (this.__width - this._lblLabel.width) / 2;
         this._lblLabel._y = (this.__height - this._lblLabel.textHeight) / 2 - 4;
      }
   }
   function change(oEvent)
   {
      this.placeLabel();
   }
   function onPress()
   {
      if(!this.selected && !this._bToggle)
      {
         this.selected = true;
      }
      else if(this._bToggle && !this.selected)
      {
         this._mcUp._visible = false;
         this._mcDown._visible = true;
      }
   }
   function onRelease()
   {
      if(this._bRadio)
      {
         this.selected = true;
      }
      else if(this._bToggle)
      {
         this.selected = !this.selected;
      }
      else
      {
         this.selected = false;
      }
      this.dispatchEvent({type:"click"});
   }
   function onReleaseOutside()
   {
      if(this._bToggle)
      {
         if(!this.selected)
         {
            this._mcUp._visible = true;
            this._mcDown._visible = false;
         }
      }
      else
      {
         this.selected = false;
      }
      this.onRollOut();
   }
   function onRollOver()
   {
      this.setLabelStyle(true);
      this.dispatchEvent({type:"over",target:this});
   }
   function onRollOut()
   {
      this.setLabelStyle(false);
      this.dispatchEvent({type:"out",target:this});
   }
}
