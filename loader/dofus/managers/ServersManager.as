class dofus.managers.ServersManager extends dofus.utils.ApiElement
{
	function ServersManager()
	{
		super();
	}
	function initialize(§\x1e\x1a\x16§, §\x1e\x0f\x1b§, §\x1e\x12\x13§)
	{
		super.initialize(var3);
		this._sObjectName = var4;
		this._sFolder = var5;
		this._oFailedURL = new Object();
	}
	function loadData(§\x1e\x12\x18§)
	{
		if(this._sFile == var2)
		{
			return undefined;
		}
		this._sFile = var2;
		this.clearTimer();
		this._mcl.unloadClip(this._mc);
		this.api.ui.loadUIComponent("Waiting","Waiting");
		this._aServers = _root._loader.copyAndOrganizeDataServerList();
		this._urlIndex = -1;
		this.loadWithNextURL();
	}
	function loadWithNextURL()
	{
		this._urlIndex++;
		if(this._urlIndex < this._aServers.length && this._aServers.length > 0)
		{
			this._oCurrentServer = this._aServers[this._urlIndex];
			this._sCurrentFileURL = this._oCurrentServer.url + this._sFolder + this._sFile;
			System.security.allowDomain(this._oCurrentServer.url);
			this._mcl = new MovieClipLoader();
			this._mcl.addListener(this);
			this._timerID = _global.setInterval(this.onEventNotCall,3000);
			this._mc = _root.createEmptyMovieClip("__ANKSWFDATA__",_root.getNextHighestDepth());
			this._mcl.loadClip(this._sCurrentFileURL,this._mc);
		}
		else
		{
			this.onAllLoadFailed(this._mc);
		}
	}
	function clear()
	{
		this.clearTimer();
	}
	function getCurrentServer()
	{
		return this._oCurrentServer.url + this._sFolder;
	}
	function clearTimer()
	{
		_global.clearInterval(this._timerID);
	}
	function clearUI()
	{
		this.api.ui.unloadUIComponent("Waiting");
		this.api.ui.unloadUIComponent("CenterText");
	}
	function onEventNotCall()
	{
		this.clearTimer();
		this.onLoadError();
	}
	function onLoadStart()
	{
		this.clearTimer();
	}
	function onLoadError(§\x0b\r§)
	{
		this.api.kernel.showMessage(undefined,"Erreur au chargement du fichier \'" + this._sCurrentFileURL + "\'","DEBUG_LOG");
		this.clearTimer();
		this.onError(var2);
		this.loadWithNextURL();
	}
	function onLoadProgress()
	{
		this.clearTimer();
	}
	function onLoadComplete()
	{
		this.clearTimer();
	}
	function onLoadInit(§\x0b\r§)
	{
		this.clearTimer();
		this._sFile = undefined;
		this.clearUI();
		this.onComplete(var2);
	}
	function onAllLoadFailed(§\x0b\r§)
	{
		this.api.kernel.showMessage(undefined,"Chargement du fichier \'" + this._sFile + "\' impossible ","DEBUG_LOG");
		this.clearTimer();
		this._sFile = undefined;
		this.clearUI();
		this.onFailed(var2);
	}
}
