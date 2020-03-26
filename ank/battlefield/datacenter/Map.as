class ank.battlefield.datacenter.Map extends Object
{
   function Map(nID)
   {
      super();
      this.initialize(nID);
   }
   function initialize(nID)
   {
      this.id = nID;
      this.originalsCellsBackup = new ank.utils.ExtendedObject();
   }
   function cleanSpritesOn()
   {
      if(this.data != undefined)
      {
         for(var k in this.data)
         {
            this.data[k].removeAllSpritesOnID();
         }
      }
   }
}
