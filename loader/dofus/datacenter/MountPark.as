class dofus.datacenter.MountPark extends Object
{
	function MountPark(nOwner, §\x02\x16§, §\x1e\x1e\x1c§, nItems, §\x1e\x13\x11§, §\x1e\x1a\x16§)
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
	function isMine(var2)
	{
		return this.guildName == var2.datacenter.Player.guildInfos.name;
	}
}
