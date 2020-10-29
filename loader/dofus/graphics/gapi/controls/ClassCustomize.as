class dofus.graphics.gapi.controls.ClassCustomize extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ClassCustomize";
	static var SPRITE_ANIMS = ["StaticF","StaticR","StaticL","WalkF","RunF","Anim2R","Anim2L"];
	static var NAME_GENERATION_DELAY = 500;
	var _nSpriteAnimIndex = 0;
	var _nLastRegenerateTimer = 0;
	function ClassCustomize()
	{
		super();
	}
	function __set__classID(var2)
	{
		this._nClassID = var2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__classID();
	}
	function __set__sex(var2)
	{
		this._nSex = var2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__sex();
	}
	function __set__colors(var2)
	{
		this.addToQueue({object:this,method:this.applyColor,params:[var2[0],1]});
		this.addToQueue({object:this,method:this.applyColor,params:[var2[1],2]});
		this.addToQueue({object:this,method:this.applyColor,params:[var2[2],3]});
		this.addToQueue({object:this,method:this.updateSprite});
		return this.__get__colors();
	}
	function __set__name(sName)
	{
		this.addToQueue({object:this,method:function()
		{
			if(this._itCharacterName.text != undefined)
			{
				this._itCharacterName.text = sName;
				this._itCharacterName.setFocus();
				Selection.setSelection(sName.length,sName.length);
			}
		}});
		return this.__get__name();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ClassCustomize.CLASS_NAME);
		this._mcRegenerateNickName._visible = false;
	}
	function createChildren()
	{
		this._visible = false;
		this._oColors = {color1:-1,color2:-1,color3:-1};
		this._oBakColors = {color1:-1,color2:-1,color3:-1};
		this.addToQueue({object:this,method:function()
		{
			this.setupRestriction();
		}});
		this.addToQueue({object:this,method:this.checkFeaturesAvailability});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.api.colors.addSprite(this._ldrSprite,this._oColors);
		this.addToQueue({object:this,method:this.setColorIndex,params:[1]});
		this.addToQueue({object:this,method:function()
		{
			this._itCharacterName.setFocus();
		}});
		this.addToQueue({object:this,method:function()
		{
			this._visible = true;
		}});
	}
	function setupRestriction()
	{
		if(this.api.datacenter.Player.isAuthorized)
		{
			this._itCharacterName.restrict = "a-zA-Z\\-\\[\\]";
		}
		else
		{
			this._itCharacterName.restrict = "a-zA-Z\\-";
		}
	}
	function checkFeaturesAvailability()
	{
		if(this.api.lang.getConfigText("GENERATE_RANDOM_NAME") && this.api.datacenter.Basics.aks_can_generate_names !== false)
		{
			this._mcRegenerateNickName._visible = true;
		}
	}
	function addListeners()
	{
		this._cpColorPicker.addEventListener("change",this);
		this._ldrSprite.addEventListener("initialization",this);
		this._btnNextAnim.addEventListener("click",this);
		this._btnPreviousAnim.addEventListener("click",this);
		this._btnReset1.addEventListener("click",this);
		this._btnReset2.addEventListener("click",this);
		this._btnReset3.addEventListener("click",this);
		this._btnColor1.addEventListener("click",this);
		this._btnColor2.addEventListener("click",this);
		this._btnColor3.addEventListener("click",this);
		this._btnColor1.addEventListener("over",this);
		this._btnColor2.addEventListener("over",this);
		this._btnColor3.addEventListener("over",this);
		this._btnColor1.addEventListener("out",this);
		this._btnColor2.addEventListener("out",this);
		this._btnColor3.addEventListener("out",this);
		this._itCharacterName.addEventListener("change",this);
		var ref = this;
		this._mcRegenerateNickName.onRelease = function()
		{
			ref.click({target:this});
		};
		this._mcRegenerateNickName.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcRegenerateNickName.onRollOut = function()
		{
			ref.out({target:this});
		};
	}
	function initTexts()
	{
		this._lblCharacterColors.text = this.api.lang.getText("SPRITE_COLORS");
		this._lblCharacterName.text = this.api.lang.getText("CREATE_CHARACTER_NAME");
	}
	function layoutContent()
	{
		if(this._nClassID == undefined || this._nSex == undefined)
		{
			return undefined;
		}
		this._ldrSprite.contentPath = dofus.Constants.CLIPS_PERSOS_PATH + this._nClassID + this._nSex + ".swf";
	}
	function applyColor(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = this._nSelectedColorIndex;
		}
		var var4 = {ColoredButton:{bgcolor:(var2 != -1?var2:16711680),highlightcolor:(var2 != -1?var2:16777215),bgdowncolor:(var2 != -1?var2:16711680),highlightdowncolor:(var2 != -1?var2:16777215)}};
		ank.gapi.styles.StylesManager.loadStylePackage(var4);
		this["_btnColor" + var3].styleName = "ColoredButton";
		this._oColors["color" + var3] = var2;
		this._oBakColors["color" + var3] = var2;
		this.updateSprite();
	}
	function setColorIndex(var2)
	{
		var var3 = this["_btnColor" + this._nSelectedColorIndex];
		var var4 = this["_btnColor" + var2];
		var3.selected = false;
		var4.selected = true;
		this._nSelectedColorIndex = var2;
	}
	function showColorPosition(nIndex)
	{
		var bWhite = true;
		this.onEnterFrame = function()
		{
			this._oColors["color" + nIndex] = !bWhite?16746632:16733525;
			this.updateSprite();
			bWhite = !bWhite;
		};
	}
	function hideColorPosition(var2)
	{
		delete this.onEnterFrame;
		this._oColors.color1 = this._oBakColors.color1;
		this._oColors.color2 = this._oBakColors.color2;
		this._oColors.color3 = this._oBakColors.color3;
		this.updateSprite();
	}
	function updateSprite()
	{
		var var2 = this._ldrSprite.content;
		var2.mcAnim.removeMovieClip();
		var2.attachMovie(dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS[this._nSpriteAnimIndex],"mcAnim",10);
		var2._xscale = var2._yscale = 200;
	}
	function hideGenerateRandomName()
	{
		this._mcRegenerateNickName._visible = false;
	}
	function change(var2)
	{
		switch(var2.target._name)
		{
			case "_itCharacterName":
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
				}
				this.dispatchEvent({type:"nameChange",value:this._itCharacterName.text});
				break;
			case "_cpColorPicker":
				this.applyColor(var2.value);
				this.dispatchEvent({type:"colorsChange",value:this._oColors});
		}
	}
	function initialization(var2)
	{
		this.updateSprite();
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnNextAnim":
				this._nSpriteAnimIndex++;
				if(this._nSpriteAnimIndex >= dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length)
				{
					this._nSpriteAnimIndex = 0;
				}
				this.updateSprite();
				break;
			case "_btnPreviousAnim":
				this._nSpriteAnimIndex--;
				if(this._nSpriteAnimIndex < 0)
				{
					this._nSpriteAnimIndex = dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length - 1;
				}
				this.updateSprite();
				break;
			default:
				switch(null)
				{
					case "_btnColor2":
					case "_btnColor3":
					default:
						switch(null)
						{
							case "_btnReset3":
								break;
							case "_mcRegenerateNickName":
								if(this._nLastRegenerateTimer + dofus.graphics.gapi.controls.ClassCustomize.NAME_GENERATION_DELAY < getTimer())
								{
									this.api.network.Account.getRandomCharacterName();
									this._nLastRegenerateTimer = dofus.graphics.gapi.controls.ClassCustomize.NAME_GENERATION_DELAY;
									break;
								}
						}
						break loop0;
					case "_btnReset1":
					case "_btnReset2":
						var var5 = Number(var2.target._name.substr(9));
						this.applyColor(-1,var5);
						this.dispatchEvent({type:"colorsChange",value:this._oColors});
				}
			case "_btnColor1":
				var var3 = Number(var2.target._name.substr(9));
				var var4 = this._oBakColors["color" + var3];
				if(var4 != -1)
				{
					this._cpColorPicker.setColor(var4);
				}
				this.setColorIndex(var3);
		}
	}
	function over(var2)
	{
		switch(var2.target._name)
		{
			case "_btnColor1":
			case "_btnColor2":
			case "_btnColor3":
				var var3 = Number(var2.target._name.substr(9));
				this.showColorPosition(var3);
				break;
			default:
				if(var0 !== "_mcRegenerateNickName")
				{
					break;
				}
				var var4 = {x:this._mcRegenerateNickName._x,y:this._mcRegenerateNickName._y};
				this._mcRegenerateNickName.localToGlobal(var4);
				this.gapi.showTooltip(this.api.lang.getText("RANDOM_NICKNAME"),var4.x + this._x,var4.y + this._y - 20);
				break;
		}
	}
	function out(var2)
	{
		switch(var2.target._name)
		{
			case "_btnColor1":
			case "_btnColor2":
			case "_btnColor3":
				this.hideColorPosition();
				break;
			default:
				this.gapi.hideTooltip();
		}
	}
}
