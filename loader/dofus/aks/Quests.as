class dofus.aks.Quests extends dofus.aks.Handler
{
	function Quests(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function getList()
	{
		this.aks.send("QL");
	}
	function getStep(§\x01\t§, §\x06\x17§)
	{
		this.aks.send("QS" + var2 + (var3 == undefined?"":"|" + (var3 <= 0?var3:"+" + var3)));
	}
	function onList(§\x1e\x12\x1a§)
	{
		var var3 = 0;
		var var4 = new Array();
		if(var2.length != 0)
		{
			var var5 = var2.split("|");
			var var6 = 0;
			while(var6 < var5.length)
			{
				var var7 = var5[var6].split(";");
				var var8 = Number(var7[0]);
				var var9 = var7[1] == "1";
				var var10 = Number(var7[2]);
				if(!var9)
				{
					var3 = var3 + 1;
				}
				var var11 = new dofus.datacenter.(var8,var9,var10);
				var4.push(var11);
				var6 = var6 + 1;
			}
		}
		this.api.datacenter.Temporary.QuestBook.quests.replaceAll(0,var4);
		this.api.ui.getUIComponent("Quests").setPendingCount(var3);
	}
	function onStep(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = var3[2];
		var var7 = new ank.utils.
();
		var var8 = var3[3];
		var var9 = var8.length != 0?var8.split(";"):new Array();
		var9.reverse();
		var var10 = var3[4];
		var var11 = var10.length != 0?var10.split(";"):new Array();
		var var12 = var3[5].split(";");
		var var13 = var12[0];
		var var14 = var12[1].split(",");
		var var15 = var6.split(";");
		var var16 = 0;
		while(var16 < var15.length)
		{
			var var17 = var15[var16].split(",");
			var var18 = Number(var17[0]);
			var var19 = var17[1] == "1";
			var var20 = new dofus.datacenter.QuestObjective(var18,var19);
			var7.push(var20);
			var16 = var16 + 1;
		}
		var var21 = this.api.datacenter.Temporary.QuestBook;
		var var22 = var21.getQuest(var4);
		if(var22 != null)
		{
			var var23 = new dofus.datacenter.(var5,1,var7,var9,var11,var13,var14);
			var22.addStep(var23);
			this.api.ui.getUIComponent("Quests").setStep(var23);
		}
		else
		{
			ank.utils.Logger.err("[onStep] Impossible de trouver l\'objet de quête");
		}
	}
}
