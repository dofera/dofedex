class dofus.aks.Infos extends dofus.aks.Handler
{
   function Infos(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function getMaps()
   {
      this.aks.send("IM");
   }
   function sendScreenInfo()
   {
      Stage.scaleMode = "noScale";
      switch(Stage.displayState)
      {
         case "normal":
            var _loc2_ = "0";
            break;
         case "fullscreen":
            _loc2_ = "1";
            break;
         default:
            _loc2_ = "2";
      }
      this.aks.send("Ir" + Stage.width + ";" + Stage.height + ";" + _loc2_);
      Stage.scaleMode = "showAll";
   }
   function onInfoMaps(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
   }
   function onInfoCompass(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = this.api.ui.getUIComponent("MapExplorer");
      if(_loc6_ != undefined)
      {
         _loc6_.select({coordinates:{x:_loc4_,y:_loc5_}});
      }
      if(_global.isNaN(_loc4_) && _global.isNaN(_loc5_))
      {
         this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1],false);
      }
      else
      {
         this.api.kernel.GameManager.updateCompass(_loc4_,_loc5_,true);
      }
   }
   function onInfoCoordinatespHighlight(sExtraData)
   {
      var _loc3_ = new Array();
      if(String(sExtraData).length != 0)
      {
         var _loc4_ = sExtraData.split("|");
         var _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            var _loc6_ = _loc4_[_loc5_].split(";");
            var _loc7_ = Number(_loc6_[0]);
            var _loc8_ = Number(_loc6_[1]);
            var _loc9_ = Number(_loc6_[2]);
            var _loc10_ = Number(_loc6_[3]);
            var _loc11_ = Number(_loc6_[4]);
            var _loc12_ = String(_loc6_[5]);
            _loc3_.push({x:_loc7_,y:_loc8_,mapID:_loc9_,type:_loc10_,playerID:_loc11_,playerName:_loc12_});
            _loc5_ = _loc5_ + 1;
         }
      }
      var _loc13_ = this.api.ui.getUIComponent("MapExplorer");
      if(_loc13_ != undefined)
      {
         _loc13_.multipleSelect(_loc3_);
      }
      this.api.datacenter.Basics.aks_infos_highlightCoords = String(sExtraData).length != 0?_loc3_:undefined;
   }
   function onMessage(sExtraData)
   {
      var _loc3_ = new Array();
      var _loc4_ = sExtraData.charAt(0);
      var _loc5_ = sExtraData.substr(1).split("|");
      var _loc7_ = 0;
      while(_loc7_ < _loc5_.length)
      {
         var _loc8_ = _loc5_[_loc7_].split(";");
         var _loc9_ = _loc8_[0];
         var _loc10_ = Number(_loc9_);
         var _loc11_ = _loc8_[1].split("~");
         switch(_loc4_)
         {
            case "0":
               var _loc6_ = "INFO_CHAT";
               if(!_global.isNaN(_loc10_))
               {
                  var _loc13_ = true;
                  switch(_loc10_)
                  {
                     case 21:
                     case 22:
                        var _loc14_ = new dofus.datacenter.Item(0,_loc11_[1]);
                        _loc11_ = [_loc11_[0],_loc14_.name];
                        break;
                     case 17:
                        _loc11_ = [_loc11_[0],this.api.lang.getJobText(_loc11_[1]).n];
                        break;
                     case 2:
                        _loc11_ = [this.api.lang.getJobText(Number(_loc11_[0])).n];
                        break;
                     case 3:
                        _loc11_ = [this.api.lang.getSpellText(Number(_loc11_[0])).n];
                        break;
                     case 54:
                     case 55:
                     case 56:
                        _loc11_[0] = this.api.lang.getQuestText(_loc11_[0]);
                        break;
                     case 65:
                     case 73:
                        var _loc15_ = new dofus.datacenter.Item(0,_loc11_[1]);
                        _loc11_[2] = _loc15_.name;
                        break;
                     case 82:
                     case 83:
                        this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("INFOS_" + _loc10_,_loc11_),"ERROR_BOX");
                        break;
                     case 84:
                        break;
                     case 120:
                        if(dofus.Constants.SAVING_THE_WORLD)
                        {
                           dofus.SaveTheWorld.getInstance().safeWasBusy();
                           dofus.SaveTheWorld.getInstance().nextAction();
                        }
                        break;
                     case 123:
                        var _loc12_ = this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("INFOS_" + _loc10_),_loc11_);
                        _loc13_ = false;
                        break;
                     case 150:
                        _loc6_ = "MESSAGE_CHAT";
                        var _loc16_ = new dofus.datacenter.Item(0,_loc11_[0]);
                        var _loc17_ = new Array();
                        var _loc18_ = 3;
                        while(_loc18_ < _loc11_.length)
                        {
                           _loc17_.push(_loc11_[_loc18_]);
                           _loc18_ = _loc18_ + 1;
                        }
                        _loc11_ = [_loc16_.name,_loc11_[1],this.api.lang.getText("OBJECT_CHAT_" + _loc11_[2],_loc17_)];
                        break;
                     case 151:
                        _loc6_ = "WHISP_CHAT";
                        var _loc19_ = new dofus.datacenter.Item(0,_loc11_[0]);
                        var _loc20_ = new Array();
                        var _loc21_ = 2;
                        while(_loc21_ < _loc11_.length)
                        {
                           _loc20_.push(_loc11_[_loc21_]);
                           _loc21_ = _loc21_ + 1;
                        }
                        _loc11_ = [_loc19_.name,this.api.lang.getText("OBJECT_CHAT_" + _loc11_[1],_loc20_)];
                  }
                  if(_loc13_)
                  {
                     _loc12_ = this.api.lang.getText("INFOS_" + _loc10_,_loc11_);
                  }
               }
               else
               {
                  _loc12_ = this.api.lang.getText(_loc9_,_loc11_);
               }
               if(_loc12_ != undefined)
               {
                  _loc3_.push(_loc12_);
               }
               break;
            case "1":
               _loc6_ = "ERROR_CHAT";
               if(!_global.isNaN(_loc10_))
               {
                  var _loc23_ = _loc10_.toString(10);
                  switch(_loc10_)
                  {
                     case 16:
                        this.api.electron.makeNotification(_loc22_);
                        break;
                     case 6:
                     case 46:
                     case 49:
                        _loc11_ = [this.api.lang.getJobText(_loc11_[0]).n];
                        break;
                     case 7:
                        _loc11_ = [this.api.lang.getSpellText(_loc11_[0]).n];
                        break;
                     case 89:
                        if(this.api.config.isStreaming)
                        {
                           _loc23_ = "89_MINICLIP";
                        }
                  }
                  var _loc22_ = this.api.lang.getText("ERROR_" + _loc23_,_loc11_);
               }
               else
               {
                  _loc22_ = this.api.lang.getText(_loc9_,_loc11_);
               }
               if(_loc22_ != undefined)
               {
                  _loc3_.push(_loc22_);
               }
               break;
            case "2":
               _loc6_ = "PVP_CHAT";
               if(!_global.isNaN(_loc10_))
               {
                  switch(_loc10_)
                  {
                     case 41:
                        _loc11_ = [this.api.lang.getMapSubAreaText(_loc11_[0]).n,this.api.lang.getMapAreaText(_loc11_[1]).n];
                        break;
                     case 86:
                     case 87:
                     case 88:
                     case 89:
                     case 90:
                        _loc11_[0] = this.api.lang.getMapAreaText(_loc11_[0]).n;
                  }
                  var _loc24_ = this.api.lang.getText("PVP_" + _loc10_,_loc11_);
               }
               else
               {
                  _loc24_ = this.api.lang.getText(_loc9_,_loc11_);
               }
               if(_loc24_ != undefined)
               {
                  _loc3_.push(_loc24_);
               }
         }
         _loc7_ = _loc7_ + 1;
      }
      var _loc25_ = _loc3_.join(" ");
      if(_loc25_ != "")
      {
         this.api.kernel.showMessage(undefined,_loc25_,_loc6_);
      }
   }
   function onQuantity(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1];
      this.api.gfx.addSpritePoints(_loc4_,_loc5_,11552256);
   }
   function onObject(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1].charAt(0) == "+";
      var _loc6_ = _loc3_[1].substr(1);
      var _loc7_ = _loc6_ != ""?new dofus.datacenter.Item(0,_loc6_,1):undefined;
      if(!this.api.datacenter.Basics.isCraftLooping)
      {
         this.api.gfx.addSpriteOverHeadItem(_loc4_,"craft",dofus.graphics.battlefield.CraftResultOverHead,[_loc5_,_loc7_],2000);
      }
   }
   function onLifeRestoreTimerStart(sExtraData)
   {
      var _loc3_ = Number(sExtraData);
      _global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
      if(!_global.isNaN(_loc3_))
      {
         var _loc4_ = this.api.datacenter.Player;
         this.api.datacenter.Basics.aks_infos_lifeRestoreInterval = _global.setInterval(_loc4_,"updateLP",_loc3_,1);
      }
   }
   function onLifeRestoreTimerFinish(sExtraData)
   {
      var _loc3_ = Number(sExtraData);
      _global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
      if(_loc3_ > 0)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_RESTORE_LIFE",[_loc3_]),"INFO_CHAT");
      }
   }
}
