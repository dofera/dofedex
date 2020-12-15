class ank.gapi.Gapi extends ank.utils.QueueEmbedMovieClip
{
	static var MAX_DELAY_CURSOR = 250;
	static var CURSOR_MAX_SIZE = 40;
	static var CURSOR_CENTER = [-20,-20];
	static var DBLCLICK_DELAY = 250;
	var _oDragClipsList = null;
	var _oCursorData = null;
	var _oCursorAligment = null;
	function Gapi()
	{
		super();
		this.initialize();
	}
	function __get__currentPopupMenu()
	{
		return this.pmPopupMenu;
	}
	function __set__api(oAPI)
	{
		this._oAPI = oAPI;
		return this.__get__api();
	}
	function __get__api()
	{
		return this._oAPI;
	}
	function __get__screenWidth()
	{
		return this._nScreenWidth != undefined?this._nScreenWidth:Stage.width;
	}
	function __get__screenHeight()
	{
		return this._nScreenHeight != undefined?this._nScreenHeight:Stage.height;
	}
	function clear()
	{
		this.createEmptyMovieClip("_mcLayer_UI",10).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/UI"];
		this.createEmptyMovieClip("_mcLayer_UI_Top",20).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/UITop"];
		this.createEmptyMovieClip("_mcLayer_UI_Ultimate",30).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/UIUltimate"];
		this.createEmptyMovieClip("_mcLayer_Popup",40).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/Popup"];
		this.createEmptyMovieClip("_mcLayer_Cursor",50).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/Cursor"];
		this._oUIComponentsList = new Object();
		this._eaUIComponentsInstances = new ank.utils.();
	}
	function setScreenSize(var2, var3)
	{
		this._nScreenWidth = var2;
		this._nScreenHeight = var3;
	}
	function createPopupMenu(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		var var4 = this.pmPopupMenu;
		if(var2 == undefined)
		{
			var2 = "BrownPopupMenu";
		}
		if(this.nPopupMenuCnt == undefined)
		{
			this.nPopupMenuCnt = 0;
		}
		var var5 = this.nPopupMenuCnt++;
		this.pmPopupMenu = (ank.gapi.controls.PopupMenu)this._mcLayer_Popup.attachMovie("PopupMenu","_mcPopupMenu" + var5,var5,{styleName:var2,gapi:this});
		var4.removeMovieClip();
		this.pmPopupMenu.adminPopupMenu = var3;
		return this.pmPopupMenu;
	}
	function removePopupMenu()
	{
		this.pmPopupMenu.removeMovieClip();
	}
	function showFixedTooltip(var2, var3, var4, var5, var6)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		if(typeof var3 == "movieclip")
		{
			var var8 = var3;
			var var9 = {x:var8._x,y:var8._y};
			var8._parent.localToGlobal(var9);
			var var7 = var9.x;
			var4 = var4 + var9.y;
		}
		else
		{
			var7 = Number(var3);
		}
		if(this._mcLayer_Popup["_mcToolTip" + var6] != undefined)
		{
			var var10 = this._mcLayer_Popup["_mcToolTip" + var6];
			var10.params = var5;
			var10.x = var7;
			var10.y = var4;
			var10.text = var2;
		}
		else
		{
			this._mcLayer_Popup.attachMovie("ToolTip","_mcToolTip" + var6,this._mcLayer_Popup.getNextHighestDepth(),{text:var2,x:var7,y:var4,params:var5,gapi:this});
		}
	}
	function showTooltip(var2, var3, var4, var5, var6)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		if(typeof var3 == "movieclip")
		{
			var var8 = var3;
			var var9 = {x:var8._x,y:var8._y};
			var8._parent.localToGlobal(var9);
			this.globalToLocal(var9);
			var var7 = var9.x;
			var4 = var4 + var9.y;
		}
		else
		{
			var7 = Number(var3);
		}
		if(this._mcLayer_Popup._mcToolTip != undefined)
		{
			var var10 = this._mcLayer_Popup._mcToolTip;
			var10.params = var5;
			var10.x = var7;
			var10.y = var4;
			var10.text = var2;
		}
		else
		{
			this._mcLayer_Popup.attachMovie("ToolTip","_mcToolTip",this._mcLayer_Popup.getNextHighestDepth(),{text:var2,x:var7,y:var4,params:var5,gapi:this,styleName:var6});
		}
	}
	function hideTooltip()
	{
		this._mcLayer_Popup._mcToolTip.removeMovieClip();
	}
	function onContentLoaded(var2)
	{
		if(!dofus.Constants.DOUBLEFRAMERATE)
		{
			return undefined;
		}
		var var3 = var2.content;
		var var4 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
		var3.gotoAndStop(var4);
	}
	function setCursor(var2, var3, var4)
	{
		if(var4 == undefined)
		{
			var4 = false;
		}
		this._nLastSetCursorTimer = getTimer();
		this.removeCursor();
		if(var3 == undefined)
		{
			var3 = new Object();
		}
		var3.width = var3.width == undefined?ank.gapi.Gapi.CURSOR_MAX_SIZE:var3.width;
		var3.height = var3.height == undefined?ank.gapi.Gapi.CURSOR_MAX_SIZE:var3.height;
		var3.x = var3.x == undefined?ank.gapi.Gapi.CURSOR_CENTER[0]:var3.x;
		var3.y = var3.y == undefined?ank.gapi.Gapi.CURSOR_CENTER[1]:var3.y;
		var var5 = (ank.gapi.controls.Container)this._mcLayer_Cursor.attachMovie("Container","cursor1",10);
		if(var4)
		{
			var5.addEventListener("onContentLoaded",this);
		}
		var5.setSize(var3.width,var3.height);
		var5.move(var3.x,var3.y);
		var5.contentData = var2;
		this._oCursorAligment = var3;
		this._oCursorData = var2;
		this._mcLayer_Cursor.startDrag(true);
	}
	function setCursorForbidden(var2, var3)
	{
		if(this.isCursorHidden())
		{
			return undefined;
		}
		if(var2 == undefined)
		{
			var2 = false;
		}
		if(var2)
		{
			if(this._mcLayer_Cursor.mcForbidden == undefined)
			{
				var var4 = this._mcLayer_Cursor.attachMovie("Loader","mcForbidden",20,{scaleContent:true});
				var4.setSize(this._oCursorAligment.width,this._oCursorAligment.height);
				var4.move(this._oCursorAligment.x,this._oCursorAligment.y);
				var4.contentPath = var3;
			}
		}
		else
		{
			this._mcLayer_Cursor.mcForbidden.removeMovieClip();
		}
	}
	function getCursor()
	{
		return this._oCursorData;
	}
	function isCursorHidden()
	{
		return this._mcLayer_Cursor.cursor1 == undefined;
	}
	function removeCursor(var2)
	{
		this.hideCursor(var2);
		if(this._oCursorData == undefined)
		{
			return false;
		}
		delete this._oCursorData;
		return true;
	}
	function hideCursor(var2)
	{
		this.setCursorForbidden(false);
		this._mcLayer_Cursor.stopDrag();
		this._mcLayer_Cursor.cursor1.removeMovieClip();
		if(var2 == true)
		{
			this.dispatchEvent({type:"removeCursor"});
		}
	}
	function unloadLastUIAutoHideComponent()
	{
		return this.unloadUIComponent(this._sLastAutoHideComponent);
	}
	function loadUIAutoHideComponent(var2, var3, var4, var5)
	{
		if(this._sLastAutoHideComponent != var2)
		{
			this.unloadUIComponent(this._sLastAutoHideComponent);
		}
		this._sLastAutoHideComponent = var2;
		return this.loadUIComponent(var2,var3,var4,var5);
	}
	function loadUIComponent(var2, var3, var4, var5)
	{
		if(var5.bForceLoad == undefined)
		{
			var var6 = false;
		}
		else
		{
			var6 = var5.bForceLoad;
		}
		if(var5.bStayIfPresent == undefined)
		{
			var var7 = false;
		}
		else
		{
			var7 = var5.bStayIfPresent;
		}
		if(var5.bAlwaysOnTop == undefined)
		{
			var var8 = false;
		}
		else
		{
			var8 = var5.bAlwaysOnTop;
		}
		if(var5.bUltimateOnTop == undefined)
		{
			var var9 = false;
		}
		else
		{
			var9 = var5.bUltimateOnTop;
		}
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			switch(var2)
			{
				default:
					switch(null)
					{
						case "Waiting":
						case "AskGameBegin":
						case "Login":
						case "Inventory":
					}
				case "AutomaticServer":
				case "BigStoreBuy":
				case "JoinFriend":
				case "StringCourse":
			}
			var2 = var2 + "_DoubleFramerate";
		}
		if(var2.substring(0,3) == "Ask")
		{
			var9 = true;
		}
		if(this._oUIComponentsList[var3] != undefined)
		{
			if(var7)
			{
				var var10 = this._oUIComponentsList[var3];
				for(var k in var4)
				{
					var10[k] = var4[k];
				}
				return null;
			}
			this.unloadUIComponent(var3);
			if(!var6)
			{
				return null;
			}
		}
		if(var4 == undefined)
		{
			var4 = new Object();
		}
		var4.api = this._oAPI;
		var4.gapi = this;
		var4.instanceName = var3;
		if(var8)
		{
			var var11 = this._mcLayer_UI_Top;
		}
		else if(var9)
		{
			var11 = this._mcLayer_UI_Ultimate;
		}
		else
		{
			var11 = this._mcLayer_UI;
		}
		var var12 = var11.attachMovie("UI_" + var2,var3,var11.getNextHighestDepth(),var4);
		this._oUIComponentsList[var3] = var12;
		this._eaUIComponentsInstances.push({name:var3});
		return var12;
	}
	function unloadUIComponent(var2)
	{
		var var3 = this.getUIComponent(var2);
		delete this._oUIComponentsList.register2;
		var var4 = this._eaUIComponentsInstances.findFirstItem("name",var2);
		if(var4.index != -1)
		{
			this._eaUIComponentsInstances.removeItems(var4.index,1);
		}
		if(var3 == undefined)
		{
			return false;
		}
		var3.destroy();
		Key.removeListener(var3);
		this.api.kernel.KeyManager.removeShortcutsListener(var3);
		this.api.kernel.KeyManager.removeKeysListener(var3);
		var3.removeMovieClip();
		return true;
	}
	function getUIComponent(var2)
	{
		var var3 = this._mcLayer_UI[var2];
		if(var3 == undefined)
		{
			var3 = this._mcLayer_UI_Top[var2];
		}
		if(var3 == undefined)
		{
			var3 = this._mcLayer_UI_Ultimate[var2];
		}
		if(var3 == undefined)
		{
			return null;
		}
		return var3;
	}
	function callCloseOnLastUI(var2)
	{
		if(var2 == undefined)
		{
			var2 = this._eaUIComponentsInstances.length - 1;
		}
		if(var2 < 0)
		{
			return false;
		}
		if(_global.isNaN(var2))
		{
			return false;
		}
		var var3 = this.getUIComponent(this._eaUIComponentsInstances[var2].name);
		if(var3.callClose() == true)
		{
			return true;
		}
		return this.callCloseOnLastUI(var2 - 1);
	}
	function initialize()
	{
		this.clear();
		ank.gapi.styles.StylesManager.loadStylePackage(ank.gapi.styles.DefaultStylePackage);
		eval(mx).events.EventDispatcher.initialize(this);
	}
	function addDragClip()
	{
	}
	function removeDragClip()
	{
	}
	function onMouseUp()
	{
		if(this._oCursorData == undefined)
		{
			return undefined;
		}
		var var2 = getTimer() - this._nLastSetCursorTimer;
		if(_global.isNaN(var2))
		{
			return undefined;
		}
		if(var2 < ank.gapi.Gapi.MAX_DELAY_CURSOR)
		{
			return undefined;
		}
		this.hideCursor(true);
	}
}
