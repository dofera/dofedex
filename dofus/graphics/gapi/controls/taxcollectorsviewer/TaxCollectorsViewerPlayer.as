class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerPlayer extends ank.gapi.core.UIBasicComponent
{
   function TaxCollectorsViewerPlayer()
   {
      super();
   }
   function __set__data(oData)
   {
      if(oData != this._oData)
      {
         this._oData = oData;
         this.addToQueue({object:this,method:this.setSprite});
      }
      return this.__get__data();
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._ldrSprite.addEventListener("initialization",this);
   }
   function setSprite()
   {
      this._ldrSprite.contentPath = this._oData.gfxFile != undefined?this._oData.gfxFile:"";
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.clip;
      _global.GAC.addSprite(_loc3_,this._oData);
      _loc3_.attachMovie("staticR","mcAnim",10);
      _loc3_._xscale = -80;
      _loc3_._yscale = 80;
   }
}
