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
			dofus.managers.UIdManager._self = new dofus.managers.();
		}
		return dofus.managers.UIdManager._self;
	}
	function update()
	{
		var loc2 = this.receiving_lc.connect("_dofus");
		if(this._status != dofus.managers.UIdManager.SERVER && loc2)
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
		this.receiving_lc.getUId = function(loc2)
		{
			var loc3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
			if(loc3.data.identity)
			{
				dofus.managers.UIdManager.getInstance().sending_lc.send(loc2,"setUId",loc3.data.identity);
			}
			loc3.close();
		};
	}
	function makeClient()
	{
		this._status = dofus.managers.UIdManager.CLIENT;
		this.receiving_lc.setUId = function(loc2)
		{
			var loc3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
			loc3.data.identity = loc2;
			loc3.close();
			dofus.managers.UIdManager.getInstance().receiving_lc.close();
		};
	}
}
