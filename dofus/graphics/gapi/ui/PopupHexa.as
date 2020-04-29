class dofus.graphics.gapi.ui.PopupHexa extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PopupHexa";
	var _nValue = "000000";
	var _bUseAllStage = false;
	function PopupHexa()
	{
		super();
	}
	function __set__value(var2)
	{
		this._nValue = var2;
		return this.__get__value();
	}
	function __set__useAllStage(var2)
	{
		this._bUseAllStage = var2;
		return this.__get__useAllStage();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.PopupHexa.CLASS_NAME);
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
		var var2 = this._winBackground.content;
		var2._btnOk.addEventListener("click",this);
		var2._tiInput.restrict = "0-9 A-F";
		var2._tiInput.maxChars = 6;
		var2._tiInput.text = this._nValue;
		var2._tiInput.setFocus();
	}
	function placeWindow()
	{
		var var2 = this._xmouse - this._winBackground.width;
		var var3 = this._ymouse - this._winBackground._height;
		var var4 = !this._bUseAllStage?this.gapi.screenWidth:Stage.width;
		var var5 = !this._bUseAllStage?this.gapi.screenHeight:Stage.height;
		if(var2 < 0)
		{
			var2 = 0;
		}
		if(var3 < 0)
		{
			var3 = 0;
		}
		if(var2 > var4 - this._winBackground.width)
		{
			var2 = var4 - this._winBackground.width;
		}
		if(var3 > var5 - this._winBackground.height)
		{
			var3 = var5 - this._winBackground.height;
		}
		this._winBackground._x = var2;
		this._winBackground._y = var3;
	}
	function validate()
	{
		this.api.kernel.KeyManager.removeShortcutsListener(this);
		this.dispatchEvent({type:"validate",value:_global.parseInt(this._winBackground.content._tiInput.text,16),params:this._oParams});
	}
	function complete(var2)
	{
		this.placeWindow();
		this.addToQueue({object:this,method:this.initWindowContent});
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnOk":
				this.validate();
				break;
			case "_bgHidder":
		}
		this.unloadThis();
	}
	function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.validate();
			this.unloadThis();
			return false;
		}
		return true;
	}
}
