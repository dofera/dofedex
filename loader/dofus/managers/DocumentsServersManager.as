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
	function getDocumentObject(var2)
	{
		return new dofus.datacenter.Document(var2);
	}
	function onComplete(var2)
	{
		var var3 = this.getDocumentObject(var2);
		this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:[var3.uiType,"Document",{document:var3}]});
	}
	function onFailed()
	{
		this.addToQueue({object:this.api.kernel,method:this.api.kernel.showMessage,params:[undefined,this.api.lang.getText("NO_DOCUMENTDATA_FILE"),"ERROR_BOX",{name:"NoMapData"}]});
		this.api.network.Documents.leave();
	}
}
