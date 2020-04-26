class dofus.aks.Quests extends dofus.aks.Handler
{
	function Quests(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function getList()
	{
		this.aks.send("QL");
	}
	function getStep(loc2, loc3)
	{
		this.aks.send("QS" + loc2 + (loc3 == undefined?"":"|" + (loc3 <= 0?loc3:"+" + loc3)));
	}
	function onList(loc2)
	{
		var loc3 = 0;
		var loc4 = new Array();
		if(loc2.length != 0)
		{
			var loc5 = loc2.split("|");
			var loc6 = 0;
			while(loc6 < loc5.length)
			{
				var loc7 = loc5[loc6].split(";");
				var loc8 = Number(loc7[0]);
				var loc9 = loc7[1] == "1";
				var loc10 = Number(loc7[2]);
				if(!loc9)
				{
					loc3 = loc3 + 1;
				}
				var loc11 = new dofus.datacenter.(loc8,loc9,loc10);
				loc4.push(loc11);
				loc6 = loc6 + 1;
			}
		}
		this.api.datacenter.Temporary.QuestBook.quests.replaceAll(0,loc4);
		this.api.ui.getUIComponent("Quests").setPendingCount(loc3);
	}
	function onStep(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = loc3[2];
		var loc7 = new ank.utils.();
		var loc8 = loc3[3];
		var loc9 = loc8.length != 0?loc8.split(";"):new Array();
		loc9.reverse();
		var loc10 = loc3[4];
		var loc11 = loc10.length != 0?loc10.split(";"):new Array();
		var loc12 = loc3[5].split(";");
		var loc13 = loc12[0];
		var loc14 = loc12[1].split(",");
		var loc15 = loc6.split(";");
		var loc16 = 0;
		while(loc16 < loc15.length)
		{
			var loc17 = loc15[loc16].split(",");
			var loc18 = Number(loc17[0]);
			var loc19 = loc17[1] == "1";
			var loc20 = new dofus.datacenter.(loc18,loc19);
			loc7.push(loc20);
			loc16 = loc16 + 1;
		}
		var loc21 = this.api.datacenter.Temporary.QuestBook;
		var loc22 = loc21.getQuest(loc4);
		if(loc22 != null)
		{
			var loc23 = new dofus.datacenter.(loc5,1,loc7,loc9,loc11,loc13,loc14);
			loc22.addStep(loc23);
			this.api.ui.getUIComponent("Quests").setStep(loc23);
		}
		else
		{
			ank.utils.Logger.err("[onStep] Impossible de trouver l\'objet de quête");
		}
	}
}
