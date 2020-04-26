class dofus.managers.OptionsManager extends dofus.utils.ApiElement
{
	static var DEFAULT_VALUES = {loaded:true,Grid:false,Transparency:false,SpriteInfos:true,SpriteMove:true,MapInfos:true,AutoHideSmileys:false,StringCourse:true,PointsOverHead:true,ChatEffects:true,CreaturesMode:50,Buff:true,GuildMessageSound:false,BannerShortcuts:true,StartTurnSound:true,TipsOnStart:true,DisplayStyle:"normal",DebugSizeIndex:0,ServerPortIndex:0,MovableBar:false,ViewAllMonsterInGroup:true,MovableBarSize:5,ShortcutSet:1,ShortcutSetDefault:1,CharacterPreview:true,MapFilters:[0,1,1,1,1,1,1],Aura:true,AudioMusicVol:60,AudioEffectVol:100,AudioEnvVol:60,AudioMusicMute:false,AudioEffectMute:false,AudioEnvMute:false,FloatingTipsCoord:new com.ankamagames.types.(415,30),DisplayingFreshTips:true,CensorshipFilter:true,BigStoreSellFilter:false,RememberAccountName:false,LastAccountNameUsed:"",DefaultQuality:"high",ConquestFilter:-2,FightGroupAutoLock:false,BannerIllustrationMode:"artwork",BannerGaugeMode:"xp",AskForWrongCraft:true,AdvancedLineOfSight:true,RemindTurnTime:true,HideSpellBar:false,SeeAllSpell:true,UseSpeakingItems:true,ConfirmDropItem:true,TimestampInChat:true,ViewDicesDammages:false};
	static var _sSelf = null;
	function OptionsManager(loc3)
	{
		super();
		dofus.managers.OptionsManager._sSelf = this;
		this.initialize(loc3);
	}
	static function getInstance()
	{
		return dofus.managers.OptionsManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
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
		var loc2 = this._so.data.language;
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
		this._so.data.language = loc2;
	}
	function setOption(loc2, loc3)
	{
		var loc4 = this.saveValue(loc2,loc3);
		if(this.applyOption(loc2,loc4))
		{
			this.dispatchEvent({type:"optionChanged",key:loc2,value:loc4});
		}
	}
	function getOption(loc2)
	{
		return this.loadValue(loc2);
	}
	function applyAllOptions()
	{
		var loc2 = this._so.data;
		§§enumerate(loc2);
		while((var loc0 = §§enumeration()) != null)
		{
			this.applyOption(k,loc2[k]);
		}
	}
	function saveValue(loc2, loc3)
	{
		var loc4 = this._so.data;
		if(loc3 == undefined)
		{
			if(typeof loc4[loc2] == "boolean")
			{
				loc4[loc2] = !loc4[loc2];
			}
			else
			{
				loc4[loc2] = true;
			}
		}
		else
		{
			loc4[loc2] = loc3;
		}
		this._so.flush();
		return loc4[loc2];
	}
	function loadValue(loc2)
	{
		return this._so.data[loc2];
	}
	function applyOption(loc2, loc3)
	{
		loop0:
		switch(loc2)
		{
			case "Grid":
				if(loc3 == true)
				{
					this.api.gfx.drawGrid();
				}
				else
				{
					this.api.gfx.removeGrid();
				}
				break;
			case "Transparency":
				this.api.gfx.setSpriteGhostView(loc3);
				break;
			case "SpriteInfos":
				if(loc3 == false)
				{
					this.api.ui.unloadUIComponent("SpriteInfos");
					this.setOption("SpriteMove",false);
				}
				break;
			case "SpriteMove":
				if(loc3 == false)
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
						if(loc3 == true)
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
						if(loc3 == false)
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
									case "BannerShortcuts":
									case "TipsOnStart":
									case "DebugSizeIndex":
									case "ServerPortIndex":
									case "ViewAllMonsterInGroup":
										break loop2;
									default:
										switch(null)
										{
											case "Buff":
												if(loc3)
												{
													this.api.ui.loadUIComponent("Buff","Buff");
												}
												else
												{
													this.api.ui.unloadUIComponent("Buff");
												}
												break loop0;
											case "DisplayStyle":
												this.api.kernel.setDisplayStyle(loc3);
												break loop0;
											case "DefaultQuality":
												this.api.kernel.setQuality(loc3);
												break loop0;
											case "MovableBar":
												this.api.ui.getUIComponent("Banner").displayMovableBar(loc3 && (this.api.datacenter.Game.isFight || !this.getOption("HideSpellBar")));
												break loop0;
											default:
												switch(null)
												{
													case "HideSpellBar":
														this.api.ui.getUIComponent("Banner").displayMovableBar(this.getOption("MovableBar") && (this.api.datacenter.Game.isFight || !loc3));
														break loop0;
													case "MovableBarSize":
														this.api.ui.getUIComponent("Banner").setMovableBarSize(loc3);
														break loop0;
													case "ShortcutSet":
														this.api.kernel.KeyManager.onSetChange(loc3);
														break loop0;
													case "CharacterPreview":
														this.api.ui.getUIComponent("Inventory").showCharacterPreview(loc3);
														break loop0;
													case "AudioMusicVol":
														this.api.kernel.AudioManager.musicVolume = loc3;
														break loop0;
													default:
														switch(null)
														{
															case "AudioEffectVol":
																this.api.kernel.AudioManager.effectVolume = loc3;
																break loop0;
															case "AudioEnvVol":
																this.api.kernel.AudioManager.environmentVolume = loc3;
																break loop0;
															case "AudioMusicMute":
																this.api.kernel.AudioManager.musicMute = loc3;
																break loop0;
															case "AudioEffectMute":
																this.api.kernel.AudioManager.effectMute = loc3;
																break loop0;
															default:
																switch(null)
																{
																	case "AudioEnvMute":
																		this.api.kernel.AudioManager.environmentMute = loc3;
																		break;
																	case "TimestampInChat":
																		this.api.kernel.ChatManager.refresh();
																}
														}
												}
										}
								}
							case "PointsOverHead":
							case "ChatEffects":
							case "GuildMessageSound":
							case "StartTurnSound":
						}
				}
		}
		return true;
	}
}
