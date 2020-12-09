class dofus.graphics.gapi.ui.Quests extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Quests";
	function Quests()
	{
		super();
	}
	function setPendingCount(§\x07\b§)
	{
		this._lblQuestCount.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("PENDING_QUEST",[var2]),"m",var2 < 2);
	}
	function setStep(§\x1e\x17\x1b§)
	{
		this.showStepViewer(true);
		this._oCurrentStep = var2;
		if(this._sCurrentTab == "Current")
		{
			this._mcTab.step = var2;
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
			this.api.datacenter.Temporary.QuestBook = new dofus.datacenter.();
		}
		this.api.network.Quests.getList();
	}
	function showStepViewer(§\x15\x13§)
	{
		if(var2)
		{
			this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_QUEST_WALKTHOUGH);
		}
		this._btnCloseStep._visible = var2;
		this._winBgViewer._visible = var2;
		this._mcTab._visible = var2;
		this._btnTabCurrent._visible = var2;
		this._btnTabAll._visible = var2;
		this._mcBackButtons._visible = var2;
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
	function setCurrentTab(§\x1e\x10\x04§)
	{
		var var3 = this["_btnTab" + this._sCurrentTab];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		var4.enabled = false;
		this._sCurrentTab = var2;
		this.updateCurrentTabInformations();
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
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
			default:
				switch(null)
				{
					case "_btnFinished":
						this.modelChanged();
						break;
					case "_btnCloseStep":
						this._dgQuests.selectedIndex = -1;
						this.showStepViewer(false);
				}
		}
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		var var3 = var2.row.item;
		if(var3.isFinished)
		{
			this.showStepViewer(false);
		}
		else
		{
			var var4 = var3.currentStep;
			this._winBgViewer.title = var3.name;
			if(var4 != undefined)
			{
				this.setStep(var4);
			}
			else
			{
				this.api.network.Quests.getStep(var3.id);
			}
			this.api.datacenter.Basics.quests_lastID = var3.id;
		}
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		var var3 = this.api.datacenter.Temporary.QuestBook.quests;
		var var4 = new ank.utils.
();
		if(this._btnFinished.selected)
		{
			var4 = var3;
		}
		else
		{
			var var5 = 0;
			while(var5 < var3.length)
			{
				if(!var3[var5].isFinished)
				{
					var4.push(var3[var5]);
				}
				var5 = var5 + 1;
			}
		}
		this._dgQuests.dataProvider = var4;
		this._dgQuests.sortOn("sortOrder",Array.NUMERIC);
		if(this.api.datacenter.Basics.quests_lastID != undefined)
		{
			var var6 = 0;
			while(var6 < this._dgQuests.dataProvider.length)
			{
				var var7 = this._dgQuests.dataProvider[var6];
				if(var7.id == this.api.datacenter.Basics.quests_lastID)
				{
					this._dgQuests.selectedIndex = var6;
					this.api.network.Quests.getStep(var7.id);
					break;
				}
				var6 = var6 + 1;
			}
		}
	}
}
