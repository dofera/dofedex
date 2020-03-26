class dofus.utils.Api extends Object
{
   function Api()
   {
      super();
      dofus.utils.Api._oLastInstance = this;
   }
   static function getInstance()
   {
      return dofus.utils.Api._oLastInstance;
   }
   function __get__config()
   {
      return this._oConfig;
   }
   function __get__kernel()
   {
      return this._oKernel;
   }
   function __get__datacenter()
   {
      return this._oDatacenter;
   }
   function __get__network()
   {
      return this._oNetwork;
   }
   function __get__gfx()
   {
      return this._oGfx;
   }
   function __get__ui()
   {
      return this._oUI;
   }
   function __get__sounds()
   {
      return this._oSounds;
   }
   function __get__lang()
   {
      return this._oLang;
   }
   function __get__colors()
   {
      return this._oColors;
   }
   function __get__electron()
   {
      return this._oElectron;
   }
   function initialize()
   {
      this._oConfig = _global.CONFIG;
      this._oLang = new dofus.utils.DofusTranslator();
      this._oUI = dofus.DofusCore.getClip().GAPI;
      this._oUI.api = this;
      this._oKernel = new dofus.Kernel(this);
      this._oElectron = new dofus.Electron(this);
      this._oSounds = dofus.sounds.AudioManager.getInstance();
      _global.SOMA = this._oSounds;
      this._oDatacenter = new dofus.datacenter.Datacenter(this);
      this._oNetwork = new dofus.aks.Aks(this);
      this._oGfx = dofus.DofusCore.getClip().BATTLEFIELD;
      if(this._oConfig.isStreaming && this._oConfig.streamingMethod == "explod")
      {
         this._oGfx.initialize(this._oDatacenter,dofus.Constants.OBJECTS_LIGHT_FILE,dofus.Constants.OBJECTS_LIGHT_FILE,dofus.Constants.ACCESSORIES_PATH,this);
      }
      else
      {
         this._oGfx.initialize(this._oDatacenter,dofus.Constants.GROUND_FILE,dofus.Constants.OBJECTS_FILE,dofus.Constants.ACCESSORIES_PATH,this);
      }
      this._oColors = _global.GAC;
      this._oConfig.languages = this._oLang.getConfigText("LANGUAGES_LIST");
   }
   function checkFileSize(sFile, nCheckID)
   {
      var _loc3_ = new Object();
      var ref = this;
      _loc3_.onLoadComplete = function(mc, httpStatus)
      {
         ref.onFileCheckFinished(true,mc.getBytesTotal(),nCheckID);
         mc.removeMovieClip();
      };
      _loc3_.onLoadError = function(mc, errorCode, httpStatus)
      {
         ref.onFileCheckFinished(false,mc.getBytesLoaded(),nCheckID);
         mc.removeMovieClip();
      };
      var _loc4_ = dofus.DofusCore.getInstance().getTemporaryContainer();
      var _loc5_ = _loc4_.createEmptyMovieClip("FC" + nCheckID,_loc4_.getNextHighestDepth());
      var _loc6_ = new MovieClipLoader();
      _loc6_.addListener(_loc3_);
      _loc6_.loadClip(sFile,_loc5_);
   }
   function onFileCheckFinished(bSuccess, nFileSize, nCheckID)
   {
      this.network.Basics.fileCheckAnswer(nCheckID,!bSuccess?-1:nFileSize);
   }
}
