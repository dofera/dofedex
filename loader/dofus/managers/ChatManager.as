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
	static var MAX_RAW_MESSAGES_LENGTH = 1000;
	static var MAX_INFOS_LENGTH = 50;
	static var MAX_VISIBLE = 30;
	static var EMPTY_ZONE_LENGTH = 31;
	static var STOP_SCROLL_LENGTH = 6;
	static var MAX_ITEM_BUFFER_LENGTH = 75;
	static var MAX_POS_REPLACE = 6;
	static var ADMIN_BUFFER_MULTIPLICATOR = 5;
	static var HTML_NB_PASS_MAX = 300;
	var _aVisibleTypes = [true,true,true,true,true,true,true,true,true,true];
	var _nItemsBufferIDs = 0;
	var _bFirstErrorCatched = false;
	var _bUseInWordCensor = false;
	static var CENSORSHIP_CHAR = ["%","&","§","@","?"];
	static var PONCTUATION = [".","!","?","~"];
	static var LINK_FILTERS = ["WWW","HTTP","@",".COM",".FR",".INFO","HOTMAIL","MSN","GMAIL","FTP"];
	static var WHITE_LIST = [".DOFUS.COM",".ANKAMA-GAMES.COM",".GOOGLE.COM",".DOFUS.FR",".DOFUS.DE",".DOFUS.ES",".DOFUS.CO.UK",".WAKFU.COM",".ANKAMA-SHOP.COM",".ANKAMA.COM",".ANKAMA-EDITIONS.COM",".ANKAMA-WEB.COM",".ANKAMA-EVENTS.COM",".DOFUS-ARENA.COM",".MUTAFUKAZ.COM",".MANGA-DOFUS.COM",".LABANDEPASSANTE.FR","@_@",".ANKAMA-PLAY.COM"];
	var _nFileOutput = 0;
	function ChatManager(var2)
	{
		super();
		dofus.managers.ChatManager._sSelf = this;
		this.initialize(var3);
	}
	function __get__fileOutput()
	{
		return this._nFileOutput;
	}
	function __set__fileOutput(var2)
	{
		this._nFileOutput = var2;
		return this.__get__fileOutput();
	}
	static function getInstance()
	{
		return dofus.managers.ChatManager._sSelf;
	}
	function initialize(var2)
	{
		super.initialize(var3);
		this._aItemsBuffer = new Array();
		this._aRawMessages = new Array();
		this._nItemsBufferIDs = 0;
		this._aBlacklist = new Array();
		this.updateRigth();
		this.clear();
	}
	function addRawMessage(var2, var3, var4, var5)
	{
		var var6 = new Object();
		var6.mapId = var2;
		var6.messageType = var3;
		var6.timestamp = var5;
		var6.rawFullMessage = var4;
		if(this._aRawMessages.length > dofus.managers.ChatManager.MAX_RAW_MESSAGES_LENGTH)
		{
			this._aRawMessages.shift();
		}
		this._aRawMessages.push(var6);
	}
	function getJailDialog()
	{
		var var2 = "";
		var var3 = 0;
		while(var3 < this._aRawMessages.length)
		{
			var var4 = this._aRawMessages[var3];
			if(var4.messageType == "MESSAGE_CHAT")
			{
				if(dofus.datacenter.DofusMap.isJail(var4.mapId))
				{
					var2 = var2 + ("\n" + var4.timestamp + " " + var4.rawFullMessage);
				}
			}
			var3 = var3 + 1;
		}
		return var2.length <= 0?var2:var2.substring(1);
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
		this._aRawMessages = new Array();
		this._nMessageCounterInfo = 0;
	}
	function setTypes(var2)
	{
		this._aVisibleTypes = var2;
		this.refresh(true);
	}
	function isTypeVisible(var2)
	{
		return this._aVisibleTypes[var2];
	}
	function setTypeVisible(var2, var3)
	{
		this._aVisibleTypes[var2] = var3;
		this.refresh(true);
	}
	function initCensorDictionnary()
	{
		if(this._oCensorDictionnary == undefined)
		{
			this._oCensorDictionnary = new Object();
			var var2 = this.api.lang.getCensoredWords();
			for(var j in var2)
			{
				this._oCensorDictionnary[String(var2[j].c).toUpperCase()] = {weight:Number(var2[j].l),id:Number(j),parseWord:var2[j].d};
				if(var2[j].d)
				{
					this._bUseInWordCensor = true;
				}
			}
		}
	}
	function applyOutputCensorship(var2)
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
		var var3 = -1;
		var var4 = 0;
		var var5 = -1;
		var var6 = this.avoidPonctuation(var2.toUpperCase()).split(" ");
		for(var i in var6)
		{
			if(this._oCensorDictionnary[var6[i]] != undefined)
			{
				if(Number(this._oCensorDictionnary[var6[i]].weight) > var3)
				{
					var3 = Number(this._oCensorDictionnary[var6[i]].weight);
					var4 = Number(this._oCensorDictionnary[var6[i]].id);
				}
			}
			else if(this._bUseInWordCensor)
			{
				for(var j in this._oCensorDictionnary)
				{
					var5 = var6[i].indexOf(j);
					if(var5 != -1 && this._oCensorDictionnary[j].parseWord)
					{
						if(Number(this._oCensorDictionnary[j].weight) > var3)
						{
							var3 = Number(this._oCensorDictionnary[j].weight);
							var4 = Number(this._oCensorDictionnary[j].id);
						}
					}
				}
			}
		}
		if(var3 >= this.api.lang.getConfigText("SEND_CENSORSHIP_SINCE"))
		{
			this.api.network.Basics.sanctionMe(var3,var4);
		}
		if(var3 > 0)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PLEASE_RESTRAIN_TO_A_POLITE_VOCABULARY"),"ERROR_CHAT");
			return false;
		}
		return true;
	}
	function applyInputCensorship(var2)
	{
		if(!this.api.kernel.OptionsManager.getOption("CensorshipFilter") || !this.api.lang.getConfigText("CENSORSHIP_ENABLE_INPUT"))
		{
			return var2;
		}
		this.initCensorDictionnary();
		var var3 = new Array();
		var var4 = var2.split(" ");
		var var5 = this.avoidPonctuation(var2.toUpperCase()).split(" ");
		var var6 = -1;
		for(var i in var5)
		{
			var6 = -1;
			if(this._oCensorDictionnary[var5[i]] != undefined)
			{
				var3.push(this.getCensoredWord(var5[i]));
				var6 = 0;
			}
			else if(this._bUseInWordCensor)
			{
				for(var j in this._oCensorDictionnary)
				{
					var6 = var5[i].indexOf(j);
					if(var6 != -1 && this._oCensorDictionnary[j].parseWord)
					{
						var3.push(this.getCensoredWord(var5[i]));
						break;
					}
					var6 = -1;
				}
			}
			if(var6 == -1)
			{
				var3.push(var4[i]);
			}
		}
		var3.reverse();
		return var3.join(" ");
	}
	function avoidPonctuation(var2)
	{
		var var3 = new String();
		var var4 = 0;
		while(var4 < var2.length)
		{
			var var5 = var2.charCodeAt(var4);
			if(var5 > 47 && var5 < 58 || (var5 > 64 && var5 < 91 || var5 == 32))
			{
				var3 = var3 + var2.charAt(var4);
			}
			var4 = var4 + 1;
		}
		return var3;
	}
	function getCensoredWord(var2)
	{
		var var3 = new String();
		var var4 = new String();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2.charCodeAt(var5);
			if(var6 > 47 && var6 < 58 || (var6 > 64 && var6 < 91 || var6 > 96 && var6 < 123))
			{
				var var7 = new String();
				while(true)
				{
					var7 = dofus.managers.ChatManager.CENSORSHIP_CHAR[Math.floor(Math.random() * dofus.managers.ChatManager.CENSORSHIP_CHAR.length)];
					if(var7 == var4)
					{
						continue;
					}
					break;
				}
				var3 = var3 + (var4 = var7);
			}
			else
			{
				var3 = var3 + (var4 = var2.charAt(var5));
			}
			var5 = var5 + 1;
		}
		return var3;
	}
	function addLinkWarning(var2)
	{
		var var3 = var2.toUpperCase();
		if(var3.indexOf("</A>") > -1)
		{
			var3 = var3.substr(var3.indexOf("</A>"));
		}
		var var4 = var3.split(" ");
		var var5 = false;
		var var6 = 0;
		while(var6 < var4.length)
		{
			var var7 = false;
			var var8 = 0;
			while(var8 < dofus.managers.ChatManager.LINK_FILTERS.length)
			{
				if(var4[var6].indexOf(dofus.managers.ChatManager.LINK_FILTERS[var8]) > -1)
				{
					var7 = true;
					break;
				}
				var8 = var8 + 1;
			}
			if(var7)
			{
				var var9 = 0;
				while(var9 < dofus.managers.ChatManager.WHITE_LIST.length)
				{
					if(var4[var6].indexOf(dofus.managers.ChatManager.WHITE_LIST[var9]) > -1)
					{
						var7 = false;
						break;
					}
					var9 = var9 + 1;
				}
			}
			if(var7)
			{
				var5 = true;
				break;
			}
			var6 = var6 + 1;
		}
		if(var5)
		{
			var2 = var2 + (" [<font color=\"#006699\"><u><b><a href=\'asfunction:onHref,ShowLinkWarning,CHAT_LINK_WARNING_TEXT\'>" + this.api.lang.getText("CHAT_LINK_WARNING") + "</a></b></u></font>]");
		}
		return var2;
	}
	function addText(var2, var3, var4, var5)
	{
		if(var4 == undefined)
		{
			var4 = true;
		}
		var var6 = "";
		var var9 = false;
		if((var var0 = var3) !== dofus.Constants.MSG_CHAT_COLOR)
		{
			loop0:
			switch(null)
			{
				case dofus.Constants.EMOTE_CHAT_COLOR:
					var var7 = dofus.managers.ChatManager.TYPE_MESSAGES;
					var9 = true;
					var var8 = true;
					break;
				case dofus.Constants.THINK_CHAT_COLOR:
					var7 = dofus.managers.ChatManager.TYPE_MESSAGES;
					var9 = true;
					var8 = true;
					break;
				default:
					switch(null)
					{
						case dofus.Constants.GROUP_CHAT_COLOR:
						case dofus.Constants.MSGCHUCHOTE_CHAT_COLOR:
							var7 = dofus.managers.ChatManager.TYPE_WISP;
							var9 = true;
							var8 = true;
							if(var4)
							{
								this.api.sounds.events.onChatWisper();
							}
							break loop0;
						default:
							if(var0 !== dofus.Constants.INFO_CHAT_COLOR)
							{
								switch(null)
								{
									case dofus.Constants.ERROR_CHAT_COLOR:
										var7 = dofus.managers.ChatManager.TYPE_ERRORS;
										var8 = true;
										if(var4)
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
										var7 = dofus.managers.ChatManager.TYPE_GUILD;
										var9 = true;
										var8 = true;
										if(var4 && this.api.kernel.OptionsManager.getOption("GuildMessageSound"))
										{
											this.api.sounds.events.onChatWisper();
										}
										break loop0;
									default:
										switch(null)
										{
											case dofus.Constants.PVP_CHAT_COLOR:
												var7 = dofus.managers.ChatManager.TYPE_PVP;
												var9 = true;
												var8 = true;
												break loop0;
											case dofus.Constants.TRADE_CHAT_COLOR:
												var7 = dofus.managers.ChatManager.TYPE_TRADE;
												var9 = true;
												var8 = true;
												break loop0;
											default:
												if(var0 !== dofus.Constants.RECRUITMENT_CHAT_COLOR)
												{
													switch(null)
													{
														case dofus.Constants.MEETIC_CHAT_COLOR:
															var7 = dofus.managers.ChatManager.TYPE_MEETIC;
															var9 = true;
															var8 = true;
															break loop0;
														default:
															if(var0 !== dofus.Constants.COMMANDS_CHAT_COLOR)
															{
																ank.utils.Logger.err("[Chat] Erreur : mauvaise couleur " + var2);
																return undefined;
															}
														case dofus.Constants.ADMIN_CHAT_COLOR:
															var7 = dofus.managers.ChatManager.TYPE_ADMIN;
															var8 = true;
													}
												}
												else
												{
													var7 = dofus.managers.ChatManager.TYPE_RECRUITMENT;
													var9 = true;
													var8 = true;
													break loop0;
												}
										}
								}
							}
							else
							{
								var7 = dofus.managers.ChatManager.TYPE_INFOS;
								this._nMessageCounterInfo++;
								var8 = false;
								break loop0;
							}
					}
			}
		}
		else
		{
			var7 = dofus.managers.ChatManager.TYPE_MESSAGES;
			var9 = true;
			var8 = true;
		}
		if(this._nFileOutput > 0)
		{
			this.api.electron.chatLog(var2);
			if(this._nFileOutput == 2)
			{
				return undefined;
			}
		}
		if(var9)
		{
			var2 = this.addLinkWarning(var2);
			var2 = this.applyInputCensorship(var2.substring(0,var2.length - 4)) + var2.substring(var2.length - 4);
		}
		if(var8 && this.api.kernel.NightManager.time.length)
		{
			var6 = "[" + this.api.kernel.NightManager.time + "] ";
		}
		this._aMessages.push({textStyleLeft:"\n<font color=\"#" + var3 + "\">",text:var2,textStyleRight:"</font>",type:var7,uniqId:var5,timestamp:var6,lf:false});
		if(this._aMessages.length > dofus.managers.ChatManager.MAX_ALL_LENGTH)
		{
			this._aMessages.shift();
		}
		this.refresh();
	}
	function refresh(var2)
	{
		var var3 = this._aMessages.length;
		var var4 = new String();
		var var5 = 0;
		if(var3 == 0 && !var2)
		{
			return undefined;
		}
		var var6 = var3 - 1;
		while(var5 < dofus.managers.ChatManager.MAX_VISIBLE && var6 >= 0)
		{
			var var7 = this._aMessages[var6];
			if(this._aVisibleTypes[var7.type] == true)
			{
				var5 = var5 + 1;
				if(!var7.htmlSyntaxChecked)
				{
					var var8 = dofus.managers.ChatManager.safeHtml(var7.text);
					var7.lf = var7.lf;
					var7.text = var8.t;
					var7.htmlSyntaxChecked = true;
				}
				if(this.api.kernel.OptionsManager.getOption("TimestampInChat"))
				{
					var4 = (!var7.lf?"":"\n") + var7.textStyleLeft + var7.timestamp + var7.text + var7.textStyleRight + var4;
				}
				else
				{
					var4 = (!var7.lf?"":"\n") + var7.textStyleLeft + var7.text + var7.textStyleRight + var4;
				}
			}
			var6 = var6 - 1;
		}
		this.api.ui.getUIComponent("Banner").setChatText(var4);
	}
	static function safeHtml(var2)
	{
		var var3 = true;
		var var4 = new Array();
		var var5 = new Array();
		var var6 = var2;
		var var7 = 0;
		var var9 = 0;
		while((var var8 = var6.indexOf("<")) > -1 && var7++ < dofus.managers.ChatManager.HTML_NB_PASS_MAX)
		{
			var var10 = var6.indexOf(">",var8) + 1;
			var var11 = var6.substring(var8,var10);
			var var12 = var11.indexOf("/");
			var var13 = var12 == 1;
			var var14 = var12 == var11.length - 2;
			var var15 = !var13?var11.substring(1,var11.length - 1):var11.substring(2,var11.length - 1);
			var var16 = var15.indexOf(" ");
			var15 = var15.substring(0,var16 <= -1?var15.length:var16);
			var5[var9] = {c:var13,b:var15};
			if(var14)
			{
				var5[var9 = var9 + 1] = {c:!var13,b:var15};
			}
			var6 = var6.substring(var10);
			var9 = var9 + 1;
		}
		if(var7 >= dofus.managers.ChatManager.HTML_NB_PASS_MAX)
		{
			var3 = false;
		}
		if(var3)
		{
			var var17 = 0;
			while(var17 < var5.length)
			{
				var var18 = var5[var17];
				if(var18.c)
				{
					if(var4[var18.b] == undefined || var4[var18.b] == 0)
					{
						var3 = false;
						break;
					}
					var4[var18.b] = var4[var18.b] - 1;
				}
				else
				{
					if(var4[var18.b] == undefined)
					{
						var4[var18.b] = 0;
					}
					var4[var18.b] = var4[var18.b] + 1;
				}
				var17 = var17 + 1;
			}
			for(var i in var4)
			{
				if(var4[i] > 0)
				{
					var3 = false;
					break;
				}
			}
		}
		if(var3)
		{
			return {v:var3,t:var2};
		}
		return {v:var3,t:var2.split("<").join("&lt;").split(">").join("&gt;")};
	}
	function parseInlineItems(var2, var3)
	{
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = Number(var3[var4]);
			var var6 = var3[var4 + 1];
			var var7 = new dofus.datacenter.(0,var5,1,1,var6,1);
			var var8 = "°" + var4 / 2;
			var var9 = this.getLinkItem(var7);
			var var10 = var2.indexOf(var8);
			if(var10 != -1)
			{
				var var11 = var2.split("");
				var11.splice(var10,var8.length,var9);
				var2 = var11.join("");
			}
			var4 = var4 + 2;
		}
		return var2;
	}
	function parseInlinePos(var2)
	{
		var var3 = var2;
		var var4 = 0;
		var var6 = 0;
		var var7 = 0;
		while(var3.indexOf("[") > -1 && (var4++ < dofus.managers.ChatManager.HTML_NB_PASS_MAX && var6 < dofus.managers.ChatManager.MAX_POS_REPLACE))
		{
			var var8 = var3.indexOf("[");
			var var9 = var3.indexOf("]",var8) + 1;
			if(var9 > 0)
			{
				var var10 = var3.substring(var8 + 1,var9 - 1).indexOf(", ") != -1?", ":",";
				var var11 = var3.substring(var8 + 1,var9 - 1).split(var10);
				if(var11.length == 2)
				{
					if(!_global.isNaN(var11[0]) && !_global.isNaN(new ank.utils.(var11[0]).trim().toString()))
					{
						var var12 = _global.parseInt(var11[0]);
						var var13 = _global.parseInt(var11[1]);
						if(Math.abs(var12) < 150 && Math.abs(var13) < 150)
						{
							var var5 = var2.split(var3.substring(var8,var9));
							var6 = var6 + var5.length;
							if(var6 > dofus.managers.ChatManager.MAX_POS_REPLACE)
							{
								break;
							}
							var2 = var5.join(this.getLinkCoord(var12,var13));
						}
					}
				}
				var3 = var3.substring(var9);
				var7 = var7 + 1;
				continue;
			}
			break;
		}
		return var2;
	}
	function parseSecretsEmotes(var2)
	{
		if(!this.api.lang.getConfigText("CHAT_USE_SECRETS_EMOTES"))
		{
			return var2;
		}
		if(var2.indexOf("[love]") != -1)
		{
			var2 = var2.split("[love]").join("");
			if(!this.api.datacenter.Game.isFight)
			{
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + ",2914,11,8,1");
			}
		}
		if(var2.indexOf("[rock]") != -1)
		{
			var2 = var2.split("[rock]").join("");
			if(!this.api.datacenter.Game.isFight)
			{
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + ",2069,10,1,1");
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + (this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum + 1) + ",2904,11,8,3");
				this.api.network.GameActions.onActions(";208;" + this.api.datacenter.Player.ID + ";" + (this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).cellNum - 1) + ",2904,11,8,3");
				this.api.network.Chat.onSmiley(this.api.datacenter.Player.ID + "|1");
				this.api.kernel.AudioManager.playSound("SPEAK_TRIGGER_LEVEL_UP");
				this.api.network.Chat.onMessage(true,this.api.datacenter.Player.ID + "|" + this.api.datacenter.Player.Name + "|" + var2);
			}
			var2 = "";
		}
		return var2;
	}
	function getLinkName(var2, var3)
	{
		if(var3 != undefined && (var3.length > 0 && var3 != ""))
		{
			return "<b><a href=\'asfunction:onHref,ShowPlayerPopupMenu," + var2 + "," + var3 + "\'>" + var2 + "</a></b>";
		}
		return "<b><a href=\'asfunction:onHref,ShowPlayerPopupMenu," + var2 + "\'>" + var2 + "</a></b>";
	}
	function getLinkCoord(var2, var3)
	{
		return "<b><a href=\'asfunction:onHref,updateCompass," + var2 + "," + var3 + "\'>[" + var2 + "," + var3 + "]</a></b>";
	}
	function getLinkItem(var2)
	{
		var var3 = this.addItemToBuffer(var2);
		return "<b>[<a href=\'asfunction:onHref,ShowItemViewer," + String(var3) + "\'>" + var2.name + "</a>]</b>";
	}
	function addItemToBuffer(var2)
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
		this._aItemsBuffer.push({id:this._nItemsBufferIDs,data:var2});
		return this._nItemsBufferIDs;
	}
	function getItemFromBuffer(var2)
	{
		var var3 = this._aItemsBuffer.length;
		while(var3 >= 0)
		{
			if(this._aItemsBuffer[var3].id == var2)
			{
				return this._aItemsBuffer[var3].data;
			}
			var3 = var3 - 1;
		}
		return undefined;
	}
	static function isPonctuation(var2)
	{
		var var3 = 0;
		while(var3 < dofus.managers.ChatManager.PONCTUATION.length)
		{
			if(dofus.managers.ChatManager.PONCTUATION[var3] == var2)
			{
				return true;
			}
			var3 = var3 + 1;
		}
		return false;
	}
	function addToBlacklist(var2, var3)
	{
		if(var2 != this.api.datacenter.Player.Name && !this.isBlacklisted(var2))
		{
			this._aBlacklist.push({sName:var2,nClass:var3});
		}
	}
	function removeToBlacklist(var2)
	{
		for(var i in this._aBlacklist)
		{
			if(var2 == this._aBlacklist[i].sName || var2 == "*" + this._aBlacklist[i].sName)
			{
				this._aBlacklist[i] = undefined;
				this.api.ui.getUIComponent("Friends").updateIgnoreList();
				this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_NOMORE_BLACKLISTED",[var2]),"INFO_CHAT");
				while(§§pop() != null)
				{
				}
				return undefined;
			}
		}
	}
	function getBlacklist()
	{
		return this._aBlacklist;
	}
	function isBlacklisted(var2)
	{
		for(var i in this._aBlacklist)
		{
			if(var2.toLowerCase() == this._aBlacklist[i].sName.toLowerCase())
			{
				return true;
			}
		}
		return false;
	}
	function getMessageFromId(var2)
	{
		for(var i in this._aMessages)
		{
			if(this._aMessages[i].uniqId == var2)
			{
				return this._aMessages[i].text;
			}
		}
		return undefined;
	}
}
