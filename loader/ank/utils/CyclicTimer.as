class ank.utils.CyclicTimer extends Object
{
	static var _instance = new ank.utils.();
	var _aFunctions = new Array();
	var _bPlaying = false;
	function CyclicTimer()
	{
		super();
	}
	static function getInstance()
	{
		return ank.utils.CyclicTimer._instance;
	}
	function addFunction(§\x1e\x18\x0e§, §\x1e\x18\x19§, §\x0e\x1a§, §\x1e\x02§, §\x1e\x18\x18§, §\x0e\x19§, §\x1e\x01§)
	{
		var var9 = new Object();
		var9.objRef = var2;
		var9.objFn = var3;
		var9.fn = var4;
		var9.params = var5;
		var9.objFnEnd = var6;
		var9.fnEnd = var7;
		var9.paramsEnd = var8;
		this._aFunctions.push(var9);
		this.play();
	}
	function removeFunction(§\x1e\x18\x0e§)
	{
		var var3 = this._aFunctions.length - 1;
		while(var3 >= 0)
		{
			var var4 = this._aFunctions[var3];
			if(var2 == var4.objRef)
			{
				this._aFunctions.splice(var3,1);
			}
			var3 = var3 - 1;
		}
	}
	function clear()
	{
		this.stop();
		this._aFunctions = new Array();
	}
	function play()
	{
		if(this._bPlaying)
		{
			return undefined;
		}
		this._bPlaying = true;
		if(this._mcCyclicGameLoop == undefined)
		{
			this._mcCyclicGameLoop = _root.createEmptyMovieClip("_mcCyclicGameLoop",_root.getNextHighestDepth());
		}
		if(this._mcCyclicGameLoop.onEnterFrame == undefined)
		{
			var thisObject = this;
			var api = _global.API;
			var FRAMES_TO_SKIP = !dofus.Constants.DOUBLEFRAMERATE?1:3;
			var nCurrentFrameSkipState = 0;
			this._mcCyclicGameLoop.onEnterFrame = function()
			{
				if(!api.electron.isWindowFocused)
				{
					if(nCurrentFrameSkipState > 0)
					{
						nCurrentFrameSkipState--;
						return undefined;
					}
					nCurrentFrameSkipState = FRAMES_TO_SKIP;
				}
				thisObject.doCycle();
			};
		}
	}
	function stop()
	{
		delete this._mcCyclicGameLoop.onEnterFrame;
		this._bPlaying = false;
	}
	function doCycle()
	{
		var var2 = this._aFunctions.length - 1;
		while(var2 >= 0)
		{
			var var3 = this._aFunctions[var2];
			if(!var3.fn.apply(var3.objFn,var3.params))
			{
				this.onFunctionEnd(var2,var3);
			}
			var2 = var2 - 1;
		}
		if(this._aFunctions.length == 0)
		{
			this.stop();
		}
	}
	function onFunctionEnd(§\x04\x17§, §\x1e\x19\x12§)
	{
		var3.fnEnd.apply(var3.objFnEnd,var3.paramsEnd);
		this._aFunctions.splice(var2,1);
	}
}
