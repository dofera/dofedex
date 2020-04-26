class ank.battlefield.mc.Bubble extends MovieClip
{
	function Bubble(loc3, loc4, loc5, loc6)
	{
		super();
		this.initialize(loc3,loc4,loc5,loc6);
	}
	function initialize(loc2, loc3, loc4, loc5)
	{
		this._maxW = loc5;
		this.createTextField("_txtf",20,0,0,150,100);
		this._txtf.autoSize = "left";
		this._txtf.wordWrap = true;
		this._txtf.embedFonts = true;
		this._txtf.multiline = true;
		this._txtf.selectable = false;
		this._txtf.html = true;
		this.draw(loc2,loc3,loc4);
	}
	function draw(loc2, loc3, loc4)
	{
		this._txtf.htmlText = loc2;
		this._txtf.setTextFormat(ank.battlefield.Constants.BUBBLE_TXTFORMAT);
		var loc5 = this._txtf.textHeight > 10?this._txtf.textHeight:11;
		var loc6 = this._txtf.textWidth > 10?this._txtf.textWidth + 4:11;
		this.drawBackground(loc6,loc5);
		this.adjust(loc6 + ank.battlefield.Constants.BUBBLE_MARGIN * 2,loc5 + ank.battlefield.Constants.BUBBLE_MARGIN * 2 + ank.battlefield.Constants.BUBBLE_PIC_HEIGHT,loc3,loc4);
		var loc7 = ank.battlefield.Constants.BUBBLE_REMOVE_TIMER + loc2.length * ank.battlefield.Constants.BUBBLE_REMOVE_CHAR_TIMER;
		ank.utils.Timer.setTimer(this,"battlefield",this,this.remove,loc7);
	}
	function remove()
	{
		this.swapDepths(1);
		this.removeMovieClip();
	}
	function drawBackground(loc2, loc3)
	{
		var loc4 = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
		this.createEmptyMovieClip("_bg",10);
		this._bg.lineStyle(1,ank.battlefield.Constants.BUBBLE_BORDERCOLOR,100);
		this._bg.beginFill(ank.battlefield.Constants.BUBBLE_BGCOLOR,100);
		this._bg.moveTo(0,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH / 2,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(0,0);
		this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(loc2 + loc4,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(loc2 + loc4,- loc3 - loc4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.lineTo(0,- loc3 - loc4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
		this._bg.endFill();
	}
	function adjust(loc2, loc3, loc4, loc5)
	{
		var loc6 = this._maxW - loc2;
		var loc7 = loc3 + ank.battlefield.Constants.BUBBLE_Y_OFFSET;
		if(loc4 > loc6)
		{
			this._txtf._x = - loc2 + ank.battlefield.Constants.BUBBLE_MARGIN;
			this._bg._xscale = -100;
		}
		else
		{
			this._txtf._x = ank.battlefield.Constants.BUBBLE_MARGIN;
		}
		if(loc5 < loc7)
		{
			this._txtf._y = ank.battlefield.Constants.BUBBLE_PIC_HEIGHT + ank.battlefield.Constants.BUBBLE_MARGIN - 3;
			this._bg._yscale = -100;
		}
		else
		{
			this._txtf._y = - loc3 + ank.battlefield.Constants.BUBBLE_MARGIN - 3 - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
			this._bg._y = - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
		}
		this._x = loc4;
		this._y = loc5;
	}
}
