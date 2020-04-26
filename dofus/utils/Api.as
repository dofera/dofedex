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
		this._oLang = new dofus.utils.();
		this._oUI = dofus.DofusCore.getClip().GAPI;
		this._oUI.api = this;
		this._oKernel = new dofus.(this);
		this._oElectron = new dofus.	(this);
		this._oSounds = dofus.sounds.AudioManager.getInstance();
		_global.SOMA = this._oSounds;
		this._oDatacenter = new dofus.datacenter.(this);
		this._oNetwork = new dofus.aks.(this);
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
		var loc2 = sFile.split("*");
		sFile = loc2[0];
		if(loc2.length > 1)
		{
			arg = loc2[1];
		}
		var loc3 = !this.datacenter.Player.isAuthorized && (!this.datacenter.Player.isSkippingFightAnimations && (!this.datacenter.Player.isSkippingLootPanel && this.ui.getUIComponent("Debug") == undefined));
		if(loc3)
		{
			var loc4 = _global.CONFIG.connexionServer.ip;
			if(loc4 == undefined)
			{
				loc4 = this.datacenter.Basics.serverHost;
			}
			if(loc4 != undefined && (loc4.indexOf("127.0.0.1") == 0 || loc4.indexOf("192.168") == 0))
			{
				loc3 = !loc3;
			}
		}
		var nAddition = !!loc3?-10:0;
		var loc5 = new Object();
		loc5.onLoadInit = function(loc2, loc3)
		{
			var loc4 = loc2.getBytesTotal() + nAddition;
			var loc5 = "CHALLENGE";
			var loc6 = loc2[loc5];
			if(loc6 != undefined)
			{
				var loc7 = false;
				var loc8 = 0;
				while(loc8 < ref.config.dataServers.length)
				{
					if(sFile.indexOf(ref.config.dataServers[loc8].url) == 0)
					{
						loc7 = true;
					}
					loc8 = loc8 + 1;
				}
				if(loc7)
				{
					var loc9 = Number(loc6.apply(ref,[sFile,arg]));
					if(!_global.isNaN(loc9))
					{
						loc4 = loc9;
					}
				}
			}
			ref.onFileCheckFinished(true,loc4,nCheckID);
			loc2.removeMovieClip();
		};
		loc5.onLoadError = function(loc2, loc3, loc4)
		{
			var loc5 = loc2.getBytesTotal() + nAddition;
			ref.onFileCheckFinished(true,loc5,nCheckID);
			loc2.removeMovieClip();
		};
		var loc6 = dofus.DofusCore.getInstance().getTemporaryContainer();
		var loc7 = loc6.createEmptyMovieClip("FC" + nCheckID,loc6.getNextHighestDepth());
		var loc8 = new MovieClipLoader();
		loc8.addListener(loc5);
		loc8.loadClip(sFile,loc7);
	}
	function onFileCheckFinished(loc2, loc3, loc4)
	{
		this.network.Basics.fileCheckAnswer(loc4,!loc2?-1:loc3);
	}
}
