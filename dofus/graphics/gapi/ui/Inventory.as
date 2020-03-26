class dofus.graphics.gapi.ui.Inventory extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Inventory";
   static var CONTAINER_BY_TYPE = {type1:["_ctr0"],type2:["_ctr1"],type3:["_ctr2","_ctr4"],type4:["_ctr3"],type5:["_ctr5"],type6:["_ctrMount"],type8:["_ctr1"],type9:["_ctr8","_ctrMount"],type10:["_ctr6"],type11:["_ctr7"],type12:["_ctr8","_ctr16"],type13:["_ctr9","_ctr10","_ctr11","_ctr12","_ctr13","_ctr14"],type7:["_ctr15"]};
   static var SUPERTYPE_NOT_EQUIPABLE = [9,14,15,16,17,18,6,19,21,20,8,22];
   static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
   static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
   static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
   static var FILTER_QUEST = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,true];
   var _nSelectedTypeID = 0;
   function Inventory()
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
   function showCharacterPreview(bShow)
   {
      if(bShow)
      {
         this._winPreview._visible = true;
         this._svCharacterViewer._visible = true;
         this._mcItemSetViewerPlacer._x = this._mcBottomPlacer._x;
         this._mcItemSetViewerPlacer._y = this._mcBottomPlacer._y;
         this._isvItemSetViewer._x = this._mcBottomPlacer._x;
         this._isvItemSetViewer._y = this._mcBottomPlacer._y;
      }
      else
      {
         this._winPreview._visible = false;
         this._svCharacterViewer._visible = false;
         this._mcItemSetViewerPlacer._x = this._winPreview._x;
         this._mcItemSetViewerPlacer._y = this._winPreview._y;
         this._isvItemSetViewer._x = this._winPreview._x;
         this._isvItemSetViewer._y = this._winPreview._y;
      }
   }
   function showLivingItems(bShow)
   {
      this._livItemViewer._visible = bShow;
      this._winLivingItems._visible = bShow;
      if(bShow)
      {
         this._winPreview._visible = false;
         this._svCharacterViewer._visible = false;
         this._mcItemSetViewerPlacer._x = this._mcBottomPlacer._x;
         this._mcItemSetViewerPlacer._y = this._mcBottomPlacer._y;
         this._isvItemSetViewer._x = this._mcBottomPlacer._x;
         this._isvItemSetViewer._y = this._mcBottomPlacer._y;
      }
      else
      {
         this.showCharacterPreview(this.api.kernel.OptionsManager.getOption("CharacterPreview"));
      }
   }
   function showItemInfos(oItem)
   {
      if(oItem == undefined)
      {
         this.hideItemViewer(true);
         this.hideItemSetViewer(true);
      }
      else
      {
         this.hideItemViewer(false);
         var _loc3_ = oItem.clone();
         if(_loc3_.realGfx)
         {
            _loc3_.gfx = _loc3_.realGfx;
         }
         this._itvItemViewer.itemData = _loc3_;
         if(oItem.isFromItemSet)
         {
            var _loc4_ = this.api.datacenter.Player.ItemSets.getItemAt(oItem.itemSetID);
            if(_loc4_ == undefined)
            {
               _loc4_ = new dofus.datacenter.ItemSet(oItem.itemSetID,"",[]);
            }
            this.hideItemSetViewer(false);
            this._isvItemSetViewer.itemSet = _loc4_;
         }
         else
         {
            this.hideItemSetViewer(true);
         }
      }
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Inventory.CLASS_NAME);
      this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Items");
      this.showCharacterPreview(this.api.kernel.OptionsManager.getOption("CharacterPreview"));
      this.showLivingItems(false);
   }
   function destroy()
   {
      this.gapi.hideTooltip();
      if(this.api.datacenter.Game.isFight)
      {
         this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
      }
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this._winBg.onRelease = function()
      {
      };
      this._winBg.useHandCursor = false;
      this._winLivingItems.onRelease = function()
      {
      };
      this._winLivingItems.useHandCursor = false;
      this.addToQueue({object:this,method:this.hideEpisodicContent});
      this.addToQueue({object:this,method:this.initFilter});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.hideItemViewer(true);
      this.hideItemSetViewer(true);
      this._ctrShield = this._ctr15;
      this._ctrWeapon = this._ctr1;
      this._ctrMount = this._ctr16;
      this._mcTwoHandedLink._visible = false;
      this._mcTwoHandedLink.stop();
      this._mcTwoHandedCrossLeft._visible = false;
      this._mcTwoHandedCrossRight._visible = false;
      Mouse.addListener(this);
      this.api.datacenter.Player.addEventListener("kamaChanged",this);
      this.api.datacenter.Player.addEventListener("mountChanged",this);
      this.addToQueue({object:this,method:this.kamaChanged,params:[{value:this.api.datacenter.Player.Kama}]});
      this.addToQueue({object:this,method:this.mountChanged});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this.addToQueue({object:this,method:this.setSubComponentsStyle,params:[_loc2_]});
   }
   function setSubComponentsStyle(oStyle)
   {
      this._itvItemViewer.styleName = oStyle.itenviewerstyle;
   }
   function hideEpisodicContent()
   {
      if(this.api.datacenter.Basics.aks_current_regional_version < 20)
      {
         this._ctrMount._visible = false;
         this._mcMountCross._visible = false;
      }
      else
      {
         this._ctrMount._visible = true;
      }
   }
   function addListeners()
   {
      this._cgGrid.addEventListener("dropItem",this);
      this._cgGrid.addEventListener("dragItem",this);
      this._cgGrid.addEventListener("selectItem",this);
      this._cgGrid.addEventListener("overItem",this);
      this._cgGrid.addEventListener("outItem",this);
      this._cgGrid.addEventListener("dblClickItem",this);
      this._btnFilterEquipement.addEventListener("click",this);
      this._btnFilterNonEquipement.addEventListener("click",this);
      this._btnFilterRessoureces.addEventListener("click",this);
      this._btnFilterQuest.addEventListener("click",this);
      this._btnFilterEquipement.addEventListener("over",this);
      this._btnFilterNonEquipement.addEventListener("over",this);
      this._btnFilterRessoureces.addEventListener("over",this);
      this._btnFilterQuest.addEventListener("over",this);
      this._btnFilterEquipement.addEventListener("out",this);
      this._btnFilterNonEquipement.addEventListener("out",this);
      this._btnFilterRessoureces.addEventListener("out",this);
      this._btnFilterQuest.addEventListener("out",this);
      this._btnClose.addEventListener("click",this);
      this._itvItemViewer.addEventListener("useItem",this);
      this._itvItemViewer.addEventListener("destroyItem",this);
      this._itvItemViewer.addEventListener("targetItem",this);
      this._cbTypes.addEventListener("itemSelected",this);
      for(var a in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
      {
         var _loc2_ = dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[a];
         var _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            var _loc4_ = this[_loc2_[_loc3_]];
            _loc4_.addEventListener("over",this);
            _loc4_.addEventListener("out",this);
            if(_loc4_.toolTipText == undefined)
            {
               _loc4_.toolTipText = this.api.lang.getText(_loc4_ != this._ctrMount?"INVENTORY_" + a.toUpperCase():"MOUNT");
            }
            _loc3_ = _loc3_ + 1;
         }
      }
   }
   function initTexts()
   {
      this._lblWeight.text = this.api.lang.getText("WEIGHT");
      this._winPreview.title = this.api.lang.getText("CHARACTER_PREVIEW",[this.api.datacenter.Player.Name]);
      this._winBg.title = this.api.lang.getText("INVENTORY");
      this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
      this._lblNoItem.text = this.api.lang.getText("SELECT_ITEM");
      this._winLivingItems.title = this.api.lang.getText("MANAGE_ITEM");
   }
   function initFilter()
   {
      switch(this.api.datacenter.Basics.inventory_filter)
      {
         case "nonequipement":
            this._btnFilterNonEquipement.selected = true;
            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
            this._btnSelectedFilterButton = this._btnFilterNonEquipement;
            break;
         case "resources":
            this._btnFilterRessoureces.selected = true;
            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
            this._btnSelectedFilterButton = this._btnFilterRessoureces;
            break;
         case "quest":
            this._btnFilterQuest.selected = true;
            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
            this._btnSelectedFilterButton = this._btnFilterQuest;
            break;
         case "equipement":
         default:
            this._btnFilterEquipement.selected = true;
            this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
            this._btnSelectedFilterButton = this._btnFilterEquipement;
      }
   }
   function initData()
   {
      this._svCharacterViewer.zoom = 250;
      this._svCharacterViewer.spriteData = (ank.battlefield.datacenter.Sprite)this.api.datacenter.Player.data;
      this.dataProvider = this.api.datacenter.Player.Inventory;
   }
   function enabledFromSuperType(oItem)
   {
      var _loc3_ = oItem.superType;
      if(_loc3_ != undefined)
      {
         for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
         {
            for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
            {
               var _loc4_ = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
               _loc4_.enabled = false;
               _loc4_.selected = false;
            }
         }
         var _loc5_ = this.api.lang.getItemSuperTypeText(_loc3_);
         if(_loc5_)
         {
            for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_])
            {
               var _loc6_ = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_][i]];
               if(!(_loc3_ == 9 && _loc6_.contentPath == ""))
               {
                  _loc6_.enabled = true;
                  _loc6_.selected = true;
               }
            }
         }
         else
         {
            for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_])
            {
               var _loc8_ = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_][i]];
               if(_loc8_.contentData == undefined)
               {
                  var _loc7_ = _loc8_;
               }
               else if(_loc8_.contentData.unicID == oItem.unicID)
               {
                  return undefined;
               }
            }
            if(_loc7_ != undefined)
            {
               _loc7_.enabled = true;
               _loc7_.selected = true;
            }
         }
         if(oItem.needTwoHands)
         {
            this._mcTwoHandedCrossLeft._visible = true;
            this._mcTwoHandedCrossRight._visible = false;
            this._ctrShield.content._alpha = 30;
            this._mcTwoHandedLink.play();
            this._mcTwoHandedLink._visible = true;
         }
         if(_loc3_ == 7 && this.api.datacenter.Player.weaponItem.needTwoHands)
         {
            this._mcTwoHandedCrossLeft._visible = false;
            this._mcTwoHandedCrossRight._visible = true;
            this._ctrWeapon.content._alpha = 30;
            this._mcTwoHandedLink.play();
            this._mcTwoHandedLink._visible = true;
         }
      }
      else
      {
         for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
         {
            for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
            {
               var _loc9_ = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
               _loc9_.enabled = true;
               if(_loc9_.selected)
               {
                  _loc9_.selected = false;
               }
            }
         }
         if(this.api.datacenter.Player.weaponItem.needTwoHands)
         {
            this._mcTwoHandedLink.gotoAndStop(1);
            this._mcTwoHandedLink._visible = true;
            this._mcTwoHandedCrossLeft._visible = true;
         }
      }
   }
   function updateData(bOnlyGrid)
   {
      var _loc3_ = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
      this._nSelectedTypeID = _loc3_ != undefined?_loc3_:0;
      var _loc4_ = new Object();
      if(!bOnlyGrid)
      {
         for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
         {
            for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
            {
               _loc4_[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]] = true;
            }
         }
      }
      var _loc5_ = new ank.utils.ExtendedArray();
      var _loc6_ = new ank.utils.ExtendedArray();
      var _loc7_ = new Object();
      for(var k in this._eaDataProvider)
      {
         var _loc8_ = this._eaDataProvider[k];
         var _loc9_ = _loc8_.position;
         if(_loc9_ != -1)
         {
            if(!bOnlyGrid)
            {
               var _loc10_ = this["_ctr" + _loc9_];
               _loc10_.contentData = _loc8_;
               delete register4[_loc10_._name];
            }
         }
         else if(this._aSelectedSuperTypes[_loc8_.superType])
         {
            if(_loc8_.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
            {
               _loc5_.push(_loc8_);
            }
            var _loc11_ = _loc8_.type;
            if(_loc7_[_loc11_] != true)
            {
               _loc6_.push({label:this.api.lang.getItemTypeText(_loc11_).n,id:_loc11_});
               _loc7_[_loc11_] = true;
            }
         }
      }
      _loc6_.sortOn("label");
      _loc6_.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
      this._cbTypes.dataProvider = _loc6_;
      this.setType(this._nSelectedTypeID);
      this._cgGrid.dataProvider = _loc5_;
      if(!bOnlyGrid)
      {
         for(var k in _loc4_)
         {
            if(this[k] != this._ctrMount)
            {
               this[k].contentData = undefined;
            }
         }
      }
      this.resetTwoHandClip();
   }
   function resetTwoHandClip()
   {
      this._ctrShield.content._alpha = 100;
      this._ctrWeapon.content._alpha = 100;
      this._mcTwoHandedLink.gotoAndStop(1);
      if(this.api.datacenter.Player.weaponItem.needTwoHands)
      {
         this._mcTwoHandedLink._visible = true;
         this._mcTwoHandedCrossLeft._visible = true;
         this._mcTwoHandedCrossRight._visible = false;
      }
      else
      {
         this._mcTwoHandedLink._visible = false;
         this._mcTwoHandedCrossLeft._visible = false;
         this._mcTwoHandedCrossRight._visible = false;
      }
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
   function canMoveItem()
   {
      var _loc2_ = this.api.datacenter.Game.isRunning;
      var _loc3_ = this.api.datacenter.Exchange != undefined;
      if(_loc2_ || _loc3_)
      {
         this.gapi.loadUIComponent("AskOk","AskOkInventory",{title:this.api.lang.getText("INFORMATIONS"),text:this.api.lang.getText("CANT_MOVE_ITEM")});
      }
      return !(_loc2_ || _loc3_);
   }
   function askDestroy(oItem, nQuantity)
   {
      if(oItem.Quantity == 1)
      {
         var _loc4_ = this.gapi.loadUIComponent("AskYesNo","AskYesNoDestroy",{title:this.api.lang.getText("QUESTION"),text:this.api.lang.getText("DO_U_DESTROY",[nQuantity,oItem.name]),params:{item:oItem,quantity:nQuantity}});
         _loc4_.addEventListener("yes",this);
      }
      else
      {
         this.api.network.Items.destroy(oItem.ID,nQuantity);
      }
   }
   function hideItemViewer(bHide)
   {
      this._itvItemViewer._visible = !bHide;
      this._mcItvDescBg._visible = !bHide;
      this._mcItvIconBg._visible = !bHide;
   }
   function hideItemSetViewer(bHide)
   {
      if(bHide)
      {
         this._isvItemSetViewer.removeMovieClip();
      }
      else if(this._isvItemSetViewer == undefined)
      {
         this.attachMovie("ItemSetViewer","_isvItemSetViewer",this.getNextHighestDepth(),{_x:this._mcItemSetViewerPlacer._x,_y:this._mcItemSetViewerPlacer._y});
      }
   }
   function kamaChanged(oEvent)
   {
      this._lblKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
   }
   function click(oEvent)
   {
      if(oEvent.target == this._btnClose)
      {
         this.callClose();
         return undefined;
      }
      if(this._mcArrowAnimation._visible)
      {
         this._mcArrowAnimation._visible = false;
      }
      if(oEvent.target != this._btnSelectedFilterButton)
      {
         this.api.sounds.events.onInventoryFilterButtonClick();
         this._btnSelectedFilterButton.selected = false;
         this._btnSelectedFilterButton = oEvent.target;
         switch(oEvent.target._name)
         {
            case "_btnFilterEquipement":
               this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
               this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
               this.api.datacenter.Basics.inventory_filter = "equipement";
               break;
            case "_btnFilterNonEquipement":
               this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
               this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
               this.api.datacenter.Basics.inventory_filter = "nonequipement";
               break;
            case "_btnFilterRessoureces":
               this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
               this._lblFilter.text = this.api.lang.getText("RESSOURECES");
               this.api.datacenter.Basics.inventory_filter = "resources";
               break;
            case "_btnFilterQuest":
               this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
               this._lblFilter.text = this.api.lang.getText("QUEST_OBJECTS");
               this.api.datacenter.Basics.inventory_filter = "quest";
         }
         this.updateData(true);
      }
      else
      {
         oEvent.target.selected = true;
      }
   }
   function modelChanged(oEvent)
   {
      switch(oEvent.eventName)
      {
         case "updateOne":
         case "updateAll":
      }
      this.updateData(false);
      this.hideItemViewer(true);
      this.hideItemSetViewer(true);
      this.showLivingItems(false);
   }
   function onMouseUp()
   {
      this.addToQueue({object:this,method:this.enabledFromSuperType});
   }
   function dragItem(oEvent)
   {
      this.gapi.removeCursor();
      if(!this.canMoveItem())
      {
         return undefined;
      }
      if(oEvent.target.contentData == undefined)
      {
         return undefined;
      }
      if(oEvent.target.contentData.isCursed)
      {
         return undefined;
      }
      this.enabledFromSuperType(oEvent.target.contentData);
      this.gapi.setCursor(oEvent.target.contentData);
   }
   function dropItem(oEvent)
   {
      if(!this.canMoveItem())
      {
         return undefined;
      }
      var _loc3_ = this.gapi.getCursor();
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      if(oEvent.target._parent == this)
      {
         var _loc4_ = Number(oEvent.target._name.substr(4));
      }
      else
      {
         if(_loc3_.position == -1)
         {
            this.resetTwoHandClip();
            return undefined;
         }
         _loc4_ = -1;
      }
      if(_loc3_.position == _loc4_)
      {
         this.resetTwoHandClip();
         return undefined;
      }
      this.gapi.removeCursor();
      if(_loc3_.Quantity > 1 && (_loc4_ == -1 || _loc4_ == 16))
      {
         var _loc5_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:_loc3_.Quantity,max:_loc3_.Quantity,params:{type:"move",position:_loc4_,item:_loc3_}});
         _loc5_.addEventListener("validate",this);
      }
      else
      {
         this.api.network.Items.movement(_loc3_.ID,_loc4_);
      }
   }
   function selectItem(oEvent)
   {
      if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.target.contentData != undefined)
      {
         this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
      }
      else
      {
         this.showItemInfos(oEvent.target.contentData);
         this.showLivingItems(oEvent.target.contentData.skineable == true);
         if(oEvent.target.contentData.skineable)
         {
            this._livItemViewer.itemData = oEvent.target.contentData;
         }
      }
   }
   function overItem(oEvent)
   {
      this.gapi.showTooltip(oEvent.target.contentData.name,oEvent.target,-20,undefined,oEvent.target.contentData.style + "ToolTip");
   }
   function outItem(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function dblClickItem(oEvent)
   {
      if(!this.canMoveItem())
      {
         return undefined;
      }
      var _loc3_ = oEvent.target.contentData;
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      if(_loc3_.position == -1)
      {
         if(_loc3_.canUse && this.api.datacenter.Player.canUseObject)
         {
            this.api.network.Items.use(_loc3_.ID);
         }
         else if(this.api.lang.getConfigText("DOUBLE_CLICK_TO_EQUIP"))
         {
            this.equipItem(_loc3_);
         }
      }
      else
      {
         this.api.network.Items.movement(_loc3_.ID,-1);
      }
   }
   function getFreeSlot(oItem)
   {
      var _loc3_ = oItem.superType;
      for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_])
      {
         if(dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_][i] != "_ctr16")
         {
            if(this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_][i]].contentData == undefined)
            {
               return this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + _loc3_][i]];
            }
         }
      }
      return undefined;
   }
   function equipItem(oItem)
   {
      if(oItem.position != -1)
      {
         return undefined;
      }
      var _loc3_ = oItem.superType;
      var _loc4_ = 0;
      while(_loc4_ < dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE.length)
      {
         if(dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE[_loc4_] == _loc3_)
         {
            return undefined;
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc5_ = this.getFreeSlot(oItem);
      if(_loc5_ != undefined)
      {
         var _loc6_ = Number(_loc5_._name.substr(4));
         this.cleanRideIfNecessary(_loc3_);
         this.api.network.Items.movement(oItem.ID,_loc6_);
      }
      else
      {
         var _loc8_ = this.api.lang.getSlotsFromSuperType(oItem.superType);
         var _loc9_ = getTimer();
         var _loc10_ = 0;
         while(_loc10_ < _loc8_.length)
         {
            if(this.api.kernel.GameManager.getLastModified(_loc8_[_loc10_]) < _loc9_)
            {
               _loc9_ = this.api.kernel.GameManager.getLastModified(_loc8_[_loc10_]);
               var _loc7_ = _loc8_[_loc10_];
            }
            _loc10_ = _loc10_ + 1;
         }
         if(this["_ctr" + _loc7_].contentData.ID == undefined || _global.isNaN(this["_ctr" + _loc7_].contentData.ID))
         {
            return undefined;
         }
         if(_loc7_ == undefined || _global.isNaN(_loc7_))
         {
            return undefined;
         }
         this.cleanRideIfNecessary(_loc3_);
         this.api.network.Items.movement(this["_ctr" + _loc7_].contentData.ID,-1);
         this.api.network.Items.movement(oItem.ID,_loc7_);
      }
   }
   function cleanRideIfNecessary(nSuperType)
   {
      if(nSuperType == 12 && (!this.api.datacenter.Game.isFight && this.api.datacenter.Player.isRiding))
      {
         this.api.network.Mount.ride();
      }
   }
   function dropDownItem()
   {
      if(!this.canMoveItem())
      {
         return undefined;
      }
      var _loc2_ = this.gapi.getCursor();
      if(!_loc2_.canDrop)
      {
         this.gapi.loadUIComponent("AskOk","AskOkCantDrop",{title:this.api.lang.getText("IMPOSSIBLE"),text:this.api.lang.getText("CANT_DROP_ITEM")});
         return undefined;
      }
      if(_loc2_.Quantity > 1)
      {
         var _loc3_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:_loc2_.Quantity,params:{type:"drop",item:_loc2_}});
         _loc3_.addEventListener("validate",this);
      }
      else if(this.api.kernel.OptionsManager.getOption("ConfirmDropItem"))
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_DROP_ITEM"),"CAUTION_YESNO",{name:"ConfirmDropOne",params:{item:_loc2_},listener:this});
      }
      else
      {
         this.api.network.Items.drop(_loc2_.ID,1);
      }
   }
   function validate(oEvent)
   {
      switch(oEvent.params.type)
      {
         case "destroy":
            if(oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
            {
               var _loc3_ = Math.min(oEvent.value,oEvent.params.item.Quantity);
               this.askDestroy(oEvent.params.item,_loc3_);
            }
            break;
         case "drop":
            this.gapi.removeCursor();
            if(oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
            {
               if(this.api.kernel.OptionsManager.getOption("ConfirmDropItem"))
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_DROP_ITEM"),"CAUTION_YESNO",{name:"ConfirmDrop",params:{item:oEvent.params.item,minValue:oEvent.value},listener:this});
               }
               else
               {
                  this.api.network.Items.drop(oEvent.params.item.ID,Math.min(oEvent.value,oEvent.params.item.Quantity));
               }
            }
            break;
         case "move":
            if(oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
            {
               this.api.network.Items.movement(oEvent.params.item.ID,oEvent.params.position,Math.min(oEvent.value,oEvent.params.item.Quantity));
            }
      }
   }
   function useItem(oEvent)
   {
      if(!oEvent.item.canUse || !this.api.datacenter.Player.canUseObject)
      {
         return undefined;
      }
      this.api.network.Items.use(oEvent.item.ID);
   }
   function destroyItem(oEvent)
   {
      if(oEvent.item.Quantity > 1)
      {
         var _loc3_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:oEvent.item.Quantity,params:{type:"destroy",item:oEvent.item}});
         _loc3_.addEventListener("validate",this);
      }
      else
      {
         this.askDestroy(oEvent.item,1);
      }
   }
   function targetItem(oEvent)
   {
      if(!oEvent.item.canTarget || !this.api.datacenter.Player.canUseObject)
      {
         return undefined;
      }
      this.api.kernel.GameManager.switchToItemTarget(oEvent.item);
      this.callClose();
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoConfirmDropOne":
            this.api.network.Items.drop(oEvent.target.params.item.ID,1);
            break;
         case "AskYesNoConfirmDrop":
            this.api.network.Items.drop(oEvent.params.item.ID,Math.min(oEvent.params.minValue,oEvent.params.item.Quantity));
            break;
         default:
            this.api.network.Items.destroy(oEvent.target.params.item.ID,oEvent.target.params.quantity);
      }
   }
   function itemSelected(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_cbTypes")
      {
         this._nSelectedTypeID = this._cbTypes.selectedItem.id;
         this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
         this.updateData();
      }
   }
   function mountChanged(oEvent)
   {
      var _loc3_ = this.api.datacenter.Player.mount;
      if(_loc3_ != undefined)
      {
         this._ctrMount.contentPath = "UI_InventoryMountIcon";
         this._mcMountCross._visible = false;
      }
      else
      {
         this._ctrMount.contentPath = "";
         this._mcMountCross._visible = true;
      }
      this.hideEpisodicContent();
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
            break;
         case this._btnFilterQuest:
            this.api.ui.showTooltip(this.api.lang.getText("QUEST_OBJECTS"),oEvent.target,-20);
            break;
         default:
            this.api.ui.showTooltip(oEvent.target.toolTipText,oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.api.ui.hideTooltip();
   }
}
