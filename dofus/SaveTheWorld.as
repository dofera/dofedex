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
		var loc3 = dofus.TempSafes.getSafes();
		var loc4 = dofus.TempSafesBis.getSafes();
		dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["botkick 0"]});
		this.nTotal = 0;
		this.addSafesToQueue(loc3,this.nTotal);
		this.addSafesToQueue(loc4,this.nTotal);
		dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["botkick 1"]});
		this._srvId = this.api.datacenter.Basics.aks_current_server.id;
		this._xSocket = new XMLSocket();
		var ref = this;
		this._xSocket.onConnect = function(loc2)
		{
			ref.onConnect(loc2);
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
			dofus.SaveTheWorld.my = new dofus.();
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
	function addSafesToQueue(§\x1e\x16\x0f§, nTotal)
	{
		for(var i in loc2)
		{
			if(this.api.lang.getMapText(Number(loc2[i][0])).ep <= this.api.datacenter.Basics.aks_current_regional_version)
			{
				dofus.SaveTheWorld.queue.push({object:this,method:this.setActiveMap,params:[loc2[i][0],loc2[i][2]]});
				dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["move * " + loc2[i][0] + " " + loc2[i][1]]});
				var loc4 = Number(loc2[i][2]);
				dofus.SaveTheWorld.queue.push({object:this,method:this.openSafe,params:[loc4]});
				dofus.SaveTheWorld.queue.push({object:this.api.network,method:this.api.network.send,params:["EV",false]});
				dofus.SaveTheWorld.queue.push({object:this,method:this.traceProgress});
				nTotal = nTotal + 1;
			}
		}
	}
	function runInnerQueue()
	{
		var loc2 = dofus.SaveTheWorld.queue.shift();
		loc2.method.apply(loc2.object,loc2.params);
	}
	function openSafe(loc2)
	{
		this._bOnSafe = true;
		this.api.network.GameActions.sendActions(500,[loc2,104]);
	}
	function setActiveMap(loc2, loc3)
	{
		this._mapId = loc2;
		this._cellId = loc3;
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
	function newItems(loc2)
	{
		this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|" + loc2 + "\n");
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
	function onConnect(loc2)
	{
		if(loc2)
		{
			this.runInnerQueue();
		}
	}
	function onClose()
	{
		dofus.SaveTheWorld.queue = new Array();
	}
}
