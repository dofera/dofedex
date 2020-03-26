class dofus.managers.TutorialManager extends dofus.utils.ApiElement
{
   var _bInTutorialMode = false;
   static var _sSelf = null;
   function TutorialManager(oAPI)
   {
      super();
      dofus.managers.TutorialManager._sSelf = this;
      this.initialize(oAPI);
   }
   function __get__isTutorialMode()
   {
      return this._bInTutorialMode;
   }
   function __get__vars()
   {
      var _loc2_ = new String();
      for(var k in this._oVars)
      {
         _loc2_ = _loc2_ + (k + ":" + this._oVars[k] + "\n");
      }
      return _loc2_;
   }
   static function getInstance()
   {
      return dofus.managers.TutorialManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      this._oSequencer = new ank.utils.Sequencer();
   }
   function clear()
   {
      this._bInTutorialMode = false;
      ank.utils.Timer.removeTimer(this,"tutorial");
      this._oVars = new Object();
   }
   function start(oTutorial)
   {
      this._bInTutorialMode = true;
      this._oVars = new Object();
      this._oTutorial = oTutorial;
      var _loc3_ = oTutorial.getRootBloc();
      this.executeBloc(_loc3_);
      if(this._oTutorial.canCancel)
      {
         this.api.ui.loadUIComponent("Tutorial","Tutorial");
      }
   }
   function cancel()
   {
      var _loc2_ = this._oTutorial.getRootExitBloc();
      if(_loc2_ == undefined)
      {
         this.terminate(0);
      }
      else
      {
         this.executeBloc(_loc2_);
      }
   }
   function terminate(nActionListID)
   {
      this.clear();
      var _loc3_ = this.api.datacenter.Player.data.cellNum;
      var _loc4_ = this.api.datacenter.Player.data.direction;
      this.api.network.Tutorial.end(nActionListID,_loc3_,_loc4_);
      this.api.ui.unloadUIComponent("Tutorial");
   }
   function executeBloc(oBloc)
   {
      ank.utils.Timer.removeTimer(this,"tutorial");
      for(var i in oBloc.params)
      {
         if(typeof oBloc.params[i] == "string")
         {
            var _loc3_ = String(oBloc.params[i]);
            if(_loc3_.substr(0,16) == "!LOCALIZEDSTRING" && _loc3_.substr(_loc3_.length - 1,1) == "!")
            {
               var _loc4_ = Number(_loc3_.substring(16,_loc3_.length - 1));
               if(!_global.isNaN(_loc4_))
               {
                  oBloc.params[i] = this.api.lang.getTutorialText(_loc4_);
               }
            }
         }
         else if(typeof oBloc.params[i] == "object")
         {
            for(var s in oBloc.params[i])
            {
               if(typeof oBloc.params[i][s] == "string")
               {
                  var _loc5_ = String(oBloc.params[i][s]);
                  if(_loc5_.substr(0,16) == "!LOCALIZEDSTRING" && _loc5_.substr(_loc5_.length - 1,1) == "!")
                  {
                     var _loc6_ = Number(_loc5_.substring(16,_loc5_.length - 1));
                     if(!_global.isNaN(_loc6_))
                     {
                        oBloc.params[i][s] = this.api.lang.getTutorialText(_loc6_);
                     }
                  }
               }
            }
         }
      }
      switch(oBloc.type)
      {
         case dofus.datacenter.TutorialBloc.TYPE_ACTION:
            if(!(oBloc instanceof dofus.datacenter.TutorialAction))
            {
               ank.utils.Logger.err("[executeBloc] le type ne correspond pas");
               return undefined;
            }
            if(!oBloc.keepLastWaitingBloc)
            {
               delete this._oCurrentWaitingBloc;
            }
            switch(oBloc.actionCode)
            {
               case "VAR_ADD":
                  this._oSequencer.addAction(false,this,this.addToVariable,oBloc.params);
                  break;
               case "VAR_SET":
                  this._oSequencer.addAction(false,this,this.setToVariable,oBloc.params);
                  break;
               case "CHAT":
                  this._oSequencer.addAction(false,this.api.kernel,this.api.kernel.showMessage,[undefined,oBloc.params[0],oBloc.params[1]]);
                  break;
               case "GFX_CLEAN_MAP":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.cleanMap,[undefined,true]);
                  break;
               case "GFX_SELECT":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.select,[oBloc.params[0],oBloc.params[1]]);
                  break;
               case "GFX_UNSELECT":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.unSelect,[oBloc.params[0],oBloc.params[1]]);
                  break;
               case "GFX_ALPHA":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpriteAlpha,[oBloc.params[0],oBloc.params[1]]);
                  break;
               case "GFX_GRID":
                  if(oBloc.params[0] == true)
                  {
                     this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.drawGrid,[false]);
                  }
                  else
                  {
                     this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.removeGrid,[]);
                  }
                  break;
               case "GFX_ADD_INDICATOR":
                  var _loc7_ = this.api.gfx.mapHandler.getCellData(oBloc.params[0]).mc;
                  if(_loc7_ == undefined)
                  {
                     ank.utils.Logger.err("[GFX_ADD_INDICATOR] la cellule n\'existe pas");
                     break;
                  }
                  var _loc8_ = {x:_loc7_._x,y:_loc7_._y};
                  _loc7_._parent.localToGlobal(_loc8_);
                  var _loc9_ = _loc8_.x;
                  var _loc10_ = _loc8_.y;
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIComponent,["Indicator","Indicator",{coordinates:[_loc9_,_loc10_],offset:oBloc.params[1],rotate:false},{bAlwaysOnTop:true}]);
                  break;
               case "GFX_ADD_PLAYER_SPRITE":
                  var _loc11_ = this.api.datacenter.Player.data;
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addSprite,[_loc11_.id,_loc11_]);
                  break;
               case "GFX_ADD_SPRITE":
                  var _loc12_ = new dofus.datacenter.PlayableCharacter(oBloc.params[0],ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + oBloc.params[1] + ".swf",oBloc.params[2],oBloc.params[3],oBloc.params[1]);
                  _loc12_.name = oBloc.params[4] != undefined?oBloc.params[4]:"";
                  _loc12_.color1 = oBloc.params[5] != undefined?oBloc.params[5]:-1;
                  _loc12_.color2 = oBloc.params[6] != undefined?oBloc.params[6]:-1;
                  _loc12_.color3 = oBloc.params[7] != undefined?oBloc.params[7]:-1;
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addSprite,[_loc12_.id,_loc12_]);
                  break;
               case "GFX_REMOVE_SPRITE":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.removeSprite,[oBloc.params[0],false]);
                  break;
               case "GFX_MOVE_SPRITE":
                  var _loc13_ = this.getSpriteIDFromData(oBloc.params[0]);
                  var _loc14_ = this.api.datacenter.Sprites.getItemAt(_loc13_);
                  var _loc15_ = ank.battlefield.utils.Pathfinding.pathFind(this.api.gfx.mapHandler,_loc14_.cellNum,oBloc.params[1],{bAllDirections:false,bIgnoreSprites:true,bCellNumOnly:true,bWithBeginCellNum:true});
                  if(_loc15_ != null)
                  {
                     this.api.gfx.spriteHandler.moveSprite(_loc14_.id,_loc15_,this._oSequencer,false,undefined,false,false);
                  }
                  break;
               case "GFX_ADD_SPRITE_BUBBLE":
                  var _loc16_ = this.getSpriteIDFromData(oBloc.params[0]);
                  this._oSequencer.addAction(true,this.api.gfx,this.api.gfx.removeSpriteBubble,[_loc16_],200);
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addSpriteBubble,[_loc16_,oBloc.params[1]]);
                  break;
               case "GFX_CLEAR_SPRITE_BUBBLES":
                  this._oSequencer.addAction(false,this.api.gfx.textHandler,this.api.gfx.textHandler.clear,[]);
                  break;
               case "GFX_SPRITE_DIR":
                  var _loc17_ = this.getSpriteIDFromData(oBloc.params[0]);
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpriteDirection,[_loc17_,oBloc.params[1]]);
                  break;
               case "GFX_SPRITE_POS":
                  var _loc18_ = this.getSpriteIDFromData(oBloc.params[0]);
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpritePosition,[_loc18_,oBloc.params[1]]);
                  break;
               case "GFX_SPRITE_VISUALEFFECT":
                  var _loc19_ = this.getSpriteIDFromData(oBloc.params[0]);
                  var _loc20_ = new ank.battlefield.datacenter.VisualEffect();
                  _loc20_.file = dofus.Constants.SPELLS_PATH + oBloc.params[1] + ".swf";
                  _loc20_.level = !_global.isNaN(Number(oBloc.params[3]))?Number(oBloc.params[3]):1;
                  _loc20_.bInFrontOfSprite = true;
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addVisualEffectOnSprite,[_loc19_,_loc20_,oBloc.params[2],oBloc.params[4]]);
                  break;
               case "GFX_SPRITE_ANIM":
                  var _loc21_ = this.getSpriteIDFromData(oBloc.params[0]);
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setSpriteAnim,[_loc21_,oBloc.params[1]]);
                  break;
               case "GFX_SPRITE_EXEC_FUNCTION":
                  var _loc22_ = this.getSpriteIDFromData(oBloc.params[0]);
                  var _loc23_ = this.api.datacenter.Sprites.getItemAt(_loc22_);
                  var _loc24_ = _loc23_[oBloc.params[1]];
                  if(typeof _loc24_ != "function")
                  {
                     ank.utils.Logger.err("[GFX_SPRITE_EXEC_FUNCTION] la fonction n\'existe pas");
                     break;
                  }
                  this._oSequencer.addAction(false,_loc23_,_loc24_,oBloc.params[2]);
                  break;
               case "GFX_SPRITE_SET_PROPERTY":
                  var _loc25_ = this.getSpriteIDFromData(oBloc.params[0]);
                  var _loc26_ = this.api.datacenter.Sprites.getItemAt(_loc25_);
                  this._oSequencer.addAction(false,this,this.setObjectPropertyValue,[_loc26_,oBloc.params[1],oBloc.params[2]]);
                  break;
               case "GFX_DRAW_ZONE":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.drawZone,oBloc.params);
                  break;
               case "GFX_CLEAR_ALL_ZONES":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.clearAllZones,[]);
                  break;
               case "GFX_ADD_POINTER_SHAPE":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.addPointerShape,oBloc.params);
                  break;
               case "GFX_CLEAR_POINTER":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.clearPointer,[]);
                  break;
               case "GFX_HIDE_POINTER":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.hidePointer,[]);
                  break;
               case "GFX_DRAW_POINTER":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.drawPointer,oBloc.params);
                  break;
               case "GFX_OBJECT2_INTERACTIVE":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setObject2Interactive,[oBloc.params[0],oBloc.params[1],1]);
                  break;
               case "INTERAC_SET":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setInteraction,[ank.battlefield.Constants[oBloc.params[0]]]);
                  break;
               case "INTERAC_SET_ONCELLS":
                  this._oSequencer.addAction(false,this.api.gfx,this.api.gfx.setInteractionOnCells,[oBloc.params[0],ank.battlefield.Constants[oBloc.params[1]]]);
                  break;
               case "UI_ADD_INDICATOR":
                  var _loc27_ = this.api.ui.getUIComponent(oBloc.params[0]);
                  var _loc28_ = eval(_loc27_ + "." + oBloc.params[1]);
                  var _loc29_ = _loc28_.getBounds();
                  var _loc30_ = _loc29_.xMax - _loc29_.xMin;
                  var _loc31_ = _loc29_.yMax - _loc29_.yMin;
                  var _loc32_ = _loc30_ / 2 + _loc28_._x + _loc29_.xMin;
                  var _loc33_ = _loc31_ / 2 + _loc28_._y + _loc29_.yMin;
                  var _loc34_ = {x:_loc32_,y:_loc33_};
                  _loc28_._parent.localToGlobal(_loc34_);
                  _loc32_ = _loc34_.x;
                  _loc33_ = _loc34_.y;
                  var _loc35_ = Math.sqrt(Math.pow(_loc30_,2) + Math.pow(_loc31_,2)) / 2;
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIComponent,["Indicator","Indicator",{coordinates:[_loc32_,_loc33_],offset:_loc35_},{bAlwaysOnTop:true}]);
                  break;
               case "UI_REMOVE_INDICATOR":
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,["Indicator"]);
                  break;
               case "UI_OPEN":
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIComponent,[oBloc.params[0],oBloc.params[0],oBloc.params[1],oBloc.params[2]]);
                  break;
               case "UI_OPEN_AUTOHIDE":
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.loadUIAutoHideComponent,[oBloc.params[0],oBloc.params[0],oBloc.params[1],oBloc.params[2]]);
                  break;
               case "UI_CLOSE":
                  this._oSequencer.addAction(false,this.api.ui,this.api.ui.unloadUIComponent,[oBloc.params[0]]);
                  break;
               case "UI_EXEC_FUNCTION":
                  var _loc36_ = this.api.ui.getUIComponent(oBloc.params[0]);
                  var _loc37_ = _loc36_[oBloc.params[1]];
                  if(typeof _loc37_ != "function")
                  {
                     ank.utils.Logger.err("[UI_EXEC_FUNCTION] la fonction n\'existe pas");
                     break;
                  }
                  this._oSequencer.addAction(false,_loc36_,_loc37_,oBloc.params[2]);
                  break;
               case "ADD_SPELL":
                  var _loc38_ = new dofus.datacenter.Spell(oBloc.params[0],oBloc.params[1],oBloc.params[2]);
                  this._oSequencer.addAction(false,this.api.datacenter.Player,this.api.datacenter.Player.updateSpellPosition,[_loc38_]);
                  break;
               case "SET_SPELLS":
                  this._oSequencer.addAction(false,this.api.network.Spells,this.api.network.Spells.onList,[oBloc.params.join(";")]);
                  break;
               case "REMOVE_SPELL":
                  this._oSequencer.addAction(false,this.api.datacenter.Player,this.api.datacenter.Player.removeSpell,oBloc.params);
                  break;
               case "END":
                  this._oSequencer.addAction(false,this,this.terminate,oBloc.params);
                  if(!this._oSequencer.isPlaying())
                  {
                     this._oSequencer.execute(true);
                  }
                  return undefined;
                  break;
               default:
                  ank.utils.Logger.err("[executeBloc] Code action " + oBloc.actionCode + " inconnu");
                  return undefined;
            }
            this._oSequencer.addAction(false,this,this.callNextBloc,[oBloc.nextBlocID]);
            if(!this._oSequencer.isPlaying())
            {
               this._oSequencer.execute(true);
            }
            break;
         case dofus.datacenter.TutorialBloc.TYPE_WAITING:
            this._oCurrentWaitingBloc = oBloc;
            if(!(oBloc instanceof dofus.datacenter.TutorialWaiting))
            {
               ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
               return undefined;
            }
            ank.utils.Timer.removeTimer(this,"tutorial");
            if(oBloc.timeout != 0)
            {
               ank.utils.Timer.setTimer(this,"tutorial",this,this.onWaitingTimeout,oBloc.timeout,[oBloc]);
            }
            break;
         case dofus.datacenter.TutorialBloc.TYPE_IF:
            if(!(oBloc instanceof dofus.datacenter.TutorialIf))
            {
               ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
               return undefined;
            }
            var _loc39_ = this.extractValue(oBloc.left);
            var _loc40_ = this.extractValue(oBloc.right);
            var _loc41_ = false;
            switch(oBloc.operator)
            {
               case "=":
                  _loc41_ = _loc39_ == _loc40_;
                  break;
               case "<":
                  _loc41_ = _loc39_ < _loc40_;
                  break;
               case ">":
                  _loc41_ = _loc39_ > _loc40_;
            }
            if(_loc41_)
            {
               this._oSequencer.addAction(false,this,this.callNextBloc,[oBloc.nextBlocTrueID]);
            }
            else
            {
               this._oSequencer.addAction(false,this,this.callNextBloc,[oBloc.nextBlocFalseID]);
            }
            if(!this._oSequencer.isPlaying())
            {
               this._oSequencer.execute(true);
            }
            break;
         default:
            ank.utils.Logger.log("[executeBloc] mauvais type");
      }
   }
   function callNextBloc(mNextBlocID)
   {
      ank.utils.Timer.removeTimer(this,"tutorial");
      if(typeof mNextBlocID == "object")
      {
         var _loc3_ = mNextBlocID[random(mNextBlocID.length)];
      }
      else
      {
         _loc3_ = mNextBlocID;
      }
      this.addToQueue({object:this,method:this.executeBloc,params:[this._oTutorial.getBloc(_loc3_)]});
   }
   function callCurrentBlocDefaultCase()
   {
      var _loc2_ = this._oCurrentWaitingBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_DEFAULT];
      if(_loc2_ != undefined)
      {
         this.callNextBloc(_loc2_.nextBlocID);
      }
   }
   function setObjectPropertyValue(oObject, sProperty, mValue)
   {
      if(oObject == undefined)
      {
         ank.utils.Logger.err("[setObjectPropertyValue] l\'objet n\'existe pas");
         return undefined;
      }
      oObject[sProperty] = mValue;
   }
   function getSpriteIDFromData(mIDorCellNum)
   {
      if(typeof mIDorCellNum == "number")
      {
         return mIDorCellNum != 0?mIDorCellNum:this.api.datacenter.Player.ID;
      }
      if(typeof mIDorCellNum == "string")
      {
         return this.api.datacenter.Map.data[mIDorCellNum.substr(1)].spriteOnID;
      }
   }
   function setToVariable(sVarName, nValue)
   {
      sVarName = this.extractVarName(sVarName);
      this._oVars[sVarName] = nValue;
   }
   function addToVariable(sVarName, nValue)
   {
      sVarName = this.extractVarName(sVarName);
      if(this._oVars[sVarName] == undefined)
      {
         this._oVars[sVarName] = nValue;
      }
      else
      {
         this._oVars[sVarName] = this._oVars[sVarName] + nValue;
      }
   }
   function extractVarName(sVarName)
   {
      var _loc3_ = sVarName.split("|");
      if(_loc3_.length != 0)
      {
         sVarName = _loc3_[0];
         var _loc4_ = 1;
         while(_loc4_ < _loc3_.length)
         {
            sVarName = sVarName + ("_" + this._oVars[_loc3_[_loc4_]]);
            _loc4_ = _loc4_ + 1;
         }
      }
      return sVarName;
   }
   function extractValue(mVarOrValue)
   {
      if(typeof mVarOrValue == "string")
      {
         return this._oVars[this.extractVarName(mVarOrValue)];
      }
      return mVarOrValue;
   }
   function onWaitingTimeout(oBloc)
   {
      this.callNextBloc(oBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_TIMEOUT].nextBlocID);
   }
   function onWaitingCase(oEvent)
   {
      var _loc3_ = oEvent.code;
      var _loc4_ = oEvent.params;
      var _loc5_ = this._oCurrentWaitingBloc.cases[_loc3_];
      if(_loc5_ != undefined)
      {
         switch(_loc5_.code)
         {
            case "CELL_RELEASE":
            case "CELL_OVER":
            case "CELL_OUT":
            case "SPRITE_RELEASE":
            case "SPELL_CONTAINER_SELECT":
            case "OBJECT_CONTAINER_SELECT":
               var _loc6_ = 0;
               while(_loc6_ < _loc5_.params.length)
               {
                  if(_loc4_[0] == _loc5_.params[_loc6_][0])
                  {
                     this.callNextBloc(_loc5_.nextBlocID[_loc6_] != undefined?_loc5_.nextBlocID[_loc6_]:_loc5_.nextBlocID);
                     return undefined;
                  }
                  _loc6_ = _loc6_ + 1;
               }
               break;
            case "OBJECT_RELEASE":
               var _loc7_ = 0;
               while(_loc7_ < _loc5_.params.length)
               {
                  if(_loc4_[0] == _loc5_.params[_loc7_][0] && _loc4_[1] == _loc5_.params[_loc7_][1])
                  {
                     this.callNextBloc(_loc5_.nextBlocID[_loc7_] != undefined?_loc5_.nextBlocID[_loc7_]:_loc5_.nextBlocID);
                     return undefined;
                  }
                  _loc7_ = _loc7_ + 1;
               }
               break;
            default:
               this.callNextBloc(_loc5_.nextBlocID);
               return undefined;
         }
         this.callCurrentBlocDefaultCase();
      }
      else
      {
         this.callCurrentBlocDefaultCase();
      }
   }
}
