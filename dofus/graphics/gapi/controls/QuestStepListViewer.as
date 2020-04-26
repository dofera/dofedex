class dofus.graphics.gapi.controls.QuestStepListViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "QuestStepListViewer";
	function QuestStepListViewer()
	{
		super();
	}
	function __set__steps(loc2)
	{
		this._eaSteps = loc2;
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
			var loc2 = 0;
			while(loc2 < this._eaSteps.length)
			{
				if(this._eaSteps[loc2].isCurrent)
				{
					this._lstSteps.selectedIndex = loc2;
					this._txtDescription.text = this._eaSteps[loc2].description;
					break;
				}
				loc2 = loc2 + 1;
			}
		}
	}
	function itemSelected(loc2)
	{
		var loc3 = loc2.row.item;
		this._txtDescription.text = loc3.description;
	}
}
