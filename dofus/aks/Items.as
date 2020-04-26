class dofus.aks.Items extends dofus.aks.Handler
{
	function Items(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function movement(loc2, loc3, loc4)
	{
		if(loc3 > 0)
		{
			this.api.kernel.GameManager.setAsModified(loc3);
		}
		this.aks.send("OM" + loc2 + "|" + loc3 + (!_global.isNaN(loc4)?"|" + loc4:""),true);
	}
	function drop(loc2, loc3)
	{
		this.aks.send("OD" + loc2 + "|" + loc3,false);
	}
	function destroy(loc2, loc3)
	{
		this.aks.send("Od" + loc2 + "|" + loc3,false);
	}
	function use(loc2, loc3, loc4, loc5)
	{
		this.aks.send("O" + (!loc5?"U":"u") + loc2 + (!(loc3 != undefined && !_global.isNaN(Number(loc3)))?"|":"|" + loc3) + (loc4 == undefined?"":"|" + loc4),true);
	}
	function dissociate(loc2, loc3)
	{
		this.aks.send("Ox" + loc2 + "|" + loc3,false);
	}
	function setSkin(loc2, loc3, loc4)
	{
		this.aks.send("Os" + loc2 + "|" + loc3 + "|" + loc4,false);
	}
	function feed(loc2, loc3, loc4)
	{
		this.aks.send("Of" + loc2 + "|" + loc3 + "|" + loc4,false);
	}
	function onAccessories(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1].split(",");
		var loc6 = new Array();
		var loc7 = 0;
		while(loc7 < loc5.length)
		{
			if(loc5[loc7].indexOf("~") != -1)
			{
				var loc11 = loc5[loc7].split("~");
				var loc8 = _global.parseInt(loc11[0],16);
				var loc10 = _global.parseInt(loc11[1]);
				var loc9 = _global.parseInt(loc11[2]) - 1;
				if(loc9 < 0)
				{
					loc9 = 0;
				}
			}
			else
			{
				loc8 = _global.parseInt(loc5[loc7],16);
				loc10 = undefined;
				loc9 = undefined;
			}
			if(!_global.isNaN(loc8))
			{
				var loc12 = new dofus.datacenter.(loc8,loc10,loc9);
				loc6[loc7] = loc12;
			}
			loc7 = loc7 + 1;
		}
		var loc13 = this.api.datacenter.Sprites.getItemAt(loc4);
		loc13.accessories = loc6;
		this.api.gfx.setForcedSpriteAnim(loc4,"static");
		if(loc4 == this.api.datacenter.Player.ID)
		{
			this.api.datacenter.Player.updateCloseCombat();
		}
	}
	function onDrop(loc2, loc3)
	{
		if(!loc2)
		{
			switch(loc3)
			{
				case "F":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("DROP_FULL"),"ERROR_BOX",{name:"DropFull"});
					break;
				case "E":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DROP_ITEM"),"ERROR_BOX");
			}
		}
	}
	function onAdd(loc2, loc3)
	{
		if(!loc2)
		{
			switch(loc3)
			{
				case "F":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("INVENTORY_FULL"),"ERROR_BOX",{name:"Full"});
					break;
				case "L":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("TOO_LOW_LEVEL_FOR_ITEM"),"ERROR_BOX",{name:"LowLevel"});
					break;
				case "A":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_EQUIPED"),"ERROR_BOX",{name:"Already"});
			}
		}
		else
		{
			var loc4 = loc3.split("*");
			var loc5 = 0;
			while(loc5 < loc4.length)
			{
				var loc6 = loc4[loc5];
				var loc7 = loc6.charAt(0);
				loc6 = loc6.substr(1);
				switch(loc7)
				{
					case "G":
						break;
					case "O":
						var loc8 = loc6.split(";");
						var loc9 = 0;
						while(loc9 < loc8.length)
						{
							var loc10 = this.api.kernel.CharactersManager.getItemObjectFromData(loc8[loc9]);
							if(loc10 != undefined)
							{
								this.api.datacenter.Player.addItem(loc10);
							}
							loc9 = loc9 + 1;
						}
						break;
					default:
						ank.utils.Logger.err("Ajout d\'un type obj inconnu");
				}
				loc5 = loc5 + 1;
			}
		}
	}
	function onChange(loc2)
	{
		var loc3 = loc2.split("*");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4];
			var loc6 = loc5.split(";");
			var loc7 = 0;
			while(loc7 < loc6.length)
			{
				var loc8 = this.api.kernel.CharactersManager.getItemObjectFromData(loc6[loc7]);
				if(loc8 != undefined)
				{
					this.api.datacenter.Player.updateItem(loc8);
				}
				loc7 = loc7 + 1;
			}
			loc4 = loc4 + 1;
		}
	}
	function onRemove(loc2)
	{
		var loc3 = Number(loc2);
		this.api.datacenter.Player.dropItem(loc3);
	}
	function onQuantity(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		this.api.datacenter.Player.updateItemQuantity(loc4,loc5);
	}
	function onMovement(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = !_global.isNaN(Number(loc3[1]))?Number(loc3[1]):-1;
		this.api.datacenter.Player.updateItemPosition(loc4,loc5);
	}
	function onTool(loc2)
	{
		var loc3 = Number(loc2);
		if(_global.isNaN(loc3))
		{
			this.api.datacenter.Player.currentJobID = undefined;
		}
		else
		{
			this.api.datacenter.Player.currentJobID = loc3;
		}
	}
	function onWeight(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		this.api.datacenter.Player.maxWeight = loc5;
		this.api.datacenter.Player.currentWeight = loc4;
	}
	function onItemSet(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = Number(loc4[0]);
		var loc6 = String(loc4[1]).split(";");
		var loc7 = loc4[2];
		if(loc3)
		{
			var loc8 = new dofus.datacenter.ItemSet(loc5,loc7,loc6);
			this.api.datacenter.Player.ItemSets.addItemAt(loc5,loc8);
		}
		else
		{
			this.api.datacenter.Player.ItemSets.removeItemAt(loc5);
		}
	}
	function onItemUseCondition(loc2)
	{
		var loc3 = loc2.charAt(0);
		switch(loc3)
		{
			case "G":
				var loc4 = loc2.substr(1).split("|");
				var loc5 = !_global.isNaN(Number(loc4[0]))?Number(loc4[0]):0;
				var loc6 = !_global.isNaN(Number(loc4[1]))?Number(loc4[1]):undefined;
				var loc7 = !_global.isNaN(Number(loc4[2]))?Number(loc4[2]):undefined;
				var loc8 = !_global.isNaN(Number(loc4[3]))?Number(loc4[3]):undefined;
				var loc9 = {name:"UseItemGold",listener:this,params:{objectID:loc5,spriteID:loc6,cellID:loc7}};
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_USE_CONDITION_GOLD",[loc8]),"CAUTION_YESNO",loc9);
				break;
			case "U":
				var loc10 = loc2.substr(1).split("|");
				var loc11 = !_global.isNaN(Number(loc10[0]))?Number(loc10[0]):0;
				var loc12 = !_global.isNaN(Number(loc10[1]))?Number(loc10[1]):undefined;
				var loc13 = !_global.isNaN(Number(loc10[2]))?Number(loc10[2]):undefined;
				var loc14 = !_global.isNaN(Number(loc10[3]))?Number(loc10[3]):undefined;
				var loc15 = {name:"UseItem",listener:this,params:{objectID:loc11,spriteID:loc12,cellID:loc13}};
				var loc16 = new dofus.datacenter.(-1,loc14,1,0,"",0);
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_USE_CONFIRMATION",[loc16.name]),"CAUTION_YESNO",loc15);
		}
	}
	function onItemFound(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = !_global.isNaN(Number(loc3[0]))?Number(loc3[0]):0;
		var loc5 = !_global.isNaN(Number(loc3[2]))?Number(loc3[2]):0;
		var loc6 = loc3[1].split("~");
		var loc7 = !_global.isNaN(Number(loc6[0]))?Number(loc6[0]):0;
		var loc8 = !_global.isNaN(Number(loc6[1]))?Number(loc6[1]):0;
		if(loc4 == 1)
		{
			if(loc7 == 0)
			{
				var loc9 = {iconFile:"KamaSymbol"};
			}
			else
			{
				loc9 = new dofus.datacenter.(0,loc7,loc8);
			}
			this.api.gfx.addSpriteOverHeadItem(this.api.datacenter.Player.ID,"itemFound",dofus.graphics.battlefield.CraftResultOverHead,[true,loc9],2000);
		}
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoUseItemGold":
				this.use(loc2.params.objectID,loc2.params.spriteID,loc2.params.cellID,true);
				break;
			case "AskYesNoUseItem":
				this.use(loc2.params.objectID,loc2.params.spriteID,loc2.params.cellID,true);
		}
	}
}
