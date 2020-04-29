class dofus.aks.Subareas extends dofus.aks.Handler
{
	function Subareas(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function onList(var2)
	{
		var var3 = var2.split("|");
		this.api.datacenter.Subareas.removeAll();
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = String(var3[var4]).split(";");
			var var6 = Number(var5[0]);
			var var7 = Number(var5[1]);
			var var8 = new dofus.datacenter.(var6,var7);
			this.api.datacenter.Subareas.addItemAt(var6,var8);
			var4 = var4 + 1;
		}
	}
	function onAlignmentModification(var2)
	{
		var var3 = String(var2).split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = Number(var3[2]) == 1;
		var var7 = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(var4);
		if(var7 == undefined)
		{
			var7 = new dofus.datacenter.(var4,var5);
			this.api.datacenter.Subareas.addItemAt(var4,var7);
		}
		else
		{
			var7.alignment.index = var5;
		}
		if(!var6)
		{
			if(var5 == -1)
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_PRISM_REMOVED",[var7.name]) + "</b>","PVP_CHAT");
			}
			else
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_IS",[var7.name,var7.alignment.name]) + "</b>","PVP_CHAT");
			}
		}
	}
}
