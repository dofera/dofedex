class dofus.graphics.gapi.ui.ChooseFeed extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "LivingItemsViewer";
	function ChooseFeed()
	{
		super();
	}
	function __set__itemsType(loc2)
	{
		this._aFiltersType = loc2;
		if(this._eaDataProvider)
		{
			this.updateData();
		}
		return this.__get__itemsType();
	}
	function __set__item(loc2)
	{
		this._oItem = loc2;
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
		var loc2 = new ank.utils.();
		for(var k in this._eaDataProvider)
		{
			var loc3 = this._eaDataProvider[k];
			var loc4 = 0;
			while(loc4 < this._aFiltersType.length)
			{
				if(loc3.type == this._aFiltersType[loc4] && (!loc3.skineable && (loc3.position == -1 && loc3.canBeExchange)))
				{
					loc2.push(loc3);
					break;
				}
				loc4 = loc4 + 1;
			}
		}
		if(loc2.length)
		{
			this._cgGrid.dataProvider = loc2;
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
	function validate(loc2, loc3)
	{
		if(!loc2.ID)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("SELECT_ITEM"),"ERROR_BOX",{name:"noSelection",listener:this});
			return undefined;
		}
		if(!loc3)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_FOOD_LIVING_ITEM"),"CAUTION_YESNO",{name:"Confirm",params:{oItem:loc2},listener:this});
			return undefined;
		}
		this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FEED);
		this.api.network.Items.feed(this._oItem.ID,this._oItem.position,loc2.ID);
		this.callClose();
	}
	function click(loc2)
	{
		switch(loc2.target)
		{
			case this._bgh:
			case this._btnClose:
				this.callClose();
				break;
			case this._btnValid:
				this.validate(this._cgGrid.selectedItem.contentData);
		}
	}
	function dblClickItem(loc2)
	{
		this.validate(loc2.target.contentData);
	}
	function selectItem(loc2)
	{
		this._itvItemViewer.itemData = loc2.target.contentData;
		this._itvItemViewer._visible = true;
		this._mcItvIconBg._visible = true;
		this._lblNoItem._visible = false;
	}
	function overItem(loc2)
	{
		this.gapi.showTooltip(loc2.target.contentData.name,loc2.target,-20,undefined,loc2.target.contentData.style + "ToolTip");
	}
	function outItem(loc2)
	{
		this.gapi.hideTooltip();
	}
	function yes(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoConfirm")
		{
			this.validate(loc2.params.oItem,true);
		}
	}
}
