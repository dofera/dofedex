class dofus.managers.AdminManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	static var DELAYED_REFRESH_DURATION = 100;
	function AdminManager()
	{
		super();
		dofus.managers.AdminManager._sSelf = this;
	}
	static function getInstance()
	{
		return dofus.managers.AdminManager._sSelf;
	}
	function __get__isExecutingBatch()
	{
		return this._bExecutingBatch != undefined && this._bExecutingBatch;
	}
	function initialize(oAPI)
	{
		super.initialize(oAPI);
		this._nUICounter = 0;
		this.loadXMLs();
	}
	function refreshVisually()
	{
		var var2 = !this._bRightClick?this.xml:this.xmlRightClick;
		var var3 = var2.firstChild.firstChild;
		this.createAndShowPopupMenuWithSearch(var3,this._bRightClick);
	}
	function updateSearch(var2, var3)
	{
		var var4 = this.api.ui.currentPopupMenu;
		if(var4.removed == undefined || (var4.removed || !var4.adminPopupMenu))
		{
			return false;
		}
		if(var2 <= 0)
		{
			switch(var3)
			{
				case 38:
					var4.selectPreviousItem();
					break;
				case 40:
					var4.selectNextItem();
			}
			return true;
		}
		if((var0 = var2) !== 8)
		{
			switch(null)
			{
				case 127:
				case 27:
					if(this._sCurrentSearch.length == 0)
					{
						var4.removePopupMenu();
						return true;
					}
					this._sCurrentSearch = "";
					if(this._nSearchRefreshTimeout != undefined)
					{
						_global.clearTimeout(this._nSearchRefreshTimeout);
					}
					this._nSearchRefreshTimeout = _global.setTimeout(this,"refreshVisually",dofus.managers.AdminManager.DELAYED_REFRESH_DURATION);
					return true;
				case 13:
					if(!var4.executeSelectedItem())
					{
						var4.selectFirstEnabled();
					}
					return true;
				default:
					var var5 = String.fromCharCode(var2);
					this._sCurrentSearch = this._sCurrentSearch + var5;
					if(this._nSearchRefreshTimeout != undefined)
					{
						_global.clearTimeout(this._nSearchRefreshTimeout);
					}
					this._nSearchRefreshTimeout = _global.setTimeout(this,"refreshVisually",dofus.managers.AdminManager.DELAYED_REFRESH_DURATION);
					return true;
			}
		}
		else
		{
			if(this._sCurrentSearch.length > 0)
			{
				this._sCurrentSearch = this._sCurrentSearch.substring(0,this._sCurrentSearch.length - 1);
			}
			if(this._nSearchRefreshTimeout != undefined)
			{
				_global.clearTimeout(this._nSearchRefreshTimeout);
			}
			this._nSearchRefreshTimeout = _global.setTimeout(this,"refreshVisually",dofus.managers.AdminManager.DELAYED_REFRESH_DURATION);
			return true;
		}
	}
	function loadXMLs(var2)
	{
		this.loadXml(var2);
		this.loadRightClickXml(false);
	}
	function loadXml(bShow)
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
				var var3 = this.parent.getAdminPopupMenu(undefined,false);
				var3.show(_root._xmouse,_root._ymouse,true);
			}
		};
		var2.ignoreWhite = true;
		var2.load(dofus.Constants.XML_ADMIN_MENU_PATH);
	}
	function loadRightClickXml(bShow)
	{
		var var2 = new XML();
		var2.parent = this;
		var2.onLoad = function(var2)
		{
			if(var2)
			{
				this.parent.xmlRightClick = this;
			}
			else
			{
				this.parent.xmlRightClick = undefined;
			}
			if(bShow)
			{
				var var3 = this.parent.getAdminPopupMenu(undefined,true);
				var3.show(_root._xmouse,_root._ymouse,true);
			}
		};
		var2.ignoreWhite = true;
		var2.load(dofus.Constants.XML_ADMIN_RIGHT_CLICK_MENU_PATH);
	}
	function getAdminPopupMenu(var2, var3)
	{
		this._bRightClick = var3;
		Selection.setFocus(null);
		var var4 = this.api.datacenter.Sprites.getItems();
		var var5 = false;
		for(var a in var4)
		{
			var var6 = var4[a];
			if(var6.name.toUpperCase() == this.api.datacenter.Player.Name.toUpperCase())
			{
				this.myPlayerObject = var6;
			}
			if(var6.name.toUpperCase() == var2.toUpperCase())
			{
				this.playerObject = var6;
				var5 = true;
				break;
			}
		}
		if(!var5)
		{
			this.playerObject = null;
		}
		if(var2 != undefined)
		{
			this.playerName = var2;
		}
		var var7 = !var3?this.xml:this.xmlRightClick;
		if(var7 != undefined)
		{
			var var8 = this.createPopupMenu(var7.firstChild.firstChild,var3);
		}
		else
		{
			var8 = this.api.ui.createPopupMenu();
			var8.addStaticItem("XML not found");
			var8.addItem("Reload XML",this,!var3?this.loadXml:this.loadRightClickXml,[true]);
		}
		return var8;
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
	function createPopupMenuWithSearch(var2, var3)
	{
		if(this._sCurrentSearch == undefined || this._sCurrentSearch.length == 0)
		{
			return this.createPopupMenu(var2,var3);
		}
		var var4 = this.api.ui.createPopupMenu(undefined,true);
		this.generateHourAndDate();
		var4.addStaticItem("Search : " + this._sCurrentSearch);
		if(this._sCurrentSearch.length < 2)
		{
			return var4;
		}
		var sSearch = this._sCurrentSearch.toLowerCase();
		var var5 = function(var2)
		{
			var var3 = var2 != undefined && var2.removeAccents().toLowerCase().indexOf(sSearch) != -1;
			return var3;
		};
		var var6 = new Array();
		var var7 = new Array();
		var var8 = 0;
		while(var2 != null && var2 != undefined)
		{
			var var9 = true;
			loop4:
			switch(var2.attributes.type)
			{
				case "menu":
					if(var5.call(this,var2.attributes.label))
					{
						var var10 = this.replace(var2.attributes.label);
						var6.push([var10 + " >>",this,this.createAndShowPopupMenu,[var2.firstChild,var3]]);
					}
					break;
				case "menuDebug":
					if(dofus.Constants.DEBUG)
					{
						if(var5.call(this,var2.attributes.label))
						{
							var var11 = this.replace(var2.attributes.label);
							var6.push([var11 + " >>",this,this.createAndShowPopupMenu,[var2.firstChild,var3]]);
						}
					}
					break;
				default:
					switch(null)
					{
						case "loadXML":
							if(var5.call(this,var2.attributes.label))
							{
								var var12 = this.replace(var2.attributes.label);
								var7.push([var12,this,!var3?this.loadXml:this.loadRightClickXml,[true]]);
							}
							break loop4;
						case "startup":
						case "prestartup":
							var9 = false;
							break loop4;
						default:
							switch(null)
							{
								case "prepareCommand":
								case "sendChat":
								case "prepareChat":
								case "copyCommand":
							}
							break loop4;
						case "batch":
						case "sendCommand":
							var9 = false;
							if(var5.call(this,var2.attributes.label))
							{
								var var13 = this.replace(var2.attributes.label);
								var7.push([var13,this,this.executeFirst,[var2]]);
								break loop4;
							}
					}
			}
			if(var9 && var2.childNodes.length > 0)
			{
				var8 = var8 + 1;
				var2 = var2.firstChild;
			}
			else
			{
				var var14 = var2.nextSibling;
				if(var14 == undefined || var14 == null)
				{
					while(var8 > 0)
					{
						var8 = var8 - 1;
						var2 = var2.parentNode;
						var var15 = var2.nextSibling;
						if(var15 != undefined && var15 != null)
						{
							var14 = var15;
							break;
						}
						if(var8 == 0)
						{
							var14 = undefined;
						}
					}
				}
				var2 = var14;
			}
		}
		var var16 = 0;
		while(var16 < var6.length)
		{
			var4.addItem.apply(var4,var6[var16]);
			var16 = var16 + 1;
		}
		var var17 = 0;
		while(var17 < var7.length)
		{
			var4.addItem.apply(var4,var7[var17]);
			var17 = var17 + 1;
		}
		return var4;
	}
	function createPopupMenu(var2, var3)
	{
		this._sCurrentSearch = "";
		var var4 = this.api.ui.createPopupMenu(undefined,true);
		this.generateHourAndDate();
		while(var2 != null && var2 != undefined)
		{
			var var5 = this.replace(var2.attributes.label);
			loop1:
			switch(var2.attributes.type)
			{
				case "static":
					var4.addStaticItem(var5);
					break;
				case "menu":
					var4.addItem(var5 + " >>",this,this.createAndShowPopupMenu,[var2.firstChild,var3]);
					break;
				case "menuDebug":
					if(dofus.Constants.DEBUG)
					{
						var4.addItem(var5 + " >>",this,this.createAndShowPopupMenu,[var2.firstChild,var3]);
					}
					break;
				case "loadXML":
					var4.addItem(var5,this,!var3?this.loadXml:this.loadRightClickXml,[true]);
					break;
				default:
					switch(null)
					{
						case "startup":
							break loop1;
						case "prestartup":
							break loop1;
						default:
							var4.addItem(var5,this,this.executeFirst,[var2]);
					}
			}
			var2 = var2.nextSibling;
		}
		return var4;
	}
	function createAndShowPopupMenu(var2, var3)
	{
		var var4 = this.api.ui.currentPopupMenu;
		var var5 = var4.x;
		var var6 = var4.y;
		var var7 = this.createPopupMenu(var2,var3);
		if(var5 != undefined && var6 != undefined)
		{
			var7.show(var5,var6,true);
		}
		else
		{
			var7.show(_root._xmouse,_root._ymouse,true);
		}
	}
	function createAndShowPopupMenuWithSearch(var2, var3)
	{
		var var4 = this.api.ui.currentPopupMenu;
		var var5 = var4.x;
		var var6 = var4.y;
		var var7 = this.createPopupMenuWithSearch(var2,var3);
		if(var5 != undefined && var6 != undefined)
		{
			var7.show(var5,var6,true);
		}
		else
		{
			var7.show(_root._xmouse,_root._ymouse,true);
		}
	}
	function initStartup(var2)
	{
		var var3 = var2;
		while(var2 != null && var2 != undefined)
		{
			if(var2.attributes.type == "startup")
			{
				this._startupNode = var2;
				break;
			}
			var2 = var2.nextSibling;
		}
		var2 = var3;
		while(var2 != null && var2 != undefined)
		{
			if(var2.attributes.type == "prestartup")
			{
				this._preStartupNode = var2;
				break;
			}
			var2 = var2.nextSibling;
		}
	}
	function executeFirst(var2)
	{
		this.removeInterval();
		this._sSaveNode = var2.cloneNode(true);
		this.execute(this._sSaveNode,false);
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
				case "copyCommand":
					this.copyCommand(var3);
					break;
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
								case "summoner":
									this.itemSummoner();
							}
					}
			}
			var2.attributes.check = true;
		}
		return true;
	}
	function batch(var2)
	{
		var var3 = false;
		this._bExecutingBatch = true;
		while(var2 != null && var2 != undefined)
		{
			var var4 = this.execute(var2);
			if(var4 == false)
			{
				return false;
			}
			if(var2.attributes.type == "sendCommand")
			{
				var var5 = var2.attributes.command;
				if(var5.indexOf("/makereport") == 0)
				{
					var3 = true;
				}
			}
			var var6 = var2.nextSibling;
			var var7 = Number(var2.attributes.delay);
			if(!_global.isNaN(var7) && var2.attributes.delayCheck != true)
			{
				ank.utils.Timer.setTimer(this,"batch",this,this.onCommandDelay,var7);
				return false;
			}
			var var8 = var2.parentNode;
			if(var8.attributes.repeatCheck == undefined)
			{
				var8.attributes.repeatCheck = 1;
			}
			var var9 = var8.attributes.repeat;
			if(var6 == undefined && (!_global.isNaN(var9) && var8.attributes.repeatCheck < var9))
			{
				var var10 = 0;
				while(var10 < var8.childNodes.length)
				{
					var8.childNodes[var10].attributes.check = false;
					var8.childNodes[var10].attributes.delayCheck = false;
					var10 = var10 + 1;
				}
				var8.attributes.repeatCheck++;
				var6 = var8.childNodes[0];
			}
			var2 = var6;
		}
		this._bExecutingBatch = false;
		if(var3)
		{
			var var11 = this.api.datacenter.Temporary.Report;
			if(var11 != undefined)
			{
				this.api.network.Basics.askReportInfos(2,var11.currentTargetPseudos,var11.currentTargetIsAllAccounts);
			}
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
	function copyCommand(var2)
	{
		System.setClipboard(var2);
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
	function characterSelected()
	{
		if(this._preStartupNode == null || this._preStartupNode == undefined)
		{
			return undefined;
		}
		this.playerObject = this.api.datacenter.Player;
		this.playerName = (dofus.datacenter.LocalPlayer)this.playerObject.Name;
		this.batch(this._preStartupNode.firstChild);
	}
	function characterEnteringGame()
	{
		if(this._startupNode == null || this._startupNode == undefined)
		{
			return undefined;
		}
		this.playerObject = this.api.datacenter.Player;
		this.playerName = (dofus.datacenter.LocalPlayer)this.playerObject.Name;
		this.batch(this._startupNode.firstChild);
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
