class dofus.graphics.gapi.ui.bigstore.BigStorePriceItem extends ank.gapi.core.UIBasicComponent
{
	function BigStorePriceItem()
	{
		super();
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function __set__row(var2)
	{
		this._mcRow = var2;
		return this.__get__row();
	}
	function setValue(var2, var3, var4)
	{
		delete this._nSelectedSet;
		if(var2)
		{
			this._oItem = var4;
			var var5 = this._mcList._parent._parent.isThisPriceSelected(var4.id,1);
			var var6 = this._mcList._parent._parent.isThisPriceSelected(var4.id,2);
			var var7 = this._mcList._parent._parent.isThisPriceSelected(var4.id,3);
			if(var5)
			{
				var var8 = this._btnPriceSet1;
			}
			if(var6)
			{
				var8 = this._btnPriceSet2;
			}
			if(var7)
			{
				var8 = this._btnPriceSet3;
			}
			if(var5 || (var6 || var7))
			{
				var var9 = this._btnBuy;
			}
			if(var9 != undefined)
			{
				this._mcList._parent._parent.setButtons(var8,var9);
			}
			this._btnPriceSet1.selected = var5 && !_global.isNaN(var4.priceSet1);
			this._btnPriceSet2.selected = var6 && !_global.isNaN(var4.priceSet2);
			this._btnPriceSet3.selected = var7 && !_global.isNaN(var4.priceSet3);
			if(var5)
			{
				this._nSelectedSet = 1;
			}
			else if(var6)
			{
				this._nSelectedSet = 2;
			}
			else if(var7)
			{
				this._nSelectedSet = 3;
			}
			this._btnBuy.enabled = this._nSelectedSet != undefined;
			this._btnBuy._visible = true;
			this._btnPriceSet1._visible = true;
			this._btnPriceSet2._visible = true;
			this._btnPriceSet3._visible = true;
			this._btnPriceSet1.enabled = !_global.isNaN(var4.priceSet1);
			this._btnPriceSet2.enabled = !_global.isNaN(var4.priceSet2);
			this._btnPriceSet3.enabled = !_global.isNaN(var4.priceSet3);
			this._btnPriceSet1.label = !_global.isNaN(var4.priceSet1)?new ank.utils.(var4.priceSet1).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
			this._btnPriceSet2.label = !_global.isNaN(var4.priceSet2)?new ank.utils.(var4.priceSet2).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
			this._btnPriceSet3.label = !_global.isNaN(var4.priceSet3)?new ank.utils.(var4.priceSet3).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + "  ":"-  ";
			this._ldrIcon.contentParams = var4.item.params;
			this._ldrIcon.contentPath = var4.item.iconFile;
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
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			default:
				switch(null)
				{
					case "_btnPriceSet3":
						break loop0;
					case "_btnBuy":
						if(!this._nSelectedSet || _global.isNaN(this._nSelectedSet))
						{
							this._btnBuy.enabled = false;
							return undefined;
						}
						this._mcList._parent._parent.askBuy(this._oItem.item,this._nSelectedSet,this._oItem["priceSet" + this._nSelectedSet]);
						this._mcList._parent._parent.askMiddlePrice(this._oItem.item);
						break;
				}
			case "_btnPriceSet1":
			case "_btnPriceSet2":
		}
		var var3 = Number(var2.target._name.substr(12));
		this._mcList._parent._parent.selectPrice(this._oItem,var3,var2.target,this._btnBuy);
		if(var2.target.selected)
		{
			this._nSelectedSet = var3;
			this._mcRow.select();
			this._btnBuy.enabled = true;
		}
		else
		{
			delete this._nSelectedSet;
			this._btnBuy.enabled = false;
		}
	}
}
