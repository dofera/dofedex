class dofus.sounds.AudioEvents
{
	function AudioEvents()
	{
	}
	static function getInstance()
	{
		if(dofus.sounds.AudioEvents.instance == null)
		{
			dofus.sounds.AudioEvents.instance = new dofus.sounds.();
		}
		dofus.sounds.AudioEvents.api = _global.API;
		return dofus.sounds.AudioEvents.instance;
	}
	function getAudioManager()
	{
		return dofus.sounds.AudioManager.getInstance();
	}
	function onGameStart(§\x1e\x06§)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		var var3 = Math.floor(Math.random() * var2.length);
		this.getAudioManager().playMusic(var2[var3],false,true);
	}
	function onGameEnd()
	{
	}
	function onTurnStart()
	{
		if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
		{
			this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("TURN_START"),undefined,true);
		}
	}
	function onGameInvitation()
	{
		if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
		{
			this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"),undefined,true);
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
			this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("TAK"),undefined,true);
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
			this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"),undefined,true);
		}
	}
	function onTaxcollectorAttack()
	{
		if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
		{
			this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLANG"),undefined,true);
		}
	}
	function onError()
	{
		if(dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
		{
			this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("ERROR"),undefined,true);
		}
	}
	function onEnterVillage()
	{
	}
}
