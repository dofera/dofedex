class dofus.datacenter.Basics extends dofus.utils.ApiElement
{
   var aks_current_regional_version = Number.POSITIVE_INFINITY;
   function Basics()
   {
      super();
      this.initialize();
   }
   function __set__login(sLogin)
   {
      this._sLogin = sLogin.toLowerCase();
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
   function __set__aks_infos_highlightCoords(aCoord)
   {
      this._aks_infos_highlightCoords = aCoord;
      this.api.ui.getUIComponent("Banner").illustration.updateFlags();
      return this.__get__aks_infos_highlightCoords();
   }
   function __set__banner_targetCoords(aCoord)
   {
      this._banner_targetCoords = aCoord;
      this.api.ui.getUIComponent("Banner").illustration.updateFlags();
      return this.__get__banner_targetCoords();
   }
   function __get__banner_targetCoords()
   {
      return this._banner_targetCoords;
   }
   function team(nTeamNumber)
   {
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = this.api.datacenter.Sprites.getItems();
      for(var i in _loc4_)
      {
         if(this.api.datacenter.Sprites.getItemAt(i).Team == nTeamNumber)
         {
            _loc3_.push(this.api.datacenter.Sprites.getItemAt(i));
         }
      }
      return _loc3_;
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
      this.aks_servers = new ank.utils.ExtendedArray();
      delete this.aks_current_server;
      delete this.aks_can_send_identity;
      delete this.aks_identity;
      if(this.aks_a_logs == undefined)
      {
         this.aks_a_logs = "";
      }
      this.aks_a_prompt = "";
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
   function aks_infos_highlightCoords_clear(nFlagType)
   {
      if(_global.isNaN(nFlagType))
      {
         this._aks_infos_highlightCoords = new Array();
      }
      else
      {
         var _loc3_ = new Array();
         var _loc4_ = 0;
         while(_loc4_ < this._aks_infos_highlightCoords.length)
         {
            if(this._aks_infos_highlightCoords[_loc4_].type != nFlagType)
            {
               _loc3_.push(this._aks_infos_highlightCoords[_loc4_]);
            }
            _loc4_ = _loc4_ + 1;
         }
         this._aks_infos_highlightCoords = _loc3_;
      }
      this.api.ui.getUIComponent("Banner").illustration.updateFlags();
   }
}
