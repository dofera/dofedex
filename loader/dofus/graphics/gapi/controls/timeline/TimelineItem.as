class dofus.graphics.gapi.controls.timeline.TimelineItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Timeline";
	function TimelineItem()
	{
		super();
	}
	function __get__chrono()
	{
		return this._vcChrono;
	}
	function __get__sprite()
	{
		return this._ldrSprite;
	}
	function __set__data(§\x1e\x1a\x02§)
	{
		this._oData = var2;
		this.updateHealth();
		return this.__get__data();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.timeline.TimelineItem.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.loadSprite,params:[this._oData.gfxFile]});
	}
	function loadSprite(§\x1e\x12\x18§)
	{
		this._ldrSprite.contentPath = var2;
		this._ldrSprite.addEventListener("initialization",this);
		this.api.colors.addSprite(this._ldrSprite,this._oData);
		this.setHealthTeamColor();
		this.updateHealth();
	}
	function setHealthTeamColor()
	{
		var var2 = new Color(this._mcHealth);
		var2.setRGB(dofus.Constants.TEAMS_COLOR[this._oData._team]);
	}
	function updateHealth()
	{
		this._mcHealth._yscale = this._oData._lp / this._oData._lpmax * 100;
	}
	function onRollOver()
	{
		this._mcBackRect._alpha = 50;
		this._oData.mc.onRollOver();
		this._oData.mc.showEffects(true);
	}
	function onRollOut()
	{
		this._mcBackRect._alpha = 100;
		this._oData.mc.onRollOut();
		this._oData.mc.showEffects(false);
	}
	function onRelease()
	{
		if(this._oData.isVisible && (this.api.datacenter.Game.interactionType == 2 || this.api.datacenter.Game.interactionType == 3))
		{
			this._oData.mc.onRelease();
		}
		else
		{
			var var2 = this.gapi.getUIComponent("PlayerInfos");
			var var3 = var2 != undefined && this._oData != var2.data;
			this.gapi.loadUIComponent("PlayerInfos","PlayerInfos",{data:this._oData},{bForceLoad:var3});
		}
	}
	function initialization(§\x1e\x19\x18§)
	{
		var var3 = var2.target.content;
		var3.attachMovie("staticR","anim",10);
		var3._x = 15;
		var3._y = 32;
		var3._xscale = -80;
		var3._yscale = 80;
	}
}
