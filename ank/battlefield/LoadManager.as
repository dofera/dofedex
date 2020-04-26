class ank.battlefield.LoadManager extends MovieClip
{
	static var MAX_PARALLELE_LOAD = 3;
	static var STATE_WAITING = 0;
	static var STATE_LOADING = 1;
	static var STATE_LOADED = 2;
	static var STATE_ERROR = -1;
	static var STATE_UNKNOWN = -1;
	function LoadManager(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function processLoad()
	{
		var loc2 = 0;
		while(loc2 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
			{
				return undefined;
			}
			if(ank.battlefield.LoadManager._aMovieClipLoader[loc2].state == ank.battlefield.LoadManager.STATE_WAITING)
			{
				ank.battlefield.LoadManager._aMovieClipLoader[loc2].state = ank.battlefield.LoadManager.STATE_LOADING;
				ank.battlefield.LoadManager._aMovieClipLoader[loc2].loader.loadClip(ank.battlefield.LoadManager._aMovieClipLoader[loc2].file,ank.battlefield.LoadManager._aMovieClipLoader[loc2].container);
			}
			loc2 = loc2 + 1;
		}
	}
	function getFileByMc(loc2)
	{
		var loc3 = 0;
		while(loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(ank.battlefield.LoadManager._aMovieClipLoader[loc3].container === loc2)
			{
				return ank.battlefield.LoadManager._aMovieClipLoader[loc3];
			}
			loc3 = loc3 + 1;
		}
		return undefined;
	}
	function getFileByName(loc2)
	{
		var loc3 = 0;
		while(loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(ank.battlefield.LoadManager._aMovieClipLoader[loc3].file == loc2)
			{
				return ank.battlefield.LoadManager._aMovieClipLoader[loc3];
			}
			loc3 = loc3 + 1;
		}
		return undefined;
	}
	function initialize(loc2)
	{
		eval("\n\x0b").events.EventDispatcher.initialize(this);
		ank.battlefield.LoadManager._aMovieClipLoader = new Array();
		this._mcMainContainer = loc2;
	}
	function loadFile(loc2)
	{
		if(this.isRegister(loc2))
		{
			if(this.isLoaded(loc2))
			{
				this.onFileLoaded(loc2);
			}
			else
			{
				return undefined;
			}
		}
		else
		{
			var loc3 = new Object();
			loc3.file = loc2;
			loc3.bitLoaded = 0;
			loc3.bitTotal = 1;
			loc3.state = ank.battlefield.LoadManager.STATE_WAITING;
			loc3.loader = new MovieClipLoader();
			var loc4 = this;
			loc3.loader.addListener(loc4);
			loc3.container = this._mcMainContainer.createEmptyMovieClip(loc2.split("/").join("_").split(".").join("_"),this._mcMainContainer.getNextHighestDepth());
			ank.battlefield.LoadManager._aMovieClipLoader.push(loc3);
			if(this.waitingRequest > ank.battlefield.LoadManager.MAX_PARALLELE_LOAD)
			{
				return undefined;
			}
			loc3.state = ank.battlefield.LoadManager.STATE_LOADING;
			loc3.loader.loadClip(loc2,loc3.container);
		}
	}
	function loadFiles(loc2)
	{
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			this.loadFile(loc2[loc3]);
			loc3 = loc3 + 1;
		}
	}
	function __get__waitingRequest()
	{
		var loc2 = 0;
		var loc3 = 0;
		while(loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(ank.battlefield.LoadManager._aMovieClipLoader[loc3].state == ank.battlefield.LoadManager.STATE_LOADING)
			{
				loc2 = loc2 + 1;
			}
			loc3 = loc3 + 1;
		}
		return loc2;
	}
	function isRegister(loc2)
	{
		var loc3 = 0;
		while(loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(loc2 == ank.battlefield.LoadManager._aMovieClipLoader[loc3].file)
			{
				return true;
			}
			loc3 = loc3 + 1;
		}
		return false;
	}
	function isLoaded(loc2)
	{
		if(!this.isRegister(loc2))
		{
			return false;
		}
		var loc3 = 0;
		while(loc3 < ank.battlefield.LoadManager._aMovieClipLoader.length)
		{
			if(loc2 == ank.battlefield.LoadManager._aMovieClipLoader[loc3].file)
			{
				return ank.battlefield.LoadManager._aMovieClipLoader[loc3].state == ank.battlefield.LoadManager.STATE_LOADED;
			}
			loc3 = loc3 + 1;
		}
	}
	function areRegister(loc2)
	{
		true;
		var loc3 = loc2.length > 0;
		var loc4 = 0;
		while(loc4 < loc2.length && loc3)
		{
			loc3 = loc3 && this.isRegister(loc2[loc4]);
			loc4 = loc4 + 1;
		}
		return loc3;
	}
	function areLoaded(loc2)
	{
		if(!this.areRegister(loc2))
		{
			return false;
		}
		true;
		var loc3 = loc2.length > 0;
		var loc4 = 0;
		while(loc4 < loc2.length && loc3)
		{
			loc3 = loc3 && this.isLoaded(loc2[loc4]);
			loc4 = loc4 + 1;
		}
		return loc3;
	}
	function getFileState(loc2)
	{
		var loc3 = this.getFileByName(loc2);
		if(loc3)
		{
			return loc3.state;
		}
		return ank.battlefield.LoadManager.STATE_UNKNOWN;
	}
	function getProgression(loc2)
	{
		var loc3 = this.getFileByName(loc2);
		if(!loc3)
		{
			return undefined;
		}
		if(loc3.state == ank.battlefield.LoadManager.STATE_LOADED)
		{
			return 100;
		}
		return Math.floor(loc3.bitLoaded / loc3.bitTotal * 100);
	}
	function getProgressions(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			var loc5 = this.getProgression(loc2[loc4]);
			if(loc5 == undefined)
			{
				return undefined;
			}
			loc3 = loc3 + loc5;
			loc4 = loc4 + 1;
		}
		return Math.floor(loc3 / loc2.length);
	}
	function onFileLoaded(loc2)
	{
		this.dispatchEvent({type:"onFileLoaded",value:loc2});
	}
	function onLoadError(loc2)
	{
		var loc3 = this.getFileByMc(loc2);
		loc3.state = ank.battlefield.LoadManager.STATE_ERROR;
		delete register3.loader;
		this.processLoad();
	}
	function onLoadInit(loc2)
	{
		var loc3 = this.getFileByMc(loc2);
		loc3.state = ank.battlefield.LoadManager.STATE_LOADED;
		delete register3.loader;
		this.onFileLoaded(loc3.file);
		this.processLoad();
	}
	function onLoadProgress(loc2, loc3, loc4)
	{
		var loc5 = this.getFileByMc(loc2);
		if(!loc5)
		{
			return undefined;
		}
		loc5.bitLoaded = loc3;
		loc5.bitTotal = loc4;
	}
}
