class dofus.datacenter.Feat extends Object
{
   function Feat(nIndex, nLevel, aParams)
   {
      super();
      this.api = _global.API;
      this.initialize(nIndex,nLevel,aParams);
   }
   function __get__index()
   {
      return this._nIndex;
   }
   function __set__index(nIndex)
   {
      this._nIndex = !(_global.isNaN(nIndex) || nIndex == undefined)?nIndex:0;
      return this.__get__index();
   }
   function __get__name()
   {
      return this._oFeatInfos.n;
   }
   function __get__level()
   {
      return this._nLevel;
   }
   function __get__effect()
   {
      return new dofus.datacenter.FeatEffect(this._oFeatInfos.e,this._aParams);
   }
   function __get__iconFile()
   {
      return dofus.Constants.FEATS_PATH + this._oFeatInfos.g + ".swf";
   }
   function initialize(nIndex, nLevel, aParams)
   {
      this._nIndex = nIndex;
      this._nLevel = nLevel;
      this._aParams = aParams;
      this._oFeatInfos = this.api.lang.getAlignmentFeat(nIndex);
   }
}
