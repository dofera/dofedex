class dofus.aks.Fights extends dofus.aks.Handler
{
	function Fights(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function getList()
	{
		this.aks.send("fL");
	}
	function getDetails(var2)
	{
		this.aks.send("fD" + var2,false);
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
	function onCount(var2)
	{
		var var3 = Number(var2);
		if(_global.isNaN(var3) || (var2.length == 0 || var3 == 0))
		{
			this.api.ui.getUIComponent("Banner").fightsCount = 0;
		}
		else if(var3 < 0)
		{
			if(this.api.ui.getUIComponent("Banner").fightsCount >= var3)
			{
				this.api.ui.getUIComponent("Banner").fightsCount = this.api.ui.getUIComponent("Banner").fightsCount + var3;
			}
		}
		else
		{
			this.api.ui.getUIComponent("Banner").fightsCount = var3;
		}
	}
	function onList(var2)
	{
		var var3 = var2.split("|");
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var3.length)
		{
			if(String(var3[var5]).length != 0)
			{
				var var6 = var3[var5].split(";");
				var var7 = Number(var6[0]);
				var var8 = Number(var6[1]);
				var var9 = var8 != -1?this.api.kernel.NightManager.getDiffDate(var8):-1;
				var var10 = new dofus.datacenter.(var7,var9);
				var var11 = String(var6[2]).split(",");
				var var12 = Number(var11[0]);
				var var13 = Number(var11[1]);
				var var14 = Number(var11[2]);
				var10.addTeam(1,var12,var13,var14);
				var var15 = String(var6[3]).split(",");
				var var16 = Number(var15[0]);
				var var17 = Number(var15[1]);
				var var18 = Number(var15[2]);
				var10.addTeam(2,var16,var17,var18);
				var4.push(var10);
			}
			var5 = var5 + 1;
		}
		var var19 = this.api.ui.getUIComponent("FightsInfos").fights;
		if(var19 != null)
		{
			var19.splice(0,var19.length);
			var19.replaceAll(0,var4);
		}
	}
	function onDetails(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = new ank.utils.();
		var var6 = var3[1].split(";");
		var var7 = 0;
		while(var7 < var6.length)
		{
			if(var6[var7] != "")
			{
				var var8 = var6[var7].split("~");
				var5.push({name:this.api.kernel.CharactersManager.getNameFromData(var8[0]).name,level:Number(var8[1]),type:this.api.kernel.CharactersManager.getNameFromData(var8[0]).type});
			}
			var7 = var7 + 1;
		}
		var var9 = new ank.utils.();
		var var10 = var3[2].split(";");
		var var11 = 0;
		while(var11 < var10.length)
		{
			if(var10[var11] != "")
			{
				var var12 = var10[var11].split("~");
				var9.push({name:this.api.kernel.CharactersManager.getNameFromData(var12[0]).name,level:Number(var12[1]),type:this.api.kernel.CharactersManager.getNameFromData(var12[0]).type});
			}
			var11 = var11 + 1;
		}
		this.api.ui.getUIComponent("FightsInfos").addFightTeams(var4,var5,var9);
	}
}
