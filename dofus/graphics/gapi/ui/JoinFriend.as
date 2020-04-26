class dofus.graphics.gapi.ui.JoinFriend extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "JoinFriend";
	static var SEARCH_DELAY = 500;
	function JoinFriend()
	{
		super();
	}
	function __set__servers(loc2)
	{
		this._eaServers = loc2;
		return this.__get__servers();
	}
	function __set__remainingTime(loc2)
	{
		this._nRemainingTime = loc2;
		return this.__get__remainingTime();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.JoinFriend.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		var ref = this;
		this._mcDirectPlay.onRelease = function()
		{
			this._parent.click({target:this});
		};
		this._btnSearch.onRelease = function()
		{
			this._parent.click({target:this});
		};
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		var loc2 = new Object();
		loc2.onSetFocus = function(loc2, loc3)
		{
			if(eval(Selection.getFocus())._parent == ref._tiSearch)
			{
				if(ref._tiSearch.text == ref.api.lang.getText("PSEUDO_DOFUS_SIMPLE"))
				{
					ref._tiSearch.text = "";
				}
			}
			else if(ref._tiSearch.text == "")
			{
				ref._tiSearch.text = ref.api.lang.getText("PSEUDO_DOFUS_SIMPLE");
			}
		};
		Selection.addListener(loc2);
	}
	function initTexts()
	{
		this._lblTitle.text = this.api.lang.getText("JOIN_FRIEND_SERVER");
		this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
		this._lblDirectPlay.text = this.api.lang.getText("DIRECT_PLAY");
		this._lblDownload.text = this.api.lang.getText("JOIN_FRIEND_INVITE");
	}
	function getLessPopulatedServer(loc2)
	{
		if(loc2.length == 1)
		{
			return loc2[0].id;
		}
		loc2.sortOn("populationWeight",Array.NUMERIC | Array.ASCENDING);
		var loc3 = loc2[0].populationWeight;
		var loc4 = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			if(loc2[loc5].populationWeight == loc3)
			{
				loc4.push(loc2[loc5]);
			}
			loc5 = loc5 + 1;
		}
		loc4.sortOn("completion",Array.NUMERIC | Array.ASCENDING);
		var loc6 = loc4[0].completion;
		var loc7 = new ank.utils.();
		var loc8 = 0;
		while(loc8 < loc4.length)
		{
			if(loc4[loc8].completion == loc6)
			{
				loc7.push(loc4[loc8]);
			}
			loc8 = loc8 + 1;
		}
		return loc7[Math.round(Math.random() * (loc7.length - 1))].id;
	}
	function selectServer(loc2)
	{
		this.gapi.loadUIComponent("ServerInformations","ServerInformations",{server:loc2});
		this.gapi.getUIComponent("ServerInformations").addEventListener("serverSelected",this);
		this.gapi.getUIComponent("ServerInformations").addEventListener("canceled",this);
	}
	function findFriend()
	{
		if(this._tiSearch.text == this.api.lang.getText("PSEUDO_DOFUS_SIMPLE") || !this._tiSearch.text.length)
		{
			return undefined;
		}
		this.api.network.Account.searchForFriend(this._tiSearch.text);
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
		{
			this.click({target:this._btnSearch});
			return false;
		}
		return true;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_mcAutomaticSelect":
				var loc3 = new ank.utils.();
				var loc4 = 0;
				while(loc4 < this._eaServers.length)
				{
					if(this._eaServers[loc4].state == dofus.datacenter.Server.SERVER_ONLINE && this._eaServers[loc4].isAllowed())
					{
						loc3.push(this._eaServers[loc4]);
					}
					loc4 = loc4 + 1;
				}
				if(loc3.length <= 0)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_DOWN"),"ERROR_BOX");
					break;
				}
				var loc5 = new ank.utils.();
				var loc6 = 0;
				while(loc6 < loc3.length)
				{
					if(loc3[loc6].canLog && (loc3[loc6].typeNum == dofus.datacenter.Server.SERVER_CLASSIC || loc3[loc6].typeNum == dofus.datacenter.Server.SERVER_RETRO))
					{
						loc5.push(loc3[loc6]);
					}
					loc6 = loc6 + 1;
				}
				loc3 = loc5;
				if(loc3.length <= 0)
				{
					if(this._nRemainingTime <= 0)
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_FULL_NOT_FULL_MEMBER"),"ERROR_BOX");
					}
					else
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_FULL_FULL_MEMBER"),"ERROR_BOX");
					}
					break;
				}
				this._eaPreselectedServers = loc3;
				loc5 = new ank.utils.();
				var loc7 = 0;
				while(loc7 < loc3.length)
				{
					if(loc3[loc7].community == this.api.datacenter.Basics.communityId || loc3[loc7].community == dofus.datacenter.Server.SERVER_COMMUNITY_INTERNATIONAL)
					{
						loc5.push(loc3[loc7]);
					}
					loc7 = loc7 + 1;
				}
				loc3 = loc5;
				if(loc3.length <= 0)
				{
					if(this._nRemainingTime <= 0)
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMUNITY_IS_FULL_NOT_FULL_MEMBER"),"CAUTION_YESNO",{name:"automaticServer",listener:this});
					}
					else
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMUNITY_IS_FULL_FULL_MEMBER"),"CAUTION_YESNO",{name:"automaticServer",listener:this});
					}
					break;
				}
				this.selectServer(this.getLessPopulatedServer(loc3));
				break;
			case "_mcManualSelect":
				this.api.datacenter.Basics.forceManualServerSelection = true;
				this.api.network.Account.getServersList();
				break;
			case "_btnSearch":
				this.findFriend();
		}
	}
	function yes(loc2)
	{
		var loc3 = new ank.utils.();
		var loc4 = 0;
		while(loc4 < this._eaPreselectedServers.length)
		{
			if(this._eaPreselectedServers[loc4].community == 2)
			{
				loc3.push(this._eaPreselectedServers[loc4]);
			}
			loc4 = loc4 + 1;
		}
		if(loc3.length > 0)
		{
			this.selectServer(this.getLessPopulatedServer(loc3));
		}
		else
		{
			this.selectServer(this.getLessPopulatedServer(this._eaPreselectedServers));
		}
	}
	function serverSelected(loc2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
		var loc3 = new dofus.datacenter.(loc2.value,1,0);
		if(loc3.isAllowed())
		{
			this.api.datacenter.Basics.aks_current_server = loc3;
			this.api.datacenter.Basics.createCharacter = true;
			this.api.network.Account.setServer(loc2.value);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("SERVER_NOT_ALLOWED_IN_YOUR_LANGUAGE"),"ERROR_BOX");
		}
	}
	function canceled(loc2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
	}
}
