class dofus.graphics.gapi.controls.SpouseViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "SpouseViewer";
   function SpouseViewer()
   {
      super();
   }
   function __set__spouse(oSpouse)
   {
      this._oSpouse = oSpouse;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__spouse();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.SpouseViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this._mcInFight._visible = false;
   }
   function addListeners()
   {
      this._btnJoin.addEventListener("click",this);
      this._btnCompass.addEventListener("click",this);
   }
   function initData()
   {
      this.updateData();
   }
   function initTexts()
   {
      this._btnJoin.label = this.api.lang.getText("JOIN_SMALL");
      if(this._oSpouse.isFollow)
      {
         this._btnCompass.label = this.api.lang.getText("STOP_FOLLOW");
      }
      else
      {
         this._btnCompass.label = this.api.lang.getText("FOLLOW");
      }
      this._lblPosition.text = this.api.lang.getText("LOCALISATION");
   }
   function updateData()
   {
      if(this._oSpouse != undefined)
      {
         this._winBg.title = ank.utils.PatternDecoder.combine(this.api.lang.getText("SPOUSE"),this._oSpouse.sex,true);
         this._lblSpouse.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("SPOUSE"),this._oSpouse.sex,true);
         this._lblName.text = this._oSpouse.name;
         this.api.colors.addSprite(this._ldrArtwork,this._oSpouse);
         this._ldrArtwork.contentPath = dofus.Constants.GUILDS_FACES_PATH + this._oSpouse.gfx + ".swf";
         if(this._oSpouse.isConnected && this._lblCoordinates.text != undefined)
         {
            this._mcInFight._visible = this._oSpouse.isInFight;
            this._lblLevel.text = !_global.isNaN(this._oSpouse.level)?this.api.lang.getText("LEVEL") + " " + this._oSpouse.level:"";
            this._lblArea.text = this.api.kernel.MapsServersManager.getMapName(this._oSpouse.mapID);
            this._lblCoordinates.text = "";
            this._btnJoin.enabled = !this.api.datacenter.Game.isFight;
            this._btnCompass.enabled = true;
         }
         else if(this._lblLevel.text != undefined)
         {
            this._mcInFight._visible = false;
            this._lblLevel.text = "";
            this._lblArea.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("SPOUSE_NOT_CONNECTED"),this._oSpouse.sex,true);
            this._lblCoordinates.text = "";
            this._btnJoin.enabled = false;
            this._btnCompass.enabled = false;
         }
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnJoin:
            if(!this.api.datacenter.Game.isFight)
            {
               this.api.network.Friends.join("S");
            }
            break;
         case this._btnCompass:
            if(this._oSpouse.isConnected)
            {
               if(this._oSpouse.isFollow)
               {
                  this.api.network.Friends.compass(true);
               }
               else
               {
                  this.api.network.Friends.compass(false);
               }
               this._oSpouse.isFollow = !this._oSpouse.isFollow;
               this.initTexts();
            }
      }
   }
}
