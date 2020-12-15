if(!dofus.aks.Items)
{
	if(!dofus)
	{
		_global.dofus = new Object();
	}
	if(!dofus.aks)
	{
		_global.dofus.aks = new Object();
	}
	dofus.aks.Items = function(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	} extends dofus.aks.Handler;
	var var1 = dofus.aks.Items = function(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}.prototype;
	var1.movement = function movement(var2, var3, var4)
	{
		if(var3 > 0)
		{
			this.api.kernel.GameManager.setAsModified(var3);
		}
		this.aks.send("OM" + var2 + "|" + var3 + (!_global.isNaN(var4)?"|" + var4:""),true);
	};
	var1.drop = function drop(var2, var3)
	{
		this.aks.send("OD" + var2 + "|" + var3,false);
	};
	var1.associateMimibiote = function associateMimibiote(var2, var3)
	{
		this.aks.send("AEi1|" + var2 + "|" + var3);
	};
	var1.destroyMimibiote = function destroyMimibiote(var2)
	{
		this.aks.send("AEi0|" + var2);
	};
	var1.destroy = function destroy(var2, var3)
	{
		this.aks.send("Od" + var2 + "|" + var3,false);
	};
	var1.use = function use(var2, var3, var4, var5)
	{
		this.aks.send("O" + (!var5?"U":"u") + var2 + (!(var3 != undefined && !_global.isNaN(Number(var3)))?"|":"|" + var3) + (var4 == undefined?"":"|" + var4),true);
	};
	var1.dissociate = function dissociate(var2, var3)
	{
		this.aks.send("Ox" + var2 + "|" + var3,false);
	};
	var1.setSkin = function setSkin(var2, var3, var4)
	{
		this.aks.send("Os" + var2 + "|" + var3 + "|" + var4,false);
	};
	var1.feed = function feed(var2, var3, var4)
	{
		this.aks.send("Of" + var2 + "|" + var3 + "|" + var4,false);
	};
	var1.onAccessories = function onAccessories(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1].split(",");
		var var6 = new Array();
		var var7 = 0;
		while(var7 < var5.length)
		{
			if(var5[var7].indexOf("~") != -1)
			{
				var var11 = var5[var7].split("~");
				var var8 = _global.parseInt(var11[0],16);
				var var10 = _global.parseInt(var11[1]);
				var var9 = _global.parseInt(var11[2]) - 1;
				if(var9 < 0)
				{
					var9 = 0;
				}
			}
			else
			{
				var8 = _global.parseInt(var5[var7],16);
				var10 = undefined;
				var9 = undefined;
			}
			if(!_global.isNaN(var8))
			{
				var var12 = new dofus.datacenter.(var8,var10,var9);
				var6[var7] = var12;
			}
			var7 = var7 + 1;
		}
		var var13 = this.api.datacenter.Sprites.getItemAt(var4);
		var13.accessories = var6;
		this.api.gfx.setForcedSpriteAnim(var4,"static");
		if(var4 == this.api.datacenter.Player.ID)
		{
			this.api.datacenter.Player.updateCloseCombat();
		}
	};
	var1.onDrop = function onDrop(var2, var3)
	{
		if(!var2)
		{
			switch(var3)
			{
				case "F":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("DROP_FULL"),"ERROR_BOX",{name:"DropFull"});
					break;
				case "E":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DROP_ITEM"),"ERROR_BOX");
			}
		}
	};
	var1.onAdd = function onAdd(var2, var3)
	{
		if(!var2)
		{
			switch(var3)
			{
				case "F":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("INVENTORY_FULL"),"ERROR_BOX",{name:"Full"});
					break;
				case "L":
				default:
					this.api.kernel.showMessage(undefined,this.api.lang.getText("TOO_LOW_LEVEL_FOR_ITEM"),"ERROR_BOX",{name:"LowLevel"});
					break;
				case "A":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_EQUIPED"),"ERROR_BOX",{name:"Already"});
			}
		}
		else
		{
			var var4 = var3.split("*");
			var var5 = 0;
			while(var5 < var4.length)
			{
				var var6 = var4[var5];
				var var7 = var6.charAt(0);
				var6 = var6.substr(1);
				if((var0 = var7) !== "G")
				{
					if(var0 !== "O")
					{
						ank.utils.Logger.err("Ajout d\'un type obj inconnu");
					}
					else
					{
						var var8 = var6.split(";");
						var var9 = 0;
						while(var9 < var8.length)
						{
							var var10 = this.api.kernel.CharactersManager.getItemObjectFromData(var8[var9]);
							if(var10 != undefined)
							{
								this.api.datacenter.Player.addItem(var10);
							}
							var9 = var9 + 1;
						}
					}
				}
				var5 = var5 + 1;
			}
		}
	};
	var1.onChange = function onChange(var2)
	{
		var var3 = var2.split("*");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4];
			var var6 = var5.split(";");
			var var7 = 0;
			while(var7 < var6.length)
			{
				var var8 = this.api.kernel.CharactersManager.getItemObjectFromData(var6[var7]);
				if(var8 != undefined)
				{
					this.api.datacenter.Player.updateItem(var8);
				}
				var7 = var7 + 1;
			}
			var4 = var4 + 1;
		}
	};
	var1.onRemove = function onRemove(var2)
	{
		var var3 = Number(var2);
		this.api.datacenter.Player.dropItem(var3);
	};
	var1.onQuantity = function onQuantity(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		this.api.datacenter.Player.updateItemQuantity(var4,var5);
	};
	var1.onMovement = function onMovement(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = !_global.isNaN(Number(var3[1]))?Number(var3[1]):-1;
		this.api.datacenter.Player.updateItemPosition(var4,var5);
	};
	var1.onTool = function onTool(var2)
	{
		var var3 = Number(var2);
		if(_global.isNaN(var3))
		{
			this.api.datacenter.Player.currentJobID = undefined;
		}
		else
		{
			this.api.datacenter.Player.currentJobID = var3;
		}
	};
	var1.onWeight = function onWeight(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		this.api.datacenter.Player.maxWeight = var5;
		this.api.datacenter.Player.currentWeight = var4;
	};
	var1.onItemSet = function onItemSet(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = Number(var4[0]);
		var var6 = String(var4[1]).split(";");
		var var7 = var4[2];
		if(var3)
		{
			var var8 = new dofus.datacenter.ItemSet(var5,var7,var6);
			this.api.datacenter.Player.ItemSets.addItemAt(var5,var8);
		}
		else
		{
			this.api.datacenter.Player.ItemSets.removeItemAt(var5);
		}
	};
	var1.onItemUseCondition = function onItemUseCondition(var2)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "G":
				var var4 = var2.substr(1).split("|");
				var var5 = !_global.isNaN(Number(var4[0]))?Number(var4[0]):0;
				var var6 = !_global.isNaN(Number(var4[1]))?Number(var4[1]):undefined;
				var var7 = !_global.isNaN(Number(var4[2]))?Number(var4[2]):undefined;
				var var8 = !_global.isNaN(Number(var4[3]))?Number(var4[3]):undefined;
				var var9 = {name:"UseItemGold",listener:this,params:{objectID:var5,spriteID:var6,cellID:var7}};
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_USE_CONDITION_GOLD",[var8]),"CAUTION_YESNO",var9);
				break;
			case "U":
				var var10 = var2.substr(1).split("|");
				var var11 = !_global.isNaN(Number(var10[0]))?Number(var10[0]):0;
				var var12 = !_global.isNaN(Number(var10[1]))?Number(var10[1]):undefined;
				var var13 = !_global.isNaN(Number(var10[2]))?Number(var10[2]):undefined;
				var var14 = !_global.isNaN(Number(var10[3]))?Number(var10[3]):undefined;
				var var15 = {name:"UseItem",listener:this,params:{objectID:var11,spriteID:var12,cellID:var13}};
				var var16 = new dofus.datacenter.(-1,var14,1,0,"",0);
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_USE_CONFIRMATION",[var16.name]),"CAUTION_YESNO",var15);
		}
	};
	var1.onItemFound = function onItemFound(var2)
	{
		var var3 = var2.split("|");
		var var4 = !_global.isNaN(Number(var3[0]))?Number(var3[0]):0;
		var var5 = !_global.isNaN(Number(var3[2]))?Number(var3[2]):0;
		var var6 = var3[1].split("~");
		var var7 = !_global.isNaN(Number(var6[0]))?Number(var6[0]):0;
		var var8 = !_global.isNaN(Number(var6[1]))?Number(var6[1]):0;
		if(var4 == 1)
		{
			if(var7 == 0)
			{
				var var9 = {iconFile:"KamaSymbol"};
			}
			else
			{
				var9 = new dofus.datacenter.(0,var7,var8);
			}
			this.api.gfx.addSpriteOverHeadItem(this.api.datacenter.Player.ID,"itemFound",dofus.graphics.battlefield.CraftResultOverHead,[true,var9],2000);
		}
	};
	var1.yes = function yes(var2)
	{
		switch(var2[§§constant(128)][§§constant(129)])
		{
			case §§constant(130):
				this[§§constant(26)](var2[§§constant(110)][§§constant(111)],var2[§§constant(110)][§§constant(112)],var2[§§constant(110)][§§constant(113)],true);
				break;
			case §§constant(131):
				this[§§constant(26)](var2[§§constant(110)][§§constant(111)],var2[§§constant(110)][§§constant(112)],var2[§§constant(110)][§§constant(113)],true);
		}
	};
	§§constant(132)(var1,null,1);
	dofus.aks.Items = function(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}[§§constant(133)] = §§constant(134);
	dofus.aks.Items = function(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}[§§constant(135)] = 16;
}
