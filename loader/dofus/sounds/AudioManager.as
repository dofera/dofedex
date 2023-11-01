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
	function __set__enabled(var2)
	{
		this._bAudioEnabled = var2;
		return this.__get__enabled();
	}
	static function __get__soundNest()
	{
		return dofus.sounds.AudioManager._mcSoundNest;
	}
	static function __set__soundNest(var2)
	{
		dofus.sounds.AudioManager._mcSoundNest = var2;
		return this.__get__soundNest();
	}
	function __get__environmentMute()
	{
		return this._bEnvironmentMute;
	}
	function __set__environmentMute(var2)
	{
		this._bEnvironmentMute = var2;
		for(var var3 in this._aSoundsCollection)
		{
			if(var3.tag == dofus.sounds.AudioManager.ENVIRONMENT_TAG)
			{
				var3.mute = this._bEnvironmentMute;
			}
		}
		this.muteChanged();
		return this.__get__environmentMute();
	}
	function __get__musicMute()
	{
		return this._bMusicMute;
	}
	function __set__musicMute(var2)
	{
		this._bMusicMute = var2;
		for(var k in this._aSoundsCollection)
		{
			var var3 = this._aSoundsCollection[k];
			if(var3.tag == dofus.sounds.AudioManager.MUSIC_TAG)
			{
				var3.mute = this._bMusicMute;
			}
		}
		this.muteChanged();
		return this.__get__musicMute();
	}
	function __get__effectMute()
	{
		return this._bEffectMute;
	}
	function __set__effectMute(var2)
	{
		this._bEffectMute = var2;
		for(var k in this._aSoundsCollection)
		{
			var var3 = this._aSoundsCollection[k];
			if(var3.tag == dofus.sounds.AudioManager.EFFECT_TAG)
			{
				var3.mute = this._bEffectMute;
			}
		}
		this.muteChanged();
		return this.__get__effectMute();
	}
	function __get__environmentVolume()
	{
		return this._nEnvironmentVolume;
	}
	function __set__environmentVolume(var2)
	{
		this._nEnvironmentVolume = var2;
		for(var k in this._aSoundsCollection)
		{
			var var3 = this._aSoundsCollection[k];
			if(var3.tag == dofus.sounds.AudioManager.ENVIRONMENT_TAG)
			{
				var3.volume = var3.baseVolume / 100 * this._nEnvironmentVolume;
			}
		}
		return this.__get__environmentVolume();
	}
	function __get__musicVolume()
	{
		return this._nMusicVolume;
	}
	function __set__musicVolume(var2)
	{
		this._nMusicVolume = var2;
		for(var var3 in this._aSoundsCollection)
		{
			if(var3.tag == dofus.sounds.AudioManager.MUSIC_TAG)
			{
				var3.volume = var3.baseVolume / 100 * this._nMusicVolume;
			}
		}
		return this.__get__musicVolume();
	}
	function __get__effectVolume()
	{
		return this._nEffectVolume;
	}
	function __set__effectVolume(var2)
	{
		this._nEffectVolume = var2;
		for(var k in this._aSoundsCollection)
		{
			var var3 = this._aSoundsCollection[k];
			if(var3.tag == dofus.sounds.AudioManager.EFFECT_TAG)
			{
				var3.volume = var3.baseVolume / 100 * this._nEffectVolume;
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
	static function getPackage(var2)
	{
		if((var var0 = var2) !== dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC)
		{
			if(var0 !== dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT)
			{
				return null;
			}
			return dofus.sounds.AudioManager._pckEffects;
		}
		return dofus.sounds.AudioManager._pckMusics;
	}
	function playSound(var2)
	{
		var var3 = new ank.utils.(var2);
		var var4 = var3.replace([" ","é","à","-"],["_","e","a","_"]).toUpperCase();
		var var5 = this.api.lang.getEffectFromKeyname(var4);
		if(var5 != undefined && !_global.isNaN(var5))
		{
			this.playEffect(var5);
		}
		else if(dofus.Constants.USING_PACKED_SOUNDS)
		{
			this.playEffectFromElement(this.getElementFromLinkname(var2));
		}
		else
		{
			return undefined;
		}
	}
	function playEnvironment(var2)
	{
		if(this._nLatestEnvironment == var2 && !this._bEnvironmentMute)
		{
			return undefined;
		}
		if(this._aLatestEnvironmentBackground != null)
		{
			var var3 = 0;
			while(var3 < this._aLatestEnvironmentBackground.length)
			{
				this._aLatestEnvironmentBackground[var3].fadeOut(dofus.sounds.AudioManager.MUSIC_FADE_OUT_LENGTH,true);
				var3 = var3 + 1;
			}
			this.stopAllSoundsWithTag(dofus.sounds.AudioManager.ENVIRONMENT_NOISE_TAG);
			_global.clearInterval(this._nEnvironmentNoisesTimer);
		}
		var var4 = this.api.lang.getEnvironment(var2);
		if(var4 == null)
		{
			return undefined;
		}
		this._aLatestEnvironmentBackground = new Array();
		var var5 = 0;
		while(var5 < var4.bg.length)
		{
			var var6 = this.getElementFromEffect(this.api.lang.getEffect(Number(var4.bg[var5])));
			var6.mute = this._bEnvironmentMute;
			var6.loops = dofus.sounds.AudioElement.INFINITE_LOOP;
			var6.baseVolume = 100;
			var6.volume = this._nEnvironmentVolume;
			var6.tag = dofus.sounds.AudioManager.ENVIRONMENT_TAG;
			this.playElement(var6);
			this._aLatestEnvironmentBackground.push(var6);
			var5 = var5 + 1;
		}
		this.nextEnvironmentNoise(var4);
		this._nLatestEnvironment = var2;
	}
	function playMusic(var2, var3)
	{
		if(this._nLatestMusic == var2 && !this._bMusicMute)
		{
			return undefined;
		}
		if(this._aeLatestMusic != null)
		{
			this._aeLatestMusic.fadeOut(dofus.sounds.AudioManager.MUSIC_FADE_OUT_LENGTH,true);
			if(var3)
			{
				this._nLatestSavedMusic = this._nLatestMusic;
			}
		}
		var var4 = this.getElementFromMusic(this.api.lang.getMusic(var2));
		var4.tag = dofus.sounds.AudioManager.MUSIC_TAG;
		var4.mute = this._bMusicMute;
		this.playElement(var4);
		this._aeLatestMusic = var4;
		this._nLatestMusic = var2;
	}
	function backToOldMusic(var2)
	{
		this.playMusic(this._nLatestSavedMusic,var2);
	}
	function playEffect(var2, var3, var4)
	{
		if(var4 == undefined)
		{
			var4 = false;
		}
		if(!var4 && !this.api.electron.isWindowFocused)
		{
			return undefined;
		}
		var var5 = this.getElementFromEffect(this.api.lang.getEffect(var2));
		var5.tag = var3 != undefined?var3:dofus.sounds.AudioManager.EFFECT_TAG;
		if((var var0 = var3) !== dofus.sounds.AudioManager.MUSIC_TAG)
		{
			switch(null)
			{
				case dofus.sounds.AudioManager.ENVIRONMENT_TAG:
					var5.mute = this._bEnvironmentMute;
					break;
				case dofus.sounds.AudioManager.EFFECT_TAG:
				default:
					var5.mute = this._bEffectMute;
			}
		}
		else
		{
			var5.mute = this._bMusicMute;
		}
		this.playElement(var5);
	}
	function playEffectFromElement(var2)
	{
		var2.tag = dofus.sounds.AudioManager.EFFECT_TAG;
		var2.mute = this._bEffectMute;
		this.playElement(var2);
	}
	function playMp3(var2)
	{
		var var3 = this.createAudioElement(var2,false,true);
		this.playElement(var3);
	}
	function stopAllSoundsWithTag(var2)
	{
		for(var k in this._aSoundsCollection)
		{
			var var3 = this._aSoundsCollection[k];
			if(var3.tag == var2)
			{
				var3.dispose();
			}
		}
	}
	function stopAllSounds()
	{
		for(var var2 in this._aSoundsCollection)
		{
			var2.dispose();
		}
		_global.clearInterval(this._nEnvironmentNoisesTimer);
		this._nLatestSavedMusic = -1;
		this._nLatestMusic = -1;
		this._nLatestEnvironment = -1;
	}
	function createAudioElement(var2, var3, var4, var5)
	{
		if(var2 == undefined)
		{
			return null;
		}
		var var6 = !var4?this.getNextSoundIndex():this.getNextMusicIndex();
		var var7 = this.getSoundContainer(var6,var5);
		return new dofus.sounds.(var6,var2,var7,var3);
	}
	function playElement(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		if(!this._bAudioEnabled)
		{
			return undefined;
		}
		this._aSoundsCollection["SND" + var2.uniqID] = var2;
		this.addToQueue({object:var2,method:var2.startElement});
	}
	function getNextSoundIndex(var2)
	{
		this._nCurrentSoundIndex++;
		if(this._nCurrentSoundIndex > dofus.sounds.AudioManager.MAX_SOUND_INDEX)
		{
			this._nCurrentSoundIndex = dofus.sounds.AudioManager.SOUND_INDEX;
		}
		var var3 = this._aSoundsCollection["SND" + this._nCurrentSoundIndex];
		var3.dispose();
		return this._nCurrentSoundIndex;
	}
	function getNextMusicIndex(var2)
	{
		this._nCurrentMusicIndex++;
		if(this._nCurrentMusicIndex > dofus.sounds.AudioManager.MAX_MUSIC_INDEX)
		{
			this._nCurrentMusicIndex = dofus.sounds.AudioManager.MUSIC_INDEX;
		}
		var var3 = this._aSoundsCollection["SND" + this._nCurrentSoundIndex];
		var3.dispose();
		return this._nCurrentMusicIndex;
	}
	function getSoundContainer(var2, var3)
	{
		if(!dofus.Constants.USING_PACKED_SOUNDS || var3 == null)
		{
			return dofus.sounds.AudioManager._mcSoundNest.createEmptyMovieClip("SND" + var2,var2);
		}
		if((var var0 = var3) !== dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT)
		{
			if(var0 !== dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC)
			{
				return null;
			}
			return dofus.sounds.AudioManager._pckMusics.createEmptyMovieClip("MU" + var2,var2);
		}
		return dofus.sounds.AudioManager._pckEffects.createEmptyMovieClip("FX" + var2,var2);
	}
	function getElementFromLinkname(var2)
	{
		var var3 = this.createAudioElement(dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT + var2,true,false,dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT);
		var3.baseVolume = 100;
		var3.volume = this._nEffectVolume;
		var3.offset = 0;
		var3.loops = dofus.sounds.AudioElement.ONESHOT_SAMPLE;
		return var3;
	}
	function getElementFromEffect(var2)
	{
		var var3 = this.createAudioElement((!dofus.Constants.USING_PACKED_SOUNDS?dofus.Constants.AUDIO_EFFECTS_PATH:dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT) + var2.f,var2.s,false,!dofus.Constants.USING_PACKED_SOUNDS?null:dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT);
		var3.baseVolume = var2.v;
		var3.volume = var2.v / 100 * this._nEffectVolume;
		var3.offset = var2.o;
		var3.loops = var2.l != true?dofus.sounds.AudioElement.ONESHOT_SAMPLE:dofus.sounds.AudioElement.INFINITE_LOOP;
		return var3;
	}
	function getElementFromMusic(var2)
	{
		var var3 = this.createAudioElement((!dofus.Constants.USING_PACKED_SOUNDS?dofus.Constants.AUDIO_MUSICS_PATH:dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC) + var2.f,var2.s,true,!dofus.Constants.USING_PACKED_SOUNDS?null:dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC);
		var3.baseVolume = var2.v;
		var3.volume = var2.v / 100 * this._nMusicVolume;
		var3.offset = var2.o;
		var3.loops = var2.l != true?dofus.sounds.AudioElement.ONESHOT_SAMPLE:dofus.sounds.AudioElement.INFINITE_LOOP;
		return var3;
	}
	function nextEnvironmentNoise(var2)
	{
		_global.clearInterval(this._nEnvironmentNoisesTimer);
		if(var2 == undefined)
		{
			return undefined;
		}
		var var3 = (var2.mind + Math.round(Math.random() * var2.maxd)) * 1000;
		var3 = Math.max(10,var3);
		this._nEnvironmentNoisesTimer = _global.setInterval(this,"onPlayNoise",var3,var2);
	}
	function onPlayNoise(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		var var3 = var2.n[Math.floor(var2.n.length * Math.random())];
		this.playEffect(var3,dofus.sounds.AudioManager.ENVIRONMENT_NOISE_TAG);
		this.nextEnvironmentNoise(var2);
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
