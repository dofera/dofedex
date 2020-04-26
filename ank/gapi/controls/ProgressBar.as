class ank.gapi.controls.ProgressBar extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ProgressBar";
	var _sRenderer = "ProgressBarDefaultRenderer";
	var _nValue = 0;
	var _nMinimum = 0;
	var _nMaximum = 100;
	function ProgressBar()
	{
		super();
	}
	function __set__renderer(loc2)
	{
		if(this._bInitialized)
		{
			return undefined;
		}
		this._sRenderer = loc2;
		return this.__get__renderer();
	}
	function __set__minimum(loc2)
	{
		this._nMinimum = Number(loc2);
		return this.__get__minimum();
	}
	function __get__minimum()
	{
		return this._nMinimum;
	}
	function __set__maximum(loc2)
	{
		this._nMaximum = Number(loc2);
		return this.__get__maximum();
	}
	function __get__maximum()
	{
		return this._nMaximum;
	}
	function __set__value(loc2)
	{
		if(loc2 > this._nMaximum)
		{
			loc2 = this._nMaximum;
		}
		if(loc2 < this._nMinimum)
		{
			loc2 = this._nMinimum;
		}
		this._nValue = Number(loc2);
		this.addToQueue({object:this,method:this.applyValue});
		return this.__get__value();
	}
	function __get__value()
	{
		return this._nValue;
	}
	function init()
	{
		super.init(false,ank.gapi.controls.ProgressBar.CLASS_NAME);
	}
	function createChildren()
	{
		this.attachMovie(this._sRenderer,"_mcRenderer",10);
		this.hideUp(true);
	}
	function size()
	{
		super.size();
	}
	function arrange()
	{
		this._mcRenderer._mcBgLeft._height = this._mcRenderer._mcBgMiddle._height = this._mcRenderer._mcBgRight._height = this.__height;
		var loc2 = this._mcRenderer._mcBgLeft._yscale;
		this._mcRenderer._mcBgLeft._xscale = this._mcRenderer._mcUpLeft._xscale = this._mcRenderer._mcUpLeft._yscale = loc2;
		this._mcRenderer._mcBgRight._xscale = this._mcRenderer._mcUpRight._xscale = this._mcRenderer._mcUpRight._yscale = loc2;
		this._mcRenderer._mcUpMiddle._yscale = loc2;
		var loc3 = this._mcRenderer._mcBgLeft._width;
		var loc4 = this._mcRenderer._mcBgLeft._width;
		this._mcRenderer._mcBgLeft._x = this._mcRenderer._mcBgLeft._y = this._mcRenderer._mcBgMiddle._y = this._mcRenderer._mcBgRight._y = 0;
		this._mcRenderer._mcUpLeft._x = this._mcRenderer._mcUpLeft._y = this._mcRenderer._mcUpMiddle._y = this._mcRenderer._mcUpRight._y = 0;
		this._mcRenderer._mcBgMiddle._x = this._mcRenderer._mcUpMiddle._x = loc3;
		this._mcRenderer._mcBgRight._x = this.__width - loc4;
		this._mcRenderer._mcBgMiddle._width = this.__width - loc3 - loc4;
	}
	function draw()
	{
		var loc3 = this.getStyle();
		var loc2 = this._mcRenderer._mcBgLeft;
		for(var k in loc2)
		{
			var loc4 = k.split("_")[0];
			this.setMovieClipColor(loc2[k],loc3[loc4 + "color"]);
		}
		loc2 = this._mcRenderer._mcBgMiddle;
		for(var k in loc2)
		{
			var loc5 = k.split("_")[0];
			this.setMovieClipColor(loc2[k],loc3[loc5 + "color"]);
		}
		loc2 = this._mcRenderer._mcBgRight;
		for(var k in loc2)
		{
			var loc6 = k.split("_")[0];
			this.setMovieClipColor(loc2[k],loc3[loc6 + "color"]);
		}
		loc2 = this._mcRenderer._mcUpLeft;
		for(var k in loc2)
		{
			var loc7 = k.split("_")[0];
			this.setMovieClipColor(loc2[k],loc3[loc7 + "color"]);
		}
		loc2 = this._mcRenderer._mcUpMiddle;
		for(var k in loc2)
		{
			var loc8 = k.split("_")[0];
			this.setMovieClipColor(loc2[k],loc3[loc8 + "color"]);
		}
		loc2 = this._mcRenderer._mcUpRight;
		for(var k in loc2)
		{
			var loc9 = k.split("_")[0];
			this.setMovieClipColor(loc2[k],loc3[loc9 + "color"]);
		}
	}
	function hideUp(loc2)
	{
		this._mcRenderer._mcUpLeft._visible = !loc2;
		this._mcRenderer._mcUpMiddle._visible = !loc2;
		this._mcRenderer._mcUpRight._visible = !loc2;
	}
	function applyValue()
	{
		var loc2 = this._mcRenderer._mcBgLeft._width;
		var loc3 = this._mcRenderer._mcBgLeft._width;
		var loc4 = this._nValue - this._nMinimum;
		if(loc4 == 0)
		{
			this.hideUp(true);
		}
		else
		{
			this.hideUp(false);
			var loc5 = this._nMaximum - this._nMinimum;
			var loc6 = this.__width - loc2 - loc3;
			var loc7 = Math.floor(loc4 / loc5 * loc6);
			this._mcRenderer._mcUpMiddle._width = loc7;
			this._mcRenderer._mcUpRight._x = loc7 + loc2;
		}
	}
	function setEnabled()
	{
		if(this._bEnabled)
		{
			this.onRollOver = function()
			{
				this.dispatchEvent({type:"over"});
			};
			this.onRollOut = function()
			{
				this.dispatchEvent({type:"out"});
			};
		}
		else
		{
			this.onRollOver = undefined;
			this.onRollOut = undefined;
		}
	}
}
