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
	function __set__remainingTime(var2)
	{
		this._nRemainingTime = var2;
		return this.__get__remainingTime();
	}
	function __set__characterName(var2)
	{
		if(this._itCharacterName.text != undefined)
		{
			this._itCharacterName.text = var2;
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
		var var2 = "";
		if(this.api.datacenter.Player.isAuthorized)
		{
			var2 = "a-zA-Z\\-\\[\\]";
		}
		else
		{
			var2 = "a-zA-Z\\-";
		}
		if(this.api.config.isStreaming)
		{
			var2 = var2 + "0-9";
		}
		this._itCharacterName.restrict = var2;
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
		var var2 = new Array();
		var var3 = 0;
		while(var3 < dofus.Constants.GUILD_ORDER.length)
		{
			if(!(this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[var3] == 12))
			{
				var2[var3] = dofus.Constants.BREEDS_SLIDER_PATH + dofus.Constants.GUILD_ORDER[var3] + this._nSex + ".swf";
			}
			var3 = var3 + 1;
		}
		this._csBreedSelection.initialize(var2);
		this._csBreedSelection.animation = true;
		this._csBreedSelection.animationSpeed = 3;
		this._svCharacter.zoom = 250;
		this._svCharacter.spriteAnims = ["StaticF","StaticR","StaticL","WalkF","RunF","Anim2R","Anim2L"];
		this._svCharacter.refreshDelay = 50;
		this._svCharacter.useSingleLoader = true;
	}
	function selectRandomBreed()
	{
		var var2 = -1;
		while(var2 == -1 || this.api.config.isStreaming && var2 == 12)
		{
			var2 = Math.round(Math.random() * (dofus.Constants.GUILD_ORDER.length - 1)) + 1;
		}
		this.setClass(var2,this._nSex);
		this._bLoaded = true;
	}
	function setClass(var2, var3)
	{
		this._csColors.breed = var2;
		this._csColors.sex = var3;
		if(this._nBreed == var2 && this._nSex == var3)
		{
			return undefined;
		}
		this._svCharacter.spriteData = new ank.battlefield.datacenter.("viewer",ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var2 + var3 + ".swf",undefined,5);
		this._ldrClassIcon.contentPath = dofus.Constants.BREEDS_SYMBOL_PATH + var2 + ".swf";
		var var4 = 0;
		while(var4 < dofus.Constants.GUILD_ORDER.length)
		{
			if(!(this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[var4] == 12))
			{
				if(dofus.Constants.GUILD_ORDER[var4] == var2)
				{
					this._csBreedSelection.currentIndex = var4;
				}
			}
			var4 = var4 + 1;
		}
		if(this._nSex != var3)
		{
			var var5 = new Array();
			var var6 = 0;
			while(var6 < dofus.Constants.GUILD_ORDER.length)
			{
				if(!(this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[var6] == 12))
				{
					var5[var6] = dofus.Constants.BREEDS_SLIDER_PATH + dofus.Constants.GUILD_ORDER[var6] + var3 + ".swf";
				}
				var6 = var6 + 1;
			}
			this._csBreedSelection.clipsList = var5;
			this._csBreedSelection.updateColor(1,this._oColors.color1);
			this._csBreedSelection.updateColor(2,this._oColors.color2);
			this._csBreedSelection.updateColor(3,this._oColors.color3);
		}
		var var7 = this.api.lang.getClassText(var2);
		this._lblClassName.text = var7.ln;
		this._txtClassDescription.text = "<font color=\'#514A3C\'>" + var7.d + "</font>";
		this._txtShortClassDescription.text = "<font color=\'#514A3C\' size=\'14\'><b>" + var7.sd + "</b></font>";
		this._svCharacter.setColors(this._oColors);
		if(dofus.Constants.EPISODIC_GUILD[var2 - 1] > this.api.datacenter.Basics.aks_current_regional_version)
		{
			this._btnValidate.label = this.api.lang.getText("COMING_SOON_SHORT");
		}
		else
		{
			this._btnValidate.label = this.api.lang.getText("VALIDATE");
		}
		this._nBreed = var2;
		this._nSex = var3;
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
	function hideColorPosition(var2)
	{
		delete this.onEnterFrame;
		this._svCharacter.setColor(var2,this._nSavedColor);
	}
	function validateCreation()
	{
		var var2 = this._itCharacterName.text;
		if(var2.length == 0 || var2 == undefined)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NEED_CHARACTER_NAME"),"ERROR_BOX",{name:"CREATENONAME"});
			return undefined;
		}
		if(var2.length > 20)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LONG_CHARACTER_NAME",[var2,20]),"ERROR_BOX");
			return undefined;
		}
		if(this.api.lang.getConfigText("CHAR_NAME_FILTER") && !this.api.datacenter.Player.isAuthorized)
		{
			var var3 = new dofus.utils.nameChecker.(var2);
			var var4 = new dofus.utils.nameChecker.rules.NameCheckerCharacterNameRules();
			var var5 = var3.isValidAgainstWithDetails(var4);
			if(!var5.IS_SUCCESS)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("INVALID_CHARACTER_NAME") + "\r\n" + var5.toString("\r\n"),"ERROR_BOX");
				return undefined;
			}
		}
		if(dofus.Constants.EPISODIC_GUILD[this._nBreed - 1] > this.api.datacenter.Basics.aks_current_regional_version)
		{
			var var6 = this.api.lang.getClassText(this._nBreed).sn;
			this.api.kernel.showMessage(undefined,this.api.lang.getText("COMING_SOON_GUILD",[var6]),"ERROR_BOX");
			return undefined;
		}
		if(dofus.Constants.PAYING_GUILD[this._nBreed - 1] && this._nRemainingTime <= 0)
		{
			var var7 = this.api.lang.getClassText(this._nBreed).sn;
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PAYING_GUILD",[var7]),"ERROR_BOX");
			return undefined;
		}
		this.api.datacenter.Basics.hasCreatedCharacter = true;
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'addCharacter;" + var2 + "\')");
		}
		this.api.network.Account.addCharacter(var2,this._nBreed,this._oColors.color1,this._oColors.color2,this._oColors.color3,this._nSex);
	}
	function setColors(var2)
	{
		this._oColors = var2;
		this._svCharacter.setColors(this._oColors);
		this._csBreedSelection.updateColor(1,var2.color1);
		this._csBreedSelection.updateColor(2,var2.color2);
		this._csBreedSelection.updateColor(3,var2.color3);
	}
	function hideGenerateRandomName()
	{
		this._mcRandomName._visible = false;
	}
	function click(var2)
	{
		loop0:
		switch(var2.target)
		{
			case this._mcRight:
				this._csBreedSelection.slide(1);
				break;
			case this._mcLeft:
				this._csBreedSelection.slide(-1);
				break;
			case this._mcMaleButton:
				this.setClass(this._nBreed,0);
				break;
			default:
				switch(null)
				{
					case this._mcFemaleButton:
						this.setClass(this._nBreed,1);
						break loop0;
					case this._mcSpellButton2:
					case this._mcSpellButton:
						this.api.ui.loadUIComponent("SpellViewerOnCreate","SpellViewerOnCreate",{breed:this._nBreed});
						break loop0;
					case this._mcHistoryButton:
						this.api.ui.loadUIComponent("HistoryViewerOnCreate","HistoryViewerOnCreate",{breed:this._nBreed});
						break loop0;
					default:
						switch(null)
						{
							case this._btnValidate:
								this.validateCreation();
								break;
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
								break;
							case this._mcRandomName:
								if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.CreateCharacter.NAME_GENERATION_DELAY < getTimer())
								{
									this.api.network.Account.getRandomCharacterName();
									this._nLastRegenerateTimer = getTimer();
									break;
								}
						}
				}
		}
	}
	function over(var2)
	{
		loop0:
		switch(var2.target)
		{
			case this._csColors:
				this.showColorPosition(var2.index);
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
						break loop0;
					case this._mcSpellButton:
						this.gapi.showTooltip(this.api.lang.getText("CLASS_SPELLS"),_root._xmouse,_root._ymouse - 20);
						break loop0;
					case this._mcRight:
						this.gapi.showTooltip(this.api.lang.getText("NEXT_WORD"),_root._xmouse,_root._ymouse - 20);
						break loop0;
					default:
						if(var0 !== this._mcLeft)
						{
							break loop0;
						}
						this.gapi.showTooltip(this.api.lang.getText("PREVIOUS_WORD"),_root._xmouse,_root._ymouse - 20);
						break loop0;
				}
		}
	}
	function out(var2)
	{
		if((var var0 = var2.target) !== this._csColors)
		{
			this.gapi.hideTooltip();
		}
		else
		{
			this.hideColorPosition(var2.index);
		}
	}
	function change(var2)
	{
		switch(var2.target)
		{
			case this._csColors:
				this.setColors(var2.value);
				break;
			case this._csBreedSelection:
				if(this._bLoaded)
				{
					this.setClass(dofus.Constants.GUILD_ORDER[var2.value],this._nSex);
				}
				break;
			case this._itCharacterName:
				var var3 = this._itCharacterName.text;
				if(!this.api.datacenter.Player.isAuthorized)
				{
					var3 = var3.substr(0,1).toUpperCase() + var3.substr(1);
					var var4 = var3.substr(0,1);
					var var5 = 1;
					while(var5 < var3.length)
					{
						if(var3.substr(var5 - 1,1) != "-")
						{
							var4 = var4 + var3.substr(var5,1).toLowerCase();
						}
						else
						{
							var4 = var4 + var3.substr(var5,1);
						}
						var5 = var5 + 1;
					}
					this._itCharacterName.removeEventListener("change",this);
					this._itCharacterName.text = var4;
					this._itCharacterName.addEventListener("change",this);
					break;
				}
		}
	}
}
