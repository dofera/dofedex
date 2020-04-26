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
	function setStep(loc2)
	{
		this.showStepViewer(true);
		this._oCurrentStep = loc2;
		if(this._sCurrentTab == "Current")
		{
			this._mcTab.step = loc2;
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
			this.api.datacenter.Temporary.QuestBook = new dofus.datacenter.();
		}
		this.api.network.Quests.getList();
	}
	function showStepViewer(loc2)
	{
		if(loc2)
		{
			this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_QUEST_WALKTHOUGH);
		}
		this._btnCloseStep._visible = loc2;
		this._winBgViewer._visible = loc2;
		this._mcTab._visible = loc2;
		this._btnTabCurrent._visible = loc2;
		this._btnTabAll._visible = loc2;
		this._mcBackButtons._visible = loc2;
	}
	function updateCurrentTabInformations()
	{
		this._mcTab.removeMovieClip();
		if((var loc0 = this._sCurrentTab) !== "Current")
		{
			if(loc0 === "All")
			{
				this.attachMovie("QuestStepListViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y,steps:this._oCurrentStep.allSteps});
			}
		}
		else
		{
			this.attachMovie("QuestStepViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y,step:this._oCurrentStep});
		}
	}
	function setCurrentTab(loc2)
	{
		var loc3 = this["_btnTab" + this._sCurrentTab];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		loc4.enabled = false;
		this._sCurrentTab = loc2;
		this.updateCurrentTabInformations();
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			case "_btnTabCurrent":
				this.setCurrentTab("Current");
				break;
			default:
				switch(null)
				{
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
	}
	function itemSelected(loc2)
	{
		var loc3 = loc2.row.item;
		if(loc3.isFinished)
		{
			this.showStepViewer(false);
		}
		else
		{
			var loc4 = loc3.currentStep;
			this._winBgViewer.title = loc3.name;
			if(loc4 != undefined)
			{
				this.setStep(loc4);
			}
			else
			{
				this.api.network.Quests.getStep(loc3.id);
			}
			this.api.datacenter.Basics.quests_lastID = loc3.id;
		}
	}
	function modelChanged(loc2)
	{
		var loc3 = this.api.datacenter.Temporary.QuestBook.quests;
		var loc4 = new ank.utils.();
		if(this._btnFinished.selected)
		{
			loc4 = loc3;
		}
		else
		{
			var loc5 = 0;
			while(loc5 < loc3.length)
			{
				if(!loc3[loc5].isFinished)
				{
					loc4.push(loc3[loc5]);
				}
				loc5 = loc5 + 1;
			}
		}
		this._dgQuests.dataProvider = loc4;
		this._dgQuests.sortOn("sortOrder",Array.NUMERIC);
		if(this.api.datacenter.Basics.quests_lastID != undefined)
		{
			var loc6 = 0;
			while(loc6 < this._dgQuests.dataProvider.length)
			{
				var loc7 = this._dgQuests.dataProvider[loc6];
				if(loc7.id == this.api.datacenter.Basics.quests_lastID)
				{
					this._dgQuests.selectedIndex = loc6;
					this.api.network.Quests.getStep(loc7.id);
					break;
				}
				loc6 = loc6 + 1;
			}
		}
	}
}
