class dofus.graphics.gapi.ui.BuffInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "BuffInfos";
   function BuffInfos()
   {
      super();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__data();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.BuffInfos.CLASS_NAME);
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
   }
   function initTexts()
   {
      this._btnClose2.label = this.api.lang.getText("CLOSE");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose2.addEventListener("click",this);
   }
   function updateData()
   {
      this._bvBuffViewer.itemData = this._oData;
   }
   function click(oEvent)
   {
      this.callClose();
   }
}
