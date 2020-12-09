class dofus.managers.UIdManager
{
	static var SERVER = 1;
	static var CLIENT = 2;
	static var NONE = 3;
	function UIdManager()
	{
		this.receiving_lc = new LocalConnection();
		this.sending_lc = new LocalConnection();
		this._status = dofus.managers.UIdManager.NONE;
		this._connId = "_dofus" + Math.floor(Math.random() * 100000000);
	}
	function __get__api()
	{
		return _global.API;
	}
	static function getInstance()
	{
		if(!dofus.managers.UIdManager._self)
		{
			dofus.managers.UIdManager._self = new dofus.managers.
();
		}
		return dofus.managers.UIdManager._self;
	}
	function update()
	{
		var var2 = this.receiving_lc.connect("_dofus");
		if(this._status != dofus.managers.UIdManager.SERVER && var2)
		{
			this.makeServer();
		}
		else if(this._status != dofus.managers.UIdManager.SERVER)
		{
			if(this._status != dofus.managers.UIdManager.CLIENT)
			{
				this.makeClient();
			}
			this.receiving_lc.connect(this._connId);
			this.sending_lc.send("_dofus","getUId",this._connId);
		}
	}
	function makeServer()
	{
		this._status = dofus.managers.UIdManager.SERVER;
		this.receiving_lc.getUId = function(§\x12\x11§)
		{
			var var3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
			if(var3.data.identity)
			{
				dofus.managers.UIdManager.getInstance().sending_lc.send(var2,"setUId",var3.data.identity);
			}
			var3.close();
		};
	}
	function makeClient()
	{
		this._status = dofus.managers.UIdManager.CLIENT;
		this.receiving_lc.setUId = function(§\x1e\n\x17§)
		{
			var var3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
			var3.data.identity = var2;
			var3.close();
			dofus.managers.UIdManager.getInstance().receiving_lc.close();
		};
	}
}
