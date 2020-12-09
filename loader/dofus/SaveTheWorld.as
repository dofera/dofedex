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
		var var3 = dofus.TempSafes.getSafes();
		var var4 = dofus.TempSafesBis.getSafes();
		dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["botkick 0"]});
		this.nTotal = 0;
		this.addSafesToQueue(var3,this.nTotal);
		this.addSafesToQueue(var4,this.nTotal);
		dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["botkick 1"]});
		this._srvId = this.api.datacenter.Basics.aks_current_server.id;
		this._xSocket = new XMLSocket();
		this._xSocket.onConnect = function(§\x1e\f\x0e§)
		{
			ref.onConnect(var2);
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
	function addSafesToQueue(§\x1e\x15\x06§, nTotal)
	{
		§§enumerate(var2);
		while((var var0 = §§enumeration()) != null)
		{
			if(this.api.lang.getMapText(Number(var2[i][0])).ep <= this.api.datacenter.Basics.aks_current_regional_version)
			{
				dofus.SaveTheWorld.queue.push({object:this,method:this.setActiveMap,params:[var2[i][0],var2[i][2]]});
				dofus.SaveTheWorld.queue.push({object:this.api.network.Basics,method:this.api.network.Basics.autorisedCommand,params:["move * " + var2[i][0] + " " + var2[i][1]]});
				var var4 = Number(var2[i][2]);
				dofus.SaveTheWorld.queue.push({object:this,method:this.openSafe,params:[var4]});
				dofus.SaveTheWorld.queue.push({object:this.api.network,method:this.api.network.send,params:["EV",false]});
				dofus.SaveTheWorld.queue.push({object:this,method:this.traceProgress});
				nTotal = nTotal + 1;
			}
		}
	}
	function runInnerQueue()
	{
		var var2 = dofus.SaveTheWorld.queue.shift();
		var2.method.apply(var2.object,var2.params);
	}
	function openSafe(§\x13\x0e§)
	{
		this._bOnSafe = true;
		this.api.network.GameActions.sendActions(500,[var2,104]);
	}
	function setActiveMap(§\x0b\x13§, §\x13\x0e§)
	{
		this._mapId = var2;
		this._cellId = var3;
		this.nextAction();
	}
	function traceProgress()
	{
		org.flashdevelop.utils.FlashConnect.mtrace("[?!!] Saving the world : " + ++this.nCount + "/" + this.nTotal + " (" + Math.round(this.nCount / this.nTotal * 100) + "%)","dofus.SaveTheWorld::traceProgress","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/SaveTheWorld.as",139);
		this.api.kernel.showMessage(undefined,"Saving the world : " + this.nCount + "/" + this.nTotal + " (" + Math.round(this.nCount / this.nTotal * 100) + "%)","DEBUG_LOG");
		this.nextAction();
	}
	function safeWasBusy()
	{
		this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|*****BUSY*****\n");
	}
	function newItems(§\f\x13§)
	{
		this._xSocket.send(this._srvId + "|" + this._mapId + "|" + this._cellId + "|" + var2 + "\n");
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
	function onConnect(§\x1e\f\x0e§)
	{
		org.flashdevelop.utils.FlashConnect.mtrace("Socket connexion result : " + (!var2?"Failed! :((((((":"OK! :)))))"),"dofus.SaveTheWorld::onConnect","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/SaveTheWorld.as",177);
		if(var2)
		{
			this.runInnerQueue();
		}
	}
	function onClose()
	{
		org.flashdevelop.utils.FlashConnect.mtrace("Socket closed! :((((","dofus.SaveTheWorld::onClose","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/SaveTheWorld.as",184);
		dofus.SaveTheWorld.queue = new Array();
	}
}
