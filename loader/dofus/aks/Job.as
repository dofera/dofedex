class dofus.aks.Job extends dofus.aks.Handler
{
	function Job(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function changeJobStats(§\x04\x0f§, §\x1e\x17\f§, minSlots)
	{
		this.aks.send("JO" + var2 + "|" + var3 + "|" + minSlots);
	}
	function onSkills(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = this.api.datacenter.Player.Jobs;
		var var5 = 0;
		while(var5 < var3.length)
		{
			var var6 = var3[var5].split(";");
			var var7 = Number(var6[0]);
			var var8 = new ank.utils.
();
			var var9 = var6[1].split(",");
			var var10 = var9.length;
			while(true)
			{
				var10;
				if(var10-- > 0)
				{
					var var11 = var9[var10].split("~");
					var8.push(new dofus.datacenter.(var11[0],var11[1],var11[2],var11[3],var11[4]));
					continue;
				}
				break;
			}
			var var12 = new dofus.datacenter.Job(var7,var8);
			var var13 = var4.findFirstItem("id",var7);
			if(var13.index != -1)
			{
				var4.updateItem(var13.index,var12);
			}
			else
			{
				var4.push(var12);
			}
			var5 = var5 + 1;
		}
	}
	function onXP(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = this.api.datacenter.Player.Jobs;
		var var5 = var3.length;
		while(true)
		{
			var5;
			if(var5-- > 0)
			{
				var var6 = var3[var5].split(";");
				var var7 = Number(var6[0]);
				var var8 = Number(var6[1]);
				var var9 = Number(var6[2]);
				var var10 = Number(var6[3]);
				var var11 = Number(var6[4]);
				var var12 = var4.findFirstItem("id",var7);
				if(var12.index != -1)
				{
					var var13 = var12.item;
					var13.level = var8;
					var13.xpMin = var9;
					var13.xpMax = var11;
					var13.xp = var10;
					var4.updateItem(var12.index,var13);
				}
				continue;
			}
			break;
		}
	}
	function onLevel(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("NEW_JOB_LEVEL",[this.api.lang.getJobText(var4).n,var5]),"ERROR_BOX",{name:"NewJobLevel"});
	}
	function onRemove(§\x1e\x12\x1a§)
	{
		var var3 = Number(var2);
		var var4 = this.api.datacenter.Player.Jobs;
		var var5 = var4.findFirstItem("id",var3);
		if(var5.index != -1)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_JOB",[var5.item.name]),"INFO_CHAT");
			var4.removeItems(var5.index,1);
		}
	}
	function onOptions(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = Number(var3[2]);
		this.api.datacenter.Player.Jobs[var4].options = new dofus.datacenter.(var5,var6);
	}
}
