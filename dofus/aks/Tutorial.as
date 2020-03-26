class dofus.aks.Tutorial extends dofus.aks.Handler
{
   static var INTRO_CINEMATIC_PATH = dofus.Constants.CINEMATICS_PATH + "8.swf";
   static var INTRO_CINEMATIC_MAX_LEN = 120;
   static var INTRO_CINEMATIC_PATH_LIGHT = "";
   static var INTRO_CINEMATIC_MAX_LEN_LIGHT = 120;
   static var NOOB_AREA_MUSIC_ID = 129;
   function Tutorial(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function end(nActionListID, nCellNum, nDir)
   {
      if(nActionListID == undefined)
      {
         nActionListID = 0;
      }
      if(nCellNum == undefined || nDir == undefined)
      {
         this.aks.send("TV" + String(nActionListID),false);
      }
      else
      {
         this.aks.send("TV" + String(nActionListID) + "|" + String(nCellNum) + "|" + String(nDir),false);
      }
   }
   function onShowTip(sExtraData)
   {
      var _loc3_ = Number(sExtraData);
      this.api.kernel.TipsManager.showNewTip(_loc3_);
   }
   function onCreate(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1];
      var _loc6_ = this.api.config.language;
      this.api.kernel.TutorialServersManager.loadTutorial(_loc4_ + "_" + _loc5_);
   }
   function onGameBegin()
   {
      var _loc2_ = new ank.utils.Sequencer((!this.api.config.isStreaming?dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN:dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN_LIGHT) * 1000);
      dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT = dofus.Constants.CINEMATICS_PATH + "9_" + this.api.config.language + ".swf";
      _loc2_.addAction(false,this.api.sounds,this.api.sounds.stopAllSounds);
      if(!this.api.config.isStreaming)
      {
         _loc2_.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["Cinematic","Cinematic",{file:(!this.api.config.isStreaming?dofus.aks.Tutorial.INTRO_CINEMATIC_PATH:dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT),sequencer:_loc2_},{bUltimateOnTop:true}]);
      }
      _loc2_.addAction(false,this.api.ui,this.api.ui.loadUIComponent,["AskGameBegin","AskGameBegin",undefined,{bAlwaysOnTop:true}]);
      _loc2_.addAction(false,this.api.sounds,this.api.sounds.playMusic,[dofus.aks.Tutorial.NOOB_AREA_MUSIC_ID,true]);
      this.addToQueue({object:_loc2_,method:_loc2_.execute,params:[true]});
   }
}
