class dofus.graphics.gapi.controls.MountWeight extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MountWeight";
	function MountWeight()
	{
		super();
	}
	function __set__styleName(var2)
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
		super.init(false,dofus.graphics.gapi.controls.MountWeight.CLASS_NAME);
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
		this.api.datacenter.Player.mount.addEventListener("podsChanged",this);
	}
	function initData()
	{
		if(this._sStyleName != undefined)
		{
			this._pbWeight.styleName = this._sStyleName;
		}
		this.podsChanged();
	}
	function podsChanged(var2)
	{
		var var3 = this.api.datacenter.Player.mount.podsMax;
		var var4 = this.api.datacenter.Player.mount.pods;
		this._nCurrentWeight = var4;
		this._pbWeight.maximum = var3;
		this._pbWeight.value = var4;
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._pbWeight)
		{
			var var3 = var2.target.maximum;
			var var4 = new ank.utils.(this._nCurrentWeight).addMiddleChar(" ",3);
			var var5 = new ank.utils.(var3).addMiddleChar(" ",3);
			this.gapi.showTooltip(this.api.lang.getText("PLAYER_WEIGHT",[var4,var5]),var2.target,-20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
