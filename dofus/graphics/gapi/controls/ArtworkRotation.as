class dofus.graphics.gapi.controls.ArtworkRotation extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ArtworkRotationItem";
	function ArtworkRotation()
	{
		super();
	}
	function __set__classID(loc2)
	{
		this._ariMan.loadArtwork(loc2);
		this._ariWoman.loadArtwork(loc2);
		return this.__get__classID();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ArtworkRotation.CLASS_NAME);
	}
	function createChildren()
	{
		this._i = 2.02;
	}
	function setPosition(loc2)
	{
		if(this._nCurrentSex == loc2)
		{
			return undefined;
		}
		this._nCurrentSex = loc2;
		var loc3 = loc2 == 0;
		this._ariWoman.colorize(loc3);
		this._ariMan.colorize(!loc3);
		if(!loc3)
		{
			this._ariMan.swapDepths(this._ariWoman);
		}
		this._i = !loc3?5.13:2;
		var loc4 = -30.4 * (!loc3?1:-1);
		var loc5 = 28.7 * (!loc3?1:-1);
		var loc6 = -45.6 * (!loc3?1:-1);
		this._ariMan._x = loc5;
		this._ariMan._y = loc6;
		this._ariWoman._x = - loc5;
		this._ariWoman._y = - loc6;
		this._ariMan._xscale = 100 + loc4;
		this._ariMan._yscale = 100 + loc4;
		this._ariWoman._xscale = 100 - loc4;
		this._ariWoman._yscale = 100 - loc4;
	}
	function rotate(loc2)
	{
		if(this._nCurrentSex == loc2)
		{
			return undefined;
		}
		this._nCurrentSex = loc2;
		var piy = 0;
		var px = 0;
		var py = 0;
		var t = 0;
		var bSwaped = false;
		var loc3 = loc2 == 0;
		this._ariWoman.colorize(loc3);
		this._ariMan.colorize(!loc3);
		this._di = !loc3?2 + Math.PI:2;
		this.onEnterFrame = function()
		{
			if(Math.abs(this._i - this._di) > 0.01)
			{
				this._i = this._i - (this._i - this._di) / 3;
				piy = py;
				px = 70 * Math.cos(this._i);
				py = 50 * Math.sin(this._i);
				if(piy < 0 && py >= 0 || piy >= 0 && py < 0)
				{
					if(!bSwaped)
					{
						this._ariMan.swapDepths(this._ariWoman);
						bSwaped = true;
					}
				}
				t = py / 1.5;
				this._ariMan._x = px;
				this._ariMan._y = py;
				this._ariWoman._x = - px;
				this._ariWoman._y = - py;
				this._ariMan._xscale = 100 + t;
				this._ariMan._yscale = 100 + t;
				this._ariWoman._xscale = 100 - t;
				this._ariWoman._yscale = 100 - t;
			}
			else
			{
				delete this.onEnterFrame;
			}
		};
	}
}
