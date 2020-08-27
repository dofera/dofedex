class dofus.graphics.gapi.ui.Debug extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Debug";
	static var MIDDLE_SIZE = 200;
	static var BIG_SIZE = 370;
	var _nFileOutput = 0;
	function Debug()
	{
		super();
	}
	function __get__fileOutput()
	{
		return this._nFileOutput;
	}
	function __set__fileOutput(var2)
	{
		this._nFileOutput = var2;
		return this.__get__fileOutput();
	}
	function setPrompt(var2)
	{
		if(this._lblPrompt.text == undefined)
		{
			return undefined;
		}
		this._lblPrompt.text = var2 + " > ";
		this._tiCommandLine._x = this._lblPrompt._x + this._lblPrompt.textWidth + 2;
		this._lblPrompt.setPreferedSize("left");
	}
	function setLogsText(var2)
	{
		if(this._cLogs.text == undefined)
		{
			return undefined;
		}
		this._cLogs.text = var2;
	}
	function __set__command(var2)
	{
		this._sCommand = var2;
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
		if((var var0 = this.api.kernel.OptionsManager.getOption("DebugSizeIndex")) !== 0)
		{
			switch(null)
			{
				case 1:
					this.minimize();
					break;
				case 2:
					this.maximize(dofus.graphics.gapi.ui.Debug.BIG_SIZE);
			}
		}
		else
		{
			this.maximize(dofus.graphics.gapi.ui.Debug.MIDDLE_SIZE);
		}
		this.initFocus();
	}
	function minimize()
	{
		this._cLogs._visible = false;
		this._srLogsBack.setSize(undefined,20);
		this._srCommandLineBack._y = this._tiCommandLine._y = this._lblPrompt._y = this._cLogs._y;
	}
	function maximize(var2)
	{
		this._cLogs._visible = true;
		this._cLogs.setSize(undefined,var2);
		this._srLogsBack.setSize(undefined,var2 + 20);
		this._srCommandLineBack._y = this._tiCommandLine._y = this._lblPrompt._y = this._cLogs._y + var2;
	}
	function onShortcut(var2)
	{
		var var3 = true;
		switch(var2)
		{
			case "HISTORY_UP":
				this._tiCommandLine.text = this.api.kernel.DebugConsole.getHistoryUp().value;
				this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
				var3 = false;
				break;
			case "HISTORY_DOWN":
				this._tiCommandLine.text = this.api.kernel.DebugConsole.getHistoryDown().value;
				this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
				var3 = false;
				break;
			case "TEAM_MESSAGE":
				var var4 = this.api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
				var4 = var4 % 3;
				this.api.kernel.OptionsManager.setOption("DebugSizeIndex",var4);
				this.applySizeIndex();
				break;
			default:
				if(var0 !== "ACCEPT_CURRENT_DIALOG")
				{
					break;
				}
				if(this._tiCommandLine.focused)
				{
					var var5 = this._tiCommandLine.text;
					if(var5.length == 0)
					{
						return true;
					}
					if(this._tiCommandLine.text != undefined)
					{
						this._tiCommandLine.text = "";
					}
					this.api.kernel.DebugConsole.process(var5);
				}
				else
				{
					this._tiCommandLine.setFocus();
				}
				var3 = false;
				break;
		}
		return var3;
	}
	function click(var2)
	{
		switch(var2.target)
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
				this.changeSize();
		}
	}
	function changeSize()
	{
		var var2 = this.api.kernel.OptionsManager.getOption("DebugSizeIndex") + 1;
		var2 = var2 % 3;
		this.api.kernel.OptionsManager.setOption("DebugSizeIndex",var2);
		this.applySizeIndex();
	}
	function href(var2)
	{
		var var3 = var2.params.split(",");
		if((var var0 = var3[0]) !== "ShowPlayerPopupMenu")
		{
			if(var0 === "ExecCmd")
			{
				this._tiCommandLine.text = _global.unescape(var3[1]);
				if(var3[2] == "true" || var3[2] == true)
				{
					this._tiCommandLine.setFocus();
					this.onShortcut("ACCEPT_CURRENT_DIALOG");
				}
			}
		}
		else
		{
			this.api.kernel.GameManager.showPlayerPopupMenu(undefined,_global.unescape(var3[1]));
		}
	}
}
