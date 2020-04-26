class dofus.graphics.gapi.controls.PlayerWeight extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PlayerWeight";
	function PlayerWeight()
	{
		super();
	}
	function __set__styleName(loc2)
	{
		this._sStyleName = loc2;
		if(this.initialized)
		{
			this._pbWeight.styleName = loc2;
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
	function currentWeightChanged(loc2)
	{
		var loc3 = this.api.datacenter.Player.maxWeight;
		var loc4 = loc2.value;
		this._nCurrentWeight = loc4;
		this._pbWeight.maximum = loc3;
		this._pbWeight.value = loc4;
	}
	function maxWeightChanged(loc2)
	{
		this._pbWeight.maximum = loc2.value;
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) === this._pbWeight)
		{
			var loc3 = loc2.target.maximum;
			var loc4 = new ank.utils.(this._nCurrentWeight).addMiddleChar(" ",3);
			var loc5 = new ank.utils.(loc3).addMiddleChar(" ",3);
			this.gapi.showTooltip(this.api.lang.getText("PLAYER_WEIGHT",[loc4,loc5]),loc2.target,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
