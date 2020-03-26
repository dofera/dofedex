class dofus.aks.GameActions extends dofus.aks.Handler
{
   function GameActions(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function warning(sWarning)
   {
      this.infoImportanteDecompilo("Hello, we would like to tell you that modifying your Dofus client or sharing a modified client is strictly FORBIDDEN.");
      this.infoImportanteDecompilo("Modifying your client in any way will also flag you as a bot by our security systems.");
      this.infoImportanteDecompilo("Bonjour, nous souhaitons vous avertir que toute modification du client ou partage d\'un client modifié est strictement INTERDIT.");
      this.infoImportanteDecompilo("Modifier votre client (et ce quelque soit le type de modification) aura également pour conséquence de vous identifier comme un BOT par nos systèmes de sécurité.");
   }
   function infoImportanteDecompilo(sInfoPourLesMargoulins)
   {
   }
   function sendActions(nActionType, aParams)
   {
      var _loc4_ = new String();
      this.aks.send("GA" + new ank.utils.ExtendedString(nActionType).addLeftChar("0",3) + aParams.join(";"));
   }
   function actionAck(nActionID)
   {
      this.aks.send("GKK" + nActionID,false);
   }
   function actionCancel(nActionID, params)
   {
      this.aks.send("GKE" + nActionID + "|" + params,false);
   }
   function challenge(sSpriteID)
   {
      this.sendActions(900,[sSpriteID]);
   }
   function acceptChallenge(sSpriteID)
   {
      this.sendActions(901,[sSpriteID]);
   }
   function refuseChallenge(sSpriteID)
   {
      this.sendActions(902,[sSpriteID]);
   }
   function joinChallenge(nChallengeID, sSpriteID)
   {
      if(sSpriteID == undefined)
      {
         this.sendActions(903,[nChallengeID]);
      }
      else
      {
         this.sendActions(903,[nChallengeID,sSpriteID]);
      }
   }
   function attack(sSpriteID)
   {
      this.sendActions(906,[sSpriteID]);
   }
   function attackTaxCollector(sSpriteID)
   {
      this.sendActions(909,[sSpriteID]);
   }
   function mutantAttack(sSpriteID)
   {
      this.sendActions(910,[sSpriteID]);
   }
   function attackPrism(sSpriteID)
   {
      this.sendActions(912,[sSpriteID]);
   }
   function usePrism(sSpriteID)
   {
      this.sendActions(512,[sSpriteID]);
   }
   function acceptMarriage(sSpriteID)
   {
      this.sendActions(618,[sSpriteID]);
   }
   function refuseMarriage(sSpriteID)
   {
      this.sendActions(619,[sSpriteID]);
   }
   function onActionsStart(sExtraData)
   {
      var _loc3_ = sExtraData;
      if(_loc3_ != this.api.datacenter.Player.ID)
      {
         return undefined;
      }
      var _loc4_ = this.api.datacenter.Player.data;
      _loc4_.GameActionsManager.m_bNextAction = true;
      if(this.api.datacenter.Game.isFight)
      {
         var _loc5_ = _loc4_.sequencer;
         _loc5_.addAction(false,this.api.gfx,this.api.gfx.setInteraction,[ank.battlefield.Constants.INTERACTION_CELL_NONE]);
         _loc5_.execute();
      }
   }
   function onActionsFinish(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1];
      if(_loc5_ != this.api.datacenter.Player.ID)
      {
         return undefined;
      }
      var _loc6_ = this.api.datacenter.Player.data;
      var _loc7_ = _loc6_.sequencer;
      _loc6_.GameActionsManager.m_bNextAction = false;
      if(this.api.datacenter.Game.isFight)
      {
         _loc7_.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.setEnabledInteractionIfICan,[ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT]);
         if(_loc4_ != undefined)
         {
            _loc7_.addAction(false,this,this.actionAck,[_loc4_]);
         }
         _loc7_.addAction(false,this.api.kernel.GameManager,this.api.kernel.GameManager.cleanPlayer,[_loc5_]);
         this.api.gfx.mapHandler.resetEmptyCells();
         _loc7_.execute();
         if(_loc4_ == 2)
         {
            this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FIGHT_ENDMOVE);
         }
      }
   }
   function onActions(sExtraData)
   {
      var _loc3_ = sExtraData.indexOf(";");
      var _loc4_ = Number(sExtraData.substring(0,_loc3_));
      if(dofus.Constants.SAVING_THE_WORLD)
      {
         if(sExtraData == ";0")
         {
            dofus.SaveTheWorld.getInstance().nextActionIfOnSafe();
         }
      }
      sExtraData = sExtraData.substring(_loc3_ + 1);
      _loc3_ = sExtraData.indexOf(";");
      var _loc5_ = Number(sExtraData.substring(0,_loc3_));
      sExtraData = sExtraData.substring(_loc3_ + 1);
      _loc3_ = sExtraData.indexOf(";");
      var _loc6_ = sExtraData.substring(0,_loc3_);
      var _loc7_ = sExtraData.substring(_loc3_ + 1);
      if(_loc6_.length == 0)
      {
         _loc6_ = this.api.datacenter.Player.ID;
      }
      var _loc9_ = this.api.datacenter.Game.currentPlayerID;
      if(this.api.datacenter.Game.isFight && _loc9_ != undefined)
      {
         var _loc8_ = _loc9_;
      }
      else
      {
         _loc8_ = _loc6_;
      }
      var _loc10_ = this.api.datacenter.Sprites.getItemAt(_loc8_);
      var _loc11_ = _loc10_.sequencer;
      var _loc12_ = _loc10_.GameActionsManager;
      var _loc13_ = true;
      _loc12_.onServerResponse(_loc4_);
      switch(_loc5_)
      {
         case 0:
            return undefined;
         case 1:
            var _loc14_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            if(!this.api.gfx.isMapBuild)
            {
               return undefined;
            }
            if(dofus.Constants.USE_JS_LOG && (_global.CONFIG.isNewAccount && !this.api.datacenter.Basics.first_movement))
            {
               getURL("JavaScript:WriteLog(\'Mouvement\')","_self");
               this.api.datacenter.Basics.first_movement = true;
            }
            var _loc15_ = ank.battlefield.utils.Compressor.extractFullPath(this.api.gfx.mapHandler,_loc7_);
            if(_loc14_.hasCarriedParent())
            {
               _loc15_.shift();
               this.api.gfx.uncarriedSprite(_loc6_,_loc15_[0],true,_loc11_);
               _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[_loc6_,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[_loc14_.Team]]);
            }
            var _loc16_ = _loc14_.forceRun;
            var _loc17_ = _loc14_.forceWalk;
            var _loc18_ = !this.api.datacenter.Game.isFight?!(_loc14_ instanceof dofus.datacenter.Character)?6:3:!(_loc14_ instanceof dofus.datacenter.Character)?4:3;
            this.api.gfx.moveSpriteWithUncompressedPath(_loc6_,_loc15_,_loc11_,!this.api.datacenter.Game.isFight,_loc16_,_loc17_,_loc18_);
            if(this.api.datacenter.Game.isRunning)
            {
               _loc11_.addAction(false,this.api.gfx,this.api.gfx.unSelect,[true]);
            }
         case 2:
            if(_loc11_ == undefined)
            {
               this.api.gfx.clear();
               this.api.datacenter.clearGame();
               if(!this.api.kernel.TutorialManager.isTutorialMode)
               {
                  this.api.ui.loadUIComponent("CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true});
               }
            }
            else
            {
               _loc11_.addAction(false,this.api.gfx,this.api.gfx.clear);
               _loc11_.addAction(false,this.api.datacenter,this.api.datacenter.clearGame);
               if(_loc7_.length == 0)
               {
                  _loc11_.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true}]);
               }
               else
               {
                  _loc11_.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["Cinematic","Cinematic",{file:dofus.Constants.CINEMATICS_PATH + _loc7_ + ".swf",sequencer:_loc11_}]);
               }
            }
         case 4:
            var _loc19_ = _loc7_.split(",");
            var _loc20_ = _loc19_[0];
            var _loc21_ = Number(_loc19_[1]);
            var _loc22_ = this.api.datacenter.Sprites.getItemAt(_loc20_).mc;
            _loc11_.addAction(false,_loc22_,_loc22_.setPosition,[_loc21_]);
         case 5:
            var _loc23_ = _loc7_.split(",");
            var _loc24_ = _loc23_[0];
            var _loc25_ = Number(_loc23_[1]);
            this.api.gfx.slideSprite(_loc24_,_loc25_,_loc11_);
         case 11:
            var _loc26_ = _loc7_.split(",");
            var _loc27_ = _loc26_[0];
            var _loc28_ = Number(_loc26_[1]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.setSpriteDirection,[_loc27_,_loc28_]);
         case 50:
            var _loc29_ = _loc7_;
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.carriedSprite,[_loc29_,_loc6_]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.removeSpriteExtraClip,[_loc29_]);
         case 51:
            var _loc30_ = Number(_loc7_);
            var _loc31_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc32_ = _loc31_.carriedChild;
            var _loc33_ = new ank.battlefield.datacenter.VisualEffect();
            _loc33_.file = dofus.Constants.SPELLS_PATH + "1200.swf";
            _loc33_.level = 1;
            _loc33_.bInFrontOfSprite = true;
            _loc33_.bTryToBypassContainerColor = false;
            this.api.gfx.spriteLaunchCarriedSprite(_loc6_,_loc33_,_loc30_,31,10);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[_loc32_.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[_loc32_.Team]]);
         case 52:
            var _loc34_ = _loc7_.split(",");
            var _loc35_ = _loc34_[0];
            var _loc36_ = this.api.datacenter.Sprites.getItemAt(_loc35_);
            var _loc37_ = Number(_loc34_[1]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.uncarriedSprite,[_loc35_,_loc37_,false]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[_loc35_,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[_loc36_.Team]]);
         case 100:
         case 108:
         case 110:
            var _loc38_ = _loc7_.split(",");
            var _loc39_ = _loc38_[0];
            var _loc40_ = this.api.datacenter.Sprites.getItemAt(_loc39_);
            var _loc41_ = Number(_loc38_[1]);
            if(_loc41_ != 0)
            {
               var _loc42_ = _loc41_ >= 0?"WIN_LP":"LOST_LP";
               _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(_loc42_,[_loc40_.name,Math.abs(_loc41_)]),"INFO_FIGHT_CHAT"]);
               _loc11_.addAction(false,_loc40_,_loc40_.updateLP,[_loc41_]);
               _loc11_.addAction(false,this.api.ui.getUIComponent("Timeline").timelineControl,this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters);
            }
            else
            {
               _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("NOCHANGE_LP",[_loc40_.name]),"INFO_FIGHT_CHAT"]);
            }
         case 101:
         case 102:
         case 111:
         case 120:
         case 168:
            var _loc43_ = _loc7_.split(",");
            var _loc44_ = this.api.datacenter.Sprites.getItemAt(_loc43_[0]);
            var _loc45_ = Number(_loc43_[1]);
            if(_loc45_ != 0)
            {
               if(_loc5_ == 101 || (_loc5_ == 111 || (_loc5_ == 120 || _loc5_ == 168)))
               {
                  var _loc46_ = _loc45_ >= 0?"WIN_AP":"LOST_AP";
                  _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(_loc46_,[_loc44_.name,Math.abs(_loc45_)]),"INFO_FIGHT_CHAT"]);
               }
               _loc11_.addAction(false,_loc44_,_loc44_.updateAP,[_loc45_,_loc5_ == 102]);
            }
         case 127:
         case 129:
         case 128:
         case 78:
         case 169:
            var _loc47_ = _loc7_.split(",");
            var _loc48_ = _loc47_[0];
            var _loc49_ = Number(_loc47_[1]);
            var _loc50_ = this.api.datacenter.Sprites.getItemAt(_loc48_);
            if(_loc49_ != 0)
            {
               if(_loc5_ == 127 || (_loc5_ == 128 || (_loc5_ == 169 || _loc5_ == 78)))
               {
                  var _loc51_ = _loc49_ >= 0?"WIN_MP":"LOST_MP";
                  _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText(_loc51_,[_loc50_.name,Math.abs(_loc49_)]),"INFO_FIGHT_CHAT"]);
               }
               _loc11_.addAction(false,_loc50_,_loc50_.updateMP,[_loc49_,_loc5_ == 129]);
            }
         case 103:
            var _loc52_ = _loc7_;
            var _loc53_ = this.api.datacenter.Sprites.getItemAt(_loc52_);
            var _loc54_ = _loc53_.mc;
            if(_loc54_ == undefined)
            {
               return undefined;
            }
            var _loc55_ = _loc53_.sex != 1?"m":"f";
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("DIE",[_loc53_.name]),_loc55_,true),"INFO_FIGHT_CHAT"]);
            var _loc56_ = this.api.ui.getUIComponent("Timeline");
            _loc11_.addAction(false,_loc56_,_loc56_.hideItem,[_loc52_]);
            this.warning("You\'re not allowed to change the behaviour of the game animations. Please play legit !");
            this.warning("Toute modification du comportement des animations est détectée et sanctionnée car c\'est considéré comme de la triche, merci de jouer legit !");
            _loc11_.addAction(true,_loc54_,_loc54_.setAnim,["Die"],1500);
            this.warning("Vous n\'êtes même pas sensé pouvoir lire ce message, mais un rappel de plus n\'est pas de trop pour certains : modification du client = ban ;)");
            if(_loc53_.hasCarriedChild())
            {
               this.api.gfx.uncarriedSprite(_loc53_.carriedSprite.id,_loc53_.cellNum,false,_loc11_);
               _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClip,[_loc53_.carriedChild.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[_loc53_.carriedChild.Team]]);
            }
            _loc11_.addAction(false,_loc54_,_loc54_.clear);
            if(this.api.datacenter.Player.summonedCreaturesID[_loc52_])
            {
               this.api.datacenter.Player.SummonedCreatures = this.api.datacenter.Player.SummonedCreatures - 1;
               delete this.api.datacenter.Player.summonedCreaturesID.register52;
               this.api.ui.getUIComponent("Banner").shortcuts.setSpellStateOnAllContainers();
            }
            if(_loc52_ == this.api.datacenter.Player.ID)
            {
               if(_loc6_ == this.api.datacenter.Player.ID)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_HIMSELF);
               }
               else
               {
                  var _loc57_ = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
                  var _loc58_ = this.api.datacenter.Sprites.getItemAt(_global.parseInt(_loc6_)).Team;
                  if(_loc57_ == _loc58_)
                  {
                     this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_BY_ALLY);
                  }
                  else
                  {
                     this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                  }
               }
            }
            else if(_loc6_ == this.api.datacenter.Player.ID)
            {
               var _loc59_ = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
               var _loc60_ = this.api.datacenter.Sprites.getItemAt(_global.parseInt(_loc52_)).Team;
               if(_loc59_ == _loc60_)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILL_ALLY);
               }
               else
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_KILL_ENEMY);
               }
            }
         case 104:
            var _loc61_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc62_ = _loc61_.mc;
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("CANT_MOVEOUT"),"INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,_loc62_,_loc62_.setAnim,["Hit"]);
         case 105:
         case 164:
            var _loc63_ = _loc7_.split(",");
            var _loc64_ = _loc63_[0];
            var _loc65_ = _loc5_ != 164?_loc63_[1]:_loc63_[1] + "%";
            var _loc66_ = this.api.datacenter.Sprites.getItemAt(_loc64_);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_DAMAGES",[_loc66_.name,_loc65_]),"INFO_FIGHT_CHAT"]);
         case 106:
            var _loc67_ = _loc7_.split(",");
            var _loc68_ = _loc67_[0];
            var _loc69_ = _loc67_[1] == "1";
            var _loc70_ = this.api.datacenter.Sprites.getItemAt(_loc68_);
            var _loc71_ = !_loc69_?this.api.lang.getText("RETURN_SPELL_NO",[_loc70_.name]):this.api.lang.getText("RETURN_SPELL_OK",[_loc70_.name]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,_loc71_,"INFO_FIGHT_CHAT"]);
         case 107:
            var _loc72_ = _loc7_.split(",");
            var _loc73_ = _loc72_[0];
            var _loc74_ = _loc72_[1];
            var _loc75_ = this.api.datacenter.Sprites.getItemAt(_loc73_);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_DAMAGES",[_loc75_.name,_loc74_]),"INFO_FIGHT_CHAT"]);
         case 130:
            var _loc76_ = Number(_loc7_);
            var _loc77_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,ank.utils.PatternDecoder.combine(this.api.lang.getText("STEAL_GOLD",[_loc77_.name,_loc76_]),"m",_loc76_ < 2),"INFO_FIGHT_CHAT"]);
         case 132:
            var _loc78_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc79_ = this.api.datacenter.Sprites.getItemAt(_loc7_);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REMOVE_ALL_EFFECTS",[_loc78_.name,_loc79_.name]),"INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,_loc79_.CharacteristicsManager,_loc79_.CharacteristicsManager.terminateAllEffects);
            _loc11_.addAction(false,_loc79_.EffectsManager,_loc79_.EffectsManager.terminateAllEffects);
         case 140:
            var _loc80_ = Number(_loc7_);
            var _loc81_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc82_ = this.api.datacenter.Sprites.getItemAt(_loc7_);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("A_PASS_NEXT_TURN",[_loc82_.name]),"INFO_FIGHT_CHAT"]);
         case 151:
            var _loc83_ = Number(_loc7_);
            var _loc84_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc85_ = _loc83_ != -1?this.api.lang.getText("INVISIBLE_OBSTACLE",[_loc84_.name,this.api.lang.getSpellText(_loc83_).n]):this.api.lang.getText("CANT_DO_INVISIBLE_OBSTACLE");
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,_loc85_,"ERROR_CHAT"]);
         case 166:
            var _loc86_ = _loc7_.split(",");
            var _loc87_ = Number(_loc86_[0]);
            var _loc88_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc89_ = Number(_loc86_[1]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("RETURN_AP",[_loc88_.name,_loc89_]),"INFO_FIGHT_CHAT"]);
         case 164:
            var _loc90_ = _loc7_.split(",");
            var _loc91_ = Number(_loc90_[0]);
            var _loc92_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc93_ = Number(_loc90_[1]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("REDUCE_LP_DAMAGES",[_loc92_.name,_loc93_]),"INFO_FIGHT_CHAT"]);
         case 780:
            if(_loc6_ == this.api.datacenter.Player.ID)
            {
               this.api.datacenter.Player.SummonedCreatures = this.api.datacenter.Player.SummonedCreatures + 1;
               var _loc94_ = _global.parseInt(_loc7_.split(";")[3]);
               this.api.datacenter.Player.summonedCreaturesID[_loc94_] = true;
            }
         case 147:
            var _loc95_ = _loc7_.split(";")[3];
            var _loc96_ = this.api.ui.getUIComponent("Timeline");
            _loc11_.addAction(false,_loc96_,_loc96_.showItem,[_loc95_]);
            _loc11_.addAction(false,this.aks.Game,this.aks.Game.onMovement,[_loc7_,true]);
         case 180:
         case 181:
            var _loc97_ = _loc7_.split(";")[3];
            if(_loc6_ == this.api.datacenter.Player.ID)
            {
               this.api.datacenter.Player.SummonedCreatures = this.api.datacenter.Player.SummonedCreatures + 1;
               this.api.datacenter.Player.summonedCreaturesID[_loc97_] = true;
            }
            _loc11_.addAction(false,this.aks.Game,this.aks.Game.onMovement,[_loc7_,true]);
         case 185:
            _loc11_.addAction(false,this.aks.Game,this.aks.Game.onMovement,[_loc7_]);
         case 117:
         case 116:
         case 115:
         case 122:
         case 112:
         case 142:
         case 145:
         case 138:
         case 160:
         case 161:
         case 114:
         case 182:
         case 118:
         case 157:
         case 123:
         case 152:
         case 126:
         case 155:
         case 119:
         case 154:
         case 124:
         case 156:
         case 125:
         case 153:
         case 160:
         case 161:
         case 162:
         case 163:
         case 606:
         case 607:
         case 608:
         case 609:
         case 610:
         case 611:
            var _loc98_ = _loc7_.split(",");
            var _loc99_ = _loc98_[0];
            var _loc100_ = this.api.datacenter.Sprites.getItemAt(_loc99_);
            var _loc101_ = Number(_loc98_[1]);
            var _loc102_ = Number(_loc98_[2]);
            var _loc103_ = _loc100_.CharacteristicsManager;
            var _loc104_ = new dofus.datacenter.Effect(_loc5_,_loc101_,undefined,undefined,undefined,_loc102_);
            _loc11_.addAction(false,_loc103_,_loc103_.addEffect,[_loc104_]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"<b>" + _loc100_.name + "</b> : " + _loc104_.description,"INFO_FIGHT_CHAT"]);
         case 149:
            var _loc105_ = _loc7_.split(",");
            var _loc106_ = _loc105_[0];
            var _loc107_ = this.api.datacenter.Sprites.getItemAt(_loc106_);
            var _loc108_ = Number(_loc105_[1]);
            var _loc109_ = Number(_loc105_[2]);
            var _loc110_ = Number(_loc105_[3]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("GFX",[_loc107_.name]),"INFO_FIGHT_CHAT"]);
            var _loc111_ = _loc107_.CharacteristicsManager;
            var _loc112_ = new dofus.datacenter.Effect(_loc5_,_loc108_,_loc109_,undefined,undefined,_loc110_);
            _loc11_.addAction(false,_loc111_,_loc111_.addEffect,[_loc112_]);
         case 150:
            var _loc113_ = _loc7_.split(",");
            var _loc114_ = _loc113_[0];
            var _loc115_ = this.api.datacenter.Sprites.getItemAt(_loc114_);
            var _loc116_ = Number(_loc113_[1]);
            if(_loc116_ > 0)
            {
               _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("INVISIBILITY",[_loc115_.name]),"INFO_FIGHT_CHAT"]);
               var _loc117_ = _loc115_.CharacteristicsManager;
               var _loc118_ = new dofus.datacenter.Effect(_loc5_,1,undefined,undefined,undefined,_loc116_);
               _loc11_.addAction(false,_loc117_,_loc117_.addEffect,[_loc118_]);
            }
            else
            {
               _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("VISIBILITY",[_loc115_.name]),"INFO_FIGHT_CHAT"]);
               this.api.gfx.hideSprite(_loc114_,false);
               this.api.gfx.setSpriteAlpha(_loc114_,100);
            }
         case 165:
            var _loc119_ = _loc7_.split(",");
            var _loc120_ = _loc119_[0];
            var _loc121_ = Number(_loc119_[1]);
            var _loc122_ = Number(_loc119_[2]);
            var _loc123_ = Number(_loc119_[3]);
         case 200:
            var _loc124_ = _loc7_.split(",");
            var _loc125_ = Number(_loc124_[0]);
            var _loc126_ = Number(_loc124_[1]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.setObject2Frame,[_loc125_,_loc126_]);
         case 208:
            var _loc127_ = _loc7_.split(",");
            var _loc128_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc129_ = Number(_loc127_[0]);
            var _loc130_ = _loc127_[1];
            var _loc131_ = Number(_loc127_[2]);
            var _loc132_ = !_global.isNaN(Number(_loc127_[3]))?"anim" + _loc127_[3]:String(_loc127_[3]).split("~");
            var _loc133_ = _loc127_[4] == undefined?1:Number(_loc127_[4]);
            var _loc134_ = new ank.battlefield.datacenter.VisualEffect();
            _loc134_.file = dofus.Constants.SPELLS_PATH + _loc130_ + ".swf";
            _loc134_.level = _loc133_;
            _loc134_.bInFrontOfSprite = true;
            _loc134_.bTryToBypassContainerColor = true;
            this.api.gfx.spriteLaunchVisualEffect(_loc6_,_loc134_,_loc129_,_loc131_,_loc132_);
         case 228:
            var _loc135_ = _loc7_.split(",");
            var _loc136_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc137_ = Number(_loc135_[0]);
            var _loc138_ = _loc135_[1];
            var _loc139_ = Number(_loc135_[2]);
            var _loc140_ = !_global.isNaN(Number(_loc135_[3]))?"anim" + _loc135_[3]:String(_loc135_[3]).split("~");
            var _loc141_ = _loc135_[4] == undefined?1:Number(_loc135_[4]);
            var _loc142_ = new ank.battlefield.datacenter.VisualEffect();
            _loc142_.file = dofus.Constants.SPELLS_PATH + _loc138_ + ".swf";
            _loc142_.level = _loc141_;
            _loc142_.bInFrontOfSprite = true;
            _loc142_.bTryToBypassContainerColor = false;
            this.api.gfx.spriteLaunchVisualEffect(_loc6_,_loc142_,_loc137_,_loc139_,_loc140_);
         case 300:
            var _loc143_ = _loc7_.split(",");
            var _loc144_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc145_ = Number(_loc143_[0]);
            var _loc146_ = Number(_loc143_[1]);
            var _loc147_ = _loc143_[2];
            var _loc148_ = Number(_loc143_[3]);
            var _loc149_ = Number(_loc143_[4]);
            var _loc150_ = !_global.isNaN(Number(_loc143_[5]))?!(_loc143_[5] == "-1" || _loc143_[5] == "-2")?"anim" + _loc143_[5]:undefined:String(_loc143_[5]).split("~");
            var _loc151_ = false;
            if(Number(_loc143_[5]) == -2)
            {
               _loc151_ = true;
            }
            var _loc152_ = _loc143_[6] != "1"?false:true;
            var _loc153_ = new ank.battlefield.datacenter.VisualEffect();
            _loc153_.file = dofus.Constants.SPELLS_PATH + _loc147_ + ".swf";
            _loc153_.level = _loc148_;
            _loc153_.bInFrontOfSprite = _loc152_;
            _loc153_.params = new dofus.datacenter.Spell(_loc145_,_loc148_).elements;
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[_loc144_.name,this.api.lang.getSpellText(_loc145_).n]),"INFO_FIGHT_CHAT"]);
            if(_loc150_ != undefined || _loc151_)
            {
               this.api.gfx.spriteLaunchVisualEffect(_loc6_,_loc153_,_loc146_,_loc149_,_loc150_);
            }
            if(_loc6_ == this.api.datacenter.Player.ID)
            {
               var _loc154_ = this.api.datacenter.Player.SpellsManager;
               var _loc155_ = this.api.gfx.mapHandler.getCellData(_loc146_).spriteOnID;
               var _loc156_ = new dofus.datacenter.LaunchedSpell(_loc145_,_loc155_);
               _loc154_.addLaunchedSpell(_loc156_);
            }
         case 301:
            var _loc157_ = Number(_loc7_);
            _loc11_.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[_loc6_,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
            if(_loc6_ == this.api.datacenter.Player.ID)
            {
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
            }
            else
            {
               var _loc158_ = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
               var _loc159_ = this.api.datacenter.Sprites.getItemAt(_global.parseInt(_loc6_)).Team;
               if(_loc158_ == _loc159_)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ALLIED);
               }
               else
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ENEMY);
               }
            }
         case 302:
            var _loc160_ = Number(_loc7_);
            var _loc161_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            _loc11_.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_LAUNCH_SPELL",[_loc161_.name,this.api.lang.getSpellText(_loc160_).n]),"INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[_loc6_,this.api.lang.getText("CRITICAL_MISS")]);
            if(_loc6_ == this.api.datacenter.Player.ID)
            {
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
            }
            else
            {
               var _loc162_ = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
               var _loc163_ = this.api.datacenter.Sprites.getItemAt(_global.parseInt(_loc6_)).Team;
               if(_loc162_ == _loc163_)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ALLIED);
               }
               else
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ENEMY);
               }
            }
         case 303:
            var _loc164_ = _loc7_.split(",");
            var _loc165_ = Number(_loc164_[0]);
            var _loc166_ = _loc164_[1];
            var _loc167_ = Number(_loc164_[2]);
            var _loc168_ = _loc164_[3] != "1"?false:true;
            var _loc169_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc170_ = _loc169_.mc;
            var _loc171_ = _loc169_.ToolAnimation;
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[_loc169_.name]),"INFO_FIGHT_CHAT"]);
            if(_loc166_ == undefined)
            {
               _loc11_.addAction(false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[_loc6_,_loc165_]);
               _loc11_.addAction(true,this.api.gfx,this.api.gfx.setSpriteAnim,[_loc6_,_loc171_]);
            }
            else
            {
               var _loc172_ = _loc169_.accessories[0].unicID;
               var _loc173_ = _loc169_.Guild;
               var _loc174_ = new ank.battlefield.datacenter.VisualEffect();
               _loc174_.file = dofus.Constants.SPELLS_PATH + _loc166_ + ".swf";
               _loc174_.level = 1;
               _loc174_.bInFrontOfSprite = _loc168_;
               _loc174_.params = new dofus.datacenter.CloseCombat(new dofus.datacenter.Item(undefined,_loc172_),_loc173_).elements;
               this.api.gfx.spriteLaunchVisualEffect(_loc6_,_loc174_,_loc165_,_loc167_,_loc171_);
            }
         case 304:
            var _loc175_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc176_ = _loc175_.mc;
            _loc11_.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalHit,[]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_HIT") + ")","INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteExtraClipOnTimer,[_loc6_,dofus.Constants.CRITICAL_HIT_XTRA_FILE,undefined,true,dofus.Constants.CRITICAL_HIT_DURATION]);
            if(_loc6_ == this.api.datacenter.Player.ID)
            {
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_OWNER);
            }
            else
            {
               var _loc177_ = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
               var _loc178_ = this.api.datacenter.Sprites.getItemAt(_global.parseInt(_loc6_)).Team;
               if(_loc177_ == _loc178_)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ALLIED);
               }
               else
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CC_ENEMY);
               }
            }
         case 305:
            var _loc179_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            _loc11_.addAction(false,this.api.sounds.events,this.api.sounds.events.onGameCriticalMiss,[]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_ATTACK_CC",[_loc179_.name]),"INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,"(" + this.api.lang.getText("CRITICAL_MISS") + ")","INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[_loc6_,this.api.lang.getText("CRITICAL_MISS")]);
            if(_loc6_ == this.api.datacenter.Player.ID)
            {
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_OWNER);
            }
            else
            {
               var _loc180_ = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team;
               var _loc181_ = this.api.datacenter.Sprites.getItemAt(_global.parseInt(_loc6_)).Team;
               if(_loc180_ == _loc181_)
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ALLIED);
               }
               else
               {
                  this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_EC_ENEMY);
               }
            }
         case 306:
            var _loc182_ = _loc7_.split(",");
            var _loc183_ = Number(_loc182_[0]);
            var _loc184_ = Number(_loc182_[1]);
            var _loc185_ = _loc182_[2];
            var _loc186_ = Number(_loc182_[3]);
            var _loc187_ = _loc182_[4] != "1"?false:true;
            var _loc188_ = Number(_loc182_[5]);
            var _loc189_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc190_ = this.api.datacenter.Sprites.getItemAt(_loc188_);
            var _loc191_ = new ank.battlefield.datacenter.VisualEffect();
            _loc191_.id = _loc183_;
            _loc191_.file = dofus.Constants.SPELLS_PATH + _loc185_ + ".swf";
            _loc191_.level = _loc186_;
            _loc191_.bInFrontOfSprite = _loc187_;
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_TRAP",[_loc189_.name,this.api.lang.getSpellText(_loc191_.id).n,_loc190_.name]),"INFO_FIGHT_CHAT"]);
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.addVisualEffectOnSprite,[_loc188_,_loc191_,_loc184_,11],1000);
         case 307:
            var _loc192_ = _loc7_.split(",");
            var _loc193_ = Number(_loc192_[0]);
            var _loc194_ = Number(_loc192_[1]);
            var _loc195_ = Number(_loc192_[3]);
            var _loc196_ = Number(_loc192_[5]);
            var _loc197_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc198_ = this.api.datacenter.Sprites.getItemAt(_loc196_);
            var _loc199_ = new dofus.datacenter.Spell(_loc193_,_loc195_);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_START_GLIPH",[_loc197_.name,_loc199_.name,_loc198_.name]),"INFO_FIGHT_CHAT"]);
         case 308:
            var _loc200_ = _loc7_.split(",");
            var _loc201_ = this.api.datacenter.Sprites.getItemAt(Number(_loc200_[0]));
            var _loc202_ = Number(_loc200_[1]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_AP",[_loc201_.name,_loc202_]),"INFO_FIGHT_CHAT"]);
         case 309:
            var _loc203_ = _loc7_.split(",");
            var _loc204_ = this.api.datacenter.Sprites.getItemAt(Number(_loc203_[0]));
            var _loc205_ = Number(_loc203_[1]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,this.api.lang.getText("HAS_DODGE_MP",[_loc204_.name,_loc205_]),"INFO_FIGHT_CHAT"]);
         case 501:
            var _loc206_ = _loc7_.split(",");
            var _loc207_ = _loc206_[0];
            var _loc208_ = Number(_loc206_[1]);
            var _loc209_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc210_ = _loc206_[2] != undefined?"anim" + _loc206_[2]:_loc209_.ToolAnimation;
            _loc11_.addAction(false,this.api.gfx,this.api.gfx.autoCalculateSpriteDirection,[_loc6_,_loc207_]);
            _loc11_.addAction(_loc6_ == this.api.datacenter.Player.ID,this.api.gfx,this.api.gfx.setSpriteLoopAnim,[_loc6_,_loc210_,_loc208_],_loc208_);
         case 617:
            _loc13_ = false;
            var _loc211_ = _loc7_.split(",");
            var _loc212_ = this.api.datacenter.Sprites.getItemAt(Number(_loc211_[0]));
            var _loc213_ = this.api.datacenter.Sprites.getItemAt(Number(_loc211_[1]));
            var _loc214_ = _loc211_[2];
            this.api.gfx.addSpriteBubble(_loc214_,this.api.lang.getText("A_ASK_MARRIAGE_B",[_loc212_.name,_loc213_.name]));
            if(_loc212_.id == this.api.datacenter.Player.ID)
            {
               this.api.kernel.showMessage(this.api.lang.getText("MARRIAGE"),this.api.lang.getText("A_ASK_MARRIAGE_B",[_loc212_.name,_loc213_.name]),"CAUTION_YESNO",{name:"Marriage",listener:this,params:{spriteID:_loc212_.id,refID:_loc6_}});
            }
         case 618:
         case 619:
            _loc13_ = false;
            var _loc215_ = _loc7_.split(",");
            var _loc216_ = this.api.datacenter.Sprites.getItemAt(Number(_loc215_[0]));
            var _loc217_ = this.api.datacenter.Sprites.getItemAt(Number(_loc215_[1]));
            var _loc218_ = _loc215_[2];
            var _loc219_ = _loc5_ != 618?"A_NOT_MARRIED_B":"A_MARRIED_B";
            this.api.gfx.addSpriteBubble(_loc218_,this.api.lang.getText(_loc219_,[_loc216_.name,_loc217_.name]));
         case 900:
            _loc13_ = false;
            var _loc220_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc221_ = this.api.datacenter.Sprites.getItemAt(Number(_loc7_));
            if(_loc220_ == undefined || (_loc221_ == undefined || (this.api.ui.getUIComponent("AskCancelChallenge") != undefined || this.api.ui.getUIComponent("AskYesNoIgnoreChallenge") != undefined)))
            {
               this.refuseChallenge(_loc6_);
               return undefined;
            }
            this.api.kernel.showMessage(undefined,this.api.lang.getText("A_CHALENGE_B",[this.api.kernel.ChatManager.getLinkName(_loc220_.name),this.api.kernel.ChatManager.getLinkName(_loc221_.name)]),"INFO_CHAT");
            if(_loc220_.id == this.api.datacenter.Player.ID)
            {
               this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("YOU_CHALENGE_B",[_loc221_.name]),"INFO_CANCEL",{name:"Challenge",listener:this,params:{spriteID:_loc220_.id}});
            }
            if(_loc221_.id == this.api.datacenter.Player.ID)
            {
               if(this.api.kernel.ChatManager.isBlacklisted(_loc220_.name))
               {
                  this.refuseChallenge(_loc220_.id);
                  return undefined;
               }
               this.api.electron.makeNotification(this.api.lang.getText("A_CHALENGE_YOU",[_loc220_.name]));
               this.api.kernel.showMessage(this.api.lang.getText("CHALENGE"),this.api.lang.getText("A_CHALENGE_YOU",[_loc220_.name]),"CAUTION_YESNOIGNORE",{name:"Challenge",player:_loc220_.name,listener:this,params:{spriteID:_loc220_.id,player:_loc220_.name}});
               this.api.sounds.events.onGameInvitation();
            }
         case 901:
            _loc13_ = false;
            if(_loc6_ == this.api.datacenter.Player.ID || Number(_loc7_) == this.api.datacenter.Player.ID)
            {
               this.api.ui.unloadUIComponent("AskCancelChallenge");
            }
         case 902:
            _loc13_ = false;
            this.api.ui.unloadUIComponent("AskYesNoIgnoreChallenge");
            this.api.ui.unloadUIComponent("AskCancelChallenge");
         case 903:
            _loc13_ = false;
            switch(_loc7_)
            {
               case "c":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CHALENGE_FULL"),"ERROR_CHAT");
                  break;
               case "t":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("TEAM_FULL"),"ERROR_CHAT");
                  break;
               case "a":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("TEAM_DIFFERENT_ALIGNMENT"),"ERROR_CHAT");
                  break;
               case "g":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_BECAUSE_GUILD"),"ERROR_CHAT");
                  break;
               case "l":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_TOO_LATE"),"ERROR_CHAT");
                  break;
               case "m":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
                  break;
               case "p":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BECAUSE_MAP"),"ERROR_CHAT");
                  break;
               case "r":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BECAUSE_ON_RESPAWN"),"ERROR_CHAT");
                  break;
               case "o":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_YOU_R_OCCUPED"),"ERROR_CHAT");
                  break;
               case "z":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_YOU_OPPONENT_OCCUPED"),"ERROR_CHAT");
                  break;
               case "h":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIGHT"),"ERROR_CHAT");
                  break;
               case "i":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIGHT_NO_RIGHTS"),"ERROR_CHAT");
                  break;
               case "s":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_21"),"ERROR_CHAT");
                  break;
               case "n":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("SUBSCRIPTION_OUT"),"ERROR_CHAT");
                  break;
               case "b":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("A_NOT_SUBSCRIB"),"ERROR_CHAT");
                  break;
               case "f":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("TEAM_CLOSED"),"ERROR_CHAT");
                  break;
               case "d":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("NO_ZOMBIE_ALLOWED"),"ERROR_CHAT");
            }
         case 905:
            this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("YOU_ARE_ATTAC"),background:true,timer:2000},{bForceLoad:true});
         case 906:
            var _loc222_ = _loc7_;
            var _loc223_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc224_ = this.api.datacenter.Sprites.getItemAt(_loc222_);
            this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[_loc223_.name,_loc224_.name]),"INFO_CHAT");
            if(_loc222_ == this.api.datacenter.Player.ID)
            {
               this.api.electron.makeNotification(this.api.lang.getText("A_ATTACK_B",[_loc223_.name,_loc224_.name]));
               this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("YOU_ARE_ATTAC"),background:true,timer:2000},{bForceLoad:true});
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESSED);
            }
            else
            {
               this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_AGRESS);
            }
         case 909:
            var _loc225_ = _loc7_;
            var _loc226_ = this.api.datacenter.Sprites.getItemAt(_loc6_);
            var _loc227_ = this.api.datacenter.Sprites.getItemAt(_loc225_);
            this.api.kernel.showMessage(undefined,this.api.lang.getText("A_ATTACK_B",[_loc226_.name,_loc227_.name]),"INFO_CHAT");
         case 950:
            var _loc228_ = _loc7_.split(",");
            var _loc229_ = _loc228_[0];
            var _loc230_ = this.api.datacenter.Sprites.getItemAt(_loc229_);
            var _loc231_ = Number(_loc228_[1]);
            var _loc232_ = Number(_loc228_[2]) != 1?false:true;
            if(_loc231_ == 8 && !_loc232_)
            {
               this.api.gfx.uncarriedSprite(_loc6_,_loc230_._oData.cellNum,true,_loc11_);
            }
            _loc11_.addAction(false,_loc230_,_loc230_.setState,[_loc231_,_loc232_]);
            var _loc233_ = this.api.lang.getText(!_loc232_?"EXIT_STATE":"ENTER_STATE",[_loc230_.name,this.api.lang.getStateText(_loc231_)]);
            _loc11_.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,_loc233_,"INFO_FIGHT_CHAT"]);
         case 998:
            var _loc234_ = sExtraData.split(",");
            var _loc235_ = _loc234_[0];
            var _loc236_ = _loc234_[0];
            var _loc237_ = _loc234_[2];
            var _loc238_ = _loc234_[3];
            var _loc239_ = _loc234_[4];
            var _loc240_ = _loc234_[6];
            var _loc241_ = _loc234_[7];
            var _loc242_ = new dofus.datacenter.Effect(Number(_loc236_),Number(_loc237_),Number(_loc238_),Number(_loc239_),"",Number(_loc240_),Number(_loc241_));
            var _loc243_ = this.api.datacenter.Sprites.getItemAt(_loc235_);
            _loc243_.EffectsManager.addEffect(_loc242_);
         case 999:
            _loc11_.addAction(false,this.aks,this.aks.processCommand,[_loc7_]);
         default:
            if(!_global.isNaN(_loc4_) && _loc6_ == this.api.datacenter.Player.ID)
            {
               _loc11_.addAction(false,_loc12_,_loc12_.ack,[_loc4_]);
            }
            else
            {
               _loc12_.end(_loc8_ == this.api.datacenter.Player.ID);
            }
            if(!_loc11_.isPlaying() && _loc13_)
            {
               _loc11_.execute(true);
            }
      }
   }
   function cancel(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskCancelChallenge")
      {
         this.refuseChallenge(oEvent.params.spriteID);
      }
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoIgnoreChallenge":
            this.acceptChallenge(oEvent.params.spriteID);
            break;
         case "AskYesNoMarriage":
            this.acceptMarriage(oEvent.params.refID);
            this.api.gfx.addSpriteBubble(oEvent.params.spriteID,this.api.lang.getText("YES"));
      }
   }
   function no(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoIgnoreChallenge":
            this.refuseChallenge(oEvent.params.spriteID);
            break;
         case "AskYesNoMarriage":
            this.refuseMarriage(oEvent.params.refID);
            this.api.gfx.addSpriteBubble(oEvent.params.spriteID,this.api.lang.getText("NO"));
      }
   }
   function ignore(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoIgnoreChallenge")
      {
         this.api.kernel.ChatManager.addToBlacklist(oEvent.params.player);
         this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[oEvent.params.player]),"INFO_CHAT");
         this.refuseChallenge(oEvent.params.spriteID);
      }
   }
}
