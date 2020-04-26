class dofus.aks.Mount extends dofus.aks.Handler
{
	function Mount(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function rename(loc2)
	{
		this.aks.send("Rn" + loc2,true);
	}
	function kill()
	{
		this.aks.send("Rf");
	}
	function setXP(loc2)
	{
		this.aks.send("Rx" + loc2,true);
	}
	function ride()
	{
		this.aks.send("Rr",false);
	}
	function data(loc2, loc3)
	{
		this.aks.send("Rd" + loc2 + "|" + loc3,true);
	}
	function parkMountData(loc2)
	{
		this.aks.send("Rp" + loc2,true);
	}
	function removeObjectInPark(loc2)
	{
		this.aks.send("Ro" + loc2,true);
	}
	function mountParkSell(loc2)
	{
		this.aks.send("Rs" + loc2,true);
	}
	function mountParkBuy(loc2)
	{
		this.aks.send("Rb" + loc2,true);
	}
	function leave()
	{
		this.aks.send("Rv");
	}
	function castrate()
	{
		this.aks.send("Rc");
	}
	function onEquip(loc2)
	{
		var loc3 = loc2.charAt(0);
		switch(loc3)
		{
			case "+":
				this.api.datacenter.Player.mount = this.createMount(loc2.substr(1));
				break;
			case "-":
				this.unequipMount();
				break;
			case "E":
				this.equipError(loc2.charAt(1));
		}
	}
	function onXP(loc2)
	{
		var loc3 = Number(loc2);
		if(!_global.isNaN(loc3))
		{
			this.api.datacenter.Player.mountXPPercent = loc3;
		}
	}
	function onName(loc2)
	{
		this.api.datacenter.Player.mount.name = loc2;
	}
	function onData(loc2)
	{
		var loc3 = this.createMount(loc2);
		this.api.ui.loadUIComponent("MountViewer","MountViewer",{mount:loc3});
	}
	function onMountPark(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = Number(loc3[2]);
		var loc7 = Number(loc3[3]);
		var loc8 = loc3[4];
		var loc9 = loc3[5];
		var loc10 = this.api.kernel.CharactersManager.createGuildEmblem(loc9);
		this.api.datacenter.Map.mountPark = new dofus.datacenter.(loc4,loc5,loc6,loc7,loc8,loc10);
	}
	function onRidingState(loc2)
	{
		var loc3 = loc2.charAt(0);
		switch(loc3)
		{
			case "+":
				this.api.datacenter.Player.isRiding = true;
				break;
			case "-":
				this.api.datacenter.Player.isRiding = false;
		}
	}
	function onMountParkBuy(loc2)
	{
		var loc3 = loc2.split("|");
		this.api.ui.loadUIComponent("MountParkSale","MountParkSale",{defaultPrice:Number(loc3[1])});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("MountParkSale");
	}
	function equipError(loc2)
	{
		switch(loc2)
		{
			case "-":
				var loc3 = this.api.lang.getText("MOUNT_ERROR_INVENTORY_NOT_EMPTY");
				break;
			case "+":
				loc3 = this.api.lang.getText("MOUNT_ERROR_ALREADY_HAVE_ONE");
				break;
			case "r":
				loc3 = this.api.lang.getText("MOUNT_ERROR_RIDE");
		}
		this.api.kernel.showMessage(undefined,loc3,"ERROR_CHAT");
	}
	function unequipMount()
	{
		this.api.datacenter.Player.mount = undefined;
	}
	function createMount(§\x1e\x11\x05§, newBorn)
	{
		var loc4 = loc2.split(":");
		var loc5 = Number(loc4[1]);
		var loc6 = new dofus.datacenter.Mount(loc5,undefined,newBorn);
		loc6.ID = loc4[0];
		loc6.ancestors = loc4[2].split(",");
		var loc7 = loc4[3].split(",");
		loc6.capacities = new ank.utils.();
		var loc8 = 0;
		while(loc8 < loc7.length)
		{
			var loc9 = Number(loc7[loc8]);
			if(loc9 != 0 && !_global.isNaN(loc9))
			{
				loc6.capacities.push({label:this.api.lang.getMountCapacity(loc9).n,data:loc9});
			}
			loc8 = loc8 + 1;
		}
		loc6.name = loc4[4] != ""?loc4[4]:this.api.lang.getText("NO_NAME");
		loc6.sex = Number(loc4[5]);
		var loc10 = loc4[6].split(",");
		loc6.xp = Number(loc10[0]);
		loc6.xpMin = Number(loc10[1]);
		loc6.xpMax = Number(loc10[2]);
		loc6.level = Number(loc4[7]);
		loc6.mountable = !!Number(loc4[8]);
		loc6.podsMax = Number(loc4[9]);
		loc6.wild = !!Number(loc4[10]);
		var loc11 = loc4[11].split(",");
		loc6.stamina = Number(loc11[0]);
		loc6.staminaMax = Number(loc11[1]);
		var loc12 = loc4[12].split(",");
		loc6.maturity = Number(loc12[0]);
		loc6.maturityMax = Number(loc12[1]);
		var loc13 = loc4[13].split(",");
		loc6.energy = Number(loc13[0]);
		loc6.energyMax = Number(loc13[1]);
		var loc14 = loc4[14].split(",");
		loc6.serenity = Number(loc14[0]);
		loc6.serenityMin = Number(loc14[1]);
		loc6.serenityMax = Number(loc14[2]);
		var loc15 = loc4[15].split(",");
		loc6.love = Number(loc15[0]);
		loc6.loveMax = Number(loc15[1]);
		loc6.fecondation = Number(loc4[16]);
		loc6.fecondable = !!Number(loc4[17]);
		loc6.setEffects(loc4[18]);
		var loc16 = loc4[19].split(",");
		loc6.tired = Number(loc16[0]);
		loc6.tiredMax = Number(loc16[1]);
		var loc17 = loc4[20].split(",");
		loc6.reprod = Number(loc17[0]);
		loc6.reprodMax = Number(loc17[1]);
		return loc6;
	}
}
