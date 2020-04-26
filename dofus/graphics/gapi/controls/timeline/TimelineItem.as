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
	function __set__data(loc2)
	{
		this._oData = loc2;
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
	function loadSprite(loc2)
	{
		this._ldrSprite.contentPath = loc2;
		this._ldrSprite.addEventListener("initialization",this);
		this.api.colors.addSprite(this._ldrSprite,this._oData);
		this.setHealthTeamColor();
		this.updateHealth();
	}
	function setHealthTeamColor()
	{
		var loc2 = new Color(this._mcHealth);
		loc2.setRGB(dofus.Constants.TEAMS_COLOR[this._oData._team]);
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
			var loc2 = this.gapi.getUIComponent("PlayerInfos");
			var loc3 = loc2 != undefined && this._oData != loc2.data;
			this.gapi.loadUIComponent("PlayerInfos","PlayerInfos",{data:this._oData},{bForceLoad:loc3});
		}
	}
	function initialization(loc2)
	{
		var loc3 = loc2.target.content;
		loc3.attachMovie("staticR","anim",10);
		loc3._x = 15;
		loc3._y = 32;
		loc3._xscale = -80;
		loc3._yscale = 80;
	}
}
