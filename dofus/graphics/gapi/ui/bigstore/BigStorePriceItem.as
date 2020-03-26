class dofus.graphics.gapi.ui.bigstore.BigStorePriceItem extends ank.gapi.core.UIBasicComponent
{
   function BigStorePriceItem()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function __set__row(mcRow)
   {
      this._mcRow = mcRow;
      return this.__get__row();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      delete this._nSelectedSet;
      if(bUsed)
      {
         this._oItem = oItem;
         var _loc5_ = this._mcList._parent._parent.isThisPriceSelected(oItem.id,1);
         var _loc6_ = this._mcList._parent._parent.isThisPriceSelected(oItem.id,2);
         var _loc7_ = this._mcList._parent._parent.isThisPriceSelected(oItem.id,3);
         if(_loc5_)
         {
            var _loc8_ = this._btnPriceSet1;
         }
         if(_loc6_)
         {
            _loc8_ = this._btnPriceSet2;
         }
         if(_loc7_)
         {
            _loc8_ = this._btnPriceSet3;
         }
         if(_loc5_ || (_loc6_ || _loc7_))
         {
            var _loc9_ = this._btnBuy;
         }
         if(_loc9_ != undefined)
         {
            this._mcList._parent._parent.setButtons(_loc8_,_loc9_);
         }
         this._btnPriceSet1.selected = _loc5_ && !_global.isNaN(oItem.priceSet1);
         this._btnPriceSet2.selected = _loc6_ && !_global.isNaN(oItem.priceSet2);
         this._btnPriceSet3.selected = _loc7_ && !_global.isNaN(oItem.priceSet3);
         if(_loc5_)
         {
            this._nSelectedSet = 1;
         }
         else if(_loc6_)
         {
            this._nSelectedSet = 2;
         }
         else if(_loc7_)
         {
            this._nSelectedSet = 3;
         }
         this._btnBuy.enabled = this._nSelectedSet != undefined;
         this._btnBuy._visible = true;
         this._btnPriceSet1._visible = true;
         this._btnPriceSet2._visible = true;
         this._btnPriceSet3._visible = true;
         this._btnPriceSet1.enabled = !_global.isNaN(oItem.priceSet1);
         this._btnPriceSet2.enabled = !_global.isNaN(oItem.priceSet2);
         this._btnPriceSet3.enabled = !_global.isNaN(oItem.priceSet3);
         this._btnPriceSet1.label = !_global.isNaN(oItem.priceSet1)?new ank.utils.ExtendedString(oItem.priceSet1).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
         this._btnPriceSet2.label = !_global.isNaN(oItem.priceSet2)?new ank.utils.ExtendedString(oItem.priceSet2).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
         this._btnPriceSet3.label = !_global.isNaN(oItem.priceSet3)?new ank.utils.ExtendedString(oItem.priceSet3).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
         this._ldrIcon.contentParams = oItem.item.params;
         this._ldrIcon.contentPath = oItem.item.iconFile;
      }
      else if(this._ldrIcon.contentPath != undefined)
      {
         this._btnPriceSet1._visible = false;
         this._btnPriceSet2._visible = false;
         this._btnPriceSet3._visible = false;
         this._btnBuy._visible = false;
         this._ldrIcon.contentPath = "";
      }
   }
   function init()
   {
      super.init(false);
      this._btnPriceSet1._visible = false;
      this._btnPriceSet2._visible = false;
      this._btnPriceSet3._visible = false;
      this._btnBuy._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
      this._btnPriceSet1.addEventListener("click",this);
      this._btnPriceSet2.addEventListener("click",this);
      this._btnPriceSet3.addEventListener("click",this);
      this._btnBuy.addEventListener("click",this);
   }
   function initTexts()
   {
      this._btnBuy.label = this._mcList.gapi.api.lang.getText("BUY");
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnPriceSet1":
         case "_btnPriceSet2":
         case "_btnPriceSet3":
            var _loc3_ = Number(oEvent.target._name.substr(12));
            this._mcList._parent._parent.selectPrice(this._oItem,_loc3_,oEvent.target,this._btnBuy);
            if(oEvent.target.selected)
            {
               this._nSelectedSet = _loc3_;
               this._mcRow.select();
               this._btnBuy.enabled = true;
            }
            else
            {
               delete this._nSelectedSet;
               this._btnBuy.enabled = false;
            }
            break;
         case "_btnBuy":
            if(!this._nSelectedSet || _global.isNaN(this._nSelectedSet))
            {
               this._btnBuy.enabled = false;
               return undefined;
            }
            this._mcList._parent._parent.askBuy(this._oItem.item,this._nSelectedSet,this._oItem["priceSet" + this._nSelectedSet]);
            this._mcList._parent._parent.askMiddlePrice(this._oItem.item);
            break;
      }
   }
}
