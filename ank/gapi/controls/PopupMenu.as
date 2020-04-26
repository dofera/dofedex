class ank.gapi.controls.PopupMenu extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "PopupMenu";
	static var MAX_ITEM_WIDTH = 150;
	static var ITEM_HEIGHT = 18;
	var _bOver = false;
	var _bCloseOnMouseUp = true;
	function PopupMenu()
	{
		super();
	}
	function addStaticItem(loc2)
	{
		var loc3 = new Object();
		loc3.text = loc2;
		loc3.bStatic = true;
		loc3.bEnabled = false;
		this._aItems.push(loc3);
	}
	function addItem(loc2, loc3, loc4, loc5, loc6)
	{
		if(loc6 == undefined)
		{
			loc6 = true;
		}
		var loc7 = new Object();
		loc7.text = loc2;
		loc7.bStatic = false;
		loc7.bEnabled = loc6;
		loc7.obj = loc3;
		loc7.fn = loc4;
		loc7.args = loc5;
		this._aItems.push(loc7);
	}
	function __get__items()
	{
		return this._aItems;
	}
	function show(loc2, loc3, loc4, loc5, loc6)
	{
		ank.utils.Timer.removeTimer(this._name);
		if(loc2 == undefined)
		{
			loc2 = _root._xmouse;
		}
		if(loc3 == undefined)
		{
			loc3 = _root._ymouse;
		}
		this.layoutContent(loc2,loc3,loc4,loc5);
		if(!_global.isNaN(Number(loc6)))
		{
			ank.utils.Timer.setTimer(this,this._name,this,this.remove,loc6);
			this._bCloseOnMouseUp = false;
		}
		this.addToQueue({object:Mouse,method:Mouse.addListener,params:[this]});
	}
	function init()
	{
		super.init(false,ank.gapi.controls.PopupMenu.CLASS_NAME);
		this._aItems = new Array();
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcBorder",10);
		this.createEmptyMovieClip("_mcBackground",20);
		this.createEmptyMovieClip("_mcForeground",30);
		this.createEmptyMovieClip("_mcItems",40);
	}
	function size()
	{
		this.arrange();
	}
	function arrange()
	{
		if(this._bInitialized && (this.__width != undefined && this.__height != undefined))
		{
			this._mcItems._x = this._mcItems._y = 2;
			this._mcBorder._width = this.__width;
			this._mcBorder._height = this.__height;
			this._mcBackground._x = this._mcBackground._y = 1;
			this._mcBackground._width = this.__width - 2;
			this._mcBackground._height = this.__height - 2;
			this._mcForeground._x = this._mcForeground._y = 2;
			this._mcForeground._width = this.__width - 4;
			this._mcForeground._height = this.__height - 4;
			var loc2 = this._aItems.length;
			while(true)
			{
				loc2;
				if(loc2-- > 0)
				{
					this.arrangeItem(loc2,this.__width - 4);
					continue;
				}
				break;
			}
		}
	}
	function draw()
	{
		var loc2 = this.getStyle();
		this._mcBorder.clear();
		this._mcBackground.clear();
		this._mcForeground.clear();
		this.drawRoundRect(this._mcBorder,0,0,1,1,0,loc2.bordercolor);
		this.drawRoundRect(this._mcBackground,0,0,1,1,0,loc2.backgroundcolor);
		this.drawRoundRect(this._mcForeground,0,0,1,1,0,loc2.foregroundcolor);
	}
	function drawItem(i, §\r\x16§, §\x1e\x1c\x0b§)
	{
		var loc4 = this._mcItems.createEmptyMovieClip("item" + loc2,loc2);
		var loc5 = (ank.gapi.controls.Label)loc4.attachMovie("Label","_lbl",20,{_width:ank.gapi.controls.PopupMenu.MAX_ITEM_WIDTH,styleName:this.getStyle().labelenabledstyle,wordWrap:true,text:i.text});
		loc5.setPreferedSize("left");
		var loc6 = Math.max(ank.gapi.controls.PopupMenu.ITEM_HEIGHT,loc5.textHeight + 6);
		if(i.bStatic)
		{
			loc5.styleName = this.getStyle().labelstaticstyle;
		}
		else if(!i.bEnabled)
		{
			loc5.styleName = this.getStyle().labeldisabledstyle;
		}
		loc4.createEmptyMovieClip("bg",10);
		this.drawRoundRect(loc4.bg,0,0,1,loc6,0,this.getStyle().itembgcolor);
		loc4._y = loc3;
		if(i.bEnabled)
		{
			loc4.bg.onRelease = function()
			{
				i.fn.apply(i.obj,i.args);
				this._parent._parent._parent.remove(true);
			};
			loc4.bg.onRollOver = function()
			{
				var loc2 = new Color(this);
				loc2.setRGB(this._parent._parent._parent.getStyle().itemovercolor);
				this._parent._parent._parent.onItemOver();
			};
			loc4.bg.onRollOut = loc4.bg.onReleaseOutside = function()
			{
				var loc2 = new Color(this);
				loc2.setRGB(this._parent._parent._parent.getStyle().itembgcolor);
				this._parent._parent._parent.onItemOut();
			};
		}
		else
		{
			loc4.bg.onPress = function()
			{
			};
			loc4.bg.useHandCursor = false;
			var loc7 = new Color(loc4.bg);
			if(i.bStatic)
			{
				loc7.setRGB(this.getStyle().itemstaticbgcolor);
			}
			else
			{
				loc7.setRGB(this.getStyle().itembgcolor);
			}
		}
		return {w:loc5.textWidth,h:loc6};
	}
	function arrangeItem(loc2, loc3)
	{
		var loc4 = this._mcItems["item" + loc2];
		loc4._lbl.setSize(loc3,ank.gapi.controls.PopupMenu.ITEM_HEIGHT);
		loc4.bg._width = loc3;
	}
	function layoutContent(loc2, loc3, loc4, loc5)
	{
		var loc6 = this._aItems.length;
		var loc7 = 0;
		var loc8 = 0;
		var loc9 = 0;
		while(loc9 < this._aItems.length)
		{
			var loc10 = this.drawItem(this._aItems[loc9],loc9,loc8);
			loc8 = loc8 + loc10.h;
			loc7 = Math.max(loc7,loc10.w);
			loc9 = loc9 + 1;
		}
		this.setSize(loc7 + 16,loc8 + 4);
		var loc11 = !loc4?this.gapi.screenWidth:Stage.width;
		var loc12 = !loc4?this.gapi.screenHeight:Stage.height;
		if(loc5 == true)
		{
			loc2 = loc2 - this.__width;
		}
		if(loc2 > loc11 - this.__width)
		{
			this._x = loc11 - this.__width;
		}
		else if(loc2 < 0)
		{
			this._x = 0;
		}
		else
		{
			this._x = loc2;
		}
		if(loc3 > loc12 - this.__height)
		{
			this._y = loc12 - this.__height;
		}
		else if(loc3 < 0)
		{
			this._y = 0;
		}
		else
		{
			this._y = loc3;
		}
	}
	function remove()
	{
		Mouse.removeListener(this);
		this.removeMovieClip();
	}
	function onItemOver()
	{
		this._bOver = true;
	}
	function onItemOut()
	{
		this._bOver = false;
	}
	function onMouseUp()
	{
		if(!this._bOver && this._bCloseOnMouseUp)
		{
			this.remove();
		}
	}
}
