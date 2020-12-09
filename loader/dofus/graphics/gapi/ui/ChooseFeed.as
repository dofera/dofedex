class dofus.graphics.gapi.ui.ChooseFeed extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "LivingItemsViewer";
	function ChooseFeed()
	{
		super();
	}
	function __set__itemsType(§\x1d\x06§)
	{
		this._aFiltersType = var2;
		if(this._eaDataProvider)
		{
			this.updateData();
		}
		return this.__get__itemsType();
	}
	function __set__item(§\x1e\x1a\x02§)
	{
		this._oItem = var2;
		return this.__get__item();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ChooseFeed.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnValid.addEventListener("click",this);
		this._bgh.addEventListener("click",this);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgGrid.addEventListener("overItem",this);
		this._cgGrid.addEventListener("outItem",this);
		this._cgGrid.addEventListener("dblClickItem",this);
		this._cgGrid.multipleContainerSelectionEnabled = false;
	}
	function initTexts()
	{
		this._btnValid.label = this.api.lang.getText("VALIDATE");
		this._winBg.title = this.api.lang.getText("FEED_ITEM");
		this._lblNoItem.text = this.api.lang.getText("SELECT_ITEM");
	}
	function updateData()
	{
		this._eaDataProvider = this.api.datacenter.Player.Inventory;
		this._itvItemViewer._visible = false;
		this._mcItvIconBg._visible = false;
		var var2 = new ank.utils.
();
		for(var k in this._eaDataProvider)
		{
			var var3 = this._eaDataProvider[k];
			var var4 = 0;
			while(var4 < this._aFiltersType.length)
			{
				if(var3.type == this._aFiltersType[var4] && (!var3.skineable && (var3.position == -1 && var3.canBeExchange)))
				{
					var2.push(var3);
					break;
				}
				var4 = var4 + 1;
			}
		}
		if(var2.length)
		{
			this._cgGrid.dataProvider = var2;
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_NO_FOOD_LIVING_ITEM",[this._oItem.name]),"ERROR_BOX",{name:"noItem",listener:this});
			this.callClose();
		}
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function validate(§\x1e\x19\r§, §\x02\x11§)
	{
		if(!var2.ID)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("SELECT_ITEM"),"ERROR_BOX",{name:"noSelection",listener:this});
			return undefined;
		}
		if(!var3)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_FOOD_LIVING_ITEM"),"CAUTION_YESNO",{name:"Confirm",params:{oItem:var2},listener:this});
			return undefined;
		}
		this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FEED);
		this.api.network.Items.feed(this._oItem.ID,this._oItem.position,var2.ID);
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
				this.validate(this._cgGrid.selectedItem.contentData);
		}
	}
	function dblClickItem(§\x1e\x19\x18§)
	{
		this.validate(var2.target.contentData);
	}
	function selectItem(§\x1e\x19\x18§)
	{
		this._itvItemViewer.itemData = var2.target.contentData;
		this._itvItemViewer._visible = true;
		this._mcItvIconBg._visible = true;
		this._lblNoItem._visible = false;
	}
	function overItem(§\x1e\x19\x18§)
	{
		this.gapi.showTooltip(var2.target.contentData.name,var2.target,-20,undefined,var2.target.contentData.style + "ToolTip");
	}
	function outItem(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
	function yes(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "AskYesNoConfirm")
		{
			this.validate(var2.params.oItem,true);
		}
	}
}
