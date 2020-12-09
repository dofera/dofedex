class dofus.graphics.battlefield.AbstractTextOverHead extends ank.gapi.core.UIBasicComponent
{
	static var BACKGROUND_ALPHA = 70;
	static var BACKGROUND_COLOR = 0;
	static var TEXT_SMALL_FORMAT = new TextFormat("Font1",10,16777215,false,false,false,null,null,"left");
	static var TEXT_FORMAT2 = new TextFormat("Font2",9,16777215,false,false,false,null,null,"center");
	static var TEXT_FORMAT = new TextFormat("Font2",10,16777215,false,false,false,null,null,"center");
	static var CORNER_RADIUS = 0;
	static var WIDTH_SPACER = 4;
	static var HEIGHT_SPACER = 4;
	function AbstractTextOverHead()
	{
		super();
	}
	function __get__height()
	{
		return Math.ceil(this._height);
	}
	function __get__width()
	{
		return Math.ceil(this._width);
	}
	function initialize()
	{
		this.createEmptyMovieClip("_mcGfx",10);
		this.createEmptyMovieClip("_mcTxtBackground",20);
	}
	function drawBackground(§\x1e\x1b\x0f§, §\x05\x07§, §\x07\x0e§)
	{
		this.drawRoundRect(this._mcTxtBackground,(- var2) / 2,0,var2,var3,3,var4,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_ALPHA);
	}
	function drawGfx(§\x1e\x12\x18§, §\x05\r§)
	{
		this._mcGfx.attachClassMovie(ank.utils.SWFLoader,"_mcSwfLoader",10);
		this._mcGfx._mcSwfLoader.loadSWF(var2,var3);
	}
	function addPvpGfxEffect(§\x01\x11§, §\x05\r§)
	{
		switch(var2)
		{
			case -1:
				var var4 = 0.5;
				var var5 = new Array();
				var5 = var5.concat([var4,0,0,0,0]);
				var5 = var5.concat([0,var4,0,0,0]);
				var5 = var5.concat([0,0,var4,0,0]);
				var5 = var5.concat([0,0,0,1,0]);
				var var6 = new flash.filters.ColorMatrixFilter(var5);
				this._mcGfx.filters = new Array(var6);
				break;
			case 1:
				switch(Math.floor((var3 - 1) / 10))
				{
					case 0:
						var var7 = 11201279;
						break;
					case 1:
						var7 = 13369344;
						break;
					case 2:
						var7 = 0;
				}
				var var8 = 0.5;
				var var9 = 10;
				var var10 = 10;
				var var11 = 2;
				var var12 = 3;
				var var13 = false;
				var var14 = false;
				var var15 = new flash.filters.GlowFilter(var7,var8,var9,var10,var11,var12,var13,var14);
				var var16 = new Array();
				var16.push(var15);
				this._mcGfx.filters = var16;
		}
	}
}
