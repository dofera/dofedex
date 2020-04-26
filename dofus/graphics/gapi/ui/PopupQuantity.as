class dofus.graphics.gapi.ui.PopupQuantity extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PopupQuantity";
	var _nValue = 0;
	var _bUseAllStage = false;
	var _nMax = 1;
	var _nMin = 1;
	function PopupQuantity()
	{
		super();
	}
	function __set__value(loc2)
	{
		this._nValue = loc2;
		return this.__get__value();
	}
	function __set__max(loc2)
	{
		this._nMax = loc2;
		return this.__get__max();
	}
	function __set__min(loc2)
	{
		this._nMin = loc2;
		return this.__get__min();
	}
	function __set__useAllStage(loc2)
	{
		this._bUseAllStage = loc2;
		return this.__get__useAllStage();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.PopupQuantity.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._winBackground.addEventListener("complete",this);
		this._bgHidder.addEventListener("click",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function initWindowContent()
	{
		var loc2 = this._winBackground.content;
		loc2._btnOk.addEventListener("click",this);
		loc2._btnMax.addEventListener("click",this);
		loc2._btnMin.addEventListener("click",this);
		loc2._btnMax.label = this.api.lang.getText("MAX_WORD");
		loc2._btnMin.label = this.api.lang.getText("MIN_WORD");
		loc2._tiInput.restrict = "0-9";
		loc2._tiInput.text = this._nValue;
		loc2._tiInput.setFocus();
	}
	function placeWindow()
	{
		var loc2 = this._xmouse - this._winBackground.width;
		var loc3 = this._ymouse - this._winBackground._height;
		var loc4 = !this._bUseAllStage?this.gapi.screenWidth:Stage.width;
		var loc5 = !this._bUseAllStage?this.gapi.screenHeight:Stage.height;
		if(loc2 < 0)
		{
			loc2 = 0;
		}
		if(loc3 < 0)
		{
			loc3 = 0;
		}
		if(loc2 > loc4 - this._winBackground.width)
		{
			loc2 = loc4 - this._winBackground.width;
		}
		if(loc3 > loc5 - this._winBackground.height)
		{
			loc3 = loc5 - this._winBackground.height;
		}
		this._winBackground._x = loc2;
		this._winBackground._y = loc3;
	}
	function validate()
	{
		this.api.kernel.KeyManager.removeShortcutsListener(this);
		this.dispatchEvent({type:"validate",value:_global.parseInt(this._winBackground.content._tiInput.text,10),params:this._oParams});
	}
	function complete(loc2)
	{
		this.placeWindow();
		this.addToQueue({object:this,method:this.initWindowContent});
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnOk":
				this.validate();
				break;
			case "_btnMax":
				if(this._winBackground.content._tiInput.text == this._nMax)
				{
					this.validate();
					break;
				}
				this._winBackground.content._tiInput.text = this._nMax;
				this._winBackground.content._tiInput.setFocus();
				return undefined;
				break;
			case "_btnMin":
				this._winBackground.content._tiInput.text = this._nMin;
				this._winBackground.content._tiInput.setFocus();
				return undefined;
				break;
			default:
				if(loc0 !== "_bgHidder")
				{
					break;
				}
		}
		this.unloadThis();
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.validate();
			this.unloadThis();
			return false;
		}
		return true;
	}
}
