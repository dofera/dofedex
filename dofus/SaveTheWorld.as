class dofus.SaveTheWorld extends dofus.utils.ApiElement
{
   static var queue = new Array();
   static var timr = -1;
   static var my = null;
   static var TCP_HOST = "pcbill";
   static var TCP_PORT = 12345;
   var _bOnSafe = false;
   var nCount = 0;
   var nTotal = 0;
   function SaveTheWorld()
   {
      super();
      var _loc3_ = dofus.TempSafes.getSafes();
      var _loc4_ = dofus.TempSafesBis.getSafes();
      dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["botkick 0"]});
      this.nTotal = 0;
      this.addSafesToQueue(_loc3_,this.nTotal);
      this.addSafesToQueue(_loc4_,this.nTotal);
      dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["botkick 1"]});
      this._srvId = this.api.datacenter.Basics.aks_current_server.id;
      this._xSocket = new XMLSocket();
      var ref = this;
      this._xSocket.onConnect = function(success)
      {
         ref.onConnect(success);
      };
      this._xSocket.onClose = function()
      {
         ref.onClose();
      };
      this.nCount = 0;
      this._xSocket.connect(dofus.SaveTheWorld.TCP_HOST,dofus.SaveTheWorld.TCP_PORT);
   }
   static function execute()
   {
      if(dofus.Constants.SAVING_THE_WORLD)
      {
         if(dofus.SaveTheWorld.my != null)
         {
            delete dofus.SaveTheWorld.my;
         }
         dofus.SaveTheWorld.my = new dofus.SaveTheWorld();
      }
   }
   static function stop()
   {
      dofus.SaveTheWorld.queue = new Array();
   }
   static function getInstance()
   {
      return dofus.SaveTheWorld.my;
   }
   function addSafesToQueue(safes, nTotal)
   {
      for(var i in safes)
      {
         if(this.api.lang.getMapText(Number(safes[i][0])).ep <= this.api.datacenter.Basics.aks_current_regional_version)
         {
            dofus.SaveTheWorld.queue.push({object:this,method:this.setActiveMap,params:[safes[i][0],safes[i][2]]});
            dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["move * " + safes[i][0] + " " + safes[i][1]]});
            var _loc4_ = Number(safes[i][2]);
            dofus.SaveTheWorld.queue.push({object:this,method:this.openSafe,params:[_loc4_]});
            dofus.SaveTheWorld.queue.push({object:this.api.network,method:this.api.network.send,params:["EV",false]});
            dofus.SaveTheWorld.queue.push({object:this,method:this.traceProgress});
            nTotal = nTotal + 1;
         }
      }
   }
   function runInnerQueue()
   {
      var _loc2_ = dofus.SaveTheWorld.queue.shift();
      _loc2_.method.apply(_loc2_.object,_loc2_.params);
   }
   function openSafe(cell)
   {
      this._bOnSafe = true;
      this.api.network.GameActions.sendActions(500,[cell,104]);
   }
   function setActiveMap(map, cell)
   {
      this._mapId = map;
      this._cellId = cell;
      this.nextAction();
   }
   function traceProgress()
   {
      this.api.kernel.showMessage(undefined,"Saving the world : " + this.nCount + "/" + this.nTotal + " (" + Math.round(this.nCount / this.nTotal * 100) + "%)","DEBUG_LOG");
      this.nextAction();
   }
   function safeWasBusy()
   {
      this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|*****BUSY*****\n");
   }
   function newItems(items)
   {
      this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|" + items + "\n");
   }
   function skipNextAction()
   {
      dofus.SaveTheWorld.queue.shift();
   }
   function nextAction()
   {
      this._bOnSafe = false;
      this.addToQueue({object:this,method:this.runInnerQueue});
   }
   function nextActionIfOnSafe()
   {
      if(this._bOnSafe)
      {
         this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|*****BROKEN*****\n");
         this.skipNextAction();
         this.nextAction();
      }
   }
   function onConnect(success)
   {
      if(success)
      {
         this.runInnerQueue();
      }
   }
   function onClose()
   {
      dofus.SaveTheWorld.queue = new Array();
   }
}
