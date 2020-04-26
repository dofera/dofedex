class dofus.datacenter.PlayableCharacter extends ank.battlefield.datacenter.Sprite
{
	var _summoned = false;
	function PlayableCharacter(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
	{
		super();
		if(this.__proto__ == dofus.datacenter.PlayableCharacter.prototype)
		{
			this.initialize(sID,clipClass,loc5,cellNum,loc7,gfxID);
		}
	}
	function initialize(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
	{
		super.initialize(sID,clipClass,loc5,cellNum,loc7);
		this.api = _global.API;
		this._gfxID = gfxID;
		this.GameActionsManager = new dofus.managers.GameActionsManager(this,this.api);
		this.CharacteristicsManager = new dofus.managers.CharacteristicsManager(this,this.api);
		this.EffectsManager = new dofus.managers.EffectsManager(this,this.api);
		if(sID == this.api.datacenter.Player.ID)
		{
			this._ap = this.api.datacenter.Player.AP;
			this._mp = this.api.datacenter.Player.MP;
		}
		AsBroadcaster.initialize(this);
		mx.events.EventDispatcher.initialize(this);
		this._states = new Object();
	}
	function updateLP(loc2)
	{
		this.LP = this.LP + Number(loc2);
		if(loc2 < 0 && this.api.datacenter.Game.isFight)
		{
			this.LPmax = this.LPmax - Math.floor((- loc2) * this.api.lang.getConfigText("PERMANENT_DAMAGE"));
			if(this.api.datacenter.Player.ID == this.id)
			{
				this.api.datacenter.Player.LPmax = this.LPmax;
				this.api.ui.getUIComponent("Banner").lpMaxChanged({value:this.LPmax});
				this.api.ui.getUIComponent("StatJob").lpMaxChanged({value:this.LPmax});
			}
			this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
		}
		this.api.gfx.addSpritePoints(this.id,String(loc2),16711680);
		if(loc2 < 0 && !this.api.datacenter.Player.isSkippingFightAnimations)
		{
			this.mc.setAnim("Hit");
		}
	}
	function initLP(loc2)
	{
		this.LP = this.LPmax;
	}
	function updateAP(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = false;
		}
		if(this.api.datacenter.Game.currentPlayerID != this.id && loc3)
		{
			return undefined;
		}
		this.AP = this.AP + Number(loc2);
		this.AP = Math.max(0,this.AP);
		this.api.gfx.addSpritePoints(this.id,String(loc2),255);
	}
	function initAP(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = true;
		}
		if(loc2)
		{
			var loc3 = this.CharacteristicsManager.getModeratorValue("1");
			this.AP = Number(this.APinit) + Number(loc3);
		}
		else
		{
			this.AP = Number(this.APinit);
		}
	}
	function updateMP(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = false;
		}
		if(this.api.datacenter.Game.currentPlayerID != this.id && loc3)
		{
			return undefined;
		}
		this.MP = this.MP + Number(loc2);
		this.MP = Math.max(0,this.MP);
		this.api.gfx.addSpritePoints(this.id,String(loc2),26112);
	}
	function initMP(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = true;
		}
		if(loc2)
		{
			var loc3 = this.CharacteristicsManager.getModeratorValue("23");
			this.MP = Number(this.MPinit) + Number(loc3);
		}
		else
		{
			this.MP = Number(this.MPinit);
		}
	}
	function isInState(loc2)
	{
		return this._states[loc2] == true;
	}
	function setState(loc2, loc3)
	{
		this._states[loc2] = loc3;
	}
	function __get__gfxID()
	{
		return this._gfxID;
	}
	function __set__gfxID(loc2)
	{
		this._gfxID = loc2;
		return this.__get__gfxID();
	}
	function __get__name()
	{
		return this._name;
	}
	function __set__name(loc2)
	{
		this._name = loc2;
		return this.__get__name();
	}
	function __get__Level()
	{
		return this._level;
	}
	function __set__Level(loc2)
	{
		this._level = Number(loc2);
		this.broadcastMessage("onSetLevel",loc2);
		return this.__get__Level();
	}
	function __get__XP()
	{
		return this._xp;
	}
	function __set__XP(loc2)
	{
		this._xp = Number(loc2);
		this.broadcastMessage("onSetXP",loc2);
		return this.__get__XP();
	}
	function __get__LP()
	{
		return this._lp;
	}
	function __set__LP(loc2)
	{
		this._lp = Number(loc2) <= 0?0:Number(loc2);
		this.dispatchEvent({type:"lpChanged",value:loc2});
		this.broadcastMessage("onSetLP",loc2,this.LPmax);
		return this.__get__LP();
	}
	function __get__LPmax()
	{
		return this._lpmax;
	}
	function __set__LPmax(loc2)
	{
		this._lpmax = Number(loc2);
		this.broadcastMessage("onSetLP",this.LP,loc2);
		return this.__get__LPmax();
	}
	function __get__AP()
	{
		return this._ap;
	}
	function __set__AP(loc2)
	{
		this._ap = Number(loc2);
		this.dispatchEvent({type:"apChanged",value:loc2});
		this.broadcastMessage("onSetAP",loc2);
		return this.__get__AP();
	}
	function __get__APinit()
	{
		return this._apinit;
	}
	function __set__APinit(loc2)
	{
		this._apinit = Number(loc2);
		return this.__get__APinit();
	}
	function __get__MP()
	{
		return this._mp;
	}
	function __set__MP(loc2)
	{
		this._mp = Number(loc2);
		this.dispatchEvent({type:"mpChanged",value:loc2});
		this.broadcastMessage("onSetMP",loc2);
		return this.__get__MP();
	}
	function __get__MPinit()
	{
		return this._mpinit;
	}
	function __set__MPinit(loc2)
	{
		this._mpinit = Number(loc2);
		return this.__get__MPinit();
	}
	function __get__Kama()
	{
		return this._kama;
	}
	function __set__Kama(loc2)
	{
		this._kama = Number(loc2);
		this.broadcastMessage("onSetKama",loc2);
		return this.__get__Kama();
	}
	function __get__Team()
	{
		return this._team;
	}
	function __set__Team(loc2)
	{
		this._team = Number(loc2);
		return this.__get__Team();
	}
	function __get__Weapon()
	{
		return this._aAccessories[0];
	}
	function __get__ToolAnimation()
	{
		var loc2 = this.Weapon.unicID;
		var loc3 = this.api.lang.getItemUnicText(loc2);
		if(loc3.an == undefined)
		{
			if(this.api.datacenter.Game.isFight)
			{
				return "anim0";
			}
			return "anim3";
		}
		return "anim" + loc3.an;
	}
	function __get__artworkFile()
	{
		return dofus.Constants.ARTWORKS_BIG_PATH + this._gfxID + ".swf";
	}
	function __get__states()
	{
		return this._states;
	}
	function __set__isSummoned(loc2)
	{
		this._summoned = loc2;
		return this.__get__isSummoned();
	}
	function __get__isSummoned(loc2)
	{
		return this._summoned;
	}
}
