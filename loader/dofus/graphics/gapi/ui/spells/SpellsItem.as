class dofus.graphics.gapi.ui.spells.SpellsItem extends ank.gapi.core.UIBasicComponent
{
	function SpellsItem()
	{
		super();
	}
	function __set__list(§\x0b\x05§)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._oItem = var4;
			var4.sortName = var4.name;
			var4.sortLevel = var4.level;
			var var5 = this._mcList._parent._parent.api;
			this._lblName.text = var4.name;
			this._lblLevel.text = var5.lang.getText("LEVEL") + " " + var4.level;
			this._lblRange.text = (var4.rangeMin == 0?"":var4.rangeMin + "-") + var4.rangeMax + " " + var5.lang.getText("RANGE");
			this._lblAP.text = var4.apCost + " " + var5.lang.getText("AP");
			this._ldrIcon.contentPath = var4.iconFile;
			if(dofus.Constants.DOUBLEFRAMERATE && this._ldrIcon.loaded)
			{
				var var6 = var5.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
				this._ldrIcon.content.gotoAndStop(var6);
			}
			var var7 = this._mcList._parent._parent.canBoost(var4) && var5.datacenter.Basics.canUseSeeAllSpell;
			var var8 = this._mcList._parent._parent.getCostForBoost(var4);
			this._btnBoost.enabled = true;
			this._btnBoost._visible = var7;
			this._lblBoost.text = !(var8 != -1 && var5.datacenter.Basics.canUseSeeAllSpell)?"":var5.lang.getText("POINT_NEED_TO_BOOST_SPELL",[var8]);
			if(var5.datacenter.Player.Level < var4._minPlayerLevel)
			{
				var var9 = 50;
				this._lblName._alpha = var9;
				this._ldrIcon._alpha = var9;
				this._lblAP._alpha = var9;
				this._lblRange._alpha = var9;
				this._lblLevel._visible = false;
				this._lblBoost._visible = false;
				this._btnBoost._visible = false;
			}
			else
			{
				this._lblName._alpha = 100;
				this._ldrIcon._alpha = 100;
				this._lblAP._alpha = 100;
				this._lblRange._alpha = 100;
				this._lblLevel._alpha = 100;
				this._lblLevel._visible = true;
				this._lblBoost._visible = true;
			}
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._lblBoost.text = "";
			this._lblRange.text = "";
			this._lblAP.text = "";
			this._ldrIcon.contentPath = "";
			this._btnBoost._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._btnBoost._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._ldrIcon.addEventListener("complete",this);
		this._btnBoost.addEventListener("click",this);
		this._btnBoost.addEventListener("over",this);
		this._btnBoost.addEventListener("out",this);
	}
	function complete(§\x1e\x19\x18§)
	{
		if(!dofus.Constants.DOUBLEFRAMERATE)
		{
			return undefined;
		}
		var var3 = this._mcList._parent._parent.api;
		var var4 = var2.clip;
		var var5 = var3.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
		var4.gotoAndStop(var5);
	}
	function click(§\x1e\x19\x18§)
	{
		var var3 = this._mcList._parent._parent.api;
		if((var var0 = var2.target) === this._btnBoost)
		{
			if(!var3.datacenter.Player.isAuthorized)
			{
				var3.kernel.showMessage(var3.lang.getText("UPGRADE_SPELL"),var3.lang.getText("UPGRADE_SPELL_WARNING",[this._mcList._parent._parent.getCostForBoost(this._oItem),this._oItem.name,String(this._oItem.level + 1)]),"CAUTION_YESNO",{name:"UpgradeSpellWarning",listener:this});
			}
			else
			{
				this.yes();
			}
		}
	}
	function yes(§\x1e\x19\x18§)
	{
		if(this._mcList._parent._parent.boostSpell(this._oItem))
		{
			this._btnBoost.enabled = false;
			if(this._lblBoost.text != undefined)
			{
				this._lblBoost.text = "";
			}
		}
	}
	function over(§\x1e\x19\x18§)
	{
		var var3 = this._mcList._parent._parent.api;
		if((var var0 = var2.target) === this._btnBoost)
		{
			var3.ui.showTooltip(var3.lang.getText("CLICK_HERE_FOR_SPELL_BOOST",[this._mcList._parent._parent.getCostForBoost(this._oItem),this._oItem.name,String(this._oItem.level + 1)]),var2.target,-30,{bXLimit:true,bYLimit:false});
		}
	}
	function out(§\x1e\x19\x18§)
	{
		var var3 = this._mcList._parent._parent.api;
		if((var var0 = var2.target) === this._btnBoost)
		{
			var3.ui.hideTooltip();
		}
	}
}
