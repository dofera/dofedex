class ank.battlefield.LoadManager extends MovieClip
{
	static var MAX_PARALLELE_LOAD = 3;
	static var STATE_WAITING = 0;
	static var STATE_LOADING = 1;
	static var STATE_LOADED = 2;
	static var STATE_ERROR = -1;
	static var STATE_UNKNOWN = -1;
	function LoadManager(var2)
	{
		super();
		this.initialize(var3);
	}
	function processLoad()
	{
		var var2 = 0;
		while(var2 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
			{
				return undefined;
			}
			if(ank.battlefield.LoadManager._aMovieClipLoader[var2].state == ank.battlefield.LoadManager.STATE_WAITING)
			{
				ank.battlefield.LoadManager._aMovieClipLoader[var2].state = ank.battlefield.LoadManager.STATE_LOADING;
				ank.battlefield.LoadManager._aMovieClipLoader[var2].loader.loadClip(ank.battlefield.LoadManager._aMovieClipLoader[var2].file,ank.battlefield.LoadManager._aMovieClipLoader[var2].container);
			}
			var2 = var2 + 1;
		}
	}
	function getFileByMc(var2)
	{
		var var3 = 0;
		while(var3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(ank.battlefield.LoadManager._aMovieClipLoader[var3].container === var2)
			{
				return ank.battlefield.LoadManager._aMovieClipLoader[var3];
			}
			var3 = var3 + 1;
		}
		return undefined;
	}
	function getFileByName(var2)
	{
		var var3 = 0;
		while(var3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(ank.battlefield.LoadManager._aMovieClipLoader[var3].file == var2)
			{
				return ank.battlefield.LoadManager._aMovieClipLoader[var3];
			}
			var3 = var3 + 1;
		}
		return undefined;
	}
	function initialize(var2)
	{
		mx.events.EventDispatcher.initialize(this);
		ank.battlefield.LoadManager._aMovieClipLoader = new Array();
		this._mcMainContainer = var2;
	}
	function loadFile(var2)
	{
		if(this.isRegister(var2))
		{
			if(this.isLoaded(var2))
			{
				this.onFileLoaded(var2);
			}
			else
			{
				return undefined;
			}
		}
		else
		{
			var var3 = new Object();
			var3.file = var2;
			var3.bitLoaded = 0;
			var3.bitTotal = 1;
			var3.state = ank.battlefield.LoadManager.STATE_WAITING;
			var3.loader = new MovieClipLoader();
			var var4 = this;
			var3.loader.addListener(var4);
			var3.container = this._mcMainContainer.createEmptyMovieClip(var2.split("/").join("_").split(".").join("_"),this._mcMainContainer.getNextHighestDepth());
			ank.battlefield.LoadManager._aMovieClipLoader.push(var3);
			if(this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
			{
				return undefined;
			}
			var3.state = ank.battlefield.LoadManager.STATE_LOADING;
			var3.loader.loadClip(var2,var3.container);
		}
	}
	function loadFiles(var2)
	{
		var var3 = 0;
		while(var3 < var2.length)
		{
			this.loadFile(var2[var3]);
			var3 = var3 + 1;
		}
	}
	function __get__waitingRequest()
	{
		var var2 = 0;
		var var3 = 0;
		while(var3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(ank.battlefield.LoadManager._aMovieClipLoader[var3].state == ank.battlefield.LoadManager.STATE_LOADING)
			{
				var2 = var2 + 1;
			}
			var3 = var3 + 1;
		}
		return var2;
	}
	function isRegister(var2)
	{
		var var3 = 0;
		while(var3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(var2 == ank.battlefield.LoadManager._aMovieClipLoader[var3].file)
			{
				return true;
			}
			var3 = var3 + 1;
		}
		return false;
	}
	function isLoaded(var2)
	{
		if(!this.isRegister(var2))
		{
			return false;
		}
		var var3 = 0;
		while(var3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(var2 == ank.battlefield.LoadManager._aMovieClipLoader[var3].file)
			{
				return ank.battlefield.LoadManager._aMovieClipLoader[var3].state == ank.battlefield.LoadManager.STATE_LOADED;
			}
			var3 = var3 + 1;
		}
	}
	function areRegister(var2)
	{
		true;
		var var3 = var2.length > 0;
		var var4 = 0;
		while(var4 < var2.length && var3)
		{
			var3 = var3 && this.isRegister(var2[var4]);
			var4 = var4 + 1;
		}
		return var3;
	}
	function areLoaded(var2)
	{
		if(!this.areRegister(var2))
		{
			return false;
		}
		true;
		var var3 = var2.length > 0;
		var var4 = 0;
		while(var4 < var2.length && var3)
		{
			var3 = var3 && this.isLoaded(var2[var4]);
			var4 = var4 + 1;
		}
		return var3;
	}
	function getFileState(var2)
	{
		var var3 = this.getFileByName(var2);
		if(var3)
		{
			return var3.state;
		}
		return ank.battlefield.LoadManager.STATE_UNKNOWN;
	}
	function getProgression(var2)
	{
		var var3 = this.getFileByName(var2);
		if(!var3)
		{
			return undefined;
		}
		if(var3.state == ank.battlefield.LoadManager.STATE_LOADED)
		{
			return 100;
		}
		return Math.floor(var3.bitLoaded / var3.bitTotal * 100);
	}
	function getProgressions(var2)
	{
		var var3 = 0;
		var var4 = 0;
		while(var4 < var2.length)
		{
			var var5 = this.getProgression(var2[var4]);
			if(var5 == undefined)
			{
				return undefined;
			}
			var3 = var3 + var5;
			var4 = var4 + 1;
		}
		return Math.floor(var3 / var2.length);
	}
	function onFileLoaded(var2)
	{
		this.dispatchEvent({type:"onFileLoaded",value:var2});
	}
	function onLoadError(var2)
	{
		var var3 = this.getFileByMc(var2);
		var3.state = ank.battlefield.LoadManager.STATE_ERROR;
		delete register3.loader;
		this.processLoad();
	}
	function onLoadInit(var2)
	{
		var var3 = this.getFileByMc(var2);
		var3.state = ank.battlefield.LoadManager.STATE_LOADED;
		delete register3.loader;
		this.onFileLoaded(var3.file);
		this.processLoad();
	}
	function onLoadProgress(var2, var3, var4)
	{
		var var5 = this.getFileByMc(var2);
		if(!var5)
		{
			return undefined;
		}
		var5.bitLoaded = var3;
		var5.bitTotal = var4;
	}
}
