class dofus.managers.KeyManager extends dofus.utils.ApiElement
{
   var _bIsBroadcasting = true;
   var _bPressedKeys = new Array();
   var _bCtrlDown = false;
   var _bShiftDown = true;
   static var _sSelf = null;
   var _nLastTriggerShow = 0;
   function KeyManager(oAPI)
   {
      super();
      dofus.managers.KeyManager._sSelf = this;
      this.initialize(oAPI);
   }
   function __get__Broadcasting()
   {
      return this._bIsBroadcasting;
   }
   function __set__Broadcasting(bIsBroadcasting)
   {
      this._bIsBroadcasting = bIsBroadcasting;
      return this.__get__Broadcasting();
   }
   static function getInstance()
   {
      return dofus.managers.KeyManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      Key.addListener(this);
      this._aAnyTimeShortcuts = new Array();
      this._aNoChatShortcuts = new Array();
      this._so = SharedObject.getLocal(this.api.datacenter.Player.login + dofus.Constants.GLOBAL_SO_SHORTCUTS_NAME);
      this._nCurrentSet = this.api.kernel.OptionsManager.getOption("ShortcutSet");
      this.loadShortcuts();
   }
   function addShortcutsListener(sMethod, oListener)
   {
      if(this._aListening == undefined)
      {
         this._aListening = new Array();
      }
      var _loc4_ = 0;
      while(_loc4_ < this._aListening.length)
      {
         if(String(this._aListening[_loc4_].o) == String(oListener) && this._aListening[_loc4_].m == sMethod)
         {
            this.removeShortcutsListener(this._aListening[_loc4_].o);
         }
         _loc4_ = _loc4_ + 1;
      }
      this._aListening.push({o:oListener,m:sMethod});
   }
   function removeShortcutsListener(oListener)
   {
      if(this._aListening == undefined)
      {
         return undefined;
      }
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < this._aListening.length)
      {
         if(this._aListening[_loc4_].o == oListener)
         {
            _loc3_.push(_loc4_);
         }
         _loc4_ = _loc4_ + 1;
      }
      _loc3_.sort(Array.DESCENDING);
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         this._aListening.splice(_loc3_[_loc5_],1);
         _loc5_ = _loc5_ + 1;
      }
   }
   function addKeysListener(sMethod, oListener)
   {
      if(this._aKeysListening == undefined)
      {
         this._aKeysListening = new Array();
      }
      var _loc4_ = 0;
      while(_loc4_ < this._aKeysListening.length)
      {
         if(String(this._aKeysListening[_loc4_].o) == String(oListener) && this._aKeysListening[_loc4_].m == sMethod)
         {
            this._aKeysListening[_loc4_] = undefined;
         }
         _loc4_ = _loc4_ + 1;
      }
      this._aKeysListening.push({o:oListener,m:sMethod});
   }
   function removeKeysListener(oListener)
   {
      if(this._aKeysListening == undefined)
      {
         return undefined;
      }
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < this._aKeysListening.length)
      {
         if(this._aKeysListening[_loc4_].o == oListener)
         {
            _loc3_.push(_loc4_);
         }
         _loc4_ = _loc4_ + 1;
      }
      _loc3_.sort(Array.DESCENDING);
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         this._aKeysListening.splice(_loc3_[_loc5_],1);
         _loc5_ = _loc5_ + 1;
      }
   }
   function getDefaultShortcut(sShortcut)
   {
      return this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet,sShortcut);
   }
   function getCurrentShortcut(sShortcut)
   {
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < this._aAnyTimeShortcuts.length)
      {
         if(this._aAnyTimeShortcuts[_loc4_].d == sShortcut)
         {
            _loc3_.push({k:this._aAnyTimeShortcuts[_loc4_].k,c:this._aAnyTimeShortcuts[_loc4_].c,d:this._aAnyTimeShortcuts[_loc4_].l});
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc5_ = 0;
      while(_loc5_ < this._aNoChatShortcuts.length)
      {
         if(this._aNoChatShortcuts[_loc5_].d == sShortcut)
         {
            _loc3_.push({k:this._aNoChatShortcuts[_loc5_].k,c:this._aNoChatShortcuts[_loc5_].c,d:this._aNoChatShortcuts[_loc5_].l});
         }
         _loc5_ = _loc5_ + 1;
      }
      if(_loc3_.length == 1)
      {
         return _loc3_[0];
      }
      if(_loc3_.length == 2)
      {
         return {k:_loc3_[0].k,c:_loc3_[0].c,d:_loc3_[0].d,k2:_loc3_[1].k,c2:_loc3_[1].c,d2:_loc3_[1].d};
      }
      return undefined;
   }
   function clearCustomShortcuts()
   {
      this._so.clear();
      this.loadShortcuts();
   }
   function askCustomShortcut(sShortcut, bIsAlternative)
   {
      this.api.ui.loadUIComponent("AskCustomShortcut","AskCustomShortcut",{title:this.api.lang.getText("SHORTCUTS_CUSTOM"),ShortcutCode:sShortcut,IsAlt:bIsAlternative,Description:this.api.lang.getKeyboardShortcuts()[sShortcut].d});
   }
   function setCustomShortcut(sShortcut, bIsAlternative, nKeyCode, nCtrlCode, sAscii)
   {
      if(sShortcut == undefined || bIsAlternative == undefined)
      {
         return undefined;
      }
      var _loc7_ = sShortcut + (!bIsAlternative?"_MAIN":"_ALT");
      if(nKeyCode == undefined)
      {
         this._so.data[_loc7_] = undefined;
      }
      else
      {
         if(nCtrlCode == undefined)
         {
            nCtrlCode = 0;
         }
         if(sAscii == undefined || sAscii == "")
         {
            sAscii = this.api.lang.getKeyStringFromKeyCode(nKeyCode);
            sAscii = this.api.lang.getControlKeyString(nCtrlCode) + sAscii;
         }
         this._so.data[_loc7_] = {s:sShortcut,a:bIsAlternative,k:nKeyCode,c:nCtrlCode,i:sAscii};
      }
      this._so.flush();
      this.loadShortcuts();
   }
   function getCustomShortcut(sShortcut, bIsAlternative)
   {
      var _loc4_ = sShortcut + (!bIsAlternative?"_MAIN":"_ALT");
      return this._so.data[_loc4_];
   }
   function isCustomShortcut(sShortcut, bIsAlternative)
   {
      return this.getCustomShortcut(sShortcut,bIsAlternative) != undefined;
   }
   function deleteCustomShortcut(sShortcut, bIsAlternative)
   {
      this.setCustomShortcut(sShortcut,bIsAlternative);
   }
   function getCurrentDefaultSet()
   {
      var _loc2_ = Number(this.api.lang.getText("SHORTCUTS_DEFAULT_SET"));
      if(_loc2_ < 1)
      {
         _loc2_ = 1;
      }
      return _loc2_;
   }
   function dispatchCtrlState(bNewCtrlState)
   {
      this.dispatchShortcut(!bNewCtrlState?"CTRL_STATE_CHANGED_OFF":"CTRL_STATE_CHANGED_ON");
   }
   function dispatchShortcut(sShortcut)
   {
      if(!this._bIsBroadcasting)
      {
         return false;
      }
      if(this._aListening == undefined)
      {
         return true;
      }
      var _loc3_ = new Array();
      var _loc4_ = true;
      var _loc5_ = 0;
      while(_loc5_ < this._aListening.length)
      {
         if(this._aListening[_loc5_] == undefined || this._aListening[_loc5_].o == undefined)
         {
            _loc3_.push(_loc5_);
         }
         else
         {
            var _loc6_ = eval(String(this._aListening[_loc5_].o) + "." + this._aListening[_loc5_].m).call(this._aListening[_loc5_].o,sShortcut);
            if(_loc6_ != undefined && _loc6_ == false)
            {
               _loc4_ = false;
               break;
            }
         }
         _loc5_ = _loc5_ + 1;
      }
      _loc3_.sort(Array.DESCENDING);
      var _loc7_ = 0;
      while(_loc7_ < _loc3_.length)
      {
         this._aListening.splice(_loc3_[_loc7_],1);
         _loc7_ = _loc7_ + 1;
      }
      if(_loc4_)
      {
         _loc4_ = this.onShortcut(sShortcut);
      }
      return _loc4_;
   }
   function dispatchKey(sKey)
   {
      if(!this._bIsBroadcasting)
      {
         return undefined;
      }
      if(this._aKeysListening == undefined)
      {
         return undefined;
      }
      sKey = new ank.utils.ExtendedString(sKey).trim().toString();
      if(sKey.length == 0)
      {
         return undefined;
      }
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < this._aKeysListening.length)
      {
         if(this._aKeysListening[_loc4_] == undefined || this._aKeysListening[_loc4_].o == undefined)
         {
            _loc3_.push(_loc4_);
         }
         else
         {
            eval(String(this._aKeysListening[_loc4_].o) + "." + this._aKeysListening[_loc4_].m).call(this._aKeysListening[_loc4_].o,sKey);
         }
         _loc4_ = _loc4_ + 1;
      }
      _loc3_.sort(Array.DESCENDING);
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         this._aKeysListening.splice(_loc3_[_loc5_],1);
         _loc5_ = _loc5_ + 1;
      }
   }
   function loadShortcuts()
   {
      var _loc2_ = this.api.lang.getKeyboardShortcuts();
      this._aNoChatShortcuts = new Array();
      this._aAnyTimeShortcuts = new Array();
      for(var k in _loc2_)
      {
         var _loc3_ = this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet,k);
         var _loc4_ = this.getCustomShortcut(k,false);
         if(_loc4_ != undefined && !_loc2_[k].s)
         {
            if(_loc3_.o)
            {
               this._aNoChatShortcuts.push({k:_loc4_.k,c:_loc4_.c,o:_loc3_.o,d:k,l:_loc4_.i,s:_loc2_[k].s});
            }
            else
            {
               this._aAnyTimeShortcuts.push({k:_loc4_.k,c:_loc4_.c,o:_loc3_.o,d:k,l:_loc4_.i,s:_loc2_[k].s});
            }
         }
         else if(_loc3_.o)
         {
            this._aNoChatShortcuts.push({k:_loc3_.k,c:_loc3_.c,o:_loc3_.o,d:k,l:_loc3_.s,s:_loc2_[k].s});
         }
         else if(_loc3_.k != undefined)
         {
            this._aAnyTimeShortcuts.push({k:_loc3_.k,c:_loc3_.c,o:_loc3_.o,d:k,l:_loc3_.s,s:_loc2_[k].s});
         }
         var _loc5_ = this.getCustomShortcut(k,true);
         if(_loc5_ != undefined && !_loc2_[k].s)
         {
            if(_loc3_.o)
            {
               this._aNoChatShortcuts.push({k:_loc5_.k,c:_loc5_.c,o:_loc3_.o,d:k,l:_loc5_.i,s:_loc2_[k].s});
            }
            else
            {
               this._aAnyTimeShortcuts.push({k:_loc5_.k,c:_loc5_.c,o:_loc3_.o,d:k,l:_loc5_.i,s:_loc2_[k].s});
            }
         }
         else if(!_global.isNaN(_loc3_.k2) && _loc3_.k2 != undefined)
         {
            if(_loc3_.o)
            {
               this._aNoChatShortcuts.push({k:_loc3_.k2,c:_loc3_.c2,o:_loc3_.o,d:k,l:_loc3_.s2,s:_loc2_[k].s});
            }
            else
            {
               this._aAnyTimeShortcuts.push({k:_loc3_.k2,c:_loc3_.c2,o:_loc3_.o,d:k,l:_loc3_.s2,s:_loc2_[k].s});
            }
         }
      }
      if(this._aNoChatShortcuts.length == 0 && this._aAnyTimeShortcuts.length == 0)
      {
         this._aAnyTimeShortcuts.push({k:38,c:0,o:true,d:"HISTORY_UP"});
         this._aAnyTimeShortcuts.push({k:40,c:0,o:true,d:"HISTORY_DOWN"});
         this._aAnyTimeShortcuts.push({k:13,c:1,o:true,d:"GUILD_MESSAGE"});
         this._aAnyTimeShortcuts.push({k:13,c:0,o:true,d:"ACCEPT_CURRENT_DIALOG"});
         this._aAnyTimeShortcuts.push({k:70,c:1,o:true,d:"FULLSCREEN"});
         var _loc6_ = this.api.lang.getDefaultConsoleShortcuts();
         var _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            this._aAnyTimeShortcuts.push({k:_loc6_[_loc7_].k,c:_loc6_[_loc7_].c,o:true,d:"CONSOLE"});
            _loc7_ = _loc7_ + 1;
         }
      }
   }
   function processShortcuts(aShortcuts, nKeyCode, bCtrl, bShift)
   {
      var _loc6_ = true;
      var _loc7_ = 0;
      while(_loc7_ < aShortcuts.length)
      {
         if(Number(aShortcuts[_loc7_].k) == nKeyCode)
         {
            var _loc8_ = false;
            switch(aShortcuts[_loc7_].c)
            {
               case 1:
                  if(bCtrl && !bShift)
                  {
                     _loc8_ = true;
                  }
                  break;
               case 2:
                  if(!bCtrl && bShift)
                  {
                     _loc8_ = true;
                  }
                  break;
               case 3:
                  if(bCtrl && bShift)
                  {
                     _loc8_ = true;
                  }
                  break;
               default:
                  if(!bCtrl && !bShift)
                  {
                     _loc8_ = true;
                  }
            }
            if(_loc8_)
            {
               _loc6_ = this.dispatchShortcut(aShortcuts[_loc7_].d);
            }
         }
         _loc7_ = _loc7_ + 1;
      }
      return _loc6_;
   }
   function onSetChange(nSetID)
   {
      this._nCurrentSet = nSetID;
      this.loadShortcuts();
   }
   function onKeyDown()
   {
      var _loc2_ = Key.getCode();
      var _loc3_ = Key.getAscii();
      var _loc4_ = Key.isDown(Key.CONTROL);
      var _loc5_ = Key.isDown(Key.SHIFT);
      if(this._lastCtrlState != _loc4_)
      {
         this._lastCtrlState = _loc4_;
         this.dispatchCtrlState(_loc4_);
      }
      if(this._bPressedKeys[_loc2_] != undefined)
      {
         return undefined;
      }
      this._bPressedKeys[_loc2_] = true;
      if(this.api.gfx.spriteHandler.isShowingMonstersTooltip)
      {
         this.api.gfx.spriteHandler.showMonstersTooltip(false);
      }
      if(this.api.gfx.spriteHandler.isPlayerSpritesHidden)
      {
         this.api.gfx.spriteHandler.hidePlayerSprites(false);
      }
      if(!this.processShortcuts(this._aAnyTimeShortcuts,_loc2_,_loc4_,_loc5_))
      {
         return undefined;
      }
      if(Selection.getFocus() != undefined)
      {
         return undefined;
      }
      if(!this.processShortcuts(this._aNoChatShortcuts,_loc2_,_loc4_,_loc5_))
      {
         return undefined;
      }
      if(_loc3_ > 0)
      {
         this.dispatchKey(String.fromCharCode(_loc3_));
      }
   }
   function onKeyUp()
   {
      if(this.api.gfx.spriteHandler.isShowingMonstersTooltip)
      {
         this.api.gfx.spriteHandler.showMonstersTooltip(false);
      }
      if(this.api.gfx.spriteHandler.isPlayerSpritesHidden)
      {
         this.api.gfx.spriteHandler.hidePlayerSprites(false);
      }
      var _loc2_ = Key.getCode();
      delete this._bPressedKeys.register2;
   }
   function onShortcut(sShortcut)
   {
      var _loc3_ = true;
      switch(sShortcut)
      {
         case "TOGGLE_FIGHT_INFOS":
            this.api.kernel.OptionsManager.setOption("ChatEffects",!this.api.kernel.OptionsManager.getOption("ChatEffects"));
            _loc3_ = false;
            break;
         case "ESCAPE":
            this.api.datacenter.Basics.gfx_canLaunch = false;
            if(!this.api.ui.removeCursor(true))
            {
               if(this.api.ui.callCloseOnLastUI() == false)
               {
                  this.api.ui.loadUIComponent("AskMainMenu","AskMainMenu");
               }
            }
            break;
         case "CONSOLE":
            if(this.api.datacenter.Player.isAuthorized)
            {
               this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
               _loc3_ = false;
            }
            break;
         case "GRID":
            this.api.kernel.OptionsManager.setOption("Grid");
            _loc3_ = false;
            break;
         case "SHOWMONSTERSTOOLTIP":
            this.api.gfx.spriteHandler.showMonstersTooltip(true);
            _loc3_ = false;
            break;
         case "SHOWTRIGGERS":
            if(!this.api.datacenter.Game.isFight)
            {
               if(getTimer() - this._nLastTriggerShow >= dofus.Constants.CLICK_MIN_DELAY)
               {
                  this._nLastTriggerShow = getTimer();
                  this.api.gfx.mapHandler.showTriggers();
               }
               _loc3_ = false;
            }
            break;
         case "HIDESPRITES":
            this.api.gfx.spriteHandler.hidePlayerSprites(true);
            _loc3_ = false;
            break;
         case "TRANSPARENCY":
            this.api.kernel.OptionsManager.setOption("Transparency",!this.api.gfx.bGhostView);
            _loc3_ = false;
            break;
         case "SPRITEINFOS":
            this.api.kernel.OptionsManager.setOption("SpriteInfos");
            _loc3_ = false;
            break;
         case "COORDS":
            this.api.kernel.OptionsManager.setOption("MapInfos");
            _loc3_ = false;
            break;
         case "STRINGCOURSE":
            this.api.kernel.OptionsManager.setOption("StringCourse");
            _loc3_ = false;
            break;
         case "BUFF":
            this.api.kernel.OptionsManager.setOption("Buff");
            _loc3_ = false;
            break;
         case "MOVABLEBAR":
            this.api.kernel.OptionsManager.setOption("MovableBar",!this.api.kernel.OptionsManager.getOption("MovableBar"));
            _loc3_ = false;
            break;
         case "MOUNTING":
            this.api.network.Mount.ride();
            _loc3_ = false;
            break;
         case "FULLSCREEN":
            this.api.kernel.GameManager.isFullScreen = _loc0_ = !this.api.kernel.GameManager.isFullScreen;
            getURL("FSCommand:" add "fullscreen",_loc0_);
            _loc3_ = false;
            break;
         case "ALLOWSCALE":
            this.api.kernel.GameManager.isAllowingScale = _loc0_ = !this.api.kernel.GameManager.isAllowingScale;
            getURL("FSCommand:" add "allowscale",_loc0_);
            _loc3_ = false;
      }
      return _loc3_;
   }
}
