class dofus.sounds.AudioEvents
{
   function AudioEvents()
   {
   }
   static function getInstance()
   {
      if(dofus.sounds.AudioEvents.instance == null)
      {
         dofus.sounds.AudioEvents.instance = new dofus.sounds.AudioEvents();
      }
      dofus.sounds.AudioEvents.api = _global.API;
      return dofus.sounds.AudioEvents.instance;
   }
   function getAudioManager()
   {
      return dofus.sounds.AudioManager.getInstance();
   }
   function onGameStart(aMusicList)
   {
      if(aMusicList == undefined)
      {
         return undefined;
      }
      var _loc3_ = Math.floor(Math.random() * aMusicList.length);
      this.getAudioManager().playMusic(aMusicList[_loc3_],false,true);
   }
   function onGameEnd()
   {
   }
   function onTurnStart()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("TURN_START"));
      }
   }
   function onGameInvitation()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"));
      }
   }
   function onGameCriticalHit()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"));
      }
   }
   function onGameCriticalMiss()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("COUP_CRITIQUE"));
      }
   }
   function onBannerRoundButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
      }
   }
   function onBannerChatButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK"));
      }
   }
   function onBannerSpellItemButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK"));
      }
   }
   function onBannerTimer()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("TAK"));
      }
   }
   function onBannerSpellSelect()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
      }
   }
   function onStatsJobBoostButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
      }
   }
   function onSpellsBoostButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
      }
   }
   function onInventoryFilterButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK3"));
      }
   }
   function onMapButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK3"));
      }
   }
   function onGuildButtonClick()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK"));
      }
   }
   function onMapFlag()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("POSE2"));
      }
   }
   function onChatWisper()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"));
      }
   }
   function onTaxcollectorAttack()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLANG"));
      }
   }
   function onError()
   {
      if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
      {
         this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("ERROR"));
      }
   }
   function onEnterVillage()
   {
   }
}
