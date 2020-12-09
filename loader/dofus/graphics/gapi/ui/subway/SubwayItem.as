class dofus.graphics.gapi.ui.subway.SubwayItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	function SubwayItem()
	{
		super();
		this._mcUnderAttack._visible = false;
		this._mcUnderAttackInteractivity._visible = false;
		this.api = _global.API;
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
			this._lblCost.text = var4.cost + " k";
			this._lblCoords.text = var4.coordinates;
			this._lblName.text = var4.name;
			this._btnLocate._visible = true;
			if(this._oItem.attackNear)
			{
				this._mcUnderAttack._visible = true;
				this._mcUnderAttackInteractivity._visible = true;
				this._mcUnderAttackInteractivity.onRollOver = function()
				{
					ref.over({target:this});
				};
				this._mcUnderAttackInteractivity.onRollOut = function()
				{
					ref.out({target:this});
				};
			}
			else
			{
				this._mcUnderAttack._visible = false;
				this._mcUnderAttackInteractivity._visible = false;
			}
		}
		else if(this._lblCost.text != undefined)
		{
			this._lblCost.text = "";
			this._lblCoords.text = "";
			this._lblName.text = "";
			this._btnLocate._visible = false;
			this._mcUnderAttack._visible = false;
			this._mcUnderAttackInteractivity._visible = false;
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnLocate.addEventListener("click",this);
	}
	function click(§\x1e\x19\x18§)
	{
		this.api.kernel.GameManager.updateCompass(this._oItem.x,this._oItem.y,true);
	}
	function over(§\x0f\r§)
	{
		if((var var0 = var2.target) === this._mcUnderAttackInteractivity)
		{
			this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_NEAR_PRISM_UNDER_ATTACK"),_root._xmouse,_root._ymouse);
		}
	}
	function out(§\x0f\r§)
	{
		this.api.ui.hideTooltip();
	}
}
