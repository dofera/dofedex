class dofus.graphics.gapi.ui.Quests extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Quests";
   function Quests()
   {
      super();
   }
   function setPendingCount(nCount)
   {
      this._lblQuestCount.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("PENDING_QUEST",[nCount]),"m",nCount < 2);
   }
   function setStep(oStep)
   {
      this.showStepViewer(true);
      this._oCurrentStep = oStep;
      if(this._sCurrentTab == "Current")
      {
         this._mcTab.step = oStep;
      }
      else
      {
         this.setCurrentTab("Current");
      }
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Quests.CLASS_NAME);
   }
   function destroy()
   {
      this.gapi.hideTooltip();
      delete this.api.datacenter.Temporary.QuestBook;
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.addListeners});
      this.showStepViewer(false);
   }
   function initTexts()
   {
      this._winBg.title = this.api.lang.getText("QUESTS_LIST");
      this._winBgViewer.title = this.api.lang.getText("STEPS");
      this._btnTabCurrent.label = this.api.lang.getText("QUESTS_CURRENT_STEP");
      this._btnTabAll.label = this.api.lang.getText("QUESTS_STEPS_LIST");
      this._dgQuests.columnsNames = [this.api.lang.getText("STATE"),this.api.lang.getText("NAME_BIG")];
      this._lblFinished.text = this.api.lang.getText("DISPLAY_FINISHED_QUESTS");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnCloseStep.addEventListener("click",this);
      this._btnTabCurrent.addEventListener("click",this);
      this._btnTabAll.addEventListener("click",this);
      this._btnFinished.addEventListener("click",this);
      this._dgQuests.addEventListener("itemSelected",this);
      this.api.datacenter.Temporary.QuestBook.quests.addEventListener("modelChanged",this);
   }
   function initData()
   {
      if(this.api.datacenter.Temporary.QuestBook == undefined)
      {
         this.api.datacenter.Temporary.QuestBook = new dofus.datacenter.QuestBook();
      }
      this.api.network.Quests.getList();
   }
   function showStepViewer(bShow)
   {
      if(bShow)
      {
         this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_QUEST_WALKTHOUGH);
      }
      this._btnCloseStep._visible = bShow;
      this._winBgViewer._visible = bShow;
      this._mcTab._visible = bShow;
      this._btnTabCurrent._visible = bShow;
      this._btnTabAll._visible = bShow;
      this._mcBackButtons._visible = bShow;
   }
   function updateCurrentTabInformations()
   {
      this._mcTab.removeMovieClip();
      switch(this._sCurrentTab)
      {
         case "Current":
            this.attachMovie("QuestStepViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y,step:this._oCurrentStep});
            break;
         case "All":
            this.attachMovie("QuestStepListViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y,steps:this._oCurrentStep.allSteps});
      }
   }
   function setCurrentTab(sNewTab)
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
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
            this.callClose();
            break;
         case "_btnTabCurrent":
            this.setCurrentTab("Current");
            break;
         case "_btnTabAll":
            this.setCurrentTab("All");
            break;
         case "_btnFinished":
            this.modelChanged();
            break;
         case "_btnCloseStep":
            this._dgQuests.selectedIndex = -1;
            this.showStepViewer(false);
      }
   }
   function itemSelected(oEvent)
   {
      var _loc3_ = oEvent.row.item;
      if(_loc3_.isFinished)
      {
         this.showStepViewer(false);
      }
      else
      {
         var _loc4_ = _loc3_.currentStep;
         this._winBgViewer.title = _loc3_.name;
         if(_loc4_ != undefined)
         {
            this.setStep(_loc4_);
         }
         else
         {
            this.api.network.Quests.getStep(_loc3_.id);
         }
         this.api.datacenter.Basics.quests_lastID = _loc3_.id;
      }
   }
   function modelChanged(oEvent)
   {
      var _loc3_ = this.api.datacenter.Temporary.QuestBook.quests;
      var _loc4_ = new ank.utils.ExtendedArray();
      if(this._btnFinished.selected)
      {
         _loc4_ = _loc3_;
      }
      else
      {
         var _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(!_loc3_[_loc5_].isFinished)
            {
               _loc4_.push(_loc3_[_loc5_]);
            }
            _loc5_ = _loc5_ + 1;
         }
      }
      this._dgQuests.dataProvider = _loc4_;
      this._dgQuests.sortOn("sortOrder",Array.NUMERIC);
      if(this.api.datacenter.Basics.quests_lastID != undefined)
      {
         var _loc6_ = 0;
         while(_loc6_ < this._dgQuests.dataProvider.length)
         {
            var _loc7_ = this._dgQuests.dataProvider[_loc6_];
            if(_loc7_.id == this.api.datacenter.Basics.quests_lastID)
            {
               this._dgQuests.selectedIndex = _loc6_;
               this.api.network.Quests.getStep(_loc7_.id);
               break;
            }
            _loc6_ = _loc6_ + 1;
         }
      }
   }
}
