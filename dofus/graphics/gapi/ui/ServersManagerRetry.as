class dofus.graphics.gapi.ui.ServersManagerRetry extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ServersManagerRetry";
	var _nTimer = 0;
	function ServersManagerRetry()
	{
		super();
	}
	function __set__timer(loc2)
	{
		this.addToQueue({object:this,method:function(loc2)
		{
			this._nTimer = Number(loc2);
			if(this.initialized)
			{
				this.updateLabel();
			}
		},params:[loc2]});
		return this.__get__timer();
	}
	function updateLabel()
	{
		var loc2 = this.api.lang.getText("SERVERS_MANAGER_RETRY",[this._nTimer]);
		this._lblCounter.text = loc2;
		this._lblCounterShadow.text = loc2;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ServersManagerRetry.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.updateLabel});
	}
}
