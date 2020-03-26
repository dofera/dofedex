class dofus.graphics.gapi.controls.Chat extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Chat";
   static var OPEN_OFFSET = 350;
   var _bOpened = false;
   function Chat()
   {
      super();
   }
   function __get__filters()
   {
      return new Array(this._btnFilter0.selected,this._btnFilter1.selected,this._btnFilter2.selected,this._btnFilter3.selected,this._btnFilter4.selected,this._btnFilter5.selected,this._btnFilter6.selected,this._btnFilter7.selected,this._btnFilter8.selected);
   }
   function __get__selectable()
   {
      return this._txtChat.selectable;
   }
   function __set__selectable(bSelectable)
   {
      this._txtChat.selectable = bSelectable;
      return this.__get__selectable();
   }
   function open(bOpen)
   {
      if(bOpen == !this._bOpened)
      {
         return undefined;
      }
      this._btnOpenClose.selected = !bOpen;
      if(bOpen)
      {
         var _loc3_ = -1;
      }
      else
      {
         _loc3_ = 1;
      }
      this._txtChat.setSize(this._txtChat.width,this._txtChat.height + _loc3_ * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET);
      this._y = this._y - _loc3_ * dofus.graphics.gapi.controls.Chat.OPEN_OFFSET;
      this._bOpened = !bOpen;
   }
   function setText(sText)
   {
      this._txtChat.text = sText;
   }
   function updateSmileysEmotes()
   {
      this._sSmileys.update();
   }
   function hideSmileys(bHide)
   {
      this._sSmileys._visible = !bHide;
      this._bSmileysOpened = !bHide;
   }
   function showSitDown(bShow)
   {
      this._btnSitDown._visible = bShow;
   }
   function selectFilter(nFilter, bSelect)
   {
      this["_btnFilter" + nFilter].selected = bSelect;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.Chat.CLASS_NAME);
      this.api.kernel.ChatManager.updateRigth();
   }
   function createChildren()
   {
      var _loc2_ = this.api.lang.getConfigText("CHAT_FILTERS");
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         if(_loc2_[_loc3_] != 1)
         {
            this["_btnFilter" + (_loc3_ + 1)]._visible = false;
         }
         _loc3_ = _loc3_ + 1;
      }
      this.addToQueue({object:this,method:this.addListeners});
      this.hideSmileys(true);
   }
   function addListeners()
   {
      this._btnOpenClose.addEventListener("click",this);
      this._btnSmileys.addEventListener("click",this);
      this._btnFilter0.addEventListener("click",this);
      this._btnFilter1.addEventListener("click",this);
      this._btnFilter2.addEventListener("click",this);
      this._btnFilter3.addEventListener("click",this);
      this._btnFilter4.addEventListener("click",this);
      this._btnFilter5.addEventListener("click",this);
      this._btnFilter6.addEventListener("click",this);
      this._btnFilter7.addEventListener("click",this);
      this._btnFilter8.addEventListener("click",this);
      this._btnSitDown.addEventListener("click",this);
      this._btnOpenClose.addEventListener("over",this);
      this._btnSmileys.addEventListener("over",this);
      this._btnFilter0.addEventListener("over",this);
      this._btnFilter1.addEventListener("over",this);
      this._btnFilter2.addEventListener("over",this);
      this._btnFilter3.addEventListener("over",this);
      this._btnFilter4.addEventListener("over",this);
      this._btnFilter5.addEventListener("over",this);
      this._btnFilter6.addEventListener("over",this);
      this._btnFilter7.addEventListener("over",this);
      this._btnFilter8.addEventListener("over",this);
      this._btnSitDown.addEventListener("over",this);
      this._btnOpenClose.addEventListener("out",this);
      this._btnSmileys.addEventListener("out",this);
      this._btnFilter0.addEventListener("out",this);
      this._btnFilter1.addEventListener("out",this);
      this._btnFilter2.addEventListener("out",this);
      this._btnFilter3.addEventListener("out",this);
      this._btnFilter4.addEventListener("out",this);
      this._btnFilter5.addEventListener("out",this);
      this._btnFilter6.addEventListener("out",this);
      this._btnFilter7.addEventListener("out",this);
      this._btnFilter8.addEventListener("out",this);
      this._btnSitDown.addEventListener("out",this);
      this._sSmileys.addEventListener("selectSmiley",this);
      this._sSmileys.addEventListener("selectEmote",this);
      this._txtChat.addEventListener("href",this);
      var _loc2_ = this._btnFilter0;
      var _loc3_ = 0;
      while(_loc2_ != undefined)
      {
         _loc2_.selected = this.api.datacenter.Basics.chat_type_visible[_loc3_] == true;
         this.api.kernel.ChatManager.setTypeVisible(_loc3_,_loc2_.selected);
         _loc3_ = _loc3_ + 1;
         _loc2_ = this["_btnFilter" + _loc3_];
      }
      this.api.kernel.ChatManager.setTypeVisible(1,true);
      this.api.kernel.ChatManager.refresh();
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnSitDown":
            this.api.sounds.events.onBannerChatButtonClick();
            var _loc3_ = this.api.lang.getEmoteID("sit");
            if(_loc3_ != undefined)
            {
               this.api.network.Emotes.useEmote(_loc3_);
            }
            break;
         case "_btnSmileys":
            this.api.sounds.events.onBannerChatButtonClick();
            this.hideSmileys(this._bSmileysOpened);
            break;
         case "_btnOpenClose":
            this.api.sounds.events.onBannerChatButtonClick();
            this.open(!oEvent.target.selected);
            break;
         default:
            this.dispatchEvent({type:"filterChanged",filter:Number(oEvent.target._name.substr(10)),selected:oEvent.target.selected});
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnSmileys":
            this.gapi.showTooltip(this.api.lang.getText("CHAT_SHOW_SMILEYS"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnOpenClose":
            this.gapi.showTooltip(this.api.lang.getText("CHAT_SHOW_MORE"),oEvent.target,-33,{bXLimit:true,bYLimit:false});
            break;
         case "_btnSitDown":
            this.gapi.showTooltip(this.api.lang.getText("SITDOWN_TOOLTIP"),oEvent.target,-46,{bXLimit:true,bYLimit:false});
            break;
         default:
            var _loc3_ = Number(oEvent.target._name.substr(10));
            this.gapi.showTooltip(this.api.lang.getText("CHAT_TYPE" + _loc3_),oEvent.target,-20,{bXLimit:true,bYLimit:true});
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function selectSmiley(oEvent)
   {
      if(!this.api.datacenter.Player.data.isInMove)
      {
         this.dispatchEvent(oEvent);
         if(this.api.kernel.OptionsManager.getOption("AutoHideSmileys"))
         {
            this.hideSmileys(true);
            this._btnSmileys.selected = false;
         }
      }
   }
   function selectEmote(oEvent)
   {
      if(!this.api.datacenter.Player.data.isInMove)
      {
         this.dispatchEvent(oEvent);
         if(this.api.kernel.OptionsManager.getOption("AutoHideSmileys"))
         {
            this.hideSmileys(true);
         }
         this._btnSmileys.selected = false;
      }
   }
   function href(oEvent)
   {
      this.dispatchEvent(oEvent);
   }
}
