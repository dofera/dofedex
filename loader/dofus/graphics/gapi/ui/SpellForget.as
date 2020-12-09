class dofus.graphics.gapi.ui.SpellForget extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SpellForget";
	function SpellForget()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.SpellForget.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._btnValidate.enabled = false;
		this._btnClose.addEventListener("click",this);
		this._btnCancel.addEventListener("click",this);
		this._btnValidate.addEventListener("click",this);
		this._lstSpells.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._winBg.title = this.api.lang.getText("SPELL_FORGET");
		this._lblName.text = this.api.lang.getText("SPELLS_SHORTCUT");
		this._lblLevel.text = this.api.lang.getText("LEVEL");
		this._btnValidate.label = this.api.lang.getText("VALIDATE");
		this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
	}
	function initData()
	{
		var var2 = this.api.datacenter.Player.Spells;
		var var3 = new ank.utils.
();
		for(var k in var2)
		{
			var var4 = var2[k];
			if(var4.classID != -1 && var4.level > 1)
			{
				var3.push(var4);
			}
		}
		this._lstSpells.dataProvider = var3;
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		this._btnValidate.enabled = true;
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._btnValidate:
				var var3 = (dofus.datacenter.Spell)this._lstSpells.selectedItem;
				this.api.kernel.showMessage(this.api.lang.getText("SPELL_FORGET"),this.api.lang.getText("SPELL_FORGET_CONFIRM",[var3.name]),"CAUTION_YESNO",{name:"SpellForget",listener:this,params:{spell:var3}});
				break;
			default:
				if(var0 !== this._btnCancel)
				{
					break;
				}
			case this._btnClose:
				this.api.network.Spells.spellForget(-1);
				this.unloadThis();
		}
	}
	function yes(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "AskYesNoSpellForget")
		{
			var var3 = var2.target.params.spell;
			this.api.network.Spells.spellForget(var3.ID);
			this.unloadThis();
		}
	}
}
