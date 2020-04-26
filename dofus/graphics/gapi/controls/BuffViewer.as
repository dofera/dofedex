class dofus.graphics.gapi.controls.BuffViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BuffViewer";
	function BuffViewer()
	{
		super();
	}
	function __set__itemData(loc2)
	{
		this._oItem = loc2;
		this.addToQueue({object:this,method:this.showItemData,params:[loc2]});
		return this.__get__itemData();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.BuffViewer.CLASS_NAME);
	}
	function createChildren()
	{
	}
	function showItemData(loc2)
	{
		if(loc2 != undefined)
		{
			this._lblName.text = loc2.name;
			this._txtDescription.text = loc2.description;
			this._ldrIcon.contentPath = loc2.iconFile;
			this._lstInfos.dataProvider = loc2.effects;
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
