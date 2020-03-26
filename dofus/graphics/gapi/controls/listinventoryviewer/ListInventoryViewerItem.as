class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItem extends ank.gapi.core.UIBasicComponent
{
   function ListInventoryViewerItem()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._lblPrice.text = !bUsed?"":new ank.utils.ExtendedString(oItem.price).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
         var _loc5_ = this._lblPrice.textWidth;
         this._lblName.text = !bUsed?"":(oItem.Quantity <= 1?"":"x" + oItem.Quantity + " ") + oItem.name;
         this._lblName.setSize(this.__width - _loc5_ - 30,this.__height);
         this._lblName.styleName = oItem.style != ""?oItem.style + "LeftSmallLabel":"BrownLeftSmallLabel";
         this._ldrIcon.contentPath = !bUsed?"":oItem.iconFile;
         this._ldrIcon.contentParams = oItem.params;
      }
      else if(this._lblPrice.text != undefined)
      {
         this._lblPrice.text = "";
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
      this._lblName.setSize(this.__width - 50,this.__height);
      this._lblPrice.setSize(this.__width - 20,this.__height);
   }
}
