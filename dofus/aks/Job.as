class dofus.aks.Job extends dofus.aks.Handler
{
	function Job(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function changeJobStats(§\x05\x12§, §\x1e\x18\x14§, minSlots)
	{
		this.aks.send("JO" + loc2 + "|" + loc3 + "|" + minSlots);
	}
	function onSkills(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = this.api.datacenter.Player.Jobs;
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = loc3[loc5].split(";");
			var loc7 = Number(loc6[0]);
			var loc8 = new ank.utils.();
			var loc9 = loc6[1].split(",");
			var loc10 = loc9.length;
			while(true)
			{
				loc10;
				if(loc10-- > 0)
				{
					var loc11 = loc9[loc10].split("~");
					loc8.push(new dofus.datacenter.(loc11[0],loc11[1],loc11[2],loc11[3],loc11[4]));
					continue;
				}
				break;
			}
			var loc12 = new dofus.datacenter.Job(loc7,loc8);
			var loc13 = loc4.findFirstItem("id",loc7);
			if(loc13.index != -1)
			{
				loc4.updateItem(loc13.index,loc12);
			}
			else
			{
				loc4.push(loc12);
			}
			loc5 = loc5 + 1;
		}
	}
	function onXP(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = this.api.datacenter.Player.Jobs;
		var loc5 = loc3.length;
		while(true)
		{
			loc5;
			if(loc5-- > 0)
			{
				var loc6 = loc3[loc5].split(";");
				var loc7 = Number(loc6[0]);
				var loc8 = Number(loc6[1]);
				var loc9 = Number(loc6[2]);
				var loc10 = Number(loc6[3]);
				var loc11 = Number(loc6[4]);
				var loc12 = loc4.findFirstItem("id",loc7);
				if(loc12.index != -1)
				{
					var loc13 = loc12.item;
					loc13.level = loc8;
					loc13.xpMin = loc9;
					loc13.xpMax = loc11;
					loc13.xp = loc10;
					loc4.updateItem(loc12.index,loc13);
				}
				continue;
			}
			break;
		}
	}
	function onLevel(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("NEW_JOB_LEVEL",[this.api.lang.getJobText(loc4).n,loc5]),"ERROR_BOX",{name:"NewJobLevel"});
	}
	function onRemove(loc2)
	{
		var loc3 = Number(loc2);
		var loc4 = this.api.datacenter.Player.Jobs;
		var loc5 = loc4.findFirstItem("id",loc3);
		if(loc5.index != -1)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_JOB",[loc5.item.name]),"INFO_CHAT");
			loc4.removeItems(loc5.index,1);
		}
	}
	function onOptions(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = Number(loc3[2]);
		this.api.datacenter.Player.Jobs[loc4].options = new dofus.datacenter.(loc5,loc6);
	}
}
