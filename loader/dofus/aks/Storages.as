class dofus.aks.Storages extends dofus.aks.Handler
{
	function Storages(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function onList(§\x1e\x12\x1a§)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = 0;
		while(var5 < var4.length)
		{
			var var6 = var4[var5].split(";");
			var var7 = var6[0];
			var var8 = var6[1] == "1";
			var var9 = this.api.datacenter.Storages;
			if(var3)
			{
				var var10 = var9.getItemAt(var7);
				if(var10 == undefined)
				{
					var10 = new dofus.datacenter.Storage();
				}
				var10.isLocked = var8;
				var9.addItemAt(var7,var10);
			}
			else
			{
				var9.removeItemAt(var7);
			}
			var5 = var5 + 1;
		}
	}
	function onLockedProperty(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1] == "1";
		var var6 = this.api.datacenter.Storages;
		var var7 = var6.getItemAt(var4);
		if(var7 == undefined)
		{
			var7 = new dofus.datacenter.Storage(var4);
			var6.addItemAt(var4,var7);
		}
		var7.isLocked = var5;
	}
}
