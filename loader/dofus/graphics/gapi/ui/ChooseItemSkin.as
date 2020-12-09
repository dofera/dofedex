class dofus.graphics.gapi.ui.ChooseItemSkin extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChooseItemSkin";
	function ChooseItemSkin()
	{
		super();
	}
	function __set__item(§\x1e\x19\r§)
	{
		this._oItem = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__item();
	}
	function __get__item()
	{
		return this._oItem;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ChooseItemSkin.CLASS_NAME);
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnValid.addEventListener("click",this);
	}
	function updateData()
	{
		this._cisItem.item = this._oItem;
	}
	function initTexts()
	{
		this._btnValid.label = this.api.lang.getText("VALIDATE");
		this._win.title = this.api.lang.getText("CHOOSE_SKIN");
	}
	function validate(§\x1e\x19\r§)
	{
		if(!var2)
		{
			return undefined;
		}
		this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CHANGE_SKIN);
		this.api.network.Items.setSkin(this._oItem.ID,this._oItem.position,var2.skin + 1);
		this.callClose();
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._bgh:
			case this._btnClose:
				this.callClose();
				break;
			case this._btnValid:
				this.validate(this._cisItem.selectedItem);
		}
	}
	function dblClickItem(§\x1e\x19\x18§)
	{
		this.validate(var2.target.contentData);
	}
}
