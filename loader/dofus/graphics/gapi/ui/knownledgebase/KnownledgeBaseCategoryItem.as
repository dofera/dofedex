class dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseCategoryItem extends ank.gapi.core.UIBasicComponent
{
	function KnownledgeBaseCategoryItem()
	{
		super();
		this._mcPicto._visible = false;
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._lblCategory.text = var4.n;
			this._mcPicto._visible = true;
		}
		else if(this._lblCategory.text != undefined)
		{
			this._lblCategory.text = "";
			this._mcPicto._visible = false;
		}
	}
	function init()
	{
		super.init(false);
	}
}
