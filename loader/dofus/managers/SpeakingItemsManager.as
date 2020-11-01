class dofus.managers.SpeakingItemsManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	static var MINUTE_DELAY = 1000 * 60;
	static var SPEAK_TRIGGER_MINUTE = 1;
	static var SPEAK_TRIGGER_AGRESS = 2;
	static var SPEAK_TRIGGER_AGRESSED = 3;
	static var SPEAK_TRIGGER_KILL_ENEMY = 4;
	static var SPEAK_TRIGGER_KILLED_BY_ENEMY = 5;
	static var SPEAK_TRIGGER_CC_OWNER = 6;
	static var SPEAK_TRIGGER_EC_OWNER = 7;
	static var SPEAK_TRIGGER_FIGHT_WON = 8;
	static var SPEAK_TRIGGER_FIGHT_LOST = 9;
	static var SPEAK_TRIGGER_NEW_ENEMY_WEAK = 10;
	static var SPEAK_TRIGGER_NEW_ENEMY_STRONG = 11;
	static var SPEAK_TRIGGER_CC_ALLIED = 12;
	static var SPEAK_TRIGGER_EC_ALLIED = 13;
	static var SPEAK_TRIGGER_CC_ENEMY = 14;
	static var SPEAK_TRIGGER_EC_ENEMY = 15;
	static var SPEAK_TRIGGER_ON_CONNECT = 16;
	static var SPEAK_TRIGGER_KILL_ALLY = 17;
	static var SPEAK_TRIGGER_KILLED_BY_ALLY = 18;
	static var SPEAK_TRIGGER_GREAT_DROP = 19;
	static var SPEAK_TRIGGER_KILLED_HIMSELF = 20;
	static var SPEAK_TRIGGER_CRAFT_OK = 21;
	static var SPEAK_TRIGGER_CRAFT_KO = 22;
	static var SPEAK_TRIGGER_LEVEL_UP = "SPEAK_TRIGGER_LEVEL_UP";
	static var SPEAK_TRIGGER_FEED = "SPEAK_TRIGGER_FEED";
	static var SPEAK_TRIGGER_ASSOCIATE = "SPEAK_TRIGGER_ASSOCIATE";
	static var SPEAK_TRIGGER_DISSOCIATE = "SPEAK_TRIGGER_DISSOCIATE";
	static var SPEAK_TRIGGER_CHANGE_SKIN = "SPEAK_TRIGGER_CHANGE_SKIN";
	function SpeakingItemsManager(var2)
	{
		super();
		dofus.managers.SpeakingItemsManager._sSelf = this;
		this.initialize(var3);
	}
	static function getInstance()
	{
		return dofus.managers.SpeakingItemsManager._sSelf;
	}
	function initialize(var2)
	{
		super.initialize(var3);
		mx.events.EventDispatcher.initialize(this);
		this.generateNextMsgCount(true);
	}
	function __get__nextMsgDelay()
	{
		return this._nNextMessageCount;
	}
	function triggerPrivateEvent(var2)
	{
		this.api.kernel.AudioManager.playSound(var2);
	}
	function triggerEvent(var2)
	{
		if(var2 == dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ON_CONNECT)
		{
			ank.utils.Timer.removeTimer(this,"SpeakingItemsManager",dofus.managers.SpeakingItemsManager._nTimer);
			ank.utils.Timer.setTimer(this,"SpeakingItemsManager",this,this.triggerEvent,dofus.managers.SpeakingItemsManager.MINUTE_DELAY,[dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_MINUTE],true);
		}
		if(!this.api.kernel.OptionsManager.getOption("UseSpeakingItems"))
		{
			return undefined;
		}
		this.updateEquipedSpeakingItems();
		if(this._eaItems.length)
		{
			var var3 = this._eaItems[Math.floor(Math.random() * this._eaItems.length)];
			this._nNextMessageCount--;
			this._nNextMessageCount = this._nNextMessageCount - (this._eaItems.length - 1) / 4;
			if(this._nNextMessageCount <= 0)
			{
				var var4 = this.api.lang.getSpeakingItemsTrigger(var2)[var3.mood];
				if(var4)
				{
					var var6 = new Array();
					var var7 = 0;
					for(; var7 < var4.length; var7 = var7 + 1)
					{
						var var5 = this.api.lang.getSpeakingItemsText(var4[var7]);
						if(var5.l <= var3.maxSkin)
						{
							if(var5.r != undefined && var5.r != "")
							{
								var var8 = var5.r.split(",");
								var var9 = false;
								var var10 = 0;
								while(var10 < var8.length)
								{
									if(var8[var10] == var3.realUnicId)
									{
										var9 = true;
										break;
									}
									var10 = var10 + 1;
								}
								if(!var9)
								{
									continue;
								}
							}
							if(var5.m != undefined)
							{
								if(var5.p != undefined)
								{
									var6.push(var4[var7]);
								}
							}
						}
					}
					var var11 = false;
					var var13 = 10;
					var var14 = this.api.lang.getConfigText("SPEAKING_ITEMS_MAX_TEXT_ID");
					while(!var11 && ((var13 = var13 - 1) && var6.length))
					{
						var var12 = var6[Math.floor(Math.random() * var6.length)];
						if(!(var14 != -1 && var12 > var14))
						{
							var5 = this.api.lang.getSpeakingItemsText(var12);
							if(Math.random() < var5.p)
							{
								var11 = true;
							}
						}
					}
					if(!var11)
					{
						return undefined;
					}
					if(var5.s != -1 && !_global.isNaN(var5.s))
					{
						var var15 = Math.floor(Math.random() * 3);
					}
					else
					{
						var15 = 1;
					}
					if((var15 == 0 || var15 == 2) && this.api.lang.getConfigText("SPEAKING_ITEMS_USE_SOUND"))
					{
						this.api.kernel.AudioManager.playSound("SPEAKING_ITEMS_" + var5.s);
					}
					if(var15 == 1 || var15 == 2)
					{
						var var16 = this.api.lang.getConfigText("SPEAKING_ITEMS_CHAT_PROBA");
						if(Math.random() * var16 <= 1 && this.api.datacenter.Player.canChatToAll)
						{
							this.api.network.Chat.send("**" + (var12 + this.api.datacenter.Player.ID) + "**","*");
						}
						else
						{
							this.api.kernel.showMessage(undefined,var3.name + " : " + var5.m,"WHISP_CHAT");
						}
					}
					this.generateNextMsgCount();
				}
			}
		}
		return undefined;
	}
	function generateNextMsgCount(var2)
	{
		var var3 = this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT");
		var var4 = var3 * this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT_DELTA");
		if(var2)
		{
			this._nNextMessageCount = Math.floor(var3 * Math.random());
		}
		else
		{
			this._nNextMessageCount = var3 + Math.floor(2 * var4 * Math.random() - var4 / 2);
		}
	}
	function updateEquipedSpeakingItems()
	{
		var var2 = this.api.datacenter.Player.Inventory;
		var var3 = new ank.utils.();
		var var4 = 0;
		while(var4 < var2.length)
		{
			if(var2[var4].isSpeakingItem && var2[var4].position != -1)
			{
				var3.push(var2[var4]);
			}
			var4 = var4 + 1;
		}
		this._eaItems = var3;
	}
}
