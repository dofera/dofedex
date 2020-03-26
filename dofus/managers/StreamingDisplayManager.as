class dofus.managers.StreamingDisplayManager extends dofus.utils.ApiElement
{
   static var DEFAULT_DISPLAY = 19;
   static var DOWNLOAD_DISPLAY = [21,22,23,24,25];
   static var TRIGGERING_MAPS = new Array();
   function StreamingDisplayManager()
   {
      super();
      this.initConfiguration();
   }
   static function getInstance()
   {
      if(dofus.managers.StreamingDisplayManager._self == null)
      {
         dofus.managers.StreamingDisplayManager._self = new dofus.managers.StreamingDisplayManager();
      }
      return dofus.managers.StreamingDisplayManager._self;
   }
   function displayAdvice(id)
   {
      getURL("FSCommand:" add "display",id);
      var _loc3_ = this.getDisplaysSharedObject();
      if(_loc3_.data["display" + id] == undefined)
      {
         _loc3_.data["display" + id] = 1;
      }
      else
      {
         _loc3_.data["display" + id] = _loc3_.data["display" + id] + 1;
      }
      _loc3_.flush();
   }
   function displayAdviceMax(id, max)
   {
      if(this.getDisplaysSharedObject().data["display" + id] == undefined || this.getDisplaysSharedObject().data["display" + id] < max)
      {
         this.displayAdvice(id);
      }
   }
   function getMapDisplay(id)
   {
      if(dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[id] != undefined)
      {
         if(this.getDisplaysSharedObject().data["display" + dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[id]] == 1)
         {
            return this.getDefaultDisplay(this.getPlayTime());
         }
         return dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[id];
      }
      return this.getDefaultDisplay(this.getPlayTime());
   }
   function getPlayTime()
   {
      return getTimer() / 1000;
   }
   function getDefaultDisplay(playtime)
   {
      if(playtime < 1200)
      {
         return dofus.managers.StreamingDisplayManager.DEFAULT_DISPLAY;
      }
      return dofus.managers.StreamingDisplayManager.DOWNLOAD_DISPLAY[Math.floor((playtime - 1200) / 300) % dofus.managers.StreamingDisplayManager.DOWNLOAD_DISPLAY.length];
   }
   function initConfiguration()
   {
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10300] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10284] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10299] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10285] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10298] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10276] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10283] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10294] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10292] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10279] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10296] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10289] = 1;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10305] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10321] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10322] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10323] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10324] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10325] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10326] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10327] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10328] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10329] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10330] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10331] = 2;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10273] = 4;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10337] = 3;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10258] = 3;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10295] = 5;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10288] = 6;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10290] = 6;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10287] = 6;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10345] = 6;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10346] = 6;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10344] = 6;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10297] = 14;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10349] = 14;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10317] = 14;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10304] = 14;
      dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10318] = 26;
   }
   function getDisplaysSharedObject()
   {
      if(this._soDisplays == undefined && this.api.datacenter.Player.Name)
      {
         this._soDisplays = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_DISPLAYS_NAME + this.api.datacenter.Player.Name);
      }
      return this._soDisplays;
   }
   function onNicknameChoice()
   {
      this.displayAdvice(16);
   }
   function onCharacterCreation()
   {
      this.displayAdvice(17);
   }
   function onCharacterChoice()
   {
      this.displayAdvice(18);
   }
   function onFightStart()
   {
      this.displayAdviceMax(7,2);
   }
   function onFightStartEnd()
   {
      this.displayAdviceMax(8,2);
   }
   function onFightEnd()
   {
      if(this.api.datacenter.Player.LP < this.api.datacenter.Player.LPmax)
      {
         this.displayAdviceMax(12,2);
      }
      else
      {
         this.displayAdvice(this.getMapDisplay(this._nCurrentMap));
      }
   }
   function onNewInterface(link)
   {
      _global.clearInterval(this._nNewInterfaceTimer);
      this._nNewInterfaceTimer = _global.setInterval(this,"newInterface",200,link);
   }
   function newInterface(link)
   {
      _global.clearInterval(this._nNewInterfaceTimer);
      switch(link)
      {
         case "Inventory":
            this.displayAdviceMax(9,2);
            break;
         case "Spells":
            this.displayAdviceMax(10,2);
            break;
         case "StatsJob":
            this.displayAdviceMax(11,2);
      }
   }
   function onInterfaceClose(instanceName)
   {
      _global.clearInterval(this._nNewInterfaceTimer);
      switch(instanceName)
      {
         case "Inventory":
         case "Spells":
         case "StatsJob":
            this.displayAdvice(this.getMapDisplay(this._nCurrentMap));
      }
   }
   function onLevelGain()
   {
      this.displayAdviceMax(13,2);
   }
   function onNewMap(id)
   {
      this._nCurrentMap = id;
      this.displayAdvice(this.getMapDisplay(id));
   }
}
