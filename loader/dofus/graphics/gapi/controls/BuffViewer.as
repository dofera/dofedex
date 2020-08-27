class dofus.graphics.gapi.controls.BuffViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BuffViewer";
	function BuffViewer()
	{
		super();
	}
	function __set__itemData(var2)
	{
		this._oItem = var2;
		this.addToQueue({object:this,method:this.showItemData,params:[var2]});
		return this.__get__itemData();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.BuffViewer.CLASS_NAME);
	}
	function createChildren()
	{
	}
	function showItemData(var2)
	{
		if(var2 != undefined)
		{
			this._lblName.text = var2.name;
			this._txtDescription.text = var2.description;
			this._ldrIcon.contentPath = var2.iconFile;
			this._lstInfos.dataProvider = var2.effects;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._txtDescription.text = "";
			this._ldrIcon.contentPath = "";
			this._lstInfos.removeAll();
		}
	}
}
