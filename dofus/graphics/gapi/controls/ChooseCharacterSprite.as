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
   function __set__showComboBox(bShowComboBox)
   {
      this._bShowComboBox = bShowComboBox;
      return this.__get__showComboBox();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      this.updateData();
      return this.__get__data();
   }
   function __get__data()
   {
      return this._oData;
   }
   function __set__selected(bSelected)
   {
      this._bSelected = bSelected;
      this.updateSelected(!bSelected?this.getStyle().overcolor:this.getStyle().selectedcolor);
      return this.__get__selected();
   }
   function __get__selected()
   {
      return this._bSelected;
   }
   function __set__deleteButton(bShow)
   {
      this._bDeleteButton = bShow;
      this._btnDelete._visible = bShow;
      return this.__get__deleteButton();
   }
   function __get__deleteButton()
   {
      return this._bDeleteButton;
   }
   function __set__isDead(bIsDead)
   {
      this._isDead = bIsDead;
      if(this._isDead)
      {
         var _loc3_ = {ra:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,rb:100,ga:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,gb:100,ba:dofus.graphics.gapi.controls.ChooseCharacterSprite.DEATH_ALPHA,bb:100};
      }
      else
      {
         _loc3_ = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
      }
      var _loc4_ = new Color(this._ldrSprite);
      _loc4_.setTransform(_loc3_);
      _loc4_ = new Color(this._ldrMerchant);
      _loc4_.setTransform(_loc3_);
      _loc4_ = new Color(this._mcGround._mcGround);
      _loc4_.setTransform(_loc3_);
      this._btnReset._visible = this._isDead;
      this._dcCharacter._visible = this._isDead;
      return this.__get__isDead();
   }
   function __get__isDead()
   {
      return this._isDead && this._isDead != undefined;
   }
   function __set__death(nDeath)
   {
      this._dcCharacter.death = nDeath;
      this._dcCharacter._alpha = 50;
      return this.__get__death();
   }
   function __set__deathState(nState)
   {
      this._nDeathState = nState;
      var ref = this;
      if(this._nDeathState == 2)
      {
         this.onEnterFrame = function()
         {
            ref._nCurrAlpha = ref._nCurrAlpha + ref._nCurrAlphaStep;
            var _loc2_ = ref._nCurrAlpha;
            if(ref._nCurrAlpha == 0)
            {
               ref._nCurrAlphaStep = 1;
            }
            if(ref._nCurrAlpha == 40)
            {
               ref._nCurrAlphaStep = -1;
            }
            var _loc3_ = {ra:_loc2_,rb:100,ga:_loc2_,gb:100,ba:_loc2_,bb:100};
            var _loc4_ = new Color(ref._ldrSprite);
            _loc4_.setTransform(_loc3_);
            _loc4_ = new Color(ref._ldrMerchant);
            _loc4_.setTransform(_loc3_);
            _loc4_ = new Color(ref._mcGround._mcGround);
            _loc4_.setTransform(_loc3_);
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
   function updateServer(nServerID)
   {
      if(nServerID != undefined)
      {
         this._nServerID = nServerID;
      }
      var _loc3_ = this.api.datacenter.Basics.aks_servers;
      var _loc4_ = 0;
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         var _loc6_ = _loc3_[_loc5_].id;
         if(_loc6_ == this._nServerID)
         {
            _loc4_ = _loc5_;
            this._oServer = _loc3_[_loc5_];
            break;
         }
         _loc5_ = _loc5_ + 1;
      }
      var _loc7_ = _loc3_[_loc4_];
      if(_loc7_ == undefined)
      {
         ank.utils.Logger.err("Serveur " + this._nServerID + " inconnu");
      }
      else
      {
         this.enabled = _loc7_.state == dofus.datacenter.Server.SERVER_ONLINE;
         this._ctrServerState.contentPath = "ChooseCharacterServerState" + _loc7_.state;
      }
      if(this._bShowComboBox && this._lblServer.text != undefined)
      {
         this._cbServers.dataProvider = _loc3_;
         this._cbServers.selectedIndex = _loc4_;
         this._cbServers.buttonIcon = "ComboBoxButtonNormalIcon";
         this._lblServer.text = "";
         this._cbServers.enabled = true;
      }
      else
      {
         this._cbServers.buttonIcon = "";
         this._lblServer.text = _loc7_.label;
         this._cbServers.enabled = false;
      }
   }
   function updateSelected(nColor)
   {
      if(this._bSelected || this._bOver && this._bEnabled)
      {
         this.setMovieClipColor(this._mcSelect,nColor);
         this._mcSelect.gotoAndPlay(1);
         this._mcSelect._visible = true;
      }
      else
      {
         this._mcSelect.stop();
         this._mcSelect._visible = false;
      }
   }
   function changeSpriteOrientation(mcSprite)
   {
      _global.clearInterval(this._nIntervalID);
      var _loc3_ = mcSprite.attachMovie("staticF","mcAnim",10);
      if(!_loc3_)
      {
         _loc3_ = mcSprite.attachMovie("staticR","mcAnim",10);
      }
      if(!_loc3_)
      {
         this.addToQueue({object:this,method:this.changeSpriteOrientation,params:[mcSprite]});
      }
   }
   function animCharacter(nAngle, bFirstTime)
   {
      var _loc4_ = 55;
      var _loc5_ = 100;
      if(nAngle == undefined)
      {
         nAngle = Math.atan2(this._ymouse - _loc5_,this._xmouse - _loc4_);
      }
      this._sDir = "F";
      this._bFlip = false;
      var _loc6_ = Math.PI / 8;
      if(nAngle < -9 * _loc6_)
      {
         this._sDir = "S";
         this._bFlip = true;
      }
      else if(nAngle < -5 * _loc6_)
      {
         this._sDir = "L";
      }
      else if(nAngle < -3 * _loc6_)
      {
         this._sDir = "B";
      }
      else if(nAngle < - _loc6_)
      {
         this._sDir = "L";
         this._bFlip = true;
      }
      else if(nAngle < _loc6_)
      {
         this._sDir = "S";
      }
      else if(nAngle < 3 * _loc6_)
      {
         this._sDir = "R";
      }
      else if(nAngle < 5 * _loc6_)
      {
         this._sDir = "F";
      }
      else if(nAngle < 7 * _loc6_)
      {
         this._sDir = "R";
         this._bFlip = true;
      }
      else
      {
         this._sDir = "S";
         this._bFlip = true;
      }
      var _loc7_ = "static";
      if(Key.isDown(Key.SHIFT))
      {
         _loc7_ = "walk";
      }
      if(Key.isDown(Key.CONTROL))
      {
         _loc7_ = "run";
      }
      this.setAnim(_loc7_);
   }
   function onKeyUp()
   {
      if(this._bSelected)
      {
         var _loc2_ = Number(String.fromCharCode(Key.getCode()));
         if(!_global.isNaN(_loc2_))
         {
            if(Key.isDown(Key.SHIFT))
            {
               _loc2_ = _loc2_ + 10;
            }
            this.setAnim("emote" + _loc2_);
         }
      }
   }
   function setAnim(sAnim, bResetDir)
   {
      if(bResetDir)
      {
         this._sDir = "R";
         this._bFlip = false;
      }
      var _loc4_ = sAnim + this._sDir;
      if(this._sOldAnim != _loc4_ || (!this._bFlip?180:-180) != this._mcSprite._xscale)
      {
         this._mcSprite.attachMovie(_loc4_,"anim",10);
         this._mcSprite._xscale = !this._bFlip?180:-180;
         this._sOldAnim = _loc4_;
      }
   }
   function initialization(oEvent)
   {
      this._mcSprite = oEvent.clip;
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
   function click(oEvent)
   {
      switch(oEvent.target)
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
   function over(oEvent)
   {
      switch(oEvent.target)
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
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function itemSelected(oEvent)
   {
      var _loc3_ = oEvent.target.selectedItem;
      this._nServerID = _loc3_.id;
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
   function modelChanged(oEvent)
   {
      if(this._oData != undefined)
      {
         this.updateServer();
         this.dispatchEvent({type:"unselect"});
      }
   }
}
