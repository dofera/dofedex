class dofus.utils.consoleParsers.DebugConsoleParser extends dofus.utils.consoleParsers.AbstractConsoleParser
{
   function DebugConsoleParser(oAPI)
   {
      super();
      this.initialize(oAPI);
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
   }
   function process(sCmd)
   {
      super.process(sCmd);
      if(sCmd.charAt(0) == "/")
      {
         var _loc4_ = sCmd.split(" ");
         var _loc5_ = _loc4_[0].substr(1).toUpperCase();
         _loc4_.splice(0,1);
         switch(_loc5_)
         {
            case "TOGGLESPRITES":
               this.api.datacenter.Basics.gfx_isSpritesHidden = !this.api.datacenter.Basics.gfx_isSpritesHidden;
               if(this.api.datacenter.Basics.gfx_isSpritesHidden)
               {
                  this.api.gfx.spriteHandler.maskAllSprites();
               }
               else
               {
                  this.api.gfx.spriteHandler.unmaskAllSprites();
               }
               break;
            case "INFOS":
               var _loc6_ = "Svr:";
               _loc6_ = _loc6_ + "\nNb:";
               _loc6_ = _loc6_ + ("\n Map  : " + String(this.api.datacenter.Game.playerCount));
               _loc6_ = _loc6_ + ("\n Cell : " + this.api.datacenter.Map.data[this.api.datacenter.Player.data.cellNum].spriteOnCount);
               _loc6_ = _loc6_ + "\nDataServers:";
               var _loc7_ = 0;
               while(_loc7_ < this.api.config.dataServers.length)
               {
                  _loc6_ = _loc6_ + ("\n host : " + this.api.config.dataServers[_loc7_].url);
                  _loc7_ = _loc7_ + 1;
               }
               _loc6_ = _loc6_ + ("\n l   : " + this.api.config.language + " (" + this.api.lang.getLangVersion() + " & " + this.api.lang.getXtraVersion() + ")");
               this.api.kernel.showMessage(undefined,_loc6_,"DEBUG_LOG");
               break;
            case "ZOOM":
               this.api.kernel.GameManager.zoomGfx(_loc4_[0],_loc4_[1],_loc4_[2]);
               break;
            case "TIMERSCOUNT":
               this.api.kernel.showMessage(undefined,String(ank.utils.Timer.getTimersCount()),"DEBUG_LOG");
               break;
            case "VARS":
               this.api.kernel.showMessage(undefined,this.api.kernel.TutorialManager.vars,"DEBUG_LOG");
               break;
            case "MOUNT":
               var _loc8_ = this.api.gfx.getSprite(this.api.datacenter.Player.ID);
               if(!_loc8_.isMounting)
               {
                  var _loc9_ = _loc4_[0] == undefined?"7002.swf":_loc4_[0] + ".swf";
                  var _loc10_ = _loc4_[1] == undefined?"10.swf":_loc4_[1] + ".swf";
                  var _loc11_ = new ank.battlefield.datacenter.Mount(dofus.Constants.CLIPS_PERSOS_PATH + _loc9_,dofus.Constants.CHEVAUCHOR_PATH + _loc10_);
                  this.api.gfx.mountSprite(this.api.datacenter.Player.ID,_loc11_);
               }
               else
               {
                  this.api.gfx.unmountSprite(this.api.datacenter.Player.ID);
               }
               break;
            case "SCALE":
               this.api.gfx.setSpriteScale(this.api.datacenter.Player.ID,_loc4_[0],_loc4_.length != 2?_loc4_[0]:_loc4_[1]);
               break;
            case "ANIM":
               if(dofus.Constants.DEBUG)
               {
                  if(_loc4_.length > 1)
                  {
                     this.api.gfx.setSpriteLoopAnim(this.api.datacenter.Player.ID,_loc4_[0],_loc4_[1]);
                  }
                  else
                  {
                     this.api.gfx.setSpriteAnim(this.api.datacenter.Player.ID,_loc4_.join(""));
                  }
               }
               break;
            case "C":
               if(dofus.Constants.DEBUG)
               {
                  var _loc12_ = _loc4_[0];
                  _loc4_.splice(0,1);
                  switch(_loc12_)
                  {
                     case ">":
                        this.api.network.send(_loc4_.join(" "));
                        break;
                     case "<":
                        this.api.network.processCommand(_loc4_.join(" "));
                  }
               }
               break;
            case "D":
               if(dofus.Constants.DEBUG)
               {
                  var _loc13_ = _loc4_[0];
                  _loc4_.splice(0,1);
                  switch(_loc13_)
                  {
                     case ">":
                        this.api.network.send(_loc4_.join(" "),false,undefined,false,true);
                        break;
                     case "<":
                        this.api.network.processCommand(_loc4_.join(" "));
                  }
               }
               break;
            case "LOGDISCO":
               if(_loc4_[0] == "1")
               {
                  this.api.datacenter.Game.isLoggingMapDisconnections = true;
               }
               else if(_loc4_[0] == "0")
               {
                  this.api.datacenter.Game.isLoggingMapDisconnections = false;
               }
               else
               {
                  this.api.datacenter.Game.isLoggingMapDisconnections = !this.api.datacenter.Game.isLoggingMapDisconnections;
               }
               this.api.kernel.showMessage(undefined,"LOG DISCONNECTIONS ON MAP : " + this.api.datacenter.Game.isLoggingMapDisconnections,"DEBUG_LOG");
               break;
            case "PING":
               this.api.network.ping();
               break;
            case "MAPID":
               this.api.kernel.showMessage(undefined,"carte : " + this.api.datacenter.Map.id,"DEBUG_LOG");
               this.api.kernel.showMessage(undefined,"Area : " + this.api.datacenter.Map.area,"DEBUG_LOG");
               this.api.kernel.showMessage(undefined,"Sub area : " + this.api.datacenter.Map.subarea,"DEBUG_LOG");
               this.api.kernel.showMessage(undefined,"Super Area : " + this.api.datacenter.Map.superarea,"DEBUG_LOG");
               break;
            case "CELLID":
               this.api.kernel.showMessage(undefined,"cellule : " + this.api.datacenter.Player.data.cellNum,"DEBUG_LOG");
               break;
            case "TIME":
               this.api.kernel.showMessage(undefined,"Heure : " + this.api.kernel.NightManager.time,"DEBUG_LOG");
               break;
            case "CACHE":
               this.api.kernel.askClearCache();
               break;
            case "REBOOT":
               this.api.kernel.reboot();
               break;
            case "FPS":
               this.api.ui.getUIComponent("Debug").showFps();
               break;
            case "UI":
               this.api.ui.loadUIComponent(_loc4_[0],_loc4_[0]);
               break;
            case "DEBUG":
               dofus.Constants.DEBUG = !dofus.Constants.DEBUG;
               this.api.kernel.showMessage(undefined,"DEBUG : " + dofus.Constants.DEBUG,"DEBUG_LOG");
               break;
            case "ASKOK":
               this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:this.api.lang.getText(_loc4_[0],_loc4_.splice(1))});
               break;
            case "ASKOK2":
               var _loc14_ = "";
               var _loc15_ = 0;
               while(_loc15_ < _loc4_.length)
               {
                  if(_loc15_ > 0)
                  {
                     _loc14_ = _loc14_ + " ";
                  }
                  _loc14_ = _loc14_ + _loc4_[_loc15_];
                  _loc15_ = _loc15_ + 1;
               }
               this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:_loc14_});
               break;
            case "MOVIECLIP":
               this.api.kernel.findMovieClipPath();
               break;
            case "LOS":
               var _loc16_ = Number(_loc4_[0]);
               var _loc17_ = Number(_loc4_[1]);
               if(_global.isNaN(_loc16_) || (_loc16_ == undefined || (_global.isNaN(_loc17_) || _loc17_ == undefined)))
               {
                  this.api.kernel.showMessage(undefined,"Unable to resolve case ID","DEBUG_LOG");
                  return undefined;
               }
               this.api.kernel.showMessage(undefined,"Line of sight between " + _loc16_ + " and " + _loc17_ + " -> " + ank.battlefield.utils.Pathfinding.checkView(this.api.gfx.mapHandler,_loc16_,_loc17_),"DEBUG_LOG");
               break;
            case "CLEARCELL":
               var _loc18_ = Number(_loc4_[0]);
               if(_global.isNaN(_loc18_) || _loc18_ == undefined)
               {
                  this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
                  return undefined;
               }
               this.api.gfx.mapHandler.getCellData(_loc18_).removeAllSpritesOnID();
               this.api.kernel.showMessage(undefined,"Cell " + _loc18_ + " cleaned.","DEBUG_LOG");
               break;
            case "CELLINFO":
               var _loc19_ = Number(_loc4_[0]);
               if(_global.isNaN(_loc19_) || _loc19_ == undefined)
               {
                  this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
                  return undefined;
               }
               var _loc20_ = this.api.gfx.mapHandler.getCellData(_loc19_);
               this.api.kernel.showMessage(undefined,"Datas about cell " + _loc19_ + ":","DEBUG_LOG");
               for(var k in _loc20_)
               {
                  this.api.kernel.showMessage(undefined,"    " + k + " -> " + _loc20_[k],"DEBUG_LOG");
                  if(_loc20_[k] instanceof Object)
                  {
                     for(var l in _loc20_[k])
                     {
                        this.api.kernel.showMessage(undefined,"        " + l + " -> " + _loc20_[k][l],"DEBUG_LOG");
                     }
                  }
               }
               break;
            case "LANGFILE":
               this.api.kernel.showMessage(undefined,_loc4_[0] + " lang file size : " + this.api.lang.getLangFileSize(_loc4_[0]) + " octets","DEBUG_LOG");
               break;
            case "POINTSPRITE":
               this.api.kernel.TipsManager.pointSprite(-1,Number(_loc4_[0]));
               break;
            case "LISTSPRITES":
               var _loc21_ = this.api.gfx.spriteHandler.getSprites().getItems();
               for(var k in _loc21_)
               {
                  this.api.kernel.showMessage(undefined,"Sprite " + _loc21_[k].gfxFile,"DEBUG_LOG");
               }
               break;
            case "LISTPICTOS":
               var _loc22_ = this.api.gfx.mapHandler.getCellsData();
               for(var k in _loc22_)
               {
                  if(_loc22_[k].layerObject1Num != undefined && (!_global.isNaN(_loc22_[k].layerObject1Num) && _loc22_[k].layerObject1Num > 0))
                  {
                     this.api.kernel.showMessage(undefined,"Picto " + _loc22_[k].layerObject1Num,"DEBUG_LOG");
                  }
                  if(_loc22_[k].layerObject2Num != undefined && (!_global.isNaN(_loc22_[k].layerObject2Num) && _loc22_[k].layerObject2Num > 0))
                  {
                     this.api.kernel.showMessage(undefined,"Picto " + _loc22_[k].layerObject2Num,"DEBUG_LOG");
                  }
               }
               break;
            case "POINTPICTO":
               this.api.kernel.TipsManager.pointPicto(-1,Number(_loc4_[0]));
               break;
            case "SAVETHEWORLD":
               if(dofus.Constants.SAVING_THE_WORLD)
               {
                  dofus.SaveTheWorld.execute();
               }
               else
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[_loc5_]),"DEBUG_ERROR");
               }
               break;
            case "STOPSAVETHEWORLD":
               if(dofus.Constants.SAVING_THE_WORLD)
               {
                  dofus.SaveTheWorld.stop();
               }
               else
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[_loc5_]),"DEBUG_ERROR");
               }
               break;
            case "NEXTSAVE":
               if(dofus.Constants.SAVING_THE_WORLD)
               {
                  dofus.SaveTheWorld.getInstance().nextAction();
               }
               else
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[_loc5_]),"DEBUG_ERROR");
               }
               break;
            case "SOMAPLAY":
               var _loc23_ = _loc4_.join(" ");
               this.api.kernel.AudioManager.playSound(_loc23_);
               break;
            case "VERIFYIDENTITY":
               var _loc24_ = _loc4_[0];
               if(this.api.network.isValidNetworkKey(_loc24_))
               {
                  this.api.kernel.showMessage(undefined,_loc24_ + ": Ok!","DEBUG_LOG");
               }
               else
               {
                  this.api.kernel.showMessage(undefined,_loc24_ + ": Failed.","DEBUG_LOG");
                  if(_loc24_ == undefined)
                  {
                     this.api.kernel.showMessage(undefined," - Undefined identity.","DEBUG_LOG");
                  }
                  if(_loc24_.length == 0)
                  {
                     this.api.kernel.showMessage(undefined," - Zero-length identity.","DEBUG_LOG");
                  }
                  if(_loc24_ == "")
                  {
                     this.api.kernel.showMessage(undefined,"\t- Empty string identity.","DEBUG_LOG");
                  }
                  if(dofus.aks.Aks.checksum(_loc24_.substr(0,_loc24_.length - 1)) != _loc24_.substr(_loc24_.length - 1))
                  {
                     this.api.kernel.showMessage(undefined,"\t- First checksum is wrong. Got " + _loc24_.substr(_loc24_.length - 1) + ", " + dofus.aks.Aks.checksum(_loc24_.substr(0,_loc24_.length - 1)) + " expected.","DEBUG_LOG");
                  }
                  if(dofus.aks.Aks.checksum(_loc24_.substr(1,_loc24_.length - 2)) != _loc24_.substr(0,1))
                  {
                     this.api.kernel.showMessage(undefined,"\t- Second checksum is wrong. Got " + _loc24_.substr(0,1) + ", " + dofus.aks.Aks.checksum(_loc24_.substr(1,_loc24_.length - 2)) + " expected.","DEBUG_LOG");
                  }
               }
               break;
            case "MONSTER":
               var _loc25_ = _loc4_[0];
               var _loc26_ = this.api.lang.getMonsters();
               for(var i in _loc26_)
               {
                  if(_loc26_[i].n.toUpperCase().indexOf(_loc25_.toUpperCase()) != -1)
                  {
                     this.api.kernel.showMessage(undefined," " + _loc26_[i].n + " : " + i + " ( gfx:" + _loc26_[i].g + ")","DEBUG_LOG");
                  }
               }
               break;
            default:
               this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[_loc5_]),"DEBUG_ERROR");
         }
      }
      else if(this.api.datacenter.Basics.isLogged)
      {
         this.api.network.Basics.autorisedCommand(sCmd);
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[sCmd]),"DEBUG_ERROR");
      }
   }
}
