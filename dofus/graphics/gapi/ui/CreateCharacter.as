class dofus.graphics.gapi.ui.CreateCharacter extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CreateCharacter";
	static var NAME_GENERATION_DELAY = 500;
	var _nLastRegenerateTimer = 0;
	var _bLoaded = false;
	function CreateCharacter()
	{
		super();
	}
	function __set__remainingTime(loc2)
	{
		this._nRemainingTime = loc2;
		return this.__get__remainingTime();
	}
	function __set__characterName(loc2)
	{
		if(this._itCharacterName.text != undefined)
		{
			this._itCharacterName.text = loc2;
		}
		return this.__get__characterName();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.CreateCharacter.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.setupRestriction});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initComponent});
		this.addToQueue({object:this,method:this.selectRandomBreed});
		this.api.kernel.StreamingDisplayManager.onCharacterCreation();
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'CreateCharacter\')");
		}
	}
	function addListeners()
	{
		var ref = this;
		this._mcMaleButton.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcMaleButton.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcMaleButton.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcFemaleButton.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcFemaleButton.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcFemaleButton.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcSpellButton.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcSpellButton.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcSpellButton.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcSpellButton2.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcSpellButton2.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcSpellButton2.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcHistoryButton.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcHistoryButton.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcHistoryButton.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcRandomName.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcRandomName.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcRandomName.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcRight.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcRight.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcRight.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcLeft.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcLeft.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcLeft.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._btnBack.addEventListener("click",this);
		this._btnValidate.addEventListener("click",this);
		this._itCharacterName.addEventListener("change",this);
		this._csColors.addEventListener("change",this);
		this._csColors.addEventListener("over",this);
		this._csColors.addEventListener("out",this);
		this._csBreedSelection.addEventListener("change",this);
	}
	function setupRestriction()
	{
		var loc2 = "";
		if(this.api.datacenter.Player.isAuthorized)
		{
			loc2 = "a-zA-Z\\-\\[\\]";
		}
		else
		{
			loc2 = "a-zA-Z\\-";
		}
		if(this.api.config.isStreaming)
		{
			loc2 = loc2 + "0-9";
		}
		this._itCharacterName.restrict = loc2;
	}
	function initTexts()
	{
		this._lblTitle.text = this.api.lang.getText("CREATE_TITLE");
		this._lblCharacterColors.text = this.api.lang.getText("SPRITE_COLORS");
		this._lblCharacterName.text = this.api.lang.getText("CREATE_CHARACTER_NAME");
		this._btnBack.label = this.api.lang.getText("BACK");
		this._btnValidate.label = this.api.lang.getText("VALIDATE");
		this._lblHistoryButton.text = this.api.lang.getText("HISTORY_CLASS_WORD");
		this._lblSpellButton.text = this.api.lang.getText("SPELLS_SHORTCUT");
	}
	function initComponent()
	{
		this._oColors = {color1:-1,color2:-1,color3:-1};
		this._nSex = Math.round(Math.random());
		var loc2 = new Array();
		var loc3 = 0;
		while(loc3 < dofus.Constants.GUILD_ORDER.length)
		{
			if(!(this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[loc3] == 12))
			{
				loc2[loc3] = dofus.Constants.BREEDS_SLIDER_PATH + dofus.Constants.GUILD_ORDER[loc3] + this._nSex + ".swf";
			}
			loc3 = loc3 + 1;
		}
		this._csBreedSelection.initialize(loc2);
		this._csBreedSelection.animation = true;
		this._csBreedSelection.animationSpeed = 3;
		this._svCharacter.zoom = 250;
		this._svCharacter.spriteAnims = ["StaticF","StaticR","StaticL","WalkF","RunF","Anim2R","Anim2L"];
		this._svCharacter.refreshDelay = 50;
		this._svCharacter.useSingleLoader = true;
	}
	function selectRandomBreed()
	{
		var loc2 = -1;
		while(loc2 == -1 || this.api.config.isStreaming && loc2 == 12)
		{
			loc2 = Math.round(Math.random() * (dofus.Constants.GUILD_ORDER.length - 1)) + 1;
		}
		this.setClass(loc2,this._nSex);
		this._bLoaded = true;
	}
	function setClass(loc2, loc3)
	{
		this._csColors.breed = loc2;
		this._csColors.sex = loc3;
		if(this._nBreed == loc2 && this._nSex == loc3)
		{
			return undefined;
		}
		this._svCharacter.spriteData = new ank.battlefield.datacenter.("1",undefined,dofus.Constants.CLIPS_PERSOS_PATH + loc2 + loc3 + ".swf",undefined,5);
		this._ldrClassIcon.contentPath = dofus.Constants.BREEDS_SYMBOL_PATH + loc2 + ".swf";
		var loc4 = 0;
		while(loc4 < dofus.Constants.GUILD_ORDER.length)
		{
			if(!(this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[loc4] == 12))
			{
				if(dofus.Constants.GUILD_ORDER[loc4] == loc2)
				{
					this._csBreedSelection.currentIndex = loc4;
				}
			}
			loc4 = loc4 + 1;
		}
		if(this._nSex != loc3)
		{
			var loc5 = new Array();
			var loc6 = 0;
			while(loc6 < dofus.Constants.GUILD_ORDER.length)
			{
				if(!(this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[loc6] == 12))
				{
					loc5[loc6] = dofus.Constants.BREEDS_SLIDER_PATH + dofus.Constants.GUILD_ORDER[loc6] + loc3 + ".swf";
				}
				loc6 = loc6 + 1;
			}
			this._csBreedSelection.clipsList = loc5;
			this._csBreedSelection.updateColor(1,this._oColors.color1);
			this._csBreedSelection.updateColor(2,this._oColors.color2);
			this._csBreedSelection.updateColor(3,this._oColors.color3);
		}
		var loc7 = this.api.lang.getClassText(loc2);
		this._lblClassName.text = loc7.ln;
		this._txtClassDescription.text = "<font color=\'#514A3C\'>" + loc7.d + "</font>";
		this._txtShortClassDescription.text = "<font color=\'#514A3C\' size=\'14\'><b>" + loc7.sd + "</b></font>";
		this._svCharacter.setColors(this._oColors);
		if(dofus.Constants.EPISODIC_GUILD[loc2 - 1] > this.api.datacenter.Basics.aks_current_regional_version)
		{
			this._btnValidate.label = this.api.lang.getText("COMING_SOON_SHORT");
		}
		else
		{
			this._btnValidate.label = this.api.lang.getText("VALIDATE");
		}
		this._nBreed = loc2;
		this._nSex = loc3;
	}
	function showColorPosition(nIndex)
	{
		var bWhite = true;
		this._nSavedColor = this._svCharacter.getColor(nIndex);
		this.onEnterFrame = function()
		{
			this._svCharacter.setColor(nIndex,!(bWhite = !bWhite)?16746632:16733525);
		};
	}
	function hideColorPosition(loc2)
	{
		delete this.onEnterFrame;
		this._svCharacter.setColor(loc2,this._nSavedColor);
	}
	function validateCreation()
	{
		var loc2 = this._itCharacterName.text;
		if(loc2.length == 0 || loc2 == undefined)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NEED_CHARACTER_NAME"),"ERROR_BOX",{name:"CREATENONAME"});
			return undefined;
		}
		if(loc2.length > 20)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LONG_CHARACTER_NAME",[loc2,20]),"ERROR_BOX");
			return undefined;
		}
		if(this.api.lang.getConfigText("CHAR_NAME_FILTER") && !this.api.datacenter.Player.isAuthorized)
		{
			var loc3 = new dofus.utils.nameChecker.
(loc2);
			var loc4 = new dofus.utils.nameChecker.rules.NameCheckerCharacterNameRules();
			var loc5 = loc3.isValidAgainstWithDetails(loc4);
			if(!loc5.IS_SUCCESS)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("INVALID_CHARACTER_NAME") + "\r\n" + loc5.toString("\r\n"),"ERROR_BOX");
				return undefined;
			}
		}
		if(dofus.Constants.EPISODIC_GUILD[this._nBreed - 1] > this.api.datacenter.Basics.aks_current_regional_version)
		{
			var loc6 = this.api.lang.getClassText(this._nBreed).sn;
			this.api.kernel.showMessage(undefined,this.api.lang.getText("COMING_SOON_GUILD",[loc6]),"ERROR_BOX");
			return undefined;
		}
		if(dofus.Constants.PAYING_GUILD[this._nBreed - 1] && this._nRemainingTime <= 0)
		{
			var loc7 = this.api.lang.getClassText(this._nBreed).sn;
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PAYING_GUILD",[loc7]),"ERROR_BOX");
			return undefined;
		}
		this.api.datacenter.Basics.hasCreatedCharacter = true;
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'addCharacter;" + loc2 + "\')");
		}
		this.api.network.Account.addCharacter(loc2,this._nBreed,this._oColors.color1,this._oColors.color2,this._oColors.color3,this._nSex);
	}
	function setColors(loc2)
	{
		this._oColors = loc2;
		this._svCharacter.setColors(this._oColors);
		this._csBreedSelection.updateColor(1,loc2.color1);
		this._csBreedSelection.updateColor(2,loc2.color2);
		this._csBreedSelection.updateColor(3,loc2.color3);
	}
	function hideGenerateRandomName()
	{
		this._mcRandomName._visible = false;
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target)
		{
			case this._mcRight:
				this._csBreedSelection.slide(1);
				break;
			case this._mcLeft:
				this._csBreedSelection.slide(-1);
				break;
			default:
				switch(null)
				{
					case this._mcMaleButton:
						this.setClass(this._nBreed,0);
						break loop0;
					case this._mcFemaleButton:
						this.setClass(this._nBreed,1);
						break loop0;
					case this._mcSpellButton2:
					case this._mcSpellButton:
						this.api.ui.loadUIComponent("SpellViewerOnCreate","SpellViewerOnCreate",{breed:this._nBreed});
						break loop0;
					default:
						switch(null)
						{
							case this._mcHistoryButton:
								this.api.ui.loadUIComponent("HistoryViewerOnCreate","HistoryViewerOnCreate",{breed:this._nBreed});
								break loop0;
							case this._btnValidate:
								this.validateCreation();
								break loop0;
							case this._btnBack:
								if(this.api.datacenter.Basics.createCharacter)
								{
									this.api.kernel.changeServer(true);
								}
								else
								{
									this.api.datacenter.Basics.ignoreCreateCharacter = true;
									this.api.network.Account.getCharactersForced();
								}
								break loop0;
							default:
								if(loc0 !== this._mcRandomName)
								{
									break loop0;
								}
								if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.CreateCharacter.NAME_GENERATION_DELAY < getTimer())
								{
									this.api.network.Account.getRandomCharacterName();
									this._nLastRegenerateTimer = getTimer();
									break loop0;
								}
								break loop0;
						}
				}
		}
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._csColors:
				this.showColorPosition(loc2.index);
				break;
			case this._mcRandomName:
				this.gapi.showTooltip(this.api.lang.getText("RANDOM_NICKNAME"),_root._xmouse,_root._ymouse - 20);
				break;
			case this._mcMaleButton:
				this.gapi.showTooltip(this.api.lang.getText("ANIMAL_MEN"),_root._xmouse,_root._ymouse - 20);
				break;
			default:
				switch(null)
				{
					case this._mcFemaleButton:
						this.gapi.showTooltip(this.api.lang.getText("ANIMAL_WOMEN"),_root._xmouse,_root._ymouse - 20);
						break;
					case this._mcSpellButton:
						this.gapi.showTooltip(this.api.lang.getText("CLASS_SPELLS"),_root._xmouse,_root._ymouse - 20);
						break;
					case this._mcRight:
						this.gapi.showTooltip(this.api.lang.getText("NEXT_WORD"),_root._xmouse,_root._ymouse - 20);
						break;
					case this._mcLeft:
						this.gapi.showTooltip(this.api.lang.getText("PREVIOUS_WORD"),_root._xmouse,_root._ymouse - 20);
				}
		}
	}
	function out(loc2)
	{
		if((var loc0 = loc2.target) !== this._csColors)
		{
			this.gapi.hideTooltip();
		}
		else
		{
			this.hideColorPosition(loc2.index);
		}
	}
	function change(loc2)
	{
		switch(loc2.target)
		{
			case this._csColors:
				this.setColors(loc2.value);
				break;
			case this._csBreedSelection:
				if(this._bLoaded)
				{
					this.setClass(dofus.Constants.GUILD_ORDER[loc2.value],this._nSex);
				}
				break;
			default:
				if(loc0 !== this._itCharacterName)
				{
					break;
				}
				var loc3 = this._itCharacterName.text;
				if(!this.api.datacenter.Player.isAuthorized)
				{
					loc3 = loc3.substr(0,1).toUpperCase() + loc3.substr(1);
					var loc4 = loc3.substr(0,1);
					var loc5 = 1;
					while(loc5 < loc3.length)
					{
						if(loc3.substr(loc5 - 1,1) != "-")
						{
							loc4 = loc4 + loc3.substr(loc5,1).toLowerCase();
						}
						else
						{
							loc4 = loc4 + loc3.substr(loc5,1);
						}
						loc5 = loc5 + 1;
					}
					this._itCharacterName.removeEventListener("change",this);
					this._itCharacterName.text = loc4;
					this._itCharacterName.addEventListener("change",this);
					break;
				}
				break;
		}
	}
}
