class dofus.graphics.gapi.controls.ChooseCharacterSprite extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChooseCharacterSprite";
	static var DEATH_ALPHA = 40;
	var _bSelected = false;
	var _bOver = false;
	var _isDead = false;
	var _nDeathState = 0;
	var _nCurrAlpha = dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA;
	var _nCurrAlphaStep = -1;
	function ChooseCharacterSprite()
	{
		super();
	}
	function __set__showComboBox(var2)
	{
		this._bShowComboBox = var2;
		return this.__get__showComboBox();
	}
	function __set__data(var2)
	{
		this._oData = var2;
		this.updateData();
		return this.__get__data();
	}
	function __get__data()
	{
		return this._oData;
	}
	function __set__selected(var2)
	{
		this._bSelected = var2;
		this.updateSelected(!var2?this.getStyle().overcolor:this.getStyle().selectedcolor);
		return this.__get__selected();
	}
	function __get__selected()
	{
		return this._bSelected;
	}
	function __set__deleteButton(var2)
	{
		this._bDeleteButton = var2;
		this._btnDelete._visible = var2;
		return this.__get__deleteButton();
	}
	function __get__deleteButton()
	{
		return this._bDeleteButton;
	}
	function __set__isDead(var2)
	{
		this._isDead = var2;
		if(this._isDead)
		{
			var var3 = {ra:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,rb:100,ga:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,gb:100,ba:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,bb:100};
		}
		else
		{
			var3 = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
		}
		var var4 = new Color(this._ldrSprite);
		var4.setTransform(var3);
		var4 = new Color(this._ldrMerchant);
		var4.setTransform(var3);
		var4 = new Color(this._mcGround._mcGround);
		var4.setTransform(var3);
		this._btnReset._visible = this._isDead;
		this._dcCharacter._visible = this._isDead;
		return this.__get__isDead();
	}
	function __get__isDead()
	{
		return this._isDead && this._isDead != undefined;
	}
	function __set__death(var2)
	{
		this._dcCharacter.death = var2;
		this._dcCharacter._alpha = 50;
		return this.__get__death();
	}
	function __set__deathState(var2)
	{
		this._nDeathState = var2;
		var ref = this;
		if(this._nDeathState == 2)
		{
			this.onEnterFrame = function()
			{
				ref._nCurrAlpha = ref._nCurrAlpha + ref._nCurrAlphaStep;
				var var2 = ref._nCurrAlpha;
				if(ref._nCurrAlpha == 0)
				{
					ref._nCurrAlphaStep = 1;
				}
				if(ref._nCurrAlpha == 40)
				{
					ref._nCurrAlphaStep = -1;
				}
				var var3 = {ra:var2,rb:100,ga:var2,gb:100,ba:var2,bb:100};
				var var4 = new Color(ref._ldrSprite);
				var4.setTransform(var3);
				var4 = new Color(ref._ldrMerchant);
				var4.setTransform(var3);
				var4 = new Color(ref._mcGround._mcGround);
				var4.setTransform(var3);
			};
		}
		else
		{
			delete this.onEnterFrame;
		}
		return this.__get__deathState();
	}
	function __get__deathState()
	{
		return this._nDeathState;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ChooseCharacterSprite.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this._btnDelete._visible = false;
		this._btnReset._visible = false;
	}
	function addListeners()
	{
		this._ldrSprite.addEventListener("initialization",this);
		this._btnDelete.addEventListener("click",this);
		this._btnDelete.addEventListener("over",this);
		this._btnDelete.addEventListener("out",this);
		this._btnReset.addEventListener("click",this);
		this._btnReset.addEventListener("over",this);
		this._btnReset.addEventListener("out",this);
		this._cbServers.addEventListener("itemSelected",this);
		this._ctrServerState.addEventListener("over",this);
		this._ctrServerState.addEventListener("out",this);
		this.api.datacenter.Basics.aks_servers.addEventListener("modelChanged",this);
		Key.addListener(this);
	}
	function initData()
	{
		this.updateData();
	}
	function setEnabled()
	{
		if(this._bEnabled)
		{
			this._mcInteraction.launchAnimCharacter = function()
			{
				this._parent.onEnterFrame = this._parent.animCharacter;
			};
			this._mcInteraction.onPress = function()
			{
				ank.utils.Timer.setTimer(this,"AnimCharacter",this,this.launchAnimCharacter,500);
			};
			this._mcInteraction.onRelease = function()
			{
				delete this._parent.onEnterFrame;
				this._parent.innerRelease();
				ank.utils.Timer.removeTimer(this,"AnimCharacter");
			};
			this._mcInteraction.onRollOver = this._mcInteraction.onDragOver = function()
			{
				this._parent.innerOver();
			};
			this._mcInteraction.onRollOut = this._mcInteraction.onReleaseOutside = function()
			{
				delete this._parent.onEnterFrame;
				this._parent.innerOut();
			};
			this._mcInteraction.onDragOut = function()
			{
				this._parent.innerOut();
			};
			this._mcUnknown._visible = false;
		}
		else
		{
			delete this._mcInteraction.onRelease;
			delete this._mcInteraction.onRollOver;
			delete this._mcInteraction.onRollOut;
			delete this._mcInteraction.onReleaseOutside;
			delete this._mcInteraction.onPress;
			delete this._mcInteraction.onDragOut;
			delete this._mcInteraction.onDragOver;
			this._mcUnknown._visible = true;
			this.selected = false;
		}
		this.isDead = this._isDead;
	}
	function updateData()
	{
		if(this._oData != undefined)
		{
			this._lblName.text = this._oData.name;
			this._lblLevel.text = this._oData.Level == undefined?this._oData.title:this.api.lang.getText("LEVEL") + " " + this._oData.Level;
			if(this._oData.Merchant)
			{
				this._ldrMerchant.contentPath = dofus.Constants.EXTRA_PATH + "0.swf";
			}
			this._ldrSprite.forceReload = true;
			this._ldrSprite.contentPath = this._oData.gfxFile;
			this._btnDelete._visible = this._bDeleteButton;
			this._cbServers._visible = true;
			this.updateServer(this._oData.serverID);
			this._mcStateBack._visible = true;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._ldrSprite.forceReload = true;
			this._ldrSprite.contentPath = "";
			this._btnDelete._visible = false;
			this._cbServers._visible = false;
			this._ctrServerState.contentPath = "";
			this._mcStateBack._visible = false;
		}
	}
	function updateServer(var2)
	{
		if(var2 != undefined)
		{
			this._nServerID = var2;
		}
		var var3 = this.api.datacenter.Basics.aks_servers;
		var var4 = 0;
		var var5 = 0;
		while(var5 < var3.length)
		{
			var var6 = var3[var5].id;
			if(var6 == this._nServerID)
			{
				var4 = var5;
				this._oServer = var3[var5];
				break;
			}
			var5 = var5 + 1;
		}
		var var7 = var3[var4];
		if(var7 == undefined)
		{
			ank.utils.Logger.err("Serveur " + this._nServerID + " inconnu");
		}
		else
		{
			this.enabled = var7.state == dofus.datacenter.Server.SERVER_ONLINE;
			this._ctrServerState.contentPath = "ChooseCharacterServerState" + var7.state;
		}
		if(this._bShowComboBox && this._lblServer.text != undefined)
		{
			this._cbServers.dataProvider = var3;
			this._cbServers.selectedIndex = var4;
			this._cbServers.buttonIcon = "ComboBoxButtonNormalIcon";
			this._lblServer.text = "";
			this._cbServers.enabled = true;
		}
		else
		{
			this._cbServers.buttonIcon = "";
			this._lblServer.text = var7.label;
			this._cbServers.enabled = false;
		}
	}
	function updateSelected(var2)
	{
		if(this._bSelected || this._bOver && this._bEnabled)
		{
			this.setMovieClipColor(this._mcSelect,var2);
			this._mcSelect.gotoAndPlay(1);
			this._mcSelect._visible = true;
		}
		else
		{
			this._mcSelect.stop();
			this._mcSelect._visible = false;
		}
	}
	function changeSpriteOrientation(var2)
	{
		_global.clearInterval(this._nIntervalID);
		var var3 = var2.attachMovie("staticF","mcAnim",10);
		if(!var3)
		{
			var3 = var2.attachMovie("staticR","mcAnim",10);
		}
		if(!var3)
		{
			this.addToQueue({object:this,method:this.changeSpriteOrientation,params:[var2]});
		}
	}
	function animCharacter(var2, var3)
	{
		var var4 = 55;
		var var5 = 100;
		if(var2 == undefined)
		{
			var2 = Math.atan2(this._ymouse - var5,this._xmouse - var4);
		}
		this._sDir = "F";
		this._bFlip = false;
		var var6 = Math.PI / 8;
		if(var2 < -9 * var6)
		{
			this._sDir = "S";
			this._bFlip = true;
		}
		else if(var2 < -5 * var6)
		{
			this._sDir = "L";
		}
		else if(var2 < -3 * var6)
		{
			this._sDir = "B";
		}
		else if(var2 < - var6)
		{
			this._sDir = "L";
			this._bFlip = true;
		}
		else if(var2 < var6)
		{
			this._sDir = "S";
		}
		else if(var2 < 3 * var6)
		{
			this._sDir = "R";
		}
		else if(var2 < 5 * var6)
		{
			this._sDir = "F";
		}
		else if(var2 < 7 * var6)
		{
			this._sDir = "R";
			this._bFlip = true;
		}
		else
		{
			this._sDir = "S";
			this._bFlip = true;
		}
		var var7 = "static";
		if(Key.isDown(Key.SHIFT))
		{
			var7 = "walk";
		}
		if(Key.isDown(Key.CONTROL))
		{
			var7 = "run";
		}
		this.setAnim(var7);
	}
	function onKeyUp()
	{
		if(this._bSelected)
		{
			var var2 = Number(String.fromCharCode(Key.getCode()));
			if(!_global.isNaN(var2))
			{
				if(Key.isDown(Key.SHIFT))
				{
					var2 = var2 + 10;
				}
				this.setAnim("emote" + var2);
			}
		}
	}
	function setAnim(var2, var3)
	{
		if(var3)
		{
			this._sDir = "R";
			this._bFlip = false;
		}
		var var4 = var2 + this._sDir;
		if(this._sOldAnim != var4 || (!this._bFlip?180:-180) != this._mcSprite._xscale)
		{
			this._mcSprite.attachMovie(var4,"anim",10);
			this._mcSprite._xscale = !this._bFlip?180:-180;
			this._sOldAnim = var4;
		}
	}
	function initialization(var2)
	{
		this._mcSprite = var2.clip;
		this.gapi.api.colors.addSprite(this._mcSprite,this._oData);
		this._mcSprite._xscale = this._mcSprite._yscale = 180;
		this.addToQueue({object:this,method:this.changeSpriteOrientation,params:[this._mcSprite]});
	}
	function innerRelease()
	{
		if(this.isDead)
		{
			return undefined;
		}
		this.selected = true;
		this.dispatchEvent({type:"select",serverID:this._nServerID});
	}
	function innerOver()
	{
		if(this.isDead)
		{
			return undefined;
		}
		this._bOver = true;
		this.updateSelected(!this._bSelected?this.getStyle().overcolor:this.getStyle().selectedcolor);
	}
	function innerOut()
	{
		this._bOver = false;
		this.updateSelected(this.getStyle().selectedcolor);
	}
	function click(var2)
	{
		switch(var2.target)
		{
			case this._btnDelete:
				if(this._nDeathState == 2)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CAUTION_WRONG_DEAD_STATE"),"ERROR_BOX",{name:"noSelection",listener:this});
					return undefined;
				}
				this.dispatchEvent({type:"remove"});
				break;
			case this._btnReset:
				if(this._nDeathState == 2)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CAUTION_WRONG_DEAD_STATE"),"ERROR_BOX",{name:"noSelection",listener:this});
					return undefined;
				}
				this.dispatchEvent({type:"reset"});
				break;
		}
	}
	function over(var2)
	{
		switch(var2.target)
		{
			case this._btnDelete:
				this.gapi.showTooltip(this.api.lang.getText("DELETE_CHARACTER"),_root._xmouse,_root._ymouse - 20);
				break;
			case this._btnReset:
				this.gapi.showTooltip(this.api.lang.getText("RESET_CHARACTER"),_root._xmouse,_root._ymouse - 20);
				break;
			case this._ctrServerState:
				this.gapi.showTooltip(this._oServer.stateStr,_root._xmouse,_root._ymouse - 20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function itemSelected(var2)
	{
		var var3 = var2.target.selectedItem;
		this._nServerID = var3.id;
		this.updateServer();
		if(!this._bSelected && this._bEnabled)
		{
			this.innerRelease();
		}
		else if(!this._bEnabled)
		{
			this.dispatchEvent({type:"unselect"});
		}
	}
	function modelChanged(var2)
	{
		if(this._oData != undefined)
		{
			this.updateServer();
			this.dispatchEvent({type:"unselect"});
		}
	}
}
