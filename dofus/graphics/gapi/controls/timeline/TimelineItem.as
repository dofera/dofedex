class dofus.graphics.gapi.controls.timeline.TimelineItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Timeline";
   function TimelineItem()
   {
      super();
   }
   function __get__chrono()
   {
      return this._vcChrono;
   }
   function __get__sprite()
   {
      return this._ldrSprite;
   }
   function __set__data(oData)
   {
      this._oData = oData;
      this.updateHealth();
      return this.__get__data();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.timeline.TimelineItem.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.loadSprite,params:[this._oData.gfxFile]});
   }
   function loadSprite(sFile)
   {
      this._ldrSprite.contentPath = sFile;
      this._ldrSprite.addEventListener("initialization",this);
      this.api.colors.addSprite(this._ldrSprite,this._oData);
      this.setHealthTeamColor();
      this.updateHealth();
   }
   function setHealthTeamColor()
   {
      var _loc2_ = new Color(this._mcHealth);
      _loc2_.setRGB(dofus.Constants.TEAMS_COLOR[this._oData._team]);
   }
   function updateHealth()
   {
      this._mcHealth._yscale = this._oData._lp / this._oData._lpmax * 100;
   }
   function onRollOver()
   {
      this._mcBackRect._alpha = 50;
      this._oData.mc.onRollOver();
      this._oData.mc.showEffects(true);
   }
   function onRollOut()
   {
      this._mcBackRect._alpha = 100;
      this._oData.mc.onRollOut();
      this._oData.mc.showEffects(false);
   }
   function onRelease()
   {
      if(this._oData.isVisible && (this.api.datacenter.Game.interactionType == 2 || this.api.datacenter.Game.interactionType == 3))
      {
         this._oData.mc.onRelease();
      }
      else
      {
         var _loc2_ = this.gapi.getUIComponent("PlayerInfos");
         var _loc3_ = _loc2_ != undefined && this._oData != _loc2_.data;
         this.gapi.loadUIComponent("PlayerInfos","PlayerInfos",{data:this._oData},{bForceLoad:_loc3_});
      }
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.target.content;
      _loc3_.attachMovie("staticR","anim",10);
      _loc3_._x = 15;
      _loc3_._y = 32;
      _loc3_._xscale = -80;
      _loc3_._yscale = 80;
   }
}
