class dofus.managers.AdminManager extends dofus.utils.ApiElement
{
   static var _sSelf = null;
   function AdminManager()
   {
      super();
      dofus.managers.AdminManager._sSelf = this;
   }
   static function getInstance()
   {
      return dofus.managers.AdminManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      this._nUICounter = 0;
      this.loadXML();
   }
   function showPopupMenu(pm)
   {
      pm.show(_root._xmouse,_root._ymouse,true);
   }
   function loadXML(bShow)
   {
      var _loc2_ = new XML();
      _loc2_.parent = this;
      _loc2_.onLoad = function(bSuccess)
      {
         if(bSuccess)
         {
            this.parent.xml = this;
            this.parent.initStartup(this.firstChild.firstChild);
         }
         else
         {
            this.parent.xml = undefined;
         }
         if(bShow)
         {
            this.parent.showAdminPopupMenu();
         }
      };
      _loc2_.ignoreWhite = true;
      _loc2_.load(dofus.Constants.XML_ADMIN_MENU_PATH);
   }
   function showAdminPopupMenu(sPlayerName)
   {
      var _loc3_ = this.api.datacenter.Sprites.getItems();
      var _loc4_ = false;
      for(var a in _loc3_)
      {
         var _loc5_ = _loc3_[a];
         if(_loc5_.name.toUpperCase() == this.api.datacenter.Player.Name.toUpperCase())
         {
            this.myPlayerObject = _loc5_;
         }
         if(_loc5_.name.toUpperCase() == sPlayerName.toUpperCase())
         {
            this.playerObject = _loc5_;
            _loc4_ = true;
            break;
         }
      }
      if(!_loc4_)
      {
         this.playerObject = null;
      }
      if(sPlayerName != undefined)
      {
         this.playerName = sPlayerName;
      }
      if(this.xml != undefined)
      {
         this.createAndShowPopupMenu(this.xml.firstChild.firstChild);
      }
      else
      {
         var _loc6_ = this.api.ui.createPopupMenu();
         _loc6_.addStaticItem("XML not found");
         _loc6_.addItem("Reload XML",this,this.loadXML,[true]);
         this.showPopupMenu(_loc6_);
      }
   }
   function generateDateString()
   {
      var _loc2_ = new Date();
      var _loc3_ = String(_loc2_.getFullYear());
      if(_loc3_.length < 2)
      {
         _loc3_ = "0" + _loc3_;
      }
      var _loc4_ = String(_loc2_.getMonth());
      if(_loc4_.length < 2)
      {
         _loc4_ = "0" + _loc4_;
      }
      var _loc5_ = String(_loc2_.getDate());
      if(_loc5_.length < 2)
      {
         _loc5_ = "0" + _loc5_;
      }
      this.date = _loc3_ + "/" + _loc4_ + "/" + _loc5_;
   }
   function generateHourString()
   {
      var _loc2_ = new Date();
      var _loc3_ = String(_loc2_.getHours());
      if(_loc3_.length < 2)
      {
         _loc3_ = "0" + _loc3_;
      }
      var _loc4_ = String(_loc2_.getMinutes());
      if(_loc4_.length < 2)
      {
         _loc4_ = "0" + _loc4_;
      }
      var _loc5_ = String(_loc2_.getSeconds());
      if(_loc5_.length < 2)
      {
         _loc5_ = "0" + _loc5_;
      }
      this.hour = _loc3_ + ":" + _loc4_ + ":" + _loc5_;
   }
   function generateHourAndDate()
   {
      this.generateDateString();
      this.generateHourString();
   }
   function createAndShowPopupMenu(node)
   {
      this.generateHourAndDate();
      var _loc3_ = this.api.ui.createPopupMenu();
      while(node != null && node != undefined)
      {
         var _loc4_ = this.replace(node.attributes.label);
         switch(node.attributes.type)
         {
            case "static":
               _loc3_.addStaticItem(_loc4_);
               break;
            case "menu":
               _loc3_.addItem(_loc4_ + " >>",this,this.createAndShowPopupMenu,[node.firstChild]);
               break;
            case "menuDebug":
               if(dofus.Constants.DEBUG)
               {
                  _loc3_.addItem(_loc4_ + " >>",this,this.createAndShowPopupMenu,[node.firstChild]);
               }
               break;
            case "loadXML":
               _loc3_.addItem(_loc4_,this,this.loadXML,[true]);
               break;
            case "startup":
               break;
            default:
               _loc3_.addItem(_loc4_,this,this.executeFirst,[node]);
         }
         node = node.nextSibling;
      }
      this.showPopupMenu(_loc3_);
   }
   function initStartup(node)
   {
      while(node != null && node != undefined)
      {
         if(node.attributes.type == "startup")
         {
            this._startupNode = node;
            return undefined;
         }
         node = node.nextSibling;
      }
   }
   function executeFirst(node)
   {
      this.removeInterval();
      this._sSaveNode = node.cloneNode(true);
      this.execute(this._sSaveNode);
   }
   function execute(node)
   {
      if(node.attributes.check != true)
      {
         this.generateHourAndDate();
         this._sCurrentNode = node;
         var _loc3_ = node.attributes.command;
         if(_loc3_ != undefined)
         {
            _loc3_ = this.replaceCommand(_loc3_);
            if(_loc3_ == null)
            {
               return false;
            }
         }
         switch(node.attributes.type)
         {
            case "sendCommand":
               this.sendCommand(_loc3_);
            case "sendChat":
               this.sendChat(_loc3_);
            case "prepareCommand":
               this.prepareCommand(_loc3_);
            case "prepareChat":
               this.prepareChat(_loc3_);
            case "clearConsole":
               this.clearConsole();
            case "openConsole":
               this.openConsole();
            case "closeConsole":
               this.closeConsole();
            case "move":
               this.move(Number(node.attributes.cell),!!node.attributes.dirs);
            case "emote":
               this.emote(Number(node.attributes.num));
            case "smiley":
               this.smiley(Number(node.attributes.num));
            case "direction":
               this.direction(Number(node.attributes.num));
            case "batch":
               return this.batch(node.firstChild);
            case "summoner":
               this.itemSummoner();
            default:
               node.attributes.check = true;
         }
      }
      return true;
   }
   function batch(node)
   {
      while(node != null && node != undefined)
      {
         var _loc3_ = this.execute(node);
         if(_loc3_ == false)
         {
            return false;
         }
         var _loc4_ = node.nextSibling;
         var _loc5_ = Number(node.attributes.delay);
         if(!_global.isNaN(_loc5_) && node.attributes.delayCheck != true)
         {
            ank.utils.Timer.setTimer(this,"batch",this,this.onCommandDelay,_loc5_);
            return false;
         }
         var _loc6_ = node.parentNode;
         if(_loc6_.attributes.repeatCheck == undefined)
         {
            _loc6_.attributes.repeatCheck = 1;
         }
         var _loc7_ = _loc6_.attributes.repeat;
         if(_loc4_ == undefined && (!_global.isNaN(_loc7_) && _loc6_.attributes.repeatCheck < _loc7_))
         {
            var _loc8_ = 0;
            while(_loc8_ < _loc6_.childNodes.length)
            {
               _loc6_.childNodes[_loc8_].attributes.check = false;
               _loc6_.childNodes[_loc8_].attributes.delayCheck = false;
               _loc8_ = _loc8_ + 1;
            }
            _loc6_.attributes.repeatCheck = _loc6_.attributes.repeatCheck + 1;
            _loc4_ = _loc6_.childNodes[0];
         }
         node = _loc4_;
      }
      return true;
   }
   function onCommandDelay()
   {
      this._sCurrentNode.attributes.delayCheck = true;
      this.removeInterval();
      this.resumeExecute();
   }
   function removeInterval()
   {
      ank.utils.Timer.removeTimer(this,"batch");
   }
   function resumeExecute()
   {
      this.execute(this._sSaveNode);
   }
   function openConsole()
   {
      this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
   }
   function closeConsole()
   {
      this.api.ui.unloadUIComponent("Debug");
   }
   function prepareCommand(sCommand)
   {
      this.api.ui.loadUIComponent("Debug","Debug",{command:sCommand},{bStayIfPresent:true});
   }
   function sendCommand(sCommand)
   {
      this.api.kernel.DebugConsole.process(sCommand);
   }
   function prepareChat(sCommand)
   {
      this.api.ui.getUIComponent("Banner").txtConsole = sCommand;
   }
   function sendChat(sCommand)
   {
      this.api.kernel.Console.process(sCommand);
   }
   function clearConsole()
   {
      this.api.ui.getUIComponent("Debug").clear();
   }
   function move(nCellNum, bAllDirections)
   {
      this.api.datacenter.Player.InteractionsManager.calculatePath(this.api.gfx.mapHandler,nCellNum,true,this.api.datacenter.Game.isFight,true,bAllDirections);
      if(this.api.datacenter.Basics.interactionsManager_path.length != 0)
      {
         var _loc4_ = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
         if(_loc4_ != undefined)
         {
            this.myPlayerObject.GameActionsManager.transmittingMove(1,[_loc4_]);
            delete this.api.datacenter.Basics.interactionsManager_path;
         }
      }
   }
   function smiley(nIndex)
   {
      this.api.network.Chat.useSmiley(nIndex);
   }
   function emote(nIndex)
   {
      this.api.network.Emotes.useEmote(nIndex);
   }
   function direction(nIndex)
   {
      this.api.network.Emotes.setDirection(nIndex);
   }
   function itemSummoner()
   {
      this.api.ui.loadUIComponent("ItemSummoner","ItemSummoner");
   }
   function replace(sText)
   {
      var _loc3_ = new Array();
      _loc3_.push({f:"%g",t:this.playerObject.guildName});
      _loc3_.push({f:"%c",t:this.playerObject.cellNum});
      _loc3_.push({f:"%p",t:this.playerName});
      _loc3_.push({f:"%n",t:this.api.datacenter.Player.Name});
      _loc3_.push({f:"%d",t:this.date});
      _loc3_.push({f:"%h",t:this.hour});
      _loc3_.push({f:"%t",t:this.api.kernel.NightManager.time});
      _loc3_.push({f:"%s",t:this.api.datacenter.Basics.aks_a_prompt});
      _loc3_.push({f:"%m",t:this.api.datacenter.Map.id});
      _loc3_.push({f:"%v",t:dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + " (" + dofus.Constants.VERSIONDATE + ")"});
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         sText = sText.split(_loc3_[_loc4_].f).join(_loc3_[_loc4_].t);
         _loc4_ = _loc4_ + 1;
      }
      return sText;
   }
   function replaceCommand(sText)
   {
      var _loc3_ = new Array();
      _loc3_.push({f:"#item",ui:"ItemSelector"});
      _loc3_.push({f:"#look",ui:"MonsterAndLookSelector"});
      _loc3_.push({f:"#monster",ui:"MonsterAndLookSelector",p:{monster:true}});
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(sText.indexOf(_loc3_[_loc4_].f) != -1)
         {
            this._nUICounter = this._nUICounter + 1;
            var _loc5_ = this.api.ui.loadUIComponent(_loc3_[_loc4_].ui,_loc3_[_loc4_].ui + this._nUICounter,_loc3_[_loc4_].p);
            _loc5_.addEventListener("select",this);
            _loc5_.addEventListener("cancel",this);
            return null;
         }
         _loc4_ = _loc4_ + 1;
      }
      return this.replace(sText);
   }
   function replaceUI(sText, sToReplace, sReplacer)
   {
      var _loc5_ = sText.indexOf(sToReplace);
      var _loc6_ = sText.split("");
      _loc6_.splice(_loc5_,sToReplace.length,sReplacer);
      var _loc7_ = _loc6_.join("");
      return _loc7_;
   }
   function cancel(oEvent)
   {
   }
   function characterEnteringGame()
   {
      if(this._startupNode != null && this._startupNode != undefined)
      {
         this.playerObject = this.api.datacenter.Player;
         this.playerName = (dofus.datacenter.LocalPlayer)this.playerObject.Name;
         this.batch(this._startupNode.firstChild);
      }
   }
   function select(oEvent)
   {
      switch(oEvent.ui)
      {
         case "ItemSelector":
            this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command,"#item",oEvent.itemId + " " + oEvent.itemQuantity);
            break;
         case "LookSelector":
            this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command,"#look",oEvent.lookId);
            break;
         case "MonsterSelector":
            this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command,"#monster",oEvent.monsterId);
      }
      this.resumeExecute();
   }
}
