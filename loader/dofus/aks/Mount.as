class dofus.aks.Mount extends dofus.aks.Handler
{
	function Mount(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function rename(§\x1e\x10\x06§)
	{
		this.aks.send("Rn" + var2,true);
	}
	function kill()
	{
		this.aks.send("Rf");
	}
	function setXP(§\x1e\x1b\x17§)
	{
		this.aks.send("Rx" + var2,true);
	}
	function ride()
	{
		this.aks.send("Rr",false);
	}
	function data(§\x02\x16§, §\x1e\f\x1d§)
	{
		this.aks.send("Rd" + var2 + "|" + var3,true);
	}
	function parkMountData(§\x1e\x1d\f§)
	{
		this.aks.send("Rp" + var2,true);
	}
	function removeObjectInPark(§\b\x02§)
	{
		this.aks.send("Ro" + var2,true);
	}
	function mountParkSell(§\x01\x14§)
	{
		this.aks.send("Rs" + var2,true);
	}
	function mountParkBuy(§\x01\x14§)
	{
		this.aks.send("Rb" + var2,true);
	}
	function leave()
	{
		this.aks.send("Rv");
	}
	function castrate()
	{
		this.aks.send("Rc");
	}
	function onEquip(§\x1e\x12\x1a§)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "+":
				this.api.datacenter.Player.mount = this.createMount(var2.substr(1));
				break;
			case "-":
				this.unequipMount();
				break;
			case "E":
				this.equipError(var2.charAt(1));
		}
	}
	function onXP(§\x1e\x12\x1a§)
	{
		var var3 = Number(var2);
		if(!_global.isNaN(var3))
		{
			this.api.datacenter.Player.mountXPPercent = var3;
		}
	}
	function onName(§\x1e\x12\x1a§)
	{
		this.api.datacenter.Player.mount.name = var2;
	}
	function onData(§\x1e\x12\x1a§)
	{
		var var3 = this.createMount(var2);
		this.api.ui.loadUIComponent("MountViewer","MountViewer",{mount:var3});
	}
	function onMountPark(§\x1e\x12\x1a§)
	{
		var var3 = var2.split(";");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = Number(var3[2]);
		var var7 = Number(var3[3]);
		var var8 = var3[4];
		var var9 = var3[5];
		var var10 = this.api.kernel.CharactersManager.createGuildEmblem(var9);
		this.api.datacenter.Map.mountPark = new dofus.datacenter.

(var4,var5,var6,var7,var8,var10);
	}
	function onRidingState(§\x1e\x12\x1a§)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "+":
			default:
				this.api.datacenter.Player.isRiding = true;
				break;
			case "-":
				this.api.datacenter.Player.isRiding = false;
		}
	}
	function onMountParkBuy(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		this.api.ui.loadUIComponent("MountParkSale","MountParkSale",{defaultPrice:Number(var3[1])});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("MountParkSale");
	}
	function equipError(§\x0f\x0e§)
	{
		switch(var2)
		{
			case "-":
				var var3 = this.api.lang.getText("MOUNT_ERROR_INVENTORY_NOT_EMPTY");
				break;
			case "+":
				var3 = this.api.lang.getText("MOUNT_ERROR_ALREADY_HAVE_ONE");
				break;
			case "r":
				var3 = this.api.lang.getText("MOUNT_ERROR_RIDE");
		}
		this.api.kernel.showMessage(undefined,var3,"ERROR_CHAT");
	}
	function unequipMount()
	{
		this.api.datacenter.Player.mount = undefined;
	}
	function createMount(§\x1e\x0f\x13§, newBorn)
	{
		var var4 = var2.split(":");
		var var5 = Number(var4[1]);
		var var6 = new dofus.datacenter.Mount(var5,undefined,newBorn);
		var6.ID = var4[0];
		var6.ancestors = var4[2].split(",");
		var var7 = var4[3].split(",");
		var6.capacities = new ank.utils.
();
		var var8 = 0;
		while(var8 < var7.length)
		{
			var var9 = Number(var7[var8]);
			if(var9 != 0 && !_global.isNaN(var9))
			{
				var6.capacities.push({label:this.api.lang.getMountCapacity(var9).n,data:var9});
			}
			var8 = var8 + 1;
		}
		var6.name = var4[4] != ""?var4[4]:this.api.lang.getText("NO_NAME");
		var6.sex = Number(var4[5]);
		var var10 = var4[6].split(",");
		var6.xp = Number(var10[0]);
		var6.xpMin = Number(var10[1]);
		var6.xpMax = Number(var10[2]);
		var6.level = Number(var4[7]);
		var6.mountable = !!Number(var4[8]);
		var6.podsMax = Number(var4[9]);
		var6.wild = !!Number(var4[10]);
		var var11 = var4[11].split(",");
		var6.stamina = Number(var11[0]);
		var6.staminaMax = Number(var11[1]);
		var var12 = var4[12].split(",");
		var6.maturity = Number(var12[0]);
		var6.maturityMax = Number(var12[1]);
		var var13 = var4[13].split(",");
		var6.energy = Number(var13[0]);
		var6.energyMax = Number(var13[1]);
		var var14 = var4[14].split(",");
		var6.serenity = Number(var14[0]);
		var6.serenityMin = Number(var14[1]);
		var6.serenityMax = Number(var14[2]);
		var var15 = var4[15].split(",");
		var6.love = Number(var15[0]);
		var6.loveMax = Number(var15[1]);
		var6.fecondation = Number(var4[16]);
		var6.fecondable = !!Number(var4[17]);
		var6.setEffects(var4[18]);
		var var16 = var4[19].split(",");
		var6.tired = Number(var16[0]);
		var6.tiredMax = Number(var16[1]);
		var var17 = var4[20].split(",");
		var6.reprod = Number(var17[0]);
		var6.reprodMax = Number(var17[1]);
		return var6;
	}
}
