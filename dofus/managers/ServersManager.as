class dofus.managers.ServersManager extends dofus.utils.ApiElement
{
	function ServersManager()
	{
		super();
	}
	function initialize(loc2, loc3, loc4)
	{
		super.initialize(loc3);
		this._sObjectName = loc4;
		this._sFolder = loc5;
		this._oFailedURL = new Object();
	}
	function loadData(loc2)
	{
		if(this._sFile == loc2)
		{
			return undefined;
		}
		this._sFile = loc2;
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
	function onLoadError(loc2)
	{
		this.api.kernel.showMessage(undefined,"Erreur au chargement du fichier \'" + this._sCurrentFileURL + "\'","DEBUG_LOG");
		this.clearTimer();
		this.onError(loc2);
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
	function onLoadInit(loc2)
	{
		this.clearTimer();
		this._sFile = undefined;
		this.clearUI();
		this.onComplete(loc2);
	}
	function onAllLoadFailed(loc2)
	{
		this.api.kernel.showMessage(undefined,"Chargement du fichier \'" + this._sFile + "\' impossible ","DEBUG_LOG");
		this.clearTimer();
		this._sFile = undefined;
		this.clearUI();
		this.onFailed(loc2);
	}
}
