class dofus.utils.LangFileLoader extends ank.utils.QueueEmbedMovieClip
{
	function LangFileLoader()
	{
		super();
		AsBroadcaster.initialize(this);
	}
	function load(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		this._aServers = loc2;
		this._sFile = loc3;
		this._mc = loc4;
		this._urlIndex = -1;
		this._sSharedObjectName = loc5;
		this._sFileName = loc6;
		this._sLang = loc7;
		this._bUseMultiSO = loc8;
		this.loadWithNextURL();
	}
	function loadWithNextURL()
	{
		this._urlIndex++;
		if(this._urlIndex < this._aServers.length && this._aServers.length > 0)
		{
			var loc2 = this._aServers[this._urlIndex].url;
			var loc3 = loc2 + this._sFile;
			System.security.allowDomain(loc2);
			this._mcl = new MovieClipLoader();
			this._mcl.addListener(this);
			this._progressTimer = _global.setInterval(this.onTimedProgress,1000);
			this._timerID = _global.setInterval(this.onEventNotCall,5000);
			this._mcl.loadClip(loc3,this._mc);
		}
		else
		{
			this.broadcastMessage("onAllLoadFailed",this._mc);
		}
	}
	function getCurrentServer()
	{
		return this._aServers[this._urlIndex];
	}
	function onEventNotCall(loc2)
	{
		_global.clearInterval(this._timerID);
		this.onLoadError(loc2,"unknown",-1);
	}
	function onLoadStart(loc2)
	{
		_global.clearInterval(this._timerID);
		this.broadcastMessage("onLoadStart",loc2,this.getCurrentServer());
	}
	function onLoadError(loc2, loc3, loc4)
	{
		_global.clearInterval(this._timerID);
		_global.clearInterval(this._progressTimer);
		this.broadcastMessage("onLoadError",loc2,loc3,loc4,this.getCurrentServer());
		this.loadWithNextURL();
	}
	function onTimedProgress()
	{
		var loc2 = this._mcl.getProgress(this._mc);
		this.broadcastMessage("onLoadProgress",this._mc,loc2.bytesLoaded,loc2.bytesTotal,this.getCurrentServer());
	}
	function onLoadComplete(loc2, loc3)
	{
		_global.clearInterval(this._timerID);
		_global.clearInterval(this._progressTimer);
		this.broadcastMessage("onLoadComplete",loc2,loc3,this.getCurrentServer());
	}
	function onLoadInit(loc2)
	{
		_global.clearInterval(this._timerID);
		_global.clearInterval(this._progressTimer);
		this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName);
		if(loc2.FILE_BEGIN != true && loc2.FILE_END != true)
		{
			this.broadcastMessage("onCorruptFile",loc2,loc2.getBytesTotal(),this.getCurrentServer());
			this.loadWithNextURL();
			return undefined;
		}
		if(this._so.data.VERSIONS == undefined)
		{
			this._so.data.VERSIONS = new Object();
		}
		this._so.data.VERSIONS[this._sFileName] = loc2.VERSION;
		if(this._so.data.WEIGHTS == undefined)
		{
			this._so.data.WEIGHTS = new Object();
		}
		this._so.data.WEIGHTS[this._sFileName.toUpperCase()] = loc2.getBytesTotal();
		this._aData = new Array();
		§§enumerate(loc2);
		while((var loc0 = §§enumeration()) != null)
		{
			if(!(k == "VERSION" || (k == "FILE_BEGIN" || k == "FILE_END")))
			{
				this._aData.push({key:k,value:loc2[k]});
				delete register2.k;
			}
		}
		this._so.data.LANGUAGE = this._sLang;
		if(this._so.flush(1000000000) == false)
		{
			this.broadcastMessage("onCantWrite",loc2);
			return undefined;
		}
		this._nStart = 0;
		if(this._bUseMultiSO)
		{
			this._nStep = 1;
		}
		else
		{
			this._nStep = 10000000;
		}
		this.addToQueue({object:this,method:this.processFile});
	}
	function processFile()
	{
		var loc2 = this._nStart;
		while(loc2 < this._nStart + this._nStep)
		{
			if(!this._aData[loc2])
			{
				break;
			}
			if(this._bUseMultiSO)
			{
				this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName + "_" + this._aData[loc2].key);
			}
			this._so.data[this._aData[loc2].key] = this._aData[loc2].value;
			delete this._aData.register2;
			loc2 = loc2 + 1;
		}
		this._nStart = this._nStart + this._nStep;
		if(this._so.flush(1000000000) == false)
		{
			this.broadcastMessage("onCantWrite",this._mc);
			return undefined;
		}
		if(this._nStart >= this._aData.length)
		{
			this.processFileEnd();
		}
		else
		{
			this.addToQueue({object:this,method:this.processFile});
		}
	}
	function processFileEnd()
	{
		delete this._so;
		this.broadcastMessage("onLoadInit",this._mc,this.getCurrentServer());
	}
}
