class dofus.graphics.gapi.ui.fightsinfos.FightsInfosPlayerItem extends ank.gapi.core.UIBasicComponent
{
	function FightsInfosPlayerItem()
	{
		super();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._lblName.text = var4.name;
			this._lblLevel.text = var4.level;
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
