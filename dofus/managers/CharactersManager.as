class dofus.managers.CharactersManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	function CharactersManager(var3)
	{
		dofus.managers.CharactersManager._sSelf = this;
		super.initialize(var3);
	}
	static function getInstance()
	{
		return dofus.managers.CharactersManager._sSelf;
	}
	function setLocalPlayerData(var2, var3, var4)
	{
		var var5 = this.api.datacenter.Player;
		var5.clean();
		var5.ID = var2;
		var5.Name = var3;
		var5.Guild = var4.guild;
		var5.Level = var4.level;
		var5.Sex = var4.sex;
		var5.color1 = var4.color1 != -1?Number("0x" + var4.color1):var4.color1;
		var5.color2 = var4.color2 != -1?Number("0x" + var4.color2):var4.color2;
		var5.color3 = var4.color3 != -1?Number("0x" + var4.color3):var4.color3;
		var var6 = var4.items.split(";");
		var var7 = 0;
		while(var7 < var6.length)
		{
			var var8 = var6[var7];
			if(var8.length != 0)
			{
				var var9 = this.getItemObjectFromData(var8);
				if(var9 != undefined)
				{
					var5.addItem(var9);
				}
			}
			var7 = var7 + 1;
		}
		var5.updateCloseCombat();
	}
	function updateLocalPlayerData(oSprite)
	{
		var var3 = this.api.datacenter.Player;
		if(var3.Name != oSprite.name)
		{
			var3.Name = oSprite.name;
		}
		if(var3.color1 != oSprite.color1 || (var3.color2 != oSprite.color2 || var3.color3 != oSprite.color3))
		{
			var3.color1 = oSprite.color1;
			var3.color2 = oSprite.color2;
			var3.color3 = oSprite.color3;
			this.api.ui.getUIComponent("Banner").updateArtwork(true);
		}
		if(var3.Sex != oSprite.Sex)
		{
			var3.Sex = oSprite.Sex;
		}
	}
	function createCharacter(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		if(this.api.datacenter.Player.isAuthorized && var4.gfxID == "999")
		{
			var4.gfxID = "8023";
		}
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID,var4.title);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = Number(var4.cell);
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.name = var3;
		var5.Guild = Number(var4.spriteType);
		var5.Level = Number(var4.level);
		var5.Sex = var4.sex == undefined?1:var4.sex;
		var5.color1 = var4.color1 != -1?Number("0x" + var4.color1):var4.color1;
		var5.color2 = var4.color2 != -1?Number("0x" + var4.color2):var4.color2;
		var5.color3 = var4.color3 != -1?Number("0x" + var4.color3):var4.color3;
		var5.Aura = var4.aura == undefined?0:var4.aura;
		var5.Merchant = var4.merchant != "1"?false:true;
		var5.serverID = Number(var4.serverID);
		var5.alignment = var4.alignment;
		var5.rank = var4.rank;
		var5.mount = var4.mount;
		var5.isDead = var4.isDead == 1;
		var5.deathState = Number(var4.isDead);
		var5.deathCount = Number(var4.deathCount);
		var5.lvlMax = Number(var4.lvlMax);
		var5.pvpGain = Number(var4.pvpGain);
		this.setSpriteAccessories(var5,var4.accessories);
		if(var4.LP != undefined)
		{
			var5.LP = var4.LP;
		}
		if(var4.LP != undefined)
		{
			var5.LPmax = var4.LP;
		}
		if(var4.AP != undefined)
		{
			var5.AP = var4.AP;
		}
		if(var4.AP != undefined)
		{
			var5.APinit = var4.AP;
		}
		if(var4.MP != undefined)
		{
			var5.MP = var4.MP;
		}
		if(var4.MP != undefined)
		{
			var5.MPinit = var4.MP;
		}
		if(var4.resistances != undefined)
		{
			var5.resistances = var4.resistances;
		}
		var5.Team = var4.team != undefined?var4.team:null;
		if(var4.emote != undefined && var4.emote.length != 0)
		{
			var5.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(var4.dir);
			if(var4.emoteTimer != undefined && var4.emote.length != 0)
			{
				var5.startAnimationTimer = var4.emoteTimer;
			}
			var5.startAnimation = "EmoteStatic" + var4.emote;
		}
		if(var4.guildName != undefined)
		{
			var5.guildName = var4.guildName;
		}
		var5.emblem = this.createGuildEmblem(var4.emblem);
		if(var4.restrictions != undefined)
		{
			var5.restrictions = _global.parseInt(var4.restrictions,36);
		}
		if(sID == this.api.datacenter.Player.ID)
		{
			this.updateLocalPlayerData(var5);
			if(!this.api.datacenter.Player.haveFakeAlignment)
			{
				this.api.datacenter.Player.alignment = var5.alignment.clone();
			}
		}
		return var5;
	}
	function createCreature(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.Creature(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.name = var3;
		var5.powerLevel = var4.powerLevel;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.noFlip = var4.noFlip;
		var5.color1 = var4.color1 != -1?Number("0x" + var4.color1):var4.color1;
		var5.color2 = var4.color2 != -1?Number("0x" + var4.color2):var4.color2;
		var5.color3 = var4.color3 != -1?Number("0x" + var4.color3):var4.color3;
		this.setSpriteAccessories(var5,var4.accessories);
		if(var4.LP != undefined)
		{
			var5.LP = var4.LP;
		}
		if(var4.LP != undefined)
		{
			var5.LPmax = var4.LP;
		}
		if(var4.AP != undefined)
		{
			var5.AP = var4.AP;
		}
		if(var4.AP != undefined)
		{
			var5.APinit = var4.AP;
		}
		if(var4.MP != undefined)
		{
			var5.MP = var4.MP;
		}
		if(var4.MP != undefined)
		{
			var5.MPinit = var4.MP;
		}
		if(var4.resistances != undefined)
		{
			var5.resistances = var4.resistances;
		}
		if(var4.summoned != undefined)
		{
			var5.isSummoned = var4.summoned;
		}
		var5.Team = var4.team != undefined?var4.team:null;
		return var5;
	}
	function createMonster(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.name = var3;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.noFlip = var4.noFlip;
		var5.powerLevel = var4.powerLevel;
		var5.color1 = var4.color1 != -1?Number("0x" + var4.color1):var4.color1;
		var5.color2 = var4.color2 != -1?Number("0x" + var4.color2):var4.color2;
		var5.color3 = var4.color3 != -1?Number("0x" + var4.color3):var4.color3;
		this.setSpriteAccessories(var5,var4.accessories);
		if(var4.LP != undefined)
		{
			var5.LP = var4.LP;
		}
		if(var4.LP != undefined)
		{
			var5.LPmax = var4.LP;
		}
		if(var4.AP != undefined)
		{
			var5.AP = var4.AP;
		}
		if(var4.AP != undefined)
		{
			var5.APinit = var4.AP;
		}
		if(var4.MP != undefined)
		{
			var5.MP = var4.MP;
		}
		if(var4.MP != undefined)
		{
			var5.MPinit = var4.MP;
		}
		if(var4.summoned != undefined)
		{
			var5.isSummoned = var4.summoned;
		}
		var5.Team = var4.team != undefined?var4.team:null;
		return var5;
	}
	function createMonsterGroup(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.bonusValue);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.name = var3;
		var5.Level = var4.level;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.noFlip = var4.noFlip;
		var5.color1 = var4.color1 != -1?Number("0x" + var4.color1):var4.color1;
		var5.color2 = var4.color2 != -1?Number("0x" + var4.color2):var4.color2;
		var5.color3 = var4.color3 != -1?Number("0x" + var4.color3):var4.color3;
		this.setSpriteAccessories(var5,var4.accessories);
		return var5;
	}
	function createNonPlayableCharacter(sID, §\x1e\x1d\x03§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID,var4.customArtwork);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.unicID = var3;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.color1 = var4.color1 != -1?Number("0x" + var4.color1):var4.color1;
		var5.color2 = var4.color2 != -1?Number("0x" + var4.color2):var4.color2;
		var5.color3 = var4.color3 != -1?Number("0x" + var4.color3):var4.color3;
		this.setSpriteAccessories(var5,var4.accessories);
		if(var4.extraClipID >= 0)
		{
			var5.extraClipID = var4.extraClipID;
		}
		return var5;
	}
	function createOfflineCharacter(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.name = var3;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.color1 = var4.color1 != -1?Number("0x" + var4.color1):var4.color1;
		var5.color2 = var4.color2 != -1?Number("0x" + var4.color2):var4.color2;
		var5.color3 = var4.color3 != -1?Number("0x" + var4.color3):var4.color3;
		this.setSpriteAccessories(var5,var4.accessories);
		if(var4.guildName != undefined)
		{
			var5.guildName = var4.guildName;
		}
		var5.emblem = this.createGuildEmblem(var4.emblem);
		var5.offlineType = var4.offlineType;
		return var5;
	}
	function createTaxCollector(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.name = this.api.lang.getFullNameText(var3.split(","));
		var5.Level = var4.level;
		if(var4.guildName != undefined)
		{
			var5.guildName = var4.guildName;
		}
		var5.emblem = this.createGuildEmblem(var4.emblem);
		if(var4.LP != undefined)
		{
			var5.LP = var4.LP;
		}
		if(var4.LP != undefined)
		{
			var5.LPmax = var4.LP;
		}
		if(var4.AP != undefined)
		{
			var5.AP = var4.AP;
		}
		if(var4.AP != undefined)
		{
			var5.APinit = var4.AP;
		}
		if(var4.MP != undefined)
		{
			var5.MP = var4.MP;
		}
		if(var4.MP != undefined)
		{
			var5.MPinit = var4.MP;
		}
		if(var4.resistances != undefined)
		{
			var5.resistances = var4.resistances;
		}
		var5.Team = var4.team != undefined?var4.team:null;
		return var5;
	}
	function createPrism(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.linkedMonster = Number(var3);
		var5.Level = var4.level;
		var5.alignment = var4.alignment;
		return var5;
	}
	function createParkMount(sID, §\x1e\x11\x13§, §\x1e\x1b\b§)
	{
		var var5 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			var5 = new dofus.datacenter.(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var4.gfxID + ".swf",var4.cell,var4.dir,var4.gfxID,var4.modelID);
			this.api.datacenter.Sprites.addItemAt(sID,var5);
		}
		var5.GameActionsManager.init();
		var5.cellNum = var4.cell;
		var5.name = var3;
		var5.scaleX = var4.scaleX;
		var5.scaleY = var4.scaleY;
		var5.ownerName = var4.ownerName;
		var5.level = var4.level;
		return var5;
	}
	function createMutant(sID, §\x1e\x1b\b§)
	{
		var var4 = this.api.datacenter.Sprites.getItemAt(sID);
		if(var4 == undefined)
		{
			var4 = new dofus.datacenter.
(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var3.gfxID + ".swf",var3.cell,var3.dir,var3.gfxID);
			this.api.datacenter.Sprites.addItemAt(sID,var4);
		}
		var4.GameActionsManager.init();
		var4.scaleX = var3.scaleX;
		var4.scaleY = var3.scaleY;
		var4.cellNum = Number(var3.cell);
		var4.Guild = Number(var3.spriteType);
		var4.powerLevel = Number(var3.powerLevel);
		var4.Sex = var3.sex == undefined?1:var3.sex;
		var4.showIsPlayer = var3.showIsPlayer;
		var4.monsterID = var3.monsterID;
		var4.playerName = var3.playerName;
		this.setSpriteAccessories(var4,var3.accessories);
		if(var3.LP != undefined)
		{
			var4.LP = var3.LP;
		}
		if(var3.LP != undefined)
		{
			var4.LPmax = var3.LP;
		}
		if(var3.AP != undefined)
		{
			var4.AP = var3.AP;
		}
		if(var3.AP != undefined)
		{
			var4.APinit = var3.AP;
		}
		if(var3.MP != undefined)
		{
			var4.MP = var3.MP;
		}
		if(var3.MP != undefined)
		{
			var4.MPinit = var3.MP;
		}
		var4.Team = var3.team != undefined?var3.team:null;
		if(var3.emote != undefined && var3.emote.length != 0)
		{
			var4.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(var3.dir);
			if(var3.emoteTimer != undefined && var3.emote.length != 0)
			{
				var4.startAnimationTimer = var3.emoteTimer;
			}
			var4.startAnimation = "EmoteStatic" + var3.emote;
		}
		if(var3.restrictions != undefined)
		{
			var4.restrictions = _global.parseInt(var3.restrictions,36);
		}
		return var4;
	}
	function getItemObjectFromData(var2)
	{
		if(var2.length == 0)
		{
			return null;
		}
		var var3 = var2.split("~");
		var var4 = _global.parseInt(var3[0],16);
		var var5 = _global.parseInt(var3[1],16);
		var var6 = _global.parseInt(var3[2],16);
		var var7 = var3[3].length != 0?_global.parseInt(var3[3],16):-1;
		var var8 = var3[4];
		var var9 = new dofus.datacenter.(var4,var5,var6,var7,var8);
		var9.priceMultiplicator = this.api.lang.getConfigText("SELL_PRICE_MULTIPLICATOR");
		return var9;
	}
	function getSpellObjectFromData(var2)
	{
		var var3 = var2.split("~");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = var3[2];
		var var7 = new dofus.datacenter.(var4,var5,var6);
		return var7;
	}
	function getNameFromData(var2)
	{
		var var3 = new Object();
		var var4 = var2.split(",");
		if(var4.length == 2)
		{
			var3.name = this.api.lang.getFullNameText(var4);
			var3.type = "taxcollector";
		}
		else if(_global.isNaN(Number(var2)))
		{
			var3.name = var2;
			var3.type = "player";
		}
		else
		{
			var3.name = this.api.lang.getMonstersText(Number(var2)).n;
			var3.type = "monster";
		}
		return var3;
	}
	function setSpriteAccessories(oSprite, §\x1e\x16\x10§)
	{
		if(var3.length != 0)
		{
			var var4 = new Array();
			var var5 = var3.split(",");
			var var6 = 0;
			while(var6 < var5.length)
			{
				if(var5[var6].indexOf("~") != -1)
				{
					var var10 = var5[var6].split("~");
					var var7 = _global.parseInt(var10[0],16);
					var var9 = _global.parseInt(var10[1]);
					var var8 = _global.parseInt(var10[2]) - 1;
					if(var8 < 0)
					{
						var8 = 0;
					}
				}
				else
				{
					var7 = _global.parseInt(var5[var6],16);
					var9 = undefined;
					var8 = undefined;
				}
				if(!_global.isNaN(var7))
				{
					var var11 = new dofus.datacenter.(var7,var9,var8);
					var4[var6] = var11;
				}
				var6 = var6 + 1;
			}
			oSprite.accessories = var4;
		}
	}
	function createGuildEmblem(var2)
	{
		if(var2 != undefined)
		{
			var var3 = var2.split(",");
			var var4 = _global.parseInt(var3[0],36);
			var var5 = _global.parseInt(var3[2],36);
			if(var4 < 1 || var4 > dofus.Constants.EMBLEM_BACKS_COUNT)
			{
				var4 = 1;
			}
			if(var5 < 1 || var5 > dofus.Constants.EMBLEM_UPS_COUNT)
			{
				var5 = 1;
			}
			var var6 = new Object();
			var6.backID = var4;
			var6.backColor = _global.parseInt(var3[1],36);
			var6.upID = var5;
			var6.upColor = _global.parseInt(var3[3],36);
			return var6;
		}
		return undefined;
	}
}
