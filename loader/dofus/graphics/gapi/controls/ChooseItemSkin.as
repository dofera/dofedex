class dofus.graphics.gapi.controls.ChooseItemSkin extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChooseItemSkin";
	function ChooseItemSkin()
	{
		super();
	}
	function __set__item(var2)
	{
		this._oItem = var2;
		return this.__get__item();
	}
	function __get__selectedItem()
	{
		return this._oSelectedItem;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ChooseItemSkin.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._cgGrid.addEventListener("dblClickItem",this._parent);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgGrid.multipleContainerSelectionEnabled = false;
	}
	function initData()
	{
		var var2 = new ank.utils.();
		var var3 = 0;
		while(var3 < this._oItem.maxSkin)
		{
			if(this._oItem.isAssociate)
			{
				var2.push(new dofus.datacenter.(-1,this._oItem.realUnicId,1,0,"",0,var3,1));
			}
			else
			{
				var2.push(new dofus.datacenter.(-1,this._oItem.unicID,1,0,"",0,var3,1));
			}
			var3 = var3 + 1;
		}
		this._cgGrid.dataProvider = var2;
	}
	function selectItem(var2)
	{
		this._oSelectedItem = var2.target.contentData;
	}
}
