class ank.battlefield.LoadManager extends MovieClip
{
   static var MAX_PARALLELE_LOAD = 3;
   static var STATE_WAITING = 0;
   static var STATE_LOADING = 1;
   static var STATE_LOADED = 2;
   static var STATE_ERROR = -1;
   static var STATE_UNKNOWN = -1;
   function LoadManager(mc)
   {
      super();
      this.initialize(mc);
   }
   function processLoad()
   {
      var _loc2_ = 0;
      while(_loc2_ < ank.battlefield.LoadManager._aMovieClipLoader.length)
      {
         if(this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
         {
            return undefined;
         }
         if(ank.battlefield.LoadManager._aMovieClipLoader[_loc2_].state == ank.battlefield.LoadManager.STATE_WAITING)
         {
            ank.battlefield.LoadManager._aMovieClipLoader[_loc2_].state = ank.battlefield.LoadManager.STATE_LOADING;
            ank.battlefield.LoadManager._aMovieClipLoader[_loc2_].loader.loadClip(ank.battlefield.LoadManager._aMovieClipLoader[_loc2_].file,ank.battlefield.LoadManager._aMovieClipLoader[_loc2_].container);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function getFileByMc(mc)
   {
      var _loc3_ = 0;
      while(_loc3_ < ank.battlefield.LoadManager._aMovieClipLoader.length)
      {
         if(ank.battlefield.LoadManager._aMovieClipLoader[_loc3_].container === mc)
         {
            return ank.battlefield.LoadManager._aMovieClipLoader[_loc3_];
         }
         _loc3_ = _loc3_ + 1;
      }
      return undefined;
   }
   function getFileByName(sFile)
   {
      var _loc3_ = 0;
      while(_loc3_ < ank.battlefield.LoadManager._aMovieClipLoader.length)
      {
         if(ank.battlefield.LoadManager._aMovieClipLoader[_loc3_].file == sFile)
         {
            return ank.battlefield.LoadManager._aMovieClipLoader[_loc3_];
         }
         _loc3_ = _loc3_ + 1;
      }
      return undefined;
   }
   function initialize(mc)
   {
      mx.events.EventDispatcher.initialize(this);
      ank.battlefield.LoadManager._aMovieClipLoader = new Array();
      this._mcMainContainer = mc;
   }
   function loadFile(sFile)
   {
      if(this.isRegister(sFile))
      {
         if(this.isLoaded(sFile))
         {
            this.onFileLoaded(sFile);
         }
         else
         {
            return undefined;
         }
      }
      else
      {
         var _loc3_ = new Object();
         _loc3_.file = sFile;
         _loc3_.bitLoaded = 0;
         _loc3_.bitTotal = 1;
         _loc3_.state = ank.battlefield.LoadManager.STATE_WAITING;
         _loc3_.loader = new MovieClipLoader();
         var _loc4_ = this;
         _loc3_.loader.addListener(_loc4_);
         _loc3_.container = this._mcMainContainer.createEmptyMovieClip(sFile.split("/").join("_").split(".").join("_"),this._mcMainContainer.getNextHighestDepth());
         ank.battlefield.LoadManager._aMovieClipLoader.push(_loc3_);
         if(this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
         {
            return undefined;
         }
         _loc3_.state = ank.battlefield.LoadManager.STATE_LOADING;
         _loc3_.loader.loadClip(sFile,_loc3_.container);
      }
   }
   function loadFiles(aFiles)
   {
      var _loc3_ = 0;
      while(_loc3_ < aFiles.length)
      {
         this.loadFile(aFiles[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
   }
   function __get__waitingRequest()
   {
      var _loc2_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < ank.battlefield.LoadManager._aMovieClipLoader.length)
      {
         if(ank.battlefield.LoadManager._aMovieClipLoader[_loc3_].state == ank.battlefield.LoadManager.STATE_LOADING)
         {
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
   function isRegister(sFile)
   {
      var _loc3_ = 0;
      while(_loc3_ < ank.battlefield.LoadManager._aMovieClipLoader.length)
      {
         if(sFile == ank.battlefield.LoadManager._aMovieClipLoader[_loc3_].file)
         {
            return true;
         }
         _loc3_ = _loc3_ + 1;
      }
      return false;
   }
   function isLoaded(sFile)
   {
      if(!this.isRegister(sFile))
      {
         return false;
      }
      var _loc3_ = 0;
      while(_loc3_ < ank.battlefield.LoadManager._aMovieClipLoader.length)
      {
         if(sFile == ank.battlefield.LoadManager._aMovieClipLoader[_loc3_].file)
         {
            return ank.battlefield.LoadManager._aMovieClipLoader[_loc3_].state == ank.battlefield.LoadManager.STATE_LOADED;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function areRegister(aFiles)
   {
      var _loc3_ = true && aFiles.length > 0;
      var _loc4_ = 0;
      while(_loc4_ < aFiles.length && _loc3_)
      {
         _loc3_ = _loc3_ && this.isRegister(aFiles[_loc4_]);
         _loc4_ = _loc4_ + 1;
      }
      return _loc3_;
   }
   function areLoaded(aFiles)
   {
      if(!this.areRegister(aFiles))
      {
         return false;
      }
      var _loc3_ = true && aFiles.length > 0;
      var _loc4_ = 0;
      while(_loc4_ < aFiles.length && _loc3_)
      {
         _loc3_ = _loc3_ && this.isLoaded(aFiles[_loc4_]);
         _loc4_ = _loc4_ + 1;
      }
      return _loc3_;
   }
   function getFileState(sFile)
   {
      var _loc3_ = this.getFileByName(sFile);
      if(_loc3_)
      {
         return _loc3_.state;
      }
      return ank.battlefield.LoadManager.STATE_UNKNOWN;
   }
   function getProgression(sFile)
   {
      var _loc3_ = this.getFileByName(sFile);
      if(!_loc3_)
      {
         return undefined;
      }
      if(_loc3_.state == ank.battlefield.LoadManager.STATE_LOADED)
      {
         return 100;
      }
      return Math.floor(_loc3_.bitLoaded / _loc3_.bitTotal * 100);
   }
   function getProgressions(aFiles)
   {
      var _loc3_ = 0;
      var _loc4_ = 0;
      while(_loc4_ < aFiles.length)
      {
         var _loc5_ = this.getProgression(aFiles[_loc4_]);
         if(_loc5_ == undefined)
         {
            return undefined;
         }
         _loc3_ = _loc3_ + _loc5_;
         _loc4_ = _loc4_ + 1;
      }
      return Math.floor(_loc3_ / aFiles.length);
   }
   function onFileLoaded(sFile)
   {
      this.dispatchEvent({type:"onFileLoaded",value:sFile});
   }
   function onLoadError(mc)
   {
      var _loc3_ = this.getFileByMc(mc);
      _loc3_.state = ank.battlefield.LoadManager.STATE_ERROR;
      delete register3.loader;
      this.processLoad();
   }
   function onLoadInit(mc)
   {
      var _loc3_ = this.getFileByMc(mc);
      _loc3_.state = ank.battlefield.LoadManager.STATE_LOADED;
      delete register3.loader;
      this.onFileLoaded(_loc3_.file);
      this.processLoad();
   }
   function onLoadProgress(mc, nBL, nBT)
   {
      var _loc5_ = this.getFileByMc(mc);
      if(!_loc5_)
      {
         return undefined;
      }
      _loc5_.bitLoaded = nBL;
      _loc5_.bitTotal = nBT;
   }
}
