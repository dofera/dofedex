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
		eval("\n\x0b").events.EventDispatcher.initialize(this);
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
	function pushCall(loc2)
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
	function call(loc2)
	{
		this._bCalling = true;
		var loc3 = new Array();
		loc3.push(ank.external.ExternalConnector.CONNECTION_NAME);
		loc3.push(loc2);
		loc3.push(this._sConnectionName);
		var loc4 = 1;
		while(loc4 < arguments.length)
		{
			loc3.push(arguments[loc4]);
			loc4 = loc4 + 1;
		}
		this.send.apply(this,loc3);
	}
	function onStatus(loc2)
	{
		this._bCalling = false;
		switch(loc2.level)
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
			var loc2 = this._aCallQueue.shift();
			if(!this._bInitialized)
			{
				this.dispatchEvent({type:"onExternalConnectionFaild"});
			}
			else
			{
				this.call.apply(this,loc2.args);
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
	function onApplicationArgs(loc2)
	{
		this.dispatchEvent({type:"onApplicationArgs",args:loc2.split(" ")});
	}
	function onBrowseFileCancel()
	{
		this.dispatchEvent({type:"onBrowseFileCancel"});
	}
	function onBrowseFileSelect(loc2)
	{
		this.dispatchEvent({type:"onBrowseFileSelect",files:loc2});
	}
	function onBrowseFileToSaveCancel()
	{
		this.dispatchEvent({type:"onBrowseFileToSaveCancel"});
	}
	function onBrowseFileToSaveSelect(loc2)
	{
		this.dispatchEvent({type:"onBrowseFileToSaveSelect",file:loc2});
	}
	function onHttpDownloadError(loc2, loc3)
	{
		this.dispatchEvent({type:"onHttpDownloadError",msg:loc2,params:loc3});
	}
	function onHttpDownloadProgress(loc2, loc3)
	{
		this.dispatchEvent({type:"onHttpDownloadProgress",bl:loc2,bt:loc3});
	}
	function onHttpDownloadComplete()
	{
		this.dispatchEvent({type:"onHttpDownloadComplete"});
	}
	function onScreenResolutionError(loc2)
	{
		this.dispatchEvent({type:"onScreenResolutionError"});
	}
	function onScreenResolutionSuccess(loc2)
	{
		this.dispatchEvent({type:"onScreenResolutionSuccess"});
	}
}
