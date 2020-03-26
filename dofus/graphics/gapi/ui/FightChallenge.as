class dofus.graphics.gapi.ui.FightChallenge extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "FightChallenge";
   function FightChallenge()
   {
      super();
   }
   function __get__challenges()
   {
      return this._aChallengeList;
   }
   function addChallenge(fc)
   {
      this._aChallengeList.push(fc);
      this.updateList();
   }
   function cleanChallenge()
   {
      var _loc2_ = 0;
      while(_loc2_ < this._aChallengeIcon.length)
      {
         (dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[_loc2_].unloadMovie();
         (dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[_loc2_].removeMovieClip();
         _loc2_ = _loc2_ + 1;
      }
      this._aChallengeIcon = new Array();
      this._aChallengeList = new ank.utils.ExtendedArray();
      this.FightChallengeViewer.unloadMovie();
      this._visible = false;
   }
   function updateChallenge(id, success)
   {
      var _loc4_ = 0;
      while(_loc4_ < this._aChallengeIcon.length)
      {
         if((dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[_loc4_].challenge.id == id)
         {
            (dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[_loc4_].challenge.state = !success?2:1;
            (dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[_loc4_].update();
            this.FightChallengeViewer.update();
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc5_ = 0;
      while(_loc5_ < this._aChallengeList.length)
      {
         if((dofus.datacenter.FightChallengeData)this._aChallengeList[_loc5_].id == id)
         {
            this._aChallengeList[_loc5_].state = !success?2:1;
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function init()
   {
      this._aChallengeList = new ank.utils.ExtendedArray();
      super.init(false,dofus.graphics.gapi.ui.FightChallenge.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnOpenClose.addEventListener("click",this);
      this._btnOpenClose.addEventListener("over",this);
      this._btnOpenClose.addEventListener("out",this);
   }
   function updateList()
   {
      this._aChallengeIcon = new Array();
      this._visible = this._aChallengeList.length > 0;
      var _loc3_ = 0;
      while(_loc3_ < this._aChallengeList.length)
      {
         var _loc2_ = (dofus.graphics.gapi.controls.FightChallengeIcon)this.attachMovie("FightChallengeIcon","FightChallengeIcon" + _loc3_,_loc3_ + 1,{challenge:this._aChallengeList[_loc3_]});
         _loc2_._x = this._btnOpenClose._x;
         _loc2_._y = this._btnOpenClose._y + 15 + (6 + _loc2_._height) * _loc3_;
         _loc2_.addEventListener("over",this);
         this._aChallengeIcon.push(_loc2_);
         _loc2_._visible = !this._btnOpenClose.selected;
         _loc3_ = _loc3_ + 1;
      }
   }
   function click(e)
   {
      var _loc3_ = 0;
      while(_loc3_ < this._aChallengeIcon.length)
      {
         this._aChallengeIcon[_loc3_]._visible = !this._btnOpenClose.selected;
         _loc3_ = _loc3_ + 1;
      }
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnOpenClose)
      {
         this.gapi.showTooltip(this.api.lang.getText("PARTY_OPEN_CLOSE"),oEvent.target,20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
