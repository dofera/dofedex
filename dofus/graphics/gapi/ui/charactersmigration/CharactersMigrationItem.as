class dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "CharactersMigrationItem";
   function CharactersMigrationItem()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function updatePlayerName(sName)
   {
      this._lblName.text = sName;
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._oItem = oItem;
         this._ldrFace._visible = true;
         this._mcInputNickname._visible = true;
         this._lblName._visible = true;
         this._lblLevel._visible = true;
         this._lblLevel.text = oItem.level;
         this._lblName.text = oItem.newPlayerName;
         this.list = oItem.list;
         this._ldrFace.contentPath = dofus.Constants.GUILDS_MINI_PATH + oItem.gfxID + ".swf";
         this._oItem.ref = this;
      }
      else
      {
         this._ldrFace._visible = false;
         this._mcInputNickname._visible = false;
         this._lblName._visible = false;
         this._lblLevel._visible = false;
      }
   }
   function getValue()
   {
      return this._oItem;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
   }
   function initTexts()
   {
   }
   function click(oEvent)
   {
   }
}
