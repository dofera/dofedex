class ank.utils.SWFLoader extends MovieClip
{
	function SWFLoader()
	{
		super();
		AsBroadcaster.initialize(this);
		this.initialize(0);
	}
	function initialize(loc2, loc3)
	{
		this.clear();
		this._frameStart = loc2;
		this._aArgs = loc3;
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
	function loadSWF(loc2, loc3, loc4)
	{
		this.initialize(loc3,loc4);
		var loc5 = new MovieClipLoader();
		loc5.addListener(this);
		loc5.loadClip(loc2,this.swf_mc);
	}
	function onLoadComplete(loc2)
	{
		this.broadcastMessage("onLoadComplete",loc2,this._aArgs);
	}
	function onLoadInit(loc2)
	{
		if(this._frameStart != undefined)
		{
			loc2.gotoAndStop(this._frameStart);
		}
		this.broadcastMessage("onLoadInit",loc2,this._aArgs);
	}
}
