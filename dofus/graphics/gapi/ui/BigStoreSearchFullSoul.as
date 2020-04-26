if(!dofus.graphics.gapi.ui.BigStoreSearchFullSoul)
{
	if(!dofus)
	{
		_global.dofus = new Object();
	}
	if(!dofus.graphics)
	{
		_global.dofus.graphics = new Object();
	}
	if(!dofus.graphics.gapi)
	{
		_global.dofus.graphics.gapi = new Object();
	}
	if(!dofus.graphics.gapi.ui)
	{
		_global.dofus.graphics.gapi.ui = new Object();
	}
	dofus.graphics.gapi.ui.BigStoreSearchFullSoul = function()
	{
		super();
	} extends dofus.graphics.gapi.core.DofusAdvancedComponent;
	var loc1 = dofus.graphics.gapi.ui.BigStoreSearchFullSoul = function()
	{
		super();
	}.prototype;
	loc1.__set__oParent = function __set__oParent(loc2)
	{
		this._oParent = loc2;
		return this.__get__oParent();
	};
	loc1.init = function init()
	{
		super.init(false,dofus.graphics.gapi.ui.BigStoreSearchFullSoul.CLASS_NAME);
	};
	loc1.callClose = function callClose()
	{
		this.gapi.hideTooltip();
		this.unloadThis();
		return true;
	};
	loc1.createChildren = function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	};
	loc1.addListeners = function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._btnView.addEventListener("click",this);
	};
	loc1.initTexts = function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("BIGSTORE_SEARCH");
		this._lblSearch.text = this.api.lang.getText("BIGSTORE_SEARCH_MONSTER_NAME");
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnView.label = this.api.lang.getText("BIGSTORE_SEARCH_VIEW");
		this._tiSearch.text = "";
		this._tiSearch.setFocus();
	};
	loc1.click = function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
			default:
				this.callClose();
				break;
			case "_btnView":
				this._oParent._sFullSoulMonster = this._tiSearch.text;
				this._oParent.modelChanged2();
				this.callClose();
		}
	};
	loc1.Z("\x05\x01�\x02",function()
	{
	}
	,loc1.__set__oParent);
	eval("<O�\x04")(loc1,null,1);
	dofus.graphics.gapi.ui.BigStoreSearchFullSoul = function()
	{
		super();
	}["\x12�\x02"] = "5:";
	loc1["\x04\x01\b\nN�\x03"] = "\b";
}
