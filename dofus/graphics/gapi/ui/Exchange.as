class dofus.graphics.gapi.ui.Exchange extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Exchange";
   static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
   static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
   static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
   static var READY_COLOR = {ra:70,rb:0,ga:70,gb:0,ba:70,bb:0};
   static var NON_READY_COLOR = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
   static var DELAY_BEFORE_VALIDATE = 3000;
   var _nDistantReadyState = false;
   var _aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
   var _nSelectedTypeID = 0;
   function Exchange()
   {
      super();
   }
   function __set__dataProvider(eaDataProvider)
   {
      this._eaDataProvider.removeEventListener("modelChanged",this);
      this._eaDataProvider = eaDataProvider;
      this._eaDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      return this.__get__dataProvider();
   }
   function __set__localDataProvider(eaLocalDataProvider)
   {
      this._eaLocalDataProvider.removeEventListener("modelChange",this);
      this._eaLocalDataProvider = eaLocalDataProvider;
      this._eaLocalDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      return this.__get__localDataProvider();
   }
   function __set__distantDataProvider(eaDistantDataProvider)
   {
      this._eaDistantDataProvider.removeEventListener("modelChange",this);
      this._eaDistantDataProvider = eaDistantDataProvider;
      this._eaDistantDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      return this.__get__distantDataProvider();
   }
   function __set__readyDataProvider(eaReadyDataProvider)
   {
      this._eaReadyDataProvider.removeEventListener("modelChange",this);
      this._eaReadyDataProvider = eaReadyDataProvider;
      this._eaReadyDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      return this.__get__readyDataProvider();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Exchange.CLASS_NAME);
   }
   function callClose()
   {
      this.api.network.Exchange.leave();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this._btnSelectedFilterButton = this._btnFilterEquipement;
      this.addToQueue({object:this,method:this.initData});
      this.hideItemViewer(true);
      this.addToQueue({object:this,method:this.initTexts});
      this._btnPrivateChat._visible = this.api.datacenter.Exchange.distantPlayerID > 0;
      this.gapi.unloadLastUIAutoHideComponent();
   }
   function addListeners()
   {
      this._cgGrid.addEventListener("dblClickItem",this);
      this._cgGrid.addEventListener("dropItem",this);
      this._cgGrid.addEventListener("dragItem",this);
      this._cgGrid.addEventListener("selectItem",this);
      this._cgLocal.addEventListener("dblClickItem",this);
      this._cgLocal.addEventListener("dropItem",this);
      this._cgLocal.addEventListener("dragItem",this);
      this._cgLocal.addEventListener("selectItem",this);
      this._cgDistant.addEventListener("selectItem",this);
      this._btnFilterEquipement.addEventListener("click",this);
      this._btnFilterNonEquipement.addEventListener("click",this);
      this._btnFilterRessoureces.addEventListener("click",this);
      this._btnFilterEquipement.addEventListener("over",this);
      this._btnFilterNonEquipement.addEventListener("over",this);
      this._btnFilterRessoureces.addEventListener("over",this);
      this._btnFilterEquipement.addEventListener("out",this);
      this._btnFilterNonEquipement.addEventListener("out",this);
      this._btnFilterRessoureces.addEventListener("out",this);
      this._btnClose.addEventListener("click",this);
      this.api.datacenter.Exchange.addEventListener("localKamaChange",this);
      this.api.datacenter.Exchange.addEventListener("distantKamaChange",this);
      this._btnValidate.addEventListener("click",this);
      this._btnPrivateChat.addEventListener("click",this);
      this._cbTypes.addEventListener("itemSelected",this);
   }
   function initTexts()
   {
      this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
      this._winInventory.title = this.api.datacenter.Player.data.name;
      this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
      this._btnValidate.label = this.api.lang.getText("ACCEPT");
      this._lblKama.text = new ank.utils.ExtendedString(this.api.datacenter.Player.Kama).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
      this._btnPrivateChat.label = this.api.lang.getText("WISPER_MESSAGE");
   }
   function initData()
   {
      this.dataProvider = this.api.datacenter.Exchange.inventory;
      this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
      this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
      this.readyDataProvider = this.api.datacenter.Exchange.readyStates;
   }
   function updateData()
   {
      var _loc2_ = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
      this._nSelectedTypeID = _loc2_ != undefined?_loc2_:0;
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = new Object();
      for(var k in this._eaDataProvider)
      {
         var _loc6_ = this._eaDataProvider[k];
         var _loc7_ = _loc6_.position;
         if(_loc7_ == -1 && this._aSelectedSuperTypes[_loc6_.superType])
         {
            if(_loc6_.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
            {
               _loc3_.push(_loc6_);
            }
            var _loc8_ = _loc6_.type;
            if(_loc5_[_loc8_] != true)
            {
               _loc4_.push({label:this.api.lang.getItemTypeText(_loc8_).n,id:_loc8_});
               _loc5_[_loc8_] = true;
            }
         }
      }
      _loc4_.sortOn("label");
      _loc4_.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
      this._cbTypes.dataProvider = _loc4_;
      this.setType(this._nSelectedTypeID);
      this._cgGrid.dataProvider = _loc3_;
   }
   function setType(nTypeID)
   {
      var _loc3_ = this._cbTypes.dataProvider;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(_loc3_[_loc4_].id == nTypeID)
         {
            this._cbTypes.selectedIndex = _loc4_;
            return undefined;
         }
         _loc4_ = _loc4_ + 1;
      }
      this._nSelectedTypeID = 0;
      this._cbTypes.selectedIndex = this._nSelectedTypeID;
   }
   function updateLocalData()
   {
      this._cgLocal.dataProvider = this._eaLocalDataProvider;
      this.hideButtonValidate(true);
      ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
   }
   function updateDistantData()
   {
      this._cgDistant.dataProvider = this._eaDistantDataProvider;
      this.hideButtonValidate(true);
      ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
   }
   function updateReadyState()
   {
      var _loc2_ = !this._eaReadyDataProvider[0]?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
      this.setMovieClipTransform(this._winLocal,_loc2_);
      this.setMovieClipTransform(this._btnValidate,_loc2_);
      this.setMovieClipTransform(this._cgLocal,_loc2_);
      _loc2_ = !this._eaReadyDataProvider[1]?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
      this.setMovieClipTransform(this._winDistant,_loc2_);
      this.setMovieClipTransform(this._cgDistant,_loc2_);
   }
   function hideButtonValidate(bHide)
   {
      var _loc3_ = !bHide?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
      this.setMovieClipTransform(this._btnValidate,_loc3_);
      this._btnValidate.enabled = !bHide;
   }
   function hideItemViewer(bHide)
   {
      this._itvItemViewer._visible = !bHide;
      this._winItemViewer._visible = !bHide;
   }
   function validateDrop(sTargetGrid, oItem, nValue)
   {
      if(nValue < 1 || nValue == undefined)
      {
         return undefined;
      }
      if(nValue > oItem.Quantity)
      {
         nValue = oItem.Quantity;
      }
      switch(sTargetGrid)
      {
         case "_cgGrid":
            this.api.network.Exchange.movementItem(false,oItem.ID,nValue);
            break;
         case "_cgLocal":
            this.api.network.Exchange.movementItem(true,oItem.ID,nValue);
      }
   }
   function validateKama(nQuantity)
   {
      if(nQuantity > this.api.datacenter.Player.Kama)
      {
         nQuantity = this.api.datacenter.Player.Kama;
      }
      this.api.network.Exchange.movementKama(nQuantity);
   }
   function askKamaQuantity()
   {
      var _loc2_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this.api.datacenter.Exchange.localKama,max:this.api.datacenter.Player.Kama,min:0,params:{targetType:"kama"}});
      _loc2_.addEventListener("validate",this);
   }
   function modelChanged(oEvent)
   {
      switch(oEvent.target)
      {
         case this._eaReadyDataProvider:
            this.updateReadyState();
            break;
         case this._eaLocalDataProvider:
            this.updateLocalData();
            break;
         case this._eaDistantDataProvider:
            this.updateDistantData();
            break;
         case this._eaDataProvider:
            this.updateData();
            break;
         default:
            this.updateData();
            this.updateLocalData();
            this.updateDistantData();
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
            this.callClose();
            break;
         case "_btnValidate":
            this.api.network.Exchange.ready();
            break;
         case "_btnPrivateChat":
            if(this.api.datacenter.Exchange.distantPlayerID > 0)
            {
               this.api.kernel.GameManager.askPrivateMessage(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name);
            }
            break;
         default:
            if(oEvent.target != this._btnSelectedFilterButton)
            {
               this._btnSelectedFilterButton.selected = false;
               this._btnSelectedFilterButton = oEvent.target;
               switch(oEvent.target._name)
               {
                  case "_btnFilterEquipement":
                     this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
                     this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                     break;
                  case "_btnFilterNonEquipement":
                     this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_NONEQUIPEMENT;
                     this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                     break;
                  case "_btnFilterRessoureces":
                     this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_RESSOURECES;
                     this._lblFilter.text = this.api.lang.getText("RESSOURECES");
               }
               this.updateData(true);
               break;
            }
            oEvent.target.selected = true;
            break;
      }
   }
   function dblClickItem(oEvent)
   {
      var _loc3_ = oEvent.target.contentData;
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      var _loc4_ = !Key.isDown(Key.CONTROL)?1:_loc3_.Quantity;
      var _loc5_ = oEvent.owner._name;
      switch(_loc5_)
      {
         case "_cgGrid":
            this.validateDrop("_cgLocal",_loc3_,_loc4_);
            break;
         case "_cgLocal":
            this.validateDrop("_cgGrid",_loc3_,_loc4_);
      }
   }
   function dragItem(oEvent)
   {
      this.gapi.removeCursor();
      if(oEvent.target.contentData == undefined)
      {
         return undefined;
      }
      this.gapi.setCursor(oEvent.target.contentData);
   }
   function dropItem(oEvent)
   {
      var _loc3_ = this.gapi.getCursor();
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      this.gapi.removeCursor();
      var _loc4_ = oEvent.target._parent._parent._name;
      switch(_loc4_)
      {
         case "_cgGrid":
            if(_loc3_.position == -1)
            {
               return undefined;
            }
            break;
         case "_cgLocal":
            if(_loc3_.position == -2)
            {
               return undefined;
            }
            break;
      }
      if(_loc3_.Quantity > 1)
      {
         var _loc5_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:_loc3_.Quantity,params:{targetType:"item",oItem:_loc3_,targetGrid:_loc4_}});
         _loc5_.addEventListener("validate",this);
      }
      else
      {
         this.validateDrop(_loc4_,_loc3_,1);
      }
   }
   function selectItem(oEvent)
   {
      if(oEvent.target.contentData == undefined)
      {
         this.hideItemViewer(true);
      }
      else
      {
         if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
         {
            this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
            return undefined;
         }
         this.hideItemViewer(false);
         this._itvItemViewer.itemData = oEvent.target.contentData;
      }
   }
   function validate(oEvent)
   {
      switch(oEvent.params.targetType)
      {
         case "item":
            this.validateDrop(oEvent.params.targetGrid,oEvent.params.oItem,oEvent.value);
            break;
         case "kama":
            this.validateKama(oEvent.value);
      }
   }
   function localKamaChange(oEvent)
   {
      this._lblLocalKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
      this._lblKama.text = new ank.utils.ExtendedString(this.api.datacenter.Player.Kama - oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
      this.hideButtonValidate(true);
      ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
   }
   function distantKamaChange(oEvent)
   {
      this._mcBlink.play();
      this._lblDistantKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
      this.hideButtonValidate(true);
      ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
   }
   function itemSelected(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_cbTypes")
      {
         this._nSelectedTypeID = this._cbTypes.selectedItem.id;
         this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
         this.updateData();
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnFilterEquipement:
            this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),oEvent.target,-20);
            break;
         case this._btnFilterNonEquipement:
            this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),oEvent.target,-20);
            break;
         case this._btnFilterRessoureces:
            this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.api.ui.hideTooltip();
   }
}
