class ank.gapi.controls.Window extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Window";
	static var LBL_TITLE_HEIGHT = 25;
	static var LBL_TITLE_TOP_PADDING = 5;
	static var LBL_TITLE_LEFT_PADDING = 5;
	var _bDrag = false;
	var _bCenterScreen = true;
	var _sContentPath = "none";
	var _bContentLoaded = false;
	var _bInterceptMouseEvent = false;
	function Window()
	{
		super();
	}
	function __set__title(sTitle)
	{
		this.addToQueue({object:this,method:function()
		{
			this._lblTitle.text = sTitle;
		}});
		return this.__get__title();
	}
	function __get__title()
	{
		return this._lblTitle.text;
	}
	function __set__contentPath(sContentPath)
	{
		this._bContentLoaded = false;
		this._sContentPath = sContentPath;
		if(sContentPath == "none")
		{
			this.addToQueue({object:this,method:function()
			{
				this._ldrContent.contentPath = "";
			}});
		}
		else
		{
			this.addToQueue({object:this,method:function()
			{
				this._ldrContent.contentPath = sContentPath;
			}});
		}
		return this.__get__contentPath();
	}
	function __get__contentPath()
	{
		return this._ldrContent.contentPath;
	}
	function __set__contentParams(oParams)
	{
		this.addToQueue({object:this,method:function()
		{
			this._ldrContent.contentParams = oParams;
		}});
		return this.__get__contentParams();
	}
	function __get__contentParams()
	{
		return this._ldrContent.contentParams;
	}
	function __get__content()
	{
		return this._ldrContent.content;
	}
	function __set__centerScreen(var2)
	{
		this._bCenterScreen = var2;
		return this.__get__centerScreen();
	}
	function __get__centerScreen()
	{
		return this._bCenterScreen;
	}
	function __set__interceptMouseEvent(var2)
	{
		this._bInterceptMouseEvent = var2;
		this.useHandCursor = false;
		if(var2)
		{
			this.onRelease = function()
			{
			};
		}
		else
		{
			delete this.onRelease;
		}
		return this.__get__interceptMouseEvent();
	}
	function __get__interceptMouseEvent()
	{
		return this._bInterceptMouseEvent;
	}
	function setPreferedSize()
	{
		this._ldrContent._x = this._ldrContent._y = 0;
		var var2 = this._ldrContent.content.getBounds(this);
		var var3 = var2.xMax - var2.xMin;
		var var4 = var2.yMax - var2.yMin;
		var var5 = this.getStyle();
		var var6 = var5.cornerradius;
		var var7 = var5.borderwidth == undefined?0:var5.borderwidth;
		var var8 = var5.titleheight;
		this._ldrContent._x = var7 - var2.xMin;
		this._ldrContent._y = var7 + var8 - var2.yMin;
		this.setSize(2 * var7 + var3,2 * var7 + var8 + var4 + (typeof var6 != "object"?var6:Math.max(var6.bl,var6.br)));
	}
	function init()
	{
		super.init(false,ank.gapi.controls.Window.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcBorder",10);
		this.createEmptyMovieClip("_mcBackground",20);
		this.createEmptyMovieClip("_mcTitle",30);
		this.attachMovie("Loader","_ldrContent",40);
		this._ldrContent.addEventListener("complete",this);
		this.attachMovie("Label","_lblTitle",50,{_x:ank.gapi.controls.Window.LBL_TITLE_LEFT_PADDING,_y:ank.gapi.controls.Window.LBL_TITLE_TOP_PADDING});
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		this._lblTitle.setSize(this.__width - ank.gapi.controls.Window.LBL_TITLE_LEFT_PADDING,ank.gapi.controls.Window.LBL_TITLE_HEIGHT);
		if(this._bInitialized)
		{
			this.draw();
		}
		if(this._bCenterScreen)
		{
			this._x = (this.gapi.screenWidth - this.__width) / 2;
			this._y = (this.gapi.screenHeight - this.__height) / 2;
		}
	}
	function draw()
	{
		if(this._sContentPath != "none" && !this._bContentLoaded)
		{
			return undefined;
		}
		var var2 = this.getStyle();
		this._lblTitle.styleName = var2.titlestyle;
		var var3 = var2.cornerradius;
		var var4 = var2.bordercolor;
		var var5 = var2.borderwidth == undefined?0:var2.borderwidth;
		var var6 = var2.backgroundcolor;
		var var7 = var2.backgroundalpha == undefined?100:var2.backgroundalpha;
		var var8 = var2.backgroundrotation == undefined?0:var2.backgroundrotation;
		var var9 = var2.backgroundradient;
		var var10 = var2.backgroundratio;
		var var11 = var2.displaytitle == undefined?true:var2.displaytitle;
		var var12 = var2.titlecolor;
		var var13 = var2.titleheight;
		if(typeof var3 == "object")
		{
			var var14 = {tl:var3.tl - var5,tr:var3.tr - var5,br:var3.bl - var5,bl:var3.bl - var5};
		}
		else
		{
			var14 = var3 - var5;
		}
		if(typeof var3 == "object")
		{
			var var15 = {tl:var3.tl - var5,tr:var3.tr - var5,br:0,bl:0};
		}
		else
		{
			var15 = {tl:var3 - var5,tr:var3 - var5,bl:0,br:0};
		}
		this._mcBorder.clear();
		this._mcBackground.clear();
		this._mcTitle.clear();
		this.drawRoundRect(this._mcBorder,0,0,this.__width,this.__height,var3,var4);
		this.drawRoundRect(this._mcBackground,var5,var5,this.__width - 2 * var5,this.__height - 2 * var5,var14,var6,var7,var8,var9,var10);
		if(var11)
		{
			this.drawRoundRect(this._mcTitle,var5,var5,this.__width - 2 * var5,var13,var15,var12);
		}
	}
	function complete()
	{
		this._bContentLoaded = true;
		this.dispatchEvent({type:"complete"});
		this.setPreferedSize();
	}
}
