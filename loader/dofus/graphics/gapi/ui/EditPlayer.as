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
	function __set__editColors(var2)
	{
		this._bEditColors = var2;
		return this.__get__editColors();
	}
	function __set__editName(var2)
	{
		this._bEditName = var2;
		return this.__get__editName();
	}
	function __set__force(var2)
	{
		this._bForce = var2;
		return this.__get__force();
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
		this._btnHideStuff.addEventListener("click",this);
		if(this.api.datacenter.Player.mount != undefined)
		{
			this._btnShowMount.addEventListener("click",this);
		}
		else
		{
			this._btnShowMount._visible = false;
			this._lblShowMount._visible = false;
		}
		this._btnClose.addEventListener("click",this);
		this._itCharacterName.addEventListener("change",this);
		this._csColors.addEventListener("change",this);
		this._csColors.addEventListener("over",this);
		this._csColors.addEventListener("out",this);
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
		this._winBg.title = this.api.lang.getText("CUSTOMIZE");
		this._lblTitle.text = this.api.lang.getText("CREATE_TITLE");
		this._lblHideStuff.text = this.api.lang.getText("HIDE_STUFF");
		this._lblShowMount.text = this.api.lang.getText("SHOW_MOUNT");
		this._lblClickToAnim.text = this.api.lang.getText("CLICK_TO_ANIMATE");
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
		this.showMyself();
		this._btnValidate.label = this.api.lang.getText("VALIDATE");
	}
	function showMyself()
	{
		var var2 = this._btnHideStuff.selected;
		var var3 = this._btnShowMount.selected;
		var var4 = (ank.battlefield.datacenter.Sprite)this.api.datacenter.Player.data;
		if(var4 == undefined)
		{
			this._svCharacter._visible = false;
			this._csColors._visible = false;
			return undefined;
		}
		if(this._svCharacter.spriteData == undefined)
		{
			var var5 = var4.color1;
			var var6 = var4.color2;
			var var7 = var4.color3;
		}
		else
		{
			var5 = this._svCharacter.getColor(1);
			var6 = this._svCharacter.getColor(2);
			var7 = this._svCharacter.getColor(3);
		}
		this._oColors = {color1:var5,color2:var6,color3:var7};
		this._svCharacter.zoom = 200;
		this._svCharacter.spriteAnims = ["StaticF","StaticR","StaticL","WalkF","RunF","Anim2R","Anim2L"];
		this._svCharacter.refreshDelay = 50;
		this._svCharacter.useSingleLoader = true;
		var var8 = this.api.datacenter.Player.Guild;
		var var9 = this.api.datacenter.Player.Sex;
		this._csColors.breed = var8;
		this._csColors.sex = var9;
		this._csColors.colors = [var5,var6,var7];
		var var10 = var8 + "" + var9;
		var var11 = new ank.battlefield.datacenter.("viewer",ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + var10 + ".swf",undefined,5);
		if(!var2)
		{
			var11.accessories = var4.accessories;
		}
		if(var3)
		{
			var var12 = this.api.datacenter.Player.mount;
			if(var12 != undefined)
			{
				var var13 = new dofus.datacenter.Mount(var12.modelID,Number(var10));
				if(var12.isChameleon)
				{
					var13.capacities = var12.capacities;
					var13.customColor1 = var6;
					var13.customColor2 = var7;
					var13.customColor3 = var7;
				}
				var11.mount = var13;
			}
		}
		this._svCharacter.enableBlur = true;
		this._svCharacter.refreshAccessories = !var2;
		this._svCharacter.sourceSpriteData = var4;
		this._svCharacter.spriteData = var11;
		this._svCharacter.setColors(this._oColors);
	}
	function showColorPosition(nIndex)
	{
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
	function validateNameEdit()
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
		this.api.network.Account.editCharacterName(var2);
	}
	function validateColorsEdit()
	{
		this.api.network.Account.editCharacterColors(this._oColors.color1,this._oColors.color2,this._oColors.color3);
	}
	function setColors(var2)
	{
		this._oColors = var2;
		this._svCharacter.setColors(this._oColors);
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
						}
						break;
					default:
						if(var0 !== this._btnShowMount)
						{
							break;
						}
					case this._btnHideStuff:
						this.showMyself();
				}
			case this._btnCancel:
		}
		this.unloadThis();
	}
	function over(var2)
	{
		switch(var2.target)
		{
			case this._csColors:
				this.showColorPosition(var2.index);
				break;
			case this._mcRandomName:
				this.gapi.showTooltip(this.api.lang.getText("RANDOM_NICKNAME"),_root._xmouse,_root._ymouse - 20);
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
