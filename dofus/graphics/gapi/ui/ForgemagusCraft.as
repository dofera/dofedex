class dofus.graphics.gapi.ui.ForgemagusCraft extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ForgemagusCraft";
   static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
   static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
   static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
   static var GRID_CONTAINER_WIDTH = 38;
   static var TYPES_ALLOWED_AS_COMPONENT = [26,78];
   static var ITEMS_ALLOWED_AS_SIGNATURE = [7508];
   var _bInvalidateDistant = false;
   var _aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_RESSOURECES;
   var _nSelectedTypeID = 0;
   var _nCurrentQuantity = 1;
   function ForgemagusCraft()
   {
      super();
      this._cgLocal._visible = false;
      this._cgDistant._visible = false;
   }
   function __set__maxItem(nMaxItem)
   {
      this._nMaxItem = Number(nMaxItem);
      return this.__get__maxItem();
   }
   function __set__skillId(nSkillId)
   {
      this._nSkillId = Number(nSkillId);
      this._nForgemagusItemType = _global.API.lang.getSkillForgemagus(this._nSkillId);
      return this.__get__skillId();
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
      this._eaLocalDataProvider.removeEventListener("modelChanged",this);
      this._eaLocalDataProvider = eaLocalDataProvider;
      this._eaLocalDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      return this.__get__localDataProvider();
   }
   function __set__distantDataProvider(eaDistantDataProvider)
   {
      this._eaDistantDataProvider.removeEventListener("modelChanged",this);
      this._eaDistantDataProvider = eaDistantDataProvider;
      this._eaDistantDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      return this.__get__distantDataProvider();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME);
      this.api.datacenter.Basics.aks_exchange_isForgemagus = true;
   }
   function destroy()
   {
      this.gapi.hideTooltip();
      this.api.datacenter.Basics.aks_exchange_isForgemagus = false;
   }
   function callClose()
   {
      this.api.network.Exchange.leave();
      return true;
   }
   function createChildren()
   {
      this._bMakeAll = false;
      this._mcPlacer._visible = false;
      this.addToQueue({object:this,method:this.addListeners});
      this._btnSelectedFilterButton = this._btnFilterRessoureces;
      this.addToQueue({object:this,method:this.initData});
      this.hideItemViewer(true);
      this.addToQueue({object:this,method:this.initTexts});
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
      this._ctrItem.addEventListener("dblClick",this);
      this._ctrItem.addEventListener("drag",this);
      this._ctrItem.addEventListener("drop",this);
      this._ctrItem.addEventListener("click",this);
      this._ctrSignature.addEventListener("dblClick",this);
      this._ctrSignature.addEventListener("drag",this);
      this._ctrSignature.addEventListener("drop",this);
      this._ctrSignature.addEventListener("click",this);
      this._ctrRune.addEventListener("dblClick",this);
      this._ctrRune.addEventListener("drag",this);
      this._ctrRune.addEventListener("drop",this);
      this._ctrRune.addEventListener("click",this);
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
      this._btnOneShot.addEventListener("click",this);
      this._btnLoop.addEventListener("click",this);
      this.api.datacenter.Exchange.addEventListener("localKamaChange",this);
      this.api.datacenter.Exchange.addEventListener("distantKamaChange",this);
      this.api.datacenter.Player.addEventListener("kamaChanged",this);
      this.addToQueue({object:this,method:this.kamaChanged,params:[{value:this.api.datacenter.Player.Kama}]});
      this._cbTypes.addEventListener("itemSelected",this);
   }
   function initTexts()
   {
      this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
      this._winInventory.title = this.api.datacenter.Player.data.name;
      this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
      this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
      this._lblItemTitle.text = this.api.lang.getText("FM_CRAFT_ITEM");
      this._lblRuneTitle.text = this.api.lang.getText("FM_CRAFT_RUNE");
      this._lblSignatureTitle.text = this.api.lang.getText("FM_CRAFT_SIGNATURE");
      this._btnOneShot.label = this.api.lang.getText("APPLY_ONE_RUNE");
      this._btnLoop.label = this.api.lang.getText("APPLY_MULTIPLE_RUNES");
   }
   function initData()
   {
      this.dataProvider = this.api.datacenter.Exchange.inventory;
      this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
      this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
   }
   function updateData()
   {
      if(this._bIsLooping)
      {
         return undefined;
      }
      var _loc2_ = this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
      this._ctrItem.contentData = this._ctrRune.contentData = this._ctrSignature.contentData = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this._eaLocalDataProvider.length)
      {
         var _loc3_ = false;
         var _loc4_ = 0;
         while(_loc4_ < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
         {
            if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc4_] == this._eaLocalDataProvider[_loc2_].unicID)
            {
               this._ctrSignature.contentData = this._eaLocalDataProvider[_loc2_];
               _loc3_ = true;
               break;
            }
            _loc4_ = _loc4_ + 1;
         }
         var _loc5_ = 0;
         while(_loc5_ < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
         {
            if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc5_] == this._eaLocalDataProvider[_loc2_].type)
            {
               this._ctrRune.contentData = this._eaLocalDataProvider[_loc2_];
               _loc3_ = true;
               break;
            }
            _loc5_ = _loc5_ + 1;
         }
         if(!_loc3_)
         {
            this._ctrItem.contentData = this._eaLocalDataProvider[_loc2_];
            if(this._ctrItem.contentData != undefined)
            {
               this.hideItemViewer(false);
               this._itvItemViewer.itemData = this._ctrItem.contentData;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function updateDistantData()
   {
      this._cgDistant.dataProvider = this._eaDistantDataProvider;
      var _loc2_ = this._cgDistant.getContainer(0).contentData;
      if(_loc2_ != undefined)
      {
         this.hideItemViewer(false);
         this._itvItemViewer.itemData = _loc2_;
      }
      this._bInvalidateDistant = true;
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
            break;
         case "_ctrItem":
         case "_ctrRune":
         case "_ctrSignature":
            var _loc5_ = false;
            var _loc6_ = false;
            switch(sTargetGrid)
            {
               case "_ctrItem":
                  if(this._nForgemagusItemType != oItem.type || !oItem.enhanceable)
                  {
                     return undefined;
                  }
                  var _loc7_ = 0;
                  while(_loc7_ < this._eaLocalDataProvider.length)
                  {
                     var _loc8_ = false;
                     var _loc9_ = 0;
                     while(_loc9_ < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
                     {
                        if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc9_] == this._eaLocalDataProvider[_loc7_].unicID)
                        {
                           _loc8_ = true;
                        }
                        _loc9_ = _loc9_ + 1;
                     }
                     var _loc10_ = 0;
                     while(_loc10_ < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
                     {
                        if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc10_] == this._eaLocalDataProvider[_loc7_].type)
                        {
                           _loc8_ = true;
                        }
                        _loc10_ = _loc10_ + 1;
                     }
                     if(!_loc8_)
                     {
                        this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[_loc7_].ID,this._eaLocalDataProvider[_loc7_].Quantity);
                     }
                     _loc7_ = _loc7_ + 1;
                  }
                  _loc5_ = true;
                  break;
               case "_ctrRune":
                  var _loc11_ = 0;
                  while(_loc11_ < this._eaLocalDataProvider.length)
                  {
                     var _loc12_ = 0;
                     while(_loc12_ < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
                     {
                        if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc12_] == this._eaLocalDataProvider[_loc11_].type && this._eaLocalDataProvider[_loc11_].unicID != oItem.unicID)
                        {
                           this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[_loc11_].ID,this._eaLocalDataProvider[_loc11_].Quantity);
                        }
                        _loc12_ = _loc12_ + 1;
                     }
                     _loc11_ = _loc11_ + 1;
                  }
                  break;
               case "_ctrSignature":
                  var _loc13_ = 0;
                  while(_loc13_ < this._eaLocalDataProvider.length)
                  {
                     var _loc14_ = 0;
                     while(_loc14_ < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
                     {
                        if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc14_] == this._eaLocalDataProvider[_loc13_].unicID)
                        {
                           this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[_loc13_].ID,this._eaLocalDataProvider[_loc13_].Quantity);
                        }
                        _loc14_ = _loc14_ + 1;
                     }
                     _loc13_ = _loc13_ + 1;
                  }
                  if(this.getCurrentCraftLevel() < 100)
                  {
                     _loc6_ = true;
                     this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_LEVEL_DOESNT_ALLOW_A_SIGNATURE"),"ERROR_CHAT");
                  }
                  _loc5_ = true;
            }
            if(!_loc6_)
            {
               this.api.network.Exchange.movementItem(true,oItem.ID,!_loc5_?nValue:1);
            }
      }
      if(this._bInvalidateDistant)
      {
         this.api.datacenter.Exchange.clearDistantGarbage();
         this._bInvalidateDistant = false;
      }
   }
   function getCurrentCraftLevel()
   {
      var _loc2_ = this.api.datacenter.Player.Jobs;
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         var _loc4_ = 0;
         while(_loc4_ < _loc2_[_loc3_].skills.length)
         {
            if((dofus.datacenter.Skill)(dofus.datacenter.Job)_loc2_[_loc3_].skills[_loc4_].id == this._nSkillId)
            {
               return (dofus.datacenter.Job)_loc2_[_loc3_].level;
            }
            _loc4_ = _loc4_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      return 0;
   }
   function setReady()
   {
      if(this.api.datacenter.Exchange.localGarbage.length == 0)
      {
         return undefined;
      }
      this.api.network.Exchange.ready();
   }
   function canDropInGarbage(oItem)
   {
      var _loc3_ = this.api.datacenter.Exchange.localGarbage.findFirstItem("ID",oItem.ID);
      var _loc4_ = this.api.datacenter.Exchange.localGarbage.length;
      if(_loc3_.index == -1 && _loc4_ >= this._nMaxItem)
      {
         return false;
      }
      return true;
   }
   function recordGarbage()
   {
      this._aGarbageMemory = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this._eaLocalDataProvider.length)
      {
         var _loc3_ = this._eaLocalDataProvider[_loc2_];
         this._aGarbageMemory.push({id:_loc3_.ID,quantity:_loc3_.Quantity});
         _loc2_ = _loc2_ + 1;
      }
   }
   function cleanGarbage()
   {
      var _loc2_ = 0;
      while(_loc2_ < this._eaLocalDataProvider.length)
      {
         var _loc3_ = this._eaLocalDataProvider[_loc2_];
         this.api.network.Exchange.movementItem(false,_loc3_.ID,_loc3_.Quantity);
         _loc2_ = _loc2_ + 1;
      }
   }
   function recallGarbageMemory()
   {
      if(this._aGarbageMemory == undefined || this._aGarbageMemory.length == 0)
      {
         return false;
      }
      this.cleanGarbage();
      var _loc2_ = 0;
      while(_loc2_ < this._aGarbageMemory.length)
      {
         var _loc3_ = this._aGarbageMemory[_loc2_];
         var _loc4_ = this._eaDataProvider.findFirstItem("ID",_loc3_.id);
         if(_loc4_.index != -1)
         {
            if(_loc4_.item.Quantity >= _loc3_.quantity)
            {
               this.api.network.Exchange.movementItem(true,_loc4_.item.ID,_loc3_.quantity);
               _loc2_ = _loc2_ + 1;
               continue;
            }
            this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NOT_ENOUGHT",[_loc4_.item.name]),"ERROR_BOX",{name:"NotEnougth"});
            return false;
         }
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NO_RESOURCE"),"ERROR_BOX",{name:"NotEnougth"});
         return false;
      }
      return true;
   }
   function nextCraft()
   {
      ank.utils.Timer.setTimer(this,"doNextCraft",this,this.doNextCraft,250);
   }
   function doNextCraft()
   {
      if(this.recallGarbageMemory() == false)
      {
         this.stopMakeAll();
      }
   }
   function stopMakeAll()
   {
      ank.utils.Timer.removeTimer(this,"doNextCraft");
      this._bMakeAll = false;
      this._cgLocal.dataProvider = this.api.datacenter.Exchange.localGarbage;
      this.updateData();
      this.updateDistantData();
   }
   function kamaChanged(oEvent)
   {
      this._lblKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
   }
   function modelChanged(oEvent)
   {
      switch(oEvent.target)
      {
         case this._eaLocalDataProvider:
            if(this._bMakeAll)
            {
               if(this._eaLocalDataProvider.length == 0)
               {
                  this.nextCraft();
               }
               else if(this._aGarbageMemory.length != undefined && this._aGarbageMemory.length == this._eaLocalDataProvider.length)
               {
                  this.setReady();
               }
            }
            else
            {
               this.updateLocalData();
            }
            break;
         case this._eaDistantDataProvider:
            if(!this._bMakeAll && !this._bIsLooping)
            {
               this.updateDistantData();
            }
            break;
         case this._eaDataProvider:
            if(!this._bMakeAll && !this._bIsLooping)
            {
               this.updateData();
            }
            break;
         default:
            if(!this._bMakeAll && !this._bIsLooping)
            {
               this.updateData();
               this.updateLocalData();
               this.updateDistantData();
            }
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
   function onCraftLoopEnd()
   {
      this._bIsLooping = false;
      this._nCurrentQuantity = 1;
      this._btnLoop.label = this.api.lang.getText("APPLY_MULTIPLE_RUNES");
      this._btnOneShot.enabled = true;
   }
   function repeatCraft()
   {
      var _loc2_ = this._ctrRune.contentData.Quantity - 1;
      if(_loc2_ <= 1)
      {
         return undefined;
      }
      this._bIsLooping = true;
      this.api.network.Exchange.repeatCraft(_loc2_);
      this._btnLoop.label = this.api.lang.getText("STOP_WORD");
      this._btnOneShot.enabled = false;
   }
   function checkIsBaka()
   {
      if(this._ctrItem.contentData == undefined || this._ctrRune.contentData == undefined)
      {
         this.api.kernel.showMessage(this.api.lang.getText("ERROR_WORD"),this.api.lang.getText("FM_ERROR_NO_ITEMS"),"ERROR_BOX");
         return true;
      }
      return false;
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnClose:
            this.callClose();
            break;
         case this._btnOneShot:
            if(this.checkIsBaka())
            {
               return undefined;
            }
            this.recordGarbage();
            this.setReady();
            break;
         case this._btnLoop:
            if(this._bIsLooping)
            {
               this.api.network.Exchange.stopRepeatCraft();
               return undefined;
            }
            if(this.checkIsBaka())
            {
               return undefined;
            }
            this.recordGarbage();
            this.setReady();
            this.addToQueue({object:this,method:this.repeatCraft});
            break;
         case this._ctrItem:
         case this._ctrRune:
         case this._ctrSignature:
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
            break;
         default:
            if(oEvent.target != this._btnSelectedFilterButton)
            {
               this._btnSelectedFilterButton.selected = false;
               this._btnSelectedFilterButton = oEvent.target;
               switch(oEvent.target._name)
               {
                  case "_btnFilterEquipement":
                     this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_EQUIPEMENT;
                     this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
                     break;
                  case "_btnFilterNonEquipement":
                     this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_NONEQUIPEMENT;
                     this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
                     break;
                  case "_btnFilterRessoureces":
                     this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_RESSOURECES;
                     this._lblFilter.text = this.api.lang.getText("RESSOURECES");
               }
               this.updateData(true);
            }
            else
            {
               oEvent.target.selected = true;
            }
      }
   }
   function dblClick(oEvent)
   {
      oEvent.owner = this._cgLocal;
      this.dblClickItem(oEvent);
   }
   function drag(oEvent)
   {
      this.dragItem(oEvent);
   }
   function drop(oEvent)
   {
      var _loc3_ = this.gapi.getCursor();
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      this.gapi.removeCursor();
      if(_loc3_.position == -2)
      {
         return undefined;
      }
      if(!this.canDropInGarbage(_loc3_))
      {
         return undefined;
      }
      var _loc4_ = false;
      var _loc5_ = false;
      switch(oEvent.target)
      {
         case this._ctrItem:
            _loc4_ = _loc5_ = true;
            var _loc6_ = 0;
            while(_loc6_ < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
            {
               if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc6_] == _loc3_.type)
               {
                  _loc4_ = false;
               }
               _loc6_ = _loc6_ + 1;
            }
            var _loc7_ = 0;
            while(_loc7_ < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
            {
               if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc7_] == _loc3_.unicID)
               {
                  _loc4_ = false;
               }
               _loc7_ = _loc7_ + 1;
            }
            break;
         case this._ctrRune:
            var _loc8_ = 0;
            while(_loc8_ < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
            {
               if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc8_] == _loc3_.type)
               {
                  _loc4_ = true;
               }
               _loc8_ = _loc8_ + 1;
            }
            break;
         case this._ctrSignature:
            var _loc9_ = 0;
            while(_loc9_ < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
            {
               if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc9_] == _loc3_.unicID)
               {
                  _loc4_ = true;
               }
               _loc9_ = _loc9_ + 1;
            }
            _loc5_ = true;
      }
      if(!_loc4_)
      {
         return undefined;
      }
      if(!_loc5_ && _loc3_.Quantity > 1)
      {
         var _loc10_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:_loc3_.Quantity,params:{targetType:"item",oItem:_loc3_,targetGrid:oEvent.target._name}});
         _loc10_.addEventListener("validate",this);
      }
      else
      {
         this.validateDrop(oEvent.target._name,_loc3_,1);
      }
   }
   function updateForgemagusResult(oItem)
   {
      var _loc3_ = new ank.utils.ExtendedArray();
      _loc3_.push(oItem);
      this.distantDataProvider = _loc3_;
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
            if(this.canDropInGarbage(_loc3_))
            {
               var _loc6_ = undefined;
               var _loc7_ = 0;
               while(_loc7_ < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length && _loc6_ == undefined)
               {
                  if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[_loc7_] == _loc3_.unicID)
                  {
                     _loc6_ = "_ctrSignature";
                  }
                  _loc7_ = _loc7_ + 1;
               }
               var _loc8_ = 0;
               while(_loc8_ < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length && _loc6_ == undefined)
               {
                  if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[_loc8_] == _loc3_.type)
                  {
                     _loc6_ = "_ctrRune";
                  }
                  _loc8_ = _loc8_ + 1;
               }
               if(_loc6_ == undefined)
               {
                  _loc6_ = "_ctrItem";
               }
               this.validateDrop(_loc6_,_loc3_,_loc4_);
            }
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
            if(!this.canDropInGarbage(_loc3_))
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
         case "repeat":
            var _loc3_ = Number(oEvent.value);
            if(_loc3_ < 1 || (_loc3_ == undefined || _global.isNaN(_loc3_)))
            {
               _loc3_ = 1;
            }
            this._nCurrentQuantity = _loc3_;
      }
   }
   function itemSelected(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_cbTypes")
      {
         this._nSelectedTypeID = this._cbTypes.selectedItem.id;
         this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
         this.updateData();
      }
   }
}
