class dofus.graphics.gapi.ui.CharactersMigration extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "CharactersMigration";
   var NAME_GENERATION_DELAY = 500;
   var _nLastRegenerateTimer = 0;
   function CharactersMigration()
   {
      super();
   }
   function __set__spriteList(aSpriteList)
   {
      this._aSpriteList = aSpriteList;
      if(this.initialized)
      {
         this.initData();
      }
      return this.__get__spriteList();
   }
   function __set__characterCount(nCharacterCount)
   {
      this._nCharacterCount = nCharacterCount;
      return this.__get__characterCount();
   }
   function __set__setNewName(sName)
   {
      this._mcPlayer._itCharacterName.text = sName;
      return this.__get__setNewName();
   }
   function hideGenerateRandomName()
   {
      this._mcPlayer._mcRandomName._visible = false;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.CharactersMigration.CLASS_NAME);
      if(this.api.datacenter.Basics.aks_is_free_community)
      {
         this._btnSubscribe._visible = false;
      }
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateCharactersList});
      this.addToQueue({object:this,method:this.initTexts});
      this._btnPlay._visible = false;
   }
   function addListeners()
   {
      this._btnSkip.addEventListener("click",this);
      this._btnSubscribe.addEventListener("click",this);
      this._btnBack.addEventListener("click",this);
      this._lstCharacters.addEventListener("itemSelected",this);
      var ref = this;
      this._mcPlayer._mcDelete.onRelease = function()
      {
         ref.api.kernel.showMessage(undefined,ref.api.lang.getText("DO_U_DELETE_A",[ref._lstCharacters.selectedItem.playerName]),"CAUTION_YESNO",{name:"ConfirmDelete",listener:ref});
      };
      this._mcPlayer._mcRandomName.onRelease = function()
      {
         if(ref._nLastRegenerateTimer + ref.NAME_GENERATION_DELAY < getTimer())
         {
            ref.api.network.Account.getRandomCharacterName();
            ref._nLastRegenerateTimer = getTimer();
         }
      };
      this._mcPlayer._mcRandomName.onRollOver = function()
      {
         ref.gapi.showTooltip(ref.api.lang.getText("RANDOM_NICKNAME"),_root._xmouse,_root._ymouse - 20);
      };
      this._mcPlayer._mcRandomName.onRollOut = function()
      {
         ref.gapi.hideTooltip();
      };
      this._mcPlayer._mcValid.onRelease = function()
      {
         ref.validateCreation(ref._mcPlayer._itCharacterName.text,ref._lstCharacters.selectedItem.playerID);
      };
   }
   function updateCharactersList()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      for(var i in this._aSpriteList)
      {
         var _loc3_ = new Object();
         _loc3_.level = this._aSpriteList[i].Level;
         _loc3_.playerName = this._aSpriteList[i].name;
         _loc3_.newPlayerName = _loc3_.playerName;
         _loc3_.gfxID = this._aSpriteList[i].gfxID;
         _loc3_.rowId = i;
         _loc3_.list = this;
         _loc3_.playerID = this._aSpriteList[i].id;
         _loc2_.push(_loc3_);
      }
      this._lstCharacters.dataProvider = _loc2_;
      this._lstCharacters.selectedIndex = 0;
      var _loc4_ = new Object();
      _loc4_.row = new Object();
      _loc4_.row.item = this._lstCharacters.selectedItem;
      this.itemSelected(_loc4_);
   }
   function initData()
   {
      this.api.datacenter.Basics.inGame = false;
      this._aConfirmedChatarcters = new Array();
   }
   function initTexts()
   {
      this._lblTitle.text = this.api.lang.getText("CHOOSE_TITLE");
      this._btnSkip.label = this.api.lang.getText("SERVER_SELECT");
      this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
      this._btnBack.label = this.api.lang.getText("CHANGE_SERVER");
      this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
      this._lblAccount.text = this.api.lang.getText("ACCOUNT_INFO");
      this._lblLogin.text = this.api.lang.getText("PSEUDO_DOFUS",[this.api.datacenter.Basics.dofusPseudo]);
      this._lblServer.text = this.api.lang.getText("CURRENT_SERVER",[this.api.datacenter.Basics.aks_current_server.label]);
      this._taMigrationDesc.text = this.api.lang.getText("CHARACTER_MIGRATION_DESC");
      this._lblMigrationTitle.text = this.api.lang.getText("CHARACTER_MIGRATION_TITLE");
      this._lstCharacters.columnsNames = ["",this.api.lang.getText("NAME").substr(0,1).toUpperCase() + this.api.lang.getText("NAME").substr(1),this.api.lang.getText("LEVEL"),this.api.lang.getText("STATE")];
   }
   function changeSpriteOrientation(mcSprite)
   {
      if(!mcSprite.attachMovie("staticF","mcAnim",10))
      {
         mcSprite.attachMovie("staticR","mcAnim",10);
      }
   }
   function checkName(sName)
   {
      return Math.random() * 2 > 1;
   }
   function destroy()
   {
      this._mcPlayer._svCharacterViewer.destroy();
   }
   function validateCreation(sCharacterName, nCharacterId)
   {
      if(sCharacterName.length == 0 || sCharacterName == undefined)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("NEED_CHARACTER_NAME"),"ERROR_BOX",{name:"CREATENONAME"});
         return undefined;
      }
      if(sCharacterName.length > 20)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("LONG_CHARACTER_NAME",[sCharacterName,20]),"ERROR_BOX");
         return undefined;
      }
      if(this.api.lang.getConfigText("CHAR_NAME_FILTER") && !this.api.datacenter.Player.isAuthorized)
      {
         var _loc4_ = new dofus.utils.nameChecker.NameChecker(sCharacterName);
         var _loc5_ = new dofus.utils.nameChecker.rules.NameCheckerCharacterNameRules();
         var _loc6_ = _loc4_.isValidAgainstWithDetails(_loc5_);
         if(!_loc6_.IS_SUCCESS)
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("INVALID_CHARACTER_NAME") + "\r\n" + _loc6_.toString("\r\n"),"ERROR_BOX");
            return undefined;
         }
      }
      if(!this.api.lang.getConfigText("CHARACTER_MIGRATION_ASK_SERVER_CONFIRM"))
      {
         if(this._aConfirmedChatarcters[nCharacterId] != undefined)
         {
            this.api.network.Account.validCharacterMigration(nCharacterId,sCharacterName);
         }
         else
         {
            var _loc7_ = {name:"ConfirmMigration",params:{nCharacterId:nCharacterId,sCharacterName:sCharacterName},listener:this};
            this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_MIGRATION",[sCharacterName]),"CAUTION_YESNO",_loc7_);
         }
      }
      else
      {
         this.api.network.Account.askCharacterMigration(nCharacterId,sCharacterName);
      }
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnSubscribe":
            _root.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
            break;
         case "_btnSkip":
            this.api.network.Account.getCharactersForced();
            this.api.datacenter.Basics.ignoreMigration = true;
            this.callClose();
      }
   }
   function itemSelected(oEvent)
   {
      this._mcPlayer._svCharacterViewer.zoom = 200;
      this._mcPlayer._svCharacterViewer.refreshDelay = 50;
      this._mcPlayer._svCharacterViewer.useSingleLoader = true;
      this._mcPlayer._svCharacterViewer.allowAnimations = false;
      this._mcPlayer._svCharacterViewer.spriteData = this._aSpriteList[oEvent.row.item.rowId];
      this._mcPlayer._lblOldName.text = this.api.lang.getText("OLD_NAME") + " : " + oEvent.row.item.playerName;
      this._mcPlayer._itCharacterName.text = oEvent.row.item.newPlayerName;
   }
   function initialization(oEvent)
   {
      this._mcSprite = oEvent.clip;
      this.gapi.api.colors.addSprite(this._mcSprite,this._oCurrentPlayerData);
      this._mcSprite._xscale = this._mcSprite._yscale = 180;
      this.addToQueue({object:this,method:this.changeSpriteOrientation,params:[this._mcSprite]});
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoConfirmDelete":
            this.api.network.Account.deleteCharacterMigration(this._lstCharacters.selectedItem.playerID);
            break;
         case "AskYesNoConfirmMigration":
            this._aConfirmedChatarcters[oEvent.params.nCharacterId] = true;
            this.api.network.Account.validCharacterMigration(oEvent.params.nCharacterId,oEvent.params.sCharacterName);
      }
   }
}
