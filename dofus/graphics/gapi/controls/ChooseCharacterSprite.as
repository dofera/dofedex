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
	function __set__showComboBox(loc2)
	{
		this._bShowComboBox = loc2;
		return this.__get__showComboBox();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
		this.updateData();
		return this.__get__data();
	}
	function __get__data()
	{
		return this._oData;
	}
	function __set__selected(loc2)
	{
		this._bSelected = loc2;
		this.updateSelected(!loc2?this.getStyle().overcolor:this.getStyle().selectedcolor);
		return this.__get__selected();
	}
	function __get__selected()
	{
		return this._bSelected;
	}
	function __set__deleteButton(loc2)
	{
		this._bDeleteButton = loc2;
		this._btnDelete._visible = loc2;
		return this.__get__deleteButton();
	}
	function __get__deleteButton()
	{
		return this._bDeleteButton;
	}
	function __set__isDead(loc2)
	{
		this._isDead = loc2;
		if(this._isDead)
		{
			var loc3 = {ra:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,rb:100,ga:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,gb:100,ba:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,bb:100};
		}
		else
		{
			loc3 = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
		}
		var loc4 = new Color(this._ldrSprite);
		loc4.setTransform(loc3);
		loc4 = new Color(this._ldrMerchant);
		loc4.setTransform(loc3);
		loc4 = new Color(this._mcGround._mcGround);
		loc4.setTransform(loc3);
		this._btnReset._visible = this._isDead;
		this._dcCharacter._visible = this._isDead;
		return this.__get__isDead();
	}
	function __get__isDead()
	{
		return this._isDead && this._isDead != undefined;
	}
	function __set__death(loc2)
	{
		this._dcCharacter.death = loc2;
		this._dcCharacter._alpha = 50;
		return this.__get__death();
	}
	function __set__deathState(loc2)
	{
		this._nDeathState = loc2;
		var ref = this;
		if(this._nDeathState == 2)
		{
			this.onEnterFrame = function()
			{
				ref._nCurrAlpha = ref._nCurrAlpha + ref._nCurrAlphaStep;
				var loc2 = ref._nCurrAlpha;
				if(ref._nCurrAlpha == 0)
				{
					ref._nCurrAlphaStep = 1;
				}
				if(ref._nCurrAlpha == 40)
				{
					ref._nCurrAlphaStep = -1;
				}
				var loc3 = {ra:loc2,rb:100,ga:loc2,gb:100,ba:loc2,bb:100};
				var loc4 = new Color(ref._ldrSprite);
				loc4.setTransform(loc3);
				loc4 = new Color(ref._ldrMerchant);
				loc4.setTransform(loc3);
				loc4 = new Color(ref._mcGround._mcGround);
				loc4.setTransform(loc3);
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
	function updateServer(loc2)
	{
		if(loc2 != undefined)
		{
			this._nServerID = loc2;
		}
		var loc3 = this.api.datacenter.Basics.aks_servers;
		var loc4 = 0;
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = loc3[loc5].id;
			if(loc6 == this._nServerID)
			{
				loc4 = loc5;
				this._oServer = loc3[loc5];
				break;
			}
			loc5 = loc5 + 1;
		}
		var loc7 = loc3[loc4];
		if(loc7 == undefined)
		{
			ank.utils.Logger.err("Serveur " + this._nServerID + " inconnu");
		}
		else
		{
			this.enabled = loc7.state == dofus.datacenter.Server.SERVER_ONLINE;
			this._ctrServerState.contentPath = "ChooseCharacterServerState" + loc7.state;
		}
		if(this._bShowComboBox && this._lblServer.text != undefined)
		{
			this._cbServers.dataProvider = loc3;
			this._cbServers.selectedIndex = loc4;
			this._cbServers.buttonIcon = "ComboBoxButtonNormalIcon";
			this._lblServer.text = "";
			this._cbServers.enabled = true;
		}
		else
		{
			this._cbServers.buttonIcon = "";
			this._lblServer.text = loc7.label;
			this._cbServers.enabled = false;
		}
	}
	function updateSelected(loc2)
	{
		if(this._bSelected || this._bOver && this._bEnabled)
		{
			this.setMovieClipColor(this._mcSelect,loc2);
			this._mcSelect.gotoAndPlay(1);
			this._mcSelect._visible = true;
		}
		else
		{
			this._mcSelect.stop();
			this._mcSelect._visible = false;
		}
	}
	function changeSpriteOrientation(loc2)
	{
		_global.clearInterval(this._nIntervalID);
		var loc3 = loc2.attachMovie("staticF","mcAnim",10);
		if(!loc3)
		{
			loc3 = loc2.attachMovie("staticR","mcAnim",10);
		}
		if(!loc3)
		{
			this.addToQueue({object:this,method:this.changeSpriteOrientation,params:[loc2]});
		}
	}
	function animCharacter(loc2, loc3)
	{
		var loc4 = 55;
		var loc5 = 100;
		if(loc2 == undefined)
		{
			loc2 = Math.atan2(this._ymouse - loc5,this._xmouse - loc4);
		}
		this._sDir = "F";
		this._bFlip = false;
		var loc6 = Math.PI / 8;
		if(loc2 < -9 * loc6)
		{
			this._sDir = "S";
			this._bFlip = true;
		}
		else if(loc2 < -5 * loc6)
		{
			this._sDir = "L";
		}
		else if(loc2 < -3 * loc6)
		{
			this._sDir = "B";
		}
		else if(loc2 < - loc6)
		{
			this._sDir = "L";
			this._bFlip = true;
		}
		else if(loc2 < loc6)
		{
			this._sDir = "S";
		}
		else if(loc2 < 3 * loc6)
		{
			this._sDir = "R";
		}
		else if(loc2 < 5 * loc6)
		{
			this._sDir = "F";
		}
		else if(loc2 < 7 * loc6)
		{
			this._sDir = "R";
			this._bFlip = true;
		}
		else
		{
			this._sDir = "S";
			this._bFlip = true;
		}
		var loc7 = "static";
		if(Key.isDown(Key.SHIFT))
		{
			loc7 = "walk";
		}
		if(Key.isDown(Key.CONTROL))
		{
			loc7 = "run";
		}
		this.setAnim(loc7);
	}
	function onKeyUp()
	{
		if(this._bSelected)
		{
			var loc2 = Number(String.fromCharCode(Key.getCode()));
			if(!_global.isNaN(loc2))
			{
				if(Key.isDown(Key.SHIFT))
				{
					loc2 = loc2 + 10;
				}
				this.setAnim("emote" + loc2);
			}
		}
	}
	function setAnim(loc2, loc3)
	{
		if(loc3)
		{
			this._sDir = "R";
			this._bFlip = false;
		}
		var loc4 = loc2 + this._sDir;
		if(this._sOldAnim != loc4 || (!this._bFlip?180:-180) != this._mcSprite._xscale)
		{
			this._mcSprite.attachMovie(loc4,"anim",10);
			this._mcSprite._xscale = !this._bFlip?180:-180;
			this._sOldAnim = loc4;
		}
	}
	function initialization(loc2)
	{
		this._mcSprite = loc2.clip;
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
	function click(loc2)
	{
		switch(loc2.target)
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
	function over(loc2)
	{
		switch(loc2.target)
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
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function itemSelected(loc2)
	{
		var loc3 = loc2.target.selectedItem;
		this._nServerID = loc3.id;
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
	function modelChanged(loc2)
	{
		if(this._oData != undefined)
		{
			this.updateServer();
			this.dispatchEvent({type:"unselect"});
		}
	}
}
