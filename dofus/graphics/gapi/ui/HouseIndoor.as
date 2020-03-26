class dofus.graphics.gapi.ui.HouseIndoor extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "HouseIndoor";
   function HouseIndoor()
   {
      super();
   }
   function __set__house(oHouse)
   {
      this._oHouse = oHouse;
      oHouse.addEventListener("forsale",this);
      oHouse.addEventListener("locked",this);
      this._mcForSale._visible = oHouse.isForSale;
      this._mcLock._visible = oHouse.isLocked;
      return this.__get__house();
   }
   function __set__skills(aSkills)
   {
      this._aSkills = aSkills;
      return this.__get__skills();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.HouseIndoor.CLASS_NAME);
   }
   function createChildren()
   {
      this._mcHouse.onRelease = this.click;
      if(this._oHouse == undefined)
      {
         this._mcForSale._visible = false;
         this._mcLock._visible = false;
      }
   }
   function click()
   {
      var _loc2_ = this._parent.gapi.createPopupMenu();
      var _loc3_ = this._parent._oHouse;
      var _loc4_ = this._parent.api;
      _loc2_.addStaticItem(_loc3_.name);
      for(var k in this._parent._aSkills)
      {
         var _loc5_ = this._parent._aSkills[k];
         var _loc6_ = _loc5_.getState(true,_loc3_.localOwner,_loc3_.isForSale,_loc3_.isLocked,true);
         if(_loc6_ != "X")
         {
            _loc2_.addItem(_loc5_.description,_loc4_.kernel.GameManager,_loc4_.kernel.GameManager.useSkill,[_loc5_.id],_loc6_ == "V");
         }
      }
      if(_loc4_.datacenter.Player.guildInfos != undefined && _loc4_.datacenter.Player.guildInfos.isValid)
      {
         _loc2_.addItem(_loc4_.lang.getText("GUILD_HOUSE_CONFIGURATION"),this._parent,this._parent.guildHouse);
      }
      _loc2_.show(_root._xmouse,_root._ymouse);
   }
   function guildHouse()
   {
      this.api.ui.loadUIComponent("GuildHouseRights","GuildHouseRights",{house:this._oHouse});
   }
   function forsale(oEvent)
   {
      this._mcForSale._visible = oEvent.value;
   }
   function locked(oEvent)
   {
      this._mcLock._visible = oEvent.value;
   }
}
