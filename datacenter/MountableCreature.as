class dofus.datacenter.MountableCreature
{
   function MountableCreature(sGfxFile, nGfxID)
   {
      this.initialize(sGfxFile,nGfxID);
   }
   function __get__gfxFile()
   {
      return this._sGfxFile;
   }
   function initialize(sGfxFile, nGfxID)
   {
      this._sGfxFile = sGfxFile;
      this._nGfxID = nGfxID;
      mx.events.EventDispatcher.initialize(this);
   }
}
