class ank.utils.extensions.MovieClipExtensions extends MovieClip
{
	function MovieClipExtensions()
	{
		super();
	}
	function attachClassMovie(className, instanceName, §\x11\x0b§, §\x1d\x12§)
	{
		var var6 = this.createEmptyMovieClip(instanceName,var4);
		var6.__proto__ = className.prototype;
		className.apply(var6,var5);
		return var6;
	}
	function alignOnPixel()
	{
		var var2 = new Object({x:0,y:0});
		this.localToGlobal(var2);
		var2.x = Math.floor(var2.x);
		var2.y = Math.floor(var2.y);
		this.globalToLocal(var2);
		this._x = this._x - var2.x;
		this._y = this._y - var2.y;
	}
	function playFirstChildren()
	{
		for(var a in this)
		{
			if(this[a].__proto__ == MovieClip.prototype)
			{
				this[a].gotoAndPlay(1);
			}
		}
	}
	function end(§\x1e\x13\x05§)
	{
		var var3 = this.getFirstParentProperty("_ACTION");
		if(var2 == undefined)
		{
			var2 = var3.sequencer;
		}
		var2.onActionEnd();
	}
	function getFirstParentProperty(§\x1e\x16\x11§)
	{
		var var3 = 20;
		var var4 = this;
		while(var3 >= 0)
		{
			if(var4[var2] != undefined)
			{
				return var4[var2];
			}
			var4 = var4._parent;
			var3 = var3 - 1;
		}
	}
	function getActionClip(§\x1e\n\f§)
	{
		return this.getFirstParentProperty("_ACTION");
	}
	function playAll(§\x0b\r§)
	{
		if(var2 == undefined)
		{
			var2 = this;
		}
		var2.gotoAndPlay(1);
		for(var a in var2)
		{
			if(var2[a] instanceof MovieClip)
			{
				this.playAll(var2[a]);
			}
		}
	}
	function stopAll(§\x0b\r§)
	{
		if(var2 == undefined)
		{
			var2 = this;
		}
		var2.gotoAndStop(1);
		for(var a in var2)
		{
			if(var2[a] instanceof MovieClip)
			{
				this.stopAll(var2[a]);
			}
		}
	}
}
