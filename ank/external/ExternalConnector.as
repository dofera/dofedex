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
   function pushCall(sMethodName)
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
   function call(sMethodName)
   {
      this._bCalling = true;
      var _loc3_ = new Array();
      _loc3_.push(ank.external.ExternalConnector.CONNECTION_NAME);
      _loc3_.push(sMethodName);
      _loc3_.push(this._sConnectionName);
      var _loc4_ = 1;
      while(_loc4_ < arguments.length)
      {
         _loc3_.push(arguments[_loc4_]);
         _loc4_ = _loc4_ + 1;
      }
      this.send.apply(this,_loc3_);
   }
   function onStatus(oInfos)
   {
      this._bCalling = false;
      switch(oInfos.level)
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
         var _loc2_ = this._aCallQueue.shift();
         if(!this._bInitialized)
         {
            this.dispatchEvent({type:"onExternalConnectionFaild"});
         }
         else
         {
            this.call.apply(this,_loc2_.args);
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
   function onApplicationArgs(sArgs)
   {
      this.dispatchEvent({type:"onApplicationArgs",args:sArgs.split(" ")});
   }
   function onBrowseFileCancel()
   {
      this.dispatchEvent({type:"onBrowseFileCancel"});
   }
   function onBrowseFileSelect(aFiles)
   {
      this.dispatchEvent({type:"onBrowseFileSelect",files:aFiles});
   }
   function onBrowseFileToSaveCancel()
   {
      this.dispatchEvent({type:"onBrowseFileToSaveCancel"});
   }
   function onBrowseFileToSaveSelect(sFile)
   {
      this.dispatchEvent({type:"onBrowseFileToSaveSelect",file:sFile});
   }
   function onHttpDownloadError(sMsg, mParams)
   {
      this.dispatchEvent({type:"onHttpDownloadError",msg:sMsg,params:mParams});
   }
   function onHttpDownloadProgress(nBytesLoaded, nBytesTotal)
   {
      this.dispatchEvent({type:"onHttpDownloadProgress",bl:nBytesLoaded,bt:nBytesTotal});
   }
   function onHttpDownloadComplete()
   {
      this.dispatchEvent({type:"onHttpDownloadComplete"});
   }
   function onScreenResolutionError(oEvent)
   {
      this.dispatchEvent({type:"onScreenResolutionError"});
   }
   function onScreenResolutionSuccess(oEvent)
   {
      this.dispatchEvent({type:"onScreenResolutionSuccess"});
   }
}
