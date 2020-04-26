class dofus.graphics.gapi.ui.bigstore.BigStorePriceItem extends ank.gapi.core.UIBasicComponent
{
	function BigStorePriceItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function __set__row(loc2)
	{
		this._mcRow = loc2;
		return this.__get__row();
	}
	function setValue(loc2, loc3, loc4)
	{
		delete this._nSelectedSet;
		if(loc2)
		{
			this._oItem = loc4;
			var loc5 = this._mcList._parent._parent.isThisPriceSelected(loc4.id,1);
			var loc6 = this._mcList._parent._parent.isThisPriceSelected(loc4.id,2);
			var loc7 = this._mcList._parent._parent.isThisPriceSelected(loc4.id,3);
			if(loc5)
			{
				var loc8 = this._btnPriceSet1;
			}
			if(loc6)
			{
				loc8 = this._btnPriceSet2;
			}
			if(loc7)
			{
				loc8 = this._btnPriceSet3;
			}
			if(loc5 || (loc6 || loc7))
			{
				var loc9 = this._btnBuy;
			}
			if(loc9 != undefined)
			{
				this._mcList._parent._parent.setButtons(loc8,loc9);
			}
			this._btnPriceSet1.selected = loc5 && !_global.isNaN(loc4.priceSet1);
			this._btnPriceSet2.selected = loc6 && !_global.isNaN(loc4.priceSet2);
			this._btnPriceSet3.selected = loc7 && !_global.isNaN(loc4.priceSet3);
			if(loc5)
			{
				this._nSelectedSet = 1;
			}
			else if(loc6)
			{
				this._nSelectedSet = 2;
			}
			else if(loc7)
			{
				this._nSelectedSet = 3;
			}
			this._btnBuy.enabled = this._nSelectedSet != undefined;
			this._btnBuy._visible = true;
			this._btnPriceSet1._visible = true;
			this._btnPriceSet2._visible = true;
			this._btnPriceSet3._visible = true;
			this._btnPriceSet1.enabled = !_global.isNaN(loc4.priceSet1);
			this._btnPriceSet2.enabled = !_global.isNaN(loc4.priceSet2);
			this._btnPriceSet3.enabled = !_global.isNaN(loc4.priceSet3);
			this._btnPriceSet1.label = !_global.isNaN(loc4.priceSet1)?new ank.utils.(loc4.priceSet1).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
			this._btnPriceSet2.label = !_global.isNaN(loc4.priceSet2)?new ank.utils.(loc4.priceSet2).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
			this._btnPriceSet3.label = !_global.isNaN(loc4.priceSet3)?new ank.utils.(loc4.priceSet3).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
			this._ldrIcon.contentParams = loc4.item.params;
			this._ldrIcon.contentPath = loc4.item.iconFile;
		}
		else if(this._ldrIcon.contentPath != undefined)
		{
			this._btnPriceSet1._visible = false;
			this._btnPriceSet2._visible = false;
			this._btnPriceSet3._visible = false;
			this._btnBuy._visible = false;
			this._ldrIcon.contentPath = "";
		}
	}
	function init()
	{
		super.init(false);
		this._btnPriceSet1._visible = false;
		this._btnPriceSet2._visible = false;
		this._btnPriceSet3._visible = false;
		this._btnBuy._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		this._btnPriceSet1.addEventListener("click",this);
		this._btnPriceSet2.addEventListener("click",this);
		this._btnPriceSet3.addEventListener("click",this);
		this._btnBuy.addEventListener("click",this);
	}
	function initTexts()
	{
		this._btnBuy.label = this._mcList.gapi.api.lang.getText("BUY");
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnPriceSet1":
			case "_btnPriceSet2":
			case "_btnPriceSet3":
				var loc3 = Number(loc2.target._name.substr(12));
				this._mcList._parent._parent.selectPrice(this._oItem,loc3,loc2.target,this._btnBuy);
				if(loc2.target.selected)
				{
					this._nSelectedSet = loc3;
					this._mcRow.select();
					this._btnBuy.enabled = true;
				}
				else
				{
					delete this._nSelectedSet;
					this._btnBuy.enabled = false;
				}
				break;
			default:
				if(loc0 !== "_btnBuy")
				{
					break;
				}
				if(!this._nSelectedSet || _global.isNaN(this._nSelectedSet))
				{
					this._btnBuy.enabled = false;
					return undefined;
				}
				this._mcList._parent._parent.askBuy(this._oItem.item,this._nSelectedSet,this._oItem["priceSet" + this._nSelectedSet]);
				this._mcList._parent._parent.askMiddlePrice(this._oItem.item);
				break;
		}
	}
}
