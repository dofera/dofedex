class dofus.graphics.gapi.ui.Friends extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Friends";
	var _sCurrentTab = "Friends";
	function Friends()
	{
		super();
	}
	function __set__enemiesList(loc2)
	{
		if(this._sCurrentTab != "Enemies")
		{
			return undefined;
		}
		var loc3 = new ank.utils.();
		var loc4 = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = loc2[loc5];
			if(loc6.account.length != 0)
			{
				if(loc6.state != "DISCONNECT")
				{
					loc3.push(loc6);
				}
				else
				{
					loc4.push(loc6);
				}
			}
			loc5 = loc5 + 1;
		}
		this._dgOnLine.dataProvider = loc3;
		this._dgOffLine.dataProvider = loc4;
		return this.__get__enemiesList();
	}
	function __set__friendsList(loc2)
	{
		if(this._sCurrentTab != "Friends")
		{
			return undefined;
		}
		var loc3 = new ank.utils.();
		var loc4 = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = loc2[loc5];
			if(loc6.account.length != 0)
			{
				if(loc6.state != "DISCONNECT")
				{
					loc3.push(loc6);
				}
				else
				{
					loc4.push(loc6);
				}
			}
			loc5 = loc5 + 1;
		}
		this._dgOnLine.dataProvider = loc3;
		if(!this.api.config.isStreaming)
		{
			this._dgOffLine.dataProvider = loc4;
		}
		return this.__get__friendsList();
	}
	function __set__spouse(loc2)
	{
		if(this._svSpouse != undefined)
		{
			this._svSpouse.swapDepths(this._mcSpousePlacer);
			this._svSpouse.removeMovieClip();
		}
		this.attachMovie("SpouseViewer","_svSpouse",10,{_x:this._mcSpousePlacer._x,_y:this._mcSpousePlacer._y,spouse:loc2});
		this._svSpouse.swapDepths(this._mcSpousePlacer);
		return this.__get__spouse();
	}
	function removeFriend(loc2)
	{
		switch(this._sCurrentTab)
		{
			case "Enemies":
				this.api.network.Enemies.removeEnemy(loc2);
				break;
			case "Friends":
				this.api.network.Friends.removeFriend(loc2);
				break;
			case "Ignore":
				this.api.kernel.ChatManager.removeToBlacklist(loc2);
				this.updateIgnoreList();
		}
	}
	function updateIgnoreList()
	{
		if(this._sCurrentTab != "Ignore")
		{
			return undefined;
		}
		var loc2 = this.api.kernel.ChatManager.getBlacklist();
		var loc3 = new ank.utils.();
		for(var i in loc2)
		{
			if(loc2[i] != undefined)
			{
				var loc4 = new Object();
				loc4.name = loc2[i].sName;
				loc4.gfxID = loc2[i].nClass;
				loc3.push(loc4);
			}
		}
		this._dgOffLine.dataProvider = new ank.utils.();
		this._dgOnLine.dataProvider = loc3;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Friends.CLASS_NAME);
		this.gapi.getUIComponent("Banner").chatAutoFocus = false;
	}
	function destroy()
	{
		this.gapi.getUIComponent("Banner").chatAutoFocus = true;
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.setTextFocus});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.setCurrentTab,params:[this._sCurrentTab]});
		this._mcSpousePlacer._visible = false;
	}
	function initTexts()
	{
		switch(this._sCurrentTab)
		{
			case "Enemies":
				this._winBg.title = this.api.lang.getText("ENEMIES");
				this._lblAddFriend.text = this.api.lang.getText("ADD_AN_ENEMY");
				this._lblInfo.text = this.api.lang.getText("FRIENDS_INFO_ENEMIES");
				this._dgOnLine.columnsNames = ["",this.api.lang.getText("ACCOUNT") + " (" + this.api.lang.getText("NAME") + ")",this.api.lang.getText("LEVEL"),"",""];
				this._dgOffLine._visible = true;
				this._lblOffLine._visible = this._dgOffLine._visible;
				this._lblOnLine._visible = this._dgOffLine._visible;
				break;
			case "Friends":
				this._winBg.title = this.api.lang.getText("FRIENDS");
				this._lblAddFriend.text = this.api.lang.getText("ADD_A_FRIEND");
				this._lblInfo.text = this.api.lang.getText("FRIENDS_INFO_FRIENDS");
				this._dgOnLine.columnsNames = ["",this.api.lang.getText("ACCOUNT") + " (" + this.api.lang.getText("NAME") + ")",this.api.lang.getText("LEVEL"),"",""];
				this._dgOffLine._visible = true;
				this._lblOffLine._visible = this._dgOffLine._visible;
				this._lblOnLine._visible = this._dgOffLine._visible;
				break;
			case "Ignore":
				this._winBg.title = this.api.lang.getText("IGNORED");
				this._lblAddFriend.text = this.api.lang.getText("ADD_A_IGNORED");
				this._lblInfo.text = this.api.lang.getText("FRIENDS_INFO_IGNORE");
				this._dgOnLine.columnsNames = ["",this.api.lang.getText("NAME").substr(0,1).toUpperCase() + this.api.lang.getText("NAME").substr(1),"",""];
				this._dgOffLine._visible = false;
				this._lblOffLine._visible = this._dgOffLine._visible;
				this._lblOnLine._visible = this._dgOffLine._visible;
		}
		this._btnTabFriends.label = this.api.lang.getText("FRIENDS");
		this._btnTabEnemies.label = this.api.lang.getText("ENEMIES");
		this._btnTabIgnore.label = this.api.lang.getText("IGNORED");
		this._lblHelp.text = this.api.lang.getText("IGNORED_DESC");
		this._lblTitleInfo.text = this.api.lang.getText("INFORMATIONS");
		this._dgOffLine.columnsNames = [this.api.lang.getText("ACCOUNT")];
		this._lblOnLine.text = this.api.lang.getText("ONLINE");
		this._lblOffLine.text = this.api.lang.getText("OFFLINE");
		this._btnAdd.label = this.api.lang.getText("ADD");
		this._lblShowFriendsWarning.text = this.api.lang.getText("WARNING_WHEN_FRIENDS_COME_ONLINE");
		if(!this.api.lang.getConfigText("ENABLE_IGNORE_LIST"))
		{
			this._btnSwapMode._visible = false;
		}
	}
	function addListeners()
	{
		this._btnAdd.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this._btnTabFriends.addEventListener("click",this);
		this._btnTabEnemies.addEventListener("click",this);
		this._btnTabIgnore.addEventListener("click",this);
		this._btnShowFriendsWarning.addEventListener("click",this);
		this._btnShowFriendsWarning.addEventListener("over",this);
		this._btnShowFriendsWarning.addEventListener("out",this);
		this._dgOnLine.addEventListener("itemSelected",this);
		this._dgOnLine.addEventListener("itemdblClick",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function initData()
	{
		this._btnShowFriendsWarning.selected = this.api.datacenter.Basics.aks_notify_on_friend_connexion;
	}
	function setTextFocus()
	{
		this._itAddFriend.setFocus();
	}
	function setCurrentTab(loc2)
	{
		var loc3 = this["_btnTab" + this._sCurrentTab];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		loc4.enabled = false;
		this._sCurrentTab = loc2;
		this.updateCurrentTabInformations();
	}
	function updateCurrentTabInformations()
	{
		switch(this._sCurrentTab)
		{
			case "Enemies":
				this.api.network.Enemies.getEnemiesList();
				break;
			case "Friends":
				this.api.network.Friends.getFriendsList();
				break;
			case "Ignore":
				this.updateIgnoreList();
		}
		this.addToQueue({object:this,method:this.initTexts});
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG" && this._itAddFriend.focused)
		{
			this.click({target:this._btnAdd});
			return false;
		}
		return true;
	}
	function click(loc2)
	{
		switch(loc2.target)
		{
			case this._btnAdd:
				if(this._itAddFriend.text.length != 0)
				{
					switch(this._sCurrentTab)
					{
						case "Enemies":
							this.api.network.Enemies.addEnemy("%" + this._itAddFriend.text);
							if(this._itAddFriend.text != undefined)
							{
								this._itAddFriend.text = "";
							}
							this.api.network.Enemies.getEnemiesList();
							break;
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
	}
	function notifyStateChanged(loc2)
	{
		this._btnShowFriendsWarning.selected = loc2;
	}
	function itemSelected(loc2)
	{
		this.api.kernel.GameManager.showPlayerPopupMenu(undefined,loc2.row.item.name,undefined,true,undefined,undefined,true);
	}
	function itemdblClick(loc2)
	{
		this.api.kernel.GameManager.askPrivateMessage(loc2.row.item.name);
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) === this._btnShowFriendsWarning)
		{
			this.gapi.showTooltip(this.api.lang.getText("WARNING_WHEN_FRIENDS_COME_ONLINE_TOOLTIP"),loc2.target,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
