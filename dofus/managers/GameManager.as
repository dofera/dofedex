class dofus.managers.GameManager extends dofus.utils.ApiElement
{
   static var MINIMAL_SPELL_LAUNCH_DELAY = 500;
   static var _sSelf = null;
   var _aLastModified = new Array();
   var _bIsFullScreen = false;
   var _bIsAllowingScale = true;
   var _nLastSpellLaunch = 0;
   static var FIGHT_TYPE_CHALLENGE = 0;
   static var FIGHT_TYPE_AGRESSION = 1;
   static var FIGHT_TYPE_PvMA = 2;
   static var FIGHT_TYPE_MXvM = 3;
   static var FIGHT_TYPE_PvM = 4;
   static var FIGHT_TYPE_PvT = 5;
   static var FIGHT_TYPE_PvMU = 6;
   var _nFightTurnInactivity = 0;
   function GameManager(oAPI)
   {
      super();
      dofus.managers.GameManager._sSelf = this;
      this.initialize(oAPI);
   }
   function __get__isFullScreen()
   {
      return this._bIsFullScreen;
   }
   function __set__isFullScreen(value)
   {
      this._bIsFullScreen = value;
      return this.__get__isFullScreen();
   }
   function __get__isAllowingScale()
   {
      return this._bIsAllowingScale;
   }
   function __set__isAllowingScale(value)
   {
      this._bIsAllowingScale = value;
      return this.__get__isAllowingScale();
   }
   function __set__lastSpellLaunch(n)
   {
      this._nLastSpellLaunch = n;
      return this.__get__lastSpellLaunch();
   }
   static function getInstance()
   {
      return dofus.managers.GameManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      this.api.ui.addEventListener("removeCursor",this);
   }
   function askPrivateMessage(sPlayerName)
   {
      var _loc3_ = this.api.ui.loadUIComponent("AskPrivateChat","AskPrivateChat",{title:this.api.lang.getText("WISPER_MESSAGE") + " " + this.api.lang.getText("TO_DESTINATION") + " " + sPlayerName,params:{playerName:sPlayerName}});
      _loc3_.addEventListener("send",this);
      _loc3_.addEventListener("addfriend",this);
   }
   function giveUpGame()
   {
      if(this.api.datacenter.Game.fightType == dofus.managers.GameManager.FIGHT_TYPE_CHALLENGE || this.api.datacenter.Basics.aks_current_server.typeNum != dofus.datacenter.Server.SERVER_HARDCORE)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_GIVEUP"),"CAUTION_YESNO",{name:"GiveUp",listener:this});
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_SUICIDE"),"CAUTION_YESNO",{name:"GiveUp",listener:this});
      }
   }
   function offlineExchange()
   {
      this.api.network.Exchange.askOfflineExchange();
   }
   function askOfflineExchange(allItemPrice, tax, priceToPay)
   {
      this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_OFFLINEEXCHANGE",[allItemPrice,tax,priceToPay]),"CAUTION_YESNO",{name:"OfflineExchange",listener:this,price:priceToPay});
   }
   function startExchange(nExchangeType, sSpriteID, nCellNum)
   {
      var _loc5_ = this.api.datacenter.Player.data;
      if(_loc5_.isInMove)
      {
         _loc5_.isInMove = false;
         _loc5_.GameActionsManager.cancel(_loc5_.cellNum,true);
      }
      this.api.network.Exchange.request(nExchangeType,Number(sSpriteID),nCellNum);
   }
   function startDialog(sSpriteID)
   {
      var _loc3_ = this.api.datacenter.Player.data;
      if(_loc3_.isInMove)
      {
         _loc3_.isInMove = false;
         _loc3_.GameActionsManager.cancel(_loc3_.cellNum,true);
      }
      this.api.network.Dialog.create(sSpriteID);
   }
   function askAttack(sSpriteID)
   {
      var _loc3_ = this.api.datacenter.Sprites.getItemAt(sSpriteID);
      var _loc4_ = "";
      if(!this.api.datacenter.Player.rank.enable)
      {
         _loc4_ = _loc4_ + this.api.lang.getText("DO_U_ATTACK_WHEN_PVP_DISABLED");
      }
      if(_loc3_.rank.value == 0)
      {
         if(_loc4_ != "")
         {
            _loc4_ = _loc4_ + "\n\n";
         }
         _loc4_ = _loc4_ + this.api.lang.getText("DO_U_ATTACK_NEUTRAL");
      }
      if(_loc4_ != "")
      {
         _loc4_ = _loc4_ + "\n\n";
      }
      if(!this.api.lang.getConfigText("SHOW_PVP_GAIN_WARNING_POPUP"))
      {
         _loc3_.pvpGain = 0;
      }
      switch(_loc3_.pvpGain)
      {
         case -1:
            _loc4_ = _loc4_ + this.api.lang.getText("DO_U_ATTACK_NO_GAIN",[_loc3_.name]);
            break;
         case 1:
            _loc4_ = _loc4_ + this.api.lang.getText("DO_U_ATTACK_BONUS_GAIN",[_loc3_.name]);
            break;
         default:
            _loc4_ = _loc4_ + this.api.lang.getText("DO_U_ATTACK",[_loc3_.name]);
      }
      this.api.kernel.showMessage(undefined,_loc4_,"CAUTION_YESNO",{name:"Punish",listener:this,params:{spriteID:sSpriteID}});
   }
   function askRemoveTaxCollector(sSpriteID)
   {
      var _loc3_ = this.api.datacenter.Sprites.getItemAt(sSpriteID).name;
      this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_REMOVE_TAXCOLLECTOR",[_loc3_]),"CAUTION_YESNO",{name:"RemoveTaxCollector",listener:this,params:{spriteID:sSpriteID}});
   }
   function useRessource(mcCell, nCellNum, nSkillID)
   {
      if(this.api.gfx.onCellRelease(mcCell))
      {
         this.api.network.GameActions.sendActions(500,[nCellNum,nSkillID]);
      }
   }
   function useSkill(nSkillID)
   {
      this.api.network.GameActions.sendActions(507,[nSkillID]);
   }
   function setEnabledInteractionIfICan(nInteractionType)
   {
      if(this.api.datacenter.Player.isCurrentPlayer)
      {
         this.api.gfx.setInteraction(nInteractionType);
      }
   }
   function cleanPlayer(sSpriteID)
   {
      if(sSpriteID != this.api.datacenter.Game.currentPlayerID)
      {
         var _loc3_ = this.api.datacenter.Sprites.getItemAt(sSpriteID);
         _loc3_.EffectsManager.nextTurn();
         _loc3_.CharacteristicsManager.nextTurn();
         _loc3_.GameActionsManager.clear();
      }
   }
   function cleanUpGameArea(bKeepSelection)
   {
      if(bKeepSelection)
      {
         this.api.gfx.unSelect(true);
      }
      this.api.ui.removeCursor();
      this.api.ui.getUIComponent("Banner").hideRightPanel();
      this.api.gfx.clearZoneLayer("spell");
      this.api.gfx.clearPointer();
      this.api.gfx.unSelect(true);
      delete this.api.datacenter.Player.currentUseObject;
      if(!(this.api.datacenter.Game.isFight && !this.api.datacenter.Game.isRunning))
      {
         this.api.datacenter.Game.setInteractionType("move");
      }
      this.api.datacenter.Player.InteractionsManager.setState(this.api.datacenter.Game.isFight);
   }
   function terminateFight()
   {
      this.api.sounds.events.onGameEnd();
      this.api.sounds.playMusic(this.api.datacenter.Map.musicID);
      this.api.kernel.showMessage(undefined,this.api.lang.getText("GAME_END"),"INFO_CHAT");
      this.api.ui.loadUIComponent("GameResult","GameResult",{data:this.api.datacenter.Game.results},{bAlwaysOnTop:true});
      this.api.gfx.cleanMap();
      this.api.network.Game.onLeave();
   }
   function switchToItemTarget(oItem)
   {
      if(this.api.datacenter.Game.isFight)
      {
         return undefined;
      }
      this.api.gfx.unSelect(true);
      this.api.gfx.clearPointer();
      this.api.gfx.addPointerShape("C",0,dofus.Constants.CELL_SPELL_EFFECT_COLOR,this.api.datacenter.Player.data.cellNum);
      this.api.datacenter.Player.currentUseObject = oItem;
      this.api.datacenter.Game.setInteractionType("target");
      this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
      this.api.ui.setCursor(oItem,{width:25,height:25,x:15,y:15});
      this.api.datacenter.Basics.gfx_canLaunch = false;
      dofus.DofusCore.getInstance().forceMouseOver();
   }
   function switchToFlagSet()
   {
      if(!this.api.datacenter.Game.isFight)
      {
         return undefined;
      }
      this.api.gfx.clearPointer();
      this.api.gfx.unSelectAllButOne("startPosition");
      this.api.gfx.addPointerShape("C",0,dofus.Constants.CELL_SPELL_EFFECT_COLOR,this.api.datacenter.Player.data.cellNum);
      this.api.datacenter.Game.setInteractionType("flag");
      this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
      this.api.ui.removeCursor();
      this.api.datacenter.Basics.gfx_canLaunch = false;
      dofus.DofusCore.getInstance().forceMouseOver();
   }
   function switchToSpellLaunch(oSpell, bSpell, bForced)
   {
      if(bForced != true)
      {
         if(!this.api.datacenter.Game.isRunning)
         {
            return undefined;
         }
         if(this.api.datacenter.Player.data.sequencer.isPlaying())
         {
            return undefined;
         }
         if(this.api.datacenter.Player.data.GameActionsManager.isWaiting())
         {
            return undefined;
         }
         if(this.api.datacenter.Player.data.GameActionsManager.m_bNextAction)
         {
            return undefined;
         }
         if(this._nLastSpellLaunch + dofus.managers.GameManager.MINIMAL_SPELL_LAUNCH_DELAY > getTimer())
         {
            return undefined;
         }
         if(!this.api.datacenter.Player.SpellsManager.checkCanLaunchSpell(oSpell.ID,undefined))
         {
            if(this.api.datacenter.Basics.spellManager_errorMsg != undefined)
            {
               this.api.kernel.showMessage(undefined,this.api.datacenter.Basics.spellManager_errorMsg,"ERROR_CHAT");
               delete this.api.datacenter.Basics.spellManager_errorMsg;
            }
            return undefined;
         }
      }
      this.api.datacenter.Player.isCurrentSpellForced = bForced;
      delete this.api.datacenter.Basics.interactionsManager_path;
      this.api.gfx.unSelect(true);
      this.api.datacenter.Player.currentUseObject = oSpell;
      this.api.gfx.clearZoneLayer("spell");
      this.api.gfx.clearPointer();
      var _loc5_ = this.api.datacenter.Player.data.cellNum;
      if(oSpell.rangeMax != 63)
      {
         var _loc6_ = oSpell.rangeMax;
         var _loc7_ = oSpell.rangeMin;
         if(_loc6_ != 0)
         {
            var _loc8_ = !oSpell.canBoostRange?0:this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator;
            _loc6_ = _loc6_ + _loc8_;
            _loc6_ = Math.max(_loc7_,_loc6_);
         }
         if(oSpell.lineOnly)
         {
            this.api.gfx.drawZone(_loc5_,_loc7_,_loc6_,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"X");
            this.drawAllowedZone(true,_loc5_,_loc7_,_loc6_);
         }
         else
         {
            this.api.gfx.drawZone(_loc5_,_loc7_,_loc6_,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
            this.drawAllowedZone(false,_loc5_,_loc7_,_loc6_);
         }
      }
      else
      {
         this.api.gfx.drawZone(0,0,100,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
      }
      var _loc9_ = oSpell.effectZones;
      var _loc10_ = 0;
      while(_loc10_ < _loc9_.length)
      {
         if(_loc9_[_loc10_].size < 63)
         {
            this.api.gfx.addPointerShape(_loc9_[_loc10_].shape,_loc9_[_loc10_].size,dofus.Constants.CELL_SPELL_EFFECT_COLOR,_loc5_);
         }
         _loc10_ = _loc10_ + 1;
      }
      if(bSpell)
      {
         this.api.datacenter.Game.setInteractionType("spell");
      }
      else
      {
         this.api.datacenter.Game.setInteractionType("cc");
      }
      this.api.ui.setCursor(oSpell,{width:25,height:25,x:15,y:15});
      this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
      this.api.datacenter.Basics.gfx_canLaunch = false;
      dofus.DofusCore.getInstance().forceMouseOver();
   }
   function drawAllowedZone(lineOnly, originCell, innerRay, outerRay)
   {
      if(!this.api.kernel.OptionsManager.getOption("AdvancedLineOfSight"))
      {
         return undefined;
      }
      var _loc6_ = this.api.gfx.mapHandler.getCellCount();
      var _loc7_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler,originCell);
      var _loc8_ = !this.api.datacenter.Player.currentUseObject.canBoostRange?0:this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator;
      var _loc9_ = 0;
      for(; _loc9_ < _loc6_; _loc9_ = _loc9_ + 1)
      {
         var _loc10_ = ank.battlefield.utils.Pathfinding.goalDistance(this.api.gfx.mapHandler,originCell,_loc9_);
         if(_loc10_ >= innerRay && _loc10_ <= outerRay)
         {
            if(lineOnly)
            {
               var _loc11_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler,_loc9_);
               if(_loc11_.x != _loc7_.x && _loc11_.y != _loc7_.y)
               {
                  continue;
               }
            }
            if(this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellOnCell(this.api.gfx.mapHandler,this.api.datacenter.Player.currentUseObject,this.api.gfx.mapHandler.getCellData(_loc9_),_loc8_))
            {
               this.api.gfx.select(_loc9_,26316,"spell",50);
            }
         }
      }
   }
   function showDisgraceSanction()
   {
      var _loc2_ = this.api.datacenter.Player.rank.disgrace;
      if(_loc2_ > 0)
      {
         var _loc3_ = "";
         var _loc4_ = 1;
         while(_loc4_ <= _loc2_)
         {
            var _loc5_ = this.api.lang.getText("DISGRACE_SANCTION_" + _loc4_);
            if(_loc5_ != undefined && (_loc5_ != "undefined" && _loc5_.charAt(0) != "!"))
            {
               _loc3_ = _loc3_ + ("\n\n" + _loc5_);
            }
            _loc4_ = _loc4_ + 1;
         }
         if(_loc3_ != "")
         {
            _loc3_ = this.api.lang.getText("DISGRACE_SANCTION",[ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS",[_loc2_]),"m",_loc2_ < 2)]) + _loc3_;
            this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),_loc3_,"ERROR_BOX");
         }
      }
   }
   function getSpellDescriptionWithEffects(aEffects, bVisibleOnly, nSpell)
   {
      var _loc5_ = new Array();
      var _loc6_ = aEffects.length;
      if(typeof aEffects == "object")
      {
         var _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            var _loc8_ = aEffects[_loc7_];
            var _loc9_ = _loc8_[0];
            var _loc10_ = !(nSpell > 0 && this.api.kernel.SpellsBoostsManager.isBoostedHealingOrDamagingEffect(_loc9_))?-1:this.api.kernel.SpellsBoostsManager.getSpellModificator(_loc9_,nSpell);
            var _loc11_ = new dofus.datacenter.Effect(_loc9_,_loc8_[1],_loc8_[2],_loc8_[3],undefined,_loc8_[4],undefined,_loc10_);
            if(bVisibleOnly == true)
            {
               if(_loc11_.showInTooltip)
               {
                  _loc5_.push(_loc11_.description);
               }
            }
            else
            {
               _loc5_.push(_loc11_.description);
            }
            _loc7_ = _loc7_ + 1;
         }
         return _loc5_.join(", ");
      }
      return null;
   }
   function getSpellEffects(aEffects, nSpell)
   {
      var _loc4_ = new Array();
      var _loc5_ = aEffects.length;
      if(typeof aEffects == "object")
      {
         var _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            var _loc7_ = aEffects[_loc6_];
            var _loc8_ = _loc7_[0];
            var _loc9_ = -1;
            if(nSpell > 0)
            {
               if(this.api.kernel.SpellsBoostsManager.isBoostedHealingEffect(_loc8_))
               {
                  _loc9_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_HEAL,nSpell);
               }
               else if(this.api.kernel.SpellsBoostsManager.isBoostedDamagingEffect(_loc8_))
               {
                  _loc9_ = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_DMG,nSpell);
               }
            }
            var _loc10_ = new dofus.datacenter.Effect(_loc8_,_loc7_[1],_loc7_[2],_loc7_[3],_loc7_[6],_loc7_[4],undefined,_loc9_);
            _loc10_.probability = _loc7_[5];
            _loc4_.push(_loc10_);
            _loc6_ = _loc6_ + 1;
         }
         return _loc4_;
      }
      return null;
   }
   function removeCursor(oEvent)
   {
      switch(this.api.datacenter.Game.interactionType)
      {
         case 2:
         case 3:
            if(!this.api.datacenter.Basics.gfx_canLaunch)
            {
               this.api.datacenter.Game.setInteractionType("move");
            }
            this.api.gfx.clearZoneLayer("spell");
            this.api.gfx.clearPointer();
            this.api.gfx.unSelect(true);
            break;
         case 5:
            if(!this.api.datacenter.Basics.gfx_canLaunch)
            {
               this.api.datacenter.Game.setInteractionType("move");
            }
            this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
            this.api.gfx.clearPointer();
            this.api.gfx.unSelectAllButOne("startPosition");
      }
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoGiveUp":
            this.api.network.Game.leave();
            break;
         case "AskYesNoOfflineExchange":
            this.api.network.Exchange.offlineExchange();
            break;
         case "AskYesNoPunish":
            this.api.network.GameActions.attack(oEvent.params.spriteID);
            break;
         case "AskYesNoAttack":
            this.api.network.GameActions.attack(oEvent.params.spriteID);
            break;
         case "AskYesNoRemoveTaxCollector":
            this.api.network.Guild.removeTaxCollector(oEvent.params.spriteID);
      }
   }
   function send(oEvent)
   {
      if(oEvent.message.length != 0)
      {
         this.api.kernel.Console.process("/w " + oEvent.params.playerName + " " + oEvent.message);
      }
   }
   function addfriend(oEvent)
   {
      this.api.network.Friends.addFriend(oEvent.params.playerName);
   }
   function updateCompass(nX, nY, bForced)
   {
      var _loc5_ = this.api.ui.getUIComponent("Banner");
      if(!bForced && (this.api.datacenter.Basics.banner_targetCoords[0] == nX && this.api.datacenter.Basics.banner_targetCoords[1] == nY) || (_global.isNaN(nX) || _global.isNaN(nY)))
      {
         this.api.datacenter.Basics.banner_targetCoords = undefined;
         delete this.api.datacenter.Basics.banner_targetCoords;
         if(_loc5_.illustrationType != "map")
         {
            _loc5_.showCircleXtra("artwork",true,{bMask:true});
         }
         return false;
      }
      var _loc6_ = this.api.datacenter.Map;
      if(_loc5_.illustrationType != "map")
      {
         _loc5_.showCircleXtra("compass",true,undefined,{updateOnLoad:false});
      }
      _loc5_.setCircleXtraParams({allCoords:{targetCoords:[nX,nY],currentCoords:[_loc6_.x,_loc6_.y]}});
      this.api.datacenter.Basics.banner_targetCoords = [nX,nY];
      return true;
   }
   function isItemUseful(itemId, skillId, maxItem)
   {
      var _loc5_ = this.api.lang.getSkillText(skillId).cl;
      var _loc6_ = 0;
      while(_loc6_ < _loc5_.length)
      {
         var _loc7_ = _loc5_[_loc6_];
         var _loc8_ = this.api.lang.getCraftText(_loc7_);
         if(_loc8_.length <= maxItem)
         {
            var _loc9_ = 0;
            while(_loc9_ < _loc8_.length)
            {
               if(_loc8_[_loc9_][0] == itemId)
               {
                  return true;
               }
               _loc9_ = _loc9_ + 1;
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      return false;
   }
   function analyseReceipts(ea, skillId, maxItem)
   {
      var _loc5_ = this.api.lang.getSkillText(skillId).cl;
      var _loc6_ = 0;
      while(true)
      {
         if(_loc6_ < _loc5_.length)
         {
            var _loc7_ = _loc5_[_loc6_];
            var _loc8_ = this.api.lang.getCraftText(_loc7_);
            if(_loc8_.length <= maxItem)
            {
               var _loc9_ = 0;
               var _loc10_ = 0;
               while(_loc10_ < _loc8_.length)
               {
                  var _loc11_ = _loc8_[_loc10_];
                  var _loc12_ = _loc11_[0];
                  var _loc13_ = _loc11_[1];
                  var _loc14_ = ea.findFirstItem("unicID",_loc12_);
                  if(_loc14_.index != -1 && _loc14_.item.Quantity == _loc13_)
                  {
                     _loc9_ = _loc9_ + 1;
                     _loc10_ = _loc10_ + 1;
                     continue;
                  }
                  break;
               }
               if(_loc9_ == _loc8_.length)
               {
                  if(ea.length == _loc8_.length)
                  {
                     break;
                  }
                  if(ea.length == _loc8_.length + 1)
                  {
                     if(ea.findFirstItem("unicID",7508).index != -1)
                     {
                        return _loc7_;
                     }
                  }
               }
            }
            _loc6_ = _loc6_ + 1;
            continue;
         }
         return undefined;
      }
      return _loc7_;
   }
   function mergeTwoInventory(a1, a2)
   {
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = 0;
      while(_loc5_ < a1.length)
      {
         _loc4_.push(a1[_loc5_]);
         _loc5_ = _loc5_ + 1;
      }
      var _loc6_ = 0;
      while(_loc6_ < a2.length)
      {
         _loc4_.push(a2[_loc6_]);
         _loc6_ = _loc6_ + 1;
      }
      return _loc4_;
   }
   function mergeUnicItemInInventory(inventory)
   {
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = new Object();
      var _loc5_ = 0;
      while(_loc5_ < inventory.length)
      {
         var _loc6_ = inventory[_loc5_];
         if(_loc4_[_loc6_.unicID] == undefined)
         {
            _loc4_[_loc6_.unicID] = _loc6_.clone();
         }
         else
         {
            _loc4_[_loc6_.unicID].Quantity = _loc4_[_loc6_.unicID].Quantity + _loc6_.Quantity;
         }
         _loc5_ = _loc5_ + 1;
      }
      for(var a in _loc4_)
      {
         _loc3_.push(_loc4_[a]);
      }
      return _loc3_;
   }
   function getRemainingString(nRemainingTime)
   {
      if(nRemainingTime == -1)
      {
         return this.api.lang.getText("OPEN_BETA_ACCOUNT");
      }
      if(nRemainingTime == 0)
      {
         return this.api.lang.getText("SUBSCRIPTION_OUT");
      }
      var _loc3_ = new Date();
      _loc3_.setTime(nRemainingTime);
      var _loc4_ = _loc3_.getUTCFullYear() - 1970;
      var _loc5_ = _loc3_.getUTCMonth();
      var _loc6_ = _loc3_.getUTCDate() - 1;
      var _loc7_ = _loc3_.getUTCHours();
      var _loc8_ = _loc3_.getUTCMinutes();
      var _loc9_ = " " + this.api.lang.getText("AND") + " ";
      var _loc10_ = this.api.lang.getText("REMAINING_TIME") + " ";
      if(_loc4_ != 0 && _loc5_ == 0)
      {
         var _loc11_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"),"m",_loc4_ == 1);
         _loc10_ = _loc10_ + (_loc4_ + " " + _loc11_);
      }
      else if(_loc4_ != 0 && _loc5_ != 0)
      {
         var _loc12_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"),"m",_loc4_ == 1);
         var _loc13_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",_loc5_ == 1);
         _loc10_ = _loc10_ + (_loc4_ + " " + _loc12_ + _loc9_ + _loc5_ + " " + _loc13_);
      }
      else if(_loc5_ != 0 && _loc6_ == 0)
      {
         var _loc14_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",_loc5_ == 1);
         _loc10_ = _loc10_ + (_loc5_ + " " + _loc14_);
      }
      else if(_loc5_ != 0 && _loc6_ != 0)
      {
         var _loc15_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",_loc5_ == 1);
         var _loc16_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",_loc6_ == 1);
         _loc10_ = _loc10_ + (_loc5_ + " " + _loc15_ + _loc9_ + _loc6_ + " " + _loc16_);
      }
      else if(_loc6_ != 0 && _loc7_ == 0)
      {
         var _loc17_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",_loc6_ == 1);
         _loc10_ = _loc10_ + (_loc6_ + " " + _loc17_);
      }
      else if(_loc6_ != 0 && _loc7_ != 0)
      {
         var _loc18_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",_loc6_ == 1);
         var _loc19_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",_loc7_ == 1);
         _loc10_ = _loc10_ + (_loc6_ + " " + _loc18_ + _loc9_ + _loc7_ + " " + _loc19_);
      }
      else if(_loc7_ != 0 && _loc8_ == 0)
      {
         var _loc20_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",_loc7_ == 1);
         _loc10_ = _loc10_ + (_loc7_ + " " + _loc20_);
      }
      else if(_loc7_ != 0 && _loc8_ != 0)
      {
         var _loc21_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",_loc7_ == 1);
         var _loc22_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",_loc8_ == 1);
         _loc10_ = _loc10_ + (_loc7_ + " " + _loc21_ + _loc9_ + _loc8_ + " " + _loc22_);
      }
      else if(_loc8_ != 0)
      {
         var _loc23_ = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",_loc8_ == 1);
         _loc10_ = _loc10_ + (_loc8_ + " " + _loc23_);
      }
      return _loc10_;
   }
   function zoomGfx(nZoom, x, y, xScreenPos, yScreenPos)
   {
      var _loc7_ = this.api.gfx.container;
      var _loc8_ = ank.battlefield.Constants.CELL_WIDTH;
      var _loc9_ = ank.battlefield.Constants.CELL_HEIGHT;
      if(nZoom != undefined)
      {
         var _loc10_ = this.api.gfx.screenWidth;
         var _loc11_ = this.api.gfx.screenHeight;
         if(x == undefined)
         {
            x = _loc10_ / 2;
         }
         if(y == undefined)
         {
            x = _loc11_ / 2;
         }
         if(xScreenPos == undefined)
         {
            xScreenPos = _loc10_ / 2;
         }
         if(yScreenPos == undefined)
         {
            yScreenPos = _loc11_ / 2;
         }
         var _loc12_ = x * nZoom / 100;
         var _loc13_ = y * nZoom / 100;
         var _loc14_ = xScreenPos - _loc12_;
         var _loc15_ = yScreenPos - _loc13_;
         var _loc16_ = (this.api.datacenter.Map.width - 1) * _loc8_ * nZoom / 100;
         var _loc17_ = (this.api.datacenter.Map.height - 1) * _loc9_ * nZoom / 100;
         if(_loc14_ > 0)
         {
            _loc14_ = 0;
         }
         if(_loc14_ + _loc16_ < _loc10_)
         {
            _loc14_ = _loc10_ - _loc16_;
         }
         if(_loc15_ > 0)
         {
            _loc15_ = 0;
         }
         if(_loc15_ + _loc17_ < _loc11_)
         {
            _loc15_ = _loc11_ - _loc17_;
         }
         _loc7_.zoom(nZoom);
         _loc7_.setXY(_loc14_,_loc15_);
      }
      else
      {
         if(!_loc7_.zoomMap())
         {
            _loc7_.zoom(100);
         }
         _loc7_.center();
      }
   }
   function showMonsterPopupMenu(oSpriteData)
   {
      var _loc3_ = oSpriteData;
      if(_loc3_ == null)
      {
         return undefined;
      }
      var _loc4_ = this.api.datacenter.Game.isFight;
      var _loc5_ = _loc3_.id;
      var _loc6_ = _loc3_.name;
      var _loc7_ = this.api.ui.createPopupMenu();
      _loc7_.addStaticItem(_loc6_);
      if(_loc4_ && (!this.api.datacenter.Game.isRunning && (_loc3_.kickable || this.api.datacenter.Player.isAuthorized)))
      {
         _loc7_.addItem(this.api.lang.getText("KICK"),this.api.network.Game,this.api.network.Game.leave,[_loc5_]);
      }
      if(_loc7_.items.length > 1)
      {
         _loc7_.show(_root._xmouse,_root._ymouse,true);
      }
   }
   function showPlayerPopupMenu(oSpriteData, sPlayerName, oPartyItem, bNoFriendsInvite, bNoGuildInvite, sUniqId, bShowJoinFriend)
   {
      var _loc9_ = null;
      if(oSpriteData != undefined)
      {
         _loc9_ = oSpriteData;
      }
      else if(sPlayerName != undefined)
      {
         var _loc10_ = this.api.datacenter.Sprites.getItems();
         for(var a in _loc10_)
         {
            var _loc11_ = _loc10_[a];
            if(_loc11_.name.toUpperCase() == sPlayerName.toUpperCase())
            {
               _loc9_ = _loc11_;
               break;
            }
         }
      }
      else
      {
         return undefined;
      }
      var _loc12_ = this.api.datacenter.Game.isFight;
      var _loc13_ = _loc9_.id;
      var _loc14_ = sPlayerName != undefined?sPlayerName:_loc9_.name;
      if(this.api.datacenter.Player.isAuthorized && Key.isDown(Key.SHIFT))
      {
         this.api.kernel.AdminManager.showAdminPopupMenu(_loc14_);
      }
      else
      {
         var _loc15_ = this.api.ui.createPopupMenu();
         _loc15_.addStaticItem(_loc14_);
         var _loc16_ = this.api.kernel.ChatManager.isBlacklisted(_loc14_);
         if(_loc16_)
         {
            _loc15_.addStaticItem("(" + this.api.lang.getText("IGNORED_WORD") + ")");
         }
         if(_loc12_)
         {
            if(!this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant))
            {
               if(_loc9_ != null && _loc13_ != this.api.datacenter.Player.ID)
               {
                  _loc15_.addItem(this.api.lang.getText("KICK"),this.api.network.Game,this.api.network.Game.leave,[_loc13_]);
               }
            }
         }
         if(_loc13_ == this.api.datacenter.Player.ID)
         {
            _loc15_.addItem(this.api.lang.getText("HIT_HIMSELF"),this.api.network.Chat,this.api.network.Chat.send,[this.api.lang.getText("SLAP_SENTENCE"),"*"]);
            if(!_loc12_ && this.api.datacenter.Player.canBeMerchant)
            {
               _loc15_.addItem(this.api.lang.getText("ORGANIZE_SHOP"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[6]);
               _loc15_.addItem(this.api.lang.getText("MERCHANT_MODE"),this.api.kernel.GameManager,this.api.kernel.GameManager.offlineExchange);
            }
            if(this.api.datacenter.Player.data.isTomb)
            {
               _loc15_.addItem(this.api.lang.getText("FREE_MY_SOUL"),this.api.network.Game,this.api.network.Game.freeMySoul);
            }
            else if(!_loc12_)
            {
               var _loc17_ = _loc9_.animation == "static";
               _loc15_.addItem(this.api.lang.getText("CHANGE_DIRECTION"),this.api.ui,this.api.ui.loadUIComponent,["DirectionChooser","DirectionChooser",{allDirections:this.api.datacenter.Player.canMoveInAllDirections,target:this.api.datacenter.Player.data.mc}]);
            }
         }
         else
         {
            if(sUniqId != undefined && (sUniqId.length > 0 && (sUniqId != "" && !_loc16_)))
            {
               var _loc18_ = false;
               var _loc19_ = 0;
               while(_loc19_ < this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST").length)
               {
                  if(this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST")[_loc19_] == this.api.datacenter.Basics.aks_current_server.id)
                  {
                     _loc18_ = true;
                     break;
                  }
                  _loc19_ = _loc19_ + 1;
               }
               if(_loc18_)
               {
                  _loc15_.addItem(this.api.lang.getText("REPORT_SENTANCE"),this.api.kernel.GameManager,this.api.kernel.GameManager.reportSentance,[_loc14_,_loc13_,sUniqId,_loc9_]);
               }
            }
            if(!this.api.kernel.ChatManager.isBlacklisted(_loc14_))
            {
               _loc15_.addItem(this.api.lang.getText("BLACKLIST_TEMPORARLY"),this.api.kernel.GameManager,this.api.kernel.GameManager.reportSentance,[_loc14_,_loc13_,undefined,_loc9_]);
            }
            else
            {
               _loc15_.addItem(this.api.lang.getText("BLACKLIST_REMOVE"),this.api.kernel.ChatManager,this.api.kernel.ChatManager.removeToBlacklist,[_loc14_]);
            }
            if(!_loc12_ || _loc12_ && sPlayerName != undefined)
            {
               _loc15_.addItem(this.api.lang.getText("WHOIS"),this.api.network.Basics,this.api.network.Basics.whoIs,[_loc14_]);
               if(bNoFriendsInvite != true)
               {
                  _loc15_.addItem(this.api.lang.getText("ADD_TO_FRIENDS"),this.api.network.Friends,this.api.network.Friends.addFriend,[_loc14_]);
               }
               if(bNoFriendsInvite != true)
               {
                  _loc15_.addItem(this.api.lang.getText("ADD_TO_ENEMY"),this.api.network.Enemies,this.api.network.Enemies.addEnemy,[_loc14_]);
               }
               _loc15_.addItem(this.api.lang.getText("WISPER_MESSAGE"),this.api.kernel.GameManager,this.api.kernel.GameManager.askPrivateMessage,[_loc14_]);
               if(oPartyItem == undefined)
               {
                  _loc15_.addItem(this.api.lang.getText("ADD_TO_PARTY"),this.api.network.Party,this.api.network.Party.invite,[_loc14_]);
               }
               if(this.api.datacenter.Player.guildInfos != undefined)
               {
                  if(bNoGuildInvite != true)
                  {
                     if(_loc9_ == null || (_loc9_ != null && _loc9_.guildName == undefined || _loc9_.guildName.length == 0))
                     {
                        if(this.api.datacenter.Player.guildInfos.playerRights.canInvite)
                        {
                           _loc15_.addItem(this.api.lang.getText("INVITE_IN_GUILD"),this.api.network.Guild,this.api.network.Guild.invite,[_loc14_]);
                        }
                     }
                  }
               }
               if(bShowJoinFriend)
               {
                  if(this.api.datacenter.Player.isAuthorized)
                  {
                     _loc15_.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.kernel.AdminManager,this.api.kernel.AdminManager.sendCommand,["join " + _loc14_]);
                  }
                  else if(this.api.datacenter.Map.superarea == 3)
                  {
                     _loc15_.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.network.Friends,this.api.network.Friends.joinFriend,[_loc14_]);
                  }
               }
            }
            if(!_loc12_ && (_loc9_ != null && !bNoFriendsInvite))
            {
               if(this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
               {
                  _loc15_.addItem(this.api.lang.getText("KICKOFF"),this.api.network.Houses,this.api.network.Houses.kick,[_loc13_]);
               }
               if(this.api.datacenter.Player.canExchange && _loc9_.canExchange)
               {
                  _loc15_.addItem(this.api.lang.getText("EXCHANGE"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[1,_loc13_]);
               }
               if(this.api.datacenter.Player.canChallenge && _loc9_.canBeChallenge)
               {
                  _loc15_.addItem(this.api.lang.getText("CHALLENGE"),this.api.network.GameActions,this.api.network.GameActions.challenge,[_loc13_],this.api.datacenter.Map.bCanChallenge);
               }
               if(this.api.datacenter.Player.canAssault && !_loc9_.showIsPlayer)
               {
                  var _loc20_ = this.api.datacenter.Player.data.alignment.index;
                  if(this.api.lang.getAlignmentCanAttack(_loc20_,_loc9_.alignment.index))
                  {
                     _loc15_.addItem(this.api.lang.getText("ASSAULT"),this.api.kernel.GameManager,this.api.kernel.GameManager.askAttack,[[_loc13_]],this.api.datacenter.Map.bCanAttack);
                  }
               }
               if(this.api.datacenter.Player.canAttack && (_loc9_.canBeAttack && !_loc9_.showIsPlayer))
               {
                  _loc15_.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.mutantAttack,[_loc9_.id]);
               }
               var _loc21_ = _loc9_.multiCraftSkillsID;
               if(_loc21_ != undefined && _loc21_.length > 0)
               {
                  var _loc22_ = 0;
                  while(_loc22_ < _loc21_.length)
                  {
                     var _loc23_ = Number(_loc21_[_loc22_]);
                     _loc15_.addItem(this.api.lang.getText("ASK_TO") + " " + this.api.lang.getSkillText(_loc23_).d,this.api.network.Exchange,this.api.network.Exchange.request,[13,_loc9_.id,_loc23_]);
                     _loc22_ = _loc22_ + 1;
                  }
               }
               else
               {
                  _loc21_ = this.api.datacenter.Player.data.multiCraftSkillsID;
                  if(_loc21_ != undefined && _loc21_.length > 0)
                  {
                     var _loc24_ = 0;
                     while(_loc24_ < _loc21_.length)
                     {
                        var _loc25_ = Number(_loc21_[_loc24_]);
                        _loc15_.addItem(this.api.lang.getText("INVITE_TO") + " " + this.api.lang.getSkillText(_loc25_).d,this.api.network.Exchange,this.api.network.Exchange.request,[12,_loc9_.id,_loc25_]);
                        _loc24_ = _loc24_ + 1;
                     }
                  }
               }
            }
         }
         if(oPartyItem != undefined)
         {
            oPartyItem.addPartyMenuItems(_loc15_);
         }
         if(_loc9_ != null && (_loc9_.isVisible && (this.api.ui.getUIComponent("Zoom") == undefined && !_loc12_)))
         {
            _loc15_.addItem(this.api.lang.getText("ZOOM"),this.api.ui,this.api.ui.loadUIAutoHideComponent,["Zoom","Zoom",{sprite:_loc9_}]);
         }
         if(_loc15_.items.length > 0)
         {
            _loc15_.show(_root._xmouse,_root._ymouse,true);
         }
      }
   }
   function getDurationString(duration, bBig)
   {
      if(duration <= 0)
      {
         return "-";
      }
      var _loc4_ = new Date();
      _loc4_.setTime(duration);
      var _loc5_ = _loc4_.getUTCHours();
      var _loc6_ = _loc4_.getUTCMinutes();
      if(bBig != true)
      {
         return (_loc5_ == 0?"":_loc5_ + " " + this.api.lang.getText("HOURS_SMALL") + " ") + _loc6_ + " " + this.api.lang.getText("MINUTES_SMALL");
      }
      return (_loc5_ == 0?"":_loc5_ + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",_loc5_ < 2) + " ") + _loc6_ + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",_loc6_ < 2);
   }
   function insertItemInChat(oItem, sPrefix, sSuffix)
   {
      if(sPrefix == undefined)
      {
         sPrefix = "";
      }
      if(sSuffix == undefined)
      {
         sSuffix = "";
      }
      if(this.api.datacenter.Basics.chatParams.items == undefined)
      {
         this.api.datacenter.Basics.chatParams.items = new Array();
      }
      if(this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS") == undefined || this.api.datacenter.Basics.chatParams.items.length < this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS"))
      {
         this.api.datacenter.Basics.chatParams.items.push(oItem);
         this.api.ui.getUIComponent("Banner").insertChat(sPrefix + "[" + oItem.name + "]" + sSuffix);
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("TOO_MANY_ITEM_LINK"),"ERROR_CHAT");
      }
   }
   function getLastModified(nSlot)
   {
      var _loc3_ = this._aLastModified[nSlot];
      if(_loc3_ == undefined || _global.isNaN(_loc3_))
      {
         return 0;
      }
      return _loc3_;
   }
   function setAsModified(nSlot)
   {
      if(nSlot < 0)
      {
         return undefined;
      }
      this._aLastModified[nSlot] = getTimer();
   }
   function getCriticalHitChance(nDice)
   {
      if(nDice == 0)
      {
         return 0;
      }
      var _loc3_ = Math.max(0,this.api.datacenter.Player.CriticalHitBonus);
      var _loc4_ = Math.max(0,this.api.datacenter.Player.AgilityTotal);
      nDice = nDice - _loc3_;
      if(_loc4_ != 0)
      {
         nDice = Math.min(nDice,Number(nDice * (Math.E * 1.1 / Math.log(_loc4_ + 12))));
      }
      return Math.floor(Math.max(nDice,2));
   }
   function reportSentance(sName, sID, sUniqId, oData)
   {
      if(sUniqId != undefined && (sUniqId.length > 0 && sUniqId != ""))
      {
         this.api.ui.loadUIComponent("AskReportMessage","AskReportMessage" + sUniqId,{message:this.api.kernel.ChatManager.getMessageFromId(sUniqId),messageId:sUniqId,authorId:sID,authorName:sName});
      }
      else
      {
         this.api.kernel.ChatManager.addToBlacklist(sName,oData.gfxID);
         this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[sName]),"INFO_CHAT");
      }
   }
   function isInMyTeam(sprite)
   {
      if(this.api.datacenter.Basics.aks_current_team == 0)
      {
         var _loc3_ = 0;
         while(_loc3_ < this.api.datacenter.Basics.aks_team1_starts.length)
         {
            if(this.api.datacenter.Basics.aks_team1_starts[_loc3_] == sprite.cellNum)
            {
               return true;
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      else if(this.api.datacenter.Basics.aks_current_team == 1)
      {
         var _loc4_ = 0;
         while(_loc4_ < this.api.datacenter.Basics.aks_team2_starts.length)
         {
            if(this.api.datacenter.Basics.aks_team2_starts[_loc4_] == sprite.cellNum)
            {
               return true;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return false;
   }
   function startInactivityDetector()
   {
      this.stopInactivityDetector();
      this.signalActivity();
      this._nInactivityInterval = _global.setInterval(this,"inactivityCheck",1000);
      this._bFightActivity = false;
      Mouse.addListener(this);
   }
   function signalActivity()
   {
      this._nLastActivity = getTimer();
   }
   function stopInactivityDetector()
   {
      if(this._nInactivityInterval != undefined)
      {
         _global.clearInterval(this._nInactivityInterval);
      }
      this._nLastActivity = undefined;
   }
   function inactivityCheck()
   {
      if(this._nLastActivity == undefined || !this.api.kernel.OptionsManager.getOption("RemindTurnTime"))
      {
         return undefined;
      }
      var _loc2_ = this.api.lang.getConfigText("INACTIVITY_DISPLAY_COUNT");
      if(_global.isNaN(_loc2_) || _loc2_ == undefined)
      {
         _loc2_ = 5;
      }
      if(this.api.datacenter.Basics.inactivity_signaled > _loc2_)
      {
         return undefined;
      }
      var _loc3_ = this.api.lang.getConfigText("INACTIVITY_TIMING");
      if(_global.isNaN(_loc3_) || (_loc3_ == undefined || _loc3_ < 1000))
      {
         _loc3_ = 11000;
      }
      if(this._nLastActivity + _loc3_ < getTimer())
      {
         if(this.api.datacenter.Game.isFight && (this.api.datacenter.Game.isRunning && this.api.datacenter.Player.isCurrentPlayer))
         {
            if(this.autoSkip)
            {
               this.api.network.Game.turnEnd();
               return undefined;
            }
            this.api.kernel.showMessage(undefined,this.api.lang.getText("INFIGHT_INACTIVITY"),"ERROR_CHAT");
            this.api.kernel.TipsManager.pointGUI("Banner",["_btnNextTurn"]);
            this.api.datacenter.Basics.inactivity_signaled = this.api.datacenter.Basics.inactivity_signaled + 1;
         }
         this.stopInactivityDetector();
      }
   }
   function __get__livingPlayerInCurrentTeam()
   {
      var _loc2_ = this.api.datacenter.Basics.team(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team);
      var _loc3_ = 0;
      for(var i in _loc2_)
      {
         if(_loc2_[i].LP > 0)
         {
            _loc3_ = _loc3_ + 1;
         }
      }
      return _loc3_;
   }
   function __get__autoSkip()
   {
      return !this._bFightActivity && (this._nFightTurnInactivity > 0 && (this.livingPlayerInCurrentTeam > 1 && this.api.lang.getConfigText("FIGHT_AUTO_SKIP")));
   }
   function signalFightActivity()
   {
      this._bFightActivity = true;
   }
   function onTurnEnd()
   {
      if(!this._bFightActivity && (this.api.lang.getConfigText("FIGHT_AUTO_SKIP") && this.livingPlayerInCurrentTeam > 1))
      {
         this._nFightTurnInactivity = this._nFightTurnInactivity + 1;
         this.api.kernel.showMessage(undefined,this.api.lang.getText("INFIGHT_INACTIVITY_AUTO_SKIP"),"ERROR_CHAT");
      }
      else
      {
         this._nFightTurnInactivity = 0;
      }
   }
   function onMouseMove()
   {
      this._bFightActivity = true;
   }
   function onMouseUp()
   {
      this._bFightActivity = true;
   }
}
