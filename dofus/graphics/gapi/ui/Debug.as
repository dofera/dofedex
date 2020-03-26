class dofus.graphics.gapi.ui.Debug extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Debug";
   static var MIDDLE_SIZE = 200;
   static var BIG_SIZE = 370;
   function Debug()
   {
      super();
   }
   function setPrompt(sPrompt)
   {
      if(this._lblPrompt.text == undefined)
      {
         return undefined;
      }
      this._lblPrompt.text = sPrompt + " > ";
      this._tiCommandLine._x = this._lblPrompt._x + this._lblPrompt.textWidth + 2;
      this._lblPrompt.setPreferedSize("left");
   }
   function setLogsText(sLogs)
   {
      if(this._cLogs.text == undefined)
      {
         return undefined;
      }
      this._cLogs.text = sLogs;
   }
   function __set__command(sCommand)
   {
      this._sCommand = sCommand;
      if(this.initialized)
      {
         this.initCommand();
      }
      return this.__get__command();
   }
   function refresh()
   {
      this.initData();
   }
   function clear()
   {
      this.api.datacenter.Basics.aks_a_logs = "";
      this.setLogsText("");
   }
   function showFps()
   {
      if(this._fps == undefined)
      {
         this.attachMovie("Fps","_fps",this.getNextHighestDepth(),{_x:this._mcFpsPlacer._x,_y:this._mcFpsPlacer._y,_width:this._mcFpsPlacer._width,_height:this._mcFpsPlacer._height,styleName:"DofusFps"});
      }
      else
      {
         this._fps.removeMovieClip();
      }
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Debug.CLASS_NAME);
      this.gapi.getUIComponent("Banner").chatAutoFocus = false;
   }
   function destroy()
   {
      this.gapi.getUIComponent("Banner").chatAutoFocus = true;
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.applySizeIndex});
      this.addToQueue({object:this,method:this.initCommand});
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClear.addEventListener("click",this);
      this._btnCopy.addEventListener("click",this);
      this._btnMinimize.addEventListener("click",this);
      this._cLogs.addEventListener("href",this);
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function initFocus()
   {
      this._tiCommandLine.setFocus();
      this._cLogs.selectable = true;
   }
   function initData()
   {
      if(this._cLogs.text == undefined)
      {
         return undefined;
      }
      this._cLogs.text = this.api.datacenter.Basics.aks_a_logs;
      this.setPrompt(this.api.datacenter.Basics.aks_a_prompt);
   }
   function initCommand()
   {
      this._tiCommandLine.text = this._sCommand;
      this.initFocus();
      this.addToQueue({objet:this,method:this.placeCursorAtTheEnd});
   }
   function placeCursorAtTheEnd()
   {
      this._tiCommandLine.setFocus();
      Selection.setSelection(this._tiCommandLine.text.length,1000);
   }
   function applySizeIndex()
   {
      switch(this.api.kernel.OptionsManager.getOption("DebugSizeIndex"))
      {
         case 0:
            this.maximize(dofus.graphics.gapi.ui.Debug.MIDDLE_SIZE);
            break;
         case 1:
            this.minimize();
            break;
         case 2:
            this.maximize(dofus.graphics.gapi.ui.Debug.BIG_SIZE);
      }
      this.initFocus();
   }
   function minimize()
   {
      this._cLogs._visible = false;
      this._srLogsBack.setSize(undefined,20);
      this._srCommandLineBack._y = this._tiCommandLine._y = this._lblPrompt._y = this._cLogs._y;
   }
   function maximize(nHeight)
   {
      this._cLogs._visible = true;
      this._cLogs.setSize(undefined,nHeight);
      this._srLogsBack.setSize(undefined,nHeight + 20);
      this._srCommandLineBack._y = this._tiCommandLine._y = this._lblPrompt._y = this._cLogs._y + nHeight;
   }
   function onShortcut(sShortcut)
   {
      var _loc3_ = true;
      switch(sShortcut)
      {
         case "HISTORY_UP":
            this._tiCommandLine.text = this.api.kernel.DebugConsole.getHistoryUp().value;
            this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
            _loc3_ = false;
            break;
         case "HISTORY_DOWN":
            this._tiCommandLine.text = this.api.kernel.DebugConsole.getHistoryDown().value;
            this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
            _loc3_ = false;
            break;
         case "TEAM_MESSAGE":
            var _loc4_ = this.api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
            _loc4_ = _loc4_ % 3;
            this.api.kernel.OptionsManager.setOption("DebugSizeIndex",_loc4_);
            this.applySizeIndex();
            break;
         case "ACCEPT_CURRENT_DIALOG":
            if(this._tiCommandLine.focused)
            {
               var _loc5_ = this._tiCommandLine.text;
               if(_loc5_.length == 0)
               {
                  return true;
               }
               if(this._tiCommandLine.text != undefined)
               {
                  this._tiCommandLine.text = "";
               }
               this.api.kernel.DebugConsole.process(_loc5_);
            }
            else
            {
               this._tiCommandLine.setFocus();
            }
            _loc3_ = false;
      }
      return _loc3_;
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnClose:
            this.callClose();
            break;
         case this._btnClear:
            this.clear();
            break;
         case this._btnCopy:
            System.setClipboard(this._cLogs.text);
            break;
         case this._btnMinimize:
            var _loc3_ = this.api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
            _loc3_ = _loc3_ % 3;
            this.api.kernel.OptionsManager.setOption("DebugSizeIndex",_loc3_);
            this.applySizeIndex();
      }
   }
   function href(oEvent)
   {
      var _loc3_ = oEvent.params.split(",");
      switch(_loc3_[0])
      {
         case "ShowPlayerPopupMenu":
            this.api.kernel.GameManager.showPlayerPopupMenu(undefined,_loc3_[1]);
            break;
         case "ExecCmd":
            this._tiCommandLine.text = _loc3_[1].split("%2C").join(",");
            if(_loc3_[2] == "true" || _loc3_[2] == true)
            {
               this._tiCommandLine.setFocus();
               this.onShortcut("ACCEPT_CURRENT_DIALOG");
               break;
            }
      }
   }
}
