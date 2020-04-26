class dofus.graphics.battlefield.TextWithTitleOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
	static var STARS_COUNT = 5;
	static var STARS_WIDTH = 10;
	static var STARS_MARGIN = 2;
	static var STARS_COLORS = [-1,16777011,16750848,39168,39372,6697728,2236962,16711680,65280,16777215,16711935];
	function TextWithTitleOverHead(§\x1e\x0e\x19§, §\x1e\x14\x04§, §\b\t§, §\x06\f§, §\x1e\x0e\x16§, §\b\x05§, nStarsValue)
	{
		super();
		this.initialize(nStarsValue);
		this.draw(loc3,loc4,loc5,loc6,loc7,loc8);
	}
	function initialize(loc2)
	{
		super.initialize();
		if(loc3 == undefined || _global.isNaN(loc3))
		{
			loc3 = -1;
		}
		this._nStarsValue = loc3;
		this.createTextField("_txtTitle",40,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + 4,0,0);
		this.createTextField("_txtText",30,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue <= -1?1:2) + 20 + (this._nStarsValue <= -1?0:dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH),0,0);
		this._txtText.embedFonts = true;
		this._txtTitle.embedFonts = true;
		this._aStars = new Array();
	}
	function draw(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		var loc8 = loc3 != undefined && loc5 != undefined;
		this._txtText.autoSize = "center";
		this._txtText.text = loc2;
		this._txtText.selectable = false;
		this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		if(loc4 != undefined)
		{
			this._txtText.textColor = loc4;
		}
		this._txtTitle.autoSize = "center";
		this._txtTitle.text = loc6;
		this._txtTitle.selectable = false;
		this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		if(loc7 != undefined)
		{
			this._txtTitle.textColor = loc7;
		}
		this._nFullWidth = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT - 1) * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN;
		var loc9 = Math.ceil(this._txtText.textHeight + 20 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue <= -1?3:4) + (this._nStarsValue <= -1?0:dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH));
		var loc10 = Math.ceil(Math.max(Math.max(this._txtText.textWidth,this._txtTitle.textWidth),this._nStarsValue <= -1?0:this._nFullWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
		this.drawBackground(loc10,loc9,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
		if(this._nStarsValue > -1)
		{
			var loc11 = this.getStarsColor();
			var loc12 = 0;
			while(loc12 < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
			{
				var loc13 = new Object();
				loc13._x = loc12 * (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN) - this._nFullWidth / 2 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER;
				loc13._y = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 4 + this._txtTitle.textHeight;
				this._aStars[loc12] = this.createEmptyMovieClip("star" + loc12,50 + loc12);
				this._aStars[loc12].attachMovie("StarBorder","star",1,loc13);
				var loc14 = this._aStars[loc12].star.fill;
				if(loc11[loc12] > -1)
				{
					var loc15 = new Color(loc14);
					loc15.setRGB(loc11[loc12]);
				}
				else
				{
					loc14._alpha = 0;
				}
				loc12 = loc12 + 1;
			}
		}
		if(loc8)
		{
			this.drawGfx(loc3,loc5);
		}
	}
	function getStarsColor()
	{
		var loc2 = new Array();
		var loc3 = 0;
		while(loc3 < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
		{
			var loc4 = Math.floor(this._nStarsValue / 100) + (this._nStarsValue - Math.floor(this._nStarsValue / 100) * 100 <= loc3 * (100 / dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)?0:1);
			loc2[loc3] = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS[Math.min(loc4,dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS.length - 1)];
			loc3 = loc3 + 1;
		}
		return loc2;
	}
}
