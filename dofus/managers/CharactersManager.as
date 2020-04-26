class dofus.managers.CharactersManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	function CharactersManager(loc3)
	{
		dofus.managers.CharactersManager._sSelf = this;
		super.initialize(loc3);
	}
	static function getInstance()
	{
		return dofus.managers.CharactersManager._sSelf;
	}
	function setLocalPlayerData(loc2, loc3, loc4)
	{
		var loc5 = this.api.datacenter.Player;
		loc5.clean();
		loc5.ID = loc2;
		loc5.Name = loc3;
		loc5.Guild = loc4.guild;
		loc5.Level = loc4.level;
		loc5.Sex = loc4.sex;
		loc5.color1 = loc4.color1 != -1?Number("0x" + loc4.color1):loc4.color1;
		loc5.color2 = loc4.color2 != -1?Number("0x" + loc4.color2):loc4.color2;
		loc5.color3 = loc4.color3 != -1?Number("0x" + loc4.color3):loc4.color3;
		var loc6 = loc4.items.split(";");
		var loc7 = 0;
		while(loc7 < loc6.length)
		{
			var loc8 = loc6[loc7];
			if(loc8.length != 0)
			{
				var loc9 = this.getItemObjectFromData(loc8);
				if(loc9 != undefined)
				{
					loc5.addItem(loc9);
				}
			}
			loc7 = loc7 + 1;
		}
		loc5.updateCloseCombat();
	}
	function createCharacter(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		if(this.api.datacenter.Player.isAuthorized && loc4.gfxID == "999")
		{
			loc4.gfxID = "8023";
		}
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID,loc4.title);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = Number(loc4.cell);
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.name = loc3;
		loc5.Guild = Number(loc4.spriteType);
		loc5.Level = Number(loc4.level);
		loc5.Sex = loc4.sex == undefined?1:loc4.sex;
		loc5.color1 = loc4.color1 != -1?Number("0x" + loc4.color1):loc4.color1;
		loc5.color2 = loc4.color2 != -1?Number("0x" + loc4.color2):loc4.color2;
		loc5.color3 = loc4.color3 != -1?Number("0x" + loc4.color3):loc4.color3;
		loc5.Aura = loc4.aura == undefined?0:loc4.aura;
		loc5.Merchant = loc4.merchant != "1"?false:true;
		loc5.serverID = Number(loc4.serverID);
		loc5.alignment = loc4.alignment;
		loc5.rank = loc4.rank;
		loc5.mount = loc4.mount;
		loc5.isDead = loc4.isDead == 1;
		loc5.deathState = Number(loc4.isDead);
		loc5.deathCount = Number(loc4.deathCount);
		loc5.lvlMax = Number(loc4.lvlMax);
		loc5.pvpGain = Number(loc4.pvpGain);
		this.setSpriteAccessories(loc5,loc4.accessories);
		if(loc4.LP != undefined)
		{
			loc5.LP = loc4.LP;
		}
		if(loc4.LP != undefined)
		{
			loc5.LPmax = loc4.LP;
		}
		if(loc4.AP != undefined)
		{
			loc5.AP = loc4.AP;
		}
		if(loc4.AP != undefined)
		{
			loc5.APinit = loc4.AP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MP = loc4.MP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MPinit = loc4.MP;
		}
		if(loc4.resistances != undefined)
		{
			loc5.resistances = loc4.resistances;
		}
		loc5.Team = loc4.team != undefined?loc4.team:null;
		if(loc4.emote != undefined && loc4.emote.length != 0)
		{
			loc5.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(loc4.dir);
			if(loc4.emoteTimer != undefined && loc4.emote.length != 0)
			{
				loc5.startAnimationTimer = loc4.emoteTimer;
			}
			loc5.startAnimation = "EmoteStatic" + loc4.emote;
		}
		if(loc4.guildName != undefined)
		{
			loc5.guildName = loc4.guildName;
		}
		loc5.emblem = this.createGuildEmblem(loc4.emblem);
		if(loc4.restrictions != undefined)
		{
			loc5.restrictions = _global.parseInt(loc4.restrictions,36);
		}
		if(sID == this.api.datacenter.Player.ID)
		{
			if(!this.api.datacenter.Player.haveFakeAlignment)
			{
				this.api.datacenter.Player.alignment = loc5.alignment.clone();
			}
		}
		return loc5;
	}
	function createCreature(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.Creature(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.name = loc3;
		loc5.powerLevel = loc4.powerLevel;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.noFlip = loc4.noFlip;
		loc5.color1 = loc4.color1 != -1?Number("0x" + loc4.color1):loc4.color1;
		loc5.color2 = loc4.color2 != -1?Number("0x" + loc4.color2):loc4.color2;
		loc5.color3 = loc4.color3 != -1?Number("0x" + loc4.color3):loc4.color3;
		this.setSpriteAccessories(loc5,loc4.accessories);
		if(loc4.LP != undefined)
		{
			loc5.LP = loc4.LP;
		}
		if(loc4.LP != undefined)
		{
			loc5.LPmax = loc4.LP;
		}
		if(loc4.AP != undefined)
		{
			loc5.AP = loc4.AP;
		}
		if(loc4.AP != undefined)
		{
			loc5.APinit = loc4.AP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MP = loc4.MP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MPinit = loc4.MP;
		}
		if(loc4.resistances != undefined)
		{
			loc5.resistances = loc4.resistances;
		}
		if(loc4.summoned != undefined)
		{
			loc5.isSummoned = loc4.summoned;
		}
		loc5.Team = loc4.team != undefined?loc4.team:null;
		return loc5;
	}
	function createMonster(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.name = loc3;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.noFlip = loc4.noFlip;
		loc5.powerLevel = loc4.powerLevel;
		loc5.color1 = loc4.color1 != -1?Number("0x" + loc4.color1):loc4.color1;
		loc5.color2 = loc4.color2 != -1?Number("0x" + loc4.color2):loc4.color2;
		loc5.color3 = loc4.color3 != -1?Number("0x" + loc4.color3):loc4.color3;
		this.setSpriteAccessories(loc5,loc4.accessories);
		if(loc4.LP != undefined)
		{
			loc5.LP = loc4.LP;
		}
		if(loc4.LP != undefined)
		{
			loc5.LPmax = loc4.LP;
		}
		if(loc4.AP != undefined)
		{
			loc5.AP = loc4.AP;
		}
		if(loc4.AP != undefined)
		{
			loc5.APinit = loc4.AP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MP = loc4.MP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MPinit = loc4.MP;
		}
		if(loc4.summoned != undefined)
		{
			loc5.isSummoned = loc4.summoned;
		}
		loc5.Team = loc4.team != undefined?loc4.team:null;
		return loc5;
	}
	function createMonsterGroup(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.bonusValue);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.name = loc3;
		loc5.Level = loc4.level;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.noFlip = loc4.noFlip;
		loc5.color1 = loc4.color1 != -1?Number("0x" + loc4.color1):loc4.color1;
		loc5.color2 = loc4.color2 != -1?Number("0x" + loc4.color2):loc4.color2;
		loc5.color3 = loc4.color3 != -1?Number("0x" + loc4.color3):loc4.color3;
		this.setSpriteAccessories(loc5,loc4.accessories);
		return loc5;
	}
	function createNonPlayableCharacter(sID, §\x1e\x1d\x05§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID,loc4.customArtwork);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.unicID = loc3;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.color1 = loc4.color1 != -1?Number("0x" + loc4.color1):loc4.color1;
		loc5.color2 = loc4.color2 != -1?Number("0x" + loc4.color2):loc4.color2;
		loc5.color3 = loc4.color3 != -1?Number("0x" + loc4.color3):loc4.color3;
		this.setSpriteAccessories(loc5,loc4.accessories);
		if(loc4.extraClipID >= 0)
		{
			loc5.extraClipID = loc4.extraClipID;
		}
		return loc5;
	}
	function createOfflineCharacter(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.name = loc3;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.color1 = loc4.color1 != -1?Number("0x" + loc4.color1):loc4.color1;
		loc5.color2 = loc4.color2 != -1?Number("0x" + loc4.color2):loc4.color2;
		loc5.color3 = loc4.color3 != -1?Number("0x" + loc4.color3):loc4.color3;
		this.setSpriteAccessories(loc5,loc4.accessories);
		if(loc4.guildName != undefined)
		{
			loc5.guildName = loc4.guildName;
		}
		loc5.emblem = this.createGuildEmblem(loc4.emblem);
		loc5.offlineType = loc4.offlineType;
		return loc5;
	}
	function createTaxCollector(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.name = this.api.lang.getFullNameText(loc3.split(","));
		loc5.Level = loc4.level;
		if(loc4.guildName != undefined)
		{
			loc5.guildName = loc4.guildName;
		}
		loc5.emblem = this.createGuildEmblem(loc4.emblem);
		if(loc4.LP != undefined)
		{
			loc5.LP = loc4.LP;
		}
		if(loc4.LP != undefined)
		{
			loc5.LPmax = loc4.LP;
		}
		if(loc4.AP != undefined)
		{
			loc5.AP = loc4.AP;
		}
		if(loc4.AP != undefined)
		{
			loc5.APinit = loc4.AP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MP = loc4.MP;
		}
		if(loc4.MP != undefined)
		{
			loc5.MPinit = loc4.MP;
		}
		if(loc4.resistances != undefined)
		{
			loc5.resistances = loc4.resistances;
		}
		loc5.Team = loc4.team != undefined?loc4.team:null;
		return loc5;
	}
	function createPrism(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.linkedMonster = Number(loc3);
		loc5.Level = loc4.level;
		loc5.alignment = loc4.alignment;
		return loc5;
	}
	function createParkMount(sID, §\x1e\x11\x15§, §\x1e\x1b\n§)
	{
		var loc5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			loc5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc4.gfxID + ".swf",loc4.cell,loc4.dir,loc4.gfxID,loc4.modelID);
			this.api.datacenter.Sprites.addItemAt(sID,loc5);
		}
		loc5.GameActionsManager.init();
		loc5.cellNum = loc4.cell;
		loc5.name = loc3;
		loc5.scaleX = loc4.scaleX;
		loc5.scaleY = loc4.scaleY;
		loc5.ownerName = loc4.ownerName;
		loc5.level = loc4.level;
		return loc5;
	}
	function createMutant(sID, §\x1e\x1b\n§)
	{
		var loc4 = this.api.datacenter.Sprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			loc4 = new dofus.datacenter.
(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + loc3.gfxID + ".swf",loc3.cell,loc3.dir,loc3.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,loc4);
		}
		loc4.GameActionsManager.init();
		loc4.scaleX = loc3.scaleX;
		loc4.scaleY = loc3.scaleY;
		loc4.cellNum = Number(loc3.cell);
		loc4.Guild = Number(loc3.spriteType);
		loc4.powerLevel = Number(loc3.powerLevel);
		loc4.Sex = loc3.sex == undefined?1:loc3.sex;
		loc4.showIsPlayer = loc3.showIsPlayer;
		loc4.monsterID = loc3.monsterID;
		loc4.playerName = loc3.playerName;
		this.setSpriteAccessories(loc4,loc3.accessories);
		if(loc3.LP != undefined)
		{
			loc4.LP = loc3.LP;
		}
		if(loc3.LP != undefined)
		{
			loc4.LPmax = loc3.LP;
		}
		if(loc3.AP != undefined)
		{
			loc4.AP = loc3.AP;
		}
		if(loc3.AP != undefined)
		{
			loc4.APinit = loc3.AP;
		}
		if(loc3.MP != undefined)
		{
			loc4.MP = loc3.MP;
		}
		if(loc3.MP != undefined)
		{
			loc4.MPinit = loc3.MP;
		}
		loc4.Team = loc3.team != undefined?loc3.team:null;
		if(loc3.emote != undefined && loc3.emote.length != 0)
		{
			loc4.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(loc3.dir);
			if(loc3.emoteTimer != undefined && loc3.emote.length != 0)
			{
				loc4.startAnimationTimer = loc3.emoteTimer;
			}
			loc4.startAnimation = "EmoteStatic" + loc3.emote;
		}
		if(loc3.restrictions != undefined)
		{
			loc4.restrictions = _global.parseInt(loc3.restrictions,36);
		}
		return loc4;
	}
	function getItemObjectFromData(loc2)
	{
		if(loc2.length == 0)
		{
			return null;
		}
		var loc3 = loc2.split("~");
		var loc4 = _global.parseInt(loc3[0],16);
		var loc5 = _global.parseInt(loc3[1],16);
		var loc6 = _global.parseInt(loc3[2],16);
		var loc7 = loc3[3].length != 0?_global.parseInt(loc3[3],16):-1;
		var loc8 = loc3[4];
		var loc9 = new dofus.datacenter.(loc4,loc5,loc6,loc7,loc8);
		loc9.priceMultiplicator = this.api.lang.getConfigText("SELL_PRICE_MULTIPLICATOR");
		return loc9;
	}
	function getSpellObjectFromData(loc2)
	{
		var loc3 = loc2.split("~");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = loc3[2];
		var loc7 = new dofus.datacenter.(loc4,loc5,loc6);
		return loc7;
	}
	function getNameFromData(loc2)
	{
		var loc3 = new Object();
		var loc4 = loc2.split(",");
		if(loc4.length == 2)
		{
			loc3.name = this.api.lang.getFullNameText(loc4);
			loc3.type = "taxcollector";
		}
		else if(_global.isNaN(Number(loc2)))
		{
			loc3.name = loc2;
			loc3.type = "player";
		}
		else
		{
			loc3.name = this.api.lang.getMonstersText(Number(loc2)).n;
			loc3.type = "monster";
		}
		return loc3;
	}
	function setSpriteAccessories(oSprite, §\x1e\x16\x12§)
	{
		if(loc3.length != 0)
		{
			var loc4 = new Array();
			var loc5 = loc3.split(",");
			var loc6 = 0;
			while(loc6 < loc5.length)
			{
				if(loc5[loc6].indexOf("~") != -1)
				{
					var loc10 = loc5[loc6].split("~");
					var loc7 = _global.parseInt(loc10[0],16);
					var loc9 = _global.parseInt(loc10[1]);
					var loc8 = _global.parseInt(loc10[2]) - 1;
					if(loc8 < 0)
					{
						loc8 = 0;
					}
				}
				else
				{
					loc7 = _global.parseInt(loc5[loc6],16);
					loc9 = undefined;
					loc8 = undefined;
				}
				if(!_global.isNaN(loc7))
				{
					var loc11 = new dofus.datacenter.(loc7,loc9,loc8);
					loc4[loc6] = loc11;
				}
				loc6 = loc6 + 1;
			}
			oSprite.accessories = loc4;
		}
	}
	function createGuildEmblem(loc2)
	{
		if(loc2 != undefined)
		{
			var loc3 = loc2.split(",");
			var loc4 = _global.parseInt(loc3[0],36);
			var loc5 = _global.parseInt(loc3[2],36);
			if(loc4 < 1 || loc4 > dofus.Constants.EMBLEM_BACKS_COUNT)
			{
				loc4 = 1;
			}
			if(loc5 < 1 || loc5 > dofus.Constants.EMBLEM_UPS_COUNT)
			{
				loc5 = 1;
			}
			var loc6 = new Object();
			loc6.backID = loc4;
			loc6.backColor = _global.parseInt(loc3[1],36);
			loc6.upID = loc5;
			loc6.upColor = _global.parseInt(loc3[3],36);
			return loc6;
		}
		return undefined;
	}
}
