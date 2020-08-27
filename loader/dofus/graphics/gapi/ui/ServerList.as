class dofus.graphics.gapi.ui.ServerList extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ServerList";
	static var SEARCH_DELAY = 500;
	var _nLastSearchTimer = 0;
	function ServerList()
	{
		super();
	}
	function __set__servers(var2)
	{
		this._eaServers = var2;
		this._eaServersSave = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__servers();
	}
	function __set__serverID(var2)
	{
		this._nServerID = var2;
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
		var ref = this;
		var var2 = new Object();
		var2.onSetFocus = function(var2, var3)
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
		Selection.addListener(var2);
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
		var var2 = new ank.utils.();
		var var3 = new ank.utils.();
		var var4 = new Object();
		var var5 = 0;
		while(var5 < this._eaServers.length)
		{
			var var6 = this._eaServers[var5];
			if((var6.isHardcore() || (this._btnDisplayAllCommunities.selected || (var6.community == this.api.datacenter.Basics.communityId || var6.community == dofus.datacenter.Server.SERVER_COMMUNITY_INTERNATIONAL))) && var6.isAllowed())
			{
				var2.push(this._eaServers[var5]);
			}
			var5 = var5 + 1;
		}
		var var7 = 0;
		while(var7 < var2.length)
		{
			var var8 = var2[var7];
			if(var8 != undefined)
			{
				var var9 = var8.language;
				var8.sortPopulation = var8.population;
				if(this.api.config.language != var9)
				{
					if(var4[var9] == undefined)
					{
						var4[var9] = new ank.utils.();
					}
					var4[var9].push(var8);
				}
				else
				{
					var3.push(var8);
				}
			}
			var7 = var7 + 1;
		}
		var3.sortOn("sortPopulation");
		for(var a in var4)
		{
			var var10 = var4[a];
			var10.sortOn("sortPopulation");
			var var11 = 0;
			while(var11 < var10.length)
			{
				var3.push(var10[var11]);
				var11 = var11 + 1;
			}
		}
		this._dgServers.dataProvider = var3;
		var var12 = 0;
		if(this._nServerID != undefined)
		{
			var var13 = 0;
			while(var13 < var3.length)
			{
				if(var3[var13].id == this._nServerID)
				{
					var12 = var13;
					break;
				}
				var13 = var13 + 1;
			}
		}
		this._dgServers.selectedIndex = var12;
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
	function setSearchResult(var2)
	{
		this._eaServers = new ank.utils.();
		var var3 = 0;
		while(var3 < this._eaServersSave.length)
		{
			var var4 = 0;
			while(var4 < var2.length)
			{
				if(var2[var4].server == this._eaServersSave[var3].id)
				{
					this._eaServersSave[var3].friendCharactersCount = var2[var4].count;
					this._eaServersSave[var3].search = this._tiSearch.text;
					this._eaServers.push(this._eaServersSave[var3]);
					break;
				}
				var4 = var4 + 1;
			}
			var3 = var3 + 1;
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
	function serverSelected(var2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
		this.dispatchEvent({type:"serverSelected",serverID:var2.value});
	}
	function canceled(var2)
	{
		this.gapi.unloadUIComponent("ServerInformations");
	}
	function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
		{
			this.click({target:this._btnSearch});
			return false;
		}
		return true;
	}
	function click(var2)
	{
		switch(var2.target)
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
	function itemRollOver(var2)
	{
		var2.row.cellRenderer_mc.over();
	}
	function itemRollOut(var2)
	{
		var2.row.cellRenderer_mc.out();
	}
	function itemSelected(var2)
	{
		this._nServerID = this._dgServers.selectedItem.id;
	}
	function itemdblClick(var2)
	{
		this.onServerSelected();
	}
}
