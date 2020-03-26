class dofus.graphics.gapi.ui.ItemViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ItemViewer";
   function ItemViewer()
   {
      super();
   }
   function __set__item(oItem)
   {
      this._oItem = oItem;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__item();
   }
   function __get__item()
   {
      return this._oItem;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ItemViewer.CLASS_NAME);
   }
   function destroy()
   {
      this.gapi.hideTooltip();
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._mcTooltip.onRollOver = function()
      {
         this._parent.onTooltipOver();
      };
      this._mcTooltip.onRollOut = function()
      {
         this._parent.onTooltipOut();
      };
   }
   function updateData()
   {
      this._itvItemViewer.itemData = this._oItem;
   }
   function initTexts()
   {
      this._btnClose.label = this.api.lang.getText("CLOSE");
      this._lblWarning.text = this.api.lang.getText("ITEMS_CHAT_WARNING");
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnClose)
      {
         this.callClose();
      }
   }
   function onTooltipOut()
   {
      this.gapi.hideTooltip();
   }
   function onTooltipOver()
   {
      this.gapi.showTooltip(this.api.lang.getText("ITEMS_CHAT_WARNING_ROLLOVER"),this._mcTooltip,14);
   }
}
