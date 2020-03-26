class dofus.Electron extends dofus.utils.ApiElement
{
   var _bEnabled = _root.electron != undefined;
   var _bUseRsaCrypto = _root.RSACrypto != undefined;
   function Electron(oAPI)
   {
      super();
      this.initialize(oAPI);
   }
   function __get__enabled()
   {
      return this._bEnabled;
   }
   function __get__useRsaCrypto()
   {
      return this._bUseRsaCrypto;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
   }
   function log(sMessage, bError)
   {
      if(!this._bEnabled)
      {
         return undefined;
      }
      if(bError == undefined)
      {
         bError = false;
      }
      flash.external.ExternalInterface.call("userLog",sMessage,bError);
   }
   function debugRequest(bSend, sData)
   {
      if(!this._bEnabled)
      {
         return undefined;
      }
      var _loc4_ = this.api.datacenter.Player.Name;
      var _loc5_ = this.api.datacenter.Basics.aks_current_server.label;
      flash.external.ExternalInterface.call("debugRequest",bSend,dofus.Constants.LOG_DATAS,sData,_loc4_,_loc5_);
   }
   function setLoginDiscordActivity()
   {
      if(!this._bEnabled)
      {
         return undefined;
      }
      flash.external.ExternalInterface.call("setLoginDiscordActivity");
   }
   function makeNotification(sContent)
   {
      if(!this._bEnabled || sContent == undefined)
      {
         return undefined;
      }
      sContent = sContent.replace("<b>","");
      sContent = sContent.replace("</b>","");
      sContent = sContent.replace("<u>","");
      sContent = sContent.replace("</u>","");
      flash.external.ExternalInterface.call("makeNotification",sContent);
   }
   function updateWindowTitle(sPlayerName)
   {
      if(!this._bEnabled)
      {
         return undefined;
      }
      var _loc3_ = "";
      if(sPlayerName != undefined)
      {
         _loc3_ = sPlayerName + " - ";
      }
      _loc3_ = _loc3_ + "Dofus Retro v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
      flash.external.ExternalInterface.call("changeTitle",_loc3_);
   }
}
