class dofus.graphics.gapi.ui.Craft extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Craft";
   static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
   static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
   static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
   static var GRID_CONTAINER_WIDTH = 38;
   static var FILTER_TYPE_ONLY_USEFUL = 10000;
   var _bInvalidateDistant = false;
   var _aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
   var _nSelectedTypeID = 0;
   var _nCurrentQuantity = 1;
   var _nLastRegenerateTimer = 0;
   static var NAME_GENERATION_DELAY = 1000;
   function Craft()
   {
      super();
      if(!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
      {
         this._btnQuantity._visible = false;
      }
      if(!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
      {
         this._btnTries._visible = false;
      }
   }
   function __set__maxItem(nMaxItem)
   {
      this._nMaxItem = Number(nMaxItem);
      return this.__get__maxItem();
   }
   function __set__skillId(nSkillId)
   {
      this._nSkillId = Number(nSkillId);
      this._btnTries._visible = false;
      this._btnApplyRunes._visible = false;
      if(_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
      {
         this._btnQuantity._visible = true;
      }
      this._btnCraft._visible = true;
      this._btnMemoryRecall._visible = true;
      this._btnValidate._visible = true;
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
      super.init(false,dofus.graphics.gapi.ui.Craft.CLASS_NAME);
   }
   function destroy()
   {
      this.gapi.hideTooltip();
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
      this.showPreview(undefined,false);
      this._winCraftViewer.swapDepths(this.getNextHighestDepth());
      this.showCraftViewer(false);
      this.showBottom(false);
      this.addToQueue({object:this,method:this.addListeners});
      this._btnSelectedFilterButton = this._btnFilterRessoureces;
      this.addToQueue({object:this,method:this.saveGridMaxSize});
      this.addToQueue({object:this,method:this.initData});
      this.hideItemViewer(true);
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.initGridWidth});
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
      this._btnQuantity.addEventListener("click",this);
      this._btnTries.addEventListener("click",this);
      this._btnApplyRunes.addEventListener("click",this);
      this.api.datacenter.Exchange.addEventListener("localKamaChange",this);
      this.api.datacenter.Exchange.addEventListener("distantKamaChange",this);
      this._btnValidate.addEventListener("click",this);
      this._btnCraft.addEventListener("click",this);
      this._btnMemoryRecall.addEventListener("click",this);
      this._ctrPreview.addEventListener("over",this);
      this._ctrPreview.addEventListener("out",this);
      this._cbTypes.addEventListener("itemSelected",this);
   }
   function initTexts()
   {
      this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
      this._winInventory.title = this.api.datacenter.Player.data.name;
      this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
      this._btnValidate.label = this.api.lang.getText("COMBINE");
      this._btnCraft.label = this.api.lang.getText("RECEIPTS");
      this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": 1";
      this._btnApplyRunes.label = this.api.lang.getText("APPLY_ONE_RUNE");
      this._btnTries.label = this.api.lang.getText("TRIES_WORD") + ": 1";
      this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
      this._winCraftViewer.title = this.api.lang.getText("RECEIPTS_FROM_JOB");
      this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
   }
   function initData()
   {
      this.dataProvider = this.api.datacenter.Exchange.inventory;
      this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
      this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
   }
   function saveGridMaxSize()
   {
      this._nMaxRight = this._winLocal._x + this._winLocal.width;
      this._nDistantToLocalWin = this._winLocal._x - this._winDistant._x;
      this._nLocalWinToCgLocal = this._cgLocal._x - this._winLocal._x;
      this._nCgLocalWinLocal = this._winLocal.width - this._cgLocal.width;
      this._nArrowToLocalWin = this._winLocal._x - this._mcArrow._x;
      this._nLblNewToDistantWin = this._lblNewObject._x - this._winDistant._x;
      this._nCgDistantToDistantWin = this._cgDistant._x - this._winDistant._x;
   }
   function showBottom(bShow)
   {
      this._winLocal._visible = bShow;
      this._mcArrow._visible = bShow;
      this._winDistant._visible = bShow;
      this._lblNewObject._visible = bShow;
      this._cgDistant._visible = bShow;
      this._cgLocal._visible = bShow;
   }
   function initGridWidth()
   {
      this._cgLocal.visibleColumnCount = this._nMaxItem;
      if(this._nMaxItem == undefined)
      {
         this._nMaxItem = 12;
      }
      var _loc2_ = dofus.graphics.gapi.ui.Craft.GRID_CONTAINER_WIDTH * this._nMaxItem;
      var _loc3_ = Math.max(304,_loc2_);
      this._cgLocal.setSize(_loc2_);
      this._cgLocal._x = this._nMaxRight - _loc2_ - this._nCgLocalWinLocal / 2;
      this._winLocal.setSize(_loc3_ + this._nCgLocalWinLocal);
      this._winLocal._x = this._nMaxRight - _loc3_ - this._nCgLocalWinLocal;
      this._mcArrow._x = this._winLocal._x - this._nArrowToLocalWin;
      this._winDistant._x = this._winLocal._x - this._nDistantToLocalWin;
      this._lblNewObject._x = this._winDistant._x + this._nLblNewToDistantWin;
      this._cgDistant._x = this._winDistant._x + this._nCgDistantToDistantWin;
      this._ctrPreview._x = this._cgDistant._x;
      this._mcFiligrane._x = this._cgDistant._x;
      this.showBottom(true);
   }
   function updateData()
   {
      if(this._bIsLooping)
      {
         return undefined;
      }
      var _loc2_ = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Craft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
            else if(this._nSelectedTypeID == dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL && this.api.kernel.GameManager.isItemUseful(_loc6_.unicID,this._nSkillId,this._nMaxItem))
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
      _loc4_.splice(0,0,{label:this.api.lang.getText("TYPE_FILTER_ONLY_USEFUL"),id:dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL});
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
      }
      if(this._bInvalidateDistant)
      {
         this.api.datacenter.Exchange.clearDistantGarbage();
         this._bInvalidateDistant = false;
      }
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
   function showCraftViewer(bShow)
   {
      if(bShow)
      {
         var _loc3_ = this.attachMovie("CraftViewer","_cvCraftViewer",this.getNextHighestDepth());
         _loc3_._x = this._mcPlacer._x;
         _loc3_._y = this._mcPlacer._y;
         _loc3_.skill = new dofus.datacenter.Skill(this._nSkillId,this._nMaxItem);
      }
      else
      {
         this._cvCraftViewer.removeMovieClip();
      }
      this._winCraftViewer._visible = bShow;
   }
   function addCraft(nTargetItemId)
   {
      if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.Craft.NAME_GENERATION_DELAY < getTimer())
      {
         this.api.network.Account.getRandomCharacterName();
         this._nLastRegenerateTimer = getTimer();
         var _loc3_ = this.api.lang.getSkillText(this._nSkillId).cl;
         var _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            var _loc5_ = _loc3_[_loc4_];
            if(nTargetItemId == _loc5_)
            {
               var _loc6_ = this.api.lang.getCraftText(_loc5_);
               var _loc8_ = 0;
               var _loc9_ = new Array();
               var _loc11_ = 0;
               while(_loc11_ < _loc6_.length)
               {
                  var _loc12_ = _loc6_[_loc11_];
                  var _loc13_ = _loc12_[0];
                  var _loc14_ = _loc12_[1];
                  var _loc7_ = false;
                  var _loc15_ = 0;
                  while(_loc15_ < this._eaDataProvider.length)
                  {
                     var _loc10_ = this._eaDataProvider[_loc15_];
                     if(_loc13_ == _loc10_.unicID)
                     {
                        if(_loc14_ <= _loc10_.Quantity && _loc10_.position == -1)
                        {
                           _loc8_ = _loc8_ + 1;
                           _loc7_ = true;
                           _loc9_.push({item:_loc10_,qty:_loc14_});
                           break;
                        }
                     }
                     _loc15_ = _loc15_ + 1;
                  }
                  if(!_loc7_)
                  {
                     break;
                  }
                  _loc11_ = _loc11_ + 1;
               }
               if(_loc7_ && _loc6_.length == _loc8_)
               {
                  var _loc17_ = new Array();
                  var _loc19_ = 0;
                  while(_loc19_ < this._cgLocal.dataProvider.length)
                  {
                     var _loc16_ = this._cgLocal.dataProvider[_loc19_];
                     var _loc18_ = _loc16_.Quantity;
                     if(!(_loc18_ < 1 || _loc18_ == undefined))
                     {
                        _loc17_.push({Add:false,ID:_loc16_.ID,Quantity:_loc18_});
                     }
                     _loc19_ = _loc19_ + 1;
                  }
                  var _loc20_ = 0;
                  while(_loc20_ < _loc9_.length)
                  {
                     _loc16_ = _loc9_[_loc20_].item;
                     _loc18_ = _loc9_[_loc20_].qty;
                     if(!(_loc18_ < 1 || _loc18_ == undefined))
                     {
                        _loc17_.push({Add:true,ID:_loc16_.ID,Quantity:_loc18_});
                     }
                     _loc20_ = _loc20_ + 1;
                  }
                  this.api.network.Exchange.movementItems(_loc17_);
               }
               else
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("DONT_HAVE_ALL_INGREDIENT"),"ERROR_BOX");
               }
               break;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return undefined;
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
   function showPreview(item, b)
   {
      if(this._ctrPreview.contentPath == undefined)
      {
         return undefined;
      }
      this._mcFiligrane._visible = b;
      this._ctrPreview._visible = b;
      this._ctrPreview.contentPath = !b?"":item.iconFile;
      this._mcFiligrane.itemName = item.name;
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
               var _loc3_ = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider),this._nSkillId,this._nMaxItem);
               if(_loc3_ != undefined)
               {
                  this.showPreview(new dofus.datacenter.Item(-1,_loc3_,1,0,"",0),true);
               }
               else
               {
                  this.showPreview(undefined,false);
               }
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
            break;
         case this._ctrPreview:
            if(this._mcFiligrane.itemName != undefined)
            {
               this.gapi.showTooltip(this._mcFiligrane.itemName,this._ctrPreview,-22);
            }
      }
   }
   function out(oEvent)
   {
      this.api.ui.hideTooltip();
   }
   function onCraftLoopEnd()
   {
      this._bIsLooping = false;
      this._btnValidate.label = this.api.lang.getText("COMBINE");
      this._nCurrentQuantity = 1;
      this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": 1";
      this._btnTries.label = this.api.lang.getText("TRIES_WORD") + ": 1";
      this._btnApplyRunes.label = this.api.lang.getText("APPLY_ONE_RUNE");
      this.updateData();
   }
   function repeatCraft()
   {
      this._bIsLooping = true;
      this._btnValidate.label = this._btnApplyRunes.label = this.api.lang.getText("STOP_WORD");
      this.api.network.Exchange.repeatCraft(this._nCurrentQuantity - 1);
   }
   function click(oEvent)
   {
      if(oEvent.target == this._btnClose)
      {
         this.callClose();
         return undefined;
      }
      if(oEvent.target == this._btnQuantity)
      {
         var _loc3_ = 99;
         var _loc4_ = 0;
         var _loc5_ = 10000000;
         var _loc8_ = 0;
         while(_loc8_ < this._eaLocalDataProvider.length)
         {
            var _loc7_ = false;
            var _loc9_ = 0;
            while(_loc9_ < this._eaDataProvider.length)
            {
               if(this._eaLocalDataProvider[_loc8_].ID == this._eaDataProvider[_loc9_].ID)
               {
                  _loc7_ = true;
                  var _loc6_ = Math.floor(this._eaDataProvider[_loc9_].Quantity / this._eaLocalDataProvider[_loc8_].Quantity);
                  if(_loc6_ < _loc5_)
                  {
                     _loc5_ = _loc6_;
                  }
               }
               _loc9_ = _loc9_ + 1;
            }
            if(!_loc7_)
            {
               break;
            }
            _loc8_ = _loc8_ + 1;
         }
         if(_loc7_)
         {
            _loc4_ = 1;
            _loc3_ = _loc5_ + 1;
            if(_loc4_ > _loc5_)
            {
               _loc4_ = _loc5_;
            }
         }
         else
         {
            _loc3_ = 0;
            _loc4_ = 0;
         }
         var _loc10_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:_loc3_,params:{targetType:"repeat"}});
         _loc10_.addEventListener("validate",this);
         return undefined;
      }
      if(oEvent.target == this._btnTries)
      {
         var _loc11_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:99,params:{targetType:"tries"}});
         _loc11_.addEventListener("validate",this);
         return undefined;
      }
      if(oEvent.target == this._btnValidate || oEvent.target == this._btnApplyRunes)
      {
         if(this._bIsLooping)
         {
            this.api.network.Exchange.stopRepeatCraft();
            return undefined;
         }
         if(this._eaLocalDataProvider.length == 0)
         {
            return undefined;
         }
         var _loc12_ = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider),this._nSkillId,this._nMaxItem);
         if(_loc12_ == undefined && this.api.kernel.OptionsManager.getOption("AskForWrongCraft"))
         {
            this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("WRONG_CRAFT_CONFIRM"),"CAUTION_YESNO",{name:"confirmWrongCraft",listener:this});
         }
         else
         {
            this.validCraft();
         }
         return undefined;
      }
      if(oEvent.target == this._btnCraft)
      {
         this.showCraftViewer(oEvent.target.selected);
         return undefined;
      }
      if(oEvent.target == this._btnMemoryRecall)
      {
         this.api.network.Exchange.replayCraft();
         return undefined;
      }
      if(oEvent.target != this._btnSelectedFilterButton)
      {
         this._btnSelectedFilterButton.selected = false;
         this._btnSelectedFilterButton = oEvent.target;
         switch(oEvent.target._name)
         {
            case "_btnFilterEquipement":
               this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_EQUIPEMENT;
               this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
               break;
            case "_btnFilterNonEquipement":
               this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_NONEQUIPEMENT;
               this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
               break;
            case "_btnFilterRessoureces":
               this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
               this._lblFilter.text = this.api.lang.getText("RESSOURECES");
         }
         this.updateData(true);
      }
      else
      {
         oEvent.target.selected = true;
      }
   }
   function validCraft()
   {
      if(this._nCurrentQuantity > 1)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_LOOP_START",[this._nCurrentQuantity]),"INFO_CHAT");
         this.showCraftViewer(false);
         this._btnCraft.selected = false;
         this.recordGarbage();
         this.setReady();
         this.addToQueue({object:this,method:this.repeatCraft});
      }
      else
      {
         this.showCraftViewer(false);
         this._btnCraft.selected = false;
         this.recordGarbage();
         this.setReady();
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
               this.validateDrop("_cgLocal",_loc3_,_loc4_);
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
            this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": " + _loc3_;
            this._nCurrentQuantity = _loc3_;
      }
   }
   function itemSelected(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_cbTypes")
      {
         this._nSelectedTypeID = this._cbTypes.selectedItem.id;
         this.api.datacenter.Basics[dofus.graphics.gapi.ui.Craft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
         this.updateData();
      }
   }
   function yes()
   {
      this.validCraft();
   }
}
