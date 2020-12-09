class dofus.graphics.gapi.ui.spellforget.SpellForgetItem extends ank.gapi.core.UIBasicComponent
{
	function SpellForgetItem()
	{
		super();
	}
	function __set__list(§\x0b\x05§)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._oItem = (dofus.datacenter.Spell)var4;
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
