class dofus.graphics.gapi.controls.ChooseServerSprite extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ChooseServerSprite";
   static var MAX_CHARS_DISPLAYED = 5;
   var _bSelected = false;
   var _bOver = false;
   function ChooseServerSprite()
   {
      super();
      this._lblNumChar._visible = false;
      this._mcNumChar._visible = false;
   }
   function __set__serverID(nServerID)
   {
      this._nServerID = nServerID;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__serverID();
   }
   function __get__serverID()
   {
      return this._nServerID;
   }
   function __get__server()
   {
      var _loc2_ = this.api.datacenter.Basics.aks_servers;
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         if(_loc2_[_loc3_].id == this._nServerID)
         {
            return _loc2_[_loc3_];
         }
         _loc3_ = _loc3_ + 1;
      }
      return undefined;
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
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ChooseServerSprite.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      this._ldrSprite.addEventListener("initialization",this);
      this._ldrSprite.addEventListener("error",this);
      this._ctrServerState.addEventListener("over",this);
      this._ctrServerState.addEventListener("out",this);
      this._lblState.onRelease = function()
      {
         getURL(this._parent.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
      };
      this._ctrServerState.onRelease = function()
      {
         getURL(this._parent.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
      };
      this.api.datacenter.Basics.aks_servers.addEventListener("modelChanged",this);
   }
   function setEnabled()
   {
      if(this._bEnabled)
      {
         this._mcInteraction.onRelease = function()
         {
            this._parent.innerRelease();
         };
         this._mcInteraction.onRollOver = function()
         {
            this._parent.innerOver();
         };
         this._mcInteraction.onRollOut = this._mcInteraction.onReleaseOutside = function()
         {
            this._parent.innerOut();
         };
         this.setMovieClipTransform(this,{ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      }
      else
      {
         delete this._mcInteraction.onRelease;
         delete this._mcInteraction.onRollOver;
         delete this._mcInteraction.onRollOut;
         delete this._mcInteraction.onReleaseOutside;
         this.setMovieClipTransform(this,this.getStyle().desabledtransform);
         this.selected = false;
      }
   }
   function updateData()
   {
      var _loc2_ = this.server;
      var _loc3_ = 0;
      while(_loc3_ < dofus.graphics.gapi.controls.ChooseServerSprite.MAX_CHARS_DISPLAYED + 1)
      {
         this["Bonhomme" + _loc3_].removeMovieClip();
         _loc3_ = _loc3_ + 1;
      }
      this._lblNumChar._visible = false;
      this._mcNumChar._visible = false;
      if(_loc2_ != undefined)
      {
         this._lblName.text = _loc2_.label;
         var _loc4_ = _loc2_.charactersCount;
         if(_loc4_ <= dofus.graphics.gapi.controls.ChooseServerSprite.MAX_CHARS_DISPLAYED)
         {
            var _loc5_ = 3;
            var _loc6_ = (112 - _loc4_ * (14.5 + _loc5_)) / 2;
            var _loc7_ = _loc6_;
            var _loc8_ = 165;
            var _loc9_ = 0;
            while(_loc9_ < _loc4_)
            {
               var _loc10_ = this.attachMovie("Bonhomme","Bonhomme" + _loc9_,_loc9_,{_x:_loc7_,_y:_loc8_});
               _loc7_ = _loc7_ + (_loc5_ + 14.5);
               _loc9_ = _loc9_ + 1;
            }
         }
         else
         {
            this._lblNumChar._visible = true;
            this._mcNumChar._visible = true;
            this._lblNumChar.text = "x" + _loc4_;
         }
         this._lblState.text = _loc2_.stateStrShort;
         this._ldrSprite.forceReload = true;
         this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + _loc2_.id + ".swf";
         this.enabled = _loc2_.state == dofus.datacenter.Server.SERVER_ONLINE;
         this._ctrServerState.contentPath = _loc2_.state != dofus.datacenter.Server.SERVER_ONLINE?"NewCross":"NewValid";
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblState.text = "";
         this._ldrSprite.contentPath = "";
         this._ctrServerState.contentPath = "";
         this.enabled = false;
      }
   }
   function updateSelected(nColor)
   {
      if(this._bSelected || this._bOver && this._bEnabled)
      {
         this._mcSelect.gotoAndPlay(1);
         this._mcSelect._visible = true;
      }
      else
      {
         this._mcSelect.stop();
         this._mcSelect._visible = false;
      }
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.clip;
   }
   function error(oEvent)
   {
      this._ldrSprite.forceReload = true;
      this._ldrSprite.contentPath = dofus.Constants.SERVER_SYMBOL_PATH + "0.swf";
   }
   function innerRelease()
   {
      this.selected = true;
      this.dispatchEvent({type:"select",serverID:this._nServerID});
   }
   function innerOver()
   {
      this._bOver = true;
      this.updateSelected(!this._bSelected?this.getStyle().overcolor:this.getStyle().selectedcolor);
   }
   function innerOut()
   {
      this._bOver = false;
      this.updateSelected(this.getStyle().selectedcolor);
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._ctrServerState)
      {
         this.gapi.showTooltip(this.server.stateStr,_root._xmouse,_root._ymouse - 20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function modelChanged(oEvent)
   {
      this.updateData();
      this.dispatchEvent({type:"unselect"});
   }
}
