class dofus.managers.OptionsManager extends dofus.utils.ApiElement
{
	static var DEFAULT_VALUES = {loaded:true,Grid:false,Transparency:false,SpriteInfos:true,SpriteMove:true,MapInfos:true,AutoHideSmileys:false,StringCourse:true,PointsOverHead:true,ChatEffects:true,CreaturesMode:50,Buff:true,GuildMessageSound:false,BannerShortcuts:true,StartTurnSound:true,TipsOnStart:true,DisplayStyle:"normal",DebugSizeIndex:0,ServerPortIndex:0,MovableBar:false,ViewAllMonsterInGroup:true,MovableBarSize:5,ShortcutSet:1,ShortcutSetDefault:1,CharacterPreview:true,MapFilters:[0,1,1,1,1,1,1],Aura:true,AudioMusicVol:60,AudioEffectVol:100,AudioEnvVol:60,AudioMusicMute:false,AudioEffectMute:false,AudioEnvMute:false,FloatingTipsCoord:new com.ankamagames.types.(415,30),DisplayingFreshTips:true,CensorshipFilter:true,BigStoreSellFilter:false,RememberAccountName:false,LastAccountNameUsed:"",DefaultQuality:"high",ConquestFilter:-2,FightGroupAutoLock:false,BannerIllustrationMode:"artwork",BannerGaugeMode:"xp",AskForWrongCraft:true,AdvancedLineOfSight:true,RemindTurnTime:true,HideSpellBar:false,SeeAllSpell:true,UseSpeakingItems:true,ConfirmDropItem:true,TimestampInChat:true,ViewDicesDammages:false,SeeDamagesColor:true,RemasteredSpellIconsPack:1};
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
		eval(mx).events.EventDispatcher.initialize(this);
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
		var var2 = this._so.data.language;
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
		this._so.data.language = var2;
		this._so.flush();
	}
	function setOption(var2, var3)
	{
		var var4 = this.saveValue(var2,var3);
		if(this.applyOption(var2,var4))
		{
			this.dispatchEvent({type:"optionChanged",key:var2,value:var4});
		}
	}
	function getOption(var2)
	{
		return this.loadValue(var2);
	}
	function applyAllOptions()
	{
		var var2 = this._so.data;
		for(var k in var2)
		{
			var var3 = false;
			if((var var0 = k) === "ShortcutSet")
			{
				var3 = true;
			}
			if(!var3)
			{
				this.applyOption(k,var2[k]);
			}
		}
	}
	function saveValue(var2, var3)
	{
		var var4 = this._so.data;
		if(var3 == undefined)
		{
			if(typeof var4[var2] == "boolean")
			{
				var4[var2] = !var4[var2];
			}
			else
			{
				var4[var2] = true;
			}
		}
		else
		{
			var4[var2] = var3;
		}
		this._so.flush();
		return var4[var2];
	}
	function loadValue(var2)
	{
		return this._so.data[var2];
	}
	function applyOption(var2, var3)
	{
		loop0:
		switch(var2)
		{
			case "Grid":
				if(var3 == true)
				{
					this.api.gfx.drawGrid();
				}
				else
				{
					this.api.gfx.removeGrid();
				}
				break;
			case "Transparency":
				this.api.gfx.setSpriteGhostView(var3);
				break;
			case "SpriteInfos":
				if(var3 == false)
				{
					this.api.ui.unloadUIComponent("SpriteInfos");
					this.setOption("SpriteMove",false);
				}
				break;
			case "SpriteMove":
				if(var3 == false)
				{
					this.api.gfx.clearZoneLayer("move");
				}
				else if(this.loadValue("SpriteInfos") == false)
				{
					this.setOption("SpriteInfos",true);
				}
				break;
			default:
				switch(null)
				{
					case "MapInfos":
						if(var3 == true)
						{
							this.api.ui.loadUIComponent("MapInfos","MapInfos",undefined,{bForceLoad:true});
						}
						else
						{
							this.api.ui.unloadUIComponent("MapInfos");
						}
						break loop0;
					case "AutoHideSmiley":
						break loop0;
					case "StringCourse":
						if(var3 == false)
						{
							this.api.ui.unloadUIComponent("StringCourse");
						}
						break loop0;
					case "CreaturesMode":
						this.api.kernel.GameManager.applyCreatureMode();
						break loop0;
					default:
						loop2:
						switch(null)
						{
							default:
								switch(null)
								{
									case "DebugSizeIndex":
									case "ServerPortIndex":
									case "ViewAllMonsterInGroup":
										break loop2;
									case "Buff":
										if(var3)
										{
											this.api.ui.loadUIComponent("Buff","Buff");
										}
										else
										{
											this.api.ui.unloadUIComponent("Buff");
										}
										break loop0;
									default:
										switch(null)
										{
											case "DisplayStyle":
												this.api.kernel.setDisplayStyle(var3);
												break loop0;
											case "DefaultQuality":
												this.api.kernel.setQuality(var3);
												break loop0;
											case "MovableBar":
												this.api.ui.getUIComponent("Banner").displayMovableBar(var3 && (this.api.datacenter.Game.isFight || !this.getOption("HideSpellBar")));
												break loop0;
											case "HideSpellBar":
												this.api.ui.getUIComponent("Banner").displayMovableBar(this.getOption("MovableBar") && (this.api.datacenter.Game.isFight || !var3));
												break loop0;
											case "MovableBarSize":
												this.api.ui.getUIComponent("Banner").setMovableBarSize(var3);
												break loop0;
											default:
												switch(null)
												{
													case "ShortcutSet":
														this.api.kernel.KeyManager.onSetChange(var3);
														break loop0;
													case "CharacterPreview":
														this.api.ui.getUIComponent("Inventory").showCharacterPreview(var3);
														break loop0;
													case "AudioMusicVol":
														this.api.kernel.AudioManager.musicVolume = var3;
														break loop0;
													case "AudioEffectVol":
														this.api.kernel.AudioManager.effectVolume = var3;
														break loop0;
													case "AudioEnvVol":
														this.api.kernel.AudioManager.environmentVolume = var3;
														break loop0;
													default:
														switch(null)
														{
															case "AudioMusicMute":
																this.api.kernel.AudioManager.musicMute = var3;
																break;
															case "AudioEffectMute":
																this.api.kernel.AudioManager.effectMute = var3;
																break;
															case "AudioEnvMute":
																this.api.kernel.AudioManager.environmentMute = var3;
																break;
															case "TimestampInChat":
																this.api.kernel.ChatManager.refresh();
														}
												}
										}
								}
							case "ChatEffects":
							case "GuildMessageSound":
							case "StartTurnSound":
							case "BannerShortcuts":
							case "TipsOnStart":
						}
					case "PointsOverHead":
				}
		}
		return true;
	}
}
