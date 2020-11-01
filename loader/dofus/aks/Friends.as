class dofus.aks.Friends extends dofus.aks.Handler
{
	function Friends(var2, var3)
	{
		super.initialize(var3,var4);
	}
	function getFriendsList()
	{
		this.aks.send("FL",true);
	}
	function addFriend(var2)
	{
		if(var2 == undefined || (var2.length == 0 || var2 == "*"))
		{
			return undefined;
		}
		this.aks.send("FA" + var2);
	}
	function removeFriend(var2)
	{
		if(var2 == undefined || (var2.length == 0 || var2 == "*"))
		{
			return undefined;
		}
		this.aks.send("FD" + var2);
	}
	function join(var2)
	{
		this.aks.send("FJ" + var2);
	}
	function joinFriend(var2)
	{
		this.aks.send("FJF" + var2);
	}
	function compass(var2)
	{
		this.aks.send("FJC" + (!var2?"+":"-"));
	}
	function setNotifyWhenConnect(var2)
	{
		this.aks.send("FO" + (!var2?"-":"+"));
	}
	function onAddFriend(var2, var3)
	{
		if(var2)
		{
			var var4 = this.getFriendObjectFromData(var3);
			if(var4 != undefined)
			{
				this.api.datacenter.Player.Friends.push(var4);
			}
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ADD_TO_FRIEND_LIST",[var4.name]),"INFO_CHAT");
		}
		else
		{
			switch(var3)
			{
				case "f":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
					break;
				case "y":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_YOU"),"ERROR_CHAT");
					break;
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_YOUR_FRIEND"),"ERROR_CHAT");
					break;
				case "m":
					this.api.kernel.showMessage(this.api.lang.getText("FRIENDS"),this.api.lang.getText("FRIENDS_LIST_FULL"),"ERROR_BOX",{name:"FriendsListFull"});
			}
		}
	}
	function onRemoveFriend(var2, var3)
	{
		if(var2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_FRIEND_OK"),"INFO_CHAT");
			this.getFriendsList();
		}
		else if((var var0 = var3) === "f")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
		}
	}
	function onFriendsList(var2)
	{
		var var3 = var2.split("|");
		this.api.datacenter.Player.Friends = new Array();
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = this.getFriendObjectFromData(var3[var4]);
			if(var5 != undefined)
			{
				this.api.datacenter.Player.Friends.push(var5);
			}
			var4 = var4 + 1;
		}
		var var6 = this.api.ui.getUIComponent("Friends");
		var var7 = this.api.datacenter.Player.Friends;
		if(var6 != undefined)
		{
			var6.friendsList = var7;
		}
		else
		{
			var var8 = new String();
			if(var7.length != 0)
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("YOUR_FRIEND_LIST") + " :</b>","INFO_CHAT");
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
				this.api.kernel.showMessage(undefined,this.api.lang.getText("EMPTY_FRIEND_LIST"),"INFO_CHAT");
			}
		}
	}
	function onSpouse(var2)
	{
		var var3 = var2.split("|");
		var var4 = new Object();
		var4.name = var3[0];
		var4.gfx = var3[1];
		var4.color1 = Number(var3[2]);
		var4.color2 = Number(var3[3]);
		var4.color3 = Number(var3[4]);
		var4.mapID = Number(var3[5]);
		var4.isConnected = !_global.isNaN(var4.mapID);
		var4.level = Number(var3[6]);
		var4.isInFight = var3[7] != "1"?false:true;
		var4.sex = this.api.datacenter.Player.Sex != 0?"m":"f";
		var4.isFollow = var3[8] != "1"?false:true;
		var var5 = this.api.ui.getUIComponent("Friends");
		var5.spouse = var4;
	}
	function onNotifyChange(var2)
	{
		this.api.datacenter.Basics.aks_notify_on_friend_connexion = var2 == "+";
		var var3 = (dofus.graphics.gapi.ui.Friends)this.api.ui.getUIComponent("Friends");
		if(var3 != null)
		{
			var3.notifyStateChanged(var2 == "+");
		}
	}
	function getFriendObjectFromData(var2)
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
	function setNotify(var2)
	{
		this.aks.send("FO" + (!var2?"-":"+"),false);
	}
}
