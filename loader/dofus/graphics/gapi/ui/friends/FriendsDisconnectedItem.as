class dofus.graphics.gapi.ui.friends.FriendsDisconnectedItem extends ank.gapi.core.UIBasicComponent
{
	function FriendsDisconnectedItem()
	{
		super();
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._oItem = var4;
			this._lblName.text = var4.account;
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
	function click(var2)
	{
		this._mcList._parent._parent.removeFriend("*" + this._oItem.account);
	}
}
