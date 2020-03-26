class dofus.managers.SpeakingItemsManager extends dofus.utils.ApiElement
{
   static var _sSelf = null;
   static var MINUTE_DELAY = 1000 * 60;
   static var SPEAK_TRIGGER_MINUTE = 1;
   static var SPEAK_TRIGGER_AGRESS = 2;
   static var SPEAK_TRIGGER_AGRESSED = 3;
   static var SPEAK_TRIGGER_KILL_ENEMY = 4;
   static var SPEAK_TRIGGER_KILLED_BY_ENEMY = 5;
   static var SPEAK_TRIGGER_CC_OWNER = 6;
   static var SPEAK_TRIGGER_EC_OWNER = 7;
   static var SPEAK_TRIGGER_FIGHT_WON = 8;
   static var SPEAK_TRIGGER_FIGHT_LOST = 9;
   static var SPEAK_TRIGGER_NEW_ENEMY_WEAK = 10;
   static var SPEAK_TRIGGER_NEW_ENEMY_STRONG = 11;
   static var SPEAK_TRIGGER_CC_ALLIED = 12;
   static var SPEAK_TRIGGER_EC_ALLIED = 13;
   static var SPEAK_TRIGGER_CC_ENEMY = 14;
   static var SPEAK_TRIGGER_EC_ENEMY = 15;
   static var SPEAK_TRIGGER_ON_CONNECT = 16;
   static var SPEAK_TRIGGER_KILL_ALLY = 17;
   static var SPEAK_TRIGGER_KILLED_BY_ALLY = 18;
   static var SPEAK_TRIGGER_GREAT_DROP = 19;
   static var SPEAK_TRIGGER_KILLED_HIMSELF = 20;
   static var SPEAK_TRIGGER_CRAFT_OK = 21;
   static var SPEAK_TRIGGER_CRAFT_KO = 22;
   static var SPEAK_TRIGGER_LEVEL_UP = "SPEAK_TRIGGER_LEVEL_UP";
   static var SPEAK_TRIGGER_FEED = "SPEAK_TRIGGER_FEED";
   static var SPEAK_TRIGGER_ASSOCIATE = "SPEAK_TRIGGER_ASSOCIATE";
   static var SPEAK_TRIGGER_DISSOCIATE = "SPEAK_TRIGGER_DISSOCIATE";
   static var SPEAK_TRIGGER_CHANGE_SKIN = "SPEAK_TRIGGER_CHANGE_SKIN";
   function SpeakingItemsManager(oAPI)
   {
      super();
      dofus.managers.SpeakingItemsManager._sSelf = this;
      this.initialize(oAPI);
   }
   static function getInstance()
   {
      return dofus.managers.SpeakingItemsManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      mx.events.EventDispatcher.initialize(this);
      this.generateNextMsgCount(true);
   }
   function __get__nextMsgDelay()
   {
      return this._nNextMessageCount;
   }
   function triggerPrivateEvent(sEvent)
   {
      this.api.kernel.AudioManager.playSound(sEvent);
   }
   function triggerEvent(nEvent)
   {
      if(nEvent == dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ON_CONNECT)
      {
         ank.utils.Timer.removeTimer(this,"SpeakingItemsManager",dofus.managers.SpeakingItemsManager._nTimer);
         ank.utils.Timer.setTimer(this,"SpeakingItemsManager",this,this.triggerEvent,dofus.managers.SpeakingItemsManager.MINUTE_DELAY,[dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_MINUTE],true);
      }
      if(!this.api.kernel.OptionsManager.getOption("UseSpeakingItems"))
      {
         return undefined;
      }
      this.updateEquipedSpeakingItems();
      if(this._eaItems.length)
      {
         var _loc3_ = this._eaItems[Math.floor(Math.random() * this._eaItems.length)];
         this._nNextMessageCount = this._nNextMessageCount - 1;
         this._nNextMessageCount = this._nNextMessageCount - (this._eaItems.length - 1) / 4;
         if(this._nNextMessageCount <= 0)
         {
            var _loc4_ = this.api.lang.getSpeakingItemsTrigger(nEvent)[_loc3_.mood];
            if(_loc4_)
            {
               var _loc6_ = new Array();
               var _loc7_ = 0;
               for(; _loc7_ < _loc4_.length; _loc7_ = _loc7_ + 1)
               {
                  var _loc5_ = this.api.lang.getSpeakingItemsText(_loc4_[_loc7_]);
                  if(_loc5_.l <= _loc3_.maxSkin)
                  {
                     if(_loc5_.r != undefined && _loc5_.r != "")
                     {
                        var _loc8_ = _loc5_.r.split(",");
                        var _loc9_ = false;
                        var _loc10_ = 0;
                        while(_loc10_ < _loc8_.length)
                        {
                           if(_loc8_[_loc10_] == _loc3_.realUnicId)
                           {
                              _loc9_ = true;
                              break;
                           }
                           _loc10_ = _loc10_ + 1;
                        }
                        if(!_loc9_)
                        {
                           continue;
                        }
                     }
                     if(_loc5_.m != undefined)
                     {
                        if(_loc5_.p != undefined)
                        {
                           _loc6_.push(_loc4_[_loc7_]);
                        }
                     }
                  }
               }
               var _loc11_ = false;
               var _loc13_ = 10;
               var _loc14_ = this.api.lang.getConfigText("SPEAKING_ITEMS_MAX_TEXT_ID");
               while(!_loc11_ && ((_loc13_ = _loc13_ - 1) && _loc6_.length))
               {
                  var _loc12_ = _loc6_[Math.floor(Math.random() * _loc6_.length)];
                  if(!(_loc14_ != -1 && _loc12_ > _loc14_))
                  {
                     _loc5_ = this.api.lang.getSpeakingItemsText(_loc12_);
                     if(Math.random() < _loc5_.p)
                     {
                        _loc11_ = true;
                     }
                  }
               }
               if(!_loc11_)
               {
                  return undefined;
               }
               if(_loc5_.s != -1 && !_global.isNaN(_loc5_.s))
               {
                  var _loc15_ = Math.floor(Math.random() * 3);
               }
               else
               {
                  _loc15_ = 1;
               }
               if((_loc15_ == 0 || _loc15_ == 2) && this.api.lang.getConfigText("SPEAKING_ITEMS_USE_SOUND"))
               {
                  this.api.kernel.AudioManager.playSound("SPEAKING_ITEMS_" + _loc5_.s);
               }
               if(_loc15_ == 1 || _loc15_ == 2)
               {
                  var _loc16_ = this.api.lang.getConfigText("SPEAKING_ITEMS_CHAT_PROBA");
                  if(Math.random() * _loc16_ <= 1 && this.api.datacenter.Player.canChatToAll)
                  {
                     this.api.network.Chat.send("**" + (_loc12_ + this.api.datacenter.Player.ID) + "**","*");
                  }
                  else
                  {
                     this.api.kernel.showMessage(undefined,_loc3_.name + " : " + _loc5_.m,"WHISP_CHAT");
                  }
               }
               this.generateNextMsgCount();
            }
         }
      }
      return undefined;
   }
   function generateNextMsgCount(bNoMin)
   {
      var _loc3_ = this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT");
      var _loc4_ = _loc3_ * this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT_DELTA");
      if(bNoMin)
      {
         this._nNextMessageCount = Math.floor(_loc3_ * Math.random());
      }
      else
      {
         this._nNextMessageCount = _loc3_ + Math.floor(2 * _loc4_ * Math.random() - _loc4_ / 2);
      }
   }
   function updateEquipedSpeakingItems()
   {
      var _loc2_ = this.api.datacenter.Player.Inventory;
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = 0;
      while(_loc4_ < _loc2_.length)
      {
         if(_loc2_[_loc4_].isSpeakingItem && _loc2_[_loc4_].position != -1)
         {
            _loc3_.push(_loc2_[_loc4_]);
         }
         _loc4_ = _loc4_ + 1;
      }
      this._eaItems = _loc3_;
   }
}
