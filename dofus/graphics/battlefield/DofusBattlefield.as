class dofus.graphics.battlefield.DofusBattlefield extends ank.battlefield.Battlefield
{
   function DofusBattlefield()
   {
      super();
   }
   function __get__api()
   {
      return this._oAPI;
   }
   function initialize(oDatacenter, sGroundFile, sObjectFile, sAccessoriesPath, oAPI)
   {
      super.initialize(oDatacenter,sGroundFile,sObjectFile,sAccessoriesPath);
      mx.events.EventDispatcher.initialize(this);
      this._oAPI = oAPI;
   }
   function addSpritePoints(sID, sValue, nColor)
   {
      if(this.api.kernel.OptionsManager.getOption("PointsOverHead"))
      {
         super.addSpritePoints(sID,sValue,nColor);
      }
   }
   function onInitError()
   {
      _root.onCriticalError(this.api.lang.getText("CRITICAL_ERROR_LOADING_BATTLEFIELD"));
   }
   function onMapLoaded()
   {
      var _loc2_ = this.api.datacenter.Map;
      this.api.ui.unloadUIComponent("CenterText");
      this.api.ui.unloadUIComponent("CenterTextMap");
      this.api.ui.unloadUIComponent("FightsInfos");
      this.setInteraction(ank.battlefield.Constants.INTERACTION_NONE);
      this.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
      this.setInteraction(ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT);
      if(this.api.datacenter.Game.isFight)
      {
         this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
      }
      else
      {
         this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
      }
      this.api.datacenter.Game.setInteractionType("move");
      this.api.datacenter.Game.isInCreaturesMode = false;
      this.api.network.Game.getExtraInformations();
      this.api.ui.unloadLastUIAutoHideComponent();
      this.api.ui.removePopupMenu();
      this.api.ui.getUIComponent("MapInfos").update();
      var _loc3_ = _loc2_.subarea;
      if(_loc3_ != this.api.datacenter.Basics.gfx_lastSubarea)
      {
         var _loc4_ = this.api.datacenter.Subareas.getItemAt(_loc3_);
         var _loc5_ = new String();
         var _loc6_ = new String();
         var _loc7_ = this.api.lang.getMapAreaText(_loc2_.area).n;
         if(_loc4_ == undefined)
         {
            _loc6_ = String(this.api.lang.getMapSubAreaText(_loc3_).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(_loc3_).n:String(this.api.lang.getMapSubAreaText(_loc3_).n).substr(2);
            if(_loc7_ != _loc6_)
            {
               _loc5_ = _loc7_ + "\n(" + _loc6_ + ")";
            }
            else
            {
               _loc5_ = _loc7_;
            }
         }
         else
         {
            _loc6_ = _loc4_.name;
            _loc5_ = _loc4_.name + " (" + _loc4_.alignment.name + ")";
            if(_loc7_ != _loc6_)
            {
               _loc5_ = _loc7_ + "\n(" + _loc6_ + ")\n" + _loc4_.alignment.name;
            }
            else
            {
               _loc5_ = _loc7_ + "\n" + _loc4_.alignment.name;
            }
         }
         if(!this.api.kernel.TutorialManager.isTutorialMode)
         {
            this.api.ui.loadUIComponent("CenterText","CenterText",{text:_loc5_,background:false,timer:2000},{bForceLoad:true});
         }
         this.api.datacenter.Basics.gfx_lastSubarea = _loc3_;
      }
      if(this.api.datacenter.Player.isAtHome(_loc2_.id))
      {
         var _loc8_ = new Array();
         var _loc9_ = this.api.lang.getHousesIndoorSkillsText();
         var _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            var _loc11_ = new dofus.datacenter.Skill(_loc9_[_loc10_]);
            _loc8_.push(_loc11_);
            _loc10_ = _loc10_ + 1;
         }
         var _loc12_ = this.api.lang.getHousesMapText(_loc2_.id);
         if(_loc12_ != undefined)
         {
            var _loc13_ = this.api.datacenter.Houses.getItemAt(_loc12_);
            this.api.ui.loadUIComponent("HouseIndoor","HouseIndoor",{skills:_loc8_,house:_loc13_},{bStayIfPresent:true});
         }
         this.api.ui.getUIComponent("MapInfos")._visible = false;
      }
      else
      {
         this.api.ui.unloadUIComponent("HouseIndoor");
      }
      if(this.api.kernel.OptionsManager.getOption("Grid") == true)
      {
         this.api.gfx.drawGrid();
      }
      else
      {
         this.api.gfx.removeGrid();
      }
      this.api.ui.getUIComponent("Banner").setCircleXtraParams({currentCoords:[_loc2_.x,_loc2_.y]});
      if(Number(_loc2_.ambianceID) > 0)
      {
         this.api.sounds.playEnvironment(_loc2_.ambianceID);
      }
      if(Number(_loc2_.musicID) > 0)
      {
         this.api.sounds.playMusic(_loc2_.musicID,true);
      }
      if(!_loc2_.bOutdoor)
      {
         this.api.kernel.NightManager.noEffects();
      }
      var _loc14_ = (Array)this.api.lang.getMapText(_loc2_.id).p;
      var _loc15_ = 0;
      while(_loc14_.length > _loc15_)
      {
         var _loc16_ = _loc14_[_loc15_][0];
         var _loc17_ = _loc14_[_loc15_][1];
         var _loc18_ = _loc14_[_loc15_][2];
         if(!dofus.utils.criterions.CriterionManager.fillingCriterions(_loc18_))
         {
            var _loc19_ = this.api.gfx.mapHandler.getCellData(_loc17_);
            var _loc20_ = 0;
            while(_loc20_ < _loc16_.length)
            {
               if(_loc19_.layerObject1Num == _loc16_[_loc20_])
               {
                  _loc19_.mcObject1._visible = false;
               }
               if(_loc19_.layerObject2Num == _loc16_[_loc20_])
               {
                  _loc19_.mcObject2._visible = false;
               }
               _loc20_ = _loc20_ + 1;
            }
         }
         _loc15_ = _loc15_ + 1;
      }
      this.dispatchEvent({type:"mapLoaded"});
   }
   function onCellRelease(mcCell)
   {
      if(this.api.kernel.TutorialManager.isTutorialMode)
      {
         this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_RELEASE",params:[mcCell.num]});
         return false;
      }
      switch(this.api.datacenter.Game.interactionType)
      {
         case 1:
            var _loc3_ = this.api.datacenter.Player.data;
            var _loc4_ = false;
            var _loc5_ = this.api.datacenter.Player.canMoveInAllDirections;
            var _loc6_ = this.api.datacenter.Player.data.isInMove;
            if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,mcCell.num,true,this.api.datacenter.Game.isFight,false,_loc5_,_loc6_))
            {
               if(this.api.datacenter.Game.isFight)
               {
                  _loc4_ = true;
               }
               else
               {
                  _loc4_ = this.api.datacenter.Basics.interactionsManager_path[this.api.datacenter.Basics.interactionsManager_path.length - 1].num == mcCell.num;
               }
            }
            if(!this.api.datacenter.Game.isFight && !_loc4_)
            {
               if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,mcCell.num,true,this.api.datacenter.Game.isFight,true,_loc5_,_loc6_))
               {
                  _loc4_ = true;
               }
            }
            if(_loc4_)
            {
               if(getTimer() - this.api.datacenter.Basics.gfx_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
               {
                  ank.utils.Logger.err("T trop rapide du clic");
                  return null;
               }
               this.api.datacenter.Basics.gfx_lastActionTime = getTimer();
               if(this.api.datacenter.Basics.interactionsManager_path.length != 0)
               {
                  var _loc7_ = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
                  if(_loc7_ != undefined)
                  {
                     _loc3_.GameActionsManager.transmittingMove(1,[_loc7_]);
                     delete this.api.datacenter.Basics.interactionsManager_path;
                  }
               }
               return true;
            }
            return false;
         case 2:
            if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
            {
               var _loc8_ = this.api.datacenter.Player.data;
               _loc8_.GameActionsManager.transmittingOther(300,[this.api.datacenter.Player.currentUseObject.ID,mcCell.num]);
               this.api.datacenter.Player.currentUseObject = null;
            }
            else if(this.api.datacenter.Basics.spellManager_errorMsg != undefined)
            {
               this.api.kernel.showMessage(undefined,this.api.datacenter.Basics.spellManager_errorMsg,"ERROR_CHAT");
               delete this.api.datacenter.Basics.spellManager_errorMsg;
            }
            this.api.ui.removeCursor();
            this.api.kernel.GameManager.lastSpellLaunch = getTimer();
            this.api.datacenter.Game.setInteractionType("move");
         case 3:
            if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
            {
               var _loc9_ = this.api.datacenter.Player.data;
               _loc9_.GameActionsManager.transmittingOther(303,[mcCell.num]);
               this.api.datacenter.Player.currentUseObject = null;
            }
            this.api.ui.removeCursor();
            this.api.kernel.GameManager.lastSpellLaunch = getTimer();
            this.api.datacenter.Game.setInteractionType("move");
         case 4:
            var _loc10_ = this.mapHandler.getCellData(mcCell.num).spriteOnID;
            if(_loc10_ == undefined)
            {
               this.api.network.Game.setPlayerPosition(mcCell.num);
            }
         case 5:
            if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
            {
               this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID,this.mapHandler.getCellData(mcCell.num).spriteOnID,mcCell.num);
            }
            this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
            this.api.gfx.clearPointer();
            this.unSelect(true);
            this.api.datacenter.Player.reset();
            this.api.ui.removeCursor();
            this.api.datacenter.Game.setInteractionType("move");
         case 6:
            if(this.api.datacenter.Game.isFight)
            {
               if(mcCell.num != undefined)
               {
                  this.api.network.Game.setFlag(mcCell.num);
               }
               this.api.gfx.clearPointer();
               this.api.gfx.unSelectAllButOne("startPosition");
               this.api.ui.removeCursor();
               if(this.api.datacenter.Game.isRunning && this.api.datacenter.Game.currentPlayerID == this.api.datacenter.Player.ID)
               {
                  this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
                  this.api.datacenter.Game.setInteractionType("move");
               }
               else
               {
                  this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                  this.api.datacenter.Game.setInteractionType("place");
               }
            }
         default:
      }
   }
   function onCellRollOver(mcCell)
   {
      if(this.api.kernel.TutorialManager.isTutorialMode)
      {
         this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_OVER",params:[mcCell.num]});
         return undefined;
      }
      if(this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
      {
         return undefined;
      }
      switch(this.api.datacenter.Game.interactionType)
      {
         case 1:
            var _loc3_ = this.api.datacenter.Player;
            var _loc4_ = _loc3_.data;
            var _loc5_ = this.mapHandler.getCellData(mcCell.num).spriteOnID;
            var _loc6_ = this.api.datacenter.Sprites.getItemAt(_loc5_);
            if(_loc6_ != undefined)
            {
               this.showSpriteInfosIfWeNeed(_loc6_);
            }
            if(ank.battlefield.utils.Pathfinding.checkRange(this.mapHandler,_loc4_.cellNum,mcCell.num,false,0,_loc4_.MP,0))
            {
               this.api.datacenter.Player.InteractionsManager.setState(this.api.datacenter.Game.isFight);
               this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,mcCell.num,false,this.api.datacenter.Game.isFight);
            }
            else
            {
               delete this.api.datacenter.Basics.interactionsManager_path;
            }
            break;
         case 2:
         case 3:
            var _loc7_ = this.api.datacenter.Player;
            var _loc8_ = _loc7_.data;
            var _loc9_ = _loc8_.cellNum;
            var _loc10_ = _loc7_.currentUseObject;
            var _loc11_ = _loc7_.SpellsManager;
            var _loc12_ = !_loc10_.canBoostRange?0:_loc8_.CharacteristicsManager.getModeratorValue(19) + _loc7_.RangeModerator;
            this.api.datacenter.Basics.gfx_canLaunch = _loc11_.checkCanLaunchSpellOnCell(this.mapHandler,_loc10_,this.mapHandler.getCellData(mcCell.num),_loc12_);
            if(this.api.datacenter.Basics.gfx_canLaunch)
            {
               this.api.ui.setCursorForbidden(false);
               this.drawPointer(mcCell.num);
            }
            else
            {
               this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
            }
            break;
         case 5:
         case 6:
            this.api.datacenter.Basics.gfx_canLaunch = true;
            this.api.ui.setCursorForbidden(false);
            this.drawPointer(mcCell.num);
      }
   }
   function onCellRollOut(mcCell)
   {
      if(this.api.kernel.TutorialManager.isTutorialMode)
      {
         this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_OUT",params:[mcCell.num]});
         return undefined;
      }
      if(this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
      {
         return undefined;
      }
      switch(this.api.datacenter.Game.interactionType)
      {
         case 1:
            this.hideSpriteInfos();
            this.unSelect(true);
            break;
         case 2:
         case 3:
            this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
            this.hidePointer();
            this.api.datacenter.Basics.gfx_canLaunch = false;
            this.hideSpriteInfos();
            break;
         case 5:
         case 6:
            this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
            this.api.datacenter.Basics.gfx_canLaunch = false;
            this.hidePointer();
      }
   }
   function onSpriteRelease(mcSprite)
   {
      var _loc3_ = mcSprite.data;
      var _loc4_ = _loc3_.id;
      if(this.api.kernel.TutorialManager.isTutorialMode)
      {
         this.api.kernel.TutorialManager.onWaitingCase({code:"SPRITE_RELEASE",params:[_loc3_.id]});
         return undefined;
      }
      if(_loc3_.hasParent)
      {
         this.onSpriteRelease(_loc3_.linkedParent.mc);
         return undefined;
      }
      if((var _loc0_ = this.api.datacenter.Game.interactionType) !== 5)
      {
         if(_loc3_ instanceof dofus.datacenter.Mutant && !_loc3_.showIsPlayer)
         {
            if(!this.api.datacenter.Game.isRunning)
            {
               if(this.api.datacenter.Player.isMutant)
               {
                  return undefined;
               }
            }
            var _loc5_ = this.mapHandler.getCellData(_loc3_.cellNum).mc;
            this.onCellRelease(_loc5_);
         }
         else if(_loc3_ instanceof dofus.datacenter.Character || _loc3_ instanceof dofus.datacenter.Mutant && _loc3_.showIsPlayer)
         {
            if(this.api.datacenter.Game.isFight)
            {
               if(this.api.datacenter.Game.isRunning)
               {
                  var _loc6_ = this.mapHandler.getCellData(_loc3_.cellNum).mc;
                  this.onCellRelease(_loc6_);
                  return undefined;
               }
            }
            this.api.kernel.GameManager.showPlayerPopupMenu(_loc3_,undefined);
         }
         else if(_loc3_ instanceof dofus.datacenter.NonPlayableCharacter)
         {
            if(this.api.datacenter.Player.cantSpeakNPC)
            {
               return undefined;
            }
            var _loc7_ = _loc3_.actions;
            if(_loc7_ != undefined && _loc7_.length != 0)
            {
               var _loc8_ = this.api.ui.createPopupMenu();
               var _loc9_ = _loc7_.length;
               while(true)
               {
                  _loc9_;
                  if(_loc9_-- > 0)
                  {
                     var _loc10_ = _loc7_[_loc9_].action;
                     _loc8_.addItem(_loc7_[_loc9_].name,_loc10_.object,_loc10_.method,_loc10_.params);
                     continue;
                  }
                  break;
               }
               _loc8_.show(_root._xmouse,_root._ymouse);
            }
         }
         else if(_loc3_ instanceof dofus.datacenter.Team)
         {
            var _loc11_ = this.api.datacenter.Player.data.alignment.index;
            var _loc12_ = _loc3_.alignment.index;
            var _loc13_ = _loc3_.enemyTeam.alignment.index;
            var _loc14_ = _loc3_.challenge.fightType;
            var _loc15_ = false;
            switch(_loc14_)
            {
               case 0:
                  switch(_loc3_.type)
                  {
                     case 0:
                     case 2:
                        _loc15_ = this.api.datacenter.Player.canChallenge && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant);
                  }
                  break;
               case 1:
               case 2:
                  switch(_loc3_.type)
                  {
                     case 0:
                     case 1:
                        if(_loc11_ == _loc12_)
                        {
                           _loc15_ = !this.api.datacenter.Player.isMutant;
                        }
                        else
                        {
                           _loc15_ = this.api.lang.getAlignmentCanJoin(_loc11_,_loc12_) && (this.api.lang.getAlignmentCanAttack(_loc11_,_loc13_) && !this.api.datacenter.Player.isMutant);
                        }
                  }
                  break;
               case 3:
                  switch(_loc3_.type)
                  {
                     case 0:
                        _loc15_ = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
                        break;
                     case 1:
                        _loc15_ = false;
                  }
                  break;
               case 4:
                  switch(_loc3_.type)
                  {
                     case 0:
                        _loc15_ = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
                        break;
                     case 1:
                        _loc15_ = false;
                  }
                  break;
               case 5:
                  switch(_loc3_.type)
                  {
                     case 0:
                        _loc15_ = !this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.cantInteractWithTaxCollector;
                        break;
                     case 3:
                        _loc15_ = false;
                  }
                  break;
               case 6:
                  switch(_loc3_.type)
                  {
                     case 0:
                        _loc15_ = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
                        break;
                     case 2:
                        _loc15_ = this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant == true;
                  }
            }
            if(_loc15_)
            {
               var _loc16_ = this.api.ui.createPopupMenu();
               var _loc17_ = this.api.lang.getMapMaxTeam(this.api.datacenter.Map.id);
               var _loc18_ = this.api.lang.getMapMaxChallenge(this.api.datacenter.Map.id);
               if(_loc3_.challenge.count >= _loc18_)
               {
                  _loc16_.addItem(this.api.lang.getText("CHALENGE_FULL"));
               }
               else if(_loc3_.count >= _loc17_)
               {
                  _loc16_.addItem(this.api.lang.getText("TEAM_FULL"));
               }
               else if(Key.isDown(Key.SHIFT))
               {
                  this.api.network.GameActions.joinChallenge(_loc3_.challenge.id,_loc3_.id);
                  this.api.ui.hideTooltip();
               }
               else
               {
                  _loc16_.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.network.GameActions,this.api.network.GameActions.joinChallenge,[_loc3_.challenge.id,_loc3_.id]);
               }
               _loc16_.show(_root._xmouse,_root._ymouse);
            }
         }
         else if(_loc3_ instanceof dofus.datacenter.ParkMount)
         {
            if(_loc3_.ownerName == this.api.datacenter.Player.Name || this.api.datacenter.Map.mountPark.guildName == this.api.datacenter.Player.guildInfos.name && this.api.datacenter.Player.guildInfos.playerRights.canManageOtherMount)
            {
               var _loc19_ = this.api.ui.createPopupMenu();
               _loc19_.addStaticItem(this.api.lang.getText("MOUNT_OF",[_loc3_.ownerName]));
               _loc19_.addItem(this.api.lang.getText("VIEW_MOUNT_DETAILS"),this.api.network.Mount,this.api.network.Mount.parkMountData,[_loc3_.id]);
               _loc19_.show(_root._xmouse,_root._ymouse);
            }
         }
         else if(_loc3_ instanceof dofus.datacenter.Creature)
         {
            var _loc20_ = this.mapHandler.getCellData(_loc3_.cellNum).mc;
            this.onCellRelease(_loc20_);
         }
         else if(_loc3_ instanceof dofus.datacenter.MonsterGroup || _loc3_ instanceof dofus.datacenter.Monster)
         {
            if(_loc3_ instanceof dofus.datacenter.Monster && this.api.kernel.GameManager.isInMyTeam(_loc3_))
            {
               this.api.kernel.GameManager.showMonsterPopupMenu(_loc3_);
            }
            if(!this.api.datacenter.Player.isMutant || (this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant || this.api.datacenter.Player.canAttackMonstersAnywhereWhenMutant))
            {
               var _loc21_ = this.mapHandler.getCellData(_loc3_.cellNum).mc;
               this.onCellRelease(_loc21_);
            }
         }
         else if(_loc3_ instanceof dofus.datacenter.OfflineCharacter)
         {
            if(!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant)
            {
               if(!this.api.datacenter.Player.canExchange)
               {
                  return undefined;
               }
               var _loc22_ = this.api.ui.createPopupMenu();
               _loc22_.addStaticItem(this.api.lang.getText("SHOP") + " " + this.api.lang.getText("OF") + " " + _loc3_.name);
               _loc22_.addItem(this.api.lang.getText("BUY"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[4,_loc3_.id,_loc3_.cellNum]);
               if(this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
               {
                  _loc22_.addItem(this.api.lang.getText("KICKOFF"),this.api.network.Basics,this.api.network.Basics.kick,[_loc3_.cellNum]);
               }
               _loc22_.show(_root._xmouse,_root._ymouse);
            }
         }
         else if(_loc3_ instanceof dofus.datacenter.TaxCollector)
         {
            if(!this.api.datacenter.Player.isMutant)
            {
               if(this.api.datacenter.Player.cantInteractWithTaxCollector)
               {
                  return undefined;
               }
               if(this.api.datacenter.Game.isFight)
               {
                  var _loc23_ = this.mapHandler.getCellData(_loc3_.cellNum).mc;
                  this.onCellRelease(_loc23_);
               }
               else
               {
                  var _loc24_ = this.api.datacenter.Player.guildInfos.playerRights;
                  var _loc25_ = _loc3_.guildName == this.api.datacenter.Player.guildInfos.name;
                  var _loc26_ = _loc25_ && _loc24_.canHireTaxCollector;
                  var _loc27_ = this.api.ui.createPopupMenu();
                  _loc27_.addItem(this.api.lang.getText("SPEAK"),this.api.network.Dialog,this.api.network.Dialog.create,[_loc4_]);
                  _loc27_.addItem(this.api.lang.getText("COLLECT_TAX"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[8,_loc4_],_loc25_);
                  _loc27_.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackTaxCollector,[[_loc4_]],!_loc25_);
                  _loc27_.addItem(this.api.lang.getText("REMOVE"),this.api.kernel.GameManager,this.api.kernel.GameManager.askRemoveTaxCollector,[[_loc4_]],_loc26_);
                  _loc27_.show(_root._xmouse,_root._ymouse);
               }
            }
         }
         else if(_loc3_ instanceof dofus.datacenter.PrismSprite)
         {
            if(!this.api.datacenter.Player.isMutant)
            {
               if(this.api.datacenter.Game.isFight)
               {
                  var _loc28_ = this.mapHandler.getCellData(_loc3_.cellNum).mc;
                  this.onCellRelease(_loc28_);
               }
               else
               {
                  var _loc29_ = this.api.datacenter.Player.alignment.compareTo(_loc3_.alignment) == 0;
                  var _loc30_ = this.api.ui.createPopupMenu();
                  _loc30_.addItem(this.api.lang.getText("USE_WORD"),this.api.network.GameActions,this.api.network.GameActions.usePrism,[[_loc4_]],_loc29_);
                  _loc30_.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackPrism,[[_loc4_]],!_loc29_);
                  _loc30_.show(_root._xmouse,_root._ymouse);
               }
            }
         }
      }
      else
      {
         if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
         {
            this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID,_loc3_.id,_loc3_.cellNum);
         }
         this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
         this.api.gfx.clearPointer();
         this.unSelect(true);
         this.api.datacenter.Player.reset();
         this.api.ui.removeCursor();
         this.api.datacenter.Game.setInteractionType("move");
      }
   }
   function onSpriteRollOver(mcSprite)
   {
      if(this.api.ui.getUIComponent("Zoom") != undefined)
      {
         return undefined;
      }
      var _loc5_ = mcSprite.data;
      var _loc6_ = dofus.Constants.OVERHEAD_TEXT_OTHER;
      if(_loc5_.isClear)
      {
         return undefined;
      }
      if(_loc5_.hasParent)
      {
         this.onSpriteRollOver(_loc5_.linkedParent.mc);
         return undefined;
      }
      if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
      {
         var _loc8_ = this.mapHandler.getCellData(_loc5_.cellNum).mc;
         if(_loc5_.isVisible)
         {
            this.onCellRollOver(_loc8_);
         }
      }
      var _loc9_ = _loc5_.name;
      if(_loc5_ instanceof dofus.datacenter.Mutant && _loc5_.showIsPlayer)
      {
         if(this.api.datacenter.Game.isRunning)
         {
            _loc9_ = _loc5_.playerName + " (" + _loc5_.LP + ")";
            this.showSpriteInfosIfWeNeed(_loc5_);
         }
         else
         {
            _loc9_ = _loc5_.playerName + " [" + _loc5_.monsterName + " (" + _loc5_.Level + ")]";
         }
      }
      else if(_loc5_ instanceof dofus.datacenter.Mutant || (_loc5_ instanceof dofus.datacenter.Creature || _loc5_ instanceof dofus.datacenter.Monster))
      {
         _loc6_ = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc5_.alignment.index];
         if(this.api.datacenter.Game.isRunning)
         {
            _loc9_ = _loc9_ + (" (" + _loc5_.LP + ")");
            this.showSpriteInfosIfWeNeed(_loc5_);
         }
         else
         {
            _loc9_ = _loc9_ + (" (" + _loc5_.Level + ")");
         }
      }
      else if(_loc5_ instanceof dofus.datacenter.Character)
      {
         _loc6_ = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
         if(this.api.datacenter.Game.isRunning)
         {
            _loc9_ = _loc9_ + (" (" + _loc5_.LP + ")");
            if(_loc5_.isVisible)
            {
               var _loc10_ = _loc5_.EffectsManager.getEffects();
               if(_loc10_.length != 0)
               {
                  this.addSpriteOverHeadItem(_loc5_.id,"effects",dofus.graphics.battlefield.EffectsOverHead,[_loc10_]);
               }
            }
            this.showSpriteInfosIfWeNeed(_loc5_);
         }
         else if(this.api.datacenter.Game.isFight)
         {
            _loc9_ = _loc9_ + (" (" + _loc5_.Level + ")");
         }
         if(!_loc5_.isVisible)
         {
            return undefined;
         }
         var _loc3_ = dofus.Constants.DEMON_ANGEL_FILE;
         if(_loc5_.alignment.fallenAngelDemon)
         {
            _loc3_ = dofus.Constants.FALLEN_DEMON_ANGEL_FILE;
         }
         var _loc11_ = !_loc5_.haveFakeAlignement?_loc5_.alignment.index:_loc5_.fakeAlignment.index;
         if(_loc5_.rank.value > 0)
         {
            if(_loc11_ == 1)
            {
               var _loc4_ = _loc5_.rank.value;
            }
            else if(_loc11_ == 2)
            {
               _loc4_ = 10 + _loc5_.rank.value;
            }
            else if(_loc11_ == 3)
            {
               _loc4_ = 20 + _loc5_.rank.value;
            }
         }
         var _loc7_ = _loc5_.title;
         if(_loc5_.guildName != undefined && _loc5_.guildName.length != 0)
         {
            _loc9_ = "";
            this.addSpriteOverHeadItem(_loc5_.id,"text",dofus.graphics.battlefield.GuildOverHead,[_loc5_.guildName,_loc5_.name,_loc5_.emblem,_loc3_,_loc4_,_loc5_.pvpGain,_loc7_],undefined,true);
         }
      }
      else if(_loc5_ instanceof dofus.datacenter.TaxCollector)
      {
         if(this.api.datacenter.Game.isRunning)
         {
            _loc9_ = _loc9_ + (" (" + _loc5_.LP + ")");
            this.showSpriteInfosIfWeNeed(_loc5_);
         }
         else if(this.api.datacenter.Game.isFight)
         {
            _loc9_ = _loc9_ + (" (" + _loc5_.Level + ")");
         }
         else
         {
            _loc9_ = "";
            this.addSpriteOverHeadItem(_loc5_.id,"text",dofus.graphics.battlefield.GuildOverHead,[_loc5_.guildName,_loc5_.name,_loc5_.emblem]);
         }
      }
      else if(_loc5_ instanceof dofus.datacenter.PrismSprite)
      {
         _loc3_ = dofus.Constants.DEMON_ANGEL_FILE;
         if(_loc5_.alignment.value > 0)
         {
            if(_loc5_.alignment.index == 1)
            {
               _loc4_ = _loc5_.alignment.value;
            }
            else if(_loc5_.alignment.index == 2)
            {
               _loc4_ = 10 + _loc5_.alignment.value;
            }
            else if(_loc5_.alignment.index == 3)
            {
               _loc4_ = 20 + _loc5_.alignment.value;
            }
         }
         _loc6_ = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc5_.alignment.index];
         this.addSpriteOverHeadItem(_loc5_.id,"text",dofus.graphics.battlefield.TextOverHead,[_loc9_,_loc3_,_loc6_,_loc4_]);
      }
      else if(_loc5_ instanceof dofus.datacenter.ParkMount)
      {
         _loc6_ = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
         _loc9_ = this.api.lang.getText("MOUNT_PARK_OVERHEAD",[_loc5_.modelName,_loc5_.level,_loc5_.ownerName]);
         this.addSpriteOverHeadItem(_loc5_.id,"text",dofus.graphics.battlefield.TextOverHead,[_loc9_,_loc3_,_loc6_,_loc4_]);
      }
      else if(_loc5_ instanceof dofus.datacenter.OfflineCharacter)
      {
         _loc6_ = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
         _loc9_ = "";
         this.addSpriteOverHeadItem(_loc5_.id,"text",dofus.graphics.battlefield.OfflineOverHead,[_loc5_]);
      }
      else if(_loc5_ instanceof dofus.datacenter.NonPlayableCharacter)
      {
         var _loc12_ = this.api.datacenter.Map;
         var _loc13_ = this.api.datacenter.Subareas.getItemAt(_loc12_.subarea);
         if(_loc13_ != undefined)
         {
            _loc6_ = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc13_.alignment.index];
         }
      }
      else if(_loc5_ instanceof dofus.datacenter.MonsterGroup || _loc5_ instanceof dofus.datacenter.Team)
      {
         if(_loc5_.alignment.index != -1)
         {
            _loc6_ = dofus.Constants.NPC_ALIGNMENT_COLOR[_loc5_.alignment.index];
         }
         var _loc14_ = _loc5_.challenge.fightType;
         if(_loc5_.isVisible && (_loc5_ instanceof dofus.datacenter.MonsterGroup || _loc5_.type == 1 && (_loc14_ == 2 || (_loc14_ == 3 || _loc14_ == 4))))
         {
            if(_loc9_ != "")
            {
               var _loc15_ = dofus.Constants.OVERHEAD_TEXT_TITLE;
               this.addSpriteOverHeadItem(_loc5_.id,"text",dofus.graphics.battlefield.TextWithTitleOverHead,[_loc9_,_loc3_,_loc6_,_loc4_,this.api.lang.getText("LEVEL") + " " + _loc5_.totalLevel,_loc15_,_loc5_.bonusValue]);
            }
            this.selectSprite(_loc5_.id,true);
            return undefined;
         }
      }
      if(_loc5_.isVisible)
      {
         if(_loc9_ != "")
         {
            this.addSpriteOverHeadItem(_loc5_.id,"text",dofus.graphics.battlefield.TextOverHead,[_loc9_,_loc3_,_loc6_,_loc4_,_loc5_.pvpGain,_loc7_]);
         }
         this.selectSprite(_loc5_.id,true);
      }
   }
   function onSpriteRollOut(mcSprite)
   {
      var _loc3_ = mcSprite.data;
      if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && _loc3_ instanceof dofus.datacenter.MonsterGroup)
      {
         return undefined;
      }
      if(_loc3_.hasParent)
      {
         this.onSpriteRollOut(_loc3_.linkedParent.mc);
         return undefined;
      }
      if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
      {
         this.hideSpriteInfos();
         var _loc4_ = this.mapHandler.getCellData(_loc3_.cellNum).mc;
         this.onCellRollOut(_loc4_);
      }
      this.removeSpriteOverHeadLayer(_loc3_.id,"text");
      this.removeSpriteOverHeadLayer(_loc3_.id,"effects");
      this.selectSprite(_loc3_.id,false);
   }
   function onObjectRelease(mcObject)
   {
      this.api.ui.hideTooltip();
      var _loc3_ = mcObject.cellData;
      var _loc4_ = _loc3_.mc;
      var _loc5_ = _loc3_.layerObject2Num;
      if(this.api.kernel.TutorialManager.isTutorialMode)
      {
         this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_RELEASE",params:[_loc3_.num,_loc5_]});
         return undefined;
      }
      var _loc6_ = _loc3_.layerObjectExternalData;
      if(_loc6_ != undefined)
      {
         if(_loc6_.durability != undefined)
         {
            if(this.api.datacenter.Map.mountPark.isMine(this.api))
            {
               var _loc7_ = this.api.ui.createPopupMenu();
               _loc7_.addStaticItem(_loc6_.name);
               _loc7_.addItem(this.api.lang.getText("REMOVE"),this.api.network.Mount,this.api.network.Mount.removeObjectInPark,[_loc4_.num]);
               _loc7_.show(_root._xmouse,_root._ymouse);
               return undefined;
            }
         }
      }
      if(!_global.isNaN(_loc5_) && (this.api.datacenter.Player.canUseInteractiveObjects && this.api.datacenter.Game.interactionType != 5))
      {
         var _loc8_ = this.api.lang.getInteractiveObjectDataByGfxText(_loc5_);
         var _loc9_ = _loc8_.n;
         var _loc10_ = _loc8_.sk;
         var _loc11_ = _loc8_.t;
         switch(_loc11_)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 7:
            case 10:
            case 12:
            case 14:
            case 15:
               var _loc12_ = this.api.datacenter.Player.currentJobID != undefined;
               if(_loc12_)
               {
                  var _loc13_ = this.api.datacenter.Player.Jobs.findFirstItem("id",this.api.datacenter.Player.currentJobID).item.skills;
               }
               else
               {
                  _loc13_ = new ank.utils.ExtendedArray();
               }
               var _loc14_ = this.api.ui.createPopupMenu();
               _loc14_.addStaticItem(_loc9_);
               for(var k in _loc10_)
               {
                  var _loc15_ = _loc10_[k];
                  var _loc16_ = new dofus.datacenter.Skill(_loc15_);
                  var _loc17_ = _loc13_.findFirstItem("id",_loc15_).index != -1;
                  var _loc18_ = this.api.datacenter.Player.Level <= dofus.Constants.NOVICE_LEVEL;
                  var _loc19_ = _loc16_.getState(_loc17_,false,false,false,false,_loc18_);
                  if(_loc19_ != "X")
                  {
                     _loc14_.addItem(_loc16_.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[_loc4_,_loc4_.num,_loc15_],_loc19_ == "V");
                  }
               }
               _loc14_.show(_root._xmouse,_root._ymouse);
               break;
            case 5:
               var _loc20_ = this.api.ui.createPopupMenu();
               var _loc21_ = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id,_loc4_.num);
               var _loc22_ = this.api.datacenter.Houses.getItemAt(_loc21_);
               _loc20_.addStaticItem(_loc9_ + " " + _loc22_.name);
               if(_loc22_.localOwner)
               {
                  _loc20_.addStaticItem(this.api.lang.getText("MY_HOME"));
               }
               else if(_loc22_.ownerName != undefined)
               {
                  if(_loc22_.ownerName == "?")
                  {
                     _loc20_.addStaticItem(this.api.lang.getText("HOUSE_WITH_NO_OWNER"));
                  }
                  else
                  {
                     _loc20_.addStaticItem(this.api.lang.getText("HOME_OF",[_loc22_.ownerName]));
                  }
               }
               for(var k in _loc10_)
               {
                  var _loc23_ = _loc10_[k];
                  var _loc24_ = new dofus.datacenter.Skill(_loc23_);
                  var _loc25_ = _loc24_.getState(true,_loc22_.localOwner,_loc22_.isForSale,_loc22_.isLocked);
                  if(_loc25_ != "X")
                  {
                     _loc20_.addItem(_loc24_.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[_loc4_,_loc4_.num,_loc23_],_loc25_ == "V");
                  }
               }
               _loc20_.show(_root._xmouse,_root._ymouse);
               break;
            case 6:
               var _loc26_ = this.api.datacenter.Map.id + "_" + _loc4_.num;
               var _loc27_ = this.api.datacenter.Storages.getItemAt(_loc26_);
               var _loc28_ = _loc27_.isLocked;
               var _loc29_ = this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id);
               var _loc30_ = this.api.ui.createPopupMenu();
               _loc30_.addStaticItem(_loc9_);
               for(var k in _loc10_)
               {
                  var _loc31_ = _loc10_[k];
                  var _loc32_ = new dofus.datacenter.Skill(_loc31_);
                  var _loc33_ = _loc32_.getState(true,_loc29_,true,_loc28_);
                  if(_loc33_ != "X")
                  {
                     _loc30_.addItem(_loc32_.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[_loc4_,_loc4_.num,_loc31_],_loc33_ == "V");
                  }
               }
               _loc30_.show(_root._xmouse,_root._ymouse);
               break;
            case 13:
               var _loc34_ = this.api.datacenter.Map.mountPark;
               var _loc35_ = this.api.ui.createPopupMenu();
               _loc35_.addStaticItem(_loc9_);
               for(var k in _loc10_)
               {
                  var _loc36_ = _loc10_[k];
                  var _loc37_ = new dofus.datacenter.Skill(_loc36_);
                  var _loc38_ = _loc37_.getState(true,_loc34_.isMine(this.api),_loc34_.price > 0,_loc34_.isPublic || _loc34_.isMine(this.api),false,_loc34_.isPublic);
                  if(_loc38_ != "X")
                  {
                     _loc35_.addItem(_loc37_.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[_loc4_,_loc4_.num,_loc36_],_loc38_ == "V");
                  }
               }
               _loc35_.show(_root._xmouse,_root._ymouse);
               break;
            default:
               this.onCellRelease(_loc4_);
         }
      }
      else
      {
         this.onCellRelease(_loc4_);
      }
   }
   function onObjectRollOver(mcObject)
   {
      if(this.api.ui.getUIComponent("Zoom") != undefined)
      {
         return undefined;
      }
      var _loc3_ = mcObject.cellData;
      var _loc4_ = _loc3_.mc;
      var _loc5_ = _loc3_.layerObject2Num;
      if(this.api.datacenter.Game.interactionType == 5)
      {
         _loc4_ = mcObject.cellData.mc;
         this.onCellRollOver(_loc4_);
      }
      mcObject.select(true);
      var _loc6_ = _loc3_.layerObjectExternalData;
      if(_loc6_ != undefined)
      {
         var _loc7_ = _loc6_.name;
         if(_loc6_.durability != undefined)
         {
            if(this.api.datacenter.Map.mountPark.isMine(this.api))
            {
               _loc7_ = _loc7_ + ("\n" + this.api.lang.getText("DURABILITY") + " : " + _loc6_.durability + "/" + _loc6_.durabilityMax);
            }
         }
         var _loc8_ = new dofus.datacenter.Character("itemOnCell",ank.battlefield.mc.Sprite,"",_loc4_.num,0,0);
         this.api.datacenter.Sprites.addItemAt("itemOnCell",_loc8_);
         this.api.gfx.addSprite("itemOnCell");
         this.addSpriteOverHeadItem("itemOnCell","text",dofus.graphics.battlefield.TextOverHead,[_loc7_,"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
      }
      var _loc9_ = this.api.lang.getInteractiveObjectDataByGfxText(_loc5_);
      var _loc10_ = _loc9_.n;
      var _loc11_ = _loc9_.sk;
      var _loc12_ = _loc9_.t;
      switch(_loc12_)
      {
         case 5:
            var _loc13_ = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id,_loc4_.num);
            var _loc14_ = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(_loc13_);
            if(_loc14_.guildName.length > 0)
            {
               var _loc15_ = new dofus.datacenter.Character("porte",ank.battlefield.mc.Sprite,"",_loc4_.num,0,0);
               this.api.datacenter.Sprites.addItemAt("porte",_loc15_);
               this.api.gfx.addSprite("porte");
               this.addSpriteOverHeadItem("porte","text",dofus.graphics.battlefield.GuildOverHead,[this.api.lang.getText("GUILD_HOUSE"),_loc14_.guildName,_loc14_.guildEmblem]);
            }
            break;
         case 13:
            var _loc16_ = this.api.datacenter.Map.mountPark;
            var _loc17_ = new dofus.datacenter.Character("enclos",ank.battlefield.mc.Sprite,"",_loc4_.num,0,0);
            this.api.datacenter.Sprites.addItemAt("enclos",_loc17_);
            this.api.gfx.addSprite("enclos");
            if(_loc16_.isPublic)
            {
               this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.TextOverHead,[this.api.lang.getText("MOUNTPARK_PUBLIC"),"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
            }
            else if(_loc16_.hasNoOwner)
            {
               this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.TextOverHead,[this.api.lang.getText("MOUNTPARK_TO_BUY",[_loc16_.price,_loc16_.size,_loc16_.items]),"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
            }
            else
            {
               if(_loc16_.price > 0)
               {
                  var _loc18_ = this.api.lang.getText("MOUNTPARK_PRIVATE_TO_BUY",[_loc16_.price]);
               }
               else
               {
                  _loc18_ = this.api.lang.getText("MOUNTPARK_PRIVATE");
               }
               this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.GuildOverHead,[_loc16_.guildName,_loc18_,_loc16_.guildEmblem]);
            }
      }
   }
   function onObjectRollOut(mcObject)
   {
      this.api.ui.hideTooltip();
      if(this.api.datacenter.Game.interactionType == 5)
      {
         var _loc3_ = mcObject.cellData.mc;
         this.onCellRollOut(_loc3_);
      }
      mcObject.select(false);
      this.removeSpriteOverHeadLayer("enclos","text");
      this.removeSprite("enclos",false);
      this.removeSpriteOverHeadLayer("porte","text");
      this.removeSprite("porte",false);
      this.removeSpriteOverHeadLayer("itemOnCell","text");
      this.removeSprite("itemOnCell",false);
   }
   function showSpriteInfosIfWeNeed(oSprite)
   {
      if(this.api.ui.isCursorHidden())
      {
         if(this.api.kernel.OptionsManager.getOption("SpriteInfos"))
         {
            if(this.api.kernel.OptionsManager.getOption("SpriteMove") && oSprite.isVisible)
            {
               this.api.gfx.drawZone(oSprite.cellNum,0,oSprite.MP,"move",dofus.Constants.CELL_MOVE_RANGE_COLOR,"C");
            }
            this.api.ui.getUIComponent("Banner").showRightPanel("BannerSpriteInfos",{data:oSprite});
         }
      }
   }
   function hideSpriteInfos()
   {
      this.api.ui.getUIComponent("Banner").hideRightPanel();
      this.api.gfx.clearZoneLayer("move");
   }
}
