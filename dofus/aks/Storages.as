class dofus.aks.Storages extends dofus.aks.Handler
{
	function Storages(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function onList(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = 0;
		while(loc5 < loc4.length)
		{
			var loc6 = loc4[loc5].split(";");
			var loc7 = loc6[0];
			var loc8 = loc6[1] == "1";
			var loc9 = this.api.datacenter.Storages;
			if(loc3)
			{
				var loc10 = loc9.getItemAt(loc7);
				if(loc10 == undefined)
				{
					loc10 = new dofus.datacenter.Storage();
				}
				loc10.isLocked = loc8;
				loc9.addItemAt(loc7,loc10);
			}
			else
			{
				loc9.removeItemAt(loc7);
			}
			loc5 = loc5 + 1;
		}
	}
	function onLockedProperty(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1] == "1";
		var loc6 = this.api.datacenter.Storages;
		var loc7 = loc6.getItemAt(loc4);
		if(loc7 == undefined)
		{
			loc7 = new dofus.datacenter.Storage(loc4);
			loc6.addItemAt(loc4,loc7);
		}
		loc7.isLocked = loc5;
	}
}
