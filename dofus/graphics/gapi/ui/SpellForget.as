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
		var loc2 = this.api.datacenter.Player.Spells;
		var loc3 = new ank.utils.();
		for(var k in loc2)
		{
			var loc4 = loc2[k];
			if(loc4.classID != -1 && loc4.level > 1)
			{
				loc3.push(loc4);
			}
		}
		this._lstSpells.dataProvider = loc3;
	}
	function itemSelected(loc2)
	{
		this._btnValidate.enabled = true;
	}
	function click(loc2)
	{
		switch(loc2.target)
		{
			case this._btnValidate:
				var loc3 = (dofus.datacenter.Spell)this._lstSpells.selectedItem;
				this.api.kernel.showMessage(this.api.lang.getText("SPELL_FORGET"),this.api.lang.getText("SPELL_FORGET_CONFIRM",[loc3.name]),"CAUTION_YESNO",{name:"SpellForget",listener:this,params:{spell:loc3}});
				break;
			default:
				if(loc0 !== this._btnCancel)
				{
					break;
				}
			case this._btnClose:
				this.api.network.Spells.spellForget(-1);
				this.unloadThis();
		}
	}
	function yes(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoSpellForget")
		{
			var loc3 = loc2.target.params.spell;
			this.api.network.Spells.spellForget(loc3.ID);
			this.unloadThis();
		}
	}
}
