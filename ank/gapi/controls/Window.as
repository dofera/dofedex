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
	function __set__centerScreen(loc2)
	{
		this._bCenterScreen = loc2;
		return this.__get__centerScreen();
	}
	function __get__centerScreen()
	{
		return this._bCenterScreen;
	}
	function __set__interceptMouseEvent(loc2)
	{
		this._bInterceptMouseEvent = loc2;
		this.useHandCursor = false;
		if(loc2)
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
		var loc2 = this._ldrContent.content.getBounds(this);
		var loc3 = loc2.xMax - loc2.xMin;
		var loc4 = loc2.yMax - loc2.yMin;
		var loc5 = this.getStyle();
		var loc6 = loc5.cornerradius;
		var loc7 = loc5.borderwidth == undefined?0:loc5.borderwidth;
		var loc8 = loc5.titleheight;
		this._ldrContent._x = loc7 - loc2.xMin;
		this._ldrContent._y = loc7 + loc8 - loc2.yMin;
		this.setSize(2 * loc7 + loc3,2 * loc7 + loc8 + loc4 + (typeof loc6 != "object"?loc6:Math.max(loc6.bl,loc6.br)));
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
		var loc2 = this.getStyle();
		this._lblTitle.styleName = loc2.titlestyle;
		var loc3 = loc2.cornerradius;
		var loc4 = loc2.bordercolor;
		var loc5 = loc2.borderwidth == undefined?0:loc2.borderwidth;
		var loc6 = loc2.backgroundcolor;
		var loc7 = loc2.backgroundalpha == undefined?100:loc2.backgroundalpha;
		var loc8 = loc2.backgroundrotation == undefined?0:loc2.backgroundrotation;
		var loc9 = loc2.backgroundradient;
		var loc10 = loc2.backgroundratio;
		var loc11 = loc2.displaytitle == undefined?true:loc2.displaytitle;
		var loc12 = loc2.titlecolor;
		var loc13 = loc2.titleheight;
		if(typeof loc3 == "object")
		{
			var loc14 = {tl:loc3.tl - loc5,tr:loc3.tr - loc5,br:loc3.bl - loc5,bl:loc3.bl - loc5};
		}
		else
		{
			loc14 = loc3 - loc5;
		}
		if(typeof loc3 == "object")
		{
			var loc15 = {tl:loc3.tl - loc5,tr:loc3.tr - loc5,br:0,bl:0};
		}
		else
		{
			loc15 = {tl:loc3 - loc5,tr:loc3 - loc5,bl:0,br:0};
		}
		this._mcBorder.clear();
		this._mcBackground.clear();
		this._mcTitle.clear();
		this.drawRoundRect(this._mcBorder,0,0,this.__width,this.__height,loc3,loc4);
		this.drawRoundRect(this._mcBackground,loc5,loc5,this.__width - 2 * loc5,this.__height - 2 * loc5,loc14,loc6,loc7,loc8,loc9,loc10);
		if(loc11)
		{
			this.drawRoundRect(this._mcTitle,loc5,loc5,this.__width - 2 * loc5,loc13,loc15,loc12);
		}
	}
	function complete()
	{
		this._bContentLoaded = true;
		this.dispatchEvent({type:"complete"});
		this.setPreferedSize();
	}
}
