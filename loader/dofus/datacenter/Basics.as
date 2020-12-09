class dofus.datacenter.Basics extends dofus.utils.ApiElement
{
	var aks_current_regional_version = Number.POSITIVE_INFINITY;
	function Basics()
	{
		super();
		this.initialize();
	}
	function __set__login(§\x1e\x10\x18§)
	{
		this._sLogin = var2.toLowerCase();
		return this.__get__login();
	}
	function __get__login()
	{
		return this._sLogin;
	}
	function __get__aks_infos_highlightCoords()
	{
		return this._aks_infos_highlightCoords;
	}
	function __set__aks_infos_highlightCoords(§\b§)
	{
		this._aks_infos_highlightCoords = var2;
		this.api.ui.getUIComponent("Banner").illustration.updateFlags();
		return this.__get__aks_infos_highlightCoords();
	}
	function __set__banner_targetCoords(§\b§)
	{
		this._banner_targetCoords = var2;
		this.api.ui.getUIComponent("Banner").illustration.updateFlags();
		return this.__get__banner_targetCoords();
	}
	function __get__banner_targetCoords()
	{
		return this._banner_targetCoords;
	}
	function team(§\x1e\x1c\x11§)
	{
		var var3 = new ank.utils.
();
		var var4 = this.api.datacenter.Sprites.getItems();
		for(var i in var4)
		{
			if(this.api.datacenter.Sprites.getItemAt(i).Team == var2)
			{
				var3.push(this.api.datacenter.Sprites.getItemAt(i));
			}
		}
		return var3;
	}
	function initialize()
	{
		delete this.connexionKey;
		delete this.lastPingTimer;
		delete this.gfx_lastActionTime;
		delete this.gfx_canLaunch;
		delete this.gfx_lastArea;
		this.lastDateUpdate = -1000000;
		this.aks_server_will_disconnect = false;
		this.aks_gifts_stack = new Array();
		delete this.aks_chat_lastActionTime;
		this.chat_type_visible = new Object();
		delete this.aks_emote_lastActionTime;
		delete this.aks_exchange_echangeType;
		_global.clearInterval(this.aks_infos_lifeRestoreInterval);
		delete this.aks_infos_lifeRestoreInterval;
		delete this.aks_infos_highlightCoords;
		delete this.aks_ticket;
		delete this.aks_gameserver_ip;
		delete this.aks_gameserver_port;
		this.aks_rescue_count = -1;
		this.aks_servers = new ank.utils.
();
		delete this.aks_current_server;
		delete this.aks_identity;
		if(this.aks_a_logs == undefined)
		{
			this.aks_a_logs = "";
		}
		this.aks_a_prompt = "";
		this.aks_debug_command_line = "";
		delete this.spellManager_errorMsg;
		delete this.interactionsManager_path;
		delete this.inventory_filter;
		delete this.banner_targetCoords;
		this.payzone_isFirst = true;
		delete this.quests_lastID;
		this.craftViewer_filter = [true,true,true,true,true,true,true,true];
		this.mapExplorer_filter = [false,false,true,false,true];
		this.mapExplorer_zoom = 50;
		this.mapExplorer_coord = undefined;
		this.mapExplorer_grid = false;
		this.isLogged = false;
		this.inGame = false;
		this.serverMessageID = -1;
		this.createCharacter = false;
		this.chatParams = new Object();
		this.aks_current_team = -1;
		this.aks_team1_starts = null;
		this.aks_team2_starts = null;
		this.inactivity_signaled = 0;
		this.first_connection_from_miniclip = false;
		this.first_movement = false;
		this.canUseSeeAllSpell = true;
		_global.API.kernel.SpellsBoostsManager.clear();
	}
	function aks_infos_highlightCoords_clear(§\x05\x0e§)
	{
		if(_global.isNaN(var2))
		{
			this._aks_infos_highlightCoords = new Array();
		}
		else
		{
			var var3 = new Array();
			var var4 = 0;
			while(var4 < this._aks_infos_highlightCoords.length)
			{
				if(this._aks_infos_highlightCoords[var4].type != var2)
				{
					var3.push(this._aks_infos_highlightCoords[var4]);
				}
				var4 = var4 + 1;
			}
			this._aks_infos_highlightCoords = var3;
		}
		this.api.ui.getUIComponent("Banner").illustration.updateFlags();
	}
}
