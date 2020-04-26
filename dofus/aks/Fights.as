class dofus.aks.Fights extends dofus.aks.Handler
{
	function Fights(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function getList()
	{
		this.aks.send("fL");
	}
	function getDetails(loc2)
	{
		this.aks.send("fD" + loc2,false);
	}
	function blockSpectators()
	{
		this.aks.send("fS");
	}
	function blockJoinerExceptParty()
	{
		this.aks.send("fP");
	}
	function blockJoiner()
	{
		this.aks.send("fN");
	}
	function needHelp()
	{
		this.aks.send("fH");
	}
	function onCount(loc2)
	{
		var loc3 = Number(loc2);
		if(_global.isNaN(loc3) || (loc2.length == 0 || loc3 == 0))
		{
			this.api.ui.getUIComponent("Banner").fightsCount = 0;
		}
		else if(loc3 < 0)
		{
			if(this.api.ui.getUIComponent("Banner").fightsCount >= loc3)
			{
				this.api.ui.getUIComponent("Banner").fightsCount = this.api.ui.getUIComponent("Banner").fightsCount + loc3;
			}
		}
		else
		{
			this.api.ui.getUIComponent("Banner").fightsCount = loc3;
		}
	}
	function onList(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = new Array();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			if(String(loc3[loc5]).length != 0)
			{
				var loc6 = loc3[loc5].split(";");
				var loc7 = Number(loc6[0]);
				var loc8 = Number(loc6[1]);
				var loc9 = loc8 != -1?this.api.kernel.NightManager.getDiffDate(loc8):-1;
				var loc10 = new dofus.datacenter.(loc7,loc9);
				var loc11 = String(loc6[2]).split(",");
				var loc12 = Number(loc11[0]);
				var loc13 = Number(loc11[1]);
				var loc14 = Number(loc11[2]);
				loc10.addTeam(1,loc12,loc13,loc14);
				var loc15 = String(loc6[3]).split(",");
				var loc16 = Number(loc15[0]);
				var loc17 = Number(loc15[1]);
				var loc18 = Number(loc15[2]);
				loc10.addTeam(2,loc16,loc17,loc18);
				loc4.push(loc10);
			}
			loc5 = loc5 + 1;
		}
		var loc19 = this.api.ui.getUIComponent("FightsInfos").fights;
		if(loc19 != null)
		{
			loc19.splice(0,loc19.length);
			loc19.replaceAll(0,loc4);
		}
	}
	function onDetails(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = new ank.utils.();
		var loc6 = loc3[1].split(";");
		var loc7 = 0;
		while(loc7 < loc6.length)
		{
			if(loc6[loc7] != "")
			{
				var loc8 = loc6[loc7].split("~");
				loc5.push({name:this.api.kernel.CharactersManager.getNameFromData(loc8[0]).name,level:Number(loc8[1]),type:this.api.kernel.CharactersManager.getNameFromData(loc8[0]).type});
			}
			loc7 = loc7 + 1;
		}
		var loc9 = new ank.utils.();
		var loc10 = loc3[2].split(";");
		var loc11 = 0;
		while(loc11 < loc10.length)
		{
			if(loc10[loc11] != "")
			{
				var loc12 = loc10[loc11].split("~");
				loc9.push({name:this.api.kernel.CharactersManager.getNameFromData(loc12[0]).name,level:Number(loc12[1]),type:this.api.kernel.CharactersManager.getNameFromData(loc12[0]).type});
			}
			loc11 = loc11 + 1;
		}
		this.api.ui.getUIComponent("FightsInfos").addFightTeams(loc4,loc5,loc9);
	}
}
