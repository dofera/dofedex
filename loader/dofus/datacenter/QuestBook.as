class dofus.datacenter.QuestBook
{
	function QuestBook()
	{
		this.initialize();
	}
	function __get__quests()
	{
		return this._eaQuests;
	}
	function getQuest(var2)
	{
		var var3 = this._eaQuests.findFirstItem("id",var2);
		if(var3.index != -1)
		{
			return var3.item;
		}
		return null;
	}
	function initialize()
	{
		this._eaQuests = new ank.utils.();
	}
}
