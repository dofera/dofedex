class ank.external.ExternalConnector extends LocalConnection
{
	static var CONNECTION_NAME = "__ank.external.connector__";
	static var TIME_OUT = 1500;
	static var TIME_OUT_LAYER = "externalconnectortimeout";
	var _bInitializing = false;
	var _bInitialized = false;
	var _aCallQueue = new Array();
	var _bCalling = false;
	function ExternalConnector()
	{
		super();
		mx.events.EventDispatcher.initialize(this);
		this._sConnectionName = ank.external.ExternalConnector.CONNECTION_NAME + new Date().getTime() + random(100000);
		this.connect(this._sConnectionName);
		ank.utils.Timer.setTimer(this,"externalconnector",this,this.initialize,100);
	}
	static function getInstance()
	{
		if(ank.external.ExternalConnector._oInstance == undefined)
		{
			ank.external.ExternalConnector._oInstance = new ank.external.ExternalConnector();
		}
		return ank.external.ExternalConnector._oInstance;
	}
	function pushCall(var2)
	{
		this._aCallQueue.push({args:arguments});
		if(!this._bInitializing)
		{
			if(!this._bCalling)
			{
				this.processQueue();
			}
			else if(!this._bInitialized)
			{
				this.onUnknownMethod();
			}
		}
	}
	function call(var2)
	{
		this._bCalling = true;
		var var3 = new Array();
		var3.push(ank.external.ExternalConnector.CONNECTION_NAME);
		var3.push(var2);
		var3.push(this._sConnectionName);
		var var4 = 1;
		while(var4 < arguments.length)
		{
			var3.push(arguments[var4]);
			var4 = var4 + 1;
		}
		this.send.apply(this,var3);
	}
	function onStatus(var2)
	{
		this._bCalling = false;
		switch(var2.level)
		{
			case "status":
				break;
			case "error":
				this.dispatchEvent({type:"onExternalConnectionFaild"});
		}
		if(this._bInitialized)
		{
			this.processQueue();
		}
	}
	function toString()
	{
		return "ExternalConnector" + " initialized:" + this._bInitialized + " calling:" + this._bCalling;
	}
	function initialize()
	{
		this._bInitializing = true;
		this.call("Initialize");
		ank.utils.Timer.setTimer(this,ank.external.ExternalConnector.TIME_OUT_LAYER,this,this.onInitializeFaild,ank.external.ExternalConnector.TIME_OUT);
	}
	function processQueue()
	{
		if(this._aCallQueue.length != 0)
		{
			var var2 = this._aCallQueue.shift();
			if(!this._bInitialized)
			{
				this.dispatchEvent({type:"onExternalConnectionFaild"});
			}
			else
			{
				this.call.apply(this,var2.args);
			}
		}
	}
	function onInitialize()
	{
		ank.utils.Timer.removeTimer(this,ank.external.ExternalConnector.TIME_OUT_LAYER);
		this._bInitializing = false;
		this._bInitialized = true;
		this.processQueue();
	}
	function onInitializeFaild()
	{
		ank.utils.Timer.removeTimer(this,ank.external.ExternalConnector.TIME_OUT_LAYER);
		this._bInitializing = false;
		this._bInitialized = false;
		this.dispatchEvent({type:"onExternalConnectionFaild"});
	}
	function onUnknownMethod()
	{
		this.dispatchEvent({type:"onExternalConnectionFaild"});
	}
	function onApplicationArgs(var2)
	{
		this.dispatchEvent({type:"onApplicationArgs",args:var2.split(" ")});
	}
	function onBrowseFileCancel()
	{
		this.dispatchEvent({type:"onBrowseFileCancel"});
	}
	function onBrowseFileSelect(var2)
	{
		this.dispatchEvent({type:"onBrowseFileSelect",files:var2});
	}
	function onBrowseFileToSaveCancel()
	{
		this.dispatchEvent({type:"onBrowseFileToSaveCancel"});
	}
	function onBrowseFileToSaveSelect(var2)
	{
		this.dispatchEvent({type:"onBrowseFileToSaveSelect",file:var2});
	}
	function onHttpDownloadError(var2, var3)
	{
		this.dispatchEvent({type:"onHttpDownloadError",msg:var2,params:var3});
	}
	function onHttpDownloadProgress(var2, var3)
	{
		this.dispatchEvent({type:"onHttpDownloadProgress",bl:var2,bt:var3});
	}
	function onHttpDownloadComplete()
	{
		this.dispatchEvent({type:"onHttpDownloadComplete"});
	}
	function onScreenResolutionError(var2)
	{
		this.dispatchEvent({type:"onScreenResolutionError"});
	}
	function onScreenResolutionSuccess(var2)
	{
		this.dispatchEvent({type:"onScreenResolutionSuccess"});
	}
}
