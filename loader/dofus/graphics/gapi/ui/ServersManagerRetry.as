class dofus.graphics.gapi.ui.ServersManagerRetry extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ServersManagerRetry";
	var _nTimer = 0;
	function ServersManagerRetry()
	{
		super();
	}
	function __set__timer(var2)
	{
		this.addToQueue({object:this,method:function(var2)
		{
			this._nTimer = Number(var2);
			if(this.initialized)
			{
				this.updateLabel();
			}
		},params:[var2]});
		return this.__get__timer();
	}
	function updateLabel()
	{
		var var2 = this.api.lang.getText("SERVERS_MANAGER_RETRY",[this._nTimer]);
		this._lblCounter.text = var2;
		this._lblCounterShadow.text = var2;
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
