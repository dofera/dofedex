class dofus.graphics.gapi.controls.BuffViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "BuffViewer";
   function BuffViewer()
   {
      super();
   }
   function __set__itemData(oItem)
   {
      this._oItem = oItem;
      this.addToQueue({object:this,method:this.showItemData,params:[oItem]});
      return this.__get__itemData();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.BuffViewer.CLASS_NAME);
   }
   function createChildren()
   {
   }
   function showItemData(oItem)
   {
      if(oItem != undefined)
      {
         this._lblName.text = oItem.name;
         this._txtDescription.text = oItem.description;
         this._ldrIcon.contentPath = oItem.iconFile;
         this._lstInfos.dataProvider = oItem.effects;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._txtDescription.text = "";
         this._ldrIcon.contentPath = "";
         this._lstInfos.removeAll();
      }
   }
}
