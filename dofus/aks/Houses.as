class dofus.aks.Houses extends dofus.aks.Handler
{
	function Houses(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function kick(loc2)
	{
		this.aks.send("hQ" + loc2);
	}
	function leave()
	{
		this.aks.send("hV");
	}
	function sell(loc2)
	{
		this.aks.send("hS" + loc2,true);
	}
	function buy(loc2)
	{
		this.aks.send("hB" + loc2,true);
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
	function rights(loc2)
	{
		this.aks.send("hG" + loc2,true);
	}
	function onList(loc2)
	{
		if(loc2.length == 0)
		{
			this.api.datacenter.Houses = new ank.utils.();
			return undefined;
		}
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = 0;
		while(loc5 < loc4.length)
		{
			var loc6 = loc4[loc5].split(";");
			var loc7 = loc6[0];
			var loc8 = loc6[1] == "1";
			var loc9 = loc6[2] == "1";
			var loc10 = loc4[3] == "1";
			var loc11 = this.api.datacenter.Houses;
			if(loc3)
			{
				var loc12 = loc11.getItemAt(loc7);
				if(loc12 == undefined)
				{
					loc12 = new dofus.datacenter.(loc7);
				}
				loc12.localOwner = loc3;
				loc12.isLocked = loc8;
				loc12.isForSale = loc9;
				loc12.isShared = loc10;
				loc11.addItemAt(loc7,loc12);
			}
			else
			{
				var loc13 = loc11.getItemAt(loc7);
				loc13.localOwner = false;
				var loc14 = this.api.lang.getHousesMapText(this.api.datacenter.Map.id);
				if(loc14 == loc7)
				{
					this.api.ui.unloadUIComponent("HouseIndoor");
				}
			}
			loc5 = loc5 + 1;
		}
	}
	function onProperties(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1].split(";");
		var loc6 = loc5[0];
		var loc7 = loc5[1] == "1";
		var loc8 = loc5[2];
		var loc9 = this.api.kernel.CharactersManager.createGuildEmblem(loc5[3]);
		var loc10 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(loc4);
		if(loc10 == undefined)
		{
			loc10 = new dofus.datacenter.(loc4);
			this.api.datacenter.Houses.addItemAt(loc4,loc10);
		}
		loc10.ownerName = loc6;
		loc10.isForSale = loc7;
		loc10.guildName = loc8;
		loc10.guildEmblem = loc9;
	}
	function onLockedProperty(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1] == "1";
		var loc6 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(loc4);
		if(loc6 == undefined)
		{
			loc6 = new dofus.datacenter.(loc4);
			this.api.datacenter.Houses.addItemAt(loc4,loc6);
		}
		loc6.isLocked = loc5;
	}
	function onCreate(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(loc4);
		if(loc6 == undefined)
		{
			loc6 = new dofus.datacenter.(loc4);
		}
		loc6.price = loc5;
		this.api.ui.loadUIComponent("HouseSale","HouseSale",{house:loc6});
	}
	function onSell(loc2, loc3)
	{
		var loc4 = loc3.split("|");
		var loc5 = Number(loc4[0]);
		var loc6 = Number(loc4[1]);
		var loc7 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(loc5);
		if(loc7 == undefined)
		{
			loc7 = new dofus.datacenter.(loc5);
		}
		loc7.isForSale = loc6 > 0;
		loc7.price = loc6;
		if(loc6 > 0)
		{
			if(loc2)
			{
				this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_SELL",[loc7.name,loc7.price]),"ERROR_BOX",{name:"SellHouse"});
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_SELL_HOUSE"),"ERROR_BOX",{name:"SellHouse"});
			}
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_NOSELL",[loc7.name]),"ERROR_BOX",{name:"NoSellHouse"});
		}
	}
	function onBuy(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = loc3.split("|");
			var loc5 = Number(loc4[0]);
			var loc6 = Number(loc4[1]);
			var loc7 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(loc5);
			if(loc7 == undefined)
			{
				loc7 = new dofus.datacenter.(loc5);
			}
			loc7.price = loc6;
			this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_BUY",[loc7.name,loc7.price]),"ERROR_BOX",{name:"BuyHouse"});
			loc7.isForSale = false;
			loc7.price = 0;
		}
		else if((var loc0 = loc3.charAt(0)) === "C")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BUY_HOUSE",[loc3.substr(1)]),"ERROR_BOX",{name:"BuyHouse"});
		}
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("HouseSale");
	}
	function onGuildInfos(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = Number(loc3[0]);
		var loc5 = true;
		var loc6 = new String();
		var loc7 = new Object();
		var loc8 = 0;
		if(loc3.length < 4)
		{
			loc5 = false;
		}
		else
		{
			loc5 = true;
			loc6 = loc3[1];
			loc7 = this.api.kernel.CharactersManager.createGuildEmblem(loc3[2]);
			loc8 = Number(loc3[3]);
		}
		var loc9 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(loc4);
		if(loc9 == undefined)
		{
			loc9 = new dofus.datacenter.(loc4);
			this.api.datacenter.Houses.addItemAt(loc4,loc9);
		}
		loc9.isShared = loc5;
		loc9.guildName = loc6;
		loc9.guildEmblem = loc7;
		loc9.guildRights = loc8;
	}
}
