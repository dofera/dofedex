class dofus.aks.Spells extends dofus.aks.Handler
{
	function Spells(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function moveToUsed(§\x05\x02§, §\x01\x17§)
	{
		this.aks.send("SM" + var2 + "|" + var3,false);
	}
	function boost(§\x05\x02§)
	{
		this.aks.send("SB" + var2);
	}
	function spellForget(§\x05\x02§)
	{
		this.aks.send("SF" + var2);
	}
	function onUpgradeSpell(§\x14\x1b§, §\x1e\x12\x1a§)
	{
		if(var2)
		{
			var var4 = this.api.kernel.CharactersManager.getSpellObjectFromData(var3);
			this.api.datacenter.Player.updateSpell(var4);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BOOST_SPELL"),"ERROR_BOX");
		}
	}
	function onList(§\x1e\x12\x1a§)
	{
		var var3 = var2.split(";");
		var var4 = this.api.datacenter.Player;
		var4.Spells.removeItems(1,var4.Spells.length);
		var var5 = new Array();
		var var6 = 0;
		while(var6 < var3.length)
		{
			var var7 = var3[var6];
			if(var7.length != 0)
			{
				var var8 = this.api.kernel.CharactersManager.getSpellObjectFromData(var7);
				if(var8 != undefined)
				{
					var5.push(var8);
				}
			}
			var6 = var6 + 1;
		}
		var4.Spells.replaceAll(1,var5);
	}
	function onChangeOption(§\x1e\x12\x1a§)
	{
		this.api.datacenter.Basics.canUseSeeAllSpell = var2.charAt(0) == "+";
	}
	function onSpellBoost(§\x1e\x12\x1a§)
	{
		var var3 = var2.split(";");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = Number(var3[2]);
		this.api.kernel.SpellsBoostsManager.setSpellModificator(var4,var5,var6);
	}
	function onSpellForget(§\x1e\x12\x1a§)
	{
		if(var2 == "+")
		{
			this.api.ui.loadUIComponent("SpellForget","SpellForget",undefined,{bStayIfPresent:true});
		}
		else if(var2 == "-")
		{
			this.api.ui.unloadUIComponent("SpellForget");
		}
	}
}
