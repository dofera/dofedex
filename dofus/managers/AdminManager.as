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
	function initialize(var2)
	{
		super.initialize(var3);
		this._nUICounter = 0;
		this.loadXML();
	}
	function loadXML(bShow)
	{
		var var2 = new XML();
		var2.parent = this;
		var2.onLoad = function(var2)
		{
			if(var2)
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
				var var3 = this.parent.getAdminPopupMenu();
				var3.show(_root._xmouse,_root._ymouse,true);
			}
		};
		var2.ignoreWhite = true;
		var2.load(dofus.Constants.XML_ADMIN_MENU_PATH);
	}
	function getAdminPopupMenu(var2)
	{
		var var3 = this.api.datacenter.Sprites.getItems();
		var var4 = false;
		loop0:
		for(var a in var3)
		{
			var var5 = var3[a];
			if(var5.name.toUpperCase() == this.api.datacenter.Player.Name.toUpperCase())
			{
				this.myPlayerObject = var5;
			}
			if(var5.name.toUpperCase() == var2.toUpperCase())
			{
				this.playerObject = var5;
				var4 = true;
				while(true)
				{
					if(§§pop() == null)
					{
						break loop0;
					}
				}
			}
			else
			{
				continue;
			}
		}
		if(!var4)
		{
			this.playerObject = null;
		}
		if(var2 != undefined)
		{
			this.playerName = var2;
		}
		if(this.xml != undefined)
		{
			var var6 = this.createPopupMenu(this.xml.firstChild.firstChild);
		}
		else
		{
			var6 = this.api.ui.createPopupMenu();
			var6.addStaticItem("XML not found");
			var6.addItem("Reload XML",this,this.loadXML,[true]);
		}
		return var6;
	}
	function generateDateString()
	{
		var var2 = new Date();
		var var3 = String(var2.getFullYear());
		if(var3.length < 2)
		{
			var3 = "0" + var3;
		}
		var var4 = String(var2.getMonth());
		if(var4.length < 2)
		{
			var4 = "0" + var4;
		}
		var var5 = String(var2.getDate());
		if(var5.length < 2)
		{
			var5 = "0" + var5;
		}
		this.date = var3 + "/" + var4 + "/" + var5;
	}
	function generateHourString()
	{
		var var2 = new Date();
		var var3 = String(var2.getHours());
		if(var3.length < 2)
		{
			var3 = "0" + var3;
		}
		var var4 = String(var2.getMinutes());
		if(var4.length < 2)
		{
			var4 = "0" + var4;
		}
		var var5 = String(var2.getSeconds());
		if(var5.length < 2)
		{
			var5 = "0" + var5;
		}
		this.hour = var3 + ":" + var4 + ":" + var5;
	}
	function generateHourAndDate()
	{
		this.generateDateString();
		this.generateHourString();
	}
	function createPopupMenu(var2)
	{
		var var3 = this.api.ui.createPopupMenu();
		this.generateHourAndDate();
		while(var2 != null && var2 != undefined)
		{
			var var4 = this.replace(var2.attributes.label);
			switch(var2.attributes.type)
			{
				case "static":
					var3.addStaticItem(var4);
					break;
				case "menu":
					var3.addItem(var4 + " >>",this,this.createAndShowPopupMenu,[var2.firstChild]);
					break;
				case "menuDebug":
					if(dofus.Constants.DEBUG)
					{
						var3.addItem(var4 + " >>",this,this.createAndShowPopupMenu,[var2.firstChild]);
					}
					break;
				case "loadXML":
					var3.addItem(var4,this,this.loadXML,[true]);
					break;
				case "startup":
					break;
				default:
					var3.addItem(var4,this,this.executeFirst,[var2]);
			}
			var2 = var2.nextSibling;
		}
		return var3;
	}
	function createAndShowPopupMenu(var2)
	{
		var var3 = this.createPopupMenu(var2);
		var3.show(_root._xmouse,_root._ymouse,true);
	}
	function initStartup(var2)
	{
		while(var2 != null && var2 != undefined)
		{
			if(var2.attributes.type == "startup")
			{
				this._startupNode = var2;
				return undefined;
			}
			var2 = var2.nextSibling;
		}
	}
	function executeFirst(var2)
	{
		this.removeInterval();
		this._sSaveNode = var2.cloneNode(true);
		this.execute(this._sSaveNode);
	}
	function execute(var2)
	{
		if(var2.attributes.check != true)
		{
			this.generateHourAndDate();
			this._sCurrentNode = var2;
			var var3 = var2.attributes.command;
			if(var3 != undefined)
			{
				var3 = this.replaceCommand(var3);
				if(var3 == null)
				{
					return false;
				}
			}
			loop0:
			switch(var2.attributes.type)
			{
				case "sendCommand":
					this.sendCommand(var3);
					break;
				case "sendChat":
					this.sendChat(var3);
					break;
				case "prepareCommand":
					this.prepareCommand(var3);
					break;
				default:
					switch(null)
					{
						case "prepareChat":
							this.prepareChat(var3);
							break loop0;
						case "clearConsole":
							this.clearConsole();
							break loop0;
						case "openConsole":
							this.openConsole();
							break loop0;
						case "closeConsole":
							this.closeConsole();
							break loop0;
						case "move":
							this.move(Number(var2.attributes.cell),!!var2.attributes.dirs);
							break loop0;
						default:
							switch(null)
							{
								case "emote":
									this.emote(Number(var2.attributes.num));
									break loop0;
								case "smiley":
									this.smiley(Number(var2.attributes.num));
									break loop0;
								case "direction":
									this.direction(Number(var2.attributes.num));
									break loop0;
								case "batch":
									return this.batch(var2.firstChild);
								default:
									if(var0 !== "summoner")
									{
										break loop0;
									}
									this.itemSummoner();
									break loop0;
							}
					}
			}
			var2.attributes.check = true;
		}
		return true;
	}
	function batch(var2)
	{
		while(var2 != null && var2 != undefined)
		{
			var var3 = this.execute(var2);
			if(var3 == false)
			{
				return false;
			}
			var var4 = var2.nextSibling;
			var var5 = Number(var2.attributes.delay);
			if(!_global.isNaN(var5) && var2.attributes.delayCheck != true)
			{
				ank.utils.Timer.setTimer(this,"batch",this,this.onCommandDelay,var5);
				return false;
			}
			var var6 = var2.parentNode;
			if(var6.attributes.repeatCheck == undefined)
			{
				var6.attributes.repeatCheck = 1;
			}
			var var7 = var6.attributes.repeat;
			if(var4 == undefined && (!_global.isNaN(var7) && var6.attributes.repeatCheck < var7))
			{
				var var8 = 0;
				while(var8 < var6.childNodes.length)
				{
					var6.childNodes[var8].attributes.check = false;
					var6.childNodes[var8].attributes.delayCheck = false;
					var8 = var8 + 1;
				}
				var6.attributes.repeatCheck++;
				var4 = var6.childNodes[0];
			}
			var2 = var4;
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
	function prepareCommand(var2)
	{
		this.api.ui.loadUIComponent("Debug","Debug",{command:var2},{bStayIfPresent:true,bAlwaysOnTop:true});
	}
	function sendCommand(var2)
	{
		this.api.kernel.DebugConsole.process(var2);
	}
	function prepareChat(var2)
	{
		this.api.ui.getUIComponent("Banner").txtConsole = var2;
	}
	function sendChat(var2)
	{
		this.api.kernel.Console.process(var2);
	}
	function clearConsole()
	{
		this.api.ui.getUIComponent("Debug").clear();
	}
	function move(var2, var3)
	{
		this.api.datacenter.Player.InteractionsManager.calculatePath(this.api.gfx.mapHandler,var2,true,this.api.datacenter.Game.isFight,true,var3);
		if(this.api.datacenter.Basics.interactionsManager_path.length != 0)
		{
			var var4 = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
			if(var4 != undefined)
			{
				this.myPlayerObject.GameActionsManager.clear();
				this.myPlayerObject.GameActionsManager.transmittingMove(1,[var4]);
				delete this.api.datacenter.Basics.interactionsManager_path;
			}
		}
	}
	function smiley(var2)
	{
		this.api.network.Chat.useSmiley(var2);
	}
	function emote(var2)
	{
		this.api.network.Emotes.useEmote(var2);
	}
	function direction(var2)
	{
		this.api.network.Emotes.setDirection(var2);
	}
	function itemSummoner()
	{
		this.api.ui.loadUIComponent("ItemSummoner","ItemSummoner");
	}
	function replace(var2)
	{
		var var3 = new Array();
		var3.push({f:"%g",t:this.playerObject.guildName});
		var3.push({f:"%c",t:this.playerObject.cellNum});
		var3.push({f:"%p",t:this.playerName});
		var3.push({f:"%n",t:this.api.datacenter.Player.Name});
		var3.push({f:"%d",t:this.date});
		var3.push({f:"%h",t:this.hour});
		var3.push({f:"%t",t:this.api.kernel.NightManager.time});
		var3.push({f:"%s",t:this.api.datacenter.Basics.aks_a_prompt});
		var3.push({f:"%m",t:this.api.datacenter.Map.id});
		var3.push({f:"%v",t:dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + " (" + dofus.Constants.VERSIONDATE + ")"});
		var var4 = 0;
		while(var4 < var3.length)
		{
			var2 = var2.split(var3[var4].f).join(var3[var4].t);
			var4 = var4 + 1;
		}
		return var2;
	}
	function replaceCommand(var2)
	{
		var var3 = new Array();
		var3.push({f:"#item",ui:"ItemSelector"});
		var3.push({f:"#look",ui:"MonsterAndLookSelector"});
		var3.push({f:"#monster",ui:"MonsterAndLookSelector",p:{monster:true}});
		var var4 = 0;
		while(var4 < var3.length)
		{
			if(var2.indexOf(var3[var4].f) != -1)
			{
				var var5 = this.api.ui.loadUIComponent(var3[var4].ui,var3[var4].ui + this._nUICounter++,var3[var4].p);
				var5.addEventListener("select",this);
				var5.addEventListener("cancel",this);
				return null;
			}
			var4 = var4 + 1;
		}
		return this.replace(var2);
	}
	function replaceUI(var2, var3, var4)
	{
		var var5 = var2.indexOf(var3);
		var var6 = var2.split("");
		var6.splice(var5,var3.length,var4);
		var var7 = var6.join("");
		return var7;
	}
	function cancel(var2)
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
	function select(var2)
	{
		switch(var2.ui)
		{
			case "ItemSelector":
				var var3 = this.replaceUI(this._sCurrentNode.attributes.command,"#item",var2.itemId + " " + var2.itemQuantity);
				if(var3 != undefined)
				{
					var3 = this.replaceCommand(var3);
				}
				if(var3 != null)
				{
					this.sendCommand(var3);
				}
				break;
			case "LookSelector":
				this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command,"#look",var2.lookId);
				this.resumeExecute();
				break;
			case "MonsterSelector":
				this._sCurrentNode.attributes.command = this.replaceUI(this._sCurrentNode.attributes.command,"#monster",var2.monsterId);
				this.resumeExecute();
		}
	}
}
