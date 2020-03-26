class dofus.graphics.gapi.controls.MouseShortcuts extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var TAB_SPELLS = "Spells";
   static var TAB_ITEMS = "Items";
   static var CLASS_NAME = "MouseShortcuts";
   static var MAX_CONTAINER = 24;
   static var ITEM_OFFSET = 34;
   static var NO_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
   static var INACTIVE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:50,bb:0};
   static var WRONG_STATE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:70,bb:0};
   var _sCurrentTab = "Items";
   function MouseShortcuts()
   {
      super();
   }
   function __get__currentTab()
   {
      return this._sCurrentTab;
   }
   function __set__meleeVisible(b)
   {
      this._ctrCC._visible = b;
      return this.__get__meleeVisible();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.MouseShortcuts.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function getContainer(nID)
   {
      return this["_ctr" + nID];
   }
   function setContainer(nID, cContainer)
   {
      this["_ctr" + nID] = cContainer;
   }
   function initData()
   {
      this._ctrCC.contentPath = dofus.Constants.SPELLS_ICONS_PATH + "0.swf";
   }
   function initTexts()
   {
      this._btnTabSpells.label = this.api.lang.getText("BANNER_TAB_SPELLS");
      this._btnTabItems.label = this.api.lang.getText("BANNER_TAB_ITEMS");
   }
   function addListeners()
   {
      this._btnTabSpells.addEventListener("click",this);
      this._btnTabItems.addEventListener("click",this);
      this._btnTabSpells.addEventListener("over",this);
      this._btnTabItems.addEventListener("over",this);
      this._btnTabSpells.addEventListener("out",this);
      this._btnTabItems.addEventListener("out",this);
      var _loc2_ = 1;
      while(_loc2_ < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
      {
         var _loc3_ = this["_ctr" + _loc2_];
         _loc3_.addEventListener("click",this);
         _loc3_.addEventListener("dblClick",this);
         _loc3_.addEventListener("over",this);
         _loc3_.addEventListener("out",this);
         _loc3_.addEventListener("drag",this);
         _loc3_.addEventListener("drop",this);
         _loc3_.params = {position:_loc2_};
         _loc2_ = _loc2_ + 1;
      }
      this._ctrCC.addEventListener("click",this);
      this._ctrCC.addEventListener("over",this);
      this._ctrCC.addEventListener("out",this);
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
      this.api.datacenter.Player.Spells.addEventListener("modelChanged",this);
      this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
   }
   function clearSpellStateOnAllContainers()
   {
      var _loc2_ = this.api.datacenter.Player.Spells;
      for(var k in _loc2_)
      {
         if(!_global.isNaN(_loc2_[k].position))
         {
            var _loc3_ = this["_ctr" + _loc2_[k].position];
            _loc3_.showLabel = false;
            this.setMovieClipTransform(_loc3_.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
         }
      }
      this.setMovieClipTransform(this._ctrCC.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
   }
   function setSpellStateOnAllContainers()
   {
      if(this._sCurrentTab != "Spells")
      {
         return undefined;
      }
      var _loc2_ = this.api.datacenter.Player.Spells;
      for(var k in _loc2_)
      {
         if(!_global.isNaN(_loc2_[k].position))
         {
            this.setSpellStateOnContainer(_loc2_[k].position);
         }
      }
      this.setSpellStateOnContainer(0);
   }
   function setItemStateOnAllContainers()
   {
      if(this._sCurrentTab != "Items")
      {
         return undefined;
      }
      var _loc2_ = this.api.datacenter.Player.Inventory;
      for(var k in _loc2_)
      {
         var _loc3_ = _loc2_[k].position - dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
         if(!(_global.isNaN(_loc3_) && _loc3_ < 1))
         {
            this.setItemStateOnContainer(_loc3_);
         }
      }
      this.setSpellStateOnContainer(0);
   }
   function updateSpells()
   {
      var _loc2_ = new Array();
      var _loc3_ = 1;
      while(_loc3_ < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
      {
         _loc2_[_loc3_] = true;
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = this.api.datacenter.Player.Spells;
      for(var k in _loc4_)
      {
         var _loc5_ = _loc4_[k];
         var _loc6_ = _loc5_.position;
         if(!_global.isNaN(_loc6_))
         {
            this["_ctr" + _loc6_].contentData = _loc5_;
            _loc2_[_loc6_] = false;
         }
      }
      var _loc7_ = 1;
      while(_loc7_ < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
      {
         if(_loc2_[_loc7_])
         {
            this["_ctr" + _loc7_].contentData = undefined;
         }
         _loc7_ = _loc7_ + 1;
      }
      this.addToQueue({object:this,method:this.setSpellStateOnAllContainers});
   }
   function updateItems()
   {
      var _loc2_ = new Array();
      var _loc3_ = 1;
      while(_loc3_ < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
      {
         _loc2_[_loc3_] = true;
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = this.api.datacenter.Player.Inventory;
      for(var k in _loc4_)
      {
         var _loc5_ = _loc4_[k];
         if(!_global.isNaN(_loc5_.position))
         {
            if(_loc5_.position < dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET + 1)
            {
               continue;
            }
            var _loc6_ = _loc5_.position - dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
            var _loc7_ = this["_ctr" + _loc6_];
            _loc7_.contentData = _loc5_;
            if(_loc5_.Quantity > 1)
            {
               _loc7_.label = String(_loc5_.Quantity);
            }
            _loc2_[_loc6_] = false;
         }
      }
      var _loc8_ = 1;
      while(_loc8_ < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
      {
         if(_loc2_[_loc8_])
         {
            this["_ctr" + _loc8_].contentData = undefined;
         }
         _loc8_ = _loc8_ + 1;
      }
      this.addToQueue({object:this,method:this.setItemStateOnAllContainers});
   }
   function setSpellStateOnContainer(nIndex)
   {
      var _loc3_ = nIndex != 0?this["_ctr" + nIndex]:this._ctrCC;
      var _loc4_ = nIndex != 0?_loc3_.contentData:this.api.datacenter.Player.Spells[0];
      if(_loc4_ == undefined)
      {
         return undefined;
      }
      if(this.api.kernel.TutorialManager.isTutorialMode)
      {
         _loc5_.can = true;
      }
      else
      {
         var _loc5_ = this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellReturnObject(_loc4_.ID);
      }
      if(_loc5_.can == false)
      {
         switch(_loc5_.type)
         {
            case "NOT_IN_REQUIRED_STATE":
            case "IN_FORBIDDEN_STATE":
               this.setMovieClipTransform(_loc3_.content,dofus.graphics.gapi.controls.MouseShortcuts.WRONG_STATE_TRANSFORM);
               if(_loc5_.params[1])
               {
                  _loc3_.showLabel = true;
                  _loc3_.label = _loc5_.params[1];
               }
               else
               {
                  _loc3_.showLabel = false;
               }
               break;
            case "NOT_ENOUGH_AP":
            case "CANT_SUMMON_MORE_CREATURE":
            case "CANT_LAUNCH_MORE":
            case "CANT_RELAUNCH":
            case "NOT_IN_FIGHT":
               _loc3_.showLabel = false;
               this.setMovieClipTransform(_loc3_.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
               break;
            case "CANT_LAUNCH_BEFORE":
               this.setMovieClipTransform(_loc3_.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
               _loc3_.showLabel = true;
               _loc3_.label = _loc5_.params[0];
         }
      }
      else
      {
         _loc3_.showLabel = false;
         this.setMovieClipTransform(_loc3_.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
      }
   }
   function setItemStateOnContainer(nIndex)
   {
      var _loc3_ = this["_ctr" + nIndex];
      var _loc4_ = _loc3_.contentData;
      if(_loc4_ == undefined)
      {
         return undefined;
      }
      _loc3_.showLabel = _loc4_.Quantity > 1;
      if(this.api.datacenter.Game.isRunning)
      {
         this.setMovieClipTransform(_loc3_.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
      }
      else
      {
         this.setMovieClipTransform(_loc3_.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
      }
   }
   function updateCurrentTabInformations()
   {
      switch(this._sCurrentTab)
      {
         case "Spells":
            this.updateSpells();
            this._ctrCC._visible = !this.api.datacenter.Player.isMutant;
            break;
         case "Items":
            this.updateItems();
            this._ctrCC._visible = false;
            this.api.ui.getUIComponent("Banner").updateEye();
      }
   }
   function setCurrentTab(sNewTab)
   {
      if(sNewTab != this._sCurrentTab)
      {
         var _loc3_ = this["_btnTab" + this._sCurrentTab];
         var _loc4_ = this["_btnTab" + sNewTab];
         _loc3_.selected = true;
         _loc3_.enabled = true;
         _loc4_.selected = false;
         _loc4_.enabled = false;
         this._sCurrentTab = sNewTab;
         this.updateCurrentTabInformations();
      }
   }
   function onShortcut(sShortcut)
   {
      var _loc3_ = true;
      switch(sShortcut)
      {
         case "SWAP":
            this.setCurrentTab(this._sCurrentTab != "Spells"?"Spells":"Items");
            _loc3_ = false;
            break;
         case "SH0":
            this.click({target:this._ctrCC});
            _loc3_ = false;
            break;
         case "SH1":
            this.click({target:this._ctr1,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH2":
            this.click({target:this._ctr2,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH3":
            this.click({target:this._ctr3,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH4":
            this.click({target:this._ctr4,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH5":
            this.click({target:this._ctr5,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH6":
            this.click({target:this._ctr6,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH7":
            this.click({target:this._ctr7,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH8":
            this.click({target:this._ctr8,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH9":
            this.click({target:this._ctr9,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH10":
            this.click({target:this._ctr10,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH11":
            this.click({target:this._ctr11,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH12":
            this.click({target:this._ctr12,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH13":
            this.click({target:this._ctr13,keyBoard:true});
            _loc3_ = false;
            break;
         case "SH14":
            this.click({target:this._ctr14,keyBoard:true});
            _loc3_ = false;
      }
      return _loc3_;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnTabSpells":
            this.api.sounds.events.onBannerSpellItemButtonClick();
            this.setCurrentTab("Spells");
            break;
         case "_btnTabItems":
            this.api.sounds.events.onBannerSpellItemButtonClick();
            this.setCurrentTab("Items");
            break;
         case "_ctrCC":
            if(this._ctrCC._visible)
            {
               if(this.api.kernel.TutorialManager.isTutorialMode)
               {
                  this.api.kernel.TutorialManager.onWaitingCase({code:"CC_CONTAINER_SELECT"});
                  break;
               }
               this.api.kernel.GameManager.switchToSpellLaunch(this.api.datacenter.Player.Spells[0],false);
            }
            break;
         default:
            switch(this._sCurrentTab)
            {
               case "Spells":
                  this.api.sounds.events.onBannerSpellSelect();
                  if(this.api.kernel.TutorialManager.isTutorialMode)
                  {
                     this.api.kernel.TutorialManager.onWaitingCase({code:"SPELL_CONTAINER_SELECT",params:[Number(oEvent.target._name.substr(4))]});
                     break;
                  }
                  if(this.gapi.getUIComponent("Spells") != undefined)
                  {
                     return undefined;
                  }
                  var _loc3_ = oEvent.target.contentData;
                  if(_loc3_ == undefined)
                  {
                     return undefined;
                  }
                  this.api.kernel.GameManager.switchToSpellLaunch(_loc3_,true);
                  break;
               case "Items":
                  if(this.api.kernel.TutorialManager.isTutorialMode)
                  {
                     this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_CONTAINER_SELECT",params:[Number(oEvent.target._name.substr(4))]});
                     break;
                  }
                  if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.target.contentData != undefined)
                  {
                     this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
                     return undefined;
                  }
                  var _loc4_ = this.gapi.getUIComponent("Inventory");
                  if(_loc4_ != undefined)
                  {
                     _loc4_.showItemInfos(oEvent.target.contentData);
                  }
                  else
                  {
                     var _loc5_ = oEvent.target.contentData;
                     if(_loc5_ == undefined)
                     {
                        return undefined;
                     }
                     if(this.api.datacenter.Player.canUseObject)
                     {
                        if(_loc5_.canTarget)
                        {
                           this.api.kernel.GameManager.switchToItemTarget(_loc5_);
                        }
                        else if(_loc5_.canUse && oEvent.keyBoard)
                        {
                           this.api.network.Items.use(_loc5_.ID);
                        }
                     }
                  }
                  break;
            }
      }
   }
   function dblClick(oEvent)
   {
      switch(this._sCurrentTab)
      {
         case "Spells":
            if((_loc0_ = oEvent.target._name) !== "_ctrCC")
            {
               var _loc3_ = oEvent.target.contentData;
            }
            else
            {
               _loc3_ = this.api.datacenter.Player.Spells[0];
            }
            if(_loc3_ == undefined)
            {
               return undefined;
            }
            this.gapi.loadUIAutoHideComponent("SpellInfos","SpellInfos",{spell:_loc3_},{bStayIfPresent:true});
            break;
         case "Items":
            var _loc4_ = oEvent.target.contentData;
            if(_loc4_ != undefined)
            {
               if(!_loc4_.canUse || !this.api.datacenter.Player.canUseObject)
               {
                  return undefined;
               }
               this.api.network.Items.use(_loc4_.ID);
            }
      }
   }
   function over(oEvent)
   {
      if(!this.gapi.isCursorHidden())
      {
         return undefined;
      }
      if((var _loc0_ = oEvent.target._name) !== "_ctrCC")
      {
         switch(this._sCurrentTab)
         {
            case "Spells":
               var _loc5_ = oEvent.target.contentData;
               if(_loc5_ != undefined)
               {
                  this.gapi.showTooltip(_loc5_.name + " (" + _loc5_.apCost + " " + this.api.lang.getText("AP") + (_loc5_.actualCriticalHit <= 0?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + _loc5_.actualCriticalHit) + ")",oEvent.target,-20,{bXLimit:true,bYLimit:false});
               }
               break;
            case "Items":
               var _loc6_ = oEvent.target.contentData;
               if(_loc6_ != undefined)
               {
                  var _loc7_ = _loc6_.name;
                  if(this.gapi.getUIComponent("Inventory") == undefined)
                  {
                     if(_loc6_.canUse && _loc6_.canTarget)
                     {
                        _loc7_ = _loc7_ + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
                     }
                     else
                     {
                        if(_loc6_.canUse)
                        {
                           _loc7_ = _loc7_ + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
                        }
                        if(_loc6_.canTarget)
                        {
                           _loc7_ = _loc7_ + ("\n" + this.api.lang.getText("HELP_SHORTCUT_CLICK"));
                        }
                     }
                  }
                  this.gapi.showTooltip(_loc7_,oEvent.target,-30,{bXLimit:true,bYLimit:false});
               }
         }
      }
      else
      {
         var _loc3_ = this.api.datacenter.Player.Spells[0];
         var _loc4_ = this.api.kernel.GameManager.getCriticalHitChance(this.api.datacenter.Player.weaponItem.criticalHit);
         this.gapi.showTooltip(_loc3_.name + "\n" + _loc3_.descriptionVisibleEffects + " (" + _loc3_.apCost + " " + this.api.lang.getText("AP") + (!!_global.isNaN(_loc4_)?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + _loc4_) + ")",oEvent.target,-30,{bXLimit:true,bYLimit:false});
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function drag(oEvent)
   {
      var _loc3_ = oEvent.target.contentData;
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      switch(this._sCurrentTab)
      {
         case "Spells":
            if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
            {
               return undefined;
            }
            break;
         case "Items":
            if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
            {
               return undefined;
            }
            break;
      }
      this.gapi.removeCursor();
      this.gapi.setCursor(_loc3_);
   }
   function drop(oEvent)
   {
      switch(this._sCurrentTab)
      {
         case "Spells":
            §§push(var _loc0_ = oEvent.target);
            if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
            {
               return undefined;
            }
            var _loc3_ = this.gapi.getCursor();
            if(_loc3_ == undefined)
            {
               return undefined;
            }
            this.gapi.removeCursor();
            var _loc4_ = _loc3_.position;
            var _loc5_ = oEvent.target.params.position;
            if(_loc4_ == _loc5_)
            {
               return undefined;
            }
            if(_loc4_ != undefined)
            {
               this["_ctr" + _loc4_].contentData = undefined;
            }
            var _loc6_ = this["_ctr" + _loc5_].contentData;
            if(_loc6_ != undefined)
            {
               _loc6_.position = undefined;
            }
            _loc3_.position = _loc5_;
            oEvent.target.contentData = _loc3_;
            this.api.network.Spells.moveToUsed(_loc3_.ID,_loc5_);
            this.addToQueue({object:this,method:this.setSpellStateOnAllContainers});
            break;
         case "Items":
            if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
            {
               return undefined;
            }
            var _loc7_ = this.gapi.getCursor();
            if(_loc7_ == undefined)
            {
               return undefined;
            }
            if(!_loc7_.canMoveToShortut)
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_MOVE_ITEM_HERE"),"ERROR_BOX");
               return undefined;
            }
            this.gapi.removeCursor();
            var _loc8_ = oEvent.target.params.position + dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
            if(_loc7_.position == _loc8_)
            {
               return undefined;
            }
            if(_loc7_.Quantity > 1)
            {
               var _loc9_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:_loc7_.Quantity,max:_loc7_.Quantity,useAllStage:true,params:{type:"drop",item:_loc7_,position:_loc8_}},{bAlwaysOnTop:true});
               _loc9_.addEventListener("validate",this);
            }
            else
            {
               this.api.network.Items.movement(_loc7_.ID,_loc8_,1);
            }
            break;
      }
      §§pop();
   }
   function modelChanged(oEvent)
   {
      switch(oEvent.eventName)
      {
         case "updateOne":
         case "updateAll":
      }
      if(oEvent.target == this.api.datacenter.Player.Spells)
      {
         if(this._sCurrentTab == "Spells")
         {
            this.updateSpells();
         }
      }
      else if(this._sCurrentTab == "Items")
      {
         this.updateItems();
      }
   }
   function validate(oEvent)
   {
      if((var _loc0_ = oEvent.params.type) === "drop")
      {
         this.gapi.removeCursor();
         if(oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
         {
            this.api.network.Items.movement(oEvent.params.item.ID,oEvent.params.position,Math.min(oEvent.value,oEvent.params.item.Quantity));
         }
      }
   }
}
