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
      this._eaUIComponentsInstances = new ank.utils.ExtendedArray();
   }
   function setScreenSize(nWidth, nHeight)
   {
      this._nScreenWidth = nWidth;
      this._nScreenHeight = nHeight;
   }
   function createPopupMenu(sStyleName)
   {
      var _loc3_ = this.pmPopupMenu;
      if(sStyleName == undefined)
      {
         sStyleName = "BrownPopupMenu";
      }
      if(this.nPopupMenuCnt == undefined)
      {
         this.nPopupMenuCnt = 0;
      }
      this.nPopupMenuCnt = this.nPopupMenuCnt + 1;
      var _loc4_ = this.nPopupMenuCnt;
      this.pmPopupMenu = (ank.gapi.controls.PopupMenu)this._mcLayer_Popup.attachMovie("PopupMenu","_mcPopupMenu" + _loc4_,_loc4_,{styleName:sStyleName,gapi:this});
      _loc3_.removeMovieClip();
      return this.pmPopupMenu;
   }
   function removePopupMenu()
   {
      this.pmPopupMenu.removeMovieClip();
   }
   function showFixedTooltip(sText, xORmc, y, oParams, sName)
   {
      if(sText == undefined)
      {
         return undefined;
      }
      if(typeof xORmc == "movieclip")
      {
         var _loc8_ = xORmc;
         var _loc9_ = {x:_loc8_._x,y:_loc8_._y};
         _loc8_._parent.localToGlobal(_loc9_);
         var _loc7_ = _loc9_.x;
         y = y + _loc9_.y;
      }
      else
      {
         _loc7_ = Number(xORmc);
      }
      if(this._mcLayer_Popup["_mcToolTip" + sName] != undefined)
      {
         var _loc10_ = this._mcLayer_Popup["_mcToolTip" + sName];
         _loc10_.params = oParams;
         _loc10_.x = _loc7_;
         _loc10_.y = y;
         _loc10_.text = sText;
      }
      else
      {
         this._mcLayer_Popup.attachMovie("ToolTip","_mcToolTip" + sName,this._mcLayer_Popup.getNextHighestDepth(),{text:sText,x:_loc7_,y:y,params:oParams,gapi:this});
      }
   }
   function showTooltip(sText, xORmc, y, oParams, sStyleName)
   {
      if(sText == undefined)
      {
         return undefined;
      }
      if(typeof xORmc == "movieclip")
      {
         var _loc8_ = xORmc;
         var _loc9_ = {x:_loc8_._x,y:_loc8_._y};
         _loc8_._parent.localToGlobal(_loc9_);
         this.globalToLocal(_loc9_);
         var _loc7_ = _loc9_.x;
         y = y + _loc9_.y;
      }
      else
      {
         _loc7_ = Number(xORmc);
      }
      if(this._mcLayer_Popup._mcToolTip != undefined)
      {
         var _loc10_ = this._mcLayer_Popup._mcToolTip;
         _loc10_.params = oParams;
         _loc10_.x = _loc7_;
         _loc10_.y = y;
         _loc10_.text = sText;
      }
      else
      {
         this._mcLayer_Popup.attachMovie("ToolTip","_mcToolTip",this._mcLayer_Popup.getNextHighestDepth(),{text:sText,x:_loc7_,y:y,params:oParams,gapi:this,styleName:sStyleName});
      }
   }
   function hideTooltip()
   {
      this._mcLayer_Popup._mcToolTip.removeMovieClip();
   }
   function setCursor(oData, oAlignment)
   {
      this._nLastSetCursorTimer = getTimer();
      this.removeCursor();
      if(oAlignment == undefined)
      {
         oAlignment = new Object();
      }
      oAlignment.width = oAlignment.width == undefined?ank.gapi.Gapi.CURSOR_MAX_SIZE:oAlignment.width;
      oAlignment.height = oAlignment.height == undefined?ank.gapi.Gapi.CURSOR_MAX_SIZE:oAlignment.height;
      oAlignment.x = oAlignment.x == undefined?ank.gapi.Gapi.CURSOR_CENTER[0]:oAlignment.x;
      oAlignment.y = oAlignment.y == undefined?ank.gapi.Gapi.CURSOR_CENTER[1]:oAlignment.y;
      var _loc4_ = (ank.gapi.controls.Container)this._mcLayer_Cursor.attachMovie("Container","cursor1",10);
      _loc4_.setSize(oAlignment.width,oAlignment.height);
      _loc4_.move(oAlignment.x,oAlignment.y);
      _loc4_.contentData = oData;
      this._oCursorAligment = oAlignment;
      this._oCursorData = oData;
      this._mcLayer_Cursor.startDrag(true);
   }
   function setCursorForbidden(bForbidden, sCursorFile)
   {
      if(this.isCursorHidden())
      {
         return undefined;
      }
      if(bForbidden == undefined)
      {
         bForbidden = false;
      }
      if(bForbidden)
      {
         if(this._mcLayer_Cursor.mcForbidden == undefined)
         {
            var _loc4_ = this._mcLayer_Cursor.attachMovie("Loader","mcForbidden",20,{scaleContent:true});
            _loc4_.setSize(this._oCursorAligment.width,this._oCursorAligment.height);
            _loc4_.move(this._oCursorAligment.x,this._oCursorAligment.y);
            _loc4_.contentPath = sCursorFile;
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
   function removeCursor(bDispatchEvent)
   {
      this.hideCursor(bDispatchEvent);
      if(this._oCursorData == undefined)
      {
         return false;
      }
      delete this._oCursorData;
      return true;
   }
   function hideCursor(bDispatchEvent)
   {
      this.setCursorForbidden(false);
      this._mcLayer_Cursor.stopDrag();
      this._mcLayer_Cursor.cursor1.removeMovieClip();
      if(bDispatchEvent == true)
      {
         this.dispatchEvent({type:"removeCursor"});
      }
   }
   function unloadLastUIAutoHideComponent()
   {
      return this.unloadUIComponent(this._sLastAutoHideComponent);
   }
   function loadUIAutoHideComponent(sLink, sInstanceName, oComponentParams, oUIParams)
   {
      if(this._sLastAutoHideComponent != sLink)
      {
         this.unloadUIComponent(this._sLastAutoHideComponent);
      }
      this._sLastAutoHideComponent = sLink;
      return this.loadUIComponent(sLink,sInstanceName,oComponentParams,oUIParams);
   }
   function loadUIComponent(sLink, sInstanceName, oComponentParams, oUIParams)
   {
      if(oUIParams.bForceLoad == undefined)
      {
         var _loc6_ = false;
      }
      else
      {
         _loc6_ = oUIParams.bForceLoad;
      }
      if(oUIParams.bStayIfPresent == undefined)
      {
         var _loc7_ = false;
      }
      else
      {
         _loc7_ = oUIParams.bStayIfPresent;
      }
      if(oUIParams.bAlwaysOnTop == undefined)
      {
         var _loc8_ = false;
      }
      else
      {
         _loc8_ = oUIParams.bAlwaysOnTop;
      }
      if(oUIParams.bUltimateOnTop == undefined)
      {
         var _loc9_ = false;
      }
      else
      {
         _loc9_ = oUIParams.bUltimateOnTop;
      }
      if(_global.doubleFramerate)
      {
         switch(sLink)
         {
            case "AutomaticServer":
            case "BigStoreBuy":
            case "JoinFriend":
            case "StringCourse":
            case "Waiting":
            case "AskGameBegin":
            case "Login":
               sLink = sLink + "_DoubleFramerate";
         }
      }
      if(sLink.substring(0,3) == "Ask")
      {
         _loc9_ = true;
      }
      if(this._oUIComponentsList[sInstanceName] != undefined)
      {
         if(_loc7_)
         {
            var _loc10_ = this._oUIComponentsList[sInstanceName];
            for(var k in oComponentParams)
            {
               _loc10_[k] = oComponentParams[k];
            }
            return null;
         }
         this.unloadUIComponent(sInstanceName);
         if(!_loc6_)
         {
            return null;
         }
      }
      if(oComponentParams == undefined)
      {
         oComponentParams = new Object();
      }
      oComponentParams.api = this._oAPI;
      oComponentParams.gapi = this;
      oComponentParams.instanceName = sInstanceName;
      if(_loc8_)
      {
         var _loc11_ = this._mcLayer_UI_Top;
      }
      else if(_loc9_)
      {
         _loc11_ = this._mcLayer_UI_Ultimate;
      }
      else
      {
         _loc11_ = this._mcLayer_UI;
      }
      var _loc12_ = _loc11_.attachMovie("UI_" + sLink,sInstanceName,_loc11_.getNextHighestDepth(),oComponentParams);
      this._oUIComponentsList[sInstanceName] = _loc12_;
      this._eaUIComponentsInstances.push({name:sInstanceName});
      return _loc12_;
   }
   function unloadUIComponent(sInstanceName)
   {
      var _loc3_ = this.getUIComponent(sInstanceName);
      delete this._oUIComponentsList.sInstanceName;
      var _loc4_ = this._eaUIComponentsInstances.findFirstItem("name",sInstanceName);
      if(_loc4_.index != -1)
      {
         this._eaUIComponentsInstances.removeItems(_loc4_.index,1);
      }
      if(_loc3_ == undefined)
      {
         return false;
      }
      _loc3_.destroy();
      Key.removeListener(_loc3_);
      this.api.kernel.KeyManager.removeShortcutsListener(_loc3_);
      this.api.kernel.KeyManager.removeKeysListener(_loc3_);
      _loc3_.removeMovieClip();
      return true;
   }
   function getUIComponent(sInstanceName)
   {
      var _loc3_ = this._mcLayer_UI[sInstanceName];
      if(_loc3_ == undefined)
      {
         _loc3_ = this._mcLayer_UI_Top[sInstanceName];
      }
      if(_loc3_ == undefined)
      {
         _loc3_ = this._mcLayer_UI_Ultimate[sInstanceName];
      }
      if(_loc3_ == undefined)
      {
         return null;
      }
      return _loc3_;
   }
   function callCloseOnLastUI(nIndex)
   {
      if(nIndex == undefined)
      {
         nIndex = this._eaUIComponentsInstances.length - 1;
      }
      if(nIndex < 0)
      {
         return false;
      }
      if(_global.isNaN(nIndex))
      {
         return false;
      }
      var _loc3_ = this.getUIComponent(this._eaUIComponentsInstances[nIndex].name);
      if(_loc3_.callClose() == true)
      {
         return true;
      }
      return this.callCloseOnLastUI(nIndex - 1);
   }
   function initialize()
   {
      this.clear();
      ank.gapi.styles.StylesManager.loadStylePackage(ank.gapi.styles.DefaultStylePackage);
      mx.events.EventDispatcher.initialize(this);
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
      var _loc2_ = getTimer() - this._nLastSetCursorTimer;
      if(_global.isNaN(_loc2_))
      {
         return undefined;
      }
      if(_loc2_ < ank.gapi.Gapi.MAX_DELAY_CURSOR)
      {
         return undefined;
      }
      this.hideCursor(true);
   }
}
