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
	function getQuest(loc2)
	{
		var loc3 = this._eaQuests.findFirstItem("id",loc2);
		if(loc3.index != -1)
		{
			return loc3.item;
		}
		return null;
	}
	function initialize()
	{
		this._eaQuests = new ank.utils.();
	}
}
