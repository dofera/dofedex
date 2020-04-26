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
	function drawBackground(loc2, loc3, loc4)
	{
		this.drawRoundRect(this._mcTxtBackground,(- loc2) / 2,0,loc2,loc3,3,loc4,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_ALPHA);
	}
	function drawGfx(loc2, loc3)
	{
		this._mcGfx.attachClassMovie(ank.utils.SWFLoader,"_mcSwfLoader",10);
		this._mcGfx._mcSwfLoader.loadSWF(loc2,loc3);
	}
	function addPvpGfxEffect(loc2, loc3)
	{
		switch(loc2)
		{
			case -1:
				var loc4 = 0.5;
				var loc5 = new Array();
				loc5 = loc5.concat([loc4,0,0,0,0]);
				loc5 = loc5.concat([0,loc4,0,0,0]);
				loc5 = loc5.concat([0,0,loc4,0,0]);
				loc5 = loc5.concat([0,0,0,1,0]);
				var loc6 = new flash.filters.ColorMatrixFilter(loc5);
				this._mcGfx.filters = new Array(loc6);
				break;
			case 1:
				switch(Math.floor((loc3 - 1) / 10))
				{
					case 0:
						var loc7 = 11201279;
						break;
					case 1:
						loc7 = 13369344;
						break;
					case 2:
						loc7 = 0;
				}
				var loc8 = 0.5;
				var loc9 = 10;
				var loc10 = 10;
				var loc11 = 2;
				var loc12 = 3;
				var loc13 = false;
				var loc14 = false;
				var loc15 = new flash.filters.GlowFilter(loc7,loc8,loc9,loc10,loc11,loc12,loc13,loc14);
				var loc16 = new Array();
				loc16.push(loc15);
				this._mcGfx.filters = loc16;
		}
	}
}
