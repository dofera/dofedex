class dofus.managers.OptionsManager extends dofus.utils.ApiElement
{
   static var DEFAULT_VALUES = {loaded:true,Grid:false,Transparency:false,SpriteInfos:true,SpriteMove:false,MapInfos:false,AutoHideSmileys:false,StringCourse:true,PointsOverHead:true,ChatEffects:true,CreaturesMode:50,Buff:true,GuildMessageSound:false,BannerShortcuts:false,StartTurnSound:true,TipsOnStart:true,DisplayStyle:"normal",DebugSizeIndex:0,ServerPortIndex:0,MovableBar:false,ViewAllMonsterInGroup:true,MovableBarSize:5,ShortcutSet:1,ShortcutSetDefault:1,CharacterPreview:true,MapFilters:[0,1,0,1],Aura:true,AudioMusicVol:60,AudioEffectVol:100,AudioEnvVol:60,AudioMusicMute:false,AudioEffectMute:false,AudioEnvMute:false,FloatingTipsCoord:new com.ankamagames.types.Point(415,30),DisplayingFreshTips:true,CensorshipFilter:true,BigStoreSellFilter:false,RememberAccountName:false,LastAccountNameUsed:"",DefaultQuality:"high",ConquestFilter:-2,FightGroupAutoLock:false,BannerIllustrationMode:"artwork",AskForWrongCraft:true,AdvancedLineOfSight:false,RemindTurnTime:true,HideSpellBar:false,SeeAllSpell:true,UseSpeakingItems:true,ConfirmDropItem:true,TimestampInChat:false,ViewDicesDammages:false};
   static var _sSelf = null;
   function OptionsManager(oAPI)
   {
      super();
      dofus.managers.OptionsManager._sSelf = this;
      this.initialize(oAPI);
   }
   static function getInstance()
   {
      return dofus.managers.OptionsManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      mx.events.EventDispatcher.initialize(this);
      this._so = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
      if(this._so.data.loaded == undefined)
      {
         this._so.clear();
      }
      for(var k in dofus.managers.OptionsManager.DEFAULT_VALUES)
      {
         if(this._so.data[k] == undefined)
         {
            this._so.data[k] = dofus.managers.OptionsManager.DEFAULT_VALUES[k];
         }
      }
      this._so.flush();
   }
   function loadDefault()
   {
      var _loc2_ = this._so.data.language;
      this._so.clear();
      for(var k in dofus.managers.OptionsManager.DEFAULT_VALUES)
      {
         if(k == "ShortcutSetDefault")
         {
            this.setOption(k,this.api.kernel.KeyManager.getCurrentDefaultSet());
         }
         else
         {
            this.setOption(k,dofus.managers.OptionsManager.DEFAULT_VALUES[k]);
         }
      }
      this._so.data.language = _loc2_;
   }
   function setOption(sKey, mValue)
   {
      var _loc4_ = this.saveValue(sKey,mValue);
      if(this.applyOption(sKey,_loc4_))
      {
         this.dispatchEvent({type:"optionChanged",key:sKey,value:_loc4_});
      }
   }
   function getOption(sKey)
   {
      return this.loadValue(sKey);
   }
   function applyAllOptions()
   {
      var _loc2_ = this._so.data;
      for(var k in _loc2_)
      {
         this.applyOption(k,_loc2_[k]);
      }
   }
   function saveValue(sKey, mValue)
   {
      var _loc4_ = this._so.data;
      if(mValue == undefined)
      {
         if(typeof _loc4_[sKey] == "boolean")
         {
            _loc4_[sKey] = !_loc4_[sKey];
         }
         else
         {
            _loc4_[sKey] = true;
         }
      }
      else
      {
         _loc4_[sKey] = mValue;
      }
      this._so.flush();
      return _loc4_[sKey];
   }
   function loadValue(sKey)
   {
      return this._so.data[sKey];
   }
   function applyOption(sKey, mValue)
   {
      switch(sKey)
      {
         case "Grid":
            if(mValue == true)
            {
               this.api.gfx.drawGrid();
            }
            else
            {
               this.api.gfx.removeGrid();
            }
            break;
         case "Transparency":
            this.api.gfx.setSpriteGhostView(mValue);
            break;
         case "SpriteInfos":
            if(mValue == false)
            {
               this.api.ui.unloadUIComponent("SpriteInfos");
               this.setOption("SpriteMove",false);
            }
            break;
         case "SpriteMove":
            if(mValue == false)
            {
               this.api.gfx.clearZoneLayer("move");
            }
            else if(this.loadValue("SpriteInfos") == false)
            {
               this.setOption("SpriteInfos",true);
            }
            break;
         case "MapInfos":
            if(mValue == true)
            {
               this.api.ui.loadUIComponent("MapInfos","MapInfos",undefined,{bForceLoad:true});
            }
            else
            {
               this.api.ui.unloadUIComponent("MapInfos");
            }
            break;
         case "AutoHideSmiley":
            break;
         case "StringCourse":
            if(mValue == false)
            {
               this.api.ui.unloadUIComponent("StringCourse");
            }
            break;
         case "PointsOverHead":
         case "ChatEffects":
         case "CreaturesMode":
         case "GuildMessageSound":
         case "StartTurnSound":
         case "BannerShortcuts":
         case "TipsOnStart":
         case "DebugSizeIndex":
         case "ServerPortIndex":
         case "ViewAllMonsterInGroup":
            break;
         case "Buff":
            if(mValue)
            {
               this.api.ui.loadUIComponent("Buff","Buff");
            }
            else
            {
               this.api.ui.unloadUIComponent("Buff");
            }
            break;
         case "DisplayStyle":
            this.api.kernel.setDisplayStyle(mValue);
            break;
         case "DefaultQuality":
            this.api.kernel.setQuality(mValue);
            break;
         case "MovableBar":
            this.api.ui.getUIComponent("Banner").displayMovableBar(mValue && (this.api.datacenter.Game.isFight || !this.getOption("HideSpellBar")));
            break;
         case "HideSpellBar":
            this.api.ui.getUIComponent("Banner").displayMovableBar(this.getOption("MovableBar") && (this.api.datacenter.Game.isFight || !mValue));
            break;
         case "MovableBarSize":
            this.api.ui.getUIComponent("Banner").setMovableBarSize(mValue);
            break;
         case "ShortcutSet":
            this.api.kernel.KeyManager.onSetChange(mValue);
            break;
         case "CharacterPreview":
            this.api.ui.getUIComponent("Inventory").showCharacterPreview(mValue);
            break;
         case "AudioMusicVol":
            this.api.kernel.AudioManager.musicVolume = mValue;
            break;
         case "AudioEffectVol":
            this.api.kernel.AudioManager.effectVolume = mValue;
            break;
         case "AudioEnvVol":
            this.api.kernel.AudioManager.environmentVolume = mValue;
            break;
         case "AudioMusicMute":
            this.api.kernel.AudioManager.musicMute = mValue;
            break;
         case "AudioEffectMute":
            this.api.kernel.AudioManager.effectMute = mValue;
            break;
         case "AudioEnvMute":
            this.api.kernel.AudioManager.environmentMute = mValue;
            break;
         case "TimestampInChat":
            this.api.kernel.ChatManager.refresh();
      }
      return true;
   }
}
