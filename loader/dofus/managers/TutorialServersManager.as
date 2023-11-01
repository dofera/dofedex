class dofus.managers.TutorialServersManager extends dofus.managers.ServersManager
{
	static var _sSelf = null;
	function TutorialServersManager()
	{
		super();
		dofus.managers.TutorialServersManager._sSelf = this;
	}
	static function getInstance()
	{
		return dofus.managers.TutorialServersManager._sSelf;
	}
	function initialize(oAPI)
	{
		super.initialize(oAPI,"tutorials","tutorials/");
	}
	function loadTutorial(sID)
	{
		this.loadData(sID + ".swf");
	}
	function onComplete(var2)
	{
		var var3 = new dofus.datacenter.Tutorial(var2);
		this.addToQueue({object:this.api.kernel.TutorialManager,method:this.api.kernel.TutorialManager.start,params:[var3]});
	}
	function onFailed()
	{
		this.addToQueue({object:this.api.kernel,method:this.api.kernel.showMessage,params:[undefined,this.api.lang.getText("NO_TUTORIALDATA_FILE"),"ERROR_CHAT"]});
		this.api.kernel.TutorialManager.terminate(0);
	}
}
