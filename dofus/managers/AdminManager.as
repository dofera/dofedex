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
	function initialize(loc2)
	{
		super.initialize(loc3);
		this._nUICounter = 0;
		this.loadXML();
	}
	function loadXML(bShow)
	{
		var loc2 = new XML();
		loc2.parent = this;
		loc2.onLoad = function(loc2)
		{
			if(loc2)
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
				var loc3 = this.parent.getAdminPopupMenu();
				loc3.show(_root._xmouse,_root._ymouse,true);
			}
		};
		loc2.ignoreWhite = true;
		loc2.load(dofus.Constants.XML_ADMIN_MENU_PATH);
	}
	function getAdminPopupMenu(loc2)
	{
		var loc3 = this.api.datacenter.Sprites.getItems();
		var loc4 = false;
		for(var loc5 in loc3)
		{
			if(loc5.name.toUpperCase() == this.api.datacenter.Player.Name.toUpperCase())
			{
				this.myPlayerObject = loc5;
			}
			if(loc5.name.toUpperCase() == loc2.toUpperCase())
			{
				this.playerObject = loc5;
				loc4 = true;
				break;
			}
		}
		if(!loc4)
		{
			this.playerObject = null;
		}
		if(loc2 != undefined)
		{
			this.playerName = loc2;
		}
		if(this.xml != undefined)
		{
			var loc6 = this.createPopupMenu(this.xml.firstChild.firstChild);
		}
		else
		{
			loc6 = this.api.ui.createPopupMenu();
			loc6.addStaticItem("XML not found");
			loc6.addItem("Reload XML",this,this.loadXML,[true]);
		}
		return loc6;
	}
	function generateDateString()
	{
		var loc2 = new Date();
		var loc3 = String(loc2.getFullYear());
		if(loc3.length < 2)
		{
			loc3 = "0" + loc3;
		}
		var loc4 = String(loc2.getMonth());
		if(loc4.length < 2)
		{
			loc4 = "0" + loc4;
		}
		var loc5 = String(loc2.getDate());
		if(loc5.length < 2)
		{
			loc5 = "0" + loc5;
		}
		this.date = loc3 + "/" + loc4 + "/" + loc5;
	}
	function generateHourString()
	{
		var loc2 = new Date();
		var loc3 = String(loc2.getHours());
		if(loc3.length < 2)
		{
			loc3 = "0" + loc3;
		}
		var loc4 = String(loc2.getMinutes());
		if(loc4.length < 2)
		{
			loc4 = "0" + loc4;
		}
		var loc5 = String(loc2.getSeconds());
		if(loc5.length < 2)
		{
			loc5 = "0" + loc5;
		}
		this.hour = loc3 + ":" + loc4 + ":" + loc5;
	}
	function generateHourAndDate()
	{
		this.generateDateString();
		this.generateHourString();
	}
	function createPopupMenu(loc2)
	{
		var loc3 = this.api.ui.createPopupMenu();
		this.generateHourAndDate();
		while(loc2 != null && loc2 != undefined)
		{
			var loc4 = this.replace(loc2.attributes.label);
			loop1:
			switch(loc2.attributes.type)
			{
				case "static":
					loc3.addStaticItem(loc4);
					break;
				case "menu":
					loc3.addItem(loc4 + " >>",this,this.createAndShowPopupMenu,[loc2.firstChild]);
					break;
				default:
					switch(null)
					{
						case "menuDebug":
							if(dofus.Constants.DEBUG)
							{
								loc3.addItem(loc4 + " >>",this,this.createAndShowPopupMenu,[loc2.firstChild]);
							}
							break loop1;
						case "loadXML":
							loc3.addItem(loc4,this,this.loadXML,[true]);
							break loop1;
						case "startup":
							break loop1;
						default:
							loc3.addItem(loc4,this,this.executeFirst,[loc2]);
					}
			}
			loc2 = loc2.nextSibling;
		}
		return loc3;
	}
	function createAndShowPopupMenu(loc2)
	{
		var loc3 = this.createPopupMenu(loc2);
		loc3.show(_root._xmouse,_root._ymouse,true);
	}
	function initStartup(loc2)
	{
		while(loc2 != null && loc2 != undefined)
		{
			if(loc2.attributes.type == "startup")
			{
				this._startupNode = loc2;
				return undefined;
			}
			loc2 = loc2.nextSibling;
		}
	}
	function executeFirst(loc2)
	{
		this.removeInterval();
		this._sSaveNode = loc2.cloneNode(true);
		this.execute(this._sSaveNode);
	}
	function execute(loc2)
	{
		if(loc2.attributes.check != true)
		{
			this.generateHourAndDate();
			this._sCurrentNode = loc2;
			var loc3 = loc2.attributes.command;
			if(loc3 != undefined)
			{
				loc3 = this.replaceCommand(loc3);
				if(loc3 == null)
				{
					return false;
				}
			}
			loop0:
			switch(loc2.attributes.type)
			{
				case "sendCommand":
					this.sendCommand(loc3);
					break;
				case "sendChat":
					this.sendChat(loc3);
					break;
				case "prepareCommand":
					this.prepareCommand(loc3);
					break;
				case "prepareChat":
					this.prepareChat(loc3);
					break;
				case "clearConsole":
					this.clearConsole();
					break;
				default:
					switch(null)
					{
						case "openConsole":
							this.openConsole();
							break loop0;
						case "closeConsole":
							this.closeConsole();
							break loop0;
						case "move":
							this.move(Number(loc2.attributes.cell),!!loc2.attributes.dirs);
							break loop0;
						case "emote":
							this.emote(Number(loc2.attributes.num));
							break loop0;
						default:
							switch(null)
							{
								case "smiley":
									this.smiley(Number(loc2.attributes.num));
									break loop0;
								case "direction":
									this.direction(Number(loc2.attributes.num));
									break loop0;
								case "batch":
									return this.batch(loc2.firstChild);
								case "summoner":
									this.itemSummoner();
							}
					}
			}
			loc2.attributes.check = true;
		}
		return true;
	}
	function batch(loc2)
	{
		while(loc2 != null && loc2 != undefined)
		{
			var loc3 = this.execute(loc2);
			if(loc3 == false)
			{
				return false;
			}
			var loc4 = loc2.nextSibling;
			var loc5 = Number(loc2.attributes.delay);
			if(!_global.isNaN(loc5) && loc2.attributes.delayCheck != true)
			{
				ank.utils.Timer.setTimer(this,"batch",this,this.onCommandDelay,loc5);
				return false;
			}
			var loc6 = loc2.parentNode;
			if(loc6.attributes.repeatCheck == undefined)
			{
				loc6.attributes.repeatCheck = 1;
			}
			var loc7 = loc6.attributes.repeat;
			if(loc4 == undefined && (!_global.isNaN(loc7) && loc6.attributes.repeatCheck < loc7))
			{
				var loc8 = 0;
				while(loc8 < loc6.childNodes.length)
				{
					loc6.childNodes[loc8].attributes.check = false;
					loc6.childNodes[loc8].attributes.delayCheck = false;
					loc8 = loc8 + 1;
				}
				loc6.attributes.repeatCheck++;
				loc4 = loc6.childNodes[0];
			}
			loc2 = loc4;
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
	function prepareCommand(loc2)
	{
		this.api.ui.loadUIComponent("Debug","Debug",{command:loc2},{bStayIfPresent:true,bAlwaysOnTop:true});
	}
	function sendCommand(loc2)
	{
		this.api.kernel.DebugConsole.process(loc2);
	}
	function prepareChat(loc2)
	{
		this.api.ui.getUIComponent("Banner").txtConsole = loc2;
	}
	function sendChat(loc2)
	{
		this.api.kernel.Console.process(loc2);
	}
	function clearConsole()
	{
		this.api.ui.getUIComponent("Debug").clear();
	}
	function move(loc2, loc3)
	{
		this.api.datacenter.Player.InteractionsManager.calculatePath(this.api.gfx.mapHandler,loc2,true,this.api.datacenter.Game.isFight,true,loc3);
		if(this.api.datacenter.Basics.interactionsManager_path.length != 0)
		{
			var loc4 = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
			if(loc4 != undefined)
			{
				this.myPlayerObject.GameActionsManager.clear();
				this.myPlayerObject.GameActionsManager.transmittingMove(1,[loc4]);
				delete this.api.datacenter.Basics.interactionsManager_path;
			}
		}
	}
	function smiley(loc2)
	{
		this.api.network.Chat.useSmiley(loc2);
	}
	function emote(loc2)
	{
		this.api.network.Emotes.useEmote(loc2);
	}
	function direction(loc2)
	{
		this.api.network.Emotes.setDirection(loc2);
	}
	function itemSummoner()
	{
		this.api.ui.loadUIComponent("ItemSummoner","ItemSummoner");
	}
	function replace(loc2)
	{
		var loc3 = new Array();
		loc3.push({f:"%g",t:this.playerObject.guildName});
		loc3.push({f:"%c",t:this.playerObject.cellNum});
		loc3.push({f:"%p",t:this.playerName});
		loc3.push({f:"%n",t:this.api.datacenter.Player.Name});
		loc3.push({f:"%d",t:this.date});
		loc3.push({f:"%h",t:this.hour});
		loc3.push({f:"%t",t:this.api.kernel.NightManager.time});
		loc3.push({f:"%s",t:this.api.datacenter.Basics.aks_a_prompt});
		loc3.push({f:"%m",t:this.api.datacenter.Map.id});
		loc3.push({f:"%v",t:dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + " (" + dofus.Constants.VERSIONDATE + ")"});
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			loc2 = loc2.split(loc3[loc4].f).join(loc3[loc4].t);
			loc4 = loc4 + 1;
		}
		return loc2;
	}
	function replaceCommand(loc2)
	{
		var loc3 = new Array();
		loc3.push({f:"#item",ui:"ItemSelector"});
		loc3.push({f:"#look",ui:"MonsterAndLookSelector"});
		loc3.push({f:"#monster",ui:"MonsterAndLookSelector",p:{monster:true}});
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			if(loc2.indexOf(loc3[loc4].f) != -1)
			{
				var loc5 = this.api.ui.loadUIComponent(loc3[loc4].ui,loc3[loc4].ui + this._nUICounter++,loc3[loc4].p);
				loc5.addEventListener("select",this);
				loc5.addEventListener("cancel",this);
				return null;
			}
			loc4 = loc4 + 1;
		}
		return this.replace(loc2);
	}
	function replaceUI(loc2, loc3, loc4)
	{
		var loc5 = loc2.indexOf(loc3);
		var loc6 = loc2.split("");
		loc6.splice(loc5,loc3.length,loc4);
		var loc7 = loc6.join("");
		return loc7;
	}
	function cancel(loc2)
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
	function select(loc2)
	{
		switch(loc2.ui)
		{
			case "ItemSelector":
				var loc3 = this.replaceUI(this._sCurrentNode.attributes.command,"#item",loc2.itemId + " " + loc2.itemQuantity);
				if(loc3 != undefined)
				{
					loc3 = this.replaceCommand(loc3);
				}
				if(loc3 != null)
				{
					this.sendCommand(loc3);
				}
				break;
			case "LookSelector":
				this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command,"#look",loc2.lookId);
				this.resumeExecute();
				break;
			case "MonsterSelector":
				this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command,"#monster",loc2.monsterId);
				this.resumeExecute();
		}
	}
}
