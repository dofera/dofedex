class dofus.graphics.gapi.ui.ItemFound extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ItemFound";
   var _nTimer = 0;
   function ItemFound()
   {
      super();
   }
   function __set__itemId(nId)
   {
      this._nItemId = nId;
      return this.__get__itemId();
   }
   function __set__qty(nQty)
   {
      this._nQty = nQty;
      return this.__get__qty();
   }
   function __set__ressourceId(nRessourceId)
   {
      this._nRessourceId = nRessourceId;
      return this.__get__ressourceId();
   }
   function __set__timer(nTimer)
   {
      this._nTimer = nTimer;
      return this.__get__timer();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ItemFound.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      if(this._nTimer != 0)
      {
         ank.utils.Timer.setTimer(this,"itemFound",this,this.hide,this._nTimer);
      }
   }
   function initTexts()
   {
      var _loc2_ = new dofus.datacenter.Item(0,this._nItemId,this._nQty);
      var _loc3_ = new dofus.datacenter.Item(0,this._nRessourceId,1);
      this._ldrItem.contentPath = _loc2_.iconFile;
      this._txtDescription.text = this.api.lang.getText("ITEM_FOUND",[this._nQty,_loc2_.name,_loc3_.name]);
   }
   function hide()
   {
      this._alpha = this._alpha - 5;
      if(this._alpha < 1)
      {
         this.unloadThis();
         return undefined;
      }
      this.addToQueue({object:this,method:this.hide});
   }
}
