class dofus.datacenter.MountPark extends Object
{
	function MountPark(nOwner, §\x01\x14§, §\x1e\x1d\x1a§, nItems, §\x1e\x12\b§, §\x1e\x19\x10§)
	{
		super();
		this.owner = nOwner;
		this.price = var4;
		this.size = var5;
		this.items = nItems;
		this.guildName = var7;
		this.guildEmblem = var8;
	}
	function __get__isPublic()
	{
		return this.owner == -1;
	}
	function __get__hasNoOwner()
	{
		return this.owner == 0;
	}
	function isMine(§\x1e\x1a\x15§)
	{
		return this.guildName == var2.datacenter.Player.guildInfos.name;
	}
}
