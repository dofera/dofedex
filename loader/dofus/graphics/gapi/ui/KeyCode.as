class dofus.graphics.gapi.ui.KeyCode extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "KeyCode";
	static var CODE_SLOT_WIDTH = 40;
	var _aKeyCode = new Array();
	var _nCurrentSelectedSlot = -1;
	function KeyCode()
	{
		super();
	}
	function __set__title(sTitle)
	{
		this.addToQueue({object:this,method:function()
		{
			this._winCode.title = sTitle;
		}});
		return this.__get__title();
	}
	function __set__changeType(§\x07\x1a§)
	{
		this._nChangeType = var2;
		return this.__get__changeType();
	}
	function __set__slotsCount(§\x1e\x1d\x12§)
	{
		if(var2 > 8)
		{
			ank.utils.Logger.err("[slotsCount] doit être au max 8");
			return undefined;
		}
		this._nSlotsCount = var2;
		this._aKeyCode = new Array();
		var var3 = 0;
		while(var3 < var2)
		{
			this._aKeyCode[var3] = "_";
			var3 = var3 + 1;
		}
		return this.__get__slotsCount();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.KeyCode.CLASS_NAME);
		this.gapi.getUIComponent("Banner").chatAutoFocus = false;
	}
	function destroy()
	{
		this.gapi.getUIComponent("Banner").chatAutoFocus = true;
	}
	function callClose()
	{
		this.api.network.Key.leave();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.drawCodeSlots();
		this.selectNextSlot();
		this._mcSlotPlacer._visible = false;
		this._btnNoCode._visible = false;
	}
	function addListeners()
	{
		var var2 = 0;
		while(var2 < 10)
		{
			var var3 = this["_ctrSymbol" + var2];
			var3.addEventListener("drag",this);
			var3.addEventListener("click",this);
			var3.addEventListener("dblClick",this);
			var3.params = {index:var2};
			var2 = var2 + 1;
		}
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this.api.kernel.KeyManager.addKeysListener("onKeys",this);
		this._btnValidate.addEventListener("click",this);
		this._btnNoCode.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
	}
	function initTexts()
	{
		switch(this._nChangeType)
		{
			case 0:
				this._btnValidate.label = this.api.lang.getText("UNLOCK");
				this._txtDescription.text = this.api.lang.getText("UNLOCK_INFOS");
				break;
			case 1:
				this._btnValidate.label = this.api.lang.getText("CHANGE");
				this._btnNoCode.label = this.api.lang.getText("NO_CODE");
				this._txtDescription.text = this.api.lang.getText("LOCK_INFOS");
		}
	}
	function initData()
	{
		var var2 = 0;
		while(var2 < 10)
		{
			this["_ctrSymbol" + var2].contentData = {iconFile:"UI_KeyCodeSymbol" + var2,value:String(var2)};
			var2 = var2 + 1;
		}
		switch(this._nChangeType)
		{
			case 0:
				this._btnNoCode._visible = false;
				break;
			case 1:
				this._btnNoCode._visible = true;
		}
	}
	function drawCodeSlots()
	{
		this._mcSlots.removeMovieClip();
		this.createEmptyMovieClip("_mcSlots",10);
		var var2 = 0;
		while(var2 < this._nSlotsCount)
		{
			var var3 = this._mcSlots.attachMovie("Container","_ctrCode" + var2,var2,{_x:var2 * dofus.graphics.gapi.ui.KeyCode.CODE_SLOT_WIDTH,backgroundRenderer:"UI_KeyCodeContainer",dragAndDrop:true,highlightRenderer:"UI_KeyCodeHighlight",styleName:"none",enabled:true,_width:30,_height:30});
			var3.addEventListener("drop",this);
			var3.addEventListener("drag",this);
			var3.params = {index:var2};
			var2 = var2 + 1;
		}
		this._mcSlots._x = this._mcSlotPlacer._x - this._mcSlots._width;
		this._mcSlots._y = this._mcSlotPlacer._y;
	}
	function selectPreviousSlot()
	{
		var var2 = this._nCurrentSelectedSlot;
		this._nCurrentSelectedSlot--;
		if(this._nCurrentSelectedSlot < 0)
		{
			this._nCurrentSelectedSlot = this._nSlotsCount - 1;
		}
		this.selectSlot(var2,this._nCurrentSelectedSlot);
	}
	function selectNextSlot()
	{
		var var2 = this._nCurrentSelectedSlot;
		this._nCurrentSelectedSlot = ++this._nCurrentSelectedSlot % this._nSlotsCount;
		this.selectSlot(var2,this._nCurrentSelectedSlot);
	}
	function selectSlot(§\x04\x02§, §\x1e\x1d\x13§)
	{
		var var4 = this._mcSlots["_ctrCode" + var2];
		var4.selected = false;
		this._mcSlots["_ctrCode" + var3].selected = true;
	}
	function setKeyInCurrentSlot(§\x04\n§)
	{
		var var3 = this._mcSlots["_ctrCode" + this._nCurrentSelectedSlot];
		var var4 = this["_ctrSymbol" + var2];
		var3.contentData = var4.contentData;
		this._aKeyCode[this._nCurrentSelectedSlot] = var2;
		this.selectNextSlot();
	}
	function validate()
	{
		var var2 = true;
		var var3 = 0;
		while(var3 < this._aKeyCode.length)
		{
			if(this._aKeyCode[var3] != "_")
			{
				var2 = false;
			}
			var3 = var3 + 1;
		}
		this.api.network.Key.sendKey(this._nChangeType,!var2?this._aKeyCode.join(""):"-");
	}
	function dblClick(§\x1e\x19\x18§)
	{
		this.click(var2);
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnNoCode":
				this.api.network.Key.sendKey(this._nChangeType,"-");
				break;
			case "_btnValidate":
				this.validate();
				break;
			case "_btnClose":
				this.callClose();
				break;
			default:
				this.setKeyInCurrentSlot(var2.target.params.index);
		}
	}
	function drop(§\x1e\x19\x18§)
	{
		var var3 = this.gapi.getCursor();
		if(var3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		var2.target.contentData = var3;
		this._aKeyCode[var2.target.params.index] = var3.value;
	}
	function drag(§\x1e\x19\x18§)
	{
		this.gapi.removeCursor();
		var var3 = var2.target.contentData;
		if(var3 == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(var3);
		if(var2.target._parent != this)
		{
			var2.target.contentData = undefined;
			this._aKeyCode[var2.target.params.index] = "_";
		}
	}
	function onShortcut(§\x1e\x0e\x04§)
	{
		if(Selection.getFocus() != null)
		{
			return true;
		}
		if(var2 == "CODE_CLEAR")
		{
			this.setKeyInCurrentSlot();
			return false;
		}
		if(var2 == "CODE_NEXT")
		{
			this.selectNextSlot();
			return false;
		}
		if(var2 == "CODE_PREVIOUS")
		{
			this.selectPreviousSlot();
			return false;
		}
		if(var2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.validate();
			return false;
		}
		return true;
	}
	function onKeys(§\x1e\x11\x10§)
	{
		if(Selection.getFocus() != null)
		{
			return undefined;
		}
		var var3 = var2.charCodeAt(0) - 48;
		if(var3 < 0 || var3 > 9)
		{
			return undefined;
		}
		this.setKeyInCurrentSlot(var3);
	}
}
