class dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell extends ank.gapi.core.UIBasicComponent
{
	static var COLOR_TRANSFORM = {ra:60,rb:0,ga:60,gb:0,ba:60,bb:0};
	static var NO_COLOR_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	function GuildBoostsViewerSpell()
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
			this._oItem = loc4;
			this._lblName.text = loc4.name;
			this._lblLevel.text = loc4.level == 0?"-":loc4.level;
			this._ldrIcon.contentPath = loc4.iconFile;
			this._mcBorder._visible = true;
			this._mcBack._visible = true;
			var loc5 = this._mcList.gapi.api.datacenter.Player.guildInfos;
			this._btnBoost._visible = loc5.playerRights.canManageBoost && loc5.canBoost("s",loc4.ID);
			if(loc4.level == 0)
			{
				this.setMovieClipTransform(this._ldrIcon,dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.COLOR_TRANSFORM);
				this._mcCross._visible = true;
			}
			else
			{
				this.setMovieClipTransform(this._ldrIcon,dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
				this._mcCross._visible = false;
			}
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._ldrIcon.contentPath = "";
			this._mcBorder._visible = false;
			this._mcBack._visible = false;
			this._mcCross._visible = false;
			this._btnBoost._visible = false;
			this.setMovieClipTransform(this._ldrIcon,dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
		}
	}
	function init()
	{
		super.init(false);
		this._mcBorder._visible = false;
		this._mcBack._visible = false;
		this._mcCross._visible = false;
		this._btnBoost._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnBoost.addEventListener("click",this);
		this._btnBoost.addEventListener("over",this);
		this._btnBoost.addEventListener("out",this);
	}
	function click(loc2)
	{
		this._mcList.gapi.api.network.Guild.boostSpell(this._oItem.ID);
	}
	function over(loc2)
	{
		var loc3 = this._mcList.gapi.api;
		var loc4 = loc3.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("s",this._oItem.ID);
		this._mcList.gapi.showTooltip(loc3.lang.getText("COST") + " : " + loc4.cost,loc2.target,-20);
	}
	function out(loc2)
	{
		this._mcList.gapi.hideTooltip();
	}
}
