class ank.utils.SharedObjectFix extends Object
{
	static var _oLocalCache = new Object();
	static var _oRemoteCache = new Object();
	function SharedObjectFix(var3)
	{
		super();
		this._so = !!var3.persistence?SharedObject.getRemote(var3.name,var3.remotePath,var3.persistence,var3.secure):SharedObject.getLocal(var3.name,var3.localPath,var3.secure);
		if(this._so.data._Data == undefined)
		{
			this._so.data._Data = new Object();
		}
		this.data = this._so.data._Data;
		this._so.onStatus = function(var2)
		{
			if(this.onStatus)
			{
				this.onStatus(var2);
			}
		};
		this._so.onSync = function(var2)
		{
			if(this.onSync)
			{
				this.onSync(var2);
			}
		};
	}
	function clear()
	{
		this.data = new Object();
		this._so.clear();
	}
	function close()
	{
		this._so.data._Data = this.data;
		this._so.close();
	}
	function flush(var2)
	{
		this._so.data._Data = this.data;
		return this._so.flush(var2);
	}
	function getSize()
	{
		this._so.data._Data = this.data;
		return this._so.getSize;
	}
	function connect(var2)
	{
		this._so.data._Data = this.data;
		return this._so.connect(var2);
	}
	function send(var2)
	{
		this._so.data._Data = this.data;
		this._so.send(var2);
	}
	function setFps(var2)
	{
		this._so.data._Data = this.data;
		return this._so.setFps(var2);
	}
	static function getLocal(var2, var3, var4)
	{
		if(!ank.utils.SharedObjectFix._oLocalCache[var2])
		{
			ank.utils.SharedObjectFix._oLocalCache[var2] = new ank.utils.({name:var2,localPath:var3,secure:var4});
		}
		return ank.utils.SharedObjectFix._oLocalCache[var2];
	}
	static function getRemote(var2, var3, var4, var5)
	{
		if(!ank.utils.SharedObjectFix._oRemoteCache[var2])
		{
			ank.utils.SharedObjectFix._oRemoteCache[var2] = new ank.utils.({name:var2,remotePath:var3,persistence:var4,secure:var5});
		}
		return ank.utils.SharedObjectFix._oRemoteCache[var2];
	}
	static function deleteAll(var2)
	{
		SharedObject.deleteAll();
	}
	static function getDiskUsage(var2)
	{
		return SharedObject.getDiskUsage(var2);
	}
}
