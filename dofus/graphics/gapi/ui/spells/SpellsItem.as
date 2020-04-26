class dofus.graphics.gapi.ui.spells.SpellsItem extends ank.gapi.core.UIBasicComponent
{
	function SpellsItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			loc4.sortName = loc4.name;
			loc4.sortLevel = loc4.level;
			var loc5 = this._mcList._parent._parent.api;
			this._lblName.text = loc4.name;
			this._lblLevel.text = loc5.lang.getText("LEVEL") + " " + loc4.level;
			this._lblRange.text = (loc4.rangeMin == 0?"":loc4.rangeMin + "-") + loc4.rangeMax + " " + loc5.lang.getText("RANGE");
			this._lblAP.text = loc4.apCost + " " + loc5.lang.getText("AP");
			this._ldrIcon.contentPath = loc4.iconFile;
			var loc6 = this._mcList._parent._parent.canBoost(loc4) && loc5.datacenter.Basics.canUseSeeAllSpell;
			var loc7 = this._mcList._parent._parent.getCostForBoost(loc4);
			this._btnBoost.enabled = true;
			this._btnBoost._visible = loc6;
			this._lblBoost.text = !(loc7 != -1 && loc5.datacenter.Basics.canUseSeeAllSpell)?"":loc5.lang.getText("POINT_NEED_TO_BOOST_SPELL",[loc7]);
			if(loc5.datacenter.Player.Level < loc4._minPlayerLevel)
			{
				var loc8 = 50;
				this._lblName._alpha = loc8;
				this._ldrIcon._alpha = loc8;
				this._lblAP._alpha = loc8;
				this._lblRange._alpha = loc8;
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
		this._btnBoost.addEventListener("click",this);
		this._btnBoost.addEventListener("over",this);
		this._btnBoost.addEventListener("out",this);
	}
	function click(loc2)
	{
		var loc3 = this._mcList._parent._parent.api;
		if((var loc0 = loc2.target) === this._btnBoost)
		{
			if(!loc3.datacenter.Player.isAuthorized)
			{
				loc3.kernel.showMessage(loc3.lang.getText("UPGRADE_SPELL"),loc3.lang.getText("UPGRADE_SPELL_WARNING",[this._mcList._parent._parent.getCostForBoost(this._oItem),this._oItem.name,String(this._oItem.level + 1)]),"CAUTION_YESNO",{name:"UpgradeSpellWarning",listener:this});
			}
			else
			{
				this.yes();
			}
		}
	}
	function yes(loc2)
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
	function over(loc2)
	{
		var loc3 = this._mcList._parent._parent.api;
		if((var loc0 = loc2.target) === this._btnBoost)
		{
			loc3.ui.showTooltip(loc3.lang.getText("CLICK_HERE_FOR_SPELL_BOOST",[this._mcList._parent._parent.getCostForBoost(this._oItem),this._oItem.name,String(this._oItem.level + 1)]),loc2.target,-30,{bXLimit:true,bYLimit:false});
		}
	}
	function out(loc2)
	{
		var loc3 = this._mcList._parent._parent.api;
		if((var loc0 = loc2.target) === this._btnBoost)
		{
			loc3.ui.hideTooltip();
		}
	}
}
