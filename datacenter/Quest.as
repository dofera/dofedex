class dofus.datacenter.Quest extends Object
{
   function Quest(nID, bFinished, nSortOrder)
   {
      super();
      this.initialize(nID,bFinished,nSortOrder);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__isFinished()
   {
      return this._bFinished;
   }
   function __get__name()
   {
      return this.api.lang.getQuestText(this._nID);
   }
   function __get__currentStep()
   {
      return this._oCurrentStep;
   }
   function addStep(oStep)
   {
      this._eoSteps.addItemAt(oStep.id,oStep);
      if(oStep.isCurrent)
      {
         this._oCurrentStep = oStep;
      }
   }
   function initialize(nID, bFinished, nSortOrder)
   {
      this.api = _global.API;
      this._eoSteps = new ank.utils.ExtendedObject();
      this._nID = nID;
      this._bFinished = bFinished;
      this.sortOrder = nSortOrder;
   }
}
