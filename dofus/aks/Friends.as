class dofus.aks.Friends extends dofus.aks.Handler
{
	function Friends(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function getFriendsList()
	{
		this.aks.send("FL",true);
	}
	function addFriend(loc2)
	{
		if(loc2 == undefined || (loc2.length == 0 || loc2 == "*"))
		{
			return undefined;
		}
		this.aks.send("FA" + loc2);
	}
	function removeFriend(loc2)
	{
		if(loc2 == undefined || (loc2.length == 0 || loc2 == "*"))
		{
			return undefined;
		}
		this.aks.send("FD" + loc2);
	}
	function join(loc2)
	{
		this.aks.send("FJ" + loc2);
	}
	function joinFriend(loc2)
	{
		this.aks.send("FJF" + loc2);
	}
	function compass(loc2)
	{
		this.aks.send("FJC" + (!loc2?"+":"-"));
	}
	function setNotifyWhenConnect(loc2)
	{
		this.aks.send("FO" + (!loc2?"-":"+"));
	}
	function onAddFriend(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = this.getFriendObjectFromData(loc3);
			if(loc4 != undefined)
			{
				this.api.datacenter.Player.Friends.push(loc4);
			}
			this.api.kernel.showMessage(undefined,this.api.lang.getText("ADD_TO_FRIEND_LIST",[loc4.name]),"INFO_CHAT");
		}
		else
		{
			switch(loc3)
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
	function onRemoveFriend(loc2, loc3)
	{
		if(loc2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_FRIEND_OK"),"INFO_CHAT");
			this.getFriendsList();
		}
		else if((var loc0 = loc3) === "f")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
		}
	}
	function onFriendsList(loc2)
	{
		var loc3 = loc2.split("|");
		this.api.datacenter.Player.Friends = new Array();
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = this.getFriendObjectFromData(loc3[loc4]);
			if(loc5 != undefined)
			{
				this.api.datacenter.Player.Friends.push(loc5);
			}
			loc4 = loc4 + 1;
		}
		var loc6 = this.api.ui.getUIComponent("Friends");
		var loc7 = this.api.datacenter.Player.Friends;
		if(loc6 != undefined)
		{
			loc6.friendsList = loc7;
		}
		else
		{
			var loc8 = new String();
			if(loc7.length != 0)
			{
				this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("YOUR_FRIEND_LIST") + " :</b>","INFO_CHAT");
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
				this.api.kernel.showMessage(undefined,this.api.lang.getText("EMPTY_FRIEND_LIST"),"INFO_CHAT");
			}
		}
	}
	function onSpouse(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = new Object();
		loc4.name = loc3[0];
		loc4.gfx = loc3[1];
		loc4.color1 = Number(loc3[2]);
		loc4.color2 = Number(loc3[3]);
		loc4.color3 = Number(loc3[4]);
		loc4.mapID = Number(loc3[5]);
		loc4.isConnected = !_global.isNaN(loc4.mapID);
		loc4.level = Number(loc3[6]);
		loc4.isInFight = loc3[7] != "1"?false:true;
		loc4.sex = this.api.datacenter.Player.Sex != 0?"m":"f";
		loc4.isFollow = loc3[8] != "1"?false:true;
		var loc5 = this.api.ui.getUIComponent("Friends");
		loc5.spouse = loc4;
	}
	function onNotifyChange(loc2)
	{
		this.api.datacenter.Basics.aks_notify_on_friend_connexion = loc2 == "+";
		var loc3 = (dofus.graphics.gapi.ui.Friends)this.api.ui.getUIComponent("Friends");
		if(loc3 != null)
		{
			loc3.notifyStateChanged(loc2 == "+");
		}
	}
	function getFriendObjectFromData(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = new Object();
		loc4.account = String(loc3[0]);
		if(loc3[1] != undefined)
		{
			switch(loc3[1])
			{
				case "1":
					loc4.state = "IN_SOLO";
					break;
				case "2":
					loc4.state = "IN_MULTI";
					break;
				case "?":
					loc4.state = "IN_UNKNOW";
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
	function setNotify(loc2)
	{
		this.aks.send("FO" + (!loc2?"-":"+"),false);
	}
}
