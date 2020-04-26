class dofus.graphics.gapi.ui.Gifts extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Gifts";
	function Gifts()
	{
		super();
	}
	function __set__gift(loc2)
	{
		this._oGift = loc2;
		return this.__get__gift();
	}
	function __set__spriteList(loc2)
	{
		this._aSpriteList = loc2;
		return this.__get__spriteList();
	}
	function checkNextGift()
	{
		if(this.api.datacenter.Basics.aks_gifts_stack.length != 0)
		{
			var loc2 = this.api.datacenter.Basics.aks_gifts_stack.shift();
			this.gapi.loadUIComponent("Gifts","Gifts",{gift:loc2,spriteList:this._aSpriteList},{bForceLoad:true});
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
		var loc2 = 0;
		while(loc2 < 5)
		{
			var loc3 = this["_ccs" + loc2];
			loc3.params = {index:loc2};
			loc3.addEventListener("select",this);
			loc2 = loc2 + 1;
		}
		this._cgGifts.addEventListener("selectItem",this);
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
		if((var loc0 = this._oGift.type) !== 1)
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
			var loc2 = 0;
			while(loc2 < 5)
			{
				var loc3 = this["_ccs" + loc2];
				loc3.data = this._aSpriteList[loc2];
				loc3.enabled = this._aSpriteList[loc2] != undefined;
				loc2 = loc2 + 1;
			}
		}
	}
	function select(loc2)
	{
		var loc3 = loc2.target.params.index;
		this["_ccs" + this._nSelectedIndex].selected = false;
		if(this._nSelectedIndex == loc3)
		{
			delete this._nSelectedIndex;
		}
		else
		{
			this._nSelectedIndex = loc3;
		}
		if(getTimer() - this._nSaveLastClick < ank.gapi.Gapi.DBLCLICK_DELAY)
		{
			this._nSelectedIndex = loc3;
			this.click({target:this._btnSelect});
			return undefined;
		}
		this._nSaveLastClick = getTimer();
	}
	function selectItem(loc2)
	{
		this._itvItemViewer.itemData = loc2.target.contentData;
	}
	function click(loc2)
	{
		switch(loc2.target)
		{
			case this._btnClose:
				this.callClose();
				break;
			case this._btnSelect:
				if(!_global.isNaN(this._nSelectedIndex))
				{
					var loc3 = (dofus.datacenter.Item)this._oGift.items[0];
					this.api.kernel.showMessage(this.api.lang.getText("THE_GIFT"),this.api.lang.getText("GIFT_ATTRIBUTION_CONFIRMATION",[loc3.name,this["_ccs" + this._nSelectedIndex].data.name]),"CAUTION_YESNO",{name:"GiftAttribution",listener:this,params:{giftId:this._oGift.id,charId:this["_ccs" + this._nSelectedIndex].data.id}});
					break;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SELECT_CHARACTER"),"ERROR_BOX",{name:"NoSelect"});
				break;
		}
	}
	function yes(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoGiftAttribution")
		{
			this.api.network.Account.attributeGiftToCharacter(loc2.params.giftId,loc2.params.charId);
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("WAITING_MSG_RECORDING")},{bAlwaysOnTop:true,bForceLoad:true});
		}
	}
}
