if(!dofus.graphics.gapi.ui.Friends)
{
	if(!dofus)
	{
		_global.dofus = new Object();
	}
	if(!dofus.graphics)
	{
		_global.dofus.graphics = new Object();
	}
	if(!dofus.graphics.gapi)
	{
		_global.dofus.graphics.gapi = new Object();
	}
	if(!dofus.graphics.gapi.ui)
	{
		_global.dofus.graphics.gapi.ui = new Object();
	}
	dofus.graphics.gapi.ui.Friends = function()
	{
		super();
	} extends dofus.graphics.gapi.core.DofusAdvancedComponent;
	var var1 = dofus.graphics.gapi.ui.Friends = function()
	{
		super();
	}.prototype;
	var1.__set__enemiesList = function __set__enemiesList(var2)
	{
		if(this._sCurrentTab != "Enemies")
		{
			return undefined;
		}
		var var3 = new ank.utils.();
		var var4 = new ank.utils.();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2[var5];
			if(var6.account.length != 0)
			{
				if(var6.state != "DISCONNECT")
				{
					var3.push(var6);
				}
				else
				{
					var4.push(var6);
				}
			}
			var5 = var5 + 1;
		}
		this._dgOnLine.dataProvider = var3;
		this._dgOffLine.dataProvider = var4;
		return this.__get__enemiesList();
	};
	var1.__set__friendsList = function __set__friendsList(var2)
	{
		if(this._sCurrentTab != "Friends")
		{
			return undefined;
		}
		var var3 = new ank.utils.();
		var var4 = new ank.utils.();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2[var5];
			if(var6.account.length != 0)
			{
				if(var6.state != "DISCONNECT")
				{
					var3.push(var6);
				}
				else
				{
					var4.push(var6);
				}
			}
			var5 = var5 + 1;
		}
		this._dgOnLine.dataProvider = var3;
		if(!this.api.config.isStreaming)
		{
			this._dgOffLine.dataProvider = var4;
		}
		return this.__get__friendsList();
	};
	var1.__set__spouse = function __set__spouse(var2)
	{
		if(this._svSpouse != undefined)
		{
			this._svSpouse.swapDepths(this._mcSpousePlacer);
			this._svSpouse.removeMovieClip();
		}
		this.attachMovie("SpouseViewer","_svSpouse",10,{_x:this._mcSpousePlacer._x,_y:this._mcSpousePlacer._y,spouse:var2});
		this._svSpouse.swapDepths(this._mcSpousePlacer);
		return this.__get__spouse();
	};
	var1.removeFriend = function removeFriend(var2)
	{
		switch(this._sCurrentTab)
		{
			case "Enemies":
				this.api.network.Enemies.removeEnemy(var2);
				break;
			case "Friends":
			default:
				this.api.network.Friends.removeFriend(var2);
				break;
			case "Ignore":
				this.api.kernel.ChatManager.removeToBlacklist(var2);
				this.updateIgnoreList();
		}
	};
	var1.updateIgnoreList = function updateIgnoreList()
	{
		if(this._sCurrentTab != "Ignore")
		{
			return undefined;
		}
		var var2 = this.api.kernel.ChatManager.getBlacklist();
		var var3 = new ank.utils.();
		§§enumerate(var2);
		while((var var0 = §§enumeration()) != null)
		{
			if(var2[i] != undefined)
			{
				var var4 = new Object();
				var4.name = var2[i].sName;
				var4.gfxID = var2[i].nClass;
				var3.push(var4);
			}
		}
		this._dgOffLine.dataProvider = new ank.utils.();
		this._dgOnLine.dataProvider = var3;
	};
	var1[§§constant(55)] = function §\§\§constant(55)§()
	{
		super["\bwR\x17�\r"](false,eval("�\x05")["\x07�*9\x10�\x02"]["g\x1b�\b"]["\x03"]["^"]["\x04\x01\bv\x07\x02"]);
		this["g\x1b�\b"]("")["\x04\x01\bhN�\x02"] = false;
	};
	var1[§§constant(60)] = function §\§\§constant(60)§()
	{
		this["g\x1b�\b"]("")["\x04\x01\bhN�\x02"] = true;
	};
	var1["\x04\x01\bv\x07\x02"] = function §\x04\x01\bv\x07\x02§()
	{
		this();
		return true;
	};
	var1[""] = function §§()
	{
		this["\x02"]({yN�:this,w�:this[""]});
		this["\x02"]({yN�:this,w�:this["2�\x02"]});
		this["\x02"]({yN�:this,w�:this["\x01"]});
		this["\x02"]({yN�:this,w�:this["@R\x17�\r"]});
		this["\x02"]({yN�:this,w�:this["\x04\x01\bz\x07\x02"],:[this["\x04\x01\b�R\x17�\x04"]]});
		this["\x04\x01\beN�\x02"][""] = false;
	};
	var1[""] = function §§()
	{
		switch(this["\x04\x01\b�R\x17�\x04"])
		{
			case "\x04\x01\b\nN4P�\x02":
				this["\x04\x01\byN�\x02"]["\bwR\x17�\r"] = this[""][""]("\x04\x01\b{\x07\x02");
				this["\x04\x01\byN�\x02"]["\bwR\x17�\r"] = this[""][""]("\x04\x01\b|\x07\x02");
				this[""]["\bwR\x17�\r"] = this[""][""]("");
				this[""]["\x04\x01\b\x15�\x02"] = ["\x05\x01�\x02",this[""][""]("\b�R\x174�\x02") + "|\x02\'N�\x02" + this[""][""]("\b\x02N�\x02") + "\b\x03N\x12\x12�\x02",this[""][""]("-�iN�\x02"),"\x05\x01�\x02","\x05\x01�\x02"];
				this["\bwR\x17�\r"][""] = true;
				this["�"][""] = this["\bwR\x17�\r"][""];
				this["�\x02"][""] = this["\bwR\x17�\r"][""];
				break;
			case "^":
				this["\x04\x01\byN�\x02"]["\bwR\x17�\r"] = this[""][""]("\b\x05\x1c�\x02");
				this["\x04\x01\byN�\x02"]["\bwR\x17�\r"] = this[""][""]("\b");
				this[""]["\bwR\x17�\r"] = this[""][""]("�\x03");
				this[""]["\x04\x01\b\x15�\x02"] = ["\x05\x01�\x02",this[""][""]("\b�R\x174�\x02") + "|\x02\'N�\x02" + this[""][""]("\b\x02N�\x02") + "\b\x03N\x12\x12�\x02",this[""][""]("-�iN�\x02"),"\x05\x01�\x02","\x05\x01�\x02"];
				this["\bwR\x17�\r"][""] = true;
				this["�"][""] = this["\bwR\x17�\r"][""];
				this["�\x02"][""] = this["\bwR\x17�\r"][""];
				break;
			case "\x04\x01\b}\x07\x02":
				this["\x04\x01\byN�\x02"]["\bwR\x17�\r"] = this[""][""]("");
				this["\x04\x01\byN�\x02"]["\bwR\x17�\r"] = this[""][""]("\x02");
				this[""]["\bwR\x17�\r"] = this[""][""]("2�\x02");
				this[""]["\x04\x01\b\x15�\x02"] = ["\x05\x01�\x02",this[""][""]("\b\x02N�\x02")["�"](0,1)["@�\x05"]() + this[""][""]("\b\x02N�\x02")["�"](1),"\x05\x01�\x02","\x05\x01�\x02"];
				this["\bwR\x17�\r"][""] = false;
				this["�"][""] = this["\bwR\x17�\r"][""];
				this["�\x02"][""] = this["\bwR\x17�\r"][""];
		}
		this[""][""] = this[""][""]("\b\x05\x1c�\x02");
		this[""][""] = this[""][""]("\x04\x01\b{\x07\x02");
		this[""][""] = this[""][""]("");
		this[""]["\bwR\x17�\r"] = this[""][""]("4P�\x02");
		this["T�+O�\x04"]["\bwR\x17�\r"] = this[""][""]("\x04\x01\bB4�\x02");
		this["\bwR\x17�\r"]["\x04\x01\b\x15�\x02"] = [this[""][""]("\b�R\x174�\x02")];
		this["�\x02"]["\bwR\x17�\r"] = this[""][""]("�\x03,�\f");
		this["�"]["\bwR\x17�\r"] = this[""][""]("");
		this["\x01"][""] = this[""][""]("\x03)");
		this["\x02\x17\x11"]["\bwR\x17�\r"] = this[""][""]("\x10");
		if(!this[""][""]["\x04\x01\byN�\x04"]("�\x04"))
		{
			this["\b�\x04\x02O�\x02"][""] = false;
		}
	};
	var1["2�\x02"] = function §2�\x02§()
	{
		this["\x01"]["\f\"�\r"]("\x05\x01�\x02",this);
		this[""]["\f\"�\r"]("\x05\x01�\x02",this);
		this[""]["\f\"�\r"]("\x05\x01�\x02",this);
		this[""]["\f\"�\r"]("\x05\x01�\x02",this);
		this[""]["\f\"�\r"]("\x05\x01�\x02",this);
		this["\x01"]["\f\"�\r"]("\x05\x01�\x02",this);
		this["\x01"]["\f\"�\r"]("\x03)",this);
		this["\x01"]["\f\"�\r"]("\x02\x1e\x1b\x01",this);
		this[""]["\f\"�\r"](";",this);
		this[""]["\f\"�\r"]("�\x04",this);
		this[""]["\x04\x01\b\x15N�\x02"]["\b�N�\x02"]["\b3N�\t"]("\x04\x02\b�N�\x02",this);
	};
	var1["@R\x17�\r"] = function §@R\x17�\r§()
	{
		this["\x01"]["\x07\x01"] = this[""][""][""]["\x04\x01\b\x1aN�\x02"];
	};
	var1["\x01"] = function §\x01§()
	{
		this._itAddFriend.setFocus();
	};
	var1["\x04\x01\bz\x07\x02"] = function §\x04\x01\bz\x07\x02§(var2)
	{
		var var3 = this["\b�4�\x02" + this["\x04\x01\b�R\x17�\x04"]];
		var var4 = this["\b�4�\x02" + var2];
		var3["\x07\x01"] = true;
		var3["\x01"] = true;
		var4["\x07\x01"] = false;
		var4["\x01"] = false;
		this["\x04\x01\b�R\x17�\x04"] = var2;
		this[",R\x17�\x03"]();
	};
	var1[",R\x17�\x03"] = function §,R\x17�\x03§()
	{
		switch(this["\x04\x01\b�R\x17�\x04"])
		{
			case "\x04\x01\b\nN4P�\x02":
				this[""][""]["\x04\x01\b\nN4P�\x02"]();
				break;
			case "^":
				this[""][""]["^"]["\x0b"]();
				break;
			case "\x04\x01\b}\x07\x02":
				this();
		}
		this["\x02"]({yN�:this,w�:this[""]});
	};
	var1["\x04\x02\b�N�\x02"] = function §\x04\x02\b�N�\x02§(var2)
	{
		if(var2 == §§constant(140) && this[§§constant(133)][§§constant(141)])
		{
			this[§§constant(118)]({§§constant(142):this[§§constant(111)]});
			return false;
		}
		return true;
	};
	var1["\x05\x01�\x02"] = function §\x05\x01�\x02§(var2)
	{
		switch(var2.target)
		{
			case this._btnAdd:
				if(this._itAddFriend.text.length != 0)
				{
					if((var0 = this._sCurrentTab) !== "Enemies")
					{
						switch(null)
						{
							case "Friends":
								this.api.network.Friends.addFriend("%" + this._itAddFriend.text);
								if(this._itAddFriend.text != undefined)
								{
									this._itAddFriend.text = "";
								}
								this.api.network.Friends.getFriendsList();
								break;
							case "Ignore":
								this.api.kernel.ChatManager.addToBlacklist(this._itAddFriend.text);
								if(this._itAddFriend.text != undefined)
								{
									this._itAddFriend.text = "";
								}
								this.updateIgnoreList();
						}
					}
					else
					{
						this.api.network.Enemies.addEnemy("%" + this._itAddFriend.text);
						if(this._itAddFriend.text != undefined)
						{
							this._itAddFriend.text = "";
						}
						this.api.network.Enemies.getEnemiesList();
					}
				}
				break;
			case this._btnClose:
				this.callClose();
				break;
			case this._btnTabFriends:
				this.setCurrentTab("Friends");
				break;
			default:
				switch(null)
				{
					case this._btnTabEnemies:
						this.setCurrentTab("Enemies");
						break;
					case this._btnTabIgnore:
						this.setCurrentTab("Ignore");
						break;
					case this._btnShowFriendsWarning:
						this.api.network.Friends.setNotifyWhenConnect(this._btnShowFriendsWarning.selected);
						this.api.datacenter.Basics.aks_notify_on_friend_connexion = this._btnShowFriendsWarning.selected;
				}
		}
	};
	var1["\b\x06@O�\x02"] = function §\b\x06@O�\x02§(var2)
	{
		this["\x01"]["\x07\x01"] = var2;
	};
	var1[";"] = function §;§(var2)
	{
		this[""]["\x04\x01\b\x15N�\x02"]["�\x02"]["\x05"](undefined,var2["\b\x05\x1c�\x02"]["\b"]["\b-N�\x02"],undefined,true,undefined,undefined,true);
	};
	var1["�\x04"] = function §�\x04§(var2)
	{
		this[""]["\x04\x01\b\x15N�\x02"]["�\x02"]["\x12�\x02"](var2["\b\x05\x1c�\x02"]["\b"]["\b-N�\x02"]);
	};
	var1["\x03)"] = function §\x03)§(var2)
	{
		if((var var0 = var2.target) === this._btnShowFriendsWarning)
		{
			this.gapi.showTooltip(this.api.lang.getText("WARNING_WHEN_FRIENDS_COME_ONLINE_TOOLTIP"),var2.target,-20);
		}
	};
	var1["\x02\x1e\x1b\x01"] = function §\x02\x1e\x1b\x01§(var2)
	{
		this["g\x1b�\b"]["\x04"]();
	};
	var1["\x01\x17�\x04"]("\b\tN�\x01",function()
	{
	}
	,var1.__set__friendsList);
	var1[§§constant(158)](§§constant(37),function()
	{
	}
	,var1[""]);
	var1["\x01\x17�\x04"]("\x04\x01\b\n�\x02",function()
	{
	}
	,var1[""]);
	eval("\x05\x01�\x02")(var1,null,1);
	dofus.graphics.gapi.ui.Friends = function()
	{
		super();
	}["\x04\x01\bv\x07\x02"] = "^";
	var1["\x04\x01\b�R\x17�\x04"] = "^";
}
