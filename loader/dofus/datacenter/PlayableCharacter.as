class dofus.datacenter.PlayableCharacter extends ank.battlefield.datacenter.Sprite
{
	var _summoned = false;
	function PlayableCharacter(sID, clipClass, §\x1e\x11\x1c§, §\x13\x05§, §\x10\x1d§, gfxID)
	{
		super();
		if(this.__proto__ == dofus.datacenter.PlayableCharacter.prototype)
		{
			this.initialize(sID,clipClass,var5,var6,var7,gfxID);
		}
	}
	function initialize(sID, clipClass, §\x1e\x11\x1c§, §\x13\x05§, §\x10\x1d§, gfxID)
	{
		super.initialize(sID,clipClass,var5,var6,var7);
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
		eval(mx).events.EventDispatcher.initialize(this);
		this._states = new Object();
	}
	function updateLP(var2)
	{
		this.LP = this.LP + Number(var2);
		if(var2 < 0 && this.api.datacenter.Game.isFight)
		{
			this.LPmax = this.LPmax - Math.floor((- var2) * this.api.lang.getConfigText("PERMANENT_DAMAGE"));
			if(this.api.datacenter.Player.ID == this.id)
			{
				this.api.datacenter.Player.LPmax = this.LPmax;
				this.api.ui.getUIComponent("Banner").lpMaxChanged({value:this.LPmax});
				this.api.ui.getUIComponent("StatJob").lpMaxChanged({value:this.LPmax});
			}
			this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
		}
		this.api.gfx.addSpritePoints(this.id,String(var2),16711680);
		if(var2 < 0 && (!this.api.datacenter.Player.isSkippingFightAnimations && this.api.electron.isWindowFocused))
		{
			this.mc.setAnim("Hit");
		}
	}
	function initLP(var2)
	{
		this.LP = this.LPmax;
	}
	function updateAP(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		if(this.api.datacenter.Game.currentPlayerID != this.id && var3)
		{
			return undefined;
		}
		this.AP = this.AP + Number(var2);
		this.AP = Math.max(0,this.AP);
		this.api.gfx.addSpritePoints(this.id,String(var2),255);
	}
	function initAP(var2)
	{
		if(var2 == undefined)
		{
			var2 = true;
		}
		if(var2)
		{
			var var3 = this.CharacteristicsManager.getModeratorValue("1");
			this.AP = Number(this.APinit) + Number(var3);
		}
		else
		{
			this.AP = Number(this.APinit);
		}
	}
	function updateMP(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		if(this.api.datacenter.Game.currentPlayerID != this.id && var3)
		{
			return undefined;
		}
		this.MP = this.MP + Number(var2);
		this.MP = Math.max(0,this.MP);
		this.api.gfx.addSpritePoints(this.id,String(var2),26112);
	}
	function initMP(var2)
	{
		if(var2 == undefined)
		{
			var2 = true;
		}
		if(var2)
		{
			var var3 = this.CharacteristicsManager.getModeratorValue("23");
			this.MP = Number(this.MPinit) + Number(var3);
		}
		else
		{
			this.MP = Number(this.MPinit);
		}
	}
	function isInState(var2)
	{
		return this._states[var2] == true;
	}
	function setState(var2, var3)
	{
		this._states[var2] = var3;
	}
	function __get__gfxID()
	{
		return this._gfxID;
	}
	function __set__gfxID(var2)
	{
		this._gfxID = var2;
		return this.__get__gfxID();
	}
	function __get__name()
	{
		return this._name;
	}
	function __set__name(var2)
	{
		this._name = var2;
		return this.__get__name();
	}
	function __get__Level()
	{
		return this._level;
	}
	function __set__Level(var2)
	{
		this._level = Number(var2);
		this.broadcastMessage("onSetLevel",var2);
		return this.__get__Level();
	}
	function __get__XP()
	{
		return this._xp;
	}
	function __set__XP(var2)
	{
		this._xp = Number(var2);
		this.broadcastMessage("onSetXP",var2);
		return this.__get__XP();
	}
	function __get__LP()
	{
		return this._lp;
	}
	function __set__LP(var2)
	{
		this._lp = Number(var2) <= 0?0:Number(var2);
		this.dispatchEvent({type:"lpChanged",value:var2});
		this.broadcastMessage("onSetLP",var2,this.LPmax);
		return this.__get__LP();
	}
	function __get__LPmax()
	{
		return this._lpmax;
	}
	function __set__LPmax(var2)
	{
		this._lpmax = Number(var2);
		this.broadcastMessage("onSetLP",this.LP,var2);
		return this.__get__LPmax();
	}
	function __get__AP()
	{
		return this._ap;
	}
	function __set__AP(var2)
	{
		this._ap = Number(var2);
		this.dispatchEvent({type:"apChanged",value:var2});
		this.broadcastMessage("onSetAP",var2);
		return this.__get__AP();
	}
	function __get__APinit()
	{
		return this._apinit;
	}
	function __set__APinit(var2)
	{
		this._apinit = Number(var2);
		return this.__get__APinit();
	}
	function __get__MP()
	{
		return this._mp;
	}
	function __set__MP(var2)
	{
		this._mp = Number(var2);
		this.dispatchEvent({type:"mpChanged",value:var2});
		this.broadcastMessage("onSetMP",var2);
		return this.__get__MP();
	}
	function __get__MPinit()
	{
		return this._mpinit;
	}
	function __set__MPinit(var2)
	{
		this._mpinit = Number(var2);
		return this.__get__MPinit();
	}
	function __get__Kama()
	{
		return this._kama;
	}
	function __set__Kama(var2)
	{
		this._kama = Number(var2);
		this.broadcastMessage("onSetKama",var2);
		return this.__get__Kama();
	}
	function __get__Team()
	{
		return this._team;
	}
	function __set__Team(var2)
	{
		this._team = Number(var2);
		return this.__get__Team();
	}
	function __get__Weapon()
	{
		return this._aAccessories[0];
	}
	function __get__ToolAnimation()
	{
		var var2 = this.Weapon.unicID;
		var var3 = this.api.lang.getItemUnicText(var2);
		if(var3.an == undefined)
		{
			if(this.api.datacenter.Game.isFight)
			{
				return "anim0";
			}
			return "anim3";
		}
		return "anim" + var3.an;
	}
	function __get__artworkFile()
	{
		return dofus.Constants.ARTWORKS_BIG_PATH + this._gfxID + ".swf";
	}
	function __get__states()
	{
		return this._states;
	}
	function __set__isSummoned(var2)
	{
		this._summoned = var2;
		return this.__get__isSummoned();
	}
	function __get__isSummoned(var2)
	{
		return this._summoned;
	}
}
