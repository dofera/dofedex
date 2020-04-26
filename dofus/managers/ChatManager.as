class dofus.managers.ChatManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	static var TYPE_INFOS = 0;
	static var TYPE_ERRORS = 1;
	static var TYPE_MESSAGES = 2;
	static var TYPE_WISP = 3;
	static var TYPE_GUILD = 4;
	static var TYPE_PVP = 5;
	static var TYPE_RECRUITMENT = 6;
	static var TYPE_TRADE = 7;
	static var TYPE_MEETIC = 8;
	static var TYPE_ADMIN = 9;
	static var MAX_ALL_LENGTH = 150;
	static var MAX_INFOS_LENGTH = 50;
	static var MAX_VISIBLE = 30;
	static var EMPTY_ZONE_LENGTH = 31;
	static var STOP_SCROLL_LENGTH = 6;
	static var MAX_ITEM_BUFFER_LENGTH = 75;
	static var MAX_POS_REPLACE = 6;
	static var ADMIN_BUFFER_MULTIPLICATOR = 5;
	static var HTML_NB_PASS_MAX = 50;
	var _aVisibleTypes = [true,true,true,true,true,true,true,true,true,true];
	var _nItemsBufferIDs = 0;
	var _bFirstErrorCatched = false;
	var _bUseInWordCensor = false;
	static var CENSORSHIP_CHAR = ["%","&","§","@","?"];
	static var PONCTUATION = [".","!","?","~"];
	static var LINK_FILTERS = ["WWW","HTTP","@",".COM",".FR",".INFO","HOTMAIL","MSN","GMAIL","FTP"];
	static var WHITE_LIST = [".DOFUS.COM",".ANKAMA-GAMES.COM",".GOOGLE.COM",".DOFUS.FR",".DOFUS.DE",".DOFUS.ES",".DOFUS.CO.UK",".WAKFU.COM",".ANKAMA-SHOP.COM",".ANKAMA.COM",".ANKAMA-EDITIONS.COM",".ANKAMA-WEB.COM",".ANKAMA-EVENTS.COM",".DOFUS-ARENA.COM",".MUTAFUKAZ.COM",".MANGA-DOFUS.COM",".LABANDEPASSANTE.FR","@_@",".ANKAMA-PLAY.COM"];
	function ChatManager(loc3)
	{
		super();
		dofus.managers.ChatManager._sSelf = this;
		this.initialize(loc3);
	}
	static function getInstance()
	{
		return dofus.managers.ChatManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		this._aItemsBuffer = new Array();
		this._aMessagesBuffer = new Array();
		this._nItemsBufferIDs = 0;
		this._aBlacklist = new Array();
		this.updateRigth();
		this.clear();
	}
	function updateRigth()
	{
		if(this.api.datacenter.Player.isAuthorized)
		{
			dofus.managers.ChatManager.MAX_VISIBLE = dofus.managers.ChatManager.MAX_VISIBLE * dofus.managers.ChatManager.ADMIN_BUFFER_MULTIPLICATOR;
			dofus.managers.ChatManager.MAX_ALL_LENGTH = dofus.managers.ChatManager.MAX_ALL_LENGTH * dofus.managers.ChatManager.ADMIN_BUFFER_MULTIPLICATOR;
			dofus.managers.ChatManager.MAX_ITEM_BUFFER_LENGTH = dofus.managers.ChatManager.MAX_ITEM_BUFFER_LENGTH * dofus.managers.ChatManager.ADMIN_BUFFER_MULTIPLICATOR;
		}
	}
	function clear()
	{
		this._aMessages = new Array();
		this._nMessageCounterInfo = 0;
	}
	function setTypes(loc2)
	{
		this._aVisibleTypes = loc2;
		this.refresh(true);
	}
	function isTypeVisible(loc2)
	{
		return this._aVisibleTypes[loc2];
	}
	function setTypeVisible(loc2, loc3)
	{
		this._aVisibleTypes[loc2] = loc3;
		this.refresh(true);
	}
	function initCensorDictionnary()
	{
		if(this._oCensorDictionnary == undefined)
		{
			this._oCensorDictionnary = new Object();
			var loc2 = this.api.lang.getCensoredWords();
			for(var j in loc2)
			{
				this._oCensorDictionnary[String(loc2[j].c).toUpperCase()] = {weight:Number(loc2[j].l),id:Number(j),parseWord:loc2[j].d};
				if(loc2[j].d)
				{
					this._bUseInWordCensor = true;
				}
			}
		}
	}
	function applyOutputCensorship(loc2)
	{
		if(this.api.datacenter.Player.isAuthorized)
		{
			return true;
		}
		if(!this.api.lang.getConfigText("CENSORSHIP_ENABLE_OUTPUT"))
		{
			return true;
		}
		this.initCensorDictionnary();
		var loc3 = -1;
		var loc4 = 0;
		var loc5 = -1;
		var loc6 = this.avoidPonctuation(loc2.toUpperCase()).split(" ");
		§§enumerate(loc6);
		while((var loc0 = §§enumeration()) != null)
		{
			if(this._oCensorDictionnary[loc6[i]] != undefined)
			{
				if(Number(this._oCensorDictionnary[loc6[i]].weight) > loc3)
				{
					loc3 = Number(this._oCensorDictionnary[loc6[i]].weight);
					loc4 = Number(this._oCensorDictionnary[loc6[i]].id);
				}
			}
			else if(this._bUseInWordCensor)
			{
				for(var loc5 in this._oCensorDictionnary)
				{
					if(loc5 != -1 && this._oCensorDictionnary[j].parseWord)
					{
						if(Number(this._oCensorDictionnary[j].weight) > loc3)
						{
							loc3 = Number(this._oCensorDictionnary[j].weight);
							loc4 = Number(this._oCensorDictionnary[j].id);
						}
					}
				}
			}
		}
		if(loc3 >= this.api.lang.getConfigText("SEND_CENSORSHIP_SINCE"))
		{
			this.api.network.Basics.sanctionMe(loc3,loc4);
		}
		if(loc3 > 0)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PLEASE_RESTRAIN_TO_A_POLITE_VOCABULARY"),"ERROR_CHAT");
			return false;
		}
		return true;
	}
	function applyInputCensorship(loc2)
	{
		if(!this.api.kernel.OptionsManager.getOption("CensorshipFilter") || !this.api.lang.getConfigText("CENSORSHIP_ENABLE_INPUT"))
		{
			return loc2;
		}
		this.initCensorDictionnary();
		var loc3 = new Array();
		var loc4 = loc2.split(" ");
		var loc5 = this.avoidPonctuation(loc2.toUpperCase()).split(" ");
		var loc6 = -1;
		for(var loc6 in loc5)
		{
			if(this._oCensorDictionnary[loc5[i]] != undefined)
			{
				loc3.push(this.getCensoredWord(loc5[i]));
				loc6 = 0;
			}
			else if(this._bUseInWordCensor)
			{
				for(var loc6 in this._oCensorDictionnary)
				{
					if(loc6 != -1 && this._oCensorDictionnary[j].parseWord)
					{
						loc3.push(this.getCensoredWord(loc5[i]));
						loc3.push(loc3.push(loc4[i]));
						loc6 = 0;
						§§enumerate(this._oCensorDictionnary);
						loc6 = -1;
						§§enumerate(loc5);
						loc6 = -1;
						loc3.push(this.getCensoredWord(loc5[i]));
						§§push(loc6 != -1);
						§§push(!this._bUseInWordCensor);
						§§push(var loc0 = §§enumeration());
						§§push((var loc0 = §§enumeration()) == null);
						§§push(!this._oCensorDictionnary.parseWord);
						break;
					}
					loc6 = -1;
				}
			}
			if(loc6 == -1)
			{
				loc3.push(loc4[i]);
			}
		}
		loc3.reverse();
		return loc3.join(" ");
	}
	function avoidPonctuation(loc2)
	{
		var loc3 = new String();
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			var loc5 = loc2.charCodeAt(loc4);
			if(loc5 > 47 && loc5 < 58 || (loc5 > 64 && loc5 < 91 || loc5 == 32))
			{
				loc3 = loc3 + loc2.charAt(loc4);
			}
			loc4 = loc4 + 1;
		}
		return loc3;
	}
	function getCensoredWord(loc2)
	{
		var loc3 = new String();
		var loc4 = new String();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = loc2.charCodeAt(loc5);
			if(loc6 > 47 && loc6 < 58 || (loc6 > 64 && loc6 < 91 || loc6 > 96 && loc6 < 123))
			{
				var loc7 = new String();
				while(true)
				{
					loc7 = dofus.managers.ChatManager.CENSORSHIP_CHAR[Math.floor(Math.random() * dofus.managers.ChatManager.CENSORSHIP_CHAR.length)];
					if(loc7 == loc4)
					{
						continue;
					}
					break;
				}
				loc3 = loc3 + (loc4 = loc7);
			}
			else
			{
				loc3 = loc3 + (loc4 = loc2.charAt(loc5));
			}
			loc5 = loc5 + 1;
		}
		return loc3;
	}
	function addLinkWarning(loc2)
	{
		var loc3 = loc2.toUpperCase();
		if(loc3.indexOf("</A>") > -1)
		{
			loc3 = loc3.substr(loc3.indexOf("</A>"));
		}
		var loc4 = loc3.split(" ");
		var loc5 = false;
		var loc6 = 0;
		while(loc6 < loc4.length)
		{
			var loc7 = false;
			var loc8 = 0;
			while(loc8 < dofus.managers.ChatManager.LINK_FILTERS.length)
			{
				if(loc4[loc6].indexOf(dofus.managers.ChatManager.LINK_FILTERS[loc8]) > -1)
				{
					loc7 = true;
					break;
				}
				loc8 = loc8 + 1;
			}
			if(loc7)
			{
				var loc9 = 0;
				while(loc9 < dofus.managers.ChatManager.WHITE_LIST.length)
				{
					if(loc4[loc6].indexOf(dofus.managers.ChatManager.WHITE_LIST[loc9]) > -1)
					{
						loc7 = false;
						break;
					}
					loc9 = loc9 + 1;
				}
			}
			if(loc7)
			{
				loc5 = true;
				break;
			}
			loc6 = loc6 + 1;
		}
		if(loc5)
		{
			loc2 = loc2 + (" [<font color=\"#006699\"><u><b><a href=\'asfunction:onHref,ShowLinkWarning,CHAT_LINK_WARNING_TEXT\'>" + this.api.lang.getText("CHAT_LINK_WARNING") + "</a></b></u></font>]");
		}
		return loc2;
	}
	function addText(loc2, loc3, loc4, loc5)
	{
		if(loc4 == undefined)
		{
			loc4 = true;
		}
		var loc6 = "";
		var loc9 = false;
		if((var loc0 = loc3) !== dofus.Constants.MSG_CHAT_COLOR)
		{
			loop0:
			switch(null)
			{
				case dofus.Constants.EMOTE_CHAT_COLOR:
					var loc7 = dofus.managers.ChatManager.TYPE_MESSAGES;
					loc9 = true;
					var loc8 = true;
					break;
				case dofus.Constants.THINK_CHAT_COLOR:
					loc7 = dofus.managers.ChatManager.TYPE_MESSAGES;
					loc9 = true;
					loc8 = true;
					break;
				default:
					switch(null)
					{
						case dofus.Constants.GROUP_CHAT_COLOR:
						case dofus.Constants.MSGCHUCHOTE_CHAT_COLOR:
							loc7 = dofus.managers.ChatManager.TYPE_WISP;
							loc9 = true;
							loc8 = true;
							if(loc4)
							{
								this.api.sounds.events.onChatWisper();
							}
							break loop0;
						default:
							if(loc0 !== dofus.Constants.INFO_CHAT_COLOR)
							{
								switch(null)
								{
									case dofus.Constants.ERROR_CHAT_COLOR:
										loc7 = dofus.managers.ChatManager.TYPE_ERRORS;
										loc8 = true;
										if(loc4)
										{
											if(this._bFirstErrorCatched)
											{
												this.api.sounds.events.onError();
											}
											else
											{
												this._bFirstErrorCatched = true;
											}
										}
										break loop0;
									case dofus.Constants.GUILD_CHAT_COLOR:
										loc7 = dofus.managers.ChatManager.TYPE_GUILD;
										loc9 = true;
										loc8 = true;
										if(loc4 && this.api.kernel.OptionsManager.getOption("GuildMessageSound"))
										{
											this.api.sounds.events.onChatWisper();
										}
										break loop0;
									default:
										if(loc0 !== dofus.Constants.PVP_CHAT_COLOR)
										{
											switch(null)
											{
												case dofus.Constants.TRADE_CHAT_COLOR:
													loc7 = dofus.managers.ChatManager.TYPE_TRADE;
													loc9 = true;
													loc8 = true;
													break loop0;
												case dofus.Constants.RECRUITMENT_CHAT_COLOR:
													loc7 = dofus.managers.ChatManager.TYPE_RECRUITMENT;
													loc9 = true;
													loc8 = true;
													break loop0;
												default:
													switch(null)
													{
														case dofus.Constants.MEETIC_CHAT_COLOR:
															loc7 = dofus.managers.ChatManager.TYPE_MEETIC;
															loc9 = true;
															loc8 = true;
															break loop0;
														case dofus.Constants.ADMIN_CHAT_COLOR:
															loc7 = dofus.managers.ChatManager.TYPE_ADMIN;
															loc8 = true;
															break loop0;
														default:
															ank.utils.Logger.err("[Chat] Erreur : mauvaise couleur " + loc2);
															return undefined;
													}
											}
										}
										else
										{
											loc7 = dofus.managers.ChatManager.TYPE_PVP;
											loc9 = true;
											loc8 = true;
											break loop0;
										}
								}
							}
							else
							{
								loc7 = dofus.managers.ChatManager.TYPE_INFOS;
								this._nMessageCounterInfo++;
								loc8 = false;
								break loop0;
							}
					}
			}
		}
		else
		{
			loc7 = dofus.managers.ChatManager.TYPE_MESSAGES;
			loc9 = true;
			loc8 = true;
		}
		if(loc9)
		{
			loc2 = this.addLinkWarning(loc2);
			loc2 = this.applyInputCensorship(loc2);
		}
		if(loc8 && this.api.kernel.NightManager.time.length)
		{
			loc6 = "[" + this.api.kernel.NightManager.time + "] ";
		}
		this._aMessages.push({textStyleLeft:"<font color=\"#" + loc3 + "\"><br />",text:loc2,textStyleRight:"</font>",type:loc7,uniqId:loc5,timestamp:loc6,lf:false});
		if(this._aMessages.length > dofus.managers.ChatManager.MAX_ALL_LENGTH)
		{
			this._aMessages.shift();
		}
		this.refresh();
	}
	function refresh(loc2)
	{
		var loc3 = this._aMessages.length;
		var loc4 = new String();
		var loc5 = 0;
		if(loc3 == 0 && !loc2)
		{
			return undefined;
		}
		var loc6 = loc3 - 1;
		while(loc5 < dofus.managers.ChatManager.MAX_VISIBLE && loc6 >= 0)
		{
			var loc7 = this._aMessages[loc6];
			if(this._aVisibleTypes[loc7.type] == true)
			{
				loc5 = loc5 + 1;
				if(!loc7.htmlSyntaxChecked)
				{
					var loc8 = dofus.managers.ChatManager.safeHtml(loc7.text);
					loc7.lf = !loc8.v || loc7.lf;
					loc7.text = loc8.t;
					loc7.htmlSyntaxChecked = true;
				}
				if(this.api.kernel.OptionsManager.getOption("TimestampInChat"))
				{
					loc4 = (!loc7.lf?"":"<br/>") + loc7.textStyleLeft + loc7.timestamp + loc7.text + loc7.textStyleRight + loc4;
				}
				else
				{
					loc4 = (!loc7.lf?"":"<br/>") + loc7.textStyleLeft + loc7.text + loc7.textStyleRight + loc4;
				}
			}
			loc6 = loc6 - 1;
		}
		this.api.ui.getUIComponent("Banner").setChatText(loc4);
	}
	static function safeHtml(loc2)
	{
		var loc3 = true;
		var loc4 = new Array();
		var loc5 = new Array();
		var loc6 = loc2;
		var loc7 = 0;
		var loc8 = 0;
		while(loc6.indexOf("<") > -1 && loc7++ < dofus.managers.ChatManager.HTML_NB_PASS_MAX)
		{
			var loc9 = loc6.indexOf("<");
			var loc10 = loc6.indexOf(">",loc9) + 1;
			var loc11 = loc6.substring(loc9,loc10);
			var loc12 = loc11.indexOf("/") == 1;
			var loc13 = loc11.indexOf("/") == loc11.length - 2;
			var loc14 = !loc12?loc11.substring(1,loc11.length - 1):loc11.substring(2,loc11.length - 1);
			loc14 = loc14.substring(0,loc14.indexOf(" ") <= -1?loc14.length:loc14.indexOf(" "));
			loc5[loc8] = {c:loc12,b:loc14};
			if(loc13)
			{
				loc5[loc8 = loc8 + 1] = {c:!loc12,b:loc14};
			}
			loc6 = loc6.substring(loc10);
			loc8 = loc8 + 1;
		}
		var loc15 = 0;
		while(loc15 < loc5.length)
		{
			var loc16 = loc5[loc15];
			if(loc16.c)
			{
				if(loc4[loc16.b] == undefined || loc4[loc16.b] == 0)
				{
					loc3 = false;
				}
				else
				{
					loc4[loc16.b] = loc4[loc16.b] - 1;
				}
			}
			else
			{
				if(loc4[loc16.b] == undefined)
				{
					loc4[loc16.b] = 0;
				}
				loc4[loc16.b] = loc4[loc16.b] + 1;
			}
			loc15 = loc15 + 1;
		}
		§§enumerate(loc4);
		while((var loc0 = §§enumeration()) != null)
		{
			if(loc4[i] > 0)
			{
				loc3 = false;
			}
		}
		if(loc3)
		{
			return {v:true,t:loc2};
		}
		return {v:false,t:loc2.split("<").join("&lt;").split(">").join("&gt;")};
	}
	function parseInlineItems(loc2, loc3)
	{
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = Number(loc3[loc4]);
			var loc6 = loc3[loc4 + 1];
			var loc7 = new dofus.datacenter.(0,loc5,1,1,loc6,1);
			var loc8 = "°" + loc4 / 2;
			var loc9 = this.getLinkItem(loc7);
			var loc10 = loc2.indexOf(loc8);
			if(loc10 != -1)
			{
				var loc11 = loc2.split("");
				loc11.splice(loc10,loc8.length,loc9);
				loc2 = loc11.join("");
			}
			loc4 = loc4 + 2;
		}
		return loc2;
	}
	function parseInlinePos(loc2)
	{
		var loc3 = loc2;
		var loc4 = 0;
		var loc6 = 0;
		var loc7 = 0;
		while(loc3.indexOf("[") > -1 && (loc4++ < dofus.managers.ChatManager.HTML_NB_PASS_MAX && loc6 < dofus.managers.ChatManager.MAX_POS_REPLACE))
		{
			var loc8 = loc3.indexOf("[");
			var loc9 = loc3.indexOf("]",loc8) + 1;
			if(loc9 > 0)
			{
				var loc10 = loc3.substring(loc8 + 1,loc9 - 1).indexOf(", ") != -1?", ":",";
				var loc11 = loc3.substring(loc8 + 1,loc9 - 1).split(loc10);
				if(loc11.length == 2)
				{
					if(!_global.isNaN(loc11[0]) && !_global.isNaN(new ank.utils.(loc11[0]).trim().toString()))
					{
						var loc12 = _global.parseInt(loc11[0]);
						var loc13 = _global.parseInt(loc11[1]);
						if(Math.abs(loc12) < 150 && Math.abs(loc13) < 150)
						{
							var loc5 = loc2.split(loc3.substring(loc8,loc9));
							loc6 = loc6 + loc5.length;
							if(loc6 > dofus.managers.ChatManager.MAX_POS_REPLACE)
							{
								break;
							}
							loc2 = loc5.join(this.getLinkCoord(loc12,loc13));
						}
					}
				}
				loc3 = loc3.substring(loc9);
				loc7 = loc7 + 1;
				continue;
			}
			break;
		}
		return loc2;
	}
	function parseSecretsEmotes(loc2)
	{
		if(!this.api.lang.getConfigText("CHAT_USE_SECRETS_EMOTES"))
		{
			return loc2;
		}
		if(loc2.indexOf("[love]") != -1)
		{
			loc2 = loc2.split("[love]").join("");
			if(!this.api.datacenter.Game.isFight)
			{
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + ",2914,11,8,1");
			}
		}
		if(loc2.indexOf("[rock]") != -1)
		{
			loc2 = loc2.split("[rock]").join("");
			if(!this.api.datacenter.Game.isFight)
			{
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + ",2069,10,1,1");
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + (this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + 1) + ",2904,11,8,3");
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + (this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum - 1) + ",2904,11,8,3");
				this.api.network.Chat.onSmiley(this.api.datacenter.Player.ID + "|1");
				this.api.kernel.AudioManager.playSound("SPEAK_TRIGGER_LEVEL_UP");
				this.api.network.Chat.onMessage(true,this.api.datacenter.Player.ID + "|" + this.api.datacenter.Player.Name + "|" + loc2);
			}
			loc2 = "";
		}
		return loc2;
	}
	function getLinkName(loc2, loc3)
	{
		if(loc3 != undefined && (loc3.length > 0 && loc3 != ""))
		{
			return "<b><a href=\'asfunction:onHref,ShowPlayerPopupMenu," + loc2 + "," + loc3 + "\'>" + loc2 + "</a></b>";
		}
		return "<b><a href=\'asfunction:onHref,ShowPlayerPopupMenu," + loc2 + "\'>" + loc2 + "</a></b>";
	}
	function getLinkCoord(loc2, loc3)
	{
		return "<b><a href=\'asfunction:onHref,updateCompass," + loc2 + "," + loc3 + "\'>[" + loc2 + "," + loc3 + "]</a></b>";
	}
	function getLinkItem(loc2)
	{
		var loc3 = this.addItemToBuffer(loc2);
		return "<b>[<a href=\'asfunction:onHref,ShowItemViewer," + String(loc3) + "\'>" + loc2.name + "</a>]</b>";
	}
	function addItemToBuffer(loc2)
	{
		if(this._nItemsBufferIDs == undefined || _global.isNaN(this._nItemsBufferIDs))
		{
			this._nItemsBufferIDs = 0;
		}
		this._nItemsBufferIDs++;
		if(this._aItemsBuffer == undefined)
		{
			this._aItemsBuffer = new Array();
		}
		if(this._aItemsBuffer.length > dofus.managers.ChatManager.MAX_ITEM_BUFFER_LENGTH)
		{
			this._aItemsBuffer.shift();
		}
		this._aItemsBuffer.push({id:this._nItemsBufferIDs,data:loc2});
		return this._nItemsBufferIDs;
	}
	function getItemFromBuffer(loc2)
	{
		var loc3 = this._aItemsBuffer.length;
		while(loc3 >= 0)
		{
			if(this._aItemsBuffer[loc3].id == loc2)
			{
				return this._aItemsBuffer[loc3].data;
			}
			loc3 = loc3 - 1;
		}
		return undefined;
	}
	static function isPonctuation(loc2)
	{
		var loc3 = 0;
		while(loc3 < dofus.managers.ChatManager.PONCTUATION.length)
		{
			if(dofus.managers.ChatManager.PONCTUATION[loc3] == loc2)
			{
				return true;
			}
			loc3 = loc3 + 1;
		}
		return false;
	}
	function addToBlacklist(loc2, loc3)
	{
		if(loc2 != this.api.datacenter.Player.Name && !this.isBlacklisted(loc2))
		{
			this._aBlacklist.push({sName:loc2,nClass:loc3});
		}
	}
	function removeToBlacklist(loc2)
	{
		for(var i in this._aBlacklist)
		{
			if(loc2 == this._aBlacklist[i].sName || loc2 == "*" + this._aBlacklist[i].sName)
			{
				this._aBlacklist[i] = undefined;
				this.api.ui.getUIComponent("Friends").updateIgnoreList();
				this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_NOMORE_BLACKLISTED",[loc2]),"INFO_CHAT");
				return undefined;
			}
		}
	}
	function getBlacklist()
	{
		return this._aBlacklist;
	}
	function isBlacklisted(loc2)
	{
		§§enumerate(this._aBlacklist);
		while((var loc0 = §§enumeration()) != null)
		{
			if(loc2.toLowerCase() == this._aBlacklist[i].sName.toLowerCase())
			{
				return true;
			}
		}
		return false;
	}
	function getMessageFromId(loc2)
	{
		for(var i in this._aMessages)
		{
			if(this._aMessages[i].uniqId == loc2)
			{
				return this._aMessages[i].text;
			}
		}
		return undefined;
	}
}
