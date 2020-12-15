class dofus.graphics.gapi.ui.Gifts extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Gifts";
	function Gifts()
	{
		super();
	}
	function __set__gift(var2)
	{
		this._oGift = var2;
		return this.__get__gift();
	}
	function __set__spriteList(var2)
	{
		this._aSpriteList = var2;
		return this.__get__spriteList();
	}
	function checkNextGift()
	{
		if(this.api.datacenter.Basics.aks_gifts_stack.length != 0)
		{
			var var2 = this.api.datacenter.Basics.aks_gifts_stack.shift();
			this.gapi.loadUIComponent("Gifts","Gifts",{gift:var2,spriteList:this._aSpriteList},{bForceLoad:true});
		}
		else
		{
			this.gapi.getUIComponent("ChooseCharacter")._visible = true;
			this.gapi.getUIComponent("CreateCharacter")._visible = true;
			this.unloadThis();
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Gifts.CLASS_NAME);
	}
	function callClose()
	{
		this.gapi.getUIComponent("ChooseCharacter")._visible = true;
		this.gapi.getUIComponent("CreateCharacter")._visible = true;
		this.unloadThis();
	}
	function createChildren()
	{
		this._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		var var2 = 0;
		while(var2 < 5)
		{
			var var3 = this["_ccs" + var2];
			var3.params = {index:var2};
			var3.addEventListener("select",this);
			var2 = var2 + 1;
		}
		this._cgGifts.addEventListener("selectItem",this);
		this._cgGifts.multipleContainerSelectionEnabled = false;
		this._btnClose.addEventListener("click",this);
		this._btnSelect.addEventListener("click",this);
	}
	function initTexts()
	{
		this._lblTitle.text = this.api.lang.getText("GIFTS_TITLE");
		this._lblGift.text = this.api.lang.getText("THE_GIFT");
		this._lblItems.text = this.api.lang.getText("GIFT_CONTENT");
		this._lblSelectCharacter.text = this.api.lang.getText("GIFT_SELECT_CHARACTER");
		this._btnClose.label = this.api.lang.getText("CLOSE");
		this._btnSelect.label = this.api.lang.getText("SELECT");
	}
	function initData()
	{
		if((var var0 = this._oGift.type) !== 1)
		{
			this.checkNextGift();
		}
		else
		{
			this._visible = true;
			this._cgGifts.dataProvider = this._oGift.items;
			this._cgGifts.selectedIndex = 0;
			this._itvItemViewer.itemData = this._oGift.items[0];
			this._ldrGfx.contentPath = this._oGift.gfxUrl;
			this._lblTitleGift.text = this._oGift.title;
			this._txtDescription.text = this._oGift.desc;
			var var2 = 0;
			while(var2 < 5)
			{
				var var3 = this["_ccs" + var2];
				var3.data = this._aSpriteList[var2];
				var3.enabled = this._aSpriteList[var2] != undefined;
				var2 = var2 + 1;
			}
		}
	}
	function select(var2)
	{
		var var3 = var2.target.params.index;
		this["_ccs" + this._nSelectedIndex].selected = false;
		if(this._nSelectedIndex == var3)
		{
			delete this._nSelectedIndex;
		}
		else
		{
			this._nSelectedIndex = var3;
		}
		if(getTimer() - this._nSaveLastClick < ank.gapi.Gapi.DBLCLICK_DELAY)
		{
			this._nSelectedIndex = var3;
			this.click({target:this._btnSelect});
			return undefined;
		}
		this._nSaveLastClick = getTimer();
	}
	function selectItem(var2)
	{
		this._itvItemViewer.itemData = var2.target.contentData;
	}
	function click(var2)
	{
		switch(var2.target)
		{
			case this._btnClose:
				this.callClose();
				break;
			case this._btnSelect:
				if(!_global.isNaN(this._nSelectedIndex))
				{
					var var3 = (dofus.datacenter.Item)this._oGift.items[0];
					this.api.kernel.showMessage(this.api.lang.getText("THE_GIFT"),this.api.lang.getText("GIFT_ATTRIBUTION_CONFIRMATION",[var3.name,this["_ccs" + this._nSelectedIndex].data.name]),"CAUTION_YESNO",{name:"GiftAttribution",listener:this,params:{giftId:this._oGift.id,charId:this["_ccs" + this._nSelectedIndex].data.id}});
					break;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SELECT_CHARACTER"),"ERROR_BOX",{name:"NoSelect"});
				break;
		}
	}
	function yes(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoGiftAttribution")
		{
			this.api.network.Account.attributeGiftToCharacter(var2.params.giftId,var2.params.charId);
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("WAITING_MSG_RECORDING")},{bAlwaysOnTop:true,bForceLoad:true});
		}
	}
}
