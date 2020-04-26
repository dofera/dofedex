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
	function SpeakingItemsManager(loc3)
	{
		super();
		dofus.managers.SpeakingItemsManager._sSelf = this;
		this.initialize(loc3);
	}
	static function getInstance()
	{
		return dofus.managers.SpeakingItemsManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		eval("\n\x0b").events.EventDispatcher.initialize(this);
		this.generateNextMsgCount(true);
	}
	function __get__nextMsgDelay()
	{
		return this._nNextMessageCount;
	}
	function triggerPrivateEvent(loc2)
	{
		this.api.kernel.AudioManager.playSound(loc2);
	}
	function triggerEvent(loc2)
	{
		if(loc2 == dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ON_CONNECT)
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
			var loc3 = this._eaItems[Math.floor(Math.random() * this._eaItems.length)];
			this._nNextMessageCount--;
			this._nNextMessageCount = this._nNextMessageCount - (this._eaItems.length - 1) / 4;
			if(this._nNextMessageCount <= 0)
			{
				var loc4 = this.api.lang.getSpeakingItemsTrigger(loc2)[loc3.mood];
				if(loc4)
				{
					var loc6 = new Array();
					var loc7 = 0;
					for(; loc7 < loc4.length; loc7 = loc7 + 1)
					{
						var loc5 = this.api.lang.getSpeakingItemsText(loc4[loc7]);
						if(loc5.l <= loc3.maxSkin)
						{
							if(loc5.r != undefined && loc5.r != "")
							{
								var loc8 = loc5.r.split(",");
								var loc9 = false;
								var loc10 = 0;
								while(loc10 < loc8.length)
								{
									if(loc8[loc10] == loc3.realUnicId)
									{
										loc9 = true;
										break;
									}
									loc10 = loc10 + 1;
								}
								if(!loc9)
								{
									continue;
								}
							}
							if(loc5.m != undefined)
							{
								if(loc5.p != undefined)
								{
									loc6.push(loc4[loc7]);
								}
							}
						}
					}
					var loc11 = false;
					var loc13 = 10;
					var loc14 = this.api.lang.getConfigText("SPEAKING_ITEMS_MAX_TEXT_ID");
					while(!loc11 && ((loc13 = loc13 - 1) && loc6.length))
					{
						var loc12 = loc6[Math.floor(Math.random() * loc6.length)];
						if(!(loc14 != -1 && loc12 > loc14))
						{
							loc5 = this.api.lang.getSpeakingItemsText(loc12);
							if(Math.random() < loc5.p)
							{
								loc11 = true;
							}
						}
					}
					if(!loc11)
					{
						return undefined;
					}
					if(loc5.s != -1 && !_global.isNaN(loc5.s))
					{
						var loc15 = Math.floor(Math.random() * 3);
					}
					else
					{
						loc15 = 1;
					}
					if((loc15 == 0 || loc15 == 2) && this.api.lang.getConfigText("SPEAKING_ITEMS_USE_SOUND"))
					{
						this.api.kernel.AudioManager.playSound("SPEAKING_ITEMS_" + loc5.s);
					}
					if(loc15 == 1 || loc15 == 2)
					{
						var loc16 = this.api.lang.getConfigText("SPEAKING_ITEMS_CHAT_PROBA");
						if(Math.random() * loc16 <= 1 && this.api.datacenter.Player.canChatToAll)
						{
							this.api.network.Chat.send("**" + (loc12 + this.api.datacenter.Player.ID) + "**","*");
						}
						else
						{
							this.api.kernel.showMessage(undefined,loc3.name + " : " + loc5.m,"WHISP_CHAT");
						}
					}
					this.generateNextMsgCount();
				}
			}
		}
		return undefined;
	}
	function generateNextMsgCount(loc2)
	{
		var loc3 = this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT");
		var loc4 = loc3 * this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT_DELTA");
		if(loc2)
		{
			this._nNextMessageCount = Math.floor(loc3 * Math.random());
		}
		else
		{
			this._nNextMessageCount = loc3 + Math.floor(2 * loc4 * Math.random() - loc4 / 2);
		}
	}
	function updateEquipedSpeakingItems()
	{
		var loc2 = this.api.datacenter.Player.Inventory;
		var loc3 = new ank.utils.();
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			if(loc2[loc4].isSpeakingItem && loc2[loc4].position != -1)
			{
				loc3.push(loc2[loc4]);
			}
			loc4 = loc4 + 1;
		}
		this._eaItems = loc3;
	}
}
