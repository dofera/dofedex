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
		this._oLang = new dofus.utils.();
		this._oUI = dofus.DofusCore.getClip().GAPI;
		this._oUI.api = this;
		org.flashdevelop.utils.FlashConnect.mtrace("[wtf]" + this._oUI.api,"dofus.utils.Api::initialize","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/utils/Api.as",136);
		this._oElectron = new dofus.(this);
		this._oKernel = new dofus.Kernel(this);
		this._oSounds = dofus.sounds.AudioManager.getInstance();
		_global.SOMA = this._oSounds;
		this._oDatacenter = new dofus.datacenter.(this);
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
		_root.menu = new ank.gapi.controls.(this);
		this.ui.loadUIComponent("Zoom","Zoom");
	}
	function checkFileSize(sFile, nCheckID)
	{
		var var2 = sFile.split("*");
		sFile = var2[0];
		if(var2.length > 1)
		{
			arg = var2[1];
		}
		var var3 = !this.datacenter.Player.isAuthorized && (!this.datacenter.Player.isSkippingFightAnimations && (!this.datacenter.Player.isSkippingLootPanel && this.ui.getUIComponent("Debug") == undefined));
		if(var3)
		{
			var var4 = _global.CONFIG.connexionServer.ip;
			if(var4 == undefined)
			{
				var4 = this.datacenter.Basics.serverHost;
			}
			if(var4 != undefined && (var4.indexOf("127.0.0.1") == 0 || var4.indexOf("192.168") == 0))
			{
				var3 = !var3;
			}
		}
		var nAddition = !!var3?-10:0;
		var var5 = new Object();
		var5.onLoadInit = function(§\x0b\r§, §\r\f§)
		{
			var var4 = var2.getBytesTotal() + nAddition;
			var var5 = "CHALLENGE";
			var var6 = var2[var5];
			if(var6 != undefined)
			{
				var var7 = false;
				var var8 = 0;
				while(var8 < ref.config.dataServers.length)
				{
					if(sFile.indexOf(ref.config.dataServers[var8].url) == 0)
					{
						var7 = true;
					}
					var8 = var8 + 1;
				}
				if(var7)
				{
					var var9 = Number(var6.apply(ref,[sFile,arg]));
					if(!_global.isNaN(var9))
					{
						var4 = var9;
					}
				}
			}
			ref.onFileCheckFinished(true,var4,nCheckID);
			var2.removeMovieClip();
		};
		var5.onLoadError = function(§\x0b\r§, §\x0f\x0f§, §\r\f§)
		{
			var var5 = var2.getBytesTotal() + nAddition;
			ref.onFileCheckFinished(true,var5,nCheckID);
			var2.removeMovieClip();
		};
		var var6 = dofus.DofusCore.getInstance().getTemporaryContainer();
		var var7 = var6.createEmptyMovieClip("FC" + nCheckID,var6.getNextHighestDepth());
		var var8 = new MovieClipLoader();
		var8.addListener(var5);
		var8.loadClip(sFile,var7);
	}
	function onFileCheckFinished(§\x14\x1b§, §\x05\x11§, §\x07\x12§)
	{
		this.network.Basics.fileCheckAnswer(var4,!var2?-1:var3);
	}
}
