class dofus.graphics.gapi.ui.ChooseFeed extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "LivingItemsViewer";
   function ChooseFeed()
   {
      super();
   }
   function __set__itemsType(aTypes)
   {
      this._aFiltersType = aTypes;
      if(this._eaDataProvider)
      {
         this.updateData();
      }
      return this.__get__itemsType();
   }
   function __set__item(oData)
   {
      this._oItem = oData;
      return this.__get__item();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ChooseFeed.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnValid.addEventListener("click",this);
      this._bgh.addEventListener("click",this);
      this._cgGrid.addEventListener("selectItem",this);
      this._cgGrid.addEventListener("overItem",this);
      this._cgGrid.addEventListener("outItem",this);
      this._cgGrid.addEventListener("dblClickItem",this);
   }
   function initTexts()
   {
      this._btnValid.label = this.api.lang.getText("VALIDATE");
      this._winBg.title = this.api.lang.getText("FEED_ITEM");
      this._lblNoItem.text = this.api.lang.getText("SELECT_ITEM");
   }
   function updateData()
   {
      this._eaDataProvider = this.api.datacenter.Player.Inventory;
      this._itvItemViewer._visible = false;
      this._mcItvIconBg._visible = false;
      var _loc2_ = new ank.utils.ExtendedArray();
      for(var k in this._eaDataProvider)
      {
         var _loc3_ = this._eaDataProvider[k];
         var _loc4_ = 0;
         while(_loc4_ < this._aFiltersType.length)
         {
            if(_loc3_.type == this._aFiltersType[_loc4_] && (!_loc3_.skineable && (_loc3_.position == -1 && _loc3_.canBeExchange)))
            {
               _loc2_.push(_loc3_);
               break;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      if(_loc2_.length)
      {
         this._cgGrid.dataProvider = _loc2_;
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_NO_FOOD_LIVING_ITEM",[this._oItem.name]),"ERROR_BOX",{name:"noItem",listener:this});
         this.callClose();
      }
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function validate(oItem, noConfirm)
   {
      if(!oItem.ID)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("SELECT_ITEM"),"ERROR_BOX",{name:"noSelection",listener:this});
         return undefined;
      }
      if(!noConfirm)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_FOOD_LIVING_ITEM"),"CAUTION_YESNO",{name:"Confirm",params:{oItem:oItem},listener:this});
         return undefined;
      }
      this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FEED);
      this.api.network.Items.feed(this._oItem.ID,this._oItem.position,oItem.ID);
      this.callClose();
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._bgh:
         case this._btnClose:
            this.callClose();
            break;
         case this._btnValid:
            this.validate(this._cgGrid.selectedItem.contentData);
      }
   }
   function dblClickItem(oEvent)
   {
      this.validate(oEvent.target.contentData);
   }
   function selectItem(oEvent)
   {
      this._itvItemViewer.itemData = oEvent.target.contentData;
      this._itvItemViewer._visible = true;
      this._mcItvIconBg._visible = true;
      this._lblNoItem._visible = false;
   }
   function overItem(oEvent)
   {
      this.gapi.showTooltip(oEvent.target.contentData.name,oEvent.target,-20,undefined,oEvent.target.contentData.style + "ToolTip");
   }
   function outItem(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function yes(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoConfirm")
      {
         this.validate(oEvent.params.oItem,true);
      }
   }
}
