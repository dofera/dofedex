class dofus.graphics.gapi.ui.fightsinfos.FightsInfosFightItem extends ank.gapi.core.UIBasicComponent
{
   function FightsInfosFightItem()
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
         this._ldrIconTeam1.contentPath = oItem.team1IconFile;
         this._lblTeam1Count.text = oItem.team1Count;
         this._ldrIconTeam2.contentPath = oItem.team2IconFile;
         this._lblTeam2Count.text = oItem.team2Count;
         this._lblTime.text = oItem.durationString;
         this._mcArrows._visible = true;
      }
      else if(this._lblTeam1Count.text != undefined)
      {
         this._ldrIconTeam1.contentPath = "";
         this._lblTeam1Count.text = "";
         this._ldrIconTeam2.contentPath = "";
         this._lblTeam2Count.text = "";
         this._lblTime.text = "";
         this._mcArrows._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._mcArrows._visible = false;
      this._mcList.gapi.api.colors.addSprite(this._ldrIconTeam1,{color1:dofus.Constants.TEAMS_COLOR[0]});
      this._mcList.gapi.api.colors.addSprite(this._ldrIconTeam2,{color1:dofus.Constants.TEAMS_COLOR[1]});
   }
}
