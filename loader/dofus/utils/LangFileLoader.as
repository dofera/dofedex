class dofus.utils.LangFileLoader extends ank.utils.QueueEmbedMovieClip
{
	function LangFileLoader()
	{
		super();
		AsBroadcaster.initialize(this);
	}
	function load(§\x1d\x0f§, §\x1e\x12\x18§, §\x0b\r§, §\x1e\x0e\x05§, §\x1e\x12\x17§, §\x1e\x11\b§, §\x14\x06§)
	{
		this._aServers = var2;
		this._sFile = var3;
		this._mc = var4;
		this._urlIndex = -1;
		this._sSharedObjectName = var5;
		this._sFileName = var6;
		this._sLang = var7;
		this._bUseMultiSO = var8;
		this.loadWithNextURL();
	}
	function loadWithNextURL()
	{
		this._urlIndex++;
		if(this._urlIndex < this._aServers.length && this._aServers.length > 0)
		{
			var var2 = this._aServers[this._urlIndex].url;
			var var3 = var2 + this._sFile;
			System.security.allowDomain(var2);
			this._mcl = new MovieClipLoader();
			this._mcl.addListener(this);
			this._progressTimer = _global.setInterval(this.onTimedProgress,1000);
			this._timerID = _global.setInterval(this.onEventNotCall,5000);
			org.flashdevelop.utils.FlashConnect.mtrace("[wtf] -> Chargement de " + var3,"dofus.utils.LangFileLoader::loadWithNextURL","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/utils/LangFileLoader.as",90);
			this._mcl.loadClip(var3,this._mc);
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
	function onEventNotCall(§\x0b\r§)
	{
		_global.clearInterval(this._timerID);
		this.onLoadError(var2,"unknown",-1);
	}
	function onLoadStart(§\x0b\r§)
	{
		_global.clearInterval(this._timerID);
		this.broadcastMessage("onLoadStart",var2,this.getCurrentServer());
	}
	function onLoadError(§\x0b\r§, §\x0f\x0f§, §\r\f§)
	{
		_global.clearInterval(this._timerID);
		_global.clearInterval(this._progressTimer);
		this.broadcastMessage("onLoadError",var2,var3,var4,this.getCurrentServer());
		this.loadWithNextURL();
	}
	function onTimedProgress()
	{
		var var2 = this._mcl.getProgress(this._mc);
		this.broadcastMessage("onLoadProgress",this._mc,var2.bytesLoaded,var2.bytesTotal,this.getCurrentServer());
	}
	function onLoadComplete(§\x0b\r§, §\r\f§)
	{
		_global.clearInterval(this._timerID);
		_global.clearInterval(this._progressTimer);
		this.broadcastMessage("onLoadComplete",var2,var3,this.getCurrentServer());
	}
	function onLoadInit(§\x0b\r§)
	{
		_global.clearInterval(this._timerID);
		_global.clearInterval(this._progressTimer);
		this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName);
		if(var2.FILE_BEGIN != true && var2.FILE_END != true)
		{
			this.broadcastMessage("onCorruptFile",var2,var2.getBytesTotal(),this.getCurrentServer());
			this.loadWithNextURL();
			return undefined;
		}
		if(this._so.data.VERSIONS == undefined)
		{
			this._so.data.VERSIONS = new Object();
		}
		this._so.data.VERSIONS[this._sFileName] = var2.VERSION;
		if(this._so.data.WEIGHTS == undefined)
		{
			this._so.data.WEIGHTS = new Object();
		}
		this._so.data.WEIGHTS[this._sFileName.toUpperCase()] = var2.getBytesTotal();
		this._aData = new Array();
		for(var k in var2)
		{
			if(!(k == "VERSION" || (k == "FILE_BEGIN" || k == "FILE_END")))
			{
				this._aData.push({key:k,value:var2[k]});
				delete register2.k;
			}
		}
		this._so.data.LANGUAGE = this._sLang;
		if(this._so.flush(1000000000) == false)
		{
			this.broadcastMessage("onCantWrite",var2);
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
		var var2 = this._nStart;
		while(var2 < this._nStart + this._nStep)
		{
			if(!this._aData[var2])
			{
				break;
			}
			if(this._bUseMultiSO)
			{
				this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName + "_" + this._aData[var2].key);
			}
			this._so.data[this._aData[var2].key] = this._aData[var2].value;
			delete this._aData.register2;
			var2 = var2 + 1;
		}
		this._nStart = this._nStart + this._nStep;
		org.flashdevelop.utils.FlashConnect.mtrace("[wtf]Flush des données","dofus.utils.LangFileLoader::processFile","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/utils/LangFileLoader.as",248);
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
