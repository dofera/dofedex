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
	function __set__enabled(loc2)
	{
		this._bAudioEnabled = loc2;
		return this.__get__enabled();
	}
	static function __get__soundNest()
	{
		return dofus.sounds.AudioManager._mcSoundNest;
	}
	static function __set__soundNest(loc2)
	{
		dofus.sounds.AudioManager._mcSoundNest = loc2;
		return this.__get__soundNest();
	}
	function __get__environmentMute()
	{
		return this._bEnvironmentMute;
	}
	function __set__environmentMute(loc2)
	{
		this._bEnvironmentMute = loc2;
		for(var loc3 in this._aSoundsCollection)
		{
			if(loc3.tag == dofus.sounds.AudioManager.ENVIRONMENT_TAG)
			{
				loc3.mute = this._bEnvironmentMute;
			}
		}
		this.muteChanged();
		return this.__get__environmentMute();
	}
	function __get__musicMute()
	{
		return this._bMusicMute;
	}
	function __set__musicMute(loc2)
	{
		this._bMusicMute = loc2;
		for(var loc3 in this._aSoundsCollection)
		{
			if(loc3.tag == dofus.sounds.AudioManager.MUSIC_TAG)
			{
				loc3.mute = this._bMusicMute;
			}
		}
		this.muteChanged();
		return this.__get__musicMute();
	}
	function __get__effectMute()
	{
		return this._bEffectMute;
	}
	function __set__effectMute(loc2)
	{
		this._bEffectMute = loc2;
		for(var loc3 in this._aSoundsCollection)
		{
			if(loc3.tag == dofus.sounds.AudioManager.EFFECT_TAG)
			{
				loc3.mute = this._bEffectMute;
			}
		}
		this.muteChanged();
		return this.__get__effectMute();
	}
	function __get__environmentVolume()
	{
		return this._nEnvironmentVolume;
	}
	function __set__environmentVolume(loc2)
	{
		this._nEnvironmentVolume = loc2;
		for(var loc3 in this._aSoundsCollection)
		{
			if(loc3.tag == dofus.sounds.AudioManager.ENVIRONMENT_TAG)
			{
				loc3.volume = loc3.baseVolume / 100 * this._nEnvironmentVolume;
			}
		}
		return this.__get__environmentVolume();
	}
	function __get__musicVolume()
	{
		return this._nMusicVolume;
	}
	function __set__musicVolume(loc2)
	{
		this._nMusicVolume = loc2;
		for(var loc3 in this._aSoundsCollection)
		{
			if(loc3.tag == dofus.sounds.AudioManager.MUSIC_TAG)
			{
				loc3.volume = loc3.baseVolume / 100 * this._nMusicVolume;
			}
		}
		return this.__get__musicVolume();
	}
	function __get__effectVolume()
	{
		return this._nEffectVolume;
	}
	function __set__effectVolume(loc2)
	{
		this._nEffectVolume = loc2;
		for(var loc3 in this._aSoundsCollection)
		{
			if(loc3.tag == dofus.sounds.AudioManager.EFFECT_TAG)
			{
				loc3.volume = loc3.baseVolume / 100 * this._nEffectVolume;
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
	static function getPackage(loc2)
	{
		if((var loc0 = loc2) !== dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC)
		{
			if(loc0 !== dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT)
			{
				return null;
			}
			return dofus.sounds.AudioManager._pckEffects;
		}
		return dofus.sounds.AudioManager._pckMusics;
	}
	function playSound(loc2)
	{
		var loc3 = new ank.utils.(loc2);
		var loc4 = loc3.replace([" ","é","à","-"],["_","e","a","_"]).toUpperCase();
		var loc5 = this.api.lang.getEffectFromKeyname(loc4);
		if(loc5 != undefined && !_global.isNaN(loc5))
		{
			this.playEffect(loc5);
		}
		else if(dofus.Constants.USING_PACKED_SOUNDS)
		{
			this.playEffectFromElement(this.getElementFromLinkname(loc2));
		}
		else
		{
			return undefined;
		}
	}
	function playEnvironment(loc2)
	{
		if(this._nLatestEnvironment == loc2 && !this._bEnvironmentMute)
		{
			return undefined;
		}
		if(this._aLatestEnvironmentBackground != null)
		{
			var loc3 = 0;
			while(loc3 < this._aLatestEnvironmentBackground.length)
			{
				this._aLatestEnvironmentBackground[loc3].fadeOut(dofus.sounds.AudioManager.MUSIC_FADE_OUT_LENGTH,true);
				loc3 = loc3 + 1;
			}
			this.stopAllSoundsWithTag(dofus.sounds.AudioManager.ENVIRONMENT_NOISE_TAG);
			_global.clearInterval(this._nEnvironmentNoisesTimer);
		}
		var loc4 = this.api.lang.getEnvironment(loc2);
		if(loc4 == null)
		{
			return undefined;
		}
		this._aLatestEnvironmentBackground = new Array();
		var loc5 = 0;
		while(loc5 < loc4.bg.length)
		{
			var loc6 = this.getElementFromEffect(this.api.lang.getEffect(Number(loc4.bg[loc5])));
			loc6.mute = this._bEnvironmentMute;
			loc6.loops = dofus.sounds.AudioElement.INFINITE_LOOP;
			loc6.baseVolume = 100;
			loc6.volume = this._nEnvironmentVolume;
			loc6.tag = dofus.sounds.AudioManager.ENVIRONMENT_TAG;
			this.playElement(loc6);
			this._aLatestEnvironmentBackground.push(loc6);
			loc5 = loc5 + 1;
		}
		this.nextEnvironmentNoise(loc4);
		this._nLatestEnvironment = loc2;
	}
	function playMusic(loc2, loc3)
	{
		if(this._nLatestMusic == loc2 && !this._bMusicMute)
		{
			return undefined;
		}
		if(this._aeLatestMusic != null)
		{
			this._aeLatestMusic.fadeOut(dofus.sounds.AudioManager.MUSIC_FADE_OUT_LENGTH,true);
			if(loc3)
			{
				this._nLatestSavedMusic = this._nLatestMusic;
			}
		}
		var loc4 = this.getElementFromMusic(this.api.lang.getMusic(loc2));
		loc4.tag = dofus.sounds.AudioManager.MUSIC_TAG;
		loc4.mute = this._bMusicMute;
		this.playElement(loc4);
		this._aeLatestMusic = loc4;
		this._nLatestMusic = loc2;
	}
	function backToOldMusic(loc2)
	{
		this.playMusic(this._nLatestSavedMusic,loc2);
	}
	function playEffect(loc2, loc3)
	{
		var loc4 = this.getElementFromEffect(this.api.lang.getEffect(loc2));
		loc4.tag = loc3 != undefined?loc3:dofus.sounds.AudioManager.EFFECT_TAG;
		if((var loc0 = loc3) !== dofus.sounds.AudioManager.MUSIC_TAG)
		{
			if(loc0 !== dofus.sounds.AudioManager.ENVIRONMENT_TAG)
			{
				if(loc0 !== dofus.sounds.AudioManager.EFFECT_TAG)
				{
				}
				loc4.mute = this._bEffectMute;
			}
			else
			{
				loc4.mute = this._bEnvironmentMute;
			}
		}
		else
		{
			loc4.mute = this._bMusicMute;
		}
		this.playElement(loc4);
	}
	function playEffectFromElement(loc2)
	{
		loc2.tag = dofus.sounds.AudioManager.EFFECT_TAG;
		loc2.mute = this._bEffectMute;
		this.playElement(loc2);
	}
	function playMp3(loc2)
	{
		var loc3 = this.createAudioElement(loc2,false,true);
		this.playElement(loc3);
	}
	function stopAllSoundsWithTag(loc2)
	{
		for(var loc3 in this._aSoundsCollection)
		{
			if(loc3.tag == loc2)
			{
				loc3.dispose();
			}
		}
	}
	function stopAllSounds()
	{
		for(var loc2 in this._aSoundsCollection)
		{
			loc2.dispose();
		}
		_global.clearInterval(this._nEnvironmentNoisesTimer);
		this._nLatestSavedMusic = -1;
		this._nLatestMusic = -1;
		this._nLatestEnvironment = -1;
	}
	function createAudioElement(loc2, loc3, loc4, loc5)
	{
		if(loc2 == undefined)
		{
			return null;
		}
		var loc6 = !loc4?this.getNextSoundIndex():this.getNextMusicIndex();
		var loc7 = this.getSoundContainer(loc6,loc5);
		return new dofus.sounds.(loc6,loc2,loc7,loc3);
	}
	function playElement(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(!this._bAudioEnabled)
		{
			return undefined;
		}
		this._aSoundsCollection["SND" + loc2.uniqID] = loc2;
		this.addToQueue({object:loc2,method:loc2.startElement});
	}
	function getNextSoundIndex(loc2)
	{
		this._nCurrentSoundIndex++;
		if(this._nCurrentSoundIndex > dofus.sounds.AudioManager.MAX_SOUND_INDEX)
		{
			this._nCurrentSoundIndex = dofus.sounds.AudioManager.SOUND_INDEX;
		}
		var loc3 = this._aSoundsCollection["SND" + this._nCurrentSoundIndex];
		loc3.dispose();
		return this._nCurrentSoundIndex;
	}
	function getNextMusicIndex(loc2)
	{
		this._nCurrentMusicIndex++;
		if(this._nCurrentMusicIndex > dofus.sounds.AudioManager.MAX_MUSIC_INDEX)
		{
			this._nCurrentMusicIndex = dofus.sounds.AudioManager.MUSIC_INDEX;
		}
		var loc3 = this._aSoundsCollection["SND" + this._nCurrentSoundIndex];
		loc3.dispose();
		return this._nCurrentMusicIndex;
	}
	function getSoundContainer(loc2, loc3)
	{
		if(!dofus.Constants.USING_PACKED_SOUNDS || loc3 == null)
		{
			return dofus.sounds.AudioManager._mcSoundNest.createEmptyMovieClip("SND" + loc2,loc2);
		}
		if((var loc0 = loc3) !== dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT)
		{
			if(loc0 !== dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC)
			{
				return null;
			}
			return dofus.sounds.AudioManager._pckMusics.createEmptyMovieClip("MU" + loc2,loc2);
		}
		return dofus.sounds.AudioManager._pckEffects.createEmptyMovieClip("FX" + loc2,loc2);
	}
	function getElementFromLinkname(loc2)
	{
		var loc3 = this.createAudioElement(dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT + loc2,true,false,dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT);
		loc3.baseVolume = 100;
		loc3.volume = this._nEffectVolume;
		loc3.offset = 0;
		loc3.loops = dofus.sounds.AudioElement.ONESHOT_SAMPLE;
		return loc3;
	}
	function getElementFromEffect(loc2)
	{
		var loc3 = this.createAudioElement((!dofus.Constants.USING_PACKED_SOUNDS?dofus.Constants.AUDIO_EFFECTS_PATH:dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT) + loc2.f,loc2.s,false,!dofus.Constants.USING_PACKED_SOUNDS?null:dofus.sounds.AudioManager.PACKAGE_TYPE_EFFECT);
		loc3.baseVolume = loc2.v;
		loc3.volume = loc2.v / 100 * this._nEffectVolume;
		loc3.offset = loc2.o;
		loc3.loops = loc2.l != true?dofus.sounds.AudioElement.ONESHOT_SAMPLE:dofus.sounds.AudioElement.INFINITE_LOOP;
		return loc3;
	}
	function getElementFromMusic(loc2)
	{
		var loc3 = this.createAudioElement((!dofus.Constants.USING_PACKED_SOUNDS?dofus.Constants.AUDIO_MUSICS_PATH:dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC) + loc2.f,loc2.s,true,!dofus.Constants.USING_PACKED_SOUNDS?null:dofus.sounds.AudioManager.PACKAGE_TYPE_MUSIC);
		loc3.baseVolume = loc2.v;
		loc3.volume = loc2.v / 100 * this._nMusicVolume;
		loc3.offset = loc2.o;
		loc3.loops = loc2.l != true?dofus.sounds.AudioElement.ONESHOT_SAMPLE:dofus.sounds.AudioElement.INFINITE_LOOP;
		return loc3;
	}
	function nextEnvironmentNoise(loc2)
	{
		_global.clearInterval(this._nEnvironmentNoisesTimer);
		if(loc2 == undefined)
		{
			return undefined;
		}
		var loc3 = (loc2.mind + Math.round(Math.random() * loc2.maxd)) * 1000;
		loc3 = Math.max(10,loc3);
		this._nEnvironmentNoisesTimer = _global.setInterval(this,"onPlayNoise",loc3,loc2);
	}
	function onPlayNoise(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		var loc3 = loc2.n[Math.floor(loc2.n.length * Math.random())];
		this.playEffect(loc3,dofus.sounds.AudioManager.ENVIRONMENT_NOISE_TAG);
		this.nextEnvironmentNoise(loc2);
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
