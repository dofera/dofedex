class dofus.aks.Specialization extends dofus.aks.Handler
{
   function Specialization(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function onSet(sExtraData)
   {
      var _loc3_ = Number(sExtraData);
      if(_global.isNaN(_loc3_) || (sExtraData.length == 0 || _loc3_ == 0))
      {
         this.api.datacenter.Player.specialization = undefined;
      }
      else
      {
         var _loc4_ = new dofus.datacenter.Specialization(_loc3_);
         this.api.datacenter.Player.specialization = _loc4_;
      }
   }
   function onChange(sExtraData)
   {
      this.onSet(sExtraData);
      var _loc3_ = this.api.datacenter.Player.specialization;
      if(_loc3_ == undefined)
      {
         this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"),this.api.lang.getText("YOU_HAVE_NO_SPECIALIZATION"),"ERROR_BOX");
      }
      else
      {
         this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"),this.api.lang.getText("YOUR_SPECIALIZATION_CHANGED",[_loc3_.name]),"ERROR_BOX");
      }
   }
}
