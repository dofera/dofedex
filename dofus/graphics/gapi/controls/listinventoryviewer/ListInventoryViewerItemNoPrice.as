class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItemNoPrice extends ank.gapi.core.UIBasicComponent
{
   function ListInventoryViewerItemNoPrice()
   {
      super();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._lblName.text = !bUsed?"":(oItem.Quantity <= 1?"":"x" + oItem.Quantity + " ") + oItem.name;
         this._ldrIcon.contentPath = !bUsed?"":oItem.iconFile;
         this._ldrIcon.contentParams = oItem.params;
         this._lblName.styleName = oItem.style != ""?oItem.style + "LeftSmallLabel":"BrownLeftSmallLabel";
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._ldrIcon.contentPath = "";
      }
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.arrange();
   }
   function size()
   {
      super.size();
      this.addToQueue({object:this,method:this.arrange});
   }
   function arrange()
   {
      this._lblName.setSize(this.__width - 20,this.__height);
   }
}
