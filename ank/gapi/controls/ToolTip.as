class ank.gapi.controls.ToolTip extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ToolTip";
	static var MAX_WIDTH = 250;
	function ToolTip()
	{
		super();
	}
	function __set__params(loc2)
	{
		this._oParams = loc2;
		return this.__get__params();
	}
	function __set__text(loc2)
	{
		this._sText = loc2;
		if(this.initialized)
		{
			this.layoutContent();
		}
		return this.__get__text();
	}
	function __set__x(loc2)
	{
		this._nX = loc2;
		if(this.initialized)
		{
			this.placeToolTip();
		}
		return this.__get__x();
	}
	function __set__y(loc2)
	{
		this._nY = loc2;
		if(this.initialized)
		{
			this.placeToolTip();
		}
		return this.__get__y();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.ToolTip.CLASS_NAME);
	}
	function createChildren()
	{
		this._visible = false;
		this.createEmptyMovieClip("_mcBackground",10);
		this.createTextField("_tfText",20,0,0,ank.gapi.controls.ToolTip.MAX_WIDTH,100);
		this._tfText.wordWrap = true;
		this._tfText.selectable = false;
		this._tfText.autoSize = "left";
		this._tfText.multiline = true;
		this._tfText.html = true;
		this.addToQueue({object:this,method:this.layoutContent});
		this.addToQueue({object:this,method:this.placeToolTip});
		Key.addListener(this);
	}
	function placeToolTip()
	{
		var loc2 = !(this._oParams.bXLimit || this._oParams.bXLimit == undefined)?Number.MAX_VALUE:this.gapi.screenWidth;
		var loc3 = !(this._oParams.bYLimit || this._oParams.bYLimit == undefined)?Number.MAX_VALUE:this.gapi.screenHeight;
		var loc4 = !(!this._oParams.bRightAlign || this._oParams.bRightAlign == undefined)?this._oParams.bRightAlign:false;
		var loc5 = !(!this._oParams.bTopAlign || this._oParams.bTopAlign == undefined)?this._oParams.bTopAlign:false;
		var loc6 = !loc4?this._nX:this._nX - this.__width;
		var loc7 = !loc5?this._nY:this._nY - this.__height;
		if(loc6 > loc2 - this.__width)
		{
			this._x = loc2 - this.__width;
		}
		else if(loc6 < 0)
		{
			this._x = 0;
		}
		else
		{
			this._x = loc6;
		}
		if(loc7 > loc3 - this.__height)
		{
			this._y = loc3 - this.__height;
		}
		else if(loc7 < 0)
		{
			this._y = 0;
		}
		else
		{
			this._y = loc7;
		}
		this._visible = true;
	}
	function draw()
	{
		var loc2 = this.getStyle();
		this.drawRoundRect(this._mcBackground,0,0,1,1,0,loc2.bgcolor);
		this._mcBackground._alpha = loc2.bgalpha;
		this._tfTextFormat = new TextFormat();
		this._tfTextFormat.font = loc2.font;
		this._tfTextFormat.size = loc2.size;
		this._tfTextFormat.color = loc2.color;
		this._tfTextFormat.bold = loc2.bold;
		this._tfTextFormat.italic = loc2.italic;
		this._tfTextFormat.size = loc2.size;
		this._tfTextFormat.size = loc2.size;
		this._tfText.embedFonts = loc2.embedfonts;
		this._tfText.antiAliasType = loc2.antialiastype;
	}
	function layoutContent()
	{
		this._tfText.htmlText = this._sText;
		this._tfText.setTextFormat(this._tfTextFormat);
		this.setSize(this._tfText.textWidth + 4,this._tfText.textHeight + 4);
		this._mcBackground._width = this.__width;
		this._mcBackground._height = this.__height;
	}
	function onKeyDown()
	{
		this.removeMovieClip();
	}
	function onMouseDown()
	{
		this.removeMovieClip();
	}
}
