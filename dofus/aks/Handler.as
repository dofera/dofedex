class dofus.aks.Handler extends dofus.utils.ApiElement
{
   function Handler()
   {
      super();
   }
   function __get__aks()
   {
      return this._oAKS;
   }
   function initialize(oAKS, oAPI)
   {
      super.initialize(oAPI);
      this._oAKS = oAKS;
      this._oAPI = oAPI;
   }
}
