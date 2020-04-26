class dofus.aks.Spells extends dofus.aks.Handler
{
	function Spells(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function moveToUsed(loc2, loc3)
	{
		this.aks.send("SM" + loc2 + "|" + loc3,false);
	}
	function boost(loc2)
	{
		this.aks.send("SB" + loc2);
	}
	function spellForget(loc2)
	{
		this.aks.send("SF" + loc2);
	}
	function onUpgradeSpell(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = this.api.kernel.CharactersManager.getSpellObjectFromData(loc3);
			this.api.datacenter.Player.updateSpell(loc4);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BOOST_SPELL"),"ERROR_BOX");
		}
	}
	function onList(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = this.api.datacenter.Player;
		loc4.Spells.removeItems(1,loc4.Spells.length);
		var loc5 = new Array();
		var loc6 = 0;
		while(loc6 < loc3.length)
		{
			var loc7 = loc3[loc6];
			if(loc7.length != 0)
			{
				var loc8 = this.api.kernel.CharactersManager.getSpellObjectFromData(loc7);
				if(loc8 != undefined)
				{
					loc5.push(loc8);
				}
			}
			loc6 = loc6 + 1;
		}
		loc4.Spells.replaceAll(1,loc5);
	}
	function onChangeOption(loc2)
	{
		this.api.datacenter.Basics.canUseSeeAllSpell = loc2.charAt(0) == "+";
	}
	function onSpellBoost(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = Number(loc3[2]);
		this.api.kernel.SpellsBoostsManager.setSpellModificator(loc4,loc5,loc6);
	}
	function onSpellForget(loc2)
	{
		if(loc2 == "+")
		{
			this.api.ui.loadUIComponent("SpellForget","SpellForget",undefined,{bStayIfPresent:true});
		}
		else if(loc2 == "-")
		{
			this.api.ui.unloadUIComponent("SpellForget");
		}
	}
}
