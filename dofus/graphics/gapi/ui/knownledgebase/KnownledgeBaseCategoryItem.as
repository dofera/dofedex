class dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseCategoryItem extends ank.gapi.core.UIBasicComponent
{
	function KnownledgeBaseCategoryItem()
	{
		super();
		this._mcPicto._visible = false;
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lblCategory.text = loc4.n;
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
