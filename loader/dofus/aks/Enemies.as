class dofus.aks.Enemies extends dofus.aks.Handler
{
	function Enemies(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function getEnemiesList()
	{
		this.aks.send("iL",true);
	}
	function addEnemy(var2)
	{
		if(var2 == undefined || (var2.length == 0 || var2 == "*"))
		{
			return undefined;
		}
		this.aks.send("iA" + var2);
	}
	function removeEnemy(var2)
	{
		if(var2 == undefined || (var2.length == 0 || var2 == "*"))
		{
			return undefined;
		}
		this.aks.send("iD" + var2);
	}
	function onAddEnemy(var2, var3)
	{
		if(var2)
		{
			var var4 = this.getEnemyObjectFromData(var3);
			if(var4 != undefined)
			{
				this.api.datacenter.Player.Enemies.push(var4);
			}
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ADD_TO_ENEMY_LIST",[var4.name]),"INFO_CHAT");
		}
		else
		{
			switch(var3)
			{
				case "f":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
					break;
				case "y":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_YOU_AS_ENEMY"),"ERROR_CHAT");
					break;
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_YOUR_ENEMY"),"ERROR_CHAT");
					break;
				default:
					if(var0 !== "m")
					{
						break;
					}
					this.api.kernel.showMessage(this.api.lang.getText("ENEMIES"),this.api.lang.getText("ENEMIES_LIST_FULL"),"ERROR_BOX",{name:"EnemiesListFull"});
					break;
			}
		}
	}
	function onRemoveEnemy(var2, var3)
	{
		if(var2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_ENEMY_OK"),"INFO_CHAT");
			this.getEnemiesList();
		}
		else if((var var0 = var3) === "f")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
		}
	}
	function onEnemiesList(var2)
	{
		var var3 = var2.split("|");
		this.api.datacenter.Player.Enemies = new Array();
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = this.getEnemyObjectFromData(var3[var4]);
			if(var5 != undefined)
			{
				this.api.datacenter.Player.Enemies.push(var5);
			}
			var4 = var4 + 1;
		}
		var var6 = this.api.ui.getUIComponent("Friends");
		var var7 = this.api.datacenter.Player.Enemies;
		if(var6 != undefined)
		{
			var6.enemiesList = var7;
		}
		else
		{
			var var8 = new String();
			if(var7.length != 0)
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("YOUR_ENEMY_LIST") + " :</b>","INFO_CHAT");
				var var9 = 0;
				while(var9 < var7.length)
				{
					var8 = " - " + var7[var9].account;
					if(var7[var9].state != "DISCONNECT")
					{
						var8 = var8 + (" (" + var7[var9].name + ") " + this.api.lang.getText("LEVEL") + ":" + var7[var9].level + ", " + this.api.lang.getText(var7[var9].state));
					}
					this.api.kernel.showMessage(undefined,var8,"INFO_CHAT");
					var9 = var9 + 1;
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("EMPTY_ENEMY_LIST"),"INFO_CHAT");
			}
		}
	}
	function getEnemyObjectFromData(var2)
	{
		var var3 = var2.split(";");
		var var4 = new Object();
		var4.account = String(var3[0]);
		if(var3[1] != undefined)
		{
			if((var var0 = var3[1]) !== "1")
			{
				switch(null)
				{
					case "2":
						var4.state = "IN_MULTI";
						break;
					case "?":
						var4.state = "IN_UNKNOW";
				}
			}
			else
			{
				var4.state = "IN_SOLO";
			}
			var4.name = var3[2];
			var4.level = var3[3];
			var4.sortLevel = var4.level != "?"?Number(var4.level):-1;
			var4.alignement = Number(var3[4]);
			var4.guild = var3[5];
			var4.sex = var3[6];
			var4.gfxID = var3[7];
		}
		else
		{
			var4.name = var4.account;
			var4.state = "DISCONNECT";
		}
		return var4.account.length == 0?undefined:var4;
	}
}
