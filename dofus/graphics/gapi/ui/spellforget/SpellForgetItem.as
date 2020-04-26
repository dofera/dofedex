class dofus.graphics.gapi.ui.spellforget.SpellForgetItem extends ank.gapi.core.UIBasicComponent
{
	function SpellForgetItem()
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
			this._oItem = (dofus.datacenter.Spell)loc4;
			this._lblName.text = this._oItem.name;
			this._lblLevel.text = String(this._oItem.level);
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
		}
	}
}
