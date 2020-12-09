class dofus.graphics.gapi.controls.QuestStepListViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "QuestStepListViewer";
	function QuestStepListViewer()
	{
		super();
	}
	function __set__steps(§\x0f\x1b§)
	{
		this._eaSteps = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__steps();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.QuestStepListViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._lstSteps.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._lblSteps.text = this.api.lang.getText("QUESTS_ALL_STEPS");
	}
	function updateData()
	{
		if(this._eaSteps != undefined)
		{
			this._lstSteps.dataProvider = this._eaSteps;
			var var2 = 0;
			while(var2 < this._eaSteps.length)
			{
				if(this._eaSteps[var2].isCurrent)
				{
					this._lstSteps.selectedIndex = var2;
					this._txtDescription.text = this._eaSteps[var2].description;
					break;
				}
				var2 = var2 + 1;
			}
		}
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		var var3 = var2.row.item;
		this._txtDescription.text = var3.description;
	}
}
