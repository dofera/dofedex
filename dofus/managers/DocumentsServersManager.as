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
	function initialize(loc2)
	{
		super.initialize(loc3,"docs","docs/");
	}
	function loadDocument(sID)
	{
		this.loadData(sID + ".swf");
	}
	function getDocumentObject(loc2)
	{
		return new dofus.datacenter.Document(loc2);
	}
	function onComplete(loc2)
	{
		var loc3 = this.getDocumentObject(loc2);
		this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:[loc3.uiType,"Document",{document:loc3}]});
	}
	function onFailed()
	{
		this.addToQueue({object:this.api.kernel,method:this.api.kernel.showMessage,params:[undefined,this.api.lang.getText("NO_DOCUMENTDATA_FILE"),"ERROR_BOX",{name:"NoMapData"}]});
		this.api.network.Documents.leave();
	}
}
