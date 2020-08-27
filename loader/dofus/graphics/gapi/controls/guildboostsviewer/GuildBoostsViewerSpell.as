class dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell extends ank.gapi.core.UIBasicComponent
{
	static var COLOR_TRANSFORM = {ra:60,rb:0,ga:60,gb:0,ba:60,bb:0};
	static var NO_COLOR_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	function GuildBoostsViewerSpell()
	{
		super();
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._oItem = var4;
			this._lblName.text = var4.name;
			this._lblLevel.text = var4.level == 0?"-":var4.level;
			this._ldrIcon.contentPath = var4.iconFile;
			this._mcBorder._visible = true;
			this._mcBack._visible = true;
			var var5 = this._mcList.gapi.api.datacenter.Player.guildInfos;
			this._btnBoost._visible = var5.playerRights.canManageBoost && var5.canBoost("s",var4.ID);
			if(var4.level == 0)
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
	function click(var2)
	{
		this._mcList.gapi.api.network.Guild.boostSpell(this._oItem.ID);
	}
	function over(var2)
	{
		var var3 = this._mcList.gapi.api;
		var var4 = var3.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("s",this._oItem.ID);
		this._mcList.gapi.showTooltip(var3.lang.getText("COST") + " : " + var4.cost,var2.target,-20);
	}
	function out(var2)
	{
		this._mcList.gapi.hideTooltip();
	}
}
