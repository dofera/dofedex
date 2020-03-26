class dofus.managers.CharactersManager extends dofus.utils.ApiElement
{
   static var _sSelf = null;
   function CharactersManager(oAPI)
   {
      dofus.managers.CharactersManager._sSelf = this;
      super.initialize(oAPI);
   }
   static function getInstance()
   {
      return dofus.managers.CharactersManager._sSelf;
   }
   function setLocalPlayerData(nID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Player;
      _loc5_.clean();
      _loc5_.ID = nID;
      _loc5_.Name = sName;
      _loc5_.Guild = oData.guild;
      _loc5_.Level = oData.level;
      _loc5_.Sex = oData.sex;
      _loc5_.color1 = oData.color1 != -1?Number("0x" + oData.color1):oData.color1;
      _loc5_.color2 = oData.color2 != -1?Number("0x" + oData.color2):oData.color2;
      _loc5_.color3 = oData.color3 != -1?Number("0x" + oData.color3):oData.color3;
      var _loc6_ = oData.items.split(";");
      var _loc7_ = 0;
      while(_loc7_ < _loc6_.length)
      {
         var _loc8_ = _loc6_[_loc7_];
         if(_loc8_.length != 0)
         {
            var _loc9_ = this.getItemObjectFromData(_loc8_);
            if(_loc9_ != undefined)
            {
               _loc5_.addItem(_loc9_);
            }
         }
         _loc7_ = _loc7_ + 1;
      }
      _loc5_.updateCloseCombat();
   }
   function createCharacter(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.Character(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID,oData.title);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = Number(oData.cell);
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.name = sName;
      _loc5_.Guild = Number(oData.spriteType);
      _loc5_.Level = Number(oData.level);
      _loc5_.Sex = oData.sex == undefined?1:oData.sex;
      _loc5_.color1 = oData.color1 != -1?Number("0x" + oData.color1):oData.color1;
      _loc5_.color2 = oData.color2 != -1?Number("0x" + oData.color2):oData.color2;
      _loc5_.color3 = oData.color3 != -1?Number("0x" + oData.color3):oData.color3;
      _loc5_.Aura = oData.aura == undefined?0:oData.aura;
      _loc5_.Merchant = oData.merchant != "1"?false:true;
      _loc5_.serverID = Number(oData.serverID);
      _loc5_.alignment = oData.alignment;
      _loc5_.rank = oData.rank;
      _loc5_.mount = oData.mount;
      _loc5_.isDead = oData.isDead == 1;
      _loc5_.deathState = Number(oData.isDead);
      _loc5_.deathCount = Number(oData.deathCount);
      _loc5_.lvlMax = Number(oData.lvlMax);
      _loc5_.pvpGain = Number(oData.pvpGain);
      this.setSpriteAccessories(_loc5_,oData.accessories);
      if(oData.LP != undefined)
      {
         _loc5_.LP = oData.LP;
      }
      if(oData.LP != undefined)
      {
         _loc5_.LPmax = oData.LP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.AP = oData.AP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.APinit = oData.AP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MP = oData.MP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MPinit = oData.MP;
      }
      if(oData.resistances != undefined)
      {
         _loc5_.resistances = oData.resistances;
      }
      _loc5_.Team = oData.team != undefined?oData.team:null;
      if(oData.emote != undefined && oData.emote.length != 0)
      {
         _loc5_.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(oData.dir);
         if(oData.emoteTimer != undefined && oData.emote.length != 0)
         {
            _loc5_.startAnimationTimer = oData.emoteTimer;
         }
         _loc5_.startAnimation = "EmoteStatic" + oData.emote;
      }
      if(oData.guildName != undefined)
      {
         _loc5_.guildName = oData.guildName;
      }
      _loc5_.emblem = this.createGuildEmblem(oData.emblem);
      if(oData.restrictions != undefined)
      {
         _loc5_.restrictions = _global.parseInt(oData.restrictions,36);
      }
      if(sID == this.api.datacenter.Player.ID)
      {
         if(!this.api.datacenter.Player.haveFakeAlignment)
         {
            this.api.datacenter.Player.alignment = _loc5_.alignment.clone();
         }
      }
      return _loc5_;
   }
   function createCreature(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.Creature(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.name = sName;
      _loc5_.powerLevel = oData.powerLevel;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.noFlip = oData.noFlip;
      _loc5_.color1 = oData.color1 != -1?Number("0x" + oData.color1):oData.color1;
      _loc5_.color2 = oData.color2 != -1?Number("0x" + oData.color2):oData.color2;
      _loc5_.color3 = oData.color3 != -1?Number("0x" + oData.color3):oData.color3;
      this.setSpriteAccessories(_loc5_,oData.accessories);
      if(oData.LP != undefined)
      {
         _loc5_.LP = oData.LP;
      }
      if(oData.LP != undefined)
      {
         _loc5_.LPmax = oData.LP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.AP = oData.AP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.APinit = oData.AP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MP = oData.MP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MPinit = oData.MP;
      }
      if(oData.resistances != undefined)
      {
         _loc5_.resistances = oData.resistances;
      }
      if(oData.summoned != undefined)
      {
         _loc5_.isSummoned = oData.summoned;
      }
      _loc5_.Team = oData.team != undefined?oData.team:null;
      return _loc5_;
   }
   function createMonster(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.Monster(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.name = sName;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.noFlip = oData.noFlip;
      _loc5_.powerLevel = oData.powerLevel;
      _loc5_.color1 = oData.color1 != -1?Number("0x" + oData.color1):oData.color1;
      _loc5_.color2 = oData.color2 != -1?Number("0x" + oData.color2):oData.color2;
      _loc5_.color3 = oData.color3 != -1?Number("0x" + oData.color3):oData.color3;
      this.setSpriteAccessories(_loc5_,oData.accessories);
      if(oData.LP != undefined)
      {
         _loc5_.LP = oData.LP;
      }
      if(oData.LP != undefined)
      {
         _loc5_.LPmax = oData.LP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.AP = oData.AP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.APinit = oData.AP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MP = oData.MP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MPinit = oData.MP;
      }
      if(oData.summoned != undefined)
      {
         _loc5_.isSummoned = oData.summoned;
      }
      _loc5_.Team = oData.team != undefined?oData.team:null;
      return _loc5_;
   }
   function createMonsterGroup(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.MonsterGroup(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.bonusValue);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.name = sName;
      _loc5_.Level = oData.level;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.noFlip = oData.noFlip;
      _loc5_.color1 = oData.color1 != -1?Number("0x" + oData.color1):oData.color1;
      _loc5_.color2 = oData.color2 != -1?Number("0x" + oData.color2):oData.color2;
      _loc5_.color3 = oData.color3 != -1?Number("0x" + oData.color3):oData.color3;
      this.setSpriteAccessories(_loc5_,oData.accessories);
      return _loc5_;
   }
   function createNonPlayableCharacter(sID, nUnicID, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.NonPlayableCharacter(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID,oData.customArtwork);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.unicID = nUnicID;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.color1 = oData.color1 != -1?Number("0x" + oData.color1):oData.color1;
      _loc5_.color2 = oData.color2 != -1?Number("0x" + oData.color2):oData.color2;
      _loc5_.color3 = oData.color3 != -1?Number("0x" + oData.color3):oData.color3;
      this.setSpriteAccessories(_loc5_,oData.accessories);
      if(oData.extraClipID >= 0)
      {
         _loc5_.extraClipID = oData.extraClipID;
      }
      return _loc5_;
   }
   function createOfflineCharacter(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.OfflineCharacter(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.name = sName;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.color1 = oData.color1 != -1?Number("0x" + oData.color1):oData.color1;
      _loc5_.color2 = oData.color2 != -1?Number("0x" + oData.color2):oData.color2;
      _loc5_.color3 = oData.color3 != -1?Number("0x" + oData.color3):oData.color3;
      this.setSpriteAccessories(_loc5_,oData.accessories);
      if(oData.guildName != undefined)
      {
         _loc5_.guildName = oData.guildName;
      }
      _loc5_.emblem = this.createGuildEmblem(oData.emblem);
      _loc5_.offlineType = oData.offlineType;
      return _loc5_;
   }
   function createTaxCollector(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.TaxCollector(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.name = this.api.lang.getFullNameText(sName.split(","));
      _loc5_.Level = oData.level;
      if(oData.guildName != undefined)
      {
         _loc5_.guildName = oData.guildName;
      }
      _loc5_.emblem = this.createGuildEmblem(oData.emblem);
      if(oData.LP != undefined)
      {
         _loc5_.LP = oData.LP;
      }
      if(oData.LP != undefined)
      {
         _loc5_.LPmax = oData.LP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.AP = oData.AP;
      }
      if(oData.AP != undefined)
      {
         _loc5_.APinit = oData.AP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MP = oData.MP;
      }
      if(oData.MP != undefined)
      {
         _loc5_.MPinit = oData.MP;
      }
      if(oData.resistances != undefined)
      {
         _loc5_.resistances = oData.resistances;
      }
      _loc5_.Team = oData.team != undefined?oData.team:null;
      return _loc5_;
   }
   function createPrism(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.PrismSprite(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.linkedMonster = Number(sName);
      _loc5_.Level = oData.level;
      _loc5_.alignment = oData.alignment;
      return _loc5_;
   }
   function createParkMount(sID, sName, oData)
   {
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         _loc5_ = new dofus.datacenter.ParkMount(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID,oData.modelID);
         this.api.datacenter.Sprites.addItemAt(sID,_loc5_);
      }
      _loc5_.GameActionsManager.init();
      _loc5_.cellNum = oData.cell;
      _loc5_.name = sName;
      _loc5_.scaleX = oData.scaleX;
      _loc5_.scaleY = oData.scaleY;
      _loc5_.ownerName = oData.ownerName;
      _loc5_.level = oData.level;
      return _loc5_;
   }
   function createMutant(sID, oData)
   {
      var _loc4_ = this.api.datacenter.Sprites.getItemAt(sID);
      if(_loc4_ == undefined)
      {
         _loc4_ = new dofus.datacenter.Mutant(sID,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf",oData.cell,oData.dir,oData.gfxID);
         this.api.datacenter.Sprites.addItemAt(sID,_loc4_);
      }
      _loc4_.GameActionsManager.init();
      _loc4_.scaleX = oData.scaleX;
      _loc4_.scaleY = oData.scaleY;
      _loc4_.cellNum = Number(oData.cell);
      _loc4_.Guild = Number(oData.spriteType);
      _loc4_.powerLevel = Number(oData.powerLevel);
      _loc4_.Sex = oData.sex == undefined?1:oData.sex;
      _loc4_.showIsPlayer = oData.showIsPlayer;
      _loc4_.monsterID = oData.monsterID;
      _loc4_.playerName = oData.playerName;
      this.setSpriteAccessories(_loc4_,oData.accessories);
      if(oData.LP != undefined)
      {
         _loc4_.LP = oData.LP;
      }
      if(oData.LP != undefined)
      {
         _loc4_.LPmax = oData.LP;
      }
      if(oData.AP != undefined)
      {
         _loc4_.AP = oData.AP;
      }
      if(oData.AP != undefined)
      {
         _loc4_.APinit = oData.AP;
      }
      if(oData.MP != undefined)
      {
         _loc4_.MP = oData.MP;
      }
      if(oData.MP != undefined)
      {
         _loc4_.MPinit = oData.MP;
      }
      _loc4_.Team = oData.team != undefined?oData.team:null;
      if(oData.emote != undefined && oData.emote.length != 0)
      {
         _loc4_.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(oData.dir);
         if(oData.emoteTimer != undefined && oData.emote.length != 0)
         {
            _loc4_.startAnimationTimer = oData.emoteTimer;
         }
         _loc4_.startAnimation = "EmoteStatic" + oData.emote;
      }
      if(oData.restrictions != undefined)
      {
         _loc4_.restrictions = _global.parseInt(oData.restrictions,36);
      }
      return _loc4_;
   }
   function getItemObjectFromData(sData)
   {
      if(sData.length == 0)
      {
         return null;
      }
      var _loc3_ = sData.split("~");
      var _loc4_ = _global.parseInt(_loc3_[0],16);
      var _loc5_ = _global.parseInt(_loc3_[1],16);
      var _loc6_ = _global.parseInt(_loc3_[2],16);
      var _loc7_ = _loc3_[3].length != 0?_global.parseInt(_loc3_[3],16):-1;
      var _loc8_ = _loc3_[4];
      var _loc9_ = new dofus.datacenter.Item(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
      _loc9_.priceMultiplicator = this.api.lang.getConfigText("SELL_PRICE_MULTIPLICATOR");
      return _loc9_;
   }
   function getSpellObjectFromData(sData)
   {
      var _loc3_ = sData.split("~");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = _loc3_[2];
      var _loc7_ = new dofus.datacenter.Spell(_loc4_,_loc5_,_loc6_);
      return _loc7_;
   }
   function getNameFromData(sData)
   {
      var _loc3_ = new Object();
      var _loc4_ = sData.split(",");
      if(_loc4_.length == 2)
      {
         _loc3_.name = this.api.lang.getFullNameText(_loc4_);
         _loc3_.type = "taxcollector";
      }
      else if(_global.isNaN(Number(sData)))
      {
         _loc3_.name = sData;
         _loc3_.type = "player";
      }
      else
      {
         _loc3_.name = this.api.lang.getMonstersText(Number(sData)).n;
         _loc3_.type = "monster";
      }
      return _loc3_;
   }
   function setSpriteAccessories(oSprite, sAccessories)
   {
      if(sAccessories.length != 0)
      {
         var _loc4_ = new Array();
         var _loc5_ = sAccessories.split(",");
         var _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_].indexOf("~") != -1)
            {
               var _loc10_ = _loc5_[_loc6_].split("~");
               var _loc7_ = _global.parseInt(_loc10_[0],16);
               var _loc9_ = _global.parseInt(_loc10_[1]);
               var _loc8_ = _global.parseInt(_loc10_[2]) - 1;
            }
            else
            {
               _loc7_ = _global.parseInt(_loc5_[_loc6_],16);
               _loc9_ = undefined;
               _loc8_ = undefined;
            }
            if(!_global.isNaN(_loc7_))
            {
               var _loc11_ = new dofus.datacenter.Accessory(_loc7_,_loc9_,_loc8_);
               _loc4_[_loc6_] = _loc11_;
            }
            _loc6_ = _loc6_ + 1;
         }
         oSprite.accessories = _loc4_;
      }
   }
   function createGuildEmblem(sEmblem)
   {
      if(sEmblem != undefined)
      {
         var _loc3_ = sEmblem.split(",");
         var _loc4_ = new Object();
         _loc4_.backID = _global.parseInt(_loc3_[0],36);
         _loc4_.backColor = _global.parseInt(_loc3_[1],36);
         _loc4_.upID = _global.parseInt(_loc3_[2],36);
         _loc4_.upColor = _global.parseInt(_loc3_[3],36);
         return _loc4_;
      }
      return undefined;
   }
}
