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
	function __set__api(loc2)
	{
		this._oAPI = loc2;
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
		this._eaUIComponentsInstances = new ank.utils.();
	}
	function setScreenSize(loc2, loc3)
	{
		this._nScreenWidth = loc2;
		this._nScreenHeight = loc3;
	}
	function createPopupMenu(loc2)
	{
		var loc3 = this.pmPopupMenu;
		if(loc2 == undefined)
		{
			loc2 = "BrownPopupMenu";
		}
		if(this.nPopupMenuCnt == undefined)
		{
			this.nPopupMenuCnt = 0;
		}
		var loc4 = this.nPopupMenuCnt++;
		this.pmPopupMenu = (ank.gapi.controls.PopupMenu)this._mcLayer_Popup.attachMovie("PopupMenu","_mcPopupMenu" + loc4,loc4,{styleName:loc2,gapi:this});
		loc3.removeMovieClip();
		return this.pmPopupMenu;
	}
	function removePopupMenu()
	{
		this.pmPopupMenu.removeMovieClip();
	}
	function showFixedTooltip(loc2, loc3, loc4, loc5, loc6)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(typeof loc3 == "movieclip")
		{
			var loc8 = loc3;
			var loc9 = {x:loc8._x,y:loc8._y};
			loc8._parent.localToGlobal(loc9);
			var loc7 = loc9.x;
			loc4 = loc4 + loc9.y;
		}
		else
		{
			loc7 = Number(loc3);
		}
		if(this._mcLayer_Popup["_mcToolTip" + loc6] != undefined)
		{
			var loc10 = this._mcLayer_Popup["_mcToolTip" + loc6];
			loc10.params = loc5;
			loc10.x = loc7;
			loc10.y = loc4;
			loc10.text = loc2;
		}
		else
		{
			this._mcLayer_Popup.attachMovie("ToolTip","_mcToolTip" + loc6,this._mcLayer_Popup.getNextHighestDepth(),{text:loc2,x:loc7,y:loc4,params:loc5,gapi:this});
		}
	}
	function showTooltip(loc2, loc3, loc4, loc5, loc6)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(typeof loc3 == "movieclip")
		{
			var loc8 = loc3;
			var loc9 = {x:loc8._x,y:loc8._y};
			loc8._parent.localToGlobal(loc9);
			this.globalToLocal(loc9);
			var loc7 = loc9.x;
			loc4 = loc4 + loc9.y;
		}
		else
		{
			loc7 = Number(loc3);
		}
		if(this._mcLayer_Popup._mcToolTip != undefined)
		{
			var loc10 = this._mcLayer_Popup._mcToolTip;
			loc10.params = loc5;
			loc10.x = loc7;
			loc10.y = loc4;
			loc10.text = loc2;
		}
		else
		{
			this._mcLayer_Popup.attachMovie("ToolTip","_mcToolTip",this._mcLayer_Popup.getNextHighestDepth(),{text:loc2,x:loc7,y:loc4,params:loc5,gapi:this,styleName:loc6});
		}
	}
	function hideTooltip()
	{
		this._mcLayer_Popup._mcToolTip.removeMovieClip();
	}
	function setCursor(loc2, loc3)
	{
		this._nLastSetCursorTimer = getTimer();
		this.removeCursor();
		if(loc3 == undefined)
		{
			loc3 = new Object();
		}
		loc3.width = loc3.width == undefined?ank.gapi.Gapi.CURSOR_MAX_SIZE:loc3.width;
		loc3.height = loc3.height == undefined?ank.gapi.Gapi.CURSOR_MAX_SIZE:loc3.height;
		loc3.x = loc3.x == undefined?ank.gapi.Gapi.CURSOR_CENTER[0]:loc3.x;
		loc3.y = loc3.y == undefined?ank.gapi.Gapi.CURSOR_CENTER[1]:loc3.y;
		var loc4 = (ank.gapi.controls.Container)this._mcLayer_Cursor.attachMovie("Container","cursor1",10);
		loc4.setSize(loc3.width,loc3.height);
		loc4.move(loc3.x,loc3.y);
		loc4.contentData = loc2;
		this._oCursorAligment = loc3;
		this._oCursorData = loc2;
		this._mcLayer_Cursor.startDrag(true);
	}
	function setCursorForbidden(loc2, loc3)
	{
		if(this.isCursorHidden())
		{
			return undefined;
		}
		if(loc2 == undefined)
		{
			loc2 = false;
		}
		if(loc2)
		{
			if(this._mcLayer_Cursor.mcForbidden == undefined)
			{
				var loc4 = this._mcLayer_Cursor.attachMovie("Loader","mcForbidden",20,{scaleContent:true});
				loc4.setSize(this._oCursorAligment.width,this._oCursorAligment.height);
				loc4.move(this._oCursorAligment.x,this._oCursorAligment.y);
				loc4.contentPath = loc3;
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
	function removeCursor(loc2)
	{
		this.hideCursor(loc2);
		if(this._oCursorData == undefined)
		{
			return false;
		}
		delete this._oCursorData;
		return true;
	}
	function hideCursor(loc2)
	{
		this.setCursorForbidden(false);
		this._mcLayer_Cursor.stopDrag();
		this._mcLayer_Cursor.cursor1.removeMovieClip();
		if(loc2 == true)
		{
			this.dispatchEvent({type:"removeCursor"});
		}
	}
	function unloadLastUIAutoHideComponent()
	{
		return this.unloadUIComponent(this._sLastAutoHideComponent);
	}
	function loadUIAutoHideComponent(loc2, loc3, loc4, loc5)
	{
		if(this._sLastAutoHideComponent != loc2)
		{
			this.unloadUIComponent(this._sLastAutoHideComponent);
		}
		this._sLastAutoHideComponent = loc2;
		return this.loadUIComponent(loc2,loc3,loc4,loc5);
	}
	function loadUIComponent(loc2, loc3, loc4, loc5)
	{
		if(loc5.bForceLoad == undefined)
		{
			var loc6 = false;
		}
		else
		{
			loc6 = loc5.bForceLoad;
		}
		if(loc5.bStayIfPresent == undefined)
		{
			var loc7 = false;
		}
		else
		{
			loc7 = loc5.bStayIfPresent;
		}
		if(loc5.bAlwaysOnTop == undefined)
		{
			var loc8 = false;
		}
		else
		{
			loc8 = loc5.bAlwaysOnTop;
		}
		if(loc5.bUltimateOnTop == undefined)
		{
			var loc9 = false;
		}
		else
		{
			loc9 = loc5.bUltimateOnTop;
		}
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			switch(loc2)
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
			loc2 = loc2 + "_DoubleFramerate";
		}
		if(loc2.substring(0,3) == "Ask")
		{
			loc9 = true;
		}
		if(this._oUIComponentsList[loc3] != undefined)
		{
			if(loc7)
			{
				var loc10 = this._oUIComponentsList[loc3];
				for(var k in loc4)
				{
					loc10[k] = loc4[k];
				}
				return null;
			}
			this.unloadUIComponent(loc3);
			if(!loc6)
			{
				return null;
			}
		}
		if(loc4 == undefined)
		{
			loc4 = new Object();
		}
		loc4.api = this._oAPI;
		loc4.gapi = this;
		loc4.instanceName = loc3;
		if(loc8)
		{
			var loc11 = this._mcLayer_UI_Top;
		}
		else if(loc9)
		{
			loc11 = this._mcLayer_UI_Ultimate;
		}
		else
		{
			loc11 = this._mcLayer_UI;
		}
		var loc12 = loc11.attachMovie("UI_" + loc2,loc3,loc11.getNextHighestDepth(),loc4);
		this._oUIComponentsList[loc3] = loc12;
		this._eaUIComponentsInstances.push({name:loc3});
		return loc12;
	}
	function unloadUIComponent(loc2)
	{
		var loc3 = this.getUIComponent(loc2);
		delete this._oUIComponentsList.register2;
		var loc4 = this._eaUIComponentsInstances.findFirstItem("name",loc2);
		if(loc4.index != -1)
		{
			this._eaUIComponentsInstances.removeItems(loc4.index,1);
		}
		if(loc3 == undefined)
		{
			return false;
		}
		loc3.destroy();
		Key.removeListener(loc3);
		this.api.kernel.KeyManager.removeShortcutsListener(loc3);
		this.api.kernel.KeyManager.removeKeysListener(loc3);
		loc3.removeMovieClip();
		return true;
	}
	function getUIComponent(loc2)
	{
		var loc3 = this._mcLayer_UI[loc2];
		if(loc3 == undefined)
		{
			loc3 = this._mcLayer_UI_Top[loc2];
		}
		if(loc3 == undefined)
		{
			loc3 = this._mcLayer_UI_Ultimate[loc2];
		}
		if(loc3 == undefined)
		{
			return null;
		}
		return loc3;
	}
	function callCloseOnLastUI(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = this._eaUIComponentsInstances.length - 1;
		}
		if(loc2 < 0)
		{
			return false;
		}
		if(_global.isNaN(loc2))
		{
			return false;
		}
		var loc3 = this.getUIComponent(this._eaUIComponentsInstances[loc2].name);
		if(loc3.callClose() == true)
		{
			return true;
		}
		return this.callCloseOnLastUI(loc2 - 1);
	}
	function initialize()
	{
		this.clear();
		ank.gapi.styles.StylesManager.loadStylePackage(ank.gapi.styles.DefaultStylePackage);
		eval("\n\x0b").events.EventDispatcher.initialize(this);
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
		var loc2 = getTimer() - this._nLastSetCursorTimer;
		if(_global.isNaN(loc2))
		{
			return undefined;
		}
		if(loc2 < ank.gapi.Gapi.MAX_DELAY_CURSOR)
		{
			return undefined;
		}
		this.hideCursor(true);
	}
}
