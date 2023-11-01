class ank.battlefield.mc.Bubble extends MovieClip
{
	function Bubble(var3, var4, var5, var6)
	{
		super();
		this.initialize(var3,var4,var5,var6);
	}
	function initialize(var2, var3, var4, var5)
	{
		this._maxW = var5;
		this.createTextField("_txtf",20,0,0,150,100);
		this._txtf.autoSize = "left";
		this._txtf.wordWrap = true;
		this._txtf.embedFonts = true;
		this._txtf.multiline = true;
		this._txtf.selectable = false;
		this._txtf.html = true;
		this.draw(var2,var3,var4);
	}
	function draw(var2, var3, var4)
	{
		this._txtf.htmlText = var2;
		this._txtf.setTextFormat(ank.battlefield.Constants.BUBBLE_TXTFORMAT);
		var var5 = this._txtf.textHeight > 10?this._txtf.textHeight:11;
		var var6 = this._txtf.textWidth > 10?this._txtf.textWidth + 4:11;
		this.drawBackground(var6,var5);
		this.adjust(var6 + ank.battlefield.Constants.BUBBLE_MARGIN * 2,var5 + ank.battlefield.Constants.BUBBLE_MARGIN * 2 + ank.battlefield.Constants.BUBBLE_PIC_HEIGHT,var3,var4);
		var var7 = ank.battlefield.Constants.BUBBLE_REMOVE_TIMER + var2.length * ank.battlefield.Constants.BUBBLE_REMOVE_CHAR_TIMER;
		ank.utils.Timer.setTimer(this,"battlefield",this,this.remove,var7);
	}
	function remove()
	{
		this.swapDepths(1);
		this.removeMovieClip();
	}
	function drawBackground(var2, var3)
	{
		var var4 = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
		this.createEmptyMovieClip("_bg",10);
		this._bg.lineStyle(1,ank.battlefield.Constants.BUBBLE_BORDERCOLOR,100);
		this._bg.beginFill(ank.battlefield.Constants.BUBBLE_BGCOLOR,100);
		this._bg.moveTo(0,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH / 2,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(0,0);
		this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(var2 + var4,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(var2 + var4,- var3 - var4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(0,- var3 - var4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.endFill();
	}
	function adjust(var2, var3, var4, var5)
	{
		var var6 = this._maxW - var2;
		var var7 = var3 + ank.battlefield.Constants.BUBBLE_Y_OFFSET;
		if(var4 > var6)
		{
			this._txtf._x = - var2 + ank.battlefield.Constants.BUBBLE_MARGIN;
			this._bg._xscale = -100;
		}
		else
		{
			this._txtf._x = ank.battlefield.Constants.BUBBLE_MARGIN;
		}
		if(var5 < var7)
		{
			this._txtf._y = ank.battlefield.Constants.BUBBLE_PIC_HEIGHT + ank.battlefield.Constants.BUBBLE_MARGIN - 3;
			this._bg._yscale = -100;
		}
		else
		{
			this._txtf._y = - var3 + ank.battlefield.Constants.BUBBLE_MARGIN - 3 - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
			this._bg._y = - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
		}
		this._x = var4;
		this._y = var5;
	}
}
