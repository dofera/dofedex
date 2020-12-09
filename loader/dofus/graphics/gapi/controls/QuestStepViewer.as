class dofus.graphics.gapi.controls.QuestStepViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "QuestStepViewer";
	function QuestStepViewer()
	{
		super();
	}
	function __set__step(§\x1e\x17\x1b§)
	{
		this._oStep = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__step();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.QuestStepViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.updateData});
		this._btnDialog._visible = false;
	}
	function addListeners()
	{
		this._btnDialog.addEventListener("click",this);
		this._btnDialog.addEventListener("over",this);
		this._btnDialog.addEventListener("out",this);
		this._lstObjectives.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._lblObjectives.text = this.api.lang.getText("QUESTS_OBJECTIVES");
		this._lblStep.text = this.api.lang.getText("STEP");
		this._lblRewards.text = this.api.lang.getText("QUESTS_REWARDS");
	}
	function updateData()
	{
		if(this._oStep != undefined)
		{
			this._lblStep.text = this.api.lang.getText("STEP") + " : " + this._oStep.name;
			this._txtDescription.text = this._oStep.description;
			this._lstObjectives.dataProvider = this._oStep.objectives;
			this._lstRewards.dataProvider = this._oStep.rewards;
			this._btnDialog._visible = this._oStep.dialogID != undefined;
		}
	}
	function over(§\x1e\x19\x18§)
	{
		var var3 = this._oStep.dialogID;
		var var4 = this._oStep.dialogParams;
		var var5 = new dofus.datacenter.(var3,undefined,var4);
		this.gapi.showTooltip(this.api.lang.getText("STEP_DIALOG") + " :\n\n" + var5.label,var2.target,20);
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
	function click(§\x1e\x19\x18§)
	{
		var var3 = this._oStep.dialogID;
		var var4 = this._oStep.dialogParams;
		var var5 = new dofus.datacenter.(var3,undefined,var4);
		this.api.kernel.showMessage(this.api.lang.getText("STEP_DIALOG"),var5.label,"ERROR_BOX");
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		var var3 = var2.row.item;
		if(var3.x != undefined && var3.y != undefined)
		{
			this.api.kernel.GameManager.updateCompass(var3.x,var3.y);
		}
	}
}
