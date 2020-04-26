class dofus.graphics.gapi.ui.ServerList extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ServerList";
	static var SEARCH_DELAY = 500;
	var _nLastSearchTimer = 0;
	function ServerList()
	{
		super();
	}
	function __set__servers(loc2)
	{
		this._eaServers = loc2;
		this._eaServersSave = loc2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__servers();
	}
	function __set__serverID(loc2)
	{
		this._nServerID = loc2;
		return this.__get__serverID();
	}
	function __get__selectedServerID()
	{
		return this._nServerID;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ServerList.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		this._dgServers.addEventListener("itemSelected",this);
		this._dgServers.addEventListener("itemdblClick",this);
		this._dgServers.addEventListener("itemRollOver",this);
		this._dgServers.addEventListener("itemRollOut",this);
		this._btnClose.addEventListener("click",this);
		this._btnSelect.addEventListener("click",this);
		this._btnSearch.addEventListener("click",this);
		this._btnDisplayAllCommunities.addEventListener("click",this);
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
		this._winBg.title = "Liste des serveurs";
		this._btnSelect.label = this.api.lang.getText("SELECT");
		this._btnClose.label = this.api.lang.getText("BACK");
		this._btnSearch.label = this.api.lang.getText("OK");
		this._lblSearch.text = this.api.lang.getText("FIND_FRIEND");
		this._lblDisplayAllCommunities.text = this.api.lang.getText("SERVER_LIST_DISPLAY_ALL_COMMUNITIES");
		this._tiSearch.text = !this._tiSearch.text.length?this.api.lang.getText("PSEUDO_DOFUS_SIMPLE"):this._tiSearch.text;
		this._dgServers.columnsNames = ["",this.api.lang.getText("NAME_BIG"),this.api.lang.getText("TYPE"),this.api.lang.getText("STATE"),this.api.lang.getText("COMMUNITY"),this.api.lang.getText("POPULATION")];
	}
	function updateData()
	{
		if(this.api.lang.getConfigText("SERVER_LIST_USE_FIND_FRIEND"))
		{
			this._dgServers._y = this._mcPlacer._y;
		}
		if(_global.CONFIG.onlyHardcore && !this._alreadySetShowAll)
		{
			this._btnDisplayAllCommunities.selected = true;
			this._alreadySetShowAll = true;
		}
		var loc2 = new ank.utils.();
		var loc3 = new ank.utils.();
		var loc4 = new Object();
		var loc5 = 0;
		while(loc5 < this._eaServers.length)
		{
			var loc6 = this._eaServers[loc5];
			if((loc6.isHardcore() || (this._btnDisplayAllCommunities.selected || (loc6.community == this.api.datacenter.Basics.communityId || loc6.community == dofus.datacenter.Server.SERVER_COMMUNITY_INTERNATIONAL))) && loc6.isAllowed())
			{
				loc2.push(this._eaServers[loc5]);
			}
			loc5 = loc5 + 1;
		}
		var loc7 = 0;
		while(loc7 < loc2.length)
		{
			var loc8 = loc2[loc7];
			if(loc8 != undefined)
			{
				var loc9 = loc8.language;
				loc8.sortPopulation = loc8.population;
				if(this.api.config.language != loc9)
				{
					if(loc4[loc9] == undefined)
					{
						loc4[loc9] = new ank.utils.();
					}
					loc4[loc9].push(loc8);
				}
				else
				{
					loc3.push(loc8);
				}
			}
			loc7 = loc7 + 1;
		}
		loc3.sortOn("sortPopulation");
		for(var loc10 in loc4)
		{
			loc10.sortOn("sortPopulation");
			var loc11 = 0;
			while(loc11 < loc10.length)
			{
				loc3.push(loc10[loc11]);
				loc11 = loc11 + 1;
			}
		}
		this._dgServers.dataProvider = loc3;
		var loc12 = 0;
		if(this._nServerID != undefined)
		{
			var loc13 = 0;
			while(loc13 < loc3.length)
			{
				if(loc3[loc13].id == this._nServerID)
				{
					loc12 = loc13;
					break;
				}
				loc13 = loc13 + 1;
			}
		}
		this._dgServers.selectedIndex = loc12;
		this._nServerID = this._dgServers.selectedItem.id;
	}
	function findFriend()
	{
		if(this._tiSearch.text == this.api.lang.getText("PSEUDO_DOFUS_SIMPLE") || !this._tiSearch.text.length)
		{
			this._eaServers = this._eaServersSave;
			this._lblSearchResult.text = "";
			this.updateData();
			return undefined;
		}
		if(this._nLastSearchTimer + dofus.graphics.gapi.ui.ServerList.SEARCH_DELAY > getTimer())
		{
			return undefined;
		}
		this._nLastSearchTimer = getTimer();
		this.api.network.Account.searchForFriend(this._tiSearch.text);
	}
	function setSearchResult(loc2)
	{
		this._eaServers = new ank.utils.();
		var loc3 = 0;
		while(loc3 < this._eaServersSave.length)
		{
			var loc4 = 0;
			while(loc4 < loc2.length)
			{
				if(loc2[loc4].server == this._eaServersSave[loc3].id)
				{
					this._eaServersSave[loc3].friendCharactersCount = loc2[loc4].count;
					this._eaServersSave[loc3].search = this._tiSearch.text;
					this._eaServers.push(this._eaServersSave[loc3]);
					break;
				}
				loc4 = loc4 + 1;
			}
			loc3 = loc3 + 1;
		}
		this._eaServers.bubbleSortOn("friendCharactersCount",Array.DESCENDING | Array.NUMERIC);
		if(!this._eaServers.length)
		{
			this._lblSearchResult.text = this.api.lang.getText("SEARCH_RESULT_EMPTY");
		}
		else
		{
			this._lblSearchResult.text = "";
		}
		this.updateData();
	}
	function onServerSelected()
	{
		this._nServerID = this._dgServers.selectedItem.id;
		if(this._nServerID == undefined)
		{
			return undefined;
		}
		this.gapi.loadUIComponent("ServerInformations","ServerInformations",{server:this._nServerID});
		this.gapi.getUIComponent("ServerInformations").addEventListener("serverSelected",this);
		this.gapi.getUIComponent("ServerInformations").addEventListener("canceled",this);
	}
	function serverSelected(loc2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
		this.dispatchEvent({type:"serverSelected",serverID:loc2.value});
	}
	function canceled(loc2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
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
		switch(loc2.target)
		{
			case this._btnSelect:
				this.onServerSelected();
				break;
			case this._btnClose:
				this.unloadThis();
				break;
			case this._btnDisplayAllCommunities:
				this.updateData();
				break;
			case this._btnSearch:
				this.findFriend();
		}
	}
	function itemRollOver(loc2)
	{
		loc2.row.cellRenderer_mc.over();
	}
	function itemRollOut(loc2)
	{
		loc2.row.cellRenderer_mc.out();
	}
	function itemSelected(loc2)
	{
		this._nServerID = this._dgServers.selectedItem.id;
	}
	function itemdblClick(loc2)
	{
		this.onServerSelected();
	}
}
