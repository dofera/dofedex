class dofus.graphics.gapi.ui.Login.KnownledgeBaseCategoryItem extends ank.gapi.core.UIBasicComponent
{
	function KnownledgeBaseCategoryItem()
	{
		super();
		this._mcPicto._visible = false;
	}
	function setValue(var2, var3, var4)
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
