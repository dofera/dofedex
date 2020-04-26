class dofus.graphics.gapi.ui.fightsinfos.FightsInfosPlayerItem extends ank.gapi.core.UIBasicComponent
{
	function FightsInfosPlayerItem()
	{
		super();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lblName.text = loc4.name;
			this._lblLevel.text = loc4.level;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
		}
	}
	function init()
	{
		super.init(false);
	}
}
