class dofus.managers.DocumentsServersManager extends dofus.managers.ServersManager
{
   static var _sSelf = null;
   function DocumentsServersManager()
   {
      super();
      dofus.managers.DocumentsServersManager._sSelf = this;
   }
   static function getInstance()
   {
      return dofus.managers.DocumentsServersManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI,"docs","docs/");
   }
   function loadDocument(sID)
   {
      this.loadData(sID + ".swf");
   }
   function getDocumentObject(mc)
   {
      return new dofus.datacenter.Document(mc);
   }
   function onComplete(mc)
   {
      var _loc3_ = this.getDocumentObject(mc);
      this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:[_loc3_.uiType,"Document",{document:_loc3_}]});
   }
   function onFailed()
   {
      this.addToQueue({object:this.api.kernel,method:this.api.kernel.showMessage,params:[undefined,this.api.lang.getText("NO_DOCUMENTDATA_FILE"),"ERROR_BOX",{name:"NoMapData"}]});
      this.api.network.Documents.leave();
   }
}
