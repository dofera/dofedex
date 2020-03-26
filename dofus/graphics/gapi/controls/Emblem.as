class dofus.graphics.gapi.controls.Emblem extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "Emblem";
   var _bShadow = false;
   function Emblem()
   {
      super();
   }
   function __set__shadow(bShadow)
   {
      this._bShadow = bShadow;
      return this.__get__shadow();
   }
   function __get__shadow()
   {
      return this._bShadow;
   }
   function __set__backID(nBackID)
   {
      this._sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + nBackID + ".swf";
      if(this.initialized)
      {
         this.layoutBack();
      }
      return this.__get__backID();
   }
   function __set__backColor(nBackColor)
   {
      this._nBackColor = nBackColor;
      if(this.initialized)
      {
         this.layoutBack();
      }
      return this.__get__backColor();
   }
   function __set__upID(nUpID)
   {
      this._sUpFile = dofus.Constants.EMBLEMS_UP_PATH + nUpID + ".swf";
      if(this.initialized)
      {
         this.layoutUp();
      }
      return this.__get__upID();
   }
   function __set__upColor(nUpColor)
   {
      this._nUpColor = nUpColor;
      if(this.initialized)
      {
         this.layoutUp();
      }
      return this.__get__upColor();
   }
   function __set__data(oData)
   {
      this._sBackFile = dofus.Constants.EMBLEMS_BACK_PATH + oData.backID + ".swf";
      this._nBackColor = oData.backColor;
      this._sUpFile = dofus.Constants.EMBLEMS_UP_PATH + oData.upID + ".swf";
      this._nUpColor = oData.upColor;
      if(this.initialized)
      {
         this.layoutBack();
         this.layoutUp();
      }
      return this.__get__data();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.Emblem.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.layoutContent});
   }
   function initScale()
   {
   }
   function addListeners()
   {
      this._ldrEmblemBack.addEventListener("initialization",this);
      this._ldrEmblemUp.addEventListener("initialization",this);
   }
   function layoutContent()
   {
      if(this._sBackFile != undefined)
      {
         if(this._bShadow)
         {
            this._ldrEmblemShadow.contentPath = this._sBackFile;
            var _loc2_ = new Color(this._ldrEmblemShadow);
            _loc2_.setRGB(16777215);
         }
         this._ldrEmblemShadow._visible = this._bShadow;
         this.layoutBack();
         this.layoutUp();
      }
   }
   function layoutBack()
   {
      if(this._ldrEmblemBack.contentPath == this._sBackFile)
      {
         this.applyBackColor();
      }
      else
      {
         this._ldrEmblemBack.contentPath = this._sBackFile;
      }
   }
   function layoutUp()
   {
      if(this._ldrEmblemUp.contentPath == this._sUpFile)
      {
         this.applyUpColor();
      }
      else
      {
         this._ldrEmblemUp.contentPath = this._sUpFile;
      }
   }
   function applyBackColor()
   {
      this.setMovieClipColor(this._ldrEmblemBack.content.back,this._nBackColor);
   }
   function applyUpColor()
   {
      this.setMovieClipColor(this._ldrEmblemUp.content,this._nUpColor);
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.target;
      switch(_loc3_._name)
      {
         case "_ldrEmblemBack":
            this.applyBackColor();
            break;
         case "_ldrEmblemUp":
            this.applyUpColor();
      }
   }
}
