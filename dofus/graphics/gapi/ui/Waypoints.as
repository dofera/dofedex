class dofus.graphics.gapi.ui.Waypoints extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Waypoints";
   function Waypoints()
   {
      super();
   }
   function __set__data(eaData)
   {
      this.addToQueue({object:this,method:function(d)
      {
         this._eaData = d;
         if(this.initialized)
         {
            this.initData();
         }
      },params:[eaData]});
      return this.__get__data();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Waypoints.CLASS_NAME);
   }
   function callClose()
   {
      this.api.network.Waypoints.leave();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      this._winBg.title = this.api.lang.getText("WAYPOINT_LIST");
      this._lblCoords.text = this.api.lang.getText("COORDINATES_SMALL");
      this._lblName.text = this.api.lang.getText("AREA") + " (" + this.api.lang.getText("SUBAREA") + ")";
      this._lblCost.text = this.api.lang.getText("COST");
      this._lblRespawn.text = this.api.lang.getText("RESPAWN_SMALL");
      this._lblDescription.text = this.api.lang.getText("CLICK_ON_WAYPOINT");
      this._btnClose2.label = this.api.lang.getText("CLOSE");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose2.addEventListener("click",this);
      this._lstWaypoints.addEventListener("itemSelected",this);
   }
   function initData()
   {
      if(this._eaData != undefined)
      {
         this._eaData.sortOn("fieldToSort",Array.CASEINSENSITIVE);
         this._lstWaypoints.dataProvider = this._eaData;
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
         case "_btnClose2":
            this.callClose();
      }
   }
   function itemSelected(oEvent)
   {
      var _loc3_ = oEvent.row.item;
      if(_loc3_.isCurrent)
      {
         return undefined;
      }
      var _loc4_ = _loc3_.cost;
      if(this.api.datacenter.Player.Kama >= _loc4_)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_USE_WAYPOINT",[_loc3_.name,_loc3_.coordinates,_loc4_]),"CAUTION_YESNO",{name:"Waypoint",listener:this,params:{waypointID:_loc3_.id}});
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGH_RICH"),"ERROR_BOX");
      }
   }
   function yes(oEvent)
   {
      this.api.network.Waypoints.use(oEvent.target.params.waypointID);
   }
}
