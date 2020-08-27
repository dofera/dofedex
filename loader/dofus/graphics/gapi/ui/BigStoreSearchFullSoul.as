class dofus.graphics.gapi.ui.BigStoreSearchFullSoul extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BigStoreSearchFullSoul";
	var _sDefaultText = "";
	function BigStoreSearchFullSoul()
	{
		super();
	}
	function __set__oParent(var2)
	{
		this._oParent = var2;
		return this.__get__oParent();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.BigStoreSearchFullSoul.CLASS_NAME);
	}
	function callClose()
	{
		this.gapi.hideTooltip();
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._btnView.addEventListener("click",this);
	}
	function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("BIGSTORE_SEARCH");
		this._lblSearch.text = this.api.lang.getText("BIGSTORE_SEARCH_MONSTER_NAME");
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnView.label = this.api.lang.getText("BIGSTORE_SEARCH_VIEW");
		this._tiSearch.text = "";
		this._tiSearch.setFocus();
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			case "_btnView":
				this._oParent._sFullSoulMonster = this._tiSearch.text;
				this._oParent.modelChanged2();
				this.callClose();
		}
	}
}
