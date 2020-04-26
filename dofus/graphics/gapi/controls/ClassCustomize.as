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
	function __set__classID(loc2)
	{
		this._nClassID = loc2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__classID();
	}
	function __set__sex(loc2)
	{
		this._nSex = loc2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__sex();
	}
	function __set__colors(loc2)
	{
		this.addToQueue({object:this,method:this.applyColor,params:[loc2[0],1]});
		this.addToQueue({object:this,method:this.applyColor,params:[loc2[1],2]});
		this.addToQueue({object:this,method:this.applyColor,params:[loc2[2],3]});
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
	function applyColor(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = this._nSelectedColorIndex;
		}
		var loc4 = {ColoredButton:{bgcolor:(loc2 != -1?loc2:16711680),highlightcolor:(loc2 != -1?loc2:16777215),bgdowncolor:(loc2 != -1?loc2:16711680),highlightdowncolor:(loc2 != -1?loc2:16777215)}};
		ank.gapi.styles.StylesManager.loadStylePackage(loc4);
		this["_btnColor" + loc3].styleName = "ColoredButton";
		this._oColors["color" + loc3] = loc2;
		this._oBakColors["color" + loc3] = loc2;
		this.updateSprite();
	}
	function setColorIndex(loc2)
	{
		var loc3 = this["_btnColor" + this._nSelectedColorIndex];
		var loc4 = this["_btnColor" + loc2];
		loc3.selected = false;
		loc4.selected = true;
		this._nSelectedColorIndex = loc2;
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
	function hideColorPosition(loc2)
	{
		delete this.onEnterFrame;
		this._oColors.color1 = this._oBakColors.color1;
		this._oColors.color2 = this._oBakColors.color2;
		this._oColors.color3 = this._oBakColors.color3;
		this.updateSprite();
	}
	function updateSprite()
	{
		var loc2 = this._ldrSprite.content;
		loc2.mcAnim.removeMovieClip();
		loc2.attachMovie(dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS[this._nSpriteAnimIndex],"mcAnim",10);
		loc2._xscale = loc2._yscale = 200;
	}
	function hideGenerateRandomName()
	{
		this._mcRegenerateNickName._visible = false;
	}
	function change(loc2)
	{
		switch(loc2.target._name)
		{
			case "_itCharacterName":
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
				}
				this.dispatchEvent({type:"nameChange",value:this._itCharacterName.text});
				break;
			case "_cpColorPicker":
				this.applyColor(loc2.value);
				this.dispatchEvent({type:"colorsChange",value:this._oColors});
		}
	}
	function initialization(loc2)
	{
		this.updateSprite();
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target._name)
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
					case "_btnColor1":
					case "_btnColor2":
					case "_btnColor3":
						var loc3 = Number(loc2.target._name.substr(9));
						var loc4 = this._oBakColors["color" + loc3];
						if(loc4 != -1)
						{
							this._cpColorPicker.setColor(loc4);
						}
						this.setColorIndex(loc3);
						break loop0;
					default:
						switch(null)
						{
							case "_btnReset2":
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
						var loc5 = Number(loc2.target._name.substr(9));
						this.applyColor(-1,loc5);
						this.dispatchEvent({type:"colorsChange",value:this._oColors});
				}
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnColor1":
			case "_btnColor2":
			case "_btnColor3":
				var loc3 = Number(loc2.target._name.substr(9));
				this.showColorPosition(loc3);
				break;
			default:
				if(loc0 !== "_mcRegenerateNickName")
				{
					break;
				}
				var loc4 = {x:this._mcRegenerateNickName._x,y:this._mcRegenerateNickName._y};
				this._mcRegenerateNickName.localToGlobal(loc4);
				this.gapi.showTooltip(this.api.lang.getText("RANDOM_NICKNAME"),loc4.x + this._x,loc4.y + this._y - 20);
				break;
		}
	}
	function out(loc2)
	{
		switch(loc2.target._name)
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
