class dofus.graphics.gapi.ui.MakeMimibiote extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MakeMimibiote";
	function MakeMimibiote()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MakeMimibiote.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnValidate.addEventListener("click",this);
		this._ivInventoryViewer.addEventListener("dblClickItem",this);
		this._ivInventoryViewer.addEventListener("dropItem",this);
		this._ivInventoryViewer.cgGrid.multipleContainerSelectionEnabled = false;
		this._cgItemToAttach.addEventListener("dblClickItem",this);
		this._cgItemToAttach.addEventListener("dropItem",this);
		this._cgItemToAttach.addEventListener("dragItem",this);
		this._cgItemToAttach.addEventListener("overItem",this);
		this._cgItemToAttach.addEventListener("outItem",this);
		this._cgItemToEat.addEventListener("dblClickItem",this);
		this._cgItemToEat.addEventListener("dropItem",this);
		this._cgItemToEat.addEventListener("dragItem",this);
		this._cgItemToEat.addEventListener("overItem",this);
		this._cgItemToEat.addEventListener("outItem",this);
		this._cgItemToAttach.multipleContainerSelectionEnabled = false;
		this._cgItemToEat.multipleContainerSelectionEnabled = false;
		this._ctrResult.addEventListener("over",this);
		this._ctrResult.addEventListener("out",this);
	}
	function initTexts()
	{
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._lblName.text = this.api.lang.getText("CUSTOMIZE");
		this._btnValidate.label = this.api.lang.getText("VALIDATE");
	}
	function initData()
	{
		this._ivInventoryViewer.showKamas = false;
		this._ivInventoryViewer.dataProvider = this.api.datacenter.Player.Inventory;
		this._cgItemToAttach.dataProvider = new ank.utils.();
		this._cgItemToEat.dataProvider = new ank.utils.();
		this._cgResult.dataProvider = new ank.utils.();
		this.refreshPreview();
	}
	function putItem(var2, var3, var4)
	{
		if(var3 != undefined && !this.canPutItem(var3,var2))
		{
			this.refreshPreview();
			return undefined;
		}
		var var5 = new ank.utils.();
		var3 = var3.clone();
		var3.Quantity = 1;
		if(!(!var4 && var2.dataProvider.length > 0))
		{
			if(var3 != undefined)
			{
				var5.push(var3);
			}
		}
		var2.dataProvider = var5;
		this.refreshPreview();
	}
	function removeItem(var2)
	{
		this.putItem(var2,undefined,false);
	}
	function canPutItem(var2, var3)
	{
		if(!dofus.Constants.isItemSuperTypeSkinable(var2.superType))
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_ITEM_NOT_SKINABLE"),"ERROR_CHAT");
			return false;
		}
		if(var2.hasCustomGfx() || var2.skineable)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_ITEM_ALREADY_SKINED"),"ERROR_CHAT");
			return false;
		}
		if(var2.skineable)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_ITEM_IS_LIVING_OBJECT"),"ERROR_CHAT");
			return false;
		}
		if(var3 == this._cgItemToEat)
		{
			var var4 = this._cgItemToAttach;
		}
		else
		{
			var4 = this._cgItemToEat;
		}
		var var5 = var4.dataProvider[0];
		if(var5 != undefined)
		{
			if(var5.superType != var2.superType)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_ITEM_SHOULD_BE_SAME_TYPE"),"ERROR_CHAT");
				return false;
			}
			if(var5.unicID == var2.unicID)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_ITEM_SAME_ID"),"ERROR_CHAT");
				return false;
			}
			if(var3 == this._cgItemToEat)
			{
				if(var5.level < var2.level)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_SKIN_ITEM_SUPERIOR_LEVEL"),"ERROR_CHAT");
					return false;
				}
			}
			else if(var2.level < var5.level)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_SKIN_ITEM_SUPERIOR_LEVEL"),"ERROR_CHAT");
				return false;
			}
		}
		return true;
	}
	function refreshPreview()
	{
		var var2 = false;
		if(this._cgItemToAttach.dataProvider.length > 0 && this._cgItemToEat.dataProvider.length > 0)
		{
			this._btnValidate.enabled = true;
			var var3 = this._cgItemToAttach.dataProvider[0];
			var var4 = this._cgItemToEat.dataProvider[0];
			if(this._ctrResult.contentPath == undefined)
			{
				return undefined;
			}
			var var5 = var3.clone();
			if(var4.realGfx != undefined)
			{
				var5.gfx = var4.realGfx;
			}
			else
			{
				var5.gfx = var4.gfx;
			}
			this._ctrResult.contentPath = var5.iconFile;
			this._mcFiligrane.item = var5;
			var2 = true;
		}
		else
		{
			this._btnValidate.enabled = false;
		}
		if(!var2)
		{
			this._ctrResult.contentPath = "";
		}
		this._mcFiligrane._visible = var2;
		this._ctrResult._visible = var2;
	}
	function yes(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoCreateMimibiote")
		{
			var var3 = this._cgItemToAttach.dataProvider[0];
			var var4 = this._cgItemToEat.dataProvider[0];
			if(!(var3 == undefined || var4 == undefined))
			{
				this.api.network.Items.associateMimibiote(var3.ID,var4.ID);
				this.unloadThis();
			}
		}
	}
	function click(var2)
	{
		if((var var0 = var2.target) !== this._btnValidate)
		{
			this.callClose();
		}
		else
		{
			var var3 = this.gapi.loadUIComponent("AskYesNo","AskYesNoCreateMimibiote",{title:this.api.lang.getText("QUESTION"),text:this.api.lang.getText("CONFIRM_MAKE_MIMIBIOTE")});
			var3.addEventListener("yes",this);
		}
	}
	function dblClickItem(var2)
	{
		if(var2.owner != undefined)
		{
			var var3 = var2.owner.dataProvider[0];
			if(var3 == undefined)
			{
				return undefined;
			}
			var var4 = var2.owner._name;
			switch(var4)
			{
				case "_cgItemToAttach":
					this.removeItem(this._cgItemToAttach);
					break;
				case "_cgItemToEat":
					this.removeItem(this._cgItemToEat);
			}
		}
		if(var2.target != undefined)
		{
			if((var0 = var2.target) === this._ivInventoryViewer)
			{
				var var5 = var2.item;
				if(var5 == undefined)
				{
					return undefined;
				}
				if(this._cgItemToAttach.dataProvider.length == 0)
				{
					this.putItem(this._cgItemToAttach,var5,false);
				}
				else
				{
					this.putItem(this._cgItemToEat,var5,true);
				}
			}
		}
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._ctrResult)
		{
			var var3 = this._mcFiligrane.item;
			if(var3 != undefined)
			{
				var3.showStatsTooltip(var2.target,var3.style);
			}
		}
	}
	function out(var2)
	{
		this.api.ui.hideTooltip();
	}
	function overItem(var2)
	{
		var var3 = var2.target.contentData;
		var3.showStatsTooltip(var2.target,var2.target.contentData.style);
	}
	function outItem(var2)
	{
		this.gapi.hideTooltip();
	}
	function dragItem(var2)
	{
		this.gapi.removeCursor();
		if(var2.target.contentData == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(var2.target.contentData);
	}
	function dropItem(var2)
	{
		if(var2.item != undefined)
		{
			var var3 = var2.item;
			var var4 = this._cgItemToAttach.dataProvider[0];
			if(var4 != undefined && var4.ID == var3.ID)
			{
				this.removeItem(this._cgItemToAttach);
				return undefined;
			}
			var var5 = this._cgItemToEat.dataProvider[0];
			if(var5 != undefined && var5.ID == var3.ID)
			{
				this.removeItem(this._cgItemToEat);
				return undefined;
			}
			return undefined;
		}
		var3 = (dofus.datacenter.Item)this.gapi.getCursor();
		if(var3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		var var6 = var2.target._parent._parent;
		var var7 = var6._name;
		switch(var7)
		{
			case "_cgItemToAttach":
				var var8 = this._cgItemToEat.dataProvider[0];
				if(var8 != undefined && var8.unicID == var3.unicID)
				{
					this.removeItem(this._cgItemToEat);
				}
				this.putItem(var6,var3,true);
				break;
			case "_cgItemToEat":
				var var9 = this._cgItemToAttach.dataProvider[0];
				if(var9 != undefined && var9.unicID == var3.unicID)
				{
					this.removeItem(this._cgItemToAttach);
				}
				this.putItem(var6,var3,true);
		}
	}
}
