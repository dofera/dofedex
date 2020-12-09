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
	function __set__renderer(§\x1e\x0e\x12§)
	{
		if(this._bInitialized)
		{
			return undefined;
		}
		this._sRenderer = var2;
		return this.__get__renderer();
	}
	function __set__minimum(§\x03\x01§)
	{
		this._nMinimum = Number(var2);
		return this.__get__minimum();
	}
	function __get__minimum()
	{
		return this._nMinimum;
	}
	function __set__maximum(§\x03\x10§)
	{
		this._nMaximum = Number(var2);
		return this.__get__maximum();
	}
	function __get__maximum()
	{
		return this._nMaximum;
	}
	function __set__value(§\x1e\x1b\x17§)
	{
		if(var2 > this._nMaximum)
		{
			var2 = this._nMaximum;
		}
		if(var2 < this._nMinimum)
		{
			var2 = this._nMinimum;
		}
		this._nValue = Number(var2);
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
		var var2 = this._mcRenderer._mcBgLeft._yscale;
		this._mcRenderer._mcBgLeft._xscale = this._mcRenderer._mcUpLeft._xscale = this._mcRenderer._mcUpLeft._yscale = var2;
		this._mcRenderer._mcBgRight._xscale = this._mcRenderer._mcUpRight._xscale = this._mcRenderer._mcUpRight._yscale = var2;
		this._mcRenderer._mcUpMiddle._yscale = var2;
		var var3 = this._mcRenderer._mcBgLeft._width;
		var var4 = this._mcRenderer._mcBgLeft._width;
		this._mcRenderer._mcBgLeft._x = this._mcRenderer._mcBgLeft._y = this._mcRenderer._mcBgMiddle._y = this._mcRenderer._mcBgRight._y = 0;
		this._mcRenderer._mcUpLeft._x = this._mcRenderer._mcUpLeft._y = this._mcRenderer._mcUpMiddle._y = this._mcRenderer._mcUpRight._y = 0;
		this._mcRenderer._mcBgMiddle._x = this._mcRenderer._mcUpMiddle._x = var3;
		this._mcRenderer._mcBgRight._x = this.__width - var4;
		this._mcRenderer._mcBgMiddle._width = this.__width - var3 - var4;
	}
	function draw()
	{
		var var3 = this.getStyle();
		var var2 = this._mcRenderer._mcBgLeft;
		for(var k in var2)
		{
			var var4 = k.split("_")[0];
			this.setMovieClipColor(var2[k],var3[var4 + "color"]);
		}
		var2 = this._mcRenderer._mcBgMiddle;
		for(var k in var2)
		{
			var var5 = k.split("_")[0];
			this.setMovieClipColor(var2[k],var3[var5 + "color"]);
		}
		var2 = this._mcRenderer._mcBgRight;
		for(var k in var2)
		{
			var var6 = k.split("_")[0];
			this.setMovieClipColor(var2[k],var3[var6 + "color"]);
		}
		var2 = this._mcRenderer._mcUpLeft;
		for(var k in var2)
		{
			var var7 = k.split("_")[0];
			this.setMovieClipColor(var2[k],var3[var7 + "color"]);
		}
		var2 = this._mcRenderer._mcUpMiddle;
		for(var k in var2)
		{
			var var8 = k.split("_")[0];
			this.setMovieClipColor(var2[k],var3[var8 + "color"]);
		}
		var2 = this._mcRenderer._mcUpRight;
		for(var k in var2)
		{
			var var9 = k.split("_")[0];
			this.setMovieClipColor(var2[k],var3[var9 + "color"]);
		}
	}
	function hideUp(§\x19\x0e§)
	{
		this._mcRenderer._mcUpLeft._visible = !var2;
		this._mcRenderer._mcUpMiddle._visible = !var2;
		this._mcRenderer._mcUpRight._visible = !var2;
	}
	function applyValue()
	{
		var var2 = this._mcRenderer._mcBgLeft._width;
		var var3 = this._mcRenderer._mcBgLeft._width;
		var var4 = this._nValue - this._nMinimum;
		if(var4 == 0)
		{
			this.hideUp(true);
		}
		else
		{
			this.hideUp(false);
			var var5 = this._nMaximum - this._nMinimum;
			var var6 = this.__width - var2 - var3;
			var var7 = Math.floor(var4 / var5 * var6);
			this._mcRenderer._mcUpMiddle._width = var7;
			this._mcRenderer._mcUpRight._x = var7 + var2;
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
