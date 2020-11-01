class ank.gapi.controls.PopupMenu extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "PopupMenu";
	static var LAST_POPUP_VALIDATION = 0;
	static var LAST_POPUP_VALIDATION_WAIT_DELAY = 500;
	static var MAX_ITEM_WIDTH = 150;
	static var ITEM_HEIGHT = 18;
	var _bOver = false;
	var _bRemoved = false;
	var _bCloseOnMouseUp = true;
	function PopupMenu()
	{
		super();
	}
	function __get__x()
	{
		return this._nX;
	}
	function __get__y()
	{
		return this._nY;
	}
	function __get__removed()
	{
		return this._bRemoved;
	}
	function __get__adminPopupMenu()
	{
		return this._bAdminPopupMenu;
	}
	function __set__adminPopupMenu(var2)
	{
		this._bAdminPopupMenu = var2;
		return this.__get__adminPopupMenu();
	}
	function addStaticItem(var2)
	{
		var var3 = new Object();
		var3.text = var2;
		var3.bStatic = true;
		var3.bEnabled = false;
		this._aItems.push(var3);
	}
	function addItem(var2, var3, var4, var5, var6)
	{
		if(var6 == undefined)
		{
			var6 = true;
		}
		var var7 = new Object();
		var7.text = var2;
		var7.bStatic = false;
		var7.bEnabled = var6;
		var7.obj = var3;
		var7.fn = var4;
		var7.args = var5;
		this._aItems.push(var7);
	}
	function __get__items()
	{
		return this._aItems;
	}
	function show(var2, var3, var4, var5, var6)
	{
		ank.utils.Timer.removeTimer(this._name);
		if(var2 == undefined)
		{
			var2 = _root._xmouse;
		}
		if(var3 == undefined)
		{
			var3 = _root._ymouse;
		}
		this._nX = var2;
		this._nY = var3;
		this.layoutContent(var2,var3,var4,var5);
		if(!_global.isNaN(Number(var6)))
		{
			ank.utils.Timer.setTimer(this,this._name,this,this.remove,var6);
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
			var var2 = this._aItems.length;
			while(true)
			{
				var2;
				if(var2-- > 0)
				{
					this.arrangeItem(var2,this.__width - 4);
					continue;
				}
				break;
			}
		}
	}
	function draw()
	{
		var var2 = this.getStyle();
		this._mcBorder.clear();
		this._mcBackground.clear();
		this._mcForeground.clear();
		this.drawRoundRect(this._mcBorder,0,0,1,1,0,var2.bordercolor);
		this.drawRoundRect(this._mcBackground,0,0,1,1,0,var2.backgroundcolor);
		this.drawRoundRect(this._mcForeground,0,0,1,1,0,var2.foregroundcolor);
	}
	function drawItem(i, §\f\x14§, §\x1e\x1a\x18§)
	{
		var var4 = this._mcItems.createEmptyMovieClip("item" + var2,var2);
		var var5 = (ank.gapi.controls.Label)var4.attachMovie("Label","_lbl",20,{_width:ank.gapi.controls.PopupMenu.MAX_ITEM_WIDTH,styleName:this.getStyle().labelenabledstyle,wordWrap:true,text:i.text});
		var5.setPreferedSize("left");
		var var6 = Math.max(ank.gapi.controls.PopupMenu.ITEM_HEIGHT,var5.textHeight + 6);
		if(i.bStatic)
		{
			var5.styleName = this.getStyle().labelstaticstyle;
		}
		else if(!i.bEnabled)
		{
			var5.styleName = this.getStyle().labeldisabledstyle;
		}
		var4.createEmptyMovieClip("bg",10);
		this.drawRoundRect(var4.bg,0,0,1,var6,0,this.getStyle().itembgcolor);
		var4.bg.over = false;
		var4._y = var3;
		if(i.bEnabled)
		{
			var4.bg.onRelease = function()
			{
				ank.gapi.controls.PopupMenu.LAST_POPUP_VALIDATION = getTimer();
				i.fn.apply(i.obj,i.args);
				this._parent._parent._parent.remove();
			};
			var4.bg.onRollOver = function()
			{
				this._parent._parent._parent.onItemOver(this,true);
			};
			var4.bg.onRollOut = var4.bg.onReleaseOutside = function()
			{
				this._parent._parent._parent.onItemOut(this,true);
			};
		}
		else
		{
			var4.bg.onPress = function()
			{
			};
			var4.bg.useHandCursor = false;
			var var7 = new Color(var4.bg);
			if(i.bStatic)
			{
				var7.setRGB(this.getStyle().itemstaticbgcolor);
			}
			else
			{
				var7.setRGB(this.getStyle().itembgcolor);
			}
		}
		return {w:var5.textWidth,h:var6};
	}
	function arrangeItem(var2, var3)
	{
		var var4 = this._mcItems["item" + var2];
		var4._lbl.setSize(var3,ank.gapi.controls.PopupMenu.ITEM_HEIGHT);
		var4.bg._width = var3;
	}
	function layoutContent(var2, var3, var4, var5)
	{
		var var6 = this._aItems.length;
		var var7 = 0;
		var var8 = 0;
		var var9 = 0;
		while(var9 < this._aItems.length)
		{
			var var10 = this.drawItem(this._aItems[var9],var9,var8);
			var8 = var8 + var10.h;
			var7 = Math.max(var7,var10.w);
			var9 = var9 + 1;
		}
		this.setSize(var7 + 16,var8 + 4);
		var var11 = !var4?this.gapi.screenWidth:Stage.width;
		var var12 = !var4?this.gapi.screenHeight:Stage.height;
		if(var5 == true)
		{
			var2 = var2 - this.__width;
		}
		if(var2 > var11 - this.__width)
		{
			this._x = var11 - this.__width;
		}
		else if(var2 < 0)
		{
			this._x = 0;
		}
		else
		{
			this._x = var2;
		}
		if(var3 > var12 - this.__height)
		{
			this._y = var12 - this.__height;
		}
		else if(var3 < 0)
		{
			this._y = 0;
		}
		else
		{
			this._y = var3;
		}
	}
	function removePopupMenu()
	{
		this.remove();
	}
	function remove()
	{
		this._bRemoved = true;
		Mouse.removeListener(this);
		this.removeMovieClip();
	}
	function getEnabledItems()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < this._aItems.length)
		{
			var var4 = this._aItems[var3];
			if(var4.bStatic || !var4.bEnabled)
			{
				var2.push(undefined);
			}
			else
			{
				var2.push(var4);
			}
			var3 = var3 + 1;
		}
		return var2;
	}
	function selectFirstEnabled(var2)
	{
		if(var2 == undefined)
		{
			var2 = this.getEnabledItems();
		}
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			if(var4 == undefined)
			{
				var3 = var3 + 1;
				continue;
			}
			var var5 = this._mcItems["item" + var3];
			this.onItemOver(var5.bg);
			break;
		}
	}
	function selectLastEnabled(var2)
	{
		if(var2 == undefined)
		{
			var2 = this.getEnabledItems();
		}
		var var3 = var2.length - 1;
		while(var3 >= 0)
		{
			var var4 = var2[var3];
			if(var4 == undefined)
			{
				var3 = var3 - 1;
				continue;
			}
			var var5 = this._mcItems["item" + var3];
			this.onItemOver(var5.bg);
			break;
		}
	}
	function unselectAll()
	{
		var var2 = 0;
		while(var2 < this._aItems.length)
		{
			var var3 = this._mcItems["item" + var2];
			this.onItemOut(var3.bg);
			var2 = var2 + 1;
		}
	}
	function executeSelectedItem()
	{
		var var2 = 0;
		while(var2 < this._aItems.length)
		{
			var var3 = this._aItems[var2];
			var var4 = this._mcItems["item" + var2];
			if(!var4.bg.over)
			{
				var2 = var2 + 1;
				continue;
			}
			var3.fn.apply(var3.obj,var3.args);
			this.remove();
			return true;
		}
		return false;
	}
	function selectNextItem()
	{
		var var2 = this.getEnabledItems();
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			if(var4 != undefined)
			{
				var var5 = this._mcItems["item" + var3];
				if(var5.bg.over)
				{
					var var6 = var3 + 1;
					while(var6 < var2.length)
					{
						var var7 = var2[var6];
						if(var7 == undefined)
						{
							var6 = var6 + 1;
							continue;
						}
						var var8 = this._mcItems["item" + var6];
						this.onItemOver(var8.bg);
						return undefined;
					}
					break;
				}
			}
			var3 = var3 + 1;
		}
		this.selectFirstEnabled(var2);
	}
	function selectPreviousItem()
	{
		var var2 = this.getEnabledItems();
		var var3 = var2.length - 1;
		while(var3 >= 0)
		{
			var var4 = var2[var3];
			if(var4 != undefined)
			{
				var var5 = this._mcItems["item" + var3];
				if(var5.bg.over)
				{
					var var6 = var3 - 1;
					while(var6 >= 0)
					{
						var var7 = var2[var6];
						if(var7 == undefined)
						{
							var6 = var6 - 1;
							continue;
						}
						break;
					}
					break;
					var var8 = this._mcItems["item" + var6];
					this.onItemOver(var8.bg);
					return undefined;
				}
			}
			var3 = var3 - 1;
		}
		this.selectLastEnabled(var2);
	}
	function onItemOver(var2, var3)
	{
		if(var3)
		{
			this._bOver = true;
		}
		if(var2.over)
		{
			return undefined;
		}
		this.unselectAll();
		var2.over = true;
		var var4 = new Color(var2);
		var4.setRGB(this.getStyle().itemovercolor);
	}
	function onItemOut(var2, var3)
	{
		if(var3)
		{
			this._bOver = false;
		}
		if(!var2.over)
		{
			return undefined;
		}
		var2.over = false;
		var var4 = new Color(var2);
		var4.setRGB(this.getStyle().itembgcolor);
	}
	function onMouseUp()
	{
		if(!this._bOver && this._bCloseOnMouseUp)
		{
			this.remove();
		}
	}
}
