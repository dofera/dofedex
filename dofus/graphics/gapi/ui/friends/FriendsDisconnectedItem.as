class dofus.graphics.gapi.ui.friends.FriendsDisconnectedItem extends ank.gapi.core.UIBasicComponent
{
	function FriendsDisconnectedItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			this._lblName.text = loc4.account;
			this._btnRemove._visible = true;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._btnRemove._visible = false;
		}
	}
	function remove()
	{
		this._oItem.owner.removeFriend(this._oItem.name);
	}
	function init()
	{
		super.init(false);
		this._btnRemove._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnRemove.addEventListener("click",this);
	}
	function click(loc2)
	{
		this._mcList._parent._parent.removeFriend("*" + this._oItem.account);
	}
}
