class dofus.graphics.gapi.ui.Options extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Options";
	static var SCROLL_BY = 20;
	function Options()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Options.CLASS_NAME);
		var var3 = System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1;
		this._eaDisplayStyles = new ank.utils.();
		this._eaDisplayStyles.push({label:this.api.lang.getText("DISPLAYSTYLE_NORMAL"),style:"normal"});
		if(System.capabilities.screenResolutionY > 950 || var3)
		{
			this._eaDisplayStyles.push({label:this.api.lang.getText("DISPLAYSTYLE_MEDIUM" + (!var3?"":"_RES")),style:"medium"});
		}
		this._eaDisplayStyles.push({label:this.api.lang.getText("DISPLAYSTYLE_MAXIMIZED" + (!var3?"":"_RES")),style:"maximized"});
		this._eaFlashQualities = new ank.utils.();
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_LOW"),quality:"low"});
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_MEDIUM"),quality:"medium"});
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_HIGH"),quality:"high"});
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_BEST"),quality:"best"});
		this._eaSpellIconsPacks = new ank.utils.();
		this._eaSpellIconsPacks.push({label:this.api.lang.getText("UI_OPTION_SPELLCOLOR_CLASSIC"),frame:3});
		this._eaSpellIconsPacks.push({label:this.api.lang.getText("UI_OPTION_SPELLCOLOR_REMASTERED"),frame:1});
		this._eaSpellIconsPacks.push({label:this.api.lang.getText("UI_OPTION_SPELLCOLOR_CONTRAST"),frame:2});
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.setCurrentTab,params:["General"]});
	}
	function initTexts()
	{
		this._lblGeneral.text = this.api.lang.getText("OPTIONS_GENERAL");
		this._lblDetailLevel.text = this.api.lang.getText("OPTIONS_DETAILLEVEL");
		this._lblAudio.text = this.api.lang.getText("OPTIONS_AUDIO");
		this._lblOptimize.text = this.api.lang.getText("OPTIONS_OPTIMIZE");
		this._lblDisplay.text = this.api.lang.getText("OPTIONS_DISPLAY");
		this._winBackground.title = this.api.lang.getText("OPTIONS");
		this._btnTabGeneral.label = this.api.lang.getText("OPTIONS_GENERAL");
		this._btnTabSound.label = this.api.lang.getText("OPTIONS_AUDIO");
		this._btnTabDisplay.label = this.api.lang.getText("OPTIONS_DISPLAY");
	}
	function initTabTexts()
	{
		this._mcTabViewer._lblMusic.text = this.api.lang.getText("MUSICS");
		this._mcTabViewer._lblSounds.text = this.api.lang.getText("SOUNDS");
		this._mcTabViewer._lblEnvironment.text = this.api.lang.getText("ENVIRONMENT");
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnDefault.label = this.api.lang.getText("DEFAUT");
		this._mcTabViewer._btnShortcuts.label = this.api.lang.getText("KEYBORD_SHORTCUT");
		this._mcTabViewer._btnClearCache.label = this.api.lang.getText("CLEAR_CACHE");
		this._mcTabViewer._btnResetTips.label = this.api.lang.getText("REINIT_WORD");
		this._mcTabViewer._lblTitleMap.text = this.api.lang.getText("MAP");
		this._mcTabViewer._lblTitleFight.text = this.api.lang.getText("FIGHT");
		this._mcTabViewer._lblTitleSecurity.text = this.api.lang.getText("SECURITY_SHORTCUT");
		this._mcTabViewer._lblTitleUI.text = this.api.lang.getText("INTERFACE_WORD");
		this._mcTabViewer._lblTitleMisc.text = this.api.lang.getText("MISC_WORD");
		this._mcTabViewer._lblTitleOptimiz.text = this.api.lang.getText("OPTIONS_OPTIMIZE");
		this._mcTabViewer._lblTitleScreen.text = this.api.lang.getText("OPTION_TITLE_SCREEN");
		this._mcTabViewer._lblGrid.text = this.api.lang.getText("OPTION_GRID");
		this._mcTabViewer._lblTransparency.text = this.api.lang.getText("OPTION_TRANSPARENCY");
		this._mcTabViewer._lblSpriteInfos.text = this.api.lang.getText("OPTION_SPRITEINFOS");
		this._mcTabViewer._lblSpriteMove.text = this.api.lang.getText("OPTION_SPRITEMOVE");
		this._mcTabViewer._lblMapInfos.text = this.api.lang.getText("OPTION_MAPINFOS");
		this._mcTabViewer._lblAutoHideSmileys.text = this.api.lang.getText("OPTION_AUTOHIDESMILEYS");
		this._mcTabViewer._lblStringCourse.text = this.api.lang.getText("OPTION_STRINGCOURSE");
		this._mcTabViewer._lblPointsOverHead.text = this.api.lang.getText("OPTION_POINTSOVERHEAD");
		this._mcTabViewer._lblChatEffects.text = this.api.lang.getText("OPTION_CHATEFFECTS");
		this._mcTabViewer._lblBuff.text = this.api.lang.getText("OPTION_BUFF");
		this._mcTabViewer._lblAdvancedLineOfSight.text = this.api.lang.getText("OPTION_LINEOFSIGHT");
		this._mcTabViewer._lblRemindTurnTime.text = this.api.lang.getText("OPTION_REMINDTURN");
		this._mcTabViewer._lblHideSpellBar.text = this.api.lang.getText("OPTION_SPELLBAR");
		this._mcTabViewer._lblCraftWrongConfirm.text = this.api.lang.getText("OPTION_WRONG_CRAFT_CONFIRM");
		this._mcTabViewer._lblGuildMessageSound.text = this.api.lang.getText("OPTION_GUILDMESSAGESOUND");
		this._mcTabViewer._lblStartTurnSound.text = this.api.lang.getText("OPTION_STARTTURNSOUND");
		this._mcTabViewer._lblBannerShortcuts.text = this.api.lang.getText("OPTION_BANNERSHORTCUTS");
		this._mcTabViewer._lblTipsOnStart.text = this.api.lang.getText("OPTION_TIPSONSTART");
		this._mcTabViewer._lblCreaturesMode.text = this.api.lang.getText("OPTION_CREATURESMODE");
		this._mcTabViewer._lblDisplayStyle.text = this.api.lang.getText("OPTION_DISPLAYSTYLE");
		this._mcTabViewer._lblMovableBar.text = this.api.lang.getText("OPTION_MOVABLEBAR");
		this._mcTabViewer._lblMovableBarSize.text = this.api.lang.getText("OPTION_MOVABLEBARSIZE");
		this._mcTabViewer._lblSpellBar.text = this.api.lang.getText("OPTION_SPELLBAR");
		this._mcTabViewer._lblViewAllMonsterInGroup.text = this.api.lang.getText("OPTION_VIEWALLMONSTERINGROUP");
		this._mcTabViewer._lblCharacterPreview.text = this.api.lang.getText("OPTION_CHARACTERPREVIEW");
		this._mcTabViewer._lblSeeAllSpell.text = this.api.lang.getText("UI_OPTION_SEEALLSPELL");
		this._mcTabViewer._lblAura.text = this.api.lang.getText("OPTION_AURA");
		this._mcTabViewer._lblTutorialTips.text = this.api.lang.getText("OPTION_TUTORIALTIPS");
		this._mcTabViewer._lblCensorshipFilter.text = this.api.lang.getText("OPTION_CENSORSHIP_FILTER");
		this._mcTabViewer._lblDefaultQuality.text = this.api.lang.getText("OPTION_DEFAULTQUALITY");
		this._mcTabViewer._lblSpeakingItems.text = this.api.lang.getText("OPTION_USE_SPEAKINGITEMS");
		this._mcTabViewer._lblConfirmDropItem.text = this.api.lang.getText("OPTION_CONFIRM_DROPITEM");
		this._mcTabViewer._lblChatTimestamp.text = this.api.lang.getText("OPTION_USE_CHATTIMESTAMP");
		this._mcTabViewer._lblViewDicesDammages.text = this.api.lang.getText("OPTION_VIEW_DICES_DAMMAGES");
		this._mcTabViewer._lblSeeDamagesColor.text = this.api.lang.getText("UI_OPTION_SEEDAMAGESCOLOR");
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			this._mcTabViewer._lblRemasteredSpellIcons.text = this.api.lang.getText("DOFUS_REMASTERED_SPELL_ICONS");
		}
		else
		{
			this._mcTabViewer._lblRemasteredSpellIcons._visible = false;
		}
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._btnDefault.addEventListener("click",this);
		this._btnTabGeneral.addEventListener("click",this);
		this._btnTabSound.addEventListener("click",this);
		this._btnTabDisplay.addEventListener("click",this);
		this.api.kernel.OptionsManager.addEventListener("optionChanged",this);
		ank.utils.MouseEvents.addListener(this);
	}
	function addTabListeners()
	{
		this._mcTabViewer._btnShortcuts.addEventListener("click",this);
		this._mcTabViewer._btnClearCache.addEventListener("click",this);
		this._mcTabViewer._btnGrid.addEventListener("click",this);
		this._mcTabViewer._btnTransparency.addEventListener("click",this);
		this._mcTabViewer._btnSpriteInfos.addEventListener("click",this);
		this._mcTabViewer._btnSpriteMove.addEventListener("click",this);
		this._mcTabViewer._btnMapInfos.addEventListener("click",this);
		this._mcTabViewer._btnAutoHideSmileys.addEventListener("click",this);
		this._mcTabViewer._btnStringCourse.addEventListener("click",this);
		this._mcTabViewer._btnPointsOverHead.addEventListener("click",this);
		this._mcTabViewer._btnChatEffects.addEventListener("click",this);
		this._mcTabViewer._btnBuff.addEventListener("click",this);
		this._mcTabViewer._btnGuildMessageSound.addEventListener("click",this);
		this._mcTabViewer._btnStartTurnSound.addEventListener("click",this);
		this._mcTabViewer._btnBannerShortcuts.addEventListener("click",this);
		this._mcTabViewer._btnTipsOnStart.addEventListener("click",this);
		this._mcTabViewer._btnMovableBar.addEventListener("click",this);
		this._mcTabViewer._btnViewAllMonsterInGroup.addEventListener("click",this);
		this._mcTabViewer._btnCharacterPreview.addEventListener("click",this);
		this._mcTabViewer._btnAura.addEventListener("click",this);
		this._mcTabViewer._btnTutorialTips.addEventListener("click",this);
		this._mcTabViewer._btnResetTips.addEventListener("click",this);
		this._mcTabViewer._btnCensorshipFilter.addEventListener("click",this);
		this._mcTabViewer._btnCraftWrongConfirm.addEventListener("click",this);
		this._mcTabViewer._btnAdvancedLineOfSight.addEventListener("click",this);
		this._mcTabViewer._btnRemindTurnTime.addEventListener("click",this);
		this._mcTabViewer._btnHideSpellBar.addEventListener("click",this);
		this._mcTabViewer._btnSeeAllSpell.addEventListener("click",this);
		this._mcTabViewer._btnSpeakingItems.addEventListener("click",this);
		this._mcTabViewer._btnConfirmDropItem.addEventListener("click",this);
		this._mcTabViewer._btnChatTimestamp.addEventListener("click",this);
		this._mcTabViewer._btnViewDicesDammages.addEventListener("click",this);
		this._mcTabViewer._btnSeeDamagesColor.addEventListener("click",this);
		this._mcTabViewer._cbDisplayStyle.addEventListener("itemSelected",this);
		this._mcTabViewer._cbDefaultQuality.addEventListener("itemSelected",this);
		this._mcTabViewer._cbSpellIconsPack.addEventListener("itemSelected",this);
		this._mcTabViewer._vsMusic.addEventListener("change",this);
		this._mcTabViewer._vsSounds.addEventListener("change",this);
		this._mcTabViewer._vsEnvironment.addEventListener("change",this);
		this._mcTabViewer._vsCreaturesMode.addEventListener("change",this);
		this._mcTabViewer._vsMovableBarSize.addEventListener("change",this);
		this._mcTabViewer._btnMuteMusic.addEventListener("click",this);
		this._mcTabViewer._btnMuteSounds.addEventListener("click",this);
		this._mcTabViewer._btnMuteEnvironment.addEventListener("click",this);
		this._sbOptions.addEventListener("scroll",this);
	}
	function initData()
	{
		this._mcTabViewer._btnShortcuts.enabled = this.api.kernel.XTRA_LANG_FILES_LOADED;
		var var2 = this.api.kernel.OptionsManager;
		this._mcTabViewer._vsMusic.value = var2.getOption("AudioMusicVol");
		this._mcTabViewer._vsSounds.value = var2.getOption("AudioEffectVol");
		this._mcTabViewer._vsEnvironment.value = var2.getOption("AudioEnvVol");
		this._mcTabViewer._btnMuteMusic.selected = var2.getOption("AudioMusicMute");
		this._mcTabViewer._btnMuteSounds.selected = var2.getOption("AudioEffectMute");
		this._mcTabViewer._btnMuteEnvironment.selected = var2.getOption("AudioEnvMute");
		this._mcTabViewer._btnGrid.selected = var2.getOption("Grid");
		this._mcTabViewer._btnTransparency.selected = var2.getOption("Transparency");
		this._mcTabViewer._btnSpriteInfos.selected = var2.getOption("SpriteInfos");
		this._mcTabViewer._btnSpriteMove.selected = var2.getOption("SpriteMove");
		this._mcTabViewer._btnMapInfos.selected = var2.getOption("MapInfos");
		this._mcTabViewer._btnAutoHideSmileys.selected = var2.getOption("AutoHideSmileys");
		this._mcTabViewer._btnStringCourse.selected = var2.getOption("StringCourse");
		this._mcTabViewer._btnPointsOverHead.selected = var2.getOption("PointsOverHead");
		this._mcTabViewer._btnChatEffects.selected = var2.getOption("ChatEffects");
		this._mcTabViewer._btnBuff.selected = var2.getOption("Buff");
		this._mcTabViewer._btnGuildMessageSound.selected = var2.getOption("GuildMessageSound");
		this._mcTabViewer._btnStartTurnSound.selected = var2.getOption("StartTurnSound");
		this._mcTabViewer._btnBannerShortcuts.selected = var2.getOption("BannerShortcuts");
		this._mcTabViewer._btnTipsOnStart.selected = var2.getOption("TipsOnStart");
		this._mcTabViewer._btnViewAllMonsterInGroup.selected = var2.getOption("ViewAllMonsterInGroup");
		this._mcTabViewer._btnCharacterPreview.selected = var2.getOption("CharacterPreview");
		this._mcTabViewer._btnAura.selected = var2.getOption("Aura");
		this._mcTabViewer._btnTutorialTips.selected = var2.getOption("DisplayingFreshTips");
		this._mcTabViewer._btnCensorshipFilter.selected = var2.getOption("CensorshipFilter");
		this._mcTabViewer._btnCraftWrongConfirm.selected = var2.getOption("AskForWrongCraft");
		this._mcTabViewer._btnAdvancedLineOfSight.selected = var2.getOption("AdvancedLineOfSight");
		this._mcTabViewer._btnRemindTurnTime.selected = var2.getOption("RemindTurnTime");
		this._mcTabViewer._btnHideSpellBar.selected = var2.getOption("HideSpellBar");
		this._mcTabViewer._btnSeeAllSpell.selected = !var2.getOption("SeeAllSpell");
		this._mcTabViewer._btnSpeakingItems.selected = var2.getOption("UseSpeakingItems");
		this._mcTabViewer._btnConfirmDropItem.selected = var2.getOption("ConfirmDropItem");
		this._mcTabViewer._btnChatTimestamp.selected = var2.getOption("TimestampInChat");
		this._mcTabViewer._btnViewDicesDammages.selected = var2.getOption("ViewDicesDammages");
		this._mcTabViewer._btnSeeDamagesColor.selected = var2.getOption("SeeDamagesColor");
		this._mcTabViewer._btnMovableBar.selected = var2.getOption("MovableBar");
		this._mcTabViewer._vsMovableBarSize.value = var2.getOption("MovableBarSize");
		this._mcTabViewer._lblMovableBarSizeValue.text = var2.getOption("MovableBarSize");
		this._mcTabViewer._vsCreaturesMode.value = var2.getOption("CreaturesMode");
		this._mcTabViewer._lblCreaturesModeValue.text = !!_global.isFinite(var2.getOption("CreaturesMode"))?var2.getOption("CreaturesMode"):this.api.lang.getText("INFINIT");
		this._mcTabViewer._cbDefaultQuality.dataProvider = this._eaFlashQualities;
		this.selectQuality(var2.getOption("DefaultQuality"));
		this.selectRemasteredSpellIconsPack(var2.getOption("RemasteredSpellIconsPack"));
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			this._mcTabViewer._cbSpellIconsPack.dataProvider = this._eaSpellIconsPacks;
		}
		else
		{
			this._mcTabViewer._cbSpellIconsPack._visible = false;
		}
		this._mcTabViewer._cbDisplayStyle.dataProvider = this._eaDisplayStyles;
		var var3 = System.capabilities.playerType == "PlugIn" || (System.capabilities.playerType == "ActiveX" || System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1);
		this.selectDisplayStyle(!!var3?var2.getOption("DisplayStyle"):"normal");
		this._mcTabViewer._cbDisplayStyle.enabled = var3;
		var var4 = new Color(this._mcTabViewer._cbDisplayStyle);
		var4.setTransform(!var3?{ra:30,rb:149,ga:30,gb:145,ba:30,bb:119}:{ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
	}
	function selectQuality(var2)
	{
		var var3 = 0;
		var var4 = 0;
		while(var4 < this._eaFlashQualities.length)
		{
			if(this._eaFlashQualities[var4].quality == var2)
			{
				var3 = var4;
				break;
			}
			var4 = var4 + 1;
		}
		this._mcTabViewer._cbDefaultQuality.selectedIndex = var3;
	}
	function selectRemasteredSpellIconsPack(var2)
	{
		var var3 = 0;
		var var4 = 0;
		while(var4 < this._eaSpellIconsPacks.length)
		{
			if(this._eaSpellIconsPacks[var4].frame == var2)
			{
				var3 = var4;
				break;
			}
			var4 = var4 + 1;
		}
		this._mcTabViewer._cbSpellIconsPack.selectedIndex = var3;
	}
	function selectDisplayStyle(var2)
	{
		var var3 = 0;
		var var4 = 0;
		while(var4 < this._eaDisplayStyles.length)
		{
			if(this._eaDisplayStyles[var4].style == var2)
			{
				var3 = var4;
				break;
			}
			var4 = var4 + 1;
		}
		this._mcTabViewer._cbDisplayStyle.selectedIndex = var3;
	}
	function updateCurrentTabInformations()
	{
		this._mcTabViewer.removeMovieClip();
		this.attachMovie("Options" + this._sCurrentTab + "Content","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
		this._mcTabViewer.setMask(this._mcMask);
		if(this._mcTabViewer._height > this._mcPlacer._height)
		{
			this._sbOptions._visible = true;
			this._sbOptions.min = 0;
			this._sbOptions.max = this._mcTabViewer._height - this._mcPlacer._height;
			this._sbOptions.page = this._sbOptions.max / 2;
		}
		else
		{
			this._sbOptions._visible = false;
		}
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTabTexts});
		this.addToQueue({object:this,method:this.addTabListeners});
	}
	function setCurrentTab(var2)
	{
		this._mcComboBoxPopup.removeMovieClip();
		var var3 = this["_btnTab" + this._sCurrentTab];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		var4.enabled = false;
		this._sCurrentTab = var2;
		this._sbOptions.scrollPosition = 0;
		this.updateCurrentTabInformations();
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnTabGeneral":
			case "_btnTabSound":
			case "_btnTabDisplay":
				this.setCurrentTab(var2.target._name.substr(7));
				break;
			default:
				switch(null)
				{
					case "_btnMuteMusic":
						this.api.kernel.OptionsManager.setOption("AudioMusicMute",var2.target.selected);
						break loop0;
					case "_btnMuteSounds":
						this.api.kernel.OptionsManager.setOption("AudioEffectMute",var2.target.selected);
						break loop0;
					case "_btnMuteEnvironment":
						this.api.kernel.OptionsManager.setOption("AudioEnvMute",var2.target.selected);
						break loop0;
					case "_btnClose":
					case "_btnClose2":
						this.callClose();
						break loop0;
					default:
						switch(null)
						{
							case "_btnDefault":
								this.api.kernel.OptionsManager.loadDefault();
								break loop0;
							case "_btnShortcuts":
								this.api.ui.loadUIComponent("Shortcuts","Shortcuts",undefined,{bAlwaysOnTop:true});
								break loop0;
							case "_btnClearCache":
								this.api.kernel.askClearCache();
								break loop0;
							case "_btnGrid":
								this.api.kernel.OptionsManager.setOption("Grid",var2.target.selected);
								break loop0;
							case "_btnTransparency":
								this.api.kernel.OptionsManager.setOption("Transparency",var2.target.selected);
								break loop0;
							default:
								switch(null)
								{
									case "_btnSpriteInfos":
										this.api.kernel.OptionsManager.setOption("SpriteInfos",var2.target.selected);
										break loop0;
									case "_btnSpriteMove":
										this.api.kernel.OptionsManager.setOption("SpriteMove",var2.target.selected);
										break loop0;
									case "_btnMapInfos":
										this.api.kernel.OptionsManager.setOption("MapInfos",var2.target.selected);
										break loop0;
									case "_btnCraftWrongConfirm":
										this.api.kernel.OptionsManager.setOption("AskForWrongCraft",var2.target.selected);
										break loop0;
									case "_btnAutoHideSmileys":
										this.api.kernel.OptionsManager.setOption("AutoHideSmileys",var2.target.selected);
										break loop0;
									default:
										switch(null)
										{
											case "_btnStringCourse":
												this.api.kernel.OptionsManager.setOption("StringCourse",var2.target.selected);
												break loop0;
											case "_btnPointsOverHead":
												this.api.kernel.OptionsManager.setOption("PointsOverHead",var2.target.selected);
												break loop0;
											case "_btnChatEffects":
												this.api.kernel.OptionsManager.setOption("ChatEffects",var2.target.selected);
												break loop0;
											case "_btnBuff":
												this.api.kernel.OptionsManager.setOption("Buff",var2.target.selected);
												break loop0;
											case "_btnGuildMessageSound":
												this.api.kernel.OptionsManager.setOption("GuildMessageSound",var2.target.selected);
												break loop0;
											default:
												switch(null)
												{
													case "_btnStartTurnSound":
														this.api.kernel.OptionsManager.setOption("StartTurnSound",var2.target.selected);
														break loop0;
													case "_btnBannerShortcuts":
														this.api.kernel.OptionsManager.setOption("BannerShortcuts",var2.target.selected);
														break loop0;
													case "_btnTipsOnStart":
														this.api.kernel.OptionsManager.setOption("TipsOnStart",var2.target.selected);
														break loop0;
													case "_btnMovableBar":
														this.api.kernel.OptionsManager.setOption("MovableBar",var2.target.selected);
														break loop0;
													case "_btnViewAllMonsterInGroup":
														this.api.kernel.OptionsManager.setOption("ViewAllMonsterInGroup",var2.target.selected);
														break loop0;
													default:
														switch(null)
														{
															case "_btnCharacterPreview":
																this.api.kernel.OptionsManager.setOption("CharacterPreview",var2.target.selected);
																break loop0;
															case "_btnAura":
																this.api.kernel.OptionsManager.setOption("Aura",var2.target.selected);
																break loop0;
															case "_btnTutorialTips":
																this.api.kernel.OptionsManager.setOption("DisplayingFreshTips",var2.target.selected);
																break loop0;
															case "_btnResetTips":
																this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_RESET_TIPS"),"CAUTION_YESNO",{name:"ResetTips",listener:this});
																break loop0;
															case "_btnCensorshipFilter":
																this.api.kernel.OptionsManager.setOption("CensorshipFilter",var2.target.selected);
																break loop0;
															case "_btnAdvancedLineOfSight":
																this.api.kernel.OptionsManager.setOption("AdvancedLineOfSight",var2.target.selected);
																break loop0;
															default:
																switch(null)
																{
																	case "_btnRemindTurnTime":
																		this.api.kernel.OptionsManager.setOption("RemindTurnTime",var2.target.selected);
																		break loop0;
																	case "_btnHideSpellBar":
																		this.api.kernel.OptionsManager.setOption("HideSpellBar",var2.target.selected);
																		break loop0;
																	case "_btnSeeAllSpell":
																		this.api.kernel.OptionsManager.setOption("SeeAllSpell",!var2.target.selected);
																		break loop0;
																	case "_btnSpeakingItems":
																		this.api.kernel.OptionsManager.setOption("UseSpeakingItems",var2.target.selected);
																		break loop0;
																	default:
																		switch(null)
																		{
																			case "_btnConfirmDropItem":
																				this.api.kernel.OptionsManager.setOption("ConfirmDropItem",var2.target.selected);
																				break;
																			case "_btnChatTimestamp":
																				this.api.kernel.OptionsManager.setOption("TimestampInChat",var2.target.selected);
																				this.api.kernel.ChatManager.refresh();
																				break;
																			case "_btnViewDicesDammages":
																				this.api.kernel.OptionsManager.setOption("ViewDicesDammages",var2.target.selected);
																				break;
																			case "_btnSeeDamagesColor":
																				this.api.kernel.OptionsManager.setOption("SeeDamagesColor",var2.target.selected);
																		}
																}
														}
												}
										}
								}
						}
				}
		}
	}
	function change(var2)
	{
		switch(var2.target._name)
		{
			case "_vsMusic":
				this.api.kernel.OptionsManager.setOption("AudioMusicVol",var2.target.value);
				break;
			case "_vsSounds":
				this.api.kernel.OptionsManager.setOption("AudioEffectVol",var2.target.value);
				break;
			default:
				switch(null)
				{
					case "_vsEnvironment":
						this.api.kernel.OptionsManager.setOption("AudioEnvVol",var2.target.value);
						break;
					case "_vsCreaturesMode":
						if(var2.target.value == var2.target.max)
						{
							this.api.kernel.OptionsManager.setOption("CreaturesMode",Number.POSITIVE_INFINITY);
						}
						else if(var2.target.value == var2.target.min)
						{
							this.api.kernel.OptionsManager.setOption("CreaturesMode",0);
						}
						else
						{
							this.api.kernel.OptionsManager.setOption("CreaturesMode",Math.floor(var2.target.value));
						}
						break;
					case "_vsMovableBarSize":
						var var3 = Math.floor(var2.target.value);
						this.api.kernel.OptionsManager.setOption("MovableBarSize",var3);
						this._mcTabViewer._lblMovableBarSizeValue.text = var3.toString();
				}
		}
	}
	function optionChanged(var2)
	{
		loop0:
		switch(var2.key)
		{
			case "Grid":
				this._mcTabViewer._btnGrid.selected = var2.value;
				break;
			case "Transparency":
				this._mcTabViewer._btnTransparency.selected = var2.value;
				break;
			case "SpriteInfos":
				this._mcTabViewer._btnSpriteInfos.selected = var2.value;
				break;
			default:
				switch(null)
				{
					case "SpriteMove":
						this._mcTabViewer._btnSpriteMove.selected = var2.value;
						break loop0;
					case "MapInfos":
						this._mcTabViewer._btnMapInfos.selected = var2.value;
						break loop0;
					case "AutoHideSmileys":
						this._mcTabViewer._btnAutoHideSmileys.selected = var2.value;
						break loop0;
					case "StringCourse":
						this._mcTabViewer._btnStringCourse.selected = var2.value;
						break loop0;
					case "PointsOverHead":
						this._mcTabViewer._btnPointsOverHead.selected = var2.value;
						break loop0;
					case "ChatEffects":
						this._mcTabViewer._btnChatEffects.selected = var2.value;
						break loop0;
					default:
						switch(null)
						{
							case "CreaturesMode":
								this._mcTabViewer._vsCreaturesMode.value = var2.value;
								this._mcTabViewer._lblCreaturesModeValue.text = !_global.isFinite(var2.value)?this.api.lang.getText("INFINIT"):var2.value;
								break loop0;
							case "Buff":
								this._mcTabViewer._btnBuff.selected = var2.value;
								break loop0;
							case "GuildMessageSound":
								this._mcTabViewer._btnGuildMessageSound.selected = var2.value;
								break loop0;
							case "StartTurnSound":
								this._mcTabViewer._btnStartTurnSound.selected = var2.value;
								break loop0;
							case "BannerShortcuts":
								this._mcTabViewer._btnBannerShortcuts.selected = var2.value;
								break loop0;
							default:
								switch(null)
								{
									case "TipsOnStart":
										this._mcTabViewer._btnTipsOnStart.selected = var2.value;
										break loop0;
									case "DisplayStyle":
										this._mcTabViewer.selectDisplayStyle(var2.value);
										break loop0;
									case "MovableBar":
										this._mcTabViewer._btnMovableBar.selected = var2.value;
										break loop0;
									case "MovableBarSize":
										this._mcTabViewer._vsMovableBarSize.value = var2.value;
										break loop0;
									case "ViewAllMonsterInGroup":
										this._mcTabViewer._btnViewAllMonsterInGroup.selected = var2.value;
										break loop0;
									default:
										switch(null)
										{
											case "CharacterPreview":
												this._mcTabViewer._btnCharacterPreview.selected = var2.value;
												break loop0;
											case "Aura":
												this._mcTabViewer._btnAura.selected = var2.value;
												break loop0;
											case "DisplayingFreshTips":
												this._mcTabViewer._btnTutorialTips.selected = var2.value;
												break loop0;
											case "CensorshipFilter":
												this._mcTabViewer._btnCensorshipFilter.selected = var2.value;
												break loop0;
											default:
												switch(null)
												{
													case "AskForWrongCraft":
														this._mcTabViewer._btnCraftWrongConfirm.selected = var2.value;
														break loop0;
													case "AdvancedLineOfSight":
														this._mcTabViewer._btnAdvancedLineOfSight.selected = var2.value;
														break loop0;
													case "RemindTurnTime":
														this._mcTabViewer._btnRemindTurnTime.selected = var2.value;
														break loop0;
													case "HideSpellBar":
														this._mcTabViewer._btnHideSpellBar.selected = var2.value;
														break loop0;
													case "SeeAllSpell":
														this._mcTabViewer._btnSeeAllSpell.selected = !var2.value;
														break loop0;
													default:
														switch(null)
														{
															case "UseSpeakingItems":
																this._mcTabViewer._btnSpeakingItems.selected = var2.value;
																break loop0;
															case "ConfirmDropItem":
																this._mcTabViewer._btnConfirmDropItem.selected = var2.value;
																break loop0;
															case "TimestampInChat":
																this._mcTabViewer._btnChatTimestamp.selected = var2.value;
																this.api.kernel.ChatManager.refresh();
																break loop0;
															case "AudioMusicMute":
																this._mcTabViewer._btnMuteMusic.selected = var2.value;
																break loop0;
															case "AudioEffectMute":
																this._mcTabViewer._btnMuteSounds.selected = var2.value;
																break loop0;
															default:
																if(var0 !== "AudioEnvMute")
																{
																	break loop0;
																}
																this._mcTabViewer._btnMuteEnvironment.selected = var2.value;
																break loop0;
														}
												}
										}
								}
						}
				}
		}
	}
	function itemSelected(var2)
	{
		switch(var2.target._name)
		{
			case "_cbDisplayStyle":
				var var3 = var2.target.selectedItem;
				if(var3.style == "normal")
				{
					this.api.kernel.OptionsManager.setOption("DisplayStyle",var3.style);
				}
				else
				{
					this.api.kernel.showMessage(this.api.lang.getText("OPTIONS_DISPLAY"),this.api.lang.getText("DO_U_CHANGE_DISPLAYSTYLE"),"CAUTION_YESNO",{name:"Display",listener:this,params:{style:var3.style}});
				}
				break;
			case "_cbDefaultQuality":
				var var4 = var2.target.selectedItem;
				this.api.kernel.showMessage(this.api.lang.getText("OPTIONS_DISPLAY"),this.api.lang.getText("DO_U_CHANGE_QUALITY_" + String(var4.quality).toUpperCase()),"CAUTION_YESNO",{name:"Quality",listener:this,params:{quality:var4.quality}});
				break;
			case "_cbSpellIconsPack":
				var var5 = var2.target.selectedItem;
				var var6 = var5.frame;
				var var7 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
				if(var7 == var6)
				{
					break;
				}
				this.api.kernel.OptionsManager.setOption("RemasteredSpellIconsPack",var6);
				this.selectRemasteredSpellIconsPack(var6);
				var var8 = (dofus.graphics.gapi.ui.Banner)this.gapi.getUIComponent("Banner");
				if(var8 != undefined)
				{
					var8.shortcuts.updateSpells();
				}
				var var9 = (dofus.graphics.gapi.ui.Spells)this.gapi.getUIComponent("Spells");
				if(var9 != undefined)
				{
					var9.updateSpells();
					var var10 = var9.spellFullInfosViewer;
					if(var10 != undefined)
					{
						var10.updateData();
					}
				}
				var var11 = (dofus.graphics.gapi.ui.SpellViewerOnCreate)this.gapi.getUIComponent("SpellViewerOnCreate");
				if(var11 != undefined)
				{
					var11.refreshSpellsPack();
					break;
				}
				break;
		}
	}
	function yes(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoDisplay":
				this.api.kernel.OptionsManager.setOption("DisplayStyle",var2.target.params.style);
				break;
			case "AskYesNoResetTips":
				dofus.managers.TipsManager.getInstance().resetDisplayedTipsList();
				break;
			default:
				if(var0 !== "AskYesNoQuality")
				{
					break;
				}
				this.api.kernel.OptionsManager.setOption("DefaultQuality",var2.target.params.quality);
				break;
		}
	}
	function no(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoDisplay":
				this.selectDisplayStyle(this.api.kernel.OptionsManager.getOption("DisplayStyle"));
				break;
			case "AskYesNoQuality":
				this.selectQuality(this.api.kernel.OptionsManager.getOption("DefaultQuality"));
		}
	}
	function scroll(var2)
	{
		this._mcTabViewer._y = this._mcPlacer._y - this._sbOptions.scrollPosition;
	}
	function onMouseWheel(var2, var3)
	{
		if(dofus.graphics.gapi.ui.Zoom.isZooming())
		{
			return undefined;
		}
		if(String(var3._target).indexOf(this._target) != -1 && this._sbOptions._visible)
		{
			this._sbOptions.scrollPosition = this._sbOptions.scrollPosition - (var2 <= 0?- dofus.graphics.gapi.ui.Options.SCROLL_BY:dofus.graphics.gapi.ui.Options.SCROLL_BY);
		}
	}
}
