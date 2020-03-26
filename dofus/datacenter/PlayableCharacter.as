class dofus.datacenter.PlayableCharacter extends ank.battlefield.datacenter.Sprite
{
   var _summoned = false;
   function PlayableCharacter(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
   {
      super();
      if(this.__proto__ == dofus.datacenter.PlayableCharacter.prototype)
      {
         this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID);
      }
   }
   function initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
   {
      super.initialize(sID,clipClass,sGfxFile,cellNum,dir);
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
   function updateLP(dLP)
   {
      this.LP = this.LP + Number(dLP);
      if(dLP < 0 && this.api.datacenter.Game.isFight)
      {
         this.LPmax = this.LPmax - Math.floor((- dLP) * this.api.lang.getConfigText("PERMANENT_DAMAGE"));
         if(this.api.datacenter.Player.ID == this.id)
         {
            this.api.datacenter.Player.LPmax = this.LPmax;
            this.api.ui.getUIComponent("Banner").lpmaxChanged({value:this.LPmax});
            this.api.ui.getUIComponent("StatJob").lpMaxChanged({value:this.LPmax});
         }
         this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
      }
      this.api.gfx.addSpritePoints(this.id,String(dLP),16711680);
      if(dLP < 0)
      {
         this.mc.setAnim("Hit");
      }
   }
   function initLP(Void)
   {
      this.LP = this.LPmax;
   }
   function updateAP(dAP, bUsed)
   {
      if(bUsed == undefined)
      {
         bUsed = false;
      }
      if(this.api.datacenter.Game.currentPlayerID != this.id && bUsed)
      {
         return undefined;
      }
      this.AP = this.AP + Number(dAP);
      this.AP = Math.max(0,this.AP);
      this.api.gfx.addSpritePoints(this.id,String(dAP),255);
   }
   function initAP(bWithModerator)
   {
      if(bWithModerator == undefined)
      {
         bWithModerator = true;
      }
      if(bWithModerator)
      {
         var _loc3_ = this.CharacteristicsManager.getModeratorValue("1");
         this.AP = Number(this.APinit) + Number(_loc3_);
      }
      else
      {
         this.AP = Number(this.APinit);
      }
   }
   function updateMP(dMP, bUsed)
   {
      if(bUsed == undefined)
      {
         bUsed = false;
      }
      if(this.api.datacenter.Game.currentPlayerID != this.id && bUsed)
      {
         return undefined;
      }
      this.MP = this.MP + Number(dMP);
      this.MP = Math.max(0,this.MP);
      this.api.gfx.addSpritePoints(this.id,String(dMP),26112);
   }
   function initMP(bWithModerator)
   {
      if(bWithModerator == undefined)
      {
         bWithModerator = true;
      }
      if(bWithModerator)
      {
         var _loc3_ = this.CharacteristicsManager.getModeratorValue("23");
         this.MP = Number(this.MPinit) + Number(_loc3_);
      }
      else
      {
         this.MP = Number(this.MPinit);
      }
   }
   function isInState(stateID)
   {
      return this._states[stateID] == true;
   }
   function setState(stateID, bActivate)
   {
      this._states[stateID] = bActivate;
   }
   function __get__gfxID()
   {
      return this._gfxID;
   }
   function __set__gfxID(value)
   {
      this._gfxID = value;
      return this.__get__gfxID();
   }
   function __get__name()
   {
      return this._name;
   }
   function __set__name(value)
   {
      this._name = value;
      return this.__get__name();
   }
   function __get__Level()
   {
      return this._level;
   }
   function __set__Level(value)
   {
      this._level = Number(value);
      this.broadcastMessage("onSetLevel",value);
      return this.__get__Level();
   }
   function __get__XP()
   {
      return this._xp;
   }
   function __set__XP(value)
   {
      this._xp = Number(value);
      this.broadcastMessage("onSetXP",value);
      return this.__get__XP();
   }
   function __get__LP()
   {
      return this._lp;
   }
   function __set__LP(value)
   {
      this._lp = Number(value) <= 0?0:Number(value);
      this.dispatchEvent({type:"lpChanged",value:value});
      this.broadcastMessage("onSetLP",value,this.LPmax);
      return this.__get__LP();
   }
   function __get__LPmax()
   {
      return this._lpmax;
   }
   function __set__LPmax(value)
   {
      this._lpmax = Number(value);
      this.broadcastMessage("onSetLP",this.LP,value);
      return this.__get__LPmax();
   }
   function __get__AP()
   {
      return this._ap;
   }
   function __set__AP(value)
   {
      this._ap = Number(value);
      this.dispatchEvent({type:"apChanged",value:value});
      this.broadcastMessage("onSetAP",value);
      return this.__get__AP();
   }
   function __get__APinit()
   {
      return this._apinit;
   }
   function __set__APinit(value)
   {
      this._apinit = Number(value);
      return this.__get__APinit();
   }
   function __get__MP()
   {
      return this._mp;
   }
   function __set__MP(value)
   {
      this._mp = Number(value);
      this.dispatchEvent({type:"mpChanged",value:value});
      this.broadcastMessage("onSetMP",value);
      return this.__get__MP();
   }
   function __get__MPinit()
   {
      return this._mpinit;
   }
   function __set__MPinit(value)
   {
      this._mpinit = Number(value);
      return this.__get__MPinit();
   }
   function __get__Kama()
   {
      return this._kama;
   }
   function __set__Kama(value)
   {
      this._kama = Number(value);
      this.broadcastMessage("onSetKama",value);
      return this.__get__Kama();
   }
   function __get__Team()
   {
      return this._team;
   }
   function __set__Team(value)
   {
      this._team = Number(value);
      return this.__get__Team();
   }
   function __get__Weapon()
   {
      return this._aAccessories[0];
   }
   function __get__ToolAnimation()
   {
      var _loc2_ = this.Weapon.unicID;
      var _loc3_ = this.api.lang.getItemUnicText(_loc2_);
      if(_loc3_.an == undefined)
      {
         if(this.api.datacenter.Game.isFight)
         {
            return "anim0";
         }
         return "anim3";
      }
      return "anim" + _loc3_.an;
   }
   function __get__artworkFile()
   {
      return dofus.Constants.ARTWORKS_BIG_PATH + this._gfxID + ".swf";
   }
   function __get__states()
   {
      return this._states;
   }
   function __set__isSummoned(bIsSummoned)
   {
      this._summoned = bIsSummoned;
      return this.__get__isSummoned();
   }
   function __get__isSummoned(bIsSummoned)
   {
      return this._summoned;
   }
}
