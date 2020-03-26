class dofus.datacenter.MountPark extends Object
{
   function MountPark(nOwner, nPrice, nSize, nItems, sGuildName, oGuildEmblem)
   {
      super();
      this.owner = nOwner;
      this.price = nPrice;
      this.size = nSize;
      this.items = nItems;
      this.guildName = sGuildName;
      this.guildEmblem = oGuildEmblem;
   }
   function __get__isPublic()
   {
      return this.owner == -1;
   }
   function __get__hasNoOwner()
   {
      return this.owner == 0;
   }
   function isMine(oApi)
   {
      return this.guildName == oApi.datacenter.Player.guildInfos.name;
   }
}
