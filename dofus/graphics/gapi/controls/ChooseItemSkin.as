class dofus.graphics.gapi.controls.ChooseItemSkin extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChooseItemSkin";
	function ChooseItemSkin()
	{
		super();
	}
	function __set__item(loc2)
	{
		this._oItem = loc2;
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
	}
	function initData()
	{
		var loc2 = new ank.utils.();
		var loc3 = 0;
		while(loc3 < this._oItem.maxSkin)
		{
			if(this._oItem.isAssociate)
			{
				loc2.push(new dofus.datacenter.(-1,this._oItem.realUnicId,1,0,"",0,loc3,1));
			}
			else
			{
				loc2.push(new dofus.datacenter.(-1,this._oItem.unicID,1,0,"",0,loc3,1));
			}
			loc3 = loc3 + 1;
		}
		this._cgGrid.dataProvider = loc2;
	}
	function selectItem(loc2)
	{
		this._oSelectedItem = loc2.target.contentData;
	}
}
