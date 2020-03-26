class dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell extends ank.gapi.core.UIBasicComponent
{
   static var COLOR_TRANSFORM = {ra:60,rb:0,ga:60,gb:0,ba:60,bb:0};
   static var NO_COLOR_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
   function GuildBoostsViewerSpell()
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
         this._lblName.text = oItem.name;
         this._lblLevel.text = oItem.level == 0?"-":oItem.level;
         this._ldrIcon.contentPath = oItem.iconFile;
         this._mcBorder._visible = true;
         this._mcBack._visible = true;
         var _loc5_ = this._mcList.gapi.api.datacenter.Player.guildInfos;
         this._btnBoost._visible = _loc5_.playerRights.canManageBoost && _loc5_.canBoost("s",oItem.ID);
         if(oItem.level == 0)
         {
            this.setMovieClipTransform(this._ldrIcon,dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.COLOR_TRANSFORM);
            this._mcCross._visible = true;
         }
         else
         {
            this.setMovieClipTransform(this._ldrIcon,dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
            this._mcCross._visible = false;
         }
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblLevel.text = "";
         this._ldrIcon.contentPath = "";
         this._mcBorder._visible = false;
         this._mcBack._visible = false;
         this._mcCross._visible = false;
         this._btnBoost._visible = false;
         this.setMovieClipTransform(this._ldrIcon,dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
      }
   }
   function init()
   {
      super.init(false);
      this._mcBorder._visible = false;
      this._mcBack._visible = false;
      this._mcCross._visible = false;
      this._btnBoost._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnBoost.addEventListener("click",this);
      this._btnBoost.addEventListener("over",this);
      this._btnBoost.addEventListener("out",this);
   }
   function click(oEvent)
   {
      this._mcList.gapi.api.network.Guild.boostSpell(this._oItem.ID);
   }
   function over(oEvent)
   {
      var _loc3_ = this._mcList.gapi.api;
      var _loc4_ = _loc3_.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("s",this._oItem.ID);
      this._mcList.gapi.showTooltip(_loc3_.lang.getText("COST") + " : " + _loc4_.cost,oEvent.target,-20);
   }
   function out(oEvent)
   {
      this._mcList.gapi.hideTooltip();
   }
}
