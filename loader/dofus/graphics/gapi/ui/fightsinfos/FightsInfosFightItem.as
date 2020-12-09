class dofus.graphics.gapi.ui.fightsinfos.FightsInfosFightItem extends ank.gapi.core.UIBasicComponent
{
	function FightsInfosFightItem()
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
			this._ldrIconTeam1.contentPath = var4.team1IconFile;
			this._lblTeam1Count.text = var4.team1Count;
			this._ldrIconTeam2.contentPath = var4.team2IconFile;
			this._lblTeam2Count.text = var4.team2Count;
			this._lblTime.text = var4.durationString;
			this._mcArrows._visible = true;
		}
		else if(this._lblTeam1Count.text != undefined)
		{
			this._ldrIconTeam1.contentPath = "";
			this._lblTeam1Count.text = "";
			this._ldrIconTeam2.contentPath = "";
			this._lblTeam2Count.text = "";
			this._lblTime.text = "";
			this._mcArrows._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcArrows._visible = false;
		this._mcList.gapi.api.colors.addSprite(this._ldrIconTeam1,{color1:dofus.Constants.TEAMS_COLOR[0]});
		this._mcList.gapi.api.colors.addSprite(this._ldrIconTeam2,{color1:dofus.Constants.TEAMS_COLOR[1]});
	}
}
