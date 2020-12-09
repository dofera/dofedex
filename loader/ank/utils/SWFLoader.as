class ank.utils.SWFLoader extends MovieClip
{
	function SWFLoader()
	{
		super();
		AsBroadcaster.initialize(this);
		this.initialize(0);
	}
	function initialize(§\x0e\x0b§, §\x1d\x13§)
	{
		this.clear();
		this._frameStart = var2;
		this._aArgs = var3;
	}
	function clear()
	{
		this.createEmptyMovieClip("swf_mc",10);
	}
	function remove()
	{
		this.swf_mc.__proto__ = MovieClip.prototype;
		this.swf_mc.removeMovieClip();
	}
	function loadSWF(§\x0e\x12§, §\x0e\x0b§, §\x1d\x13§)
	{
		this.initialize(var3,var4);
		var var5 = new MovieClipLoader();
		var5.addListener(this);
		var5.loadClip(var2,this.swf_mc);
	}
	function onLoadComplete(§\x0b\r§)
	{
		this.broadcastMessage("onLoadComplete",var2,this._aArgs);
	}
	function onLoadInit(§\x0b\r§)
	{
		if(this._frameStart != undefined)
		{
			var2.gotoAndStop(this._frameStart);
		}
		this.broadcastMessage("onLoadInit",var2,this._aArgs);
	}
}
