class ank.utils.extensions.MovieClipExtensions extends MovieClip
{
	function MovieClipExtensions()
	{
		super();
	}
	function attachClassMovie(className, instanceName, §\x12\x02§, §\x1d\x12§)
	{
		var loc6 = this.createEmptyMovieClip(instanceName,loc4);
		loc6.__proto__ = className.prototype;
		className.apply(loc6,loc5);
		return loc6;
	}
	function alignOnPixel()
	{
		var loc2 = new Object({x:0,y:0});
		this.localToGlobal(loc2);
		loc2.x = Math.floor(loc2.x);
		loc2.y = Math.floor(loc2.y);
		this.globalToLocal(loc2);
		this._x = this._x - loc2.x;
		this._y = this._y - loc2.y;
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
	function end(loc2)
	{
		var loc3 = this.getFirstParentProperty("_ACTION");
		if(loc2 == undefined)
		{
			loc2 = loc3.sequencer;
		}
		loc2.onActionEnd();
	}
	function getFirstParentProperty(loc2)
	{
		var loc3 = 20;
		var loc4 = this;
		while(loc3 >= 0)
		{
			if(loc4[loc2] != undefined)
			{
				return loc4[loc2];
			}
			loc4 = loc4._parent;
			loc3 = loc3 - 1;
		}
	}
	function getActionClip(loc2)
	{
		return this.getFirstParentProperty("_ACTION");
	}
	function playAll(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = this;
		}
		loc2.gotoAndPlay(1);
		for(var a in loc2)
		{
			if(loc2[a] instanceof MovieClip)
			{
				this.playAll(loc2[a]);
			}
		}
	}
	function stopAll(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = this;
		}
		loc2.gotoAndStop(1);
		for(var a in loc2)
		{
			if(loc2[a] instanceof MovieClip)
			{
				this.stopAll(loc2[a]);
			}
		}
	}
}
