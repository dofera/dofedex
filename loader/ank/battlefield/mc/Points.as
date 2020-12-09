class ank.battlefield.mc.Points extends MovieClip
{
	var _bFinished = false;
	function Points(pointsHandler, §\x05\x02§, §\x1e\x1e\x19§, §\x1e\f\t§, §\x07\x0e§)
	{
		super();
		this.initialize(pointsHandler,var4,var5,var6,var7);
	}
	function initialize(pointsHandler, §\x05\x02§, §\x1e\x1e\x19§, §\x1e\f\t§, §\x07\x0e§)
	{
		this._pointsHandler = pointsHandler;
		this._nRefY = var4;
		this._nID = var3;
		this.createTextField("_tf",10,0,0,150,100);
		this._tf.autoSize = "left";
		this._tf.embedFonts = true;
		this._tf.selectable = false;
		this._tf.textColor = var6;
		this._tf.text = var5;
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
		this._nY = var4;
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
				var var2 = this._nRefY - this._nY;
				if(var2 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
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
				var var3 = this._nRefY - this._nY;
				if(var3 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
				{
					this.remove();
				}
				if(!this._bFinished)
				{
					if(var3 > ank.battlefield.Constants.SPRITE_POINTS_OFFSET - 2)
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
