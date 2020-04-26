class dofus.aks.Subareas extends dofus.aks.Handler
{
	function Subareas(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function onList(loc2)
	{
		var loc3 = loc2.split("|");
		this.api.datacenter.Subareas.removeAll();
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = String(loc3[loc4]).split(";");
			var loc6 = Number(loc5[0]);
			var loc7 = Number(loc5[1]);
			var loc8 = new dofus.datacenter.(loc6,loc7);
			this.api.datacenter.Subareas.addItemAt(loc6,loc8);
			loc4 = loc4 + 1;
		}
	}
	function onAlignmentModification(loc2)
	{
		var loc3 = String(loc2).split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = Number(loc3[2]) == 1;
		var loc7 = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(loc4);
		if(loc7 == undefined)
		{
			loc7 = new dofus.datacenter.(loc4,loc5);
			this.api.datacenter.Subareas.addItemAt(loc4,loc7);
		}
		else
		{
			loc7.alignment.index = loc5;
		}
		if(!loc6)
		{
			if(loc5 == -1)
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_PRISM_REMOVED",[loc7.name]) + "</b>","PVP_CHAT");
			}
			else
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_IS",[loc7.name,loc7.alignment.name]) + "</b>","PVP_CHAT");
			}
		}
	}
}
