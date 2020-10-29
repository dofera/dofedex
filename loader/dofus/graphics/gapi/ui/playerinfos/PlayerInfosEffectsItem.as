class dofus.graphics.gapi.ui.playerinfos.PlayerInfosEffectsItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	function PlayerInfosEffectsItem()
	{
		super();
		this.api = _global.API;
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._ldrIcon.forceNextLoad();
			this._ldrIcon.contentPath = dofus.Constants.EFFECTSICON_FILE;
			this._lblDescription.text = var4.description;
			this._lblRemainingTurn.text = var4.remainingTurnStr;
			this._lblSpell.text = var4.spellName;
			var ref = this;
			this._mcInteractivity.onRollOver = function()
			{
				ref.over({target:this});
			};
			this._mcInteractivity.onRollOut = function()
			{
				ref.out({target:this});
			};
			this._oItem = var4;
		}
		else if(this._lblSpell.text != undefined)
		{
			this._ldrIcon.contentPath = "";
			this._lblDescription.text = "";
			this._lblRemainingTurn.text = "";
			this._lblSpell.text = "";
			delete this._mcInteractivity.onRollOver;
			delete this._mcInteractivity.onRollOut;
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
		this._ldrIcon.addEventListener("initialization",this);
	}
	function initialization(var2)
	{
		var var3 = this._ldrIcon.content.attachMovie("Icon_" + this._oItem.characteristic,"_mcIcon",10,{operator:this._oItem.operator});
		var3.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
		var var4 = (dofus.graphics.battlefield.EffectIcon)var3;
		var4.initialize(this._oItem.operator,1);
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._mcInteractivity)
		{
			if(this._oItem.spellDescription.length > 0)
			{
				this.api.ui.showTooltip(this._oItem.spellDescription,_root._xmouse,_root._ymouse - 30);
			}
		}
	}
	function out(var2)
	{
		this.api.ui.hideTooltip();
	}
}
