class dofus.aks.Spells extends dofus.aks.Handler
{
   function Spells(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function moveToUsed(nID, nPosition)
   {
      this.aks.send("SM" + nID + "|" + nPosition,false);
   }
   function boost(nID)
   {
      this.aks.send("SB" + nID);
   }
   function spellForget(nID)
   {
      this.aks.send("SF" + nID);
   }
   function onUpgradeSpell(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = this.api.kernel.CharactersManager.getSpellObjectFromData(sExtraData);
         this.api.datacenter.Player.updateSpell(_loc4_);
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BOOST_SPELL"),"ERROR_BOX");
      }
   }
   function onList(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = this.api.datacenter.Player;
      _loc4_.Spells.removeItems(1,_loc4_.Spells.length);
      var _loc5_ = new Array();
      var _loc6_ = 0;
      while(_loc6_ < _loc3_.length)
      {
         var _loc7_ = _loc3_[_loc6_];
         if(_loc7_.length != 0)
         {
            var _loc8_ = this.api.kernel.CharactersManager.getSpellObjectFromData(_loc7_);
            if(_loc8_ != undefined)
            {
               _loc5_.push(_loc8_);
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      _loc4_.Spells.replaceAll(1,_loc5_);
   }
   function onChangeOption(sExtraData)
   {
      this.api.datacenter.Basics.canUseSeeAllSpell = sExtraData.charAt(0) == "+";
   }
   function onSpellBoost(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = Number(_loc3_[2]);
      this.api.kernel.SpellsBoostsManager.setSpellModificator(_loc4_,_loc5_,_loc6_);
   }
   function onSpellForget(sExtraData)
   {
      if(sExtraData == "+")
      {
         this.api.ui.loadUIComponent("SpellForget","SpellForget",undefined,{bStayIfPresent:true});
      }
      else if(sExtraData == "-")
      {
         this.api.ui.unloadUIComponent("SpellForget");
      }
   }
}
