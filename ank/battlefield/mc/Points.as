class ank.battlefield.mc.Points extends MovieClip
{
	var _bFinished = false;
	function Points(pointsHandler, §\x06\x02§, §\x01\x1d§, §\x1e\x0e\x04§, §\b\t§)
	{
		super();
		this.initialize(pointsHandler,loc4,loc5,loc6,loc7);
	}
	function initialize(pointsHandler, §\x06\x02§, §\x01\x1d§, §\x1e\x0e\x04§, §\b\t§)
	{
		this._pointsHandler = pointsHandler;
		this._nRefY = loc4;
		this._nID = loc3;
		this.createTextField("_tf",10,0,0,150,100);
		this._tf.autoSize = "left";
		this._tf.embedFonts = true;
		this._tf.selectable = false;
		this._tf.textColor = loc6;
		this._tf.text = loc5;
		this._tf.setTextFormat(ank.battlefield.Constants.SPRITE_POINTS_TEXTFORMAT);
		this._tf._x = - this._tf.textWidth / 2;
		this._tf._y = - this._tf.textHeight / 2;
		this._visible = false;
		this._nI = 0;
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			this._nSz = 200;
			this._nVy = -20;
			this._nOpacity = 100;
		}
		else
		{
			this._nSz = 100;
			this._nVy = -20;
		}
		this._nY = loc4;
	}
	function animate()
	{
		this._visible = true;
		this._nCurrentFrame = 0;
		this.onEnterFrame = function()
		{
			this._nCurrentFrame++;
			if(dofus.Constants.DOUBLEFRAMERATE)
			{
				this._xscale = this._nT;
				this._yscale = this._nT;
				this._alpha = this._nOpacity;
				this._nT = 100 + this._nSz * Math.sin(this._nI = this._nI + 0.25);
				this._nSz = this._nSz * 0.95;
				this._nY = this._nY + (this._nVy = this._nVy * 0.7);
				this._y = this._nY;
				var loc2 = this._nRefY - this._nY;
				if(loc2 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
				{
					this._nOpacity = this._nOpacity - 0;
				}
				if(this._nSz <= 0 || this._nCurrentFrame > 15)
				{
					this._bFinished = true;
					this._pointsHandler.onAnimateFinished(this._nID);
					this.removeMovieClip();
					delete this.onEnterFrame;
				}
			}
			else
			{
				this._xscale = this._nT;
				this._yscale = this._nT;
				this._nT = 100 + this._nSz * Math.sin(this._nI = this._nI + 1.2);
				this._nSz = this._nSz * 0.85;
				this._nY = this._nY + (this._nVy = this._nVy * 0.7);
				this._y = this._nY;
				var loc3 = this._nRefY - this._nY;
				if(loc3 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
				{
					this.remove();
				}
				if(!this._bFinished)
				{
					if(loc3 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET - 2)
					{
						this._bFinished = true;
						this._pointsHandler.onAnimateFinished(this._nID);
					}
				}
			}
		};
	}
	function remove()
	{
		delete this.onEnterFrame;
		this.removeMovieClip();
	}
}
