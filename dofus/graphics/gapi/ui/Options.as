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
		var loc3 = System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1;
		this._eaDisplayStyles = new ank.utils.();
		this._eaDisplayStyles.push({label:this.api.lang.getText("DISPLAYSTYLE_NORMAL"),style:"normal"});
		if(System.capabilities.screenResolutionY > 950 || loc3)
		{
			this._eaDisplayStyles.push({label:this.api.lang.getText("DISPLAYSTYLE_MEDIUM" + (!loc3?"":"_RES")),style:"medium"});
		}
		this._eaDisplayStyles.push({label:this.api.lang.getText("DISPLAYSTYLE_MAXIMIZED" + (!loc3?"":"_RES")),style:"maximized"});
		this._eaFlashQualities = new ank.utils.();
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_LOW"),quality:"low"});
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_MEDIUM"),quality:"medium"});
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_HIGH"),quality:"high"});
		this._eaFlashQualities.push({label:this.api.lang.getText("QUALITY_BEST"),quality:"best"});
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
		this._mcTabViewer._cbDisplayStyle.addEventListener("itemSelected",this);
		this._mcTabViewer._cbDefaultQuality.addEventListener("itemSelected",this);
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
		this._mcTabViewer._btnShortcuts.enabled = this.api.ui.getUIComponent("Banner") != undefined;
		var loc2 = this.api.kernel.OptionsManager;
		this._mcTabViewer._vsMusic.value = loc2.getOption("AudioMusicVol");
		this._mcTabViewer._vsSounds.value = loc2.getOption("AudioEffectVol");
		this._mcTabViewer._vsEnvironment.value = loc2.getOption("AudioEnvVol");
		this._mcTabViewer._btnMuteMusic.selected = loc2.getOption("AudioMusicMute");
		this._mcTabViewer._btnMuteSounds.selected = loc2.getOption("AudioEffectMute");
		this._mcTabViewer._btnMuteEnvironment.selected = loc2.getOption("AudioEnvMute");
		this._mcTabViewer._btnGrid.selected = loc2.getOption("Grid");
		this._mcTabViewer._btnTransparency.selected = loc2.getOption("Transparency");
		this._mcTabViewer._btnSpriteInfos.selected = loc2.getOption("SpriteInfos");
		this._mcTabViewer._btnSpriteMove.selected = loc2.getOption("SpriteMove");
		this._mcTabViewer._btnMapInfos.selected = loc2.getOption("MapInfos");
		this._mcTabViewer._btnAutoHideSmileys.selected = loc2.getOption("AutoHideSmileys");
		this._mcTabViewer._btnStringCourse.selected = loc2.getOption("StringCourse");
		this._mcTabViewer._btnPointsOverHead.selected = loc2.getOption("PointsOverHead");
		this._mcTabViewer._btnChatEffects.selected = loc2.getOption("ChatEffects");
		this._mcTabViewer._btnBuff.selected = loc2.getOption("Buff");
		this._mcTabViewer._btnGuildMessageSound.selected = loc2.getOption("GuildMessageSound");
		this._mcTabViewer._btnStartTurnSound.selected = loc2.getOption("StartTurnSound");
		this._mcTabViewer._btnBannerShortcuts.selected = loc2.getOption("BannerShortcuts");
		this._mcTabViewer._btnTipsOnStart.selected = loc2.getOption("TipsOnStart");
		this._mcTabViewer._btnViewAllMonsterInGroup.selected = loc2.getOption("ViewAllMonsterInGroup");
		this._mcTabViewer._btnCharacterPreview.selected = loc2.getOption("CharacterPreview");
		this._mcTabViewer._btnAura.selected = loc2.getOption("Aura");
		this._mcTabViewer._btnTutorialTips.selected = loc2.getOption("DisplayingFreshTips");
		this._mcTabViewer._btnCensorshipFilter.selected = loc2.getOption("CensorshipFilter");
		this._mcTabViewer._btnCraftWrongConfirm.selected = loc2.getOption("AskForWrongCraft");
		this._mcTabViewer._btnAdvancedLineOfSight.selected = loc2.getOption("AdvancedLineOfSight");
		this._mcTabViewer._btnRemindTurnTime.selected = loc2.getOption("RemindTurnTime");
		this._mcTabViewer._btnHideSpellBar.selected = loc2.getOption("HideSpellBar");
		this._mcTabViewer._btnSeeAllSpell.selected = !loc2.getOption("SeeAllSpell");
		this._mcTabViewer._btnSpeakingItems.selected = loc2.getOption("UseSpeakingItems");
		this._mcTabViewer._btnConfirmDropItem.selected = loc2.getOption("ConfirmDropItem");
		this._mcTabViewer._btnChatTimestamp.selected = loc2.getOption("TimestampInChat");
		this._mcTabViewer._btnViewDicesDammages.selected = loc2.getOption("ViewDicesDammages");
		this._mcTabViewer._btnMovableBar.selected = loc2.getOption("MovableBar");
		this._mcTabViewer._vsMovableBarSize.value = loc2.getOption("MovableBarSize");
		this._mcTabViewer._lblMovableBarSizeValue.text = loc2.getOption("MovableBarSize");
		this._mcTabViewer._vsCreaturesMode.value = loc2.getOption("CreaturesMode");
		this._mcTabViewer._lblCreaturesModeValue.text = !!_global.isFinite(loc2.getOption("CreaturesMode"))?loc2.getOption("CreaturesMode"):this.api.lang.getText("INFINIT");
		this._mcTabViewer._cbDefaultQuality.dataProvider = this._eaFlashQualities;
		this.selectQuality(loc2.getOption("DefaultQuality"));
		this._mcTabViewer._cbDisplayStyle.dataProvider = this._eaDisplayStyles;
		var loc3 = System.capabilities.playerType == "PlugIn" || (System.capabilities.playerType == "ActiveX" || System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1);
		this.selectDisplayStyle(!!loc3?loc2.getOption("DisplayStyle"):"normal");
		this._mcTabViewer._cbDisplayStyle.enabled = loc3;
		var loc4 = new Color(this._mcTabViewer._cbDisplayStyle);
		loc4.setTransform(!loc3?{ra:30,rb:149,ga:30,gb:145,ba:30,bb:119}:{ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
	}
	function selectQuality(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		while(loc4 < this._eaFlashQualities.length)
		{
			if(this._eaFlashQualities[loc4].quality == loc2)
			{
				loc3 = loc4;
				break;
			}
			loc4 = loc4 + 1;
		}
		this._mcTabViewer._cbDefaultQuality.selectedIndex = loc3;
	}
	function selectDisplayStyle(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		while(loc4 < this._eaDisplayStyles.length)
		{
			if(this._eaDisplayStyles[loc4].style == loc2)
			{
				loc3 = loc4;
				break;
			}
			loc4 = loc4 + 1;
		}
		this._mcTabViewer._cbDisplayStyle.selectedIndex = loc3;
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
	function setCurrentTab(loc2)
	{
		this._mcComboBoxPopup.removeMovieClip();
		var loc3 = this["_btnTab" + this._sCurrentTab];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		loc4.enabled = false;
		this._sCurrentTab = loc2;
		this._sbOptions.scrollPosition = 0;
		this.updateCurrentTabInformations();
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target._name)
		{
			case "_btnTabGeneral":
			case "_btnTabSound":
			case "_btnTabDisplay":
				this.setCurrentTab(loc2.target._name.substr(7));
				break;
			default:
				switch(null)
				{
					case "_btnMuteMusic":
						this.api.kernel.OptionsManager.setOption("AudioMusicMute",loc2.target.selected);
						break loop0;
					case "_btnMuteSounds":
						this.api.kernel.OptionsManager.setOption("AudioEffectMute",loc2.target.selected);
						break loop0;
					case "_btnMuteEnvironment":
						this.api.kernel.OptionsManager.setOption("AudioEnvMute",loc2.target.selected);
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
								this.api.kernel.OptionsManager.setOption("Grid",loc2.target.selected);
								break loop0;
							case "_btnTransparency":
								this.api.kernel.OptionsManager.setOption("Transparency",loc2.target.selected);
								break loop0;
							default:
								switch(null)
								{
									case "_btnSpriteInfos":
										this.api.kernel.OptionsManager.setOption("SpriteInfos",loc2.target.selected);
										break loop0;
									case "_btnSpriteMove":
										this.api.kernel.OptionsManager.setOption("SpriteMove",loc2.target.selected);
										break loop0;
									case "_btnMapInfos":
										this.api.kernel.OptionsManager.setOption("MapInfos",loc2.target.selected);
										break loop0;
									case "_btnCraftWrongConfirm":
										this.api.kernel.OptionsManager.setOption("AskForWrongCraft",loc2.target.selected);
										break loop0;
									case "_btnAutoHideSmileys":
										this.api.kernel.OptionsManager.setOption("AutoHideSmileys",loc2.target.selected);
										break loop0;
									default:
										switch(null)
										{
											case "_btnStringCourse":
												this.api.kernel.OptionsManager.setOption("StringCourse",loc2.target.selected);
												break loop0;
											case "_btnPointsOverHead":
												this.api.kernel.OptionsManager.setOption("PointsOverHead",loc2.target.selected);
												break loop0;
											case "_btnChatEffects":
												this.api.kernel.OptionsManager.setOption("ChatEffects",loc2.target.selected);
												break loop0;
											case "_btnBuff":
												this.api.kernel.OptionsManager.setOption("Buff",loc2.target.selected);
												break loop0;
											default:
												switch(null)
												{
													case "_btnGuildMessageSound":
														this.api.kernel.OptionsManager.setOption("GuildMessageSound",loc2.target.selected);
														break loop0;
													case "_btnStartTurnSound":
														this.api.kernel.OptionsManager.setOption("StartTurnSound",loc2.target.selected);
														break loop0;
													case "_btnBannerShortcuts":
														this.api.kernel.OptionsManager.setOption("BannerShortcuts",loc2.target.selected);
														break loop0;
													case "_btnTipsOnStart":
														this.api.kernel.OptionsManager.setOption("TipsOnStart",loc2.target.selected);
														break loop0;
													case "_btnMovableBar":
														this.api.kernel.OptionsManager.setOption("MovableBar",loc2.target.selected);
														break loop0;
													default:
														switch(null)
														{
															case "_btnViewAllMonsterInGroup":
																this.api.kernel.OptionsManager.setOption("ViewAllMonsterInGroup",loc2.target.selected);
																break loop0;
															case "_btnCharacterPreview":
																this.api.kernel.OptionsManager.setOption("CharacterPreview",loc2.target.selected);
																break loop0;
															case "_btnAura":
																this.api.kernel.OptionsManager.setOption("Aura",loc2.target.selected);
																break loop0;
															case "_btnTutorialTips":
																this.api.kernel.OptionsManager.setOption("DisplayingFreshTips",loc2.target.selected);
																break loop0;
															case "_btnResetTips":
																this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_RESET_TIPS"),"CAUTION_YESNO",{name:"ResetTips",listener:this});
																break loop0;
															default:
																switch(null)
																{
																	case "_btnCensorshipFilter":
																		this.api.kernel.OptionsManager.setOption("CensorshipFilter",loc2.target.selected);
																		break loop0;
																	case "_btnAdvancedLineOfSight":
																		this.api.kernel.OptionsManager.setOption("AdvancedLineOfSight",loc2.target.selected);
																		break loop0;
																	case "_btnRemindTurnTime":
																		this.api.kernel.OptionsManager.setOption("RemindTurnTime",loc2.target.selected);
																		break loop0;
																	case "_btnHideSpellBar":
																		this.api.kernel.OptionsManager.setOption("HideSpellBar",loc2.target.selected);
																		break loop0;
																	default:
																		switch(null)
																		{
																			case "_btnSeeAllSpell":
																				this.api.kernel.OptionsManager.setOption("SeeAllSpell",!loc2.target.selected);
																				break;
																			case "_btnSpeakingItems":
																				this.api.kernel.OptionsManager.setOption("UseSpeakingItems",loc2.target.selected);
																				break;
																			case "_btnConfirmDropItem":
																				this.api.kernel.OptionsManager.setOption("ConfirmDropItem",loc2.target.selected);
																				break;
																			case "_btnChatTimestamp":
																				this.api.kernel.OptionsManager.setOption("TimestampInChat",loc2.target.selected);
																				this.api.kernel.ChatManager.refresh();
																				break;
																			case "_btnViewDicesDammages":
																				this.api.kernel.OptionsManager.setOption("ViewDicesDammages",loc2.target.selected);
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
	function change(loc2)
	{
		switch(loc2.target._name)
		{
			case "_vsMusic":
				this.api.kernel.OptionsManager.setOption("AudioMusicVol",loc2.target.value);
				break;
			case "_vsSounds":
				this.api.kernel.OptionsManager.setOption("AudioEffectVol",loc2.target.value);
				break;
			case "_vsEnvironment":
				this.api.kernel.OptionsManager.setOption("AudioEnvVol",loc2.target.value);
				break;
			default:
				switch(null)
				{
					case "_vsCreaturesMode":
						if(loc2.target.value == loc2.target.max)
						{
							this.api.kernel.OptionsManager.setOption("CreaturesMode",Number.POSITIVE_INFINITY);
						}
						else if(loc2.target.value == loc2.target.min)
						{
							this.api.kernel.OptionsManager.setOption("CreaturesMode",0);
						}
						else
						{
							this.api.kernel.OptionsManager.setOption("CreaturesMode",Math.floor(loc2.target.value));
						}
						break;
					case "_vsMovableBarSize":
						var loc3 = Math.floor(loc2.target.value);
						this.api.kernel.OptionsManager.setOption("MovableBarSize",loc3);
						this._mcTabViewer._lblMovableBarSizeValue.text = loc3.toString();
				}
		}
	}
	function optionChanged(loc2)
	{
		loop0:
		switch(loc2.key)
		{
			case "Grid":
				this._mcTabViewer._btnGrid.selected = loc2.value;
				break;
			case "Transparency":
				this._mcTabViewer._btnTransparency.selected = loc2.value;
				break;
			case "SpriteInfos":
				this._mcTabViewer._btnSpriteInfos.selected = loc2.value;
				break;
			default:
				switch(null)
				{
					case "SpriteMove":
						this._mcTabViewer._btnSpriteMove.selected = loc2.value;
						break loop0;
					case "MapInfos":
						this._mcTabViewer._btnMapInfos.selected = loc2.value;
						break loop0;
					case "AutoHideSmileys":
						this._mcTabViewer._btnAutoHideSmileys.selected = loc2.value;
						break loop0;
					case "StringCourse":
						this._mcTabViewer._btnStringCourse.selected = loc2.value;
						break loop0;
					default:
						switch(null)
						{
							case "PointsOverHead":
								this._mcTabViewer._btnPointsOverHead.selected = loc2.value;
								break loop0;
							case "ChatEffects":
								this._mcTabViewer._btnChatEffects.selected = loc2.value;
								break loop0;
							case "CreaturesMode":
								this._mcTabViewer._vsCreaturesMode.value = loc2.value;
								this._mcTabViewer._lblCreaturesModeValue.text = !_global.isFinite(loc2.value)?this.api.lang.getText("INFINIT"):loc2.value;
								break loop0;
							case "Buff":
								this._mcTabViewer._btnBuff.selected = loc2.value;
								break loop0;
							case "GuildMessageSound":
								this._mcTabViewer._btnGuildMessageSound.selected = loc2.value;
								break loop0;
							default:
								switch(null)
								{
									case "StartTurnSound":
										this._mcTabViewer._btnStartTurnSound.selected = loc2.value;
										break loop0;
									case "BannerShortcuts":
										this._mcTabViewer._btnBannerShortcuts.selected = loc2.value;
										break loop0;
									case "TipsOnStart":
										this._mcTabViewer._btnTipsOnStart.selected = loc2.value;
										break loop0;
									case "DisplayStyle":
										this._mcTabViewer.selectDisplayStyle(loc2.value);
										break loop0;
									default:
										switch(null)
										{
											case "MovableBar":
												this._mcTabViewer._btnMovableBar.selected = loc2.value;
												break loop0;
											case "MovableBarSize":
												this._mcTabViewer._vsMovableBarSize.value = loc2.value;
												break loop0;
											case "ViewAllMonsterInGroup":
												this._mcTabViewer._btnViewAllMonsterInGroup.selected = loc2.value;
												break loop0;
											case "CharacterPreview":
												this._mcTabViewer._btnCharacterPreview.selected = loc2.value;
												break loop0;
											case "Aura":
												this._mcTabViewer._btnAura.selected = loc2.value;
												break loop0;
											default:
												switch(null)
												{
													case "DisplayingFreshTips":
														this._mcTabViewer._btnTutorialTips.selected = loc2.value;
														break loop0;
													case "CensorshipFilter":
														this._mcTabViewer._btnCensorshipFilter.selected = loc2.value;
														break loop0;
													case "AskForWrongCraft":
														this._mcTabViewer._btnCraftWrongConfirm.selected = loc2.value;
														break loop0;
													case "AdvancedLineOfSight":
														this._mcTabViewer._btnAdvancedLineOfSight.selected = loc2.value;
														break loop0;
													case "RemindTurnTime":
														this._mcTabViewer._btnRemindTurnTime.selected = loc2.value;
														break loop0;
													default:
														switch(null)
														{
															case "HideSpellBar":
																this._mcTabViewer._btnHideSpellBar.selected = loc2.value;
																break loop0;
															case "SeeAllSpell":
																this._mcTabViewer._btnSeeAllSpell.selected = !loc2.value;
																break loop0;
															case "UseSpeakingItems":
																this._mcTabViewer._btnSpeakingItems.selected = loc2.value;
																break loop0;
															case "ConfirmDropItem":
																this._mcTabViewer._btnConfirmDropItem.selected = loc2.value;
																break loop0;
															default:
																switch(null)
																{
																	case "TimestampInChat":
																		this._mcTabViewer._btnChatTimestamp.selected = loc2.value;
																		this.api.kernel.ChatManager.refresh();
																		break;
																	case "AudioMusicMute":
																		this._mcTabViewer._btnMuteMusic.selected = loc2.value;
																		break;
																	case "AudioEffectMute":
																		this._mcTabViewer._btnMuteSounds.selected = loc2.value;
																		break;
																	case "AudioEnvMute":
																		this._mcTabViewer._btnMuteEnvironment.selected = loc2.value;
																}
														}
												}
										}
								}
						}
				}
		}
	}
	function itemSelected(loc2)
	{
		switch(loc2.target._name)
		{
			case "_cbDisplayStyle":
				var loc3 = loc2.target.selectedItem;
				if(loc3.style == "normal")
				{
					this.api.kernel.OptionsManager.setOption("DisplayStyle",loc3.style);
				}
				else
				{
					this.api.kernel.showMessage(this.api.lang.getText("OPTIONS_DISPLAY"),this.api.lang.getText("DO_U_CHANGE_DISPLAYSTYLE"),"CAUTION_YESNO",{name:"Display",listener:this,params:{style:loc3.style}});
				}
				break;
			case "_cbDefaultQuality":
				var loc4 = loc2.target.selectedItem;
				this.api.kernel.showMessage(this.api.lang.getText("OPTIONS_DISPLAY"),this.api.lang.getText("DO_U_CHANGE_QUALITY_" + String(loc4.quality).toUpperCase()),"CAUTION_YESNO",{name:"Quality",listener:this,params:{quality:loc4.quality}});
		}
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoDisplay":
				this.api.kernel.OptionsManager.setOption("DisplayStyle",loc2.target.params.style);
				break;
			case "AskYesNoResetTips":
				dofus.managers.TipsManager.getInstance().resetDisplayedTipsList();
				break;
			case "AskYesNoQuality":
				this.api.kernel.OptionsManager.setOption("DefaultQuality",loc2.target.params.quality);
		}
	}
	function no(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoDisplay":
				this.selectDisplayStyle(this.api.kernel.OptionsManager.getOption("DisplayStyle"));
				break;
			case "AskYesNoQuality":
				this.selectQuality(this.api.kernel.OptionsManager.getOption("DefaultQuality"));
		}
	}
	function scroll(loc2)
	{
		this._mcTabViewer._y = this._mcPlacer._y - this._sbOptions.scrollPosition;
	}
	function onMouseWheel(loc2, loc3)
	{
		if(String(loc3._target).indexOf(this._target) != -1 && this._sbOptions._visible)
		{
			this._sbOptions.scrollPosition = this._sbOptions.scrollPosition - (loc2 <= 0?- dofus.graphics.gapi.ui.Options.SCROLL_BY:dofus.graphics.gapi.ui.Options.SCROLL_BY);
		}
	}
}
