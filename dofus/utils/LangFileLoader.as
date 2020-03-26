class dofus.utils.LangFileLoader extends ank.utils.QueueEmbedMovieClip
{
   function LangFileLoader()
   {
      super();
      AsBroadcaster.initialize(this);
   }
   function load(aServers, sFile, mc, sSharedObjectName, sFileName, sLang, bUseMultiSO)
   {
      this._aServers = aServers;
      this._sFile = sFile;
      this._mc = mc;
      this._urlIndex = -1;
      this._sSharedObjectName = sSharedObjectName;
      this._sFileName = sFileName;
      this._sLang = sLang;
      this._bUseMultiSO = bUseMultiSO;
      this.loadWithNextURL();
   }
   function loadWithNextURL()
   {
      this._urlIndex = this._urlIndex + 1;
      if(this._urlIndex < this._aServers.length && this._aServers.length > 0)
      {
         var _loc2_ = this._aServers[this._urlIndex].url;
         var _loc3_ = _loc2_ + this._sFile;
         System.security.allowDomain(_loc2_);
         this._mcl = new MovieClipLoader();
         this._mcl.addListener(this);
         this._progressTimer = _global.setInterval(this.onTimedProgress,1000);
         this._timerID = _global.setInterval(this.onEventNotCall,5000);
         this._mcl.loadClip(_loc3_,this._mc);
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
   function onEventNotCall(mc)
   {
      _global.clearInterval(this._timerID);
      this.onLoadError(mc,"unknown",-1);
   }
   function onLoadStart(mc)
   {
      _global.clearInterval(this._timerID);
      this.broadcastMessage("onLoadStart",mc,this.getCurrentServer());
   }
   function onLoadError(mc, errorCode, httpStatus)
   {
      _global.clearInterval(this._timerID);
      _global.clearInterval(this._progressTimer);
      this.broadcastMessage("onLoadError",mc,errorCode,httpStatus,this.getCurrentServer());
      this.loadWithNextURL();
   }
   function onTimedProgress()
   {
      var _loc2_ = this._mcl.getProgress(this._mc);
      this.broadcastMessage("onLoadProgress",this._mc,_loc2_.bytesLoaded,_loc2_.bytesTotal,this.getCurrentServer());
   }
   function onLoadComplete(mc, httpStatus)
   {
      _global.clearInterval(this._timerID);
      _global.clearInterval(this._progressTimer);
      this.broadcastMessage("onLoadComplete",mc,httpStatus,this.getCurrentServer());
   }
   function onLoadInit(mc)
   {
      _global.clearInterval(this._timerID);
      _global.clearInterval(this._progressTimer);
      this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName);
      if(mc.FILE_BEGIN != true && mc.FILE_END != true)
      {
         this.broadcastMessage("onCorruptFile",mc,mc.getBytesTotal(),this.getCurrentServer());
         this.loadWithNextURL();
         return undefined;
      }
      if(this._so.data.VERSIONS == undefined)
      {
         this._so.data.VERSIONS = new Object();
      }
      this._so.data.VERSIONS[this._sFileName] = mc.VERSION;
      if(this._so.data.WEIGHTS == undefined)
      {
         this._so.data.WEIGHTS = new Object();
      }
      this._so.data.WEIGHTS[this._sFileName.toUpperCase()] = mc.getBytesTotal();
      this._aData = new Array();
      for(var k in mc)
      {
         if(!(k == "VERSION" || (k == "FILE_BEGIN" || k == "FILE_END")))
         {
            this._aData.push({key:k,value:mc[k]});
            delete mc.k;
         }
      }
      this._so.data.LANGUAGE = this._sLang;
      if(this._so.flush(1000000000) == false)
      {
         this.broadcastMessage("onCantWrite",mc);
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
      var _loc2_ = this._nStart;
      while(_loc2_ < this._nStart + this._nStep)
      {
         if(!this._aData[_loc2_])
         {
            break;
         }
         if(this._bUseMultiSO)
         {
            this._so = ank.utils.SharedObjectFix.getLocal(this._sSharedObjectName + "_" + this._aData[_loc2_].key);
         }
         this._so.data[this._aData[_loc2_].key] = this._aData[_loc2_].value;
         delete this._aData.register2;
         _loc2_ = _loc2_ + 1;
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
