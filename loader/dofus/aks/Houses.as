class dofus.aks.Houses extends dofus.aks.Handler
{
	function Houses(var2, var3)
	{
		super.initialize(var3,var4);
	}
	function kick(var2)
	{
		this.aks.send("hQ" + var2);
	}
	function leave()
	{
		this.aks.send("hV");
	}
	function sell(var2)
	{
		this.aks.send("hS" + var2,true);
	}
	function buy(var2)
	{
		this.aks.send("hB" + var2,true);
	}
	function state()
	{
		this.aks.send("hG",true);
	}
	function share()
	{
		this.aks.send("hG+",true);
	}
	function unshare()
	{
		this.aks.send("hG-",true);
	}
	function rights(var2)
	{
		this.aks.send("hG" + var2,true);
	}
	function onList(var2)
	{
		if(var2.length == 0)
		{
			this.api.datacenter.Houses = new ank.utils.();
			return undefined;
		}
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = 0;
		while(var5 < var4.length)
		{
			var var6 = var4[var5].split(";");
			var var7 = var6[0];
			var var8 = var6[1] == "1";
			var var9 = var6[2] == "1";
			var var10 = var4[3] == "1";
			var var11 = this.api.datacenter.Houses;
			if(var3)
			{
				var var12 = var11.getItemAt(var7);
				if(var12 == undefined)
				{
					var12 = new dofus.datacenter.(var7);
				}
				var12.localOwner = var3;
				var12.isLocked = var8;
				var12.isForSale = var9;
				var12.isShared = var10;
				var11.addItemAt(var7,var12);
			}
			else
			{
				var var13 = var11.getItemAt(var7);
				var13.localOwner = false;
				var var14 = this.api.lang.getHousesMapText(this.api.datacenter.Map.id);
				if(var14 == var7)
				{
					this.api.ui.unloadUIComponent("HouseIndoor");
				}
			}
			var5 = var5 + 1;
		}
	}
	function onProperties(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1].split(";");
		var var6 = var5[0];
		var var7 = var5[1] == "1";
		var var8 = var5[2];
		var var9 = this.api.kernel.CharactersManager.createGuildEmblem(var5[3]);
		var var10 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(var4);
		if(var10 == undefined)
		{
			var10 = new dofus.datacenter.(var4);
			this.api.datacenter.Houses.addItemAt(var4,var10);
		}
		var10.ownerName = var6;
		var10.isForSale = var7;
		var10.guildName = var8;
		var10.guildEmblem = var9;
	}
	function onLockedProperty(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1] == "1";
		var var6 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(var4);
		if(var6 == undefined)
		{
			var6 = new dofus.datacenter.(var4);
			this.api.datacenter.Houses.addItemAt(var4,var6);
		}
		var6.isLocked = var5;
	}
	function onCreate(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(var4);
		if(var6 == undefined)
		{
			var6 = new dofus.datacenter.(var4);
		}
		var6.price = var5;
		this.api.ui.loadUIComponent("HouseSale","HouseSale",{house:var6});
	}
	function onSell(var2, var3)
	{
		var var4 = var3.split("|");
		var var5 = Number(var4[0]);
		var var6 = Number(var4[1]);
		var var7 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(var5);
		if(var7 == undefined)
		{
			var7 = new dofus.datacenter.(var5);
		}
		var7.isForSale = var6 > 0;
		var7.price = var6;
		if(var6 > 0)
		{
			if(var2)
			{
				this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_SELL",[var7.name,var7.price]),"ERROR_BOX",{name:"SellHouse"});
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_SELL_HOUSE"),"ERROR_BOX",{name:"SellHouse"});
			}
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_NOSELL",[var7.name]),"ERROR_BOX",{name:"NoSellHouse"});
		}
	}
	function onBuy(var2, var3)
	{
		if(var2)
		{
			var var4 = var3.split("|");
			var var5 = Number(var4[0]);
			var var6 = Number(var4[1]);
			var var7 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(var5);
			if(var7 == undefined)
			{
				var7 = new dofus.datacenter.(var5);
			}
			var7.price = var6;
			this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_BUY",[var7.name,var7.price]),"ERROR_BOX",{name:"BuyHouse"});
			var7.isForSale = false;
			var7.price = 0;
		}
		else if((var var0 = var3.charAt(0)) === "C")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BUY_HOUSE",[var3.substr(1)]),"ERROR_BOX",{name:"BuyHouse"});
		}
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("HouseSale");
	}
	function onGuildInfos(var2)
	{
		var var3 = var2.split(";");
		var var4 = Number(var3[0]);
		var var5 = true;
		var var6 = new String();
		var var7 = new Object();
		var var8 = 0;
		if(var3.length < 4)
		{
			var5 = false;
		}
		else
		{
			var5 = true;
			var6 = var3[1];
			var7 = this.api.kernel.CharactersManager.createGuildEmblem(var3[2]);
			var8 = Number(var3[3]);
		}
		var var9 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(var4);
		if(var9 == undefined)
		{
			var9 = new dofus.datacenter.(var4);
			this.api.datacenter.Houses.addItemAt(var4,var9);
		}
		var9.isShared = var5;
		var9.guildName = var6;
		var9.guildEmblem = var7;
		var9.guildRights = var8;
	}
}
