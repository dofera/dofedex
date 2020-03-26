class dofus.aks.Game extends dofus.aks.Handler
{
   static var TYPE_SOLO = 1;
   static var TYPE_FIGHT = 2;
   var _bIsBusy = false;
   var _aGameSpriteLeftHistory = new Array();
   var nLastMapIdReceived = -1;
   function Game(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function __get__isBusy()
   {
      return this._bIsBusy;
   }
   function create()
   {
      this.aks.send("GC" + dofus.aks.Game.TYPE_SOLO);
   }
   function leave(sSpriteID)
   {
      this.aks.send("GQ" + (sSpriteID != undefined?sSpriteID:""));
   }
   function setPlayerPosition(nCellNum)
   {
      this.aks.send("Gp" + nCellNum,true);
   }
   function ready(bReady)
   {
      this.aks.send("GR" + (!bReady?"0":"1"));
   }
   function getMapData(nMapID)
   {
      if(this.api.lang.getConfigText("ENABLE_CLIENT_MAP_REQUEST"))
      {
         this.aks.send("GD" + (nMapID == undefined?"":String(nMapID)));
      }
   }
   function getExtraInformations()
   {
      this.aks.send("GI");
   }
   function turnEnd()
   {
      if(this.api.datacenter.Player.isCurrentPlayer)
      {
         this.aks.send("Gt",false);
      }
   }
   function turnOk(sSpriteID)
   {
      this.aks.send("GT" + (sSpriteID == undefined?"":sSpriteID),false);
   }
   function turnOk2(sSpriteID)
   {
      this.aks.send("GT" + (sSpriteID == undefined?"":sSpriteID),false);
   }
   function askDisablePVPMode()
   {
      this.aks.send("GP*",false);
   }
   function enabledPVPMode(bEnabled)
   {
      this.aks.send("GP" + (!bEnabled?"-":"+"),false);
   }
   function freeMySoul()
   {
      this.aks.send("GF",false);
   }
   function setFlag(nCellID)
   {
      this.aks.send("Gf" + nCellID,false);
   }
   function showFightChallengeTarget(challengeId)
   {
      this.aks.send("Gdi" + challengeId,false);
   }
   function onCreate(bSuccess, sExtraData)
   {
      if(!bSuccess)
      {
         ank.utils.Logger.err("[onCreate] Impossible de créer la partie");
         return undefined;
      }
      var _loc4_ = sExtraData.split("|");
      var _loc5_ = Number(_loc4_[0]);
      if(_loc5_ != 1)
      {
         ank.utils.Logger.err("[onCreate] Type incorrect");
         return undefined;
      }
      this.api.datacenter.Game = new dofus.datacenter.Game();
      this.api.datacenter.Game.state = _loc5_;
      this.api.datacenter.Player.data.initAP(false);
      this.api.datacenter.Player.data.initMP(false);
      this.api.datacenter.Player.SpellsManager.clear();
      this.api.datacenter.Player.data.CharacteristicsManager.initialize();
      this.api.datacenter.Player.data.EffectsManager.initialize();
      this.api.datacenter.Player.clearSummon();
      this.api.gfx.cleanMap(1);
      this.onCreateSolo();
   }
   function onJoin(sExtraData)
   {
      this.api.ui.getUIComponent("Zoom").callClose();
      this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1] != "0"?true:false;
      var _loc6_ = _loc3_[2] != "0"?true:false;
      var _loc7_ = _loc3_[3] != "0"?true:false;
      var _loc8_ = Number(_loc3_[4]);
      var _loc9_ = Number(_loc3_[5]);
      this.api.datacenter.Game = new dofus.datacenter.Game();
      this.api.datacenter.Game.state = _loc4_;
      this.api.datacenter.Game.fightType = _loc9_;
      this.api.datacenter.Game.isSpectator = _loc7_;
      if(!_loc7_)
      {
         this.api.datacenter.Player.data.initAP(false);
         this.api.datacenter.Player.data.initMP(false);
         this.api.datacenter.Player.SpellsManager.clear();
      }
      this.api.ui.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
      this.api.gfx.cleanMap(1);
      if(this.api.datacenter.Game.isTacticMode)
      {
         this.api.datacenter.Game.isTacticMode = true;
      }
      if(_loc6_)
      {
         this.api.ui.loadUIComponent("ChallengeMenu","ChallengeMenu",{labelReady:this.api.lang.getText("READY"),labelCancel:this.api.lang.getText("CANCEL_SMALL"),cancelButton:_loc5_,ready:false},{bStayIfPresent:true});
      }
      if(!_global.isNaN(_loc8_))
      {
         this.api.ui.getUIComponent("Banner").startTimer(_loc8_ / 1000);
      }
      this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
      this.api.ui.unloadLastUIAutoHideComponent();
      this.api.ui.unloadUIComponent("Fights");
   }
   function onPositionStart(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1];
      var _loc6_ = Number(_loc3_[2]);
      this.api.datacenter.Basics.aks_current_team = _loc6_;
      this.api.datacenter.Basics.aks_team1_starts = new Array();
      this.api.datacenter.Basics.aks_team2_starts = new Array();
      this.api.kernel.StreamingDisplayManager.onFightStart();
      this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
      this.api.datacenter.Game.setInteractionType("place");
      if(_loc6_ == undefined)
      {
         ank.utils.Logger.err("[onPositionStart] Impossible de trouver l\'équipe du joueur local !");
      }
      var _loc7_ = 0;
      while(_loc7_ < _loc4_.length)
      {
         var _loc8_ = ank.utils.Compressor.decode64(_loc4_.charAt(_loc7_)) << 6;
         _loc8_ = _loc8_ + ank.utils.Compressor.decode64(_loc4_.charAt(_loc7_ + 1));
         this.api.datacenter.Basics.aks_team1_starts.push(_loc8_);
         if(_loc6_ == 0)
         {
            this.api.gfx.setInteractionOnCell(_loc8_,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
         }
         this.api.gfx.select(_loc8_,dofus.Constants.TEAMS_COLOR[0],"startPosition");
         _loc7_ = _loc7_ + 2;
      }
      var _loc9_ = 0;
      while(_loc9_ < _loc5_.length)
      {
         var _loc10_ = ank.utils.Compressor.decode64(_loc5_.charAt(_loc9_)) << 6;
         _loc10_ = _loc10_ + ank.utils.Compressor.decode64(_loc5_.charAt(_loc9_ + 1));
         this.api.datacenter.Basics.aks_team2_starts.push(_loc10_);
         if(_loc6_ == 1)
         {
            this.api.gfx.setInteractionOnCell(_loc10_,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
         }
         this.api.gfx.select(_loc10_,dofus.Constants.TEAMS_COLOR[1],"startPosition");
         _loc9_ = _loc9_ + 2;
      }
      if(this.api.ui.getUIComponent("FightOptionButtons") == undefined)
      {
         this.api.ui.loadUIComponent("FightOptionButtons","FightOptionButtons");
      }
      this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_PLACEMENT);
   }
   function onPlayersCoordinates(sExtraData)
   {
      if(sExtraData != "e")
      {
         var _loc3_ = sExtraData.split("|");
         var _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            var _loc5_ = _loc3_[_loc4_].split(";");
            var _loc6_ = _loc5_[0];
            var _loc7_ = Number(_loc5_[1]);
            this.api.gfx.setSpritePosition(_loc6_,_loc7_);
            _loc4_ = _loc4_ + 1;
         }
      }
      else
      {
         this.api.sounds.events.onError();
      }
   }
   function onReady(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "1";
      var _loc4_ = sExtraData.substr(1);
      if(_loc3_)
      {
         this.api.gfx.addSpriteExtraClip(_loc4_,dofus.Constants.READY_FILE);
      }
      else
      {
         this.api.gfx.removeSpriteExtraClip(_loc4_);
      }
   }
   function onStartToPlay()
   {
      this.api.ui.getUIComponent("Banner").stopTimer();
      this.aks.GameActions.onActionsFinish(this.api.datacenter.Player.ID);
      this.api.sounds.events.onGameStart(this.api.datacenter.Map.musics);
      this.api.kernel.StreamingDisplayManager.onFightStartEnd();
      var _loc2_ = this.api.ui.getUIComponent("Banner");
      _loc2_.showGiveUpButton(true);
      if(!this.api.datacenter.Game.isSpectator)
      {
         var _loc3_ = this.api.datacenter.Player.data;
         _loc3_.initAP();
         _loc3_.initMP();
         _loc3_.initLP();
         _loc2_.showPoints(true);
         _loc2_.showNextTurnButton(true);
         this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("GAME_LAUNCH"),background:true,timer:2000},{bForceLoad:true});
         this.api.ui.getUIComponent("FightOptionButtons").onGameRunning();
      }
      else
      {
         this.api.ui.loadUIComponent("FightOptionButtons","FightOptionButtons");
      }
      this.api.ui.loadUIComponent("Timeline","Timeline");
      this.api.ui.unloadUIComponent("ChallengeMenu");
      this.api.gfx.unSelect(true);
      this.api.gfx.drawGrid();
      this.api.datacenter.Game.setInteractionType("move");
      this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
      this.api.kernel.GameManager.signalFightActivity();
      this.api.datacenter.Game.isRunning = true;
      var _loc4_ = this.api.datacenter.Sprites.getItems();
      for(var k in _loc4_)
      {
         this.api.gfx.addSpriteExtraClip(k,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[_loc4_[k].Team]);
      }
      if(this.api.datacenter.Game.isTacticMode)
      {
         this.api.datacenter.Game.isTacticMode = true;
      }
   }
   function onTurnStart(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = Number(_loc3_[1]) / 1000;
      var _loc6_ = this.api.datacenter.Sprites.getItemAt(_loc4_);
      _loc6_.GameActionsManager.clear();
      this.api.gfx.unSelect(true);
      this.api.datacenter.Game.currentPlayerID = _loc4_;
      this.api.kernel.GameManager.cleanPlayer(this.api.datacenter.Game.lastPlayerID);
      this.api.ui.getUIComponent("Timeline").nextTurn(_loc4_);
      if(this.api.datacenter.Player.isCurrentPlayer)
      {
         this.api.electron.makeNotification(this.api.lang.getText("PLAYER_TURN",[this.api.datacenter.Player.Name]));
         if(this.api.kernel.OptionsManager.getOption("StartTurnSound"))
         {
            this.api.sounds.events.onTurnStart();
         }
         if(this.api.kernel.GameManager.autoSkip && this.api.datacenter.Game.isFight)
         {
            this.api.network.Game.turnEnd();
         }
         this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
         this.api.datacenter.Player.SpellsManager.nextTurn();
         this.api.ui.getUIComponent("Banner").startTimer(_loc5_);
         this.api.kernel.GameManager.startInactivityDetector();
         dofus.DofusCore.getInstance().forceMouseOver();
         this.api.gfx.mapHandler.resetEmptyCells();
      }
      else
      {
         this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
         this.api.ui.getUIComponent("Timeline").startChrono(_loc5_);
      }
      if(this.api.kernel.OptionsManager.getOption("StringCourse"))
      {
         var _loc7_ = new Array();
         _loc7_[1] = _loc6_.color1;
         _loc7_[2] = _loc6_.color2;
         _loc7_[3] = _loc6_.color3;
         this.api.ui.loadUIComponent("StringCourse","StringCourse",{gfx:_loc6_.artworkFile,name:_loc6_.name,level:this.api.lang.getText("LEVEL_SMALL") + " " + _loc6_.Level,colors:_loc7_},{bForceLoad:true});
      }
      this.api.kernel.GameManager.cleanUpGameArea(true);
      ank.utils.Timer.setTimer(this.api.network.Ping,"GameDecoDetect",this.api.network,this.api.network.quickPing,_loc5_ * 1000);
      this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_START);
   }
   function onTurnFinish(sExtraData)
   {
      var _loc3_ = sExtraData;
      var _loc4_ = this.api.datacenter.Sprites.getItemAt(_loc3_);
      if(this.api.datacenter.Player.isCurrentPlayer)
      {
         this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
         this.api.kernel.GameManager.stopInactivityDetector();
         this.api.kernel.GameManager.onTurnEnd();
      }
      this.api.datacenter.Game.lastPlayerID = this.api.datacenter.Game.currentPlayerID;
      this.api.datacenter.Game.currentPlayerID = undefined;
      this.api.ui.getUIComponent("Banner").stopTimer();
      this.api.ui.getUIComponent("Timeline").stopChrono();
      this.api.kernel.GameManager.cleanUpGameArea(true);
   }
   function onTurnlist(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      this.api.datacenter.Game.turnSequence = _loc3_;
      this.api.ui.getUIComponent("Timeline").update();
   }
   function onTurnMiddle(sExtraData)
   {
      if(!this.api.datacenter.Game.isRunning)
      {
         ank.utils.Logger.err("[innerOnTurnMiddle] on est pas en combat");
         return undefined;
      }
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = new Object();
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         var _loc6_ = _loc3_[_loc5_].split(";");
         if(_loc6_.length != 0)
         {
            var _loc7_ = _loc6_[0];
            var _loc8_ = _loc6_[1] != "1"?false:true;
            var _loc9_ = Number(_loc6_[2]);
            var _loc10_ = Number(_loc6_[3]);
            var _loc11_ = Number(_loc6_[4]);
            var _loc12_ = Number(_loc6_[5]);
            var _loc13_ = Number(_loc6_[6]);
            var _loc14_ = Number(_loc6_[7]);
            _loc4_[_loc7_] = true;
            var _loc15_ = this.api.datacenter.Sprites.getItemAt(_loc7_);
            if(_loc15_ != undefined)
            {
               _loc15_.sequencer.clearAllNextActions();
               if(_loc8_)
               {
                  _loc15_.mc.clear();
                  this.api.gfx.removeSpriteOverHeadLayer(_loc7_,"text");
               }
               else
               {
                  _loc15_.LP = _loc9_;
                  _loc15_.LPmax = _loc14_;
                  _loc15_.AP = _loc10_;
                  _loc15_.MP = _loc11_;
                  if(!_global.isNaN(_loc12_) && !_loc15_.hasCarriedParent())
                  {
                     this.api.gfx.setSpritePosition(_loc7_,_loc12_);
                  }
                  if(_loc15_.hasCarriedChild())
                  {
                     _loc15_.carriedChild.updateCarriedPosition();
                  }
               }
            }
            else
            {
               ank.utils.Logger.err("[onTurnMiddle] le sprite n\'existe pas");
            }
         }
         _loc5_ = _loc5_ + 1;
      }
      var _loc16_ = this.api.datacenter.Sprites.getItems();
      for(var k in _loc16_)
      {
         if(!_loc4_[k])
         {
            _loc16_[k].mc.clear();
            this.api.datacenter.Sprites.removeItemAt(k);
         }
      }
      this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
   }
   function onTurnReady(sExtraData)
   {
      var _loc3_ = sExtraData;
      var _loc4_ = this.api.datacenter.Sprites.getItemAt(_loc3_);
      if(_loc4_ != undefined)
      {
         var _loc5_ = _loc4_.sequencer;
         _loc5_.addAction(false,this,this.turnOk);
         _loc5_.execute();
      }
      else
      {
         ank.utils.Logger.err("[onTurnReday] le sprite " + _loc3_ + " n\'existe pas");
         this.turnOk2();
      }
   }
   function onMapData(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1];
      var _loc6_ = _loc3_[2];
      if(Number(_loc4_) == this.api.datacenter.Map.id)
      {
         if(!this.api.datacenter.Map.bOutdoor)
         {
            this.api.kernel.NightManager.noEffects();
         }
         this.api.gfx.onMapLoaded();
         return undefined;
      }
      this.api.gfx.showContainer(false);
      this.nLastMapIdReceived = _global.parseInt(_loc4_,10);
      this.api.kernel.MapsServersManager.loadMap(_loc4_,_loc5_,_loc6_);
   }
   function onMapLoaded()
   {
      this.api.gfx.showContainer(true);
      if(dofus.Constants.SAVING_THE_WORLD)
      {
         dofus.SaveTheWorld.getInstance().nextAction();
      }
   }
   function onMovement(sExtraData, bIsSummoned)
   {
      var _loc4_ = sExtraData.split("|");
      var _loc5_ = 0;
      for(; _loc5_ < _loc4_.length; _loc5_ = _loc5_ + 1)
      {
         var _loc6_ = _loc4_[_loc5_];
         if(_loc6_.length != 0)
         {
            var _loc7_ = false;
            var _loc8_ = false;
            var _loc9_ = _loc6_.charAt(0);
            if(_loc9_ == "+")
            {
               _loc8_ = true;
            }
            else if(_loc9_ == "~")
            {
               _loc8_ = true;
               _loc7_ = true;
            }
            else if(_loc9_ != "-")
            {
               continue;
            }
            if(_loc8_)
            {
               var _loc10_ = _loc6_.substr(1).split(";");
               var _loc11_ = _loc10_[0];
               var _loc12_ = _loc10_[1];
               var _loc13_ = Number(_loc10_[2]);
               var _loc14_ = _loc10_[3];
               var _loc15_ = _loc10_[4];
               var _loc16_ = _loc10_[5];
               var _loc17_ = _loc10_[6];
               var _loc18_ = false;
               var _loc19_ = true;
               if(_loc17_.charAt(_loc17_.length - 1) == "*")
               {
                  _loc17_ = _loc17_.substr(0,_loc17_.length - 1);
                  _loc18_ = true;
               }
               if(_loc17_.charAt(0) == "*")
               {
                  _loc19_ = false;
                  _loc17_ = _loc17_.substr(1);
               }
               var _loc20_ = _loc17_.split("^");
               var _loc21_ = _loc20_.length != 2?_loc17_:_loc20_[0];
               var _loc22_ = _loc16_.split(",");
               var _loc23_ = _loc22_[0];
               var _loc24_ = _loc22_[1];
               var _loc25_ = undefined;
               if(_loc24_.length)
               {
                  var _loc26_ = _loc24_.split("*");
                  _loc25_ = new dofus.datacenter.Title(_global.parseInt(_loc26_[0]),_loc26_[1]);
               }
               var _loc27_ = 100;
               var _loc28_ = 100;
               if(_loc20_.length == 2)
               {
                  var _loc29_ = _loc20_[1];
                  if(_global.isNaN(Number(_loc29_)))
                  {
                     var _loc30_ = _loc29_.split("x");
                     _loc27_ = _loc30_.length != 2?100:Number(_loc30_[0]);
                     _loc28_ = _loc30_.length != 2?100:Number(_loc30_[1]);
                  }
                  else
                  {
                     _loc27_ = _loc28_ = Number(_loc29_);
                  }
               }
               if(_loc7_)
               {
                  var _loc31_ = this.api.datacenter.Sprites.getItemAt(_loc14_);
                  this.onSpriteMovement(false,_loc31_);
               }
               switch(_loc23_)
               {
                  case "-1":
                  case "-2":
                     var _loc33_ = new Object();
                     _loc33_.spriteType = _loc23_;
                     _loc33_.gfxID = _loc21_;
                     _loc33_.scaleX = _loc27_;
                     _loc33_.scaleY = _loc28_;
                     _loc33_.noFlip = _loc18_;
                     _loc33_.cell = _loc11_;
                     _loc33_.dir = _loc12_;
                     _loc33_.powerLevel = _loc10_[7];
                     _loc33_.color1 = _loc10_[8];
                     _loc33_.color2 = _loc10_[9];
                     _loc33_.color3 = _loc10_[10];
                     _loc33_.accessories = _loc10_[11];
                     if(this.api.datacenter.Game.isFight)
                     {
                        _loc33_.LP = _loc10_[12];
                        _loc33_.AP = _loc10_[13];
                        _loc33_.MP = _loc10_[14];
                        if(_loc10_.length > 18)
                        {
                           _loc33_.resistances = new Array(Number(_loc10_[15]),Number(_loc10_[16]),Number(_loc10_[17]),Number(_loc10_[18]),Number(_loc10_[19]),Number(_loc10_[20]),Number(_loc10_[21]));
                           _loc33_.team = _loc10_[22];
                        }
                        else
                        {
                           _loc33_.team = _loc10_[15];
                        }
                        _loc33_.summoned = bIsSummoned;
                     }
                     if(_loc23_ == -1)
                     {
                        _loc31_ = this.api.kernel.CharactersManager.createCreature(_loc14_,_loc15_,_loc33_);
                     }
                     else
                     {
                        _loc31_ = this.api.kernel.CharactersManager.createMonster(_loc14_,_loc15_,_loc33_);
                     }
                     break;
                  case "-3":
                     var _loc34_ = new Object();
                     _loc34_.spriteType = _loc23_;
                     _loc34_.level = _loc10_[7];
                     _loc34_.scaleX = _loc27_;
                     _loc34_.scaleY = _loc28_;
                     _loc34_.noFlip = _loc18_;
                     _loc34_.cell = Number(_loc11_);
                     _loc34_.dir = _loc12_;
                     var _loc35_ = _loc10_[8].split(",");
                     _loc34_.color1 = _loc35_[0];
                     _loc34_.color2 = _loc35_[1];
                     _loc34_.color3 = _loc35_[2];
                     _loc34_.accessories = _loc10_[9];
                     _loc34_.bonusValue = _loc13_;
                     var _loc36_ = this.sliptGfxData(_loc17_);
                     var _loc37_ = _loc36_.gfx;
                     this.splitGfxForScale(_loc37_[0],_loc34_);
                     _loc31_ = this.api.kernel.CharactersManager.createMonsterGroup(_loc14_,_loc15_,_loc34_);
                     if(this.api.kernel.OptionsManager.getOption("ViewAllMonsterInGroup") == true)
                     {
                        var _loc38_ = _loc14_;
                        var _loc39_ = 1;
                        while(_loc39_ < _loc37_.length)
                        {
                           if(_loc37_[_loc5_] != "")
                           {
                              this.splitGfxForScale(_loc37_[_loc39_],_loc34_);
                              _loc35_ = _loc10_[8 + 2 * _loc39_].split(",");
                              _loc34_.color1 = _loc35_[0];
                              _loc34_.color2 = _loc35_[1];
                              _loc34_.color3 = _loc35_[2];
                              _loc34_.dir = random(4) * 2 + 1;
                              _loc34_.accessories = _loc10_[9 + 2 * _loc39_];
                              var _loc40_ = _loc14_ + "_" + _loc39_;
                              var _loc41_ = this.api.kernel.CharactersManager.createMonsterGroup(_loc40_,undefined,_loc34_);
                              var _loc42_ = _loc38_;
                              if(random(3) != 0 && _loc39_ != 1)
                              {
                                 _loc42_ = _loc14_ + "_" + (random(_loc39_ - 1) + 1);
                              }
                              var _loc43_ = random(8);
                              this.api.gfx.addLinkedSprite(_loc40_,_loc42_,_loc43_,_loc41_);
                              if(!_global.isNaN(_loc41_.scaleX))
                              {
                                 this.api.gfx.setSpriteScale(_loc41_.id,_loc41_.scaleX,_loc41_.scaleY);
                              }
                              switch(_loc36_.shape)
                              {
                                 case "circle":
                                    _loc43_ = _loc39_;
                                    break;
                                 case "line":
                                    _loc42_ = _loc40_;
                                    _loc43_ = 2;
                              }
                           }
                           _loc39_ = _loc39_ + 1;
                        }
                     }
                     break;
                  case "-4":
                     var _loc44_ = new Object();
                     _loc44_.spriteType = _loc23_;
                     _loc44_.gfxID = _loc21_;
                     _loc44_.scaleX = _loc27_;
                     _loc44_.scaleY = _loc28_;
                     _loc44_.cell = _loc11_;
                     _loc44_.dir = _loc12_;
                     _loc44_.sex = _loc10_[7];
                     _loc44_.color1 = _loc10_[8];
                     _loc44_.color2 = _loc10_[9];
                     _loc44_.color3 = _loc10_[10];
                     _loc44_.accessories = _loc10_[11];
                     _loc44_.extraClipID = !(_loc10_[12] != undefined && !_global.isNaN(Number(_loc10_[12])))?-1:Number(_loc10_[12]);
                     _loc44_.customArtwork = Number(_loc10_[13]);
                     _loc31_ = this.api.kernel.CharactersManager.createNonPlayableCharacter(_loc14_,Number(_loc15_),_loc44_);
                     break;
                  case "-5":
                     var _loc45_ = new Object();
                     _loc45_.spriteType = _loc23_;
                     _loc45_.gfxID = _loc21_;
                     _loc45_.scaleX = _loc27_;
                     _loc45_.scaleY = _loc28_;
                     _loc45_.cell = _loc11_;
                     _loc45_.dir = _loc12_;
                     _loc45_.color1 = _loc10_[7];
                     _loc45_.color2 = _loc10_[8];
                     _loc45_.color3 = _loc10_[9];
                     _loc45_.accessories = _loc10_[10];
                     _loc45_.guildName = _loc10_[11];
                     _loc45_.emblem = _loc10_[12];
                     _loc45_.offlineType = _loc10_[13];
                     _loc31_ = this.api.kernel.CharactersManager.createOfflineCharacter(_loc14_,_loc15_,_loc45_);
                     break;
                  case "-6":
                     var _loc46_ = new Object();
                     _loc46_.spriteType = _loc23_;
                     _loc46_.gfxID = _loc21_;
                     _loc46_.scaleX = _loc27_;
                     _loc46_.scaleY = _loc28_;
                     _loc46_.cell = _loc11_;
                     _loc46_.dir = _loc12_;
                     _loc46_.level = _loc10_[7];
                     if(this.api.datacenter.Game.isFight)
                     {
                        _loc46_.LP = _loc10_[8];
                        _loc46_.AP = _loc10_[9];
                        _loc46_.MP = _loc10_[10];
                        _loc46_.resistances = new Array(Number(_loc10_[11]),Number(_loc10_[12]),Number(_loc10_[13]),Number(_loc10_[14]),Number(_loc10_[15]),Number(_loc10_[16]),Number(_loc10_[17]));
                        _loc46_.team = _loc10_[18];
                     }
                     else
                     {
                        _loc46_.guildName = _loc10_[8];
                        _loc46_.emblem = _loc10_[9];
                     }
                     _loc31_ = this.api.kernel.CharactersManager.createTaxCollector(_loc14_,_loc15_,_loc46_);
                     break;
                  case "-7":
                  case "-8":
                     var _loc47_ = new Object();
                     _loc47_.spriteType = _loc23_;
                     _loc47_.gfxID = _loc21_;
                     _loc47_.scaleX = _loc27_;
                     _loc47_.scaleY = _loc28_;
                     _loc47_.cell = _loc11_;
                     _loc47_.dir = _loc12_;
                     _loc47_.sex = _loc10_[7];
                     _loc47_.powerLevel = _loc10_[8];
                     _loc47_.accessories = _loc10_[9];
                     if(this.api.datacenter.Game.isFight)
                     {
                        _loc47_.LP = _loc10_[10];
                        _loc47_.AP = _loc10_[11];
                        _loc47_.MP = _loc10_[12];
                        _loc47_.team = _loc10_[20];
                     }
                     else
                     {
                        _loc47_.emote = _loc10_[10];
                        _loc47_.emoteTimer = _loc10_[11];
                        _loc47_.restrictions = Number(_loc10_[12]);
                     }
                     if(_loc23_ == "-8")
                     {
                        _loc47_.showIsPlayer = true;
                        var _loc48_ = _loc15_.split("~");
                        _loc47_.monsterID = _loc48_[0];
                        _loc47_.playerName = _loc48_[1];
                     }
                     else
                     {
                        _loc47_.showIsPlayer = false;
                        _loc47_.monsterID = _loc15_;
                     }
                     _loc31_ = this.api.kernel.CharactersManager.createMutant(_loc14_,_loc47_);
                     break;
                  case "-9":
                     var _loc49_ = new Object();
                     _loc49_.spriteType = _loc23_;
                     _loc49_.gfxID = _loc21_;
                     _loc49_.scaleX = _loc27_;
                     _loc49_.scaleY = _loc28_;
                     _loc49_.cell = _loc11_;
                     _loc49_.dir = _loc12_;
                     _loc49_.ownerName = _loc10_[7];
                     _loc49_.level = _loc10_[8];
                     _loc49_.modelID = _loc10_[9];
                     _loc31_ = this.api.kernel.CharactersManager.createParkMount(_loc14_,_loc15_ == ""?this.api.lang.getText("NO_NAME"):_loc15_,_loc49_);
                     break;
                  case "-10":
                     var _loc50_ = new Object();
                     _loc50_.spriteType = _loc23_;
                     _loc50_.gfxID = _loc21_;
                     _loc50_.scaleX = _loc27_;
                     _loc50_.scaleY = _loc28_;
                     _loc50_.cell = _loc11_;
                     _loc50_.dir = _loc12_;
                     _loc50_.level = _loc10_[7];
                     _loc50_.alignment = new dofus.datacenter.Alignment(Number(_loc10_[9]),Number(_loc10_[8]));
                     _loc31_ = this.api.kernel.CharactersManager.createPrism(_loc14_,_loc15_,_loc50_);
                     break;
                  default:
                     var _loc52_ = new Object();
                     _loc52_.spriteType = _loc23_;
                     _loc52_.cell = _loc11_;
                     _loc52_.scaleX = _loc27_;
                     _loc52_.scaleY = _loc28_;
                     _loc52_.dir = _loc12_;
                     _loc52_.sex = _loc10_[7];
                     if(this.api.datacenter.Game.isFight)
                     {
                        _loc52_.level = _loc10_[8];
                        var _loc51_ = _loc10_[9];
                        _loc52_.color1 = _loc10_[10];
                        _loc52_.color2 = _loc10_[11];
                        _loc52_.color3 = _loc10_[12];
                        _loc52_.accessories = _loc10_[13];
                        _loc52_.LP = _loc10_[14];
                        _loc52_.AP = _loc10_[15];
                        _loc52_.MP = _loc10_[16];
                        _loc52_.resistances = new Array(Number(_loc10_[17]),Number(_loc10_[18]),Number(_loc10_[19]),Number(_loc10_[20]),Number(_loc10_[21]),Number(_loc10_[22]),Number(_loc10_[23]));
                        _loc52_.team = _loc10_[24];
                        if(_loc10_[25].indexOf(",") != -1)
                        {
                           var _loc53_ = _loc10_[25].split(",");
                           var _loc54_ = Number(_loc53_[0]);
                           var _loc55_ = _global.parseInt(_loc53_[1],16);
                           var _loc56_ = _global.parseInt(_loc53_[2],16);
                           var _loc57_ = _global.parseInt(_loc53_[3],16);
                           if(_loc55_ == -1 || _global.isNaN(_loc55_))
                           {
                              _loc55_ = this.api.datacenter.Player.color1;
                           }
                           if(_loc56_ == -1 || _global.isNaN(_loc56_))
                           {
                              _loc56_ = this.api.datacenter.Player.color2;
                           }
                           if(_loc57_ == -1 || _global.isNaN(_loc57_))
                           {
                              _loc57_ = this.api.datacenter.Player.color3;
                           }
                           if(!_global.isNaN(_loc54_))
                           {
                              var _loc58_ = new dofus.datacenter.Mount(_loc54_,Number(_loc21_));
                              _loc58_.customColor1 = _loc55_;
                              _loc58_.customColor2 = _loc56_;
                              _loc58_.customColor3 = _loc57_;
                              _loc52_.mount = _loc58_;
                           }
                        }
                        else
                        {
                           var _loc59_ = Number(_loc10_[25]);
                           if(!_global.isNaN(_loc59_))
                           {
                              _loc52_.mount = new dofus.datacenter.Mount(_loc59_,Number(_loc21_));
                           }
                        }
                     }
                     else
                     {
                        _loc51_ = _loc10_[8];
                        _loc52_.color1 = _loc10_[9];
                        _loc52_.color2 = _loc10_[10];
                        _loc52_.color3 = _loc10_[11];
                        _loc52_.accessories = _loc10_[12];
                        _loc52_.aura = _loc10_[13];
                        _loc52_.emote = _loc10_[14];
                        _loc52_.emoteTimer = _loc10_[15];
                        _loc52_.guildName = _loc10_[16];
                        _loc52_.emblem = _loc10_[17];
                        _loc52_.restrictions = _loc10_[18];
                        if(_loc10_[19].indexOf(",") != -1)
                        {
                           var _loc60_ = _loc10_[19].split(",");
                           var _loc61_ = Number(_loc60_[0]);
                           var _loc62_ = _global.parseInt(_loc60_[1],16);
                           var _loc63_ = _global.parseInt(_loc60_[2],16);
                           var _loc64_ = _global.parseInt(_loc60_[3],16);
                           if(_loc62_ == -1 || _global.isNaN(_loc62_))
                           {
                              _loc62_ = this.api.datacenter.Player.color1;
                           }
                           if(_loc63_ == -1 || _global.isNaN(_loc63_))
                           {
                              _loc63_ = this.api.datacenter.Player.color2;
                           }
                           if(_loc64_ == -1 || _global.isNaN(_loc64_))
                           {
                              _loc64_ = this.api.datacenter.Player.color3;
                           }
                           if(!_global.isNaN(_loc61_))
                           {
                              var _loc65_ = new dofus.datacenter.Mount(_loc61_,Number(_loc21_));
                              _loc65_.customColor1 = _loc62_;
                              _loc65_.customColor2 = _loc63_;
                              _loc65_.customColor3 = _loc64_;
                              _loc52_.mount = _loc65_;
                           }
                        }
                        else
                        {
                           var _loc66_ = Number(_loc10_[19]);
                           if(!_global.isNaN(_loc66_))
                           {
                              _loc52_.mount = new dofus.datacenter.Mount(_loc66_,Number(_loc21_));
                           }
                        }
                     }
                     if(_loc7_)
                     {
                        var _loc32_ = [_loc14_,this.createTransitionEffect(),_loc11_,10];
                     }
                     var _loc67_ = _loc51_.split(",");
                     _loc52_.alignment = new dofus.datacenter.Alignment(Number(_loc67_[0]),Number(_loc67_[1]));
                     _loc52_.rank = new dofus.datacenter.Rank(Number(_loc67_[2]));
                     _loc52_.alignment.fallenAngelDemon = _loc67_[4] == 1;
                     if(_loc67_.length > 3 && _loc14_ != this.api.datacenter.Player.ID)
                     {
                        if(this.api.lang.getAlignmentCanViewPvpGain(this.api.datacenter.Player.alignment.index,Number(_loc52_.alignment.index)))
                        {
                           var _loc68_ = Number(_loc67_[3]) - _global.parseInt(_loc14_);
                           var _loc69_ = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT");
                           var _loc70_ = this.api.lang.getConfigText("PVP_VIEW_BONUS_MINOR_LIMIT_PRC");
                           var _loc71_ = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT");
                           var _loc72_ = this.api.lang.getConfigText("PVP_VIEW_BONUS_MAJOR_LIMIT_PRC");
                           var _loc73_ = 0;
                           if(this.api.datacenter.Player.Level * (1 - _loc70_ / 100) > _loc68_)
                           {
                              _loc73_ = -1;
                           }
                           if(this.api.datacenter.Player.Level - _loc68_ > _loc69_)
                           {
                              _loc73_ = -1;
                           }
                           if(this.api.datacenter.Player.Level * (1 + _loc72_ / 100) < _loc68_)
                           {
                              _loc73_ = 1;
                           }
                           if(this.api.datacenter.Player.Level - _loc68_ < _loc71_)
                           {
                              _loc73_ = 1;
                           }
                           _loc52_.pvpGain = _loc73_;
                        }
                     }
                     if(!this.api.datacenter.Game.isFight && (_global.parseInt(_loc14_,10) != this.api.datacenter.Player.ID && ((this.api.datacenter.Player.alignment.index == 1 || this.api.datacenter.Player.alignment.index == 2) && ((_loc52_.alignment.index == 1 || _loc52_.alignment.index == 2) && (_loc52_.alignment.index != this.api.datacenter.Player.alignment.index && (_loc52_.rank.value && this.api.datacenter.Map.bCanAttack))))))
                     {
                        if(this.api.datacenter.Player.rank.value > _loc52_.rank.value)
                        {
                           this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_WEAK);
                        }
                        if(this.api.datacenter.Player.rank.value < _loc52_.rank.value)
                        {
                           this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_NEW_ENEMY_STRONG);
                        }
                     }
                     var _loc74_ = this.sliptGfxData(_loc17_);
                     var _loc75_ = _loc74_.gfx;
                     this.splitGfxForScale(_loc75_[0],_loc52_);
                     _loc52_.title = _loc25_;
                     _loc31_ = this.api.kernel.CharactersManager.createCharacter(_loc14_,_loc15_,_loc52_);
                     (dofus.datacenter.Character)_loc31_.isClear = false;
                     _loc31_.allowGhostMode = _loc19_;
                     var _loc76_ = _loc14_;
                     var _loc77_ = _loc74_.shape != "circle"?2:0;
                     var _loc78_ = 1;
                     while(_loc78_ < _loc75_.length)
                     {
                        if(_loc75_[_loc78_] != "")
                        {
                           var _loc79_ = _loc14_ + "_" + _loc78_;
                           var _loc80_ = new Object();
                           this.splitGfxForScale(_loc75_[_loc78_],_loc80_);
                           var _loc81_ = new ank.battlefield.datacenter.Sprite(_loc79_,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + _loc80_.gfxID + ".swf");
                           _loc81_.allDirections = false;
                           this.api.gfx.addLinkedSprite(_loc79_,_loc76_,_loc77_,_loc81_);
                           if(!_global.isNaN(_loc80_.scaleX))
                           {
                              this.api.gfx.setSpriteScale(_loc81_.id,_loc80_.scaleX,_loc80_.scaleY);
                           }
                           switch(_loc74_.shape)
                           {
                              case "circle":
                                 _loc77_ = _loc78_;
                                 break;
                              case "line":
                                 _loc76_ = _loc79_;
                                 _loc77_ = 2;
                           }
                        }
                        _loc78_ = _loc78_ + 1;
                     }
               }
               this.onSpriteMovement(_loc8_,_loc31_,_loc32_);
            }
            else
            {
               var _loc82_ = _loc6_.substr(1);
               var _loc83_ = this.api.datacenter.Sprites.getItemAt(_loc82_);
               if(!this.api.datacenter.Game.isRunning && this.api.datacenter.Game.isLoggingMapDisconnections)
               {
                  var _loc84_ = _loc83_.id;
                  var _loc85_ = _loc83_.name;
                  var _loc86_ = this._aGameSpriteLeftHistory[_loc84_];
                  if(!_global.isNaN(_loc86_) && getTimer() - _loc86_ < 300)
                  {
                     this.api.kernel.showMessage(undefined,this.api.kernel.DebugManager.getTimestamp() + " (Map) " + this.api.kernel.ChatManager.getLinkName(_loc85_) + " s\'est déconnecté","ADMIN_CHAT");
                  }
                  this._aGameSpriteLeftHistory[_loc84_] = getTimer();
               }
               this.onSpriteMovement(_loc8_,_loc83_);
            }
         }
      }
   }
   function onCellData(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_].split(";");
         var _loc6_ = Number(_loc5_[0]);
         var _loc7_ = _loc5_[1].substring(0,10);
         var _loc8_ = _loc5_[1].substr(10);
         var _loc9_ = _loc5_[2] != "0"?1:0;
         this.api.gfx.updateCell(_loc6_,_loc7_,_loc8_,_loc9_);
         _loc4_ = _loc4_ + 1;
      }
   }
   function onZoneData(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_];
         var _loc6_ = _loc5_.charAt(0) != "+"?false:true;
         var _loc7_ = _loc5_.substr(1).split(";");
         var _loc8_ = Number(_loc7_[0]);
         var _loc9_ = Number(_loc7_[1]);
         var _loc10_ = _loc7_[2];
         if(_loc6_)
         {
            this.api.gfx.drawZone(_loc8_,0,_loc9_,_loc10_,dofus.Constants.ZONE_COLOR[_loc10_]);
         }
         else
         {
            this.api.gfx.clearZone(_loc8_,_loc9_,_loc10_);
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function onCellObject(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = 0;
      while(_loc5_ < _loc4_.length)
      {
         var _loc6_ = _loc4_[_loc5_].split(";");
         var _loc7_ = Number(_loc6_[0]);
         var _loc8_ = _global.parseInt(_loc6_[1]);
         if(_loc3_)
         {
            var _loc9_ = new dofus.datacenter.Item(0,_loc8_);
            var _loc10_ = Number(_loc6_[2]);
            switch(_loc10_)
            {
               case 0:
                  this.api.gfx.updateCellObjectExternalWithExternalClip(_loc7_,_loc9_.iconFile,1,true,true,_loc9_);
                  break;
               case 1:
                  if(this.api.gfx.mapHandler.getCellData(_loc7_).layerObjectExternalData.unicID != _loc8_)
                  {
                     this.api.gfx.updateCellObjectExternalWithExternalClip(_loc7_,_loc9_.iconFile,1,true,false,_loc9_);
                  }
                  else
                  {
                     _loc9_ = this.api.gfx.mapHandler.getCellData(_loc7_).layerObjectExternalData;
                  }
                  _loc9_.durability = Number(_loc6_[3]);
                  _loc9_.durabilityMax = Number(_loc6_[4]);
            }
         }
         else
         {
            this.api.gfx.initializeCell(_loc7_,1);
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function onFrameObject2(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_].split(";");
         var _loc6_ = Number(_loc5_[0]);
         var _loc7_ = _loc5_[1];
         var _loc8_ = _loc5_[2] != undefined;
         var _loc9_ = _loc5_[2] != "1"?false:true;
         if(_loc8_)
         {
            this.api.gfx.setObject2Interactive(_loc6_,_loc9_,2);
         }
         this.api.gfx.setObject2Frame(_loc6_,_loc7_);
         _loc4_ = _loc4_ + 1;
      }
   }
   function onFrameObjectExternal(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_].split(";");
         var _loc6_ = Number(_loc5_[0]);
         var _loc7_ = Number(_loc5_[1]);
         this.api.gfx.setObjectExternalFrame(_loc6_,_loc7_);
         _loc4_ = _loc4_ + 1;
      }
   }
   function onEffect(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1].split(",");
      var _loc6_ = _loc3_[2];
      var _loc7_ = _loc3_[3];
      var _loc8_ = _loc3_[4];
      var _loc9_ = _loc3_[5];
      var _loc10_ = Number(_loc3_[6]);
      var _loc11_ = _loc3_[7];
      var _loc12_ = 0;
      while(_loc12_ < _loc5_.length)
      {
         var _loc13_ = _loc5_[_loc12_];
         if(_loc13_ == this.api.datacenter.Game.currentPlayerID)
         {
            _loc10_ = _loc10_ + 1;
         }
         var _loc14_ = new dofus.datacenter.Effect(Number(_loc4_),Number(_loc6_),Number(_loc7_),Number(_loc8_),_loc9_,Number(_loc10_),Number(_loc11_));
         var _loc15_ = this.api.datacenter.Sprites.getItemAt(_loc13_);
         _loc15_.EffectsManager.addEffect(_loc14_);
         _loc12_ = _loc12_ + 1;
      }
   }
   function onClearAllEffect(sExtraData)
   {
      var _loc3_ = this.api.datacenter.Sprites;
      for(var a in _loc3_)
      {
         _loc3_[a].EffectsManager.terminateAllEffects();
      }
   }
   function onChallenge(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = _loc4_.shift().split(";");
      var _loc6_ = Number(_loc5_[0]);
      var _loc7_ = Number(_loc5_[1]);
      var _loc8_ = (Math.cos(_loc6_) + 1) * 8388607;
      if(_loc3_)
      {
         var _loc9_ = new dofus.datacenter.Challenge(_loc6_,_loc7_);
         this.api.datacenter.Challenges.addItemAt(_loc6_,_loc9_);
         var _loc10_ = 0;
         while(_loc10_ < _loc4_.length)
         {
            var _loc11_ = _loc4_[_loc10_].split(";");
            var _loc12_ = _loc11_[0];
            var _loc13_ = Number(_loc11_[1]);
            var _loc14_ = Number(_loc11_[2]);
            var _loc15_ = Number(_loc11_[3]);
            var _loc16_ = dofus.Constants.getTeamFileFromType(_loc14_,_loc15_);
            var _loc17_ = new dofus.datacenter.Team(_loc12_,ank.battlefield.mc.Sprite,_loc16_,_loc13_,_loc8_,_loc14_,_loc15_);
            _loc9_.addTeam(_loc17_);
            this.api.gfx.addSprite(_loc17_.id,_loc17_);
            _loc10_ = _loc10_ + 1;
         }
      }
      else
      {
         var _loc18_ = this.api.datacenter.Challenges.getItemAt(_loc6_).teams;
         for(var k in _loc18_)
         {
            var _loc19_ = _loc18_[k];
            this.api.gfx.removeSprite(_loc19_.id);
         }
         this.api.datacenter.Challenges.removeItemAt(_loc6_);
      }
   }
   function onTeam(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_.shift());
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(_loc4_);
      var _loc6_ = 0;
      while(_loc6_ < _loc3_.length)
      {
         var _loc7_ = _loc3_[_loc6_].split(";");
         var _loc8_ = _loc7_[0].charAt(0) == "+";
         var _loc9_ = _loc7_[0].substr(1);
         var _loc10_ = _loc7_[1];
         var _loc11_ = _loc7_[2];
         var _loc12_ = _loc10_.split(",");
         var _loc13_ = Number(_loc10_);
         if(_loc12_.length > 1)
         {
            _loc10_ = this.api.lang.getFullNameText(_loc12_);
         }
         else if(!_global.isNaN(_loc13_))
         {
            _loc10_ = this.api.lang.getMonstersText(_loc13_).n;
         }
         if(_loc8_)
         {
            var _loc14_ = new Object();
            _loc14_.id = _loc9_;
            _loc14_.name = _loc10_;
            _loc14_.level = _loc11_;
            _loc5_.addPlayer(_loc14_);
         }
         else
         {
            _loc5_.removePlayer(_loc9_);
         }
         _loc6_ = _loc6_ + 1;
      }
   }
   function onFightOption(sExtraData)
   {
      var _loc3_ = sExtraData.substr(2);
      var _loc4_ = this.api.datacenter.Sprites.getItemAt(_loc3_);
      if(_loc4_ != undefined)
      {
         var _loc5_ = sExtraData.charAt(0) == "+";
         var _loc6_ = sExtraData.charAt(1);
         switch(_loc6_)
         {
            case "H":
               _loc4_.options[dofus.datacenter.Team.OPT_NEED_HELP] = _loc5_;
               break;
            case "S":
               _loc4_.options[dofus.datacenter.Team.OPT_BLOCK_SPECTATOR] = _loc5_;
               break;
            case "A":
               _loc4_.options[dofus.datacenter.Team.OPT_BLOCK_JOINER] = _loc5_;
               break;
            case "P":
               _loc4_.options[dofus.datacenter.Team.OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER] = _loc5_;
         }
         this.api.gfx.addSpriteOverHeadItem(_loc3_,"FightOptions",dofus.graphics.battlefield.FightOptionsOverHead,[_loc4_],undefined);
      }
   }
   function onLeave()
   {
      this.api.datacenter.Game.currentPlayerID = undefined;
      this.api.ui.getUIComponent("Banner").stopTimer();
      this.api.ui.getUIComponent("Banner").hideRightPanel();
      this.api.ui.unloadUIComponent("Timeline");
      this.api.ui.unloadUIComponent("StringCourse");
      this.api.ui.unloadUIComponent("PlayerInfos");
      this.api.ui.unloadUIComponent("SpriteInfos");
      this.aks.GameActions.onActionsFinish(String(this.api.datacenter.Player.ID));
      this.api.datacenter.Player.reset();
      var _loc2_ = (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge");
      _loc2_.cleanChallenge();
      this.create();
   }
   function onEnd(sExtraData)
   {
      if(this.api.kernel.MapsServersManager.isBuilding)
      {
         this.addToQueue({object:this,method:this.onEnd,params:[sExtraData]});
         return undefined;
      }
      this._bIsBusy = true;
      var _loc3_ = (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge");
      this.api.kernel.StreamingDisplayManager.onFightEnd();
      var _loc4_ = {winners:[],loosers:[],collectors:[],challenges:_loc3_.challenges.clone()};
      this.api.datacenter.Game.results = _loc4_;
      _loc3_.cleanChallenge();
      var _loc5_ = sExtraData.split("|");
      var _loc6_ = -1;
      if(!_global.isNaN(Number(_loc5_[0])))
      {
         _loc4_.duration = Number(_loc5_[0]);
      }
      else
      {
         var _loc7_ = _loc5_[0].split(";");
         _loc4_.duration = Number(_loc7_[0]);
         _loc6_ = Number(_loc7_[1]);
      }
      this.api.datacenter.Basics.aks_game_end_bonus = _loc6_;
      var _loc8_ = Number(_loc5_[1]);
      var _loc9_ = Number(_loc5_[2]);
      _loc4_.fightType = _loc9_;
      var _loc10_ = new ank.utils.ExtendedArray();
      var _loc11_ = 0;
      this.parsePlayerData(_loc4_,3,_loc8_,_loc5_,_loc9_,_loc11_,_loc10_);
   }
   function parsePlayerData(oResults, nStartIndex, nSenderID, aTmp, nFightType, nKamaDrop, eaFightDrop)
   {
      var _loc9_ = nStartIndex;
      var _loc10_ = aTmp[_loc9_].split(";");
      var _loc11_ = new Object();
      if(Number(_loc10_[0]) != 6)
      {
         _loc11_.id = Number(_loc10_[1]);
         if(_loc11_.id == this.api.datacenter.Player.ID)
         {
            if(Number(_loc10_[0]) == 0)
            {
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_LOST);
            }
            else
            {
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_FIGHT_WON);
            }
         }
         var _loc13_ = this.api.kernel.CharactersManager.getNameFromData(_loc10_[2]);
         _loc11_.name = _loc13_.name;
         _loc11_.type = _loc13_.type;
         _loc11_.level = Number(_loc10_[3]);
         _loc11_.bDead = _loc10_[4] != "1"?false:true;
         switch(nFightType)
         {
            case 0:
               _loc11_.minxp = Number(_loc10_[5]);
               _loc11_.xp = Number(_loc10_[6]);
               _loc11_.maxxp = Number(_loc10_[7]);
               _loc11_.winxp = Number(_loc10_[8]);
               _loc11_.guildxp = Number(_loc10_[9]);
               _loc11_.mountxp = Number(_loc10_[10]);
               var _loc12_ = _loc10_[11].split(",");
               if(_loc11_.id == this.api.datacenter.Player.ID && _loc12_.length > 10)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
               }
               _loc11_.kama = _loc10_[12];
               break;
            case 1:
               _loc11_.minhonour = Number(_loc10_[5]);
               _loc11_.honour = Number(_loc10_[6]);
               _loc11_.maxhonour = Number(_loc10_[7]);
               _loc11_.winhonour = Number(_loc10_[8]);
               _loc11_.rank = Number(_loc10_[9]);
               _loc11_.disgrace = Number(_loc10_[10]);
               _loc11_.windisgrace = Number(_loc10_[11]);
               _loc11_.maxdisgrace = this.api.lang.getMaxDisgracePoints();
               _loc11_.mindisgrace = 0;
               _loc12_ = _loc10_[12].split(",");
               if(_loc11_.id == this.api.datacenter.Player.ID && _loc12_.length > 10)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_GREAT_DROP);
               }
               _loc11_.kama = _loc10_[13];
               _loc11_.minxp = Number(_loc10_[14]);
               _loc11_.xp = Number(_loc10_[15]);
               _loc11_.maxxp = Number(_loc10_[16]);
               _loc11_.winxp = Number(_loc10_[17]);
         }
      }
      else
      {
         _loc12_ = _loc10_[1].split(",");
         _loc11_.kama = _loc10_[2];
         nKamaDrop = nKamaDrop + Number(_loc11_.kama);
      }
      _loc11_.items = new Array();
      var _loc14_ = _loc12_.length;
      while((_loc14_ = _loc14_ - 1) >= 0)
      {
         var _loc15_ = _loc12_[_loc14_].split("~");
         var _loc16_ = Number(_loc15_[0]);
         var _loc17_ = Number(_loc15_[1]);
         if(_global.isNaN(_loc16_))
         {
            break;
         }
         if(_loc16_ != 0)
         {
            var _loc18_ = new dofus.datacenter.Item(0,_loc16_,_loc17_);
            _loc11_.items.push(_loc18_);
         }
      }
      switch(Number(_loc10_[0]))
      {
         case 0:
            oResults.loosers.push(_loc11_);
            break;
         case 2:
            oResults.winners.push(_loc11_);
            break;
         case 5:
            oResults.collectors.push(_loc11_);
            break;
         case 6:
            eaFightDrop = eaFightDrop.concat(_loc11_.items);
      }
      _loc9_ = _loc9_ + 1;
      if(_loc9_ < aTmp.length)
      {
         this.addToQueue({object:this,method:this.parsePlayerData,params:[oResults,_loc9_,nSenderID,aTmp,nFightType,nKamaDrop,eaFightDrop]});
      }
      else
      {
         this.onParseItemEnd(nSenderID,oResults,eaFightDrop,nKamaDrop);
      }
   }
   function onParseItemEnd(nSenderID, oResults, eaFightDrop, nKamaDrop)
   {
      if(eaFightDrop.length)
      {
         var _loc6_ = Math.ceil(eaFightDrop.length / oResults.winners.length);
         var _loc7_ = 0;
         while(_loc7_ < oResults.winners.length)
         {
            var _loc8_ = eaFightDrop.length;
            oResults.winners[_loc7_].kama = Math.ceil(nKamaDrop / _loc6_);
            if(_loc7_ == oResults.winners.length - 1)
            {
               _loc6_ = _loc8_;
            }
            var _loc9_ = _loc8_ - _loc6_;
            while(_loc9_ < _loc8_)
            {
               oResults.winners[_loc7_].items.push(eaFightDrop.pop());
               _loc9_ = _loc9_ + 1;
            }
            _loc7_ = _loc7_ + 1;
         }
      }
      if(nSenderID == this.api.datacenter.Player.ID)
      {
         this.aks.GameActions.onActionsFinish(String(nSenderID));
      }
      this.api.datacenter.Game.isRunning = false;
      var _loc10_ = this.api.datacenter.Sprites.getItemAt(nSenderID).sequencer;
      this._bIsBusy = false;
      if(_loc10_ != undefined)
      {
         _loc10_.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.terminateFight);
         _loc10_.execute(false);
      }
      else
      {
         ank.utils.Logger.err("[AKS.Game.onEnd] Impossible de trouver le sequencer");
         ank.utils.Timer.setTimer(this,"game",this.api.kernel.GameManager,this.api.kernel.GameManager.terminateFight,500);
      }
      this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDFIGHT);
   }
   function onExtraClip(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1].split(";");
      var _loc6_ = dofus.Constants.EXTRA_PATH + _loc4_ + ".swf";
      var _loc7_ = _loc4_ == "-";
      for(var k in _loc5_)
      {
         var _loc8_ = _loc5_[k];
         if(_loc7_)
         {
            this.api.gfx.removeSpriteExtraClip(_loc8_,false);
         }
         else
         {
            this.api.gfx.addSpriteExtraClip(_loc8_,_loc6_,undefined,false);
         }
      }
   }
   function onPVP(sExtraData, bEnabled)
   {
      if(!bEnabled)
      {
         var _loc4_ = Number(sExtraData);
         this.api.kernel.showMessage(undefined,this.api.lang.getText("ASK_DISABLE_PVP",[_loc4_]),"CAUTION_YESNO",{name:"DisabledPVP",listener:this});
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("ASK_ENABLED_PVP"),"CAUTION_YESNO",{name:"EnabledPVP",listener:this});
      }
   }
   function onGameOver()
   {
      this.api.network.softDisconnect();
      this.api.ui.loadUIComponent("GameOver","GameOver",undefined,{bAlwaysOnTop:true});
   }
   function onCreateSolo()
   {
      this.api.datacenter.Player.InteractionsManager.setState(false);
      this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
      this.api.ui.removeCursor();
      this.api.ui.getUIComponent("Banner").shortcuts.setCurrentTab("Items");
      this.api.datacenter.Basics.gfx_isSpritesHidden = false;
      this.api.gfx.spriteHandler.unmaskAllSprites();
      if(!this.api.gfx.isMapBuild)
      {
         if(this.api.ui.getUIComponent("Banner") == undefined)
         {
            this.api.kernel.OptionsManager.applyAllOptions();
            this.api.ui.loadUIComponent("Banner","Banner",{data:this.api.datacenter.Player},{bAlwaysOnTop:true});
            this.api.ui.setScreenSize(742,432);
         }
         this.addToQueue({object:this,method:this.getMapData,params:[this.api.datacenter.Map.id]});
      }
      else
      {
         var _loc2_ = this.api.ui.getUIComponent("Banner");
         _loc2_.showPoints(false);
         _loc2_.showNextTurnButton(false);
         _loc2_.showGiveUpButton(false);
         this.api.ui.unloadUIComponent("FightOptionButtons");
         this.api.ui.unloadUIComponent("ChallengeMenu");
         this.api.gfx.cleanMap(2);
         this.getMapData(this.api.datacenter.Map.id);
      }
   }
   function onSpriteMovement(bAdd, oSprite, aEffect)
   {
      if(oSprite instanceof dofus.datacenter.Character)
      {
         this.api.datacenter.Game.playerCount = this.api.datacenter.Game.playerCount + (!bAdd?-1:1);
      }
      if(bAdd)
      {
         if(aEffect != undefined)
         {
            this.api.gfx.spriteLaunchVisualEffect.apply(this.api.gfx,aEffect);
         }
         this.api.gfx.addSprite(oSprite.id);
         if(!_global.isNaN(oSprite.scaleX))
         {
            this.api.gfx.setSpriteScale(oSprite.id,oSprite.scaleX,oSprite.scaleY);
         }
         if(oSprite instanceof dofus.datacenter.OfflineCharacter)
         {
            oSprite.mc.addExtraClip(dofus.Constants.EXTRA_PATH + oSprite.offlineType + ".swf",undefined,true);
            return undefined;
         }
         if(oSprite instanceof dofus.datacenter.NonPlayableCharacter)
         {
            if(!_global.isNaN(oSprite.extraClipID))
            {
               this.api.gfx.addSpriteExtraClip(oSprite.id,dofus.Constants.EXTRA_PATH + oSprite.extraClipID + ".swf",undefined,false);
               return undefined;
            }
         }
         if(this.api.datacenter.Game.isRunning)
         {
            this.api.gfx.addSpriteExtraClip(oSprite.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[oSprite.Team]);
         }
         else if(oSprite.Aura != 0 && (oSprite.Aura != undefined && this.api.kernel.OptionsManager.getOption("Aura")))
         {
            this.api.gfx.addSpriteExtraClip(oSprite.id,dofus.Constants.AURA_PATH + oSprite.Aura + ".swf",undefined,true);
         }
         if(oSprite.id == this.api.datacenter.Player.ID)
         {
            this.api.ui.getUIComponent("Banner").updateLocalPlayer();
         }
         else if(this.api.gfx.spriteHandler.isPlayerSpritesHidden && (oSprite instanceof dofus.datacenter.Character || (oSprite instanceof dofus.datacenter.PlayerShop || oSprite instanceof dofus.datacenter.MonsterGroup)))
         {
            this.api.gfx.spriteHandler.hidePlayerSprites();
         }
         else if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && oSprite instanceof dofus.datacenter.MonsterGroup)
         {
            oSprite.mc._rollOver();
         }
      }
      else if(!this.api.datacenter.Game.isRunning)
      {
         this.api.gfx.removeSprite(oSprite.id);
      }
      else
      {
         var _loc5_ = oSprite.sequencer;
         var _loc6_ = oSprite.mc;
         _loc5_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("LEAVE_GAME",[oSprite.name]),"INFO_CHAT"]);
         _loc5_.addAction(false,this.api.ui.getUIComponent("Timeline"),this.api.ui.getUIComponent("Timeline").hideItem,[oSprite.id]);
         _loc5_.addAction(true,_loc6_,_loc6_.setAnim,["Die"],1500);
         if(oSprite.hasCarriedChild())
         {
            this.api.gfx.uncarriedSprite(oSprite.carriedChild.id,oSprite.cellNum,false,_loc5_);
            _loc5_.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[oSprite.carriedChild.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[oSprite.carriedChild.Team]]);
         }
         _loc5_.addAction(false,_loc6_,_loc6_.clear);
         _loc5_.execute();
         if(this.api.datacenter.Game.currentPlayerID == oSprite.id)
         {
            this.api.ui.getUIComponent("Banner").stopTimer();
            this.api.ui.getUIComponent("Timeline").stopChrono();
         }
      }
      if(!this.api.datacenter.Game.isFight)
      {
         var _loc7_ = this.api.datacenter.Game.playerCount;
         var _loc8_ = this.api.kernel.OptionsManager.getOption("CreaturesMode");
         var _loc9_ = _loc8_ - 2;
         if(_loc7_ >= _loc8_)
         {
            var _loc10_ = this.api.datacenter.Sprites.getItems();
            for(var k in _loc10_)
            {
               var _loc11_ = _loc10_[k];
               if(_loc11_ instanceof dofus.datacenter.Character)
               {
                  if(_loc11_.canSwitchInCreaturesMode)
                  {
                     if(!(_loc11_ instanceof dofus.datacenter.Mutant))
                     {
                        if(!_loc11_.bInCreaturesMode)
                        {
                           _loc11_.tmpGfxFile = _loc11_.gfxFile;
                           _loc11_.tmpMount = _loc11_.mount;
                           _loc11_.mount = undefined;
                           var _loc12_ = dofus.Constants.CLIPS_PERSOS_PATH + _loc11_.Guild + "2.swf";
                           this.api.gfx.setSpriteGfx(_loc11_.id,_loc12_);
                           _loc11_.bInCreaturesMode = true;
                        }
                     }
                  }
               }
            }
            this.api.datacenter.Game.isInCreaturesMode = true;
         }
         if(_loc7_ < _loc9_)
         {
            var _loc13_ = this.api.datacenter.Sprites.getItems();
            for(var k in _loc13_)
            {
               var _loc14_ = _loc13_[k];
               if(_loc14_ instanceof dofus.datacenter.Character)
               {
                  if(_loc14_.canSwitchInCreaturesMode)
                  {
                     if(!(_loc14_ instanceof dofus.datacenter.Mutant))
                     {
                        if(_loc14_.bInCreaturesMode)
                        {
                           _loc14_.mount = _loc14_.tmpMount;
                           delete register14.tmpMount;
                           var _loc15_ = _loc14_.tmpGfxFile != undefined?_loc14_.tmpGfxFile:_loc14_.gfxFile;
                           delete register14.tmpGfxFile;
                           this.api.gfx.setSpriteGfx(_loc14_.id,_loc15_);
                           _loc14_.bInCreaturesMode = false;
                        }
                     }
                  }
               }
            }
            this.api.datacenter.Game.isInCreaturesMode = false;
         }
      }
   }
   function onFlag(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = this.api.datacenter.Sprites.getItemAt(_loc4_);
      var _loc7_ = new ank.battlefield.datacenter.VisualEffect();
      _loc7_.file = dofus.Constants.CLIPS_PATH + "flag.swf";
      _loc7_.bInFrontOfSprite = true;
      _loc7_.bTryToBypassContainerColor = true;
      this.api.kernel.showMessage(undefined,this.api.lang.getText("PLAYER_SET_FLAG",[_loc6_.name,_loc5_]),"INFO_CHAT");
      this.api.gfx.spriteLaunchVisualEffect(_loc4_,_loc7_,_loc5_,11,undefined,undefined,undefined,true);
   }
   function onFightChallenge(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      if(!this.api.ui.getUIComponent("FightChallenge"))
      {
         this.api.ui.loadUIComponent("FightChallenge","FightChallenge");
      }
      var _loc4_ = new dofus.datacenter.FightChallengeData(_global.parseInt(_loc3_[0]),_loc3_[1] == "1",_global.parseInt(_loc3_[2]),_global.parseInt(_loc3_[3]),_global.parseInt(_loc3_[4]),_global.parseInt(_loc3_[5]),_global.parseInt(_loc3_[6]));
      (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge").addChallenge(_loc4_);
   }
   function onFightChallengeUpdate(sExtraData, success)
   {
      var _loc4_ = _global.parseInt(sExtraData);
      (dofus.graphics.gapi.ui.FightChallenge)(dofus.graphics.gapi.ui.FightChallenge)this.api.ui.getUIComponent("FightChallenge").updateChallenge(_loc4_,success);
      var _loc5_ = !success?this.api.lang.getText("FIGHT_CHALLENGE_FAILED"):this.api.lang.getText("FIGHT_CHALLENGE_DONE");
      _loc5_ = _loc5_ + (" : " + this.api.lang.getFightChallenge(_loc4_).n);
      this.api.kernel.showMessage(undefined,_loc5_,"INFO_CHAT");
   }
   function sliptGfxData(sGfx)
   {
      if(sGfx.indexOf(",") != -1)
      {
         var _loc3_ = sGfx.split(",");
         return {shape:"circle",gfx:_loc3_};
      }
      if(sGfx.indexOf(":") != -1)
      {
         var _loc4_ = sGfx.split(":");
         return {shape:"line",gfx:_loc4_};
      }
      return {shape:"none",gfx:[sGfx]};
   }
   function createTransitionEffect()
   {
      var _loc2_ = new ank.battlefield.datacenter.VisualEffect();
      _loc2_.id = 5;
      _loc2_.file = dofus.Constants.SPELLS_PATH + "transition.swf";
      _loc2_.level = 5;
      _loc2_.params = [];
      _loc2_.bInFrontOfSprite = true;
      _loc2_.bTryToBypassContainerColor = false;
      return _loc2_;
   }
   function splitGfxForScale(sGfxInput, oData)
   {
      var _loc4_ = sGfxInput.split("^");
      var _loc5_ = _loc4_.length != 2?sGfxInput:_loc4_[0];
      var _loc6_ = 100;
      var _loc7_ = 100;
      if(_loc4_.length == 2)
      {
         var _loc8_ = _loc4_[1];
         if(_global.isNaN(Number(_loc8_)))
         {
            var _loc9_ = _loc8_.split("x");
            _loc6_ = _loc9_.length != 2?100:Number(_loc9_[0]);
            _loc7_ = _loc9_.length != 2?100:Number(_loc9_[1]);
         }
         else
         {
            _loc6_ = _loc7_ = Number(_loc8_);
         }
      }
      oData.gfxID = _loc5_;
      oData.scaleX = _loc6_;
      oData.scaleY = _loc7_;
   }
   function cancel(oEvent)
   {
      var _loc0_ = oEvent.target._name;
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoEnabledPVP":
            this.api.network.Game.enabledPVPMode(true);
            break;
         case "AskYesNoDisabledPVP":
            this.api.network.Game.enabledPVPMode(false);
      }
   }
   function no(oEvent)
   {
      var _loc0_ = oEvent.target._name;
   }
}
