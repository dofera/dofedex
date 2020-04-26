class dofus.datacenter.MountPark extends Object
{
	function MountPark(nOwner, §\x02\x18§, §\x01\x01§, nItems, §\x1e\x13\x13§, §\x1e\x1a\x18§)
	{
		super();
		this.owner = nOwner;
		this.price = loc4;
		this.size = loc5;
		this.items = nItems;
		this.guildName = loc7;
		this.guildEmblem = loc8;
	}
	function __get__isPublic()
	{
		return this.owner == -1;
	}
	function __get__hasNoOwner()
	{
		return this.owner == 0;
	}
	function isMine(loc2)
	{
		return this.guildName == loc2.datacenter.Player.guildInfos.name;
	}
}
