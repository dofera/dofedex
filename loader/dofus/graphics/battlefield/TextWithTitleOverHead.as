class dofus.graphics.battlefield.TextWithTitleOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
	static var STARS_COUNT = 5;
	static var STARS_WIDTH = 10;
	static var STARS_MARGIN = 2;
	static var STARS_COLORS = [-1,16777011,16750848,39168,39372,6697728,2236962,16711680,65280,16777215,16711935];
	function TextWithTitleOverHead(§\x1e\f\x14§, §\x1e\x12\r§, §\x07\x03§, §\x05\x03§, §\x1e\f\x10§, §\x06\x1c§, nStarsValue)
	{
		super();
		this.initialize(nStarsValue);
		this.draw(var3,var4,var5,var6,var7,var8);
	}
	function initialize(var2)
	{
		super.initialize();
		if(var3 == undefined || _global.isNaN(var3))
		{
			var3 = -1;
		}
		this._nStarsValue = var3;
		this.createTextField("_txtTitle",40,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + 4,0,0);
		this.createTextField("_txtText",30,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue <= -1?1:2) + 20 + (this._nStarsValue <= -1?0:dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH),0,0);
		this._txtText.embedFonts = true;
		this._txtTitle.embedFonts = true;
		this._aStars = new Array();
	}
	function draw(var2, var3, var4, var5, var6, var7)
	{
		var var8 = var3 != undefined && var5 != undefined;
		this._txtText.autoSize = "center";
		this._txtText.text = var2;
		this._txtText.selectable = false;
		this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		if(var4 != undefined)
		{
			this._txtText.textColor = var4;
		}
		this._txtTitle.autoSize = "center";
		this._txtTitle.text = var6;
		this._txtTitle.selectable = false;
		this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		if(var7 != undefined)
		{
			this._txtTitle.textColor = var7;
		}
		this._nFullWidth = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT - 1) * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN;
		var var9 = Math.ceil(this._txtText.textHeight + 20 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue <= -1?3:4) + (this._nStarsValue <= -1?0:dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH));
		var var10 = Math.ceil(Math.max(Math.max(this._txtText.textWidth,this._txtTitle.textWidth),this._nStarsValue <= -1?0:this._nFullWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
		this.drawBackground(var10,var9,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
		if(this._nStarsValue > -1)
		{
			var var11 = this.getStarsColor();
			var var12 = 0;
			while(var12 < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
			{
				var var13 = new Object();
				var13._x = var12 * (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN) - this._nFullWidth / 2 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER;
				var13._y = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 4 + this._txtTitle.textHeight;
				this._aStars[var12] = this.createEmptyMovieClip("star" + var12,50 + var12);
				this._aStars[var12].attachMovie("StarBorder","star",1,var13);
				var var14 = this._aStars[var12].star.fill;
				if(var11[var12] > -1)
				{
					var var15 = new Color(var14);
					var15.setRGB(var11[var12]);
				}
				else
				{
					var14._alpha = 0;
				}
				var12 = var12 + 1;
			}
		}
		if(var8)
		{
			this.drawGfx(var3,var5);
		}
	}
	function getStarsColor()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
		{
			var var4 = Math.floor(this._nStarsValue / 100) + (this._nStarsValue - Math.floor(this._nStarsValue / 100) * 100 <= var3 * (100 / dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)?0:1);
			var2[var3] = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS[Math.min(var4,dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS.length - 1)];
			var3 = var3 + 1;
		}
		return var2;
	}
}
