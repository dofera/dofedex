class ank.utils.SharedObjectFix extends Object
{
	static var _oLocalCache = new Object();
	static var _oRemoteCache = new Object();
	function SharedObjectFix(loc3)
	{
		super();
		this._so = !!loc3.persistence?SharedObject.getRemote(loc3.name,loc3.remotePath,loc3.persistence,loc3.secure):SharedObject.getLocal(loc3.name,loc3.localPath,loc3.secure);
		if(this._so.data._Data == undefined)
		{
			this._so.data._Data = new Object();
		}
		this.data = this._so.data._Data;
		this._so.onStatus = function(loc2)
		{
			if(this.onStatus)
			{
				this.onStatus(loc2);
			}
		};
		this._so.onSync = function(loc2)
		{
			if(this.onSync)
			{
				this.onSync(loc2);
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
	function flush(loc2)
	{
		this._so.data._Data = this.data;
		return this._so.flush(loc2);
	}
	function getSize()
	{
		this._so.data._Data = this.data;
		return this._so.getSize;
	}
	function connect(loc2)
	{
		this._so.data._Data = this.data;
		return this._so.connect(loc2);
	}
	function send(loc2)
	{
		this._so.data._Data = this.data;
		this._so.send(loc2);
	}
	function setFps(loc2)
	{
		this._so.data._Data = this.data;
		return this._so.setFps(loc2);
	}
	static function getLocal(loc2, loc3, loc4)
	{
		if(!ank.utils.SharedObjectFix._oLocalCache[loc2])
		{
			ank.utils.SharedObjectFix._oLocalCache[loc2] = new ank.utils.({name:loc2,localPath:loc3,secure:loc4});
		}
		return ank.utils.SharedObjectFix._oLocalCache[loc2];
	}
	static function getRemote(loc2, loc3, loc4, loc5)
	{
		if(!ank.utils.SharedObjectFix._oRemoteCache[loc2])
		{
			ank.utils.SharedObjectFix._oRemoteCache[loc2] = new ank.utils.({name:loc2,remotePath:loc3,persistence:loc4,secure:loc5});
		}
		return ank.utils.SharedObjectFix._oRemoteCache[loc2];
	}
	static function deleteAll(loc2)
	{
		SharedObject.deleteAll();
	}
	static function getDiskUsage(loc2)
	{
		return SharedObject.getDiskUsage(loc2);
	}
}
