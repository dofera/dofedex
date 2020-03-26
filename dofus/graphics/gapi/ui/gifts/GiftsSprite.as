class dofus.graphics.gapi.ui.gifts.GiftsSprite extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Gifts";
   function GiftsSprite()
   {
      super();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      if(this.initialized)
      {
         this.addToQueue({object:this,method:this.updateData});
      }
      return this.__get__data();
   }
   function __get__data()
   {
      return this._oData;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.gifts.GiftsSprite.CLASS_NAME);
   }
   function createChildren()
   {
      this._mcSelect._visible = false;
      this._mcSelect.stop();
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._ldrSprite.addEventListener("initialization",this);
      this._btnBack.addEventListener("click",this);
      this._btnBack.addEventListener("over",this);
      this._btnBack.addEventListener("out",this);
   }
   function updateData()
   {
      if(this._oData != undefined)
      {
         this._lblName.text = this._oData.name;
         this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oData.Level;
         this._ldrSprite.contentPath = this._oData.gfxFile;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._ldrSprite.contentPath = "";
      }
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.clip;
      this.gapi.api.colors.addSprite(_loc3_,this._oData);
      _loc3_.attachMovie("staticF","mcAnim",10);
   }
   function click(oEvent)
   {
      if(this._bEnabled)
      {
         this.dispatchEvent({type:"onSpriteSelected",data:this._oData});
      }
   }
   function over(oEvent)
   {
      if(this._bEnabled)
      {
         this._mcSelect._visible = true;
         this._mcSelect.play();
      }
   }
   function out(oEvent)
   {
      if(this._bEnabled)
      {
         this._mcSelect._visible = false;
         this._mcSelect.stop();
      }
   }
}
