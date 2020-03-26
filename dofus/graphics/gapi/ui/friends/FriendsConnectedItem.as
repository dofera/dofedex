class dofus.graphics.gapi.ui.friends.FriendsConnectedItem extends ank.gapi.core.UIBasicComponent
{
   function FriendsConnectedItem()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._oItem = oItem;
         if(oItem.account != undefined && !this._mcList._parent._parent.api.config.isStreaming)
         {
            this._lblName.text = oItem.account + " (" + oItem.name + ")";
         }
         else
         {
            this._lblName.text = oItem.name;
         }
         if(oItem.level != undefined)
         {
            this._lblLevel.text = oItem.level;
         }
         else
         {
            this._lblLevel.text = "";
         }
         this._mcFight._visible = oItem.state == "IN_MULTI";
         this._ldrGuild.contentPath = dofus.Constants.GUILDS_MINI_PATH + oItem.gfxID + ".swf";
         if(oItem.alignement != -1)
         {
            this._ldrAlignement.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + oItem.alignement + ".swf";
         }
         else
         {
            this._ldrAlignement.contentPath = "";
         }
         this._btnRemove._visible = true;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblLevel.text = "";
         this._ldrAlignement.contentPath = "";
         this._mcFight._visible = false;
         this._ldrGuild.contentPath = "";
         this._btnRemove._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._mcFight._visible = false;
      this._btnRemove._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnRemove.addEventListener("click",this);
   }
   function click(oEvent)
   {
      if(this._oItem.account != undefined)
      {
         this._mcList._parent._parent.removeFriend("*" + this._oItem.account);
      }
      else
      {
         this._mcList._parent._parent.removeFriend(this._oItem.name);
      }
   }
}
