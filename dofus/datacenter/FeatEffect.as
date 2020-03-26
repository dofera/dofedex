class dofus.datacenter.FeatEffect extends Object
{
   function FeatEffect(nIndex, aParams)
   {
      super();
      this.api = _global.API;
      this.initialize(nIndex,aParams);
   }
   function __get__index()
   {
      return this._nIndex;
   }
   function __set__index(nIndex)
   {
      this._nIndex = nIndex;
      return this.__get__index();
   }
   function __get__description()
   {
      return ank.utils.PatternDecoder.getDescription(this._sFeatEffectInfos,this._aParams);
   }
   function __set__params(aParams)
   {
      this._aParams = aParams;
      return this.__get__params();
   }
   function __get__params()
   {
      return this._aParams;
   }
   function initialize(nIndex, aParams)
   {
      this._nIndex = nIndex;
      this._aParams = aParams;
      this._sFeatEffectInfos = this.api.lang.getAlignmentFeatEffect(nIndex);
   }
}
