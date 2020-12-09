class dofus.graphics.gapi.controls.PlayerWeight extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PlayerWeight";
	function PlayerWeight()
	{
		super();
	}
	function __set__styleName(§\x1e\r\x14§)
	{
		this._sStyleName = var2;
		if(this.initialized)
		{
			this._pbWeight.styleName = var2;
		}
		return this.__get__styleName();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.PlayerWeight.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._pbWeight.addEventListener("over",this);
		this._pbWeight.addEventListener("out",this);
		this.api.datacenter.Player.addEventListener("maxWeightChanged",this);
		this.api.datacenter.Player.addEventListener("currentWeightChanged",this);
	}
	function initData()
	{
		if(this._sStyleName != undefined)
		{
			this._pbWeight.styleName = this._sStyleName;
		}
		this.currentWeightChanged({value:this.api.datacenter.Player.currentWeight});
	}
	function currentWeightChanged(§\x1e\x19\x18§)
	{
		var var3 = this.api.datacenter.Player.maxWeight;
		var var4 = var2.value;
		this._nCurrentWeight = var4;
		this._pbWeight.maximum = var3;
		this._pbWeight.value = var4;
	}
	function maxWeightChanged(§\x1e\x19\x18§)
	{
		this._pbWeight.maximum = var2.value;
	}
	function over(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target) === this._pbWeight)
		{
			var var3 = var2.target.maximum;
			var var4 = new ank.utils.(this._nCurrentWeight).addMiddleChar(" ",3);
			var var5 = new ank.utils.(var3).addMiddleChar(" ",3);
			this.gapi.showTooltip(this.api.lang.getText("PLAYER_WEIGHT",[var4,var5]),var2.target,-20);
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
}
