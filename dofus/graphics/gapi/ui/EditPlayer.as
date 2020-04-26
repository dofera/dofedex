class dofus.graphics.gapi.ui.EditPlayer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "EditPlayer";
	static var NAME_GENERATION_DELAY = 500;
	var _nLastRegenerateTimer = 0;
	var _bLoaded = false;
	var _bEditColors = false;
	var _bEditName = false;
	var _bForce = false;
	function EditPlayer()
	{
		super();
	}
	function __set__editColors(loc2)
	{
		this._bEditColors = loc2;
		return this.__get__editColors();
	}
	function __set__editName(loc2)
	{
		this._bEditName = loc2;
		return this.__get__editName();
	}
	function __set__force(loc2)
	{
		this._bForce = loc2;
		return this.__get__force();
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
		super.init(false,dofus.graphics.gapi.ui.EditPlayer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.setupRestriction});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initComponent});
	}
	function addListeners()
	{
		var ref = this;
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
		this._btnCancel.addEventListener("click",this);
		this._btnValidate.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this._itCharacterName.addEventListener("change",this);
		this._csColors.addEventListener("change",this);
		this._csColors.addEventListener("over",this);
		this._csColors.addEventListener("out",this);
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
		this._winBg.title = this.api.lang.getText("CUSTOMIZE");
		this._lblTitle.text = this.api.lang.getText("CREATE_TITLE");
		this._lblCharacterColors.text = this.api.lang.getText("SPRITE_COLORS");
		this._lblCharacterName.text = this.api.lang.getText("CREATE_CHARACTER_NAME");
		this._btnCancel.label = this.api.lang.getText("BACK");
		this._btnValidate.label = this.api.lang.getText("VALIDATE");
	}
	function initComponent()
	{
		if(this._bForce)
		{
			this._btnClose._visible = false;
			this._btnCancel._visible = false;
		}
		if(!this._bEditName)
		{
			this._itCharacterName.enabled = false;
			this._mcRandomName._visible = false;
			this._mcItCharacterNameBg._visible = false;
		}
		if(!this._bEditColors)
		{
			this._lblCharacterColors._visible = false;
			this._csColors._visible = false;
		}
		this.characterName = this.api.datacenter.Player.Name;
		var loc2 = this.api.datacenter.Player.data;
		if(loc2 == undefined)
		{
			this._svCharacter._visible = false;
			this._csColors._visible = false;
		}
		else
		{
			this._oColors = {color1:loc2.color1,color2:loc2.color2,color3:loc2.color3};
			this._svCharacter.zoom = 250;
			this._svCharacter.spriteAnims = ["StaticF","StaticR","StaticL","WalkF","RunF","Anim2R","Anim2L"];
			this._svCharacter.refreshDelay = 50;
			this._svCharacter.useSingleLoader = true;
			var loc3 = this.api.datacenter.Player.Guild;
			var loc4 = this.api.datacenter.Player.Sex;
			this._csColors.breed = loc3;
			this._csColors.sex = loc4;
			this._csColors.colors = [loc2.color1,loc2.color2,loc2.color3];
			this._svCharacter.spriteData = new ank.battlefield.datacenter.("1",undefined,dofus.Constants.CLIPS_PERSOS_PATH + loc3 + loc4 + ".swf",undefined,5);
			this._svCharacter.setColors(this._oColors);
		}
		this._btnValidate.label = this.api.lang.getText("VALIDATE");
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
	function validateNameEdit()
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
		this.api.network.Account.editCharacterName(loc2);
	}
	function validateColorsEdit()
	{
		this.api.network.Account.editCharacterColors(this._oColors.color1,this._oColors.color2,this._oColors.color3);
	}
	function setColors(loc2)
	{
		this._oColors = loc2;
		this._svCharacter.setColors(this._oColors);
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
			case this._btnValidate:
				if(this._bEditName)
				{
					this.validateNameEdit();
				}
				if(this._bEditColors)
				{
					this.validateColorsEdit();
					break;
				}
				break;
			default:
				switch(null)
				{
					case this._btnClose:
						break loop0;
					case this._mcRandomName:
						if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.EditPlayer.NAME_GENERATION_DELAY < getTimer())
						{
							this.api.network.Account.getRandomCharacterName();
							this._nLastRegenerateTimer = getTimer();
							break;
						}
				}
			case this._btnCancel:
		}
		this.unloadThis();
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
			case this._itCharacterName:
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
		}
	}
}
