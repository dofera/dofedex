class dofus.sounds.AudioManager extends dofus.utils.ApiElement
{
   static var MUSIC_INDEX = 1000;
   static var MAX_MUSIC_INDEX = 1010;
   static var SOUND_INDEX = 1;
   static var MAX_SOUND_INDEX = 100;
   static var MUSIC_FADE_OUT_LENGTH = 4;
   static var ENVIRONMENT_TAG = "TAG_ENVIRONMENT";
   static var ENVIRONMENT_NOISE_TAG = "TAG_ENVIRONMENT_NOISE";
   static var EFFECT_TAG = "TAG_EFFECT";
   static var MUSIC_TAG = "TAG_MUSIC";
   static var PACKAGE_TYPE_MUSIC = "mu/";
   static var PACKAGE_TYPE_EFFECT = "fx/";
   static var instance = null;
   static var _bInitialized = false;
   var _bAudioEnabled = true;
   var _nCurrentSoundIndex = dofus.sounds.AudioManager.SOUND_INDEX;
   var _nCurrentMusicIndex = dofus.sounds.AudioManager.MUSIC_INDEX;
   var _bEnvironmentMute = false;
   var _bMusicMute = false;
   var _bEffectMute = false;
   var _nEnvironmentVolume = 100;
   var _nMusicVolume = 100;
   var _nEffectVolume = 100;
   var _aSoundsCollection = new Array();
   var _nLatestSavedMusic = -1;
   var _nLatestMusic = -1;
   var _aeLatestMusic = null;
   var _nLatestEnvironment = -1;
   var _aLatestEnvironmentBackground = null;
   var _nEnvironmentNoisesTimer = -1;
   function AudioManager()
   {
      super();
      if(dofus.sounds.AudioManager._mcSoundNest == null)
      {
         return undefined;
      }
   }
   function __get__events()
   {
      return dofus.sounds.AudioEvents.getInstance();
   }
   function __get__enabled()
   {
      return this._bAudioEnabled;
   }
   function __set__enabled(bValue)
   {
      this._bAudioEnabled = bValue;
      return this.__get__enabled();
   }
   static function __get__soundNest()
   {
      return dofus.sounds.AudioManager._mcSoundNest;
   }
   static function __set__soundNest(newNest)
   {
      dofus.sounds.AudioManager._mcSoundNest = newNest;
      return this.__get__soundNest();
   }
   function __get__environmentMute()
   {
      return this._bEnvironmentMute;
   }
   function __set__environmentMute(bValue)
   {
      this._bEnvironmentMute = bValue;
      for(var k in this._aSoundsCollection)
      {
         var _loc3_ = this._aSoundsCollection[k];
         if(_loc3_.tag == dofus.sounds.AudioManager.ENVIRONMENT_TAG)
         {
            _loc3_.mute = this._bEnvironmentMute;
         }
      }
      this.muteChanged();
      return this.__get__environmentMute();
   }
   function __get__musicMute()
   {
      return this._bMusicMute;
   }
   function __set__musicMute(bValue)
   {
      this._bMusicMute = bValue;
      for(var k in this._aSoundsCollection)
      {
         var _loc3_ = this._aSoundsCollection[k];
         if(_loc3_.tag == dofus.sounds.AudioManager.MUSIC_TAG)
         {
            _loc3_.mute = this._bMusicMute;
         }
      }
      this.muteChanged();
      return this.__get__musicMute();
   }
   function __get__effectMute()
   {
      return this._bEffectMute;
   }
   function __set__effectMute(bValue)
   {
      this._bEffectMute = bValue;
      for(var k in this._aSoundsCollection)
      {
         var _loc3_ = this._aSoundsCollection[k];
         if(_loc3_.tag == dofus.sounds.AudioManager.EFFECT_TAG)
         {
            _loc3_.mute = this._bEffectMute;
         }
      }
      this.muteChanged();
      return this.__get__effectMute();
   }
   function __get__environmentVolume()
   {
      return this._nEnvironmentVolume;
   }
   function __set__environmentVolume(nValue)
   {
      this._nEnvironmentVolume = nValue;
      for(var k in this._aSoundsCollection)
      {
         var _loc3_ = this._aSoundsCollection[k];
         if(_loc3_.tag == dofus.sounds.AudioManager.ENVIRONMENT_TAG)
         {
            _loc3_.volume = _loc3_.baseVolume / 100 * this._nEnvironmentVolume;
         }
      }
      return this.__get__environmentVolume();
   }
   function __get__musicVolume()
   {
      return this._nMusicVolume;
   }
   function __set__musicVolume(nValue)
   {
      this._nMusicVolume = nValue;
      for(var k in this._aSoundsCollection)
      {
         var _loc3_ = this._aSoundsCollection[k];
         if(_loc3_.tag == dofus.sounds.AudioManager.MUSIC_TAG)
         {
            _loc3_.volume = _loc3_.baseVolume / 100 * this._nMusicVolume;
         }
      }
      return this.__get__musicVolume();
   }
   function __get__effectVolume()
   {
      return this._nEffectVolume;
   }
   function __set__effectVolume(nValue)
   {
      this._nEffectVolume = nValue;
      for(var k in this._aSoundsCollection)
      {
         var _loc3_ = this._aSoundsCollection[k];
         if(_loc3_.tag == dofus.sounds.AudioManager.EFFECT_TAG)
         {
            _loc3_.volume = _loc3_.baseVolume / 100 * this._nEffectVolume;
         }
      }
      return this.__get__effectVolume();
   }
   static function initialize(soundNest)
   {
      dofus.sounds.AudioManager._mcSoundNest = soundNest;
      if(dofus.Constants.USING_PACKED_SOUNDS)
      {
         dofus.sounds.AudioManager._pckEffects = soundNest.createEmptyMovieClip("pckEffects",soundNest.getNextHighestDepth());
         dofus.sounds.AudioManager._pckEffects.loadMovie(dofus.Constants.SOUND_EFFECTS_PACKAGE);
         dofus.sounds.AudioManager._pckMusics = soundNest.createEmptyMovieClip("pckMusics",soundNest.getNextHighestDepth());
         dofus.sounds.AudioManager._pckMusics.loadMovie(dofus.Constants.SOUND_MUSICS_PACKAGE);
      }
      dofus.sounds.AudioManager._bInitialized = true;
   }
   static function getInstance()
   {
      if(!dofus.sounds.AudioManager._bInitialized)
      {
         return null;
      }
      if(dofus.sounds.AudioManager.instance == null)
      {
         dofus.sounds.AudioManager.instance = new dofus.sounds.AudioManager();
      }
      return dofus.sounds.AudioManager.instance;
   }
   static function getPackage(sPackageType)
   {
      switch(sPackageType)
      {
         case dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC:
            return dofus.sounds.AudioManager._pckMusics;
         case dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT:
            return dofus.sounds.AudioManager._pckEffects;
         default:
            return null;
      }
   }
   function playSound(sOldSoundID)
   {
      var _loc3_ = new ank.utils.ExtendedString(sOldSoundID);
      var _loc4_ = _loc3_.replace([" ","é","à","-"],["_","e","a","_"]).toUpperCase();
      var _loc5_ = this.api.lang.getEffectFromKeyname(_loc4_);
      if(_loc5_ != undefined && !_global.isNaN(_loc5_))
      {
         this.playEffect(_loc5_);
      }
      else if(dofus.Constants.USING_PACKED_SOUNDS)
      {
         this.playEffectFromElement(this.getElementFromLinkname(sOldSoundID));
      }
      else
      {
         return undefined;
      }
   }
   function playEnvironment(environmentID)
   {
      if(this._nLatestEnvironment == environmentID && !this._bEnvironmentMute)
      {
         return undefined;
      }
      if(this._aLatestEnvironmentBackground != null)
      {
         var _loc3_ = 0;
         while(_loc3_ < this._aLatestEnvironmentBackground.length)
         {
            this._aLatestEnvironmentBackground[_loc3_].fadeOut(dofus.sounds.AudioManager.MUSIC_FADE_OUT_LENGTH,true);
            _loc3_ = _loc3_ + 1;
         }
         this.stopAllSoundsWithTag(dofus.sounds.AudioManager.ENVIRONMENT_NOISE_TAG);
         _global.clearInterval(this._nEnvironmentNoisesTimer);
      }
      var _loc4_ = this.api.lang.getEnvironment(environmentID);
      if(_loc4_ == null)
      {
         return undefined;
      }
      this._aLatestEnvironmentBackground = new Array();
      var _loc5_ = 0;
      while(_loc5_ < _loc4_.bg.length)
      {
         var _loc6_ = this.getElementFromEffect(this.api.lang.getEffect(Number(_loc4_.bg[_loc5_])));
         _loc6_.mute = this._bEnvironmentMute;
         _loc6_.loops = dofus.sounds.AudioElement.INFINITE_LOOP;
         _loc6_.baseVolume = 100;
         _loc6_.volume = this._nEnvironmentVolume;
         _loc6_.tag = dofus.sounds.AudioManager.ENVIRONMENT_TAG;
         this.playElement(_loc6_);
         this._aLatestEnvironmentBackground.push(_loc6_);
         _loc5_ = _loc5_ + 1;
      }
      this.nextEnvironmentNoise(_loc4_);
      this._nLatestEnvironment = environmentID;
   }
   function playMusic(musicID, bSaveOldMusic)
   {
      if(this._nLatestMusic == musicID && !this._bMusicMute)
      {
         return undefined;
      }
      if(this._aeLatestMusic != null)
      {
         this._aeLatestMusic.fadeOut(dofus.sounds.AudioManager.MUSIC_FADE_OUT_LENGTH,true);
         if(bSaveOldMusic)
         {
            this._nLatestSavedMusic = this._nLatestMusic;
         }
      }
      var _loc4_ = this.getElementFromMusic(this.api.lang.getMusic(musicID));
      _loc4_.tag = dofus.sounds.AudioManager.MUSIC_TAG;
      _loc4_.mute = this._bMusicMute;
      this.playElement(_loc4_);
      this._aeLatestMusic = _loc4_;
      this._nLatestMusic = musicID;
   }
   function backToOldMusic(bStartSmooth)
   {
      this.playMusic(this._nLatestSavedMusic,bStartSmooth);
   }
   function playEffect(effectID, customTag)
   {
      var _loc4_ = this.getElementFromEffect(this.api.lang.getEffect(effectID));
      _loc4_.tag = customTag != undefined?customTag:dofus.sounds.AudioManager.EFFECT_TAG;
      switch(customTag)
      {
         case dofus.sounds.AudioManager.MUSIC_TAG:
            _loc4_.mute = this._bMusicMute;
            break;
         case dofus.sounds.AudioManager.ENVIRONMENT_TAG:
            _loc4_.mute = this._bEnvironmentMute;
            break;
         case dofus.sounds.AudioManager.EFFECT_TAG:
         default:
            _loc4_.mute = this._bEffectMute;
      }
      this.playElement(_loc4_);
   }
   function playEffectFromElement(ae)
   {
      ae.tag = dofus.sounds.AudioManager.EFFECT_TAG;
      ae.mute = this._bEffectMute;
      this.playElement(ae);
   }
   function playMp3(file)
   {
      var _loc3_ = this.createAudioElement(file,false,true);
      this.playElement(_loc3_);
   }
   function stopAllSoundsWithTag(sTag)
   {
      for(var k in this._aSoundsCollection)
      {
         var _loc3_ = this._aSoundsCollection[k];
         if(_loc3_.tag == sTag)
         {
            _loc3_.dispose();
         }
      }
   }
   function stopAllSounds()
   {
      for(var k in this._aSoundsCollection)
      {
         var _loc2_ = this._aSoundsCollection[k];
         _loc2_.dispose();
      }
      _global.clearInterval(this._nEnvironmentNoisesTimer);
      this._nLatestSavedMusic = -1;
      this._nLatestMusic = -1;
      this._nLatestEnvironment = -1;
   }
   function createAudioElement(file, streaming, music, package)
   {
      if(file == undefined)
      {
         return null;
      }
      var _loc6_ = !music?this.getNextSoundIndex():this.getNextMusicIndex();
      var _loc7_ = this.getSoundContainer(_loc6_,package);
      return new dofus.sounds.AudioElement(_loc6_,file,_loc7_,streaming);
   }
   function playElement(soundElement)
   {
      if(soundElement == undefined)
      {
         return undefined;
      }
      if(!this._bAudioEnabled)
      {
         return undefined;
      }
      this._aSoundsCollection["SND" + soundElement.uniqID] = soundElement;
      this.addToQueue({object:soundElement,method:soundElement.startElement});
   }
   function getNextSoundIndex(Void)
   {
      this._nCurrentSoundIndex = this._nCurrentSoundIndex + 1;
      if(this._nCurrentSoundIndex > dofus.sounds.AudioManager.MAX_SOUND_INDEX)
      {
         this._nCurrentSoundIndex = dofus.sounds.AudioManager.SOUND_INDEX;
      }
      var _loc3_ = this._aSoundsCollection["SND" + this._nCurrentSoundIndex];
      _loc3_.dispose();
      return this._nCurrentSoundIndex;
   }
   function getNextMusicIndex(Void)
   {
      this._nCurrentMusicIndex = this._nCurrentMusicIndex + 1;
      if(this._nCurrentMusicIndex > dofus.sounds.AudioManager.MAX_MUSIC_INDEX)
      {
         this._nCurrentMusicIndex = dofus.sounds.AudioManager.MUSIC_INDEX;
      }
      var _loc3_ = this._aSoundsCollection["SND" + this._nCurrentSoundIndex];
      _loc3_.dispose();
      return this._nCurrentMusicIndex;
   }
   function getSoundContainer(nUniqID, package)
   {
      if(!dofus.Constants.USING_PACKED_SOUNDS || package == null)
      {
         return dofus.sounds.AudioManager._mcSoundNest.createEmptyMovieClip("SND" + nUniqID,nUniqID);
      }
      switch(package)
      {
         case dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT:
            return dofus.sounds.AudioManager._pckEffects.createEmptyMovieClip("FX" + nUniqID,nUniqID);
         case dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC:
            return dofus.sounds.AudioManager._pckMusics.createEmptyMovieClip("MU" + nUniqID,nUniqID);
         default:
            return null;
      }
   }
   function getElementFromLinkname(sLink)
   {
      var _loc3_ = this.createAudioElement(dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT + sLink,true,false,dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT);
      _loc3_.baseVolume = 100;
      _loc3_.volume = this._nEffectVolume;
      _loc3_.offset = 0;
      _loc3_.loops = dofus.sounds.AudioElement.ONESHOT_SAMPLE;
      return _loc3_;
   }
   function getElementFromEffect(oEffect)
   {
      var _loc3_ = this.createAudioElement((!dofus.Constants.USING_PACKED_SOUNDS?dofus.Constants.AUDIO_EFFECTS_PATH:dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT) + oEffect.f,oEffect.s,false,!dofus.Constants.USING_PACKED_SOUNDS?null:dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT);
      _loc3_.baseVolume = oEffect.v;
      _loc3_.volume = oEffect.v / 100 * this._nEffectVolume;
      _loc3_.offset = oEffect.o;
      _loc3_.loops = oEffect.l != true?dofus.sounds.AudioElement.ONESHOT_SAMPLE:dofus.sounds.AudioElement.INFINITE_LOOP;
      return _loc3_;
   }
   function getElementFromMusic(oMusic)
   {
      var _loc3_ = this.createAudioElement((!dofus.Constants.USING_PACKED_SOUNDS?dofus.Constants.AUDIO_MUSICS_PATH:dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC) + oMusic.f,oMusic.s,true,!dofus.Constants.USING_PACKED_SOUNDS?null:dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC);
      _loc3_.baseVolume = oMusic.v;
      _loc3_.volume = oMusic.v / 100 * this._nMusicVolume;
      _loc3_.offset = oMusic.o;
      _loc3_.loops = oMusic.l != true?dofus.sounds.AudioElement.ONESHOT_SAMPLE:dofus.sounds.AudioElement.INFINITE_LOOP;
      return _loc3_;
   }
   function nextEnvironmentNoise(oEnvironment)
   {
      _global.clearInterval(this._nEnvironmentNoisesTimer);
      if(oEnvironment == undefined)
      {
         return undefined;
      }
      var _loc3_ = (oEnvironment.mind + Math.round(Math.random() * oEnvironment.maxd)) * 1000;
      _loc3_ = Math.max(10,_loc3_);
      this._nEnvironmentNoisesTimer = _global.setInterval(this,"onPlayNoise",_loc3_,oEnvironment);
   }
   function onPlayNoise(environment)
   {
      if(environment == undefined)
      {
         return undefined;
      }
      var _loc3_ = environment.n[Math.floor(environment.n.length * Math.random())];
      this.playEffect(_loc3_,dofus.sounds.AudioManager.ENVIRONMENT_NOISE_TAG);
      this.nextEnvironmentNoise(environment);
   }
   function muteChanged()
   {
      if(this._bMusicMute && (this._bEnvironmentMute && this._bEffectMute))
      {
         this._bAudioEnabled = false;
      }
      else
      {
         this._bAudioEnabled = true;
      }
   }
}
