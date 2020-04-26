class dofus.graphics.gapi.ui.fightsinfos.FightsInfosFightItem extends ank.gapi.core.UIBasicComponent
{
	function FightsInfosFightItem()
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
			this._ldrIconTeam1.contentPath = loc4.team1IconFile;
			this._lblTeam1Count.text = loc4.team1Count;
			this._ldrIconTeam2.contentPath = loc4.team2IconFile;
			this._lblTeam2Count.text = loc4.team2Count;
			this._lblTime.text = loc4.durationString;
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
