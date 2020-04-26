class dofus.aks.Enemies extends dofus.aks.Handler
{
	function Enemies(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function getEnemiesList()
	{
		this.aks.send("iL",true);
	}
	function addEnemy(loc2)
	{
		if(loc2 == undefined || (loc2.length == 0 || loc2 == "*"))
		{
			return undefined;
		}
		this.aks.send("iA" + loc2);
	}
	function removeEnemy(loc2)
	{
		if(loc2 == undefined || (loc2.length == 0 || loc2 == "*"))
		{
			return undefined;
		}
		this.aks.send("iD" + loc2);
	}
	function onAddEnemy(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = this.getEnemyObjectFromData(loc3);
			if(loc4 != undefined)
			{
				this.api.datacenter.Player.Enemies.push(loc4);
			}
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ADD_TO_ENEMY_LIST",[loc4.name]),"INFO_CHAT");
		}
		else
		{
			switch(loc3)
			{
				case "f":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
					break;
				case "y":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_YOU_AS_ENEMY"),"ERROR_CHAT");
					break;
				default:
					switch(null)
					{
						case "a":
							this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_YOUR_ENEMY"),"ERROR_CHAT");
							break;
						case "m":
							this.api.kernel.showMessage(this.api.lang.getText("ENEMIES"),this.api.lang.getText("ENEMIES_LIST_FULL"),"ERROR_BOX",{name:"EnemiesListFull"});
					}
			}
		}
	}
	function onRemoveEnemy(loc2, loc3)
	{
		if(loc2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_ENEMY_OK"),"INFO_CHAT");
			this.getEnemiesList();
		}
		else if((var loc0 = loc3) === "f")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
		}
	}
	function onEnemiesList(loc2)
	{
		var loc3 = loc2.split("|");
		this.api.datacenter.Player.Enemies = new Array();
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = this.getEnemyObjectFromData(loc3[loc4]);
			if(loc5 != undefined)
			{
				this.api.datacenter.Player.Enemies.push(loc5);
			}
			loc4 = loc4 + 1;
		}
		var loc6 = this.api.ui.getUIComponent("Friends");
		var loc7 = this.api.datacenter.Player.Enemies;
		if(loc6 != undefined)
		{
			loc6.enemiesList = loc7;
		}
		else
		{
			var loc8 = new String();
			if(loc7.length != 0)
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("YOUR_ENEMY_LIST") + " :</b>","INFO_CHAT");
				var loc9 = 0;
				while(loc9 < loc7.length)
				{
					loc8 = " - " + loc7[loc9].account;
					if(loc7[loc9].state != "DISCONNECT")
					{
						loc8 = loc8 + (" (" + loc7[loc9].name + ") " + this.api.lang.getText("LEVEL") + ":" + loc7[loc9].level + ", " + this.api.lang.getText(loc7[loc9].state));
					}
					this.api.kernel.showMessage(undefined,loc8,"INFO_CHAT");
					loc9 = loc9 + 1;
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("EMPTY_ENEMY_LIST"),"INFO_CHAT");
			}
		}
	}
	function getEnemyObjectFromData(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = new Object();
		loc4.account = String(loc3[0]);
		if(loc3[1] != undefined)
		{
			if((var loc0 = loc3[1]) !== "1")
			{
				switch(null)
				{
					case "2":
						loc4.state = "IN_MULTI";
						break;
					case "?":
						loc4.state = "IN_UNKNOW";
				}
			}
			else
			{
				loc4.state = "IN_SOLO";
			}
			loc4.name = loc3[2];
			loc4.level = loc3[3];
			loc4.sortLevel = loc4.level != "?"?Number(loc4.level):-1;
			loc4.alignement = Number(loc3[4]);
			loc4.guild = loc3[5];
			loc4.sex = loc3[6];
			loc4.gfxID = loc3[7];
		}
		else
		{
			loc4.name = loc4.account;
			loc4.state = "DISCONNECT";
		}
		return loc4.account.length == 0?undefined:loc4;
	}
}
