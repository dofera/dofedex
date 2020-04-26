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
	function __set__changeType(loc2)
	{
		this._nChangeType = loc2;
		return this.__get__changeType();
	}
	function __set__slotsCount(loc2)
	{
		if(loc2 > 8)
		{
			ank.utils.Logger.err("[slotsCount] doit être au max 8");
			return undefined;
		}
		this._nSlotsCount = loc2;
		this._aKeyCode = new Array();
		var loc3 = 0;
		while(loc3 < loc2)
		{
			this._aKeyCode[loc3] = "_";
			loc3 = loc3 + 1;
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
		var loc2 = 0;
		while(loc2 < 10)
		{
			var loc3 = this["_ctrSymbol" + loc2];
			loc3.addEventListener("drag",this);
			loc3.addEventListener("click",this);
			loc3.addEventListener("dblClick",this);
			loc3.params = {index:loc2};
			loc2 = loc2 + 1;
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
		var loc2 = 0;
		while(loc2 < 10)
		{
			this["_ctrSymbol" + loc2].contentData = {iconFile:"UI_KeyCodeSymbol" + loc2,value:String(loc2)};
			loc2 = loc2 + 1;
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
		var loc2 = 0;
		while(loc2 < this._nSlotsCount)
		{
			var loc3 = this._mcSlots.attachMovie("Container","_ctrCode" + loc2,loc2,{_x:loc2 * dofus.graphics.gapi.ui.KeyCode.CODE_SLOT_WIDTH,backgroundRenderer:"UI_KeyCodeContainer",dragAndDrop:true,highlightRenderer:"UI_KeyCodeHighlight",styleName:"none",enabled:true,_width:30,_height:30});
			loc3.addEventListener("drop",this);
			loc3.addEventListener("drag",this);
			loc3.params = {index:loc2};
			loc2 = loc2 + 1;
		}
		this._mcSlots._x = this._mcSlotPlacer._x - this._mcSlots._width;
		this._mcSlots._y = this._mcSlotPlacer._y;
	}
	function selectPreviousSlot()
	{
		var loc2 = this._nCurrentSelectedSlot;
		this._nCurrentSelectedSlot--;
		if(this._nCurrentSelectedSlot < 0)
		{
			this._nCurrentSelectedSlot = this._nSlotsCount - 1;
		}
		this.selectSlot(loc2,this._nCurrentSelectedSlot);
	}
	function selectNextSlot()
	{
		var loc2 = this._nCurrentSelectedSlot;
		this._nCurrentSelectedSlot = ++this._nCurrentSelectedSlot % this._nSlotsCount;
		this.selectSlot(loc2,this._nCurrentSelectedSlot);
	}
	function selectSlot(loc2, loc3)
	{
		var loc4 = this._mcSlots["_ctrCode" + loc2];
		loc4.selected = false;
		this._mcSlots["_ctrCode" + loc3].selected = true;
	}
	function setKeyInCurrentSlot(loc2)
	{
		var loc3 = this._mcSlots["_ctrCode" + this._nCurrentSelectedSlot];
		var loc4 = this["_ctrSymbol" + loc2];
		loc3.contentData = loc4.contentData;
		this._aKeyCode[this._nCurrentSelectedSlot] = loc2;
		this.selectNextSlot();
	}
	function validate()
	{
		var loc2 = true;
		var loc3 = 0;
		while(loc3 < this._aKeyCode.length)
		{
			if(this._aKeyCode[loc3] != "_")
			{
				loc2 = false;
			}
			loc3 = loc3 + 1;
		}
		this.api.network.Key.sendKey(this._nChangeType,!loc2?this._aKeyCode.join(""):"-");
	}
	function dblClick(loc2)
	{
		this.click(loc2);
	}
	function click(loc2)
	{
		switch(loc2.target._name)
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
				this.setKeyInCurrentSlot(loc2.target.params.index);
		}
	}
	function drop(loc2)
	{
		var loc3 = this.gapi.getCursor();
		if(loc3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		loc2.target.contentData = loc3;
		this._aKeyCode[loc2.target.params.index] = loc3.value;
	}
	function drag(loc2)
	{
		this.gapi.removeCursor();
		var loc3 = loc2.target.contentData;
		if(loc3 == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(loc3);
		if(loc2.target._parent != this)
		{
			loc2.target.contentData = undefined;
			this._aKeyCode[loc2.target.params.index] = "_";
		}
	}
	function onShortcut(loc2)
	{
		if(Selection.getFocus() != null)
		{
			return true;
		}
		if(loc2 == "CODE_CLEAR")
		{
			this.setKeyInCurrentSlot();
			return false;
		}
		if(loc2 == "CODE_NEXT")
		{
			this.selectNextSlot();
			return false;
		}
		if(loc2 == "CODE_PREVIOUS")
		{
			this.selectPreviousSlot();
			return false;
		}
		if(loc2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.validate();
			return false;
		}
		return true;
	}
	function onKeys(loc2)
	{
		if(Selection.getFocus() != null)
		{
			return undefined;
		}
		var loc3 = loc2.charCodeAt(0) - 48;
		if(loc3 < 0 || loc3 > 9)
		{
			return undefined;
		}
		this.setKeyInCurrentSlot(loc3);
	}
}
